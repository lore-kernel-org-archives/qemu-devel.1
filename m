Received: from eggs.gnu.org ([2001:4830:134:3::10]:59152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dcsapak@zita.proxmox.com>) id 1g9VRf-000863-0L
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 09:19:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dcsapak@zita.proxmox.com>) id 1g9VRb-00032B-Kq
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 09:19:34 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:44252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dcsapak@zita.proxmox.com>)
	id 1g9VRb-0002td-AU
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 09:19:31 -0400
From: Dominik Csapak <d.csapak@proxmox.com>
Date: Mon,  8 Oct 2018 15:19:24 +0200
Message-Id: <20181008131924.7377-1-d.csapak@proxmox.com>
Subject: [Qemu-devel] [PATCH] qapi: add info about reset to SHUTDOWN event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, berrange@redhat.com

when '-no-reboot' is set, it is interesting if the guest was originally
shutdown or reset, so save and return that info

Signed-off-by: Dominik Csapak <d.csapak@proxmox.com>
---
 qapi/run-state.json | 5 ++++-
 vl.c                | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/qapi/run-state.json b/qapi/run-state.json
index 332e44897b..ec1769777d 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -107,6 +107,9 @@
 # a guest-initiated ACPI shutdown request or other hardware-specific action)
 # rather than a host request (such as sending qemu a SIGINT). (since 2.10)
 #
+# @was_reset: If true, the shutdown was actually a reset, but no-reboot
+# was set, so it got converted to a shutdown
+#
 # Note: If the command-line option "-no-shutdown" has been specified, qemu will
 # not exit, and a STOP event will eventually follow the SHUTDOWN event
 #
@@ -118,7 +121,7 @@
 #      "timestamp": { "seconds": 1267040730, "microseconds": 682951 } }
 #
 ##
-{ 'event': 'SHUTDOWN', 'data': { 'guest': 'bool' } }
+{ 'event': 'SHUTDOWN', 'data': { 'guest': 'bool', 'was_reset': 'bool' } }
 
 ##
 # @POWERDOWN:
diff --git a/vl.c b/vl.c
index 4e25c78bff..66e29cb830 100644
--- a/vl.c
+++ b/vl.c
@@ -1524,6 +1524,7 @@ void vm_state_notify(int running, RunState state)
 
 static ShutdownCause reset_requested;
 static ShutdownCause shutdown_requested;
+static bool shutdown_was_reset;
 static int shutdown_signal;
 static pid_t shutdown_pid;
 static int powerdown_requested;
@@ -1681,6 +1682,7 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
 void qemu_system_reset_request(ShutdownCause reason)
 {
     if (no_reboot && reason != SHUTDOWN_CAUSE_SUBSYSTEM_RESET) {
+        shutdown_was_reset = true;
         shutdown_requested = reason;
     } else {
         reset_requested = reason;
@@ -1807,7 +1809,8 @@ static bool main_loop_should_exit(void)
     request = qemu_shutdown_requested();
     if (request) {
         qemu_kill_report();
-        qapi_event_send_shutdown(shutdown_caused_by_guest(request));
+        qapi_event_send_shutdown(shutdown_caused_by_guest(request),
+                                 shutdown_was_reset);
         if (no_shutdown) {
             vm_stop(RUN_STATE_SHUTDOWN);
         } else {
-- 
2.11.0
