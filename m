Received: from eggs.gnu.org ([2001:4830:134:3::10]:51611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cwEel-0006FF-BM
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 17:09:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cwEeh-0001ZO-CM
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 17:09:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cwEeh-0001Z9-3u
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 17:09:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1E059B0811
	for <qemu-devel@nongnu.org>; Thu,  6 Apr 2017 21:09:22 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Thu,  6 Apr 2017 16:09:17 -0500
Message-Id: <20170406210917.6896-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH] event: Add signal information to SHUTDOWN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

qemu_kill_report() is already able to tell whether a shutdown
was triggered by guest action (no output) or by a host signal
(a message about termination is printed via error_report); but
this information is then lost.  Libvirt would like to be able
to distinguish between a SHUTDOWN event triggered solely by
guest request and one triggered by a SIGTERM on the host.

Enhance the SHUTDOWN event to pass the value of shutdown_signal
through to the monitor client, suitably remapped into a
platform-neutral string.  Note that mingw lacks decent signal
support, and will never report a signal because it never calls
qemu_system_killed().

See also https://bugzilla.redhat.com/1384007

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qapi/event.json | 20 +++++++++++++++++++-
 vl.c            | 21 ++++++++++++++++++---
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/qapi/event.json b/qapi/event.json
index e80f3f4..6aad475 100644
--- a/qapi/event.json
+++ b/qapi/event.json
@@ -5,11 +5,29 @@
 ##

 ##
+# @ShutdownSignal:
+#
+# The list of host signal types known to cause qemu to shut down a guest.
+#
+# @int: SIGINT
+# @hup: SIGHUP
+# @term: SIGTERM
+#
+# Since: 2.10
+##
+{ 'enum': 'ShutdownSignal', 'data': [ 'int', 'hup', 'term' ] }
+
+##
 # @SHUTDOWN:
 #
 # Emitted when the virtual machine has shut down, indicating that qemu is
 # about to exit.
 #
+# @signal: If present, the shutdown was (probably) triggered due to
+# the receipt of the given signal in the host, rather than by a guest
+# action (note that there is an inherent race with a guest choosing to
+# shut down near the same time the host sends a signal). (since 2.10)
+#
 # Note: If the command-line option "-no-shutdown" has been specified, qemu will
 # not exit, and a STOP event will eventually follow the SHUTDOWN event
 #
@@ -21,7 +39,7 @@
 #      "timestamp": { "seconds": 1267040730, "microseconds": 682951 } }
 #
 ##
-{ 'event': 'SHUTDOWN' }
+{ 'event': 'SHUTDOWN', 'data': { '*signal': 'ShutdownSignal' } }

 ##
 # @POWERDOWN:
diff --git a/vl.c b/vl.c
index 0b4ed52..af29b2c 100644
--- a/vl.c
+++ b/vl.c
@@ -1626,9 +1626,23 @@ static int qemu_shutdown_requested(void)
     return atomic_xchg(&shutdown_requested, 0);
 }

-static void qemu_kill_report(void)
+static ShutdownSignal qemu_kill_report(void)
 {
+    ShutdownSignal ss = SHUTDOWN_SIGNAL__MAX;
     if (!qtest_driver() && shutdown_signal != -1) {
+        switch (shutdown_signal) {
+        case SIGINT:
+            ss = SHUTDOWN_SIGNAL_INT;
+            break;
+#ifdef SIGHUP
+        case SIGHUP:
+            ss = SHUTDOWN_SIGNAL_HUP;
+            break;
+#endif
+        case SIGTERM:
+            ss = SHUTDOWN_SIGNAL_TERM;
+            break;
+        }
         if (shutdown_pid == 0) {
             /* This happens for eg ^C at the terminal, so it's worth
              * avoiding printing an odd message in that case.
@@ -1644,6 +1658,7 @@ static void qemu_kill_report(void)
         }
         shutdown_signal = -1;
     }
+    return ss;
 }

 static int qemu_reset_requested(void)
@@ -1852,8 +1867,8 @@ static bool main_loop_should_exit(void)
         qemu_system_suspend();
     }
     if (qemu_shutdown_requested()) {
-        qemu_kill_report();
-        qapi_event_send_shutdown(&error_abort);
+        ShutdownSignal ss = qemu_kill_report();
+        qapi_event_send_shutdown(ss < SHUTDOWN_SIGNAL__MAX, ss, &error_abort);
         if (no_shutdown) {
             vm_stop(RUN_STATE_SHUTDOWN);
         } else {
-- 
2.9.3
