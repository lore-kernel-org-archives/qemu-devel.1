Received: from eggs.gnu.org ([2001:4830:134:3::10]:38739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dD8xZ-0005kv-5L
	for qemu-devel@nongnu.org; Tue, 23 May 2017 08:30:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dD8xW-00013y-Oi
	for qemu-devel@nongnu.org; Tue, 23 May 2017 08:30:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dD8xW-00013A-JD
	for qemu-devel@nongnu.org; Tue, 23 May 2017 08:30:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A1FFC61980
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 12:30:40 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 23 May 2017 14:30:32 +0200
Message-Id: <1495542638-12335-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1495542638-12335-1-git-send-email-armbru@redhat.com>
References: <1495542638-12335-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 3/9] shutdown: Simplify shutdown_signal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

There is no signal 0 (kill(pid, 0) has special semantics to probe whether
a process is alive), rather than actually sending a signal 0).  So we
can use the simpler 0, instead of -1, for our sentinel of whether a
shutdown request due to a signal has happened.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-Id: <20170515214114.15442-2-eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 vl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/vl.c b/vl.c
index 1512df6..b42b0b3 100644
--- a/vl.c
+++ b/vl.c
@@ -1598,7 +1598,7 @@ void vm_state_notify(int running, RunState state)
 }
 
 static int reset_requested;
-static int shutdown_requested, shutdown_signal = -1;
+static int shutdown_requested, shutdown_signal;
 static pid_t shutdown_pid;
 static int powerdown_requested;
 static int debug_requested;
@@ -1629,7 +1629,7 @@ static int qemu_shutdown_requested(void)
 
 static void qemu_kill_report(void)
 {
-    if (!qtest_driver() && shutdown_signal != -1) {
+    if (!qtest_driver() && shutdown_signal) {
         if (shutdown_pid == 0) {
             /* This happens for eg ^C at the terminal, so it's worth
              * avoiding printing an odd message in that case.
@@ -1643,7 +1643,7 @@ static void qemu_kill_report(void)
                          shutdown_cmd ? shutdown_cmd : "<unknown process>");
             g_free(shutdown_cmd);
         }
-        shutdown_signal = -1;
+        shutdown_signal = 0;
     }
 }
 
-- 
2.7.4
