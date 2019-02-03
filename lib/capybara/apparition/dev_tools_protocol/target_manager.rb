# frozen_string_literal: true

require 'capybara/apparition/dev_tools_protocol/target'

module Capybara::Apparition
  module DevToolsProtocol
    class TargetManager
      def initialize
        @targets = {}
      end

      def get(id)
        @targets[id]
      end
      
      def of_type(type)
        @targets.select { |_id, target| target.info['type'] == type }
      end

      def add(id, target)
        if @targets.key?(id)
          raise ArgumentError, "Target already exists"
        else
          @targets[id] = target
        end
      end

      def delete(id)
        @targets.delete(id)
      end

      def pages
        @targets.values.select { |target| target.info['type'] == 'page' }.map(&:page)
      end

      def target?(id)
        @targets.key?(id)
      end

      def window_handles
        @targets.values.select { |target| target.info['type'] == 'page' }.map(&:id).compact
      end
    end
  end
end
