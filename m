Received: from eggs.gnu.org ([2001:4830:134:3::10]:48908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkxa8-0006TH-8J
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:14:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkxa4-0004Ai-2I
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:14:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dkxa3-0004A7-OZ
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:14:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CD83681DF9
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 19:14:14 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 24 Aug 2017 21:13:57 +0200
Message-Id: <1503602048-12268-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1503602048-12268-1-git-send-email-armbru@redhat.com>
References: <1503602048-12268-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 05/16] qapi-schema: Collect run state stuff
 in qapi/run-state.json
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 MAINTAINERS         |   1 +
 Makefile            |   1 +
 qapi-schema.json    | 165 +-----------------------
 qapi/event.json     | 182 ---------------------------
 qapi/run-state.json | 352 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 355 insertions(+), 346 deletions(-)
 create mode 100644 qapi/run-state.json

diff --git a/MAINTAINERS b/MAINTAINERS
index fb90a19..289ea8c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1338,6 +1338,7 @@ F: cpus.c
 F: util/main-loop.c
 F: util/qemu-timer.c
 F: vl.c
+F: qapi/run-state.json
 
 Human Monitor (HMP)
 M: Dr. David Alan Gilbert <dgilbert@redhat.com>
diff --git a/Makefile b/Makefile
index ca4a03c..d3ba41a 100644
--- a/Makefile
+++ b/Makefile
@@ -413,6 +413,7 @@ qapi-modules = $(SRC_PATH)/qapi-schema.json $(SRC_PATH)/qapi/common.json \
                $(SRC_PATH)/qapi/crypto.json \
                $(SRC_PATH)/qapi/event.json $(SRC_PATH)/qapi/introspect.json \
                $(SRC_PATH)/qapi/rocker.json \
+               $(SRC_PATH)/qapi/run-state.json \
                $(SRC_PATH)/qapi/sockets.json \
                $(SRC_PATH)/qapi/trace.json
 
diff --git a/qapi-schema.json b/qapi-schema.json
index d69b6da..f42d61b 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -80,6 +80,7 @@
 
 { 'include': 'qapi/common.json' }
 { 'include': 'qapi/sockets.json' }
+{ 'include': 'qapi/run-state.json' }
 { 'include': 'qapi/crypto.json' }
 { 'include': 'qapi/block.json' }
 { 'include': 'qapi/rocker.json' }
@@ -243,94 +244,6 @@
 { 'command': 'query-kvm', 'returns': 'KvmInfo' }
 
 ##
-# @RunState:
-#
-# An enumeration of VM run states.
-#
-# @debug: QEMU is running on a debugger
-#
-# @finish-migrate: guest is paused to finish the migration process
-#
-# @inmigrate: guest is paused waiting for an incoming migration.  Note
-# that this state does not tell whether the machine will start at the
-# end of the migration.  This depends on the command-line -S option and
-# any invocation of 'stop' or 'cont' that has happened since QEMU was
-# started.
-#
-# @internal-error: An internal error that prevents further guest execution
-# has occurred
-#
-# @io-error: the last IOP has failed and the device is configured to pause
-# on I/O errors
-#
-# @paused: guest has been paused via the 'stop' command
-#
-# @postmigrate: guest is paused following a successful 'migrate'
-#
-# @prelaunch: QEMU was started with -S and guest has not started
-#
-# @restore-vm: guest is paused to restore VM state
-#
-# @running: guest is actively running
-#
-# @save-vm: guest is paused to save the VM state
-#
-# @shutdown: guest is shut down (and -no-shutdown is in use)
-#
-# @suspended: guest is suspended (ACPI S3)
-#
-# @watchdog: the watchdog action is configured to pause and has been triggered
-#
-# @guest-panicked: guest has been panicked as a result of guest OS panic
-#
-# @colo: guest is paused to save/restore VM state under colo checkpoint,
-#        VM can not get into this state unless colo capability is enabled
-#        for migration. (since 2.8)
-##
-{ 'enum': 'RunState',
-  'data': [ 'debug', 'inmigrate', 'internal-error', 'io-error', 'paused',
-            'postmigrate', 'prelaunch', 'finish-migrate', 'restore-vm',
-            'running', 'save-vm', 'shutdown', 'suspended', 'watchdog',
-            'guest-panicked', 'colo' ] }
-
-##
-# @StatusInfo:
-#
-# Information about VCPU run state
-#
-# @running: true if all VCPUs are runnable, false if not runnable
-#
-# @singlestep: true if VCPUs are in single-step mode
-#
-# @status: the virtual machine @RunState
-#
-# Since:  0.14.0
-#
-# Notes: @singlestep is enabled through the GDB stub
-##
-{ 'struct': 'StatusInfo',
-  'data': {'running': 'bool', 'singlestep': 'bool', 'status': 'RunState'} }
-
-##
-# @query-status:
-#
-# Query the run status of all VCPUs
-#
-# Returns: @StatusInfo reflecting all VCPUs
-#
-# Since:  0.14.0
-#
-# Example:
-#
-# -> { "execute": "query-status" }
-# <- { "return": { "running": true,
-#                  "singlestep": false,
-#                  "status": "running" } }
-#
-##
-{ 'command': 'query-status', 'returns': 'StatusInfo' }
-
-##
 # @UuidInfo:
 #
 # Guest UUID information (Universally Unique Identifier).
