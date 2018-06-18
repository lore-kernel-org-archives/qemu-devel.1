Received: from eggs.gnu.org ([2001:4830:134:3::10]:37689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fUuq1-0000xs-H4
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:08:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fUuq0-0000SV-FB
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:08:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52934 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fUuq0-0000S7-AG
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:08:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC4A2400E9AF
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 14:08:55 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 18 Jun 2018 16:08:50 +0200
Message-Id: <20180618140854.17824-4-armbru@redhat.com>
In-Reply-To: <20180618140854.17824-1-armbru@redhat.com>
References: <20180618140854.17824-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 3/7] monitor: more comments on lock-free elements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

Add some explicit comments for both Readline and cpu_set/cpu_get helpers
that they do not need the mon_lock protection.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180608035511.7439-4-peterx@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/monitor.c b/monitor.c
index 0fba3ccc20..5c60bf08cc 100644
--- a/monitor.c
+++ b/monitor.c
@@ -206,7 +206,15 @@ struct Monitor {
     int suspend_cnt;            /* Needs to be accessed atomically */
     bool skip_flush;
     bool use_io_thr;
+
+    /*
+     * State used only in the thread "owning" the monitor.
+     * If @use_io_thr, this is mon_global.mon_iothread.
+     * Else, it's the main thread.
+     * These members can be safely accessed without locks.
+     */
     ReadLineState *rs;
+
     MonitorQMP qmp;
     gchar *mon_cpu_path;
     BlockCompletionFunc *password_completion_cb;
@@ -1311,7 +1319,7 @@ void qmp_qmp_capabilities(bool has_enable, QMPCapabilityList *enable,
     cur_mon->qmp.commands = &qmp_commands;
 }
 
-/* set the current CPU defined by the user */
+/* Set the current CPU defined by the user. Callers must hold BQL. */
 int monitor_set_cpu(int cpu_index)
 {
     CPUState *cpu;
@@ -1325,6 +1333,7 @@ int monitor_set_cpu(int cpu_index)
     return 0;
 }
 
+/* Callers must hold BQL. */
 static CPUState *mon_get_cpu_sync(bool synchronize)
 {
     CPUState *cpu;
-- 
2.17.1
