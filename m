Received: from eggs.gnu.org ([2001:4830:134:3::10]:55901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZCJx-00060S-I0
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:09:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZCJu-00086R-QF
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:09:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gZCJu-0007yJ-F9
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:09:46 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 18 Dec 2018 11:09:35 +0100
Message-Id: <20181218100941.25267-2-armbru@redhat.com>
In-Reply-To: <20181218100941.25267-1-armbru@redhat.com>
References: <20181218100941.25267-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 1/7] qapi: Turn ShutdownCause into QAPI enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Dominik Csapak <d.csapak@proxmox.com>

From: Dominik Csapak <d.csapak@proxmox.com>

Needed so the patch after next can add ShutdownCause to QMP events
SHUTDOWN and RESET.

Signed-off-by: Dominik Csapak <d.csapak@proxmox.com>
Message-Id: <20181205110131.23049-2-d.csapak@proxmox.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/sysemu/sysemu.h | 20 --------------------
 qapi/run-state.json     | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 8d6095d98b..f83522c7e7 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -31,26 +31,6 @@ VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
 void qemu_del_vm_change_state_handler(VMChangeStateEntry *e);
 void vm_state_notify(int running, RunState state);
 
-/* Enumeration of various causes for shutdown. */
-typedef enum ShutdownCause {
-    SHUTDOWN_CAUSE_NONE,          /* No shutdown request pending */
-    SHUTDOWN_CAUSE_HOST_ERROR,    /* An error prevents further use of guest */
-    SHUTDOWN_CAUSE_HOST_QMP,      /* Reaction to a QMP command, like 'quit' */
-    SHUTDOWN_CAUSE_HOST_SIGNAL,   /* Reaction to a signal, such as SIGINT */
-    SHUTDOWN_CAUSE_HOST_UI,       /* Reaction to UI event, like window close */
-    SHUTDOWN_CAUSE_GUEST_SHUTDOWN,/* Guest shutdown/suspend request, via
-                                     ACPI or other hardware-specific means */
-    SHUTDOWN_CAUSE_GUEST_RESET,   /* Guest reset request, and command line
-                                     turns that into a shutdown */
-    SHUTDOWN_CAUSE_GUEST_PANIC,   /* Guest panicked, and command line turns
-                                     that into a shutdown */
-    SHUTDOWN_CAUSE_SUBSYSTEM_RESET,/* Partial guest reset that does not trigger
-                                      QMP events and ignores --no-reboot. This
-                                      is useful for sanitize hypercalls on s390
-                                      that are used during kexec/kdump/boot */
-    SHUTDOWN_CAUSE__MAX,
-} ShutdownCause;
-
 static inline bool shutdown_caused_by_guest(ShutdownCause cause)
 {
     return cause >= SHUTDOWN_CAUSE_GUEST_SHUTDOWN;
diff --git a/qapi/run-state.json b/qapi/run-state.json
index 332e44897b..de7725bf09 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -59,6 +59,40 @@
             'running', 'save-vm', 'shutdown', 'suspended', 'watchdog',
             'guest-panicked', 'colo', 'preconfig' ] }
 
+##
+# @ShutdownCause:
+#
+# An enumeration of reasons for a Shutdown.
+#
+# @none: No shutdown request pending
+#
+# @host-error: An error prevents further use of guest
+#
+# @host-qmp: Reaction to a QMP command, like 'quit'
+#
+# @host-signal: Reaction to a signal, such as SIGINT
+#
+# @host-ui: Reaction to a UI event, like window close
+#
+# @guest-shutdown: Guest shutdown/suspend request, via ACPI or other
+#                  hardware-specific means
+#
+# @guest-reset: Guest reset request, and command line turns that into
+#               a shutdown
+#
+# @guest-panic: Guest panicked, and command line turns that into a shutdown
+#
+# @subsystem-reset: Partial guest reset that does not trigger QMP events and
+#                  ignores --no-reboot. This is useful for sanitizing
+#                  hypercalls on s390 that are used during kexec/kdump/boot
+#
+##
+{ 'enum': 'ShutdownCause',
+  # Beware, shutdown_caused_by_guest() depends on enumeration order
+  'data': [ 'none', 'host-error', 'host-qmp', 'host-signal', 'host-ui',
+            'guest-shutdown', 'guest-reset', 'guest-panic',
+            'subsystem-reset'] }
+
 ##
 # @StatusInfo:
 #
-- 
2.17.2
