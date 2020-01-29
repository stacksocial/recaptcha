# frozen_string_literal: true

module Recaptcha
  class Instrumentation
    CHANNEL = 'Recaptcha::API::Response'

    def self.report(payload = {})
      ActiveSupport::Notifications.instrument(CHANNEL, payload)
    end

    def self.subscribe(&block)
      ActiveSupport::Notifications.subscribe(CHANNEL) do |*args|
        event = ActiveSupport::Notifications::Event.new(*args)

        yield event if block_given?
      end
    end
  end
end