@@ -6017,34 +5930,6 @@
 { 'command': 'query-acpi-ospm-status', 'returns': ['ACPIOSTInfo'] }
 
 ##
-# @WatchdogExpirationAction:
-#
-# An enumeration of the actions taken when the watchdog device's timer is
-# expired
-#
-# @reset: system resets
-#
-# @shutdown: system shutdown, note that it is similar to @powerdown, which
-#            tries to set to system status and notify guest
-#
-# @poweroff: system poweroff, the emulator program exits
-#
-# @pause: system pauses, similar to @stop
-#
-# @debug: system enters debug state
-#
-# @none: nothing is done
-#
-# @inject-nmi: a non-maskable interrupt is injected into the first VCPU (all
-#              VCPUS on x86) (since 2.4)
-#
-# Since: 2.1
-##
-{ 'enum': 'WatchdogExpirationAction',
-  'data': [ 'reset', 'shutdown', 'poweroff', 'pause', 'debug', 'none',
-            'inject-nmi' ] }
-
-##
 # @IoOperationType:
 #
 # An enumeration of the I/O operation types
@@ -6059,54 +5944,6 @@
   'data': [ 'read', 'write' ] }
 
 ##
-# @GuestPanicAction:
-#
-# An enumeration of the actions taken when guest OS panic is detected
-#
-# @pause: system pauses
-#
-# Since: 2.1 (poweroff since 2.8)
-##
-{ 'enum': 'GuestPanicAction',
-  'data': [ 'pause', 'poweroff' ] }
-
-##
-# @GuestPanicInformationType:
-#
-# An enumeration of the guest panic information types
-#
-# Since: 2.9
-##
-{ 'enum': 'GuestPanicInformationType',
-  'data': [ 'hyper-v'] }
-
-##
-# @GuestPanicInformation:
-#
-# Information about a guest panic
-#
-# Since: 2.9
-##
-{'union': 'GuestPanicInformation',
- 'base': {'type': 'GuestPanicInformationType'},
- 'discriminator': 'type',
- 'data': { 'hyper-v': 'GuestPanicInformationHyperV' } }
-
-##
-# @GuestPanicInformationHyperV:
-#
-# Hyper-V specific guest panic information (HV crash MSRs)
-#
-# Since: 2.9
-##
-{'struct': 'GuestPanicInformationHyperV',
- 'data': { 'arg1': 'uint64',
-           'arg2': 'uint64',
-           'arg3': 'uint64',
-           'arg4': 'uint64',
-           'arg5': 'uint64' } }
-
-##
 # @rtc-reset-reinjection:
 #
 # This command will reset the RTC interrupt reinjection backlog.
