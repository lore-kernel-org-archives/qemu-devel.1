Received: from eggs.gnu.org ([2001:4830:134:3::10]:57951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Christian_Ludwig@genua.de>) id 1fNXZq-0002jI-NG
	for qemu-devel@nongnu.org; Tue, 29 May 2018 01:53:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Christian_Ludwig@genua.de>) id 1fNXZm-0007GS-ON
	for qemu-devel@nongnu.org; Tue, 29 May 2018 01:53:46 -0400
Received: from gg-0.genua.de ([80.154.94.10]:1692 helo=gg.genua.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Christian_Ludwig@genua.de>)
	id 1fNXZm-0007EO-Hh
	for qemu-devel@nongnu.org; Tue, 29 May 2018 01:53:42 -0400
Received: from gg.genua.de (localhost [127.0.0.1])
	by gg.genua.de (Postfix) with ESMTP id D3BD679B882
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 07:53:30 +0200 (CEST)
From: Christian Ludwig <christian_ludwig@genua.de>
Date: Tue, 29 May 2018 07:53:12 +0200
Message-Id: <20180529055312.29633-1-christian_ludwig@genua.de>
Subject: [Qemu-devel] [PATCH] qemu: Emit RESET event with -no-reboot option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Christian Ludwig <christian_ludwig@genua.de>

When -no-reboot is given on the command line, qemu quits when the guest
finishes a system reboot operation. This is done by indicating that the
system should shut down, rather than reset. A user who observes QMP
events only sees a SHUTDOWN event and thus cannot distinguish whether
the guest initiated a shutdown or a reboot operation.

With -no-reboot set, set flags for system shutdown and system reset now.
The system shutdown path will continue to tear down and clean up the
guest to exit the application. But in the shutdown path, emit a REBOOT
event if the reboot flag is set.

Signed-off-by: Christian Ludwig <christian_ludwig@genua.de>
---
 vl.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/vl.c b/vl.c
index 038d7f8042..4057d3382c 100644
--- a/vl.c
+++ b/vl.c
@@ -1778,9 +1778,7 @@ void qemu_system_reset_request(ShutdownCause reason)
 {
     if (no_reboot) {
         shutdown_requested = reason;
-    } else {
-        reset_requested = reason;
-    }
+    reset_requested = reason;
     cpu_stop_current();
     qemu_notify_event();
 }
@@ -1885,7 +1883,9 @@ void qemu_system_debug_request(void)
 static bool main_loop_should_exit(void)
 {
     RunState r;
-    ShutdownCause request;
+    ShutdownCause shutdown_request;
+    ShutdownCause reset_request;
+    bool from_guest;
 
     if (qemu_debug_requested()) {
         vm_stop(RUN_STATE_DEBUG);
@@ -1893,21 +1893,27 @@ static bool main_loop_should_exit(void)
     if (qemu_suspend_requested()) {
         qemu_system_suspend();
     }
-    request = qemu_shutdown_requested();
-    if (request) {
+    shutdown_request = qemu_shutdown_requested();
+    if (shutdown_request) {
         qemu_kill_report();
-        qapi_event_send_shutdown(shutdown_caused_by_guest(request),
-                                 &error_abort);
+        reset_request = qemu_reset_requested();
+        if (reset_request) {
+            from_guest = shutdown_caused_by_guest(reset_request);
+            qapi_event_send_reset(from_guest, &error_abort);
+        } else {
+            from_guest = shutdown_caused_by_guest(shutdown_request);
+            qapi_event_send_shutdown(from_guest, &error_abort);
+        }
         if (no_shutdown) {
             vm_stop(RUN_STATE_SHUTDOWN);
         } else {
             return true;
         }
     }
-    request = qemu_reset_requested();
-    if (request) {
+    reset_request = qemu_reset_requested();
+    if (reset_request) {
         pause_all_vcpus();
-        qemu_system_reset(request);
+        qemu_system_reset(reset_request);
         resume_all_vcpus();
         if (!runstate_check(RUN_STATE_RUNNING) &&
                 !runstate_check(RUN_STATE_INMIGRATE)) {
-- 
2.17.0
