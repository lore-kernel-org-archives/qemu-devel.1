Received: from eggs.gnu.org ([2001:4830:134:3::10]:42634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fLi2u-0003Wa-SV
	for qemu-devel@nongnu.org; Thu, 24 May 2018 00:40:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fLi2q-0008VH-0p
	for qemu-devel@nongnu.org; Thu, 24 May 2018 00:40:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33324 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fLi2p-0008V8-T3
	for qemu-devel@nongnu.org; Thu, 24 May 2018 00:40:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 80C92BB414
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 04:40:07 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Thu, 24 May 2018 12:39:51 +0800
Message-Id: <20180524043952.11245-4-peterx@redhat.com>
In-Reply-To: <20180524043952.11245-1-peterx@redhat.com>
References: <20180524043952.11245-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v7 3/4] monitor: more comments on lock-free
 fleids/funcs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Add some explicit comment for both Readline and cpu_set/cpu_get helpers
that they do not need the mon_lock protection.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/monitor.c b/monitor.c
index d6c3c08932..f01589f945 100644
--- a/monitor.c
+++ b/monitor.c
@@ -207,7 +207,16 @@ struct Monitor {
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
+    // other members that aren't shared
+
     MonitorQMP qmp;
     gchar *mon_cpu_path;
     BlockCompletionFunc *password_completion_cb;
@@ -1313,7 +1322,7 @@ void qmp_qmp_capabilities(bool has_enable, QMPCapabilityList *enable,
     cur_mon->qmp.commands = &qmp_commands;
 }
 
-/* set the current CPU defined by the user */
+/* Set the current CPU defined by the user. Callers must hold BQL. */
 int monitor_set_cpu(int cpu_index)
 {
     CPUState *cpu;
@@ -1327,6 +1336,7 @@ int monitor_set_cpu(int cpu_index)
     return 0;
 }
 
+/* Callers must hold BQL. */
 static CPUState *mon_get_cpu_sync(bool synchronize)
 {
     CPUState *cpu;
-- 
2.17.0