diff --git a/qapi/event.json b/qapi/event.json
index 6d22b02..9c6126d 100644
--- a/qapi/event.json
+++ b/qapi/event.json
@@ -5,144 +5,6 @@
 ##
 
 ##
-# @SHUTDOWN:
-#
-# Emitted when the virtual machine has shut down, indicating that qemu is
-# about to exit.
-#
-# @guest: If true, the shutdown was triggered by a guest request (such as
-# a guest-initiated ACPI shutdown request or other hardware-specific action)
-# rather than a host request (such as sending qemu a SIGINT). (since 2.10)
-#
-# Note: If the command-line option "-no-shutdown" has been specified, qemu will
-# not exit, and a STOP event will eventually follow the SHUTDOWN event
-#
-# Since: 0.12.0
-#
-# Example:
-#
-# <- { "event": "SHUTDOWN", "data": { "guest": true },
-#      "timestamp": { "seconds": 1267040730, "microseconds": 682951 } }
-#
-##
-{ 'event': 'SHUTDOWN', 'data': { 'guest': 'bool' } }
-
-##
-# @POWERDOWN:
-#
-# Emitted when the virtual machine is powered down through the power control
-# system, such as via ACPI.
-#
-# Since: 0.12.0
-#
-# Example:
-#
-# <- { "event": "POWERDOWN",
-#      "timestamp": { "seconds": 1267040730, "microseconds": 682951 } }
-#
-##
-{ 'event': 'POWERDOWN' }
-
-##
-# @RESET:
-#
-# Emitted when the virtual machine is reset
-#
-# @guest: If true, the reset was triggered by a guest request (such as
-# a guest-initiated ACPI reboot request or other hardware-specific action)
-# rather than a host request (such as the QMP command system_reset).
-# (since 2.10)
-#
-# Since: 0.12.0
-#
-# Example:
-#
-# <- { "event": "RESET", "data": { "guest": false },
-#      "timestamp": { "seconds": 1267041653, "microseconds": 9518 } }
-#
-##
-{ 'event': 'RESET', 'data': { 'guest': 'bool' } }
-
-##
-# @STOP:
-#
-# Emitted when the virtual machine is stopped
-#
-# Since: 0.12.0
-#
-# Example:
-#
-# <- { "event": "STOP",
-#      "timestamp": { "seconds": 1267041730, "microseconds": 281295 } }
-#
-##
-{ 'event': 'STOP' }
-
-##
-# @RESUME:
-#
-# Emitted when the virtual machine resumes execution
-#
-# Since: 0.12.0
-#
-# Example:
-#
-# <- { "event": "RESUME",
-#      "timestamp": { "seconds": 1271770767, "microseconds": 582542 } }
-#
-##
-{ 'event': 'RESUME' }
-
-##
-# @SUSPEND:
-#
-# Emitted when guest enters a hardware suspension state, for example, S3 state,
-# which is sometimes called standby state
-#
-# Since: 1.1
-#
-# Example:
-#
-# <- { "event": "SUSPEND",
-#      "timestamp": { "seconds": 1344456160, "microseconds": 309119 } }
-#
-##
-{ 'event': 'SUSPEND' }
-
-##
-# @SUSPEND_DISK:
-#
-# Emitted when guest enters a hardware suspension state with data saved on
-# disk, for example, S4 state, which is sometimes called hibernate state
-#
-# Note: QEMU shuts down (similar to event @SHUTDOWN) when entering this state
-#
-# Since: 1.2
-#
-# Example:
-#
-# <-   { "event": "SUSPEND_DISK",
-#        "timestamp": { "seconds": 1344456160, "microseconds": 309119 } }
-#
-##
-{ 'event': 'SUSPEND_DISK' }
-
-##
-# @WAKEUP:
-#
-# Emitted when the guest has woken up from suspend state and is running
-#
-# Since: 1.1
-#
-# Example:
-#
-# <- { "event": "WAKEUP",
-#      "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
-#
-##
-{ 'event': 'WAKEUP' }
-
-##
 # @RTC_CHANGE:
 #
 # Emitted when the guest changes the RTC time.
