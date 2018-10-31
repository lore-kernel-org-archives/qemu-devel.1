Received: from eggs.gnu.org ([2001:4830:134:3::10]:40541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dcsapak@zita.proxmox.com>) id 1gHp3I-0004Xh-Qy
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:52:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dcsapak@zita.proxmox.com>) id 1gHp3F-00042U-MX
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:52:48 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:11378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dcsapak@zita.proxmox.com>)
	id 1gHp3F-00040Z-6f
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:52:45 -0400
From: Dominik Csapak <d.csapak@proxmox.com>
Date: Wed, 31 Oct 2018 12:52:40 +0100
Message-Id: <20181031115242.6558-2-d.csapak@proxmox.com>
In-Reply-To: <20181031115242.6558-1-d.csapak@proxmox.com>
References: <20181031115242.6558-1-d.csapak@proxmox.com>
Subject: [Qemu-devel] [PATCH 1/3] qapi: move ShutdownCause to
 qapi/run-state.json
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com

this makes it possible to use the reason as return value
in a QMP event, such as SHUTDOWN

Signed-off-by: Dominik Csapak <d.csapak@proxmox.com>
---
 include/sysemu/sysemu.h | 20 --------------------
 qapi/run-state.json     | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 20 deletions(-)

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
index 332e44897b..883bed167c 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -60,6 +60,39 @@
             'guest-panicked', 'colo', 'preconfig' ] }
 
 ##
+# @ShutdownCause:
+#
+# An enumeration of reasons for a Shutdown.
+#
+# @none: No shutdown request pending
+#
+# @host-error: An error prevented further use of guest
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
+  'data': [ 'none', 'host-error', 'host-qmp', 'host-signal', 'host-ui',
+            'guest-shutdown', 'guest-reset', 'guest-panic',
+            'subsystem-reset'] }
+
+##
 # @StatusInfo:
 #
 # Information about VCPU run state
-- 
2.11.0