@@ -165,30 +27,6 @@
   'data': { 'offset': 'int' } }
 
 ##
-# @WATCHDOG:
-#
-# Emitted when the watchdog device's timer is expired
-#
-# @action: action that has been taken
-#
-# Note: If action is "reset", "shutdown", or "pause" the WATCHDOG event is
-# followed respectively by the RESET, SHUTDOWN, or STOP events
-#
-# Note: This event is rate-limited.
-#
-# Since: 0.13.0
-#
-# Example:
-#
-# <- { "event": "WATCHDOG",
-#      "data": { "action": "reset" },
-#      "timestamp": { "seconds": 1267061043, "microseconds": 959568 } }
-#
-##
-{ 'event': 'WATCHDOG',
-  'data': { 'action': 'WatchdogExpirationAction' } }
-
-##
 # @DEVICE_DELETED:
 #
 # Emitted whenever the device removal completion is acknowledged by the guest.
@@ -491,26 +329,6 @@
   'data': { 'actual': 'int' } }
 
 ##
-# @GUEST_PANICKED:
-#
-# Emitted when guest OS panic is detected
-#
-# @action: action that has been taken, currently always "pause"
-#
-# @info: information about a panic (since 2.9)
-#
-# Since: 1.5
-#
-# Example:
-#
-# <- { "event": "GUEST_PANICKED",
-#      "data": { "action": "pause" } }
-#
-##
-{ 'event': 'GUEST_PANICKED',
-  'data': { 'action': 'GuestPanicAction', '*info': 'GuestPanicInformation' } }
-
-##
 # @QUORUM_FAILURE:
 #
 # Emitted by the Quorum block driver if it fails to establish a quorum
diff --git a/qapi/run-state.json b/qapi/run-state.json
new file mode 100644
index 0000000..d36ff49
--- /dev/null
+++ b/qapi/run-state.json
@@ -0,0 +1,352 @@
+# -*- Mode: Python -*-
+#
+
+##
+# = VM run state
+##
+
+##
+# @RunState:
+#
+# An enumeration of VM run states.
+#
+# @debug: QEMU is running on a debugger
+#
+# @finish-migrate: guest is paused to finish the migration process
+#
+# @inmigrate: guest is paused waiting for an incoming migration.  Note
+# that this state does not tell whether the machine will start at the
+# end of the migration.  This depends on the command-line -S option and
+# any invocation of 'stop' or 'cont' that has happened since QEMU was
+# started.
+#
+# @internal-error: An internal error that prevents further guest execution
+# has occurred
+#
+# @io-error: the last IOP has failed and the device is configured to pause
+# on I/O errors
+#
+# @paused: guest has been paused via the 'stop' command
+#
+# @postmigrate: guest is paused following a successful 'migrate'
+#
+# @prelaunch: QEMU was started with -S and guest has not started
+#
+# @restore-vm: guest is paused to restore VM state
+#
+# @running: guest is actively running
+#
+# @save-vm: guest is paused to save the VM state
+#
+# @shutdown: guest is shut down (and -no-shutdown is in use)
+#
+# @suspended: guest is suspended (ACPI S3)
+#
+# @watchdog: the watchdog action is configured to pause and has been triggered
+#
+# @guest-panicked: guest has been panicked as a result of guest OS panic
+#
+# @colo: guest is paused to save/restore VM state under colo checkpoint,
+#        VM can not get into this state unless colo capability is enabled
+#        for migration. (since 2.8)
+##
+{ 'enum': 'RunState',
+  'data': [ 'debug', 'inmigrate', 'internal-error', 'io-error', 'paused',
+            'postmigrate', 'prelaunch', 'finish-migrate', 'restore-vm',
+            'running', 'save-vm', 'shutdown', 'suspended', 'watchdog',
+            'guest-panicked', 'colo' ] }
+
+##
+# @StatusInfo:
+#
+# Information about VCPU run state
+#
+# @running: true if all VCPUs are runnable, false if not runnable
+#
+# @singlestep: true if VCPUs are in single-step mode
+#
+# @status: the virtual machine @RunState
+#
+# Since:  0.14.0
+#
+# Notes: @singlestep is enabled through the GDB stub
+##
+{ 'struct': 'StatusInfo',
+  'data': {'running': 'bool', 'singlestep': 'bool', 'status': 'RunState'} }
+
+##
+# @query-status:
+#
+# Query the run status of all VCPUs
+#
+# Returns: @StatusInfo reflecting all VCPUs
+#
+# Since:  0.14.0
+#
+# Example:
+#
+# -> { "execute": "query-status" }
+# <- { "return": { "running": true,
+#                  "singlestep": false,
+#                  "status": "running" } }
+#
+##
+{ 'command': 'query-status', 'returns': 'StatusInfo' }
+
+##
+# @SHUTDOWN:
+#
+# Emitted when the virtual machine has shut down, indicating that qemu is
+# about to exit.
+#
+# @guest: If true, the shutdown was triggered by a guest request (such as
+# a guest-initiated ACPI shutdown request or other hardware-specific action)
+# rather than a host request (such as sending qemu a SIGINT). (since 2.10)
+#
+# Note: If the command-line option "-no-shutdown" has been specified, qemu will
+# not exit, and a STOP event will eventually follow the SHUTDOWN event
+#
+# Since: 0.12.0
+#
+# Example:
+#
+# <- { "event": "SHUTDOWN", "data": { "guest": true },
+#      "timestamp": { "seconds": 1267040730, "microseconds": 682951 } }
+#
+##
+{ 'event': 'SHUTDOWN', 'data': { 'guest': 'bool' } }
+
+##
+# @POWERDOWN:
+#
+# Emitted when the virtual machine is powered down through the power control
+# system, such as via ACPI.
+#
+# Since: 0.12.0
+#
+# Example:
+#
+# <- { "event": "POWERDOWN",
+#      "timestamp": { "seconds": 1267040730, "microseconds": 682951 } }
+#
+##
+{ 'event': 'POWERDOWN' }
+
+##
+# @RESET:
+#
+# Emitted when the virtual machine is reset
+#
+# @guest: If true, the reset was triggered by a guest request (such as
+# a guest-initiated ACPI reboot request or other hardware-specific action)
+# rather than a host request (such as the QMP command system_reset).
+# (since 2.10)
+#
+# Since: 0.12.0
+#
+# Example:
+#
+# <- { "event": "RESET", "data": { "guest": false },
+#      "timestamp": { "seconds": 1267041653, "microseconds": 9518 } }
+#
+##
+{ 'event': 'RESET', 'data': { 'guest': 'bool' } }
+
+##
+# @STOP:
+#
+# Emitted when the virtual machine is stopped
+#
+# Since: 0.12.0
+#
+# Example:
+#
+# <- { "event": "STOP",
+#      "timestamp": { "seconds": 1267041730, "microseconds": 281295 } }
+#
+##
+{ 'event': 'STOP' }
+
+##
+# @RESUME:
+#
+# Emitted when the virtual machine resumes execution
+#
+# Since: 0.12.0
+#
+# Example:
+#
+# <- { "event": "RESUME",
+#      "timestamp": { "seconds": 1271770767, "microseconds": 582542 } }
+#
+##
+{ 'event': 'RESUME' }
+
+##
+# @SUSPEND:
+#
+# Emitted when guest enters a hardware suspension state, for example, S3 state,
+# which is sometimes called standby state
+#
+# Since: 1.1
+#
+# Example:
+#
+# <- { "event": "SUSPEND",
+#      "timestamp": { "seconds": 1344456160, "microseconds": 309119 } }
+#
+##
+{ 'event': 'SUSPEND' }
+
+##
+# @SUSPEND_DISK:
+#
+# Emitted when guest enters a hardware suspension state with data saved on
+# disk, for example, S4 state, which is sometimes called hibernate state
+#
+# Note: QEMU shuts down (similar to event @SHUTDOWN) when entering this state
+#
+# Since: 1.2
+#
+# Example:
+#
+# <-   { "event": "SUSPEND_DISK",
+#        "timestamp": { "seconds": 1344456160, "microseconds": 309119 } }
+#
+##
+{ 'event': 'SUSPEND_DISK' }
+
+##
+# @WAKEUP:
+#
+# Emitted when the guest has woken up from suspend state and is running
+#
+# Since: 1.1
+#
+# Example:
+#
+# <- { "event": "WAKEUP",
+#      "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
+#
+##
+{ 'event': 'WAKEUP' }
+
+##
+# @WATCHDOG:
+#
+# Emitted when the watchdog device's timer is expired
+#
+# @action: action that has been taken
+#
+# Note: If action is "reset", "shutdown", or "pause" the WATCHDOG event is
+# followed respectively by the RESET, SHUTDOWN, or STOP events
+#
+# Note: This event is rate-limited.
+#
+# Since: 0.13.0
+#
+# Example:
+#
+# <- { "event": "WATCHDOG",
+#      "data": { "action": "reset" },
+#      "timestamp": { "seconds": 1267061043, "microseconds": 959568 } }
+#
+##
+{ 'event': 'WATCHDOG',
+  'data': { 'action': 'WatchdogExpirationAction' } }
+
+##
+# @WatchdogExpirationAction:
+#
+# An enumeration of the actions taken when the watchdog device's timer is
+# expired
+#
+# @reset: system resets
+#
+# @shutdown: system shutdown, note that it is similar to @powerdown, which
+#            tries to set to system status and notify guest
+#
+# @poweroff: system poweroff, the emulator program exits
+#
+# @pause: system pauses, similar to @stop
+#
+# @debug: system enters debug state
+#
+# @none: nothing is done
+#
+# @inject-nmi: a non-maskable interrupt is injected into the first VCPU (all
+#              VCPUS on x86) (since 2.4)
+#
+# Since: 2.1
+##
+{ 'enum': 'WatchdogExpirationAction',
+  'data': [ 'reset', 'shutdown', 'poweroff', 'pause', 'debug', 'none',
+            'inject-nmi' ] }
+
+##
+# @GUEST_PANICKED:
+#
+# Emitted when guest OS panic is detected
+#
+# @action: action that has been taken, currently always "pause"
+#
+# @info: information about a panic (since 2.9)
+#
+# Since: 1.5
+#
+# Example:
+#
+# <- { "event": "GUEST_PANICKED",
+#      "data": { "action": "pause" } }
+#
+##
+{ 'event': 'GUEST_PANICKED',
+  'data': { 'action': 'GuestPanicAction', '*info': 'GuestPanicInformation' } }
+
+##
+# @GuestPanicAction:
+#
+# An enumeration of the actions taken when guest OS panic is detected
+#
+# @pause: system pauses
+#
+# Since: 2.1 (poweroff since 2.8)
+##
+{ 'enum': 'GuestPanicAction',
+  'data': [ 'pause', 'poweroff' ] }
+
+##
+# @GuestPanicInformationType:
+#
+# An enumeration of the guest panic information types
+#
+# Since: 2.9
+##
+{ 'enum': 'GuestPanicInformationType',
+  'data': [ 'hyper-v'] }
+
+##
+# @GuestPanicInformation:
+#
+# Information about a guest panic
+#
+# Since: 2.9
+##
+{'union': 'GuestPanicInformation',
+ 'base': {'type': 'GuestPanicInformationType'},
+ 'discriminator': 'type',
+ 'data': { 'hyper-v': 'GuestPanicInformationHyperV' } }
+
+##
+# @GuestPanicInformationHyperV:
+#
+# Hyper-V specific guest panic information (HV crash MSRs)
+#
+# Since: 2.9
+##
+{'struct': 'GuestPanicInformationHyperV',
+ 'data': { 'arg1': 'uint64',
+           'arg2': 'uint64',
+           'arg3': 'uint64',
+           'arg4': 'uint64',
+           'arg5': 'uint64' } }
-- 
2.7.5
