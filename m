Received: from eggs.gnu.org ([2001:4830:134:3::10]:52472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fDodH-0002Ju-G1
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fDodG-0008O2-Gc
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:05:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48974 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fDodG-0008Nj-4Z
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:05:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1E68A40704AD
	for <qemu-devel@nongnu.org>; Wed,  2 May 2018 10:05:05 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  2 May 2018 18:04:21 +0800
Message-Id: <20180502100422.8688-4-peterx@redhat.com>
In-Reply-To: <20180502100422.8688-1-peterx@redhat.com>
References: <20180502100422.8688-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v4 3/4] monitor: more comments on lock-free
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
 monitor.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/monitor.c b/monitor.c
index 9f361ec21e..6100ad44f8 100644
--- a/monitor.c
+++ b/monitor.c
@@ -207,6 +207,7 @@ struct Monitor {
     int suspend_cnt;            /* Needs to be accessed atomically */
     bool skip_flush;
     bool use_io_thr;
+    /* Only used in parser, so no lock needed. */
     ReadLineState *rs;
     MonitorQMP qmp;
     gchar *mon_cpu_path;
@@ -1316,7 +1317,7 @@ void qmp_qmp_capabilities(bool has_enable, QMPCapabilityList *enable,
     cur_mon->qmp.commands = &qmp_commands;
 }
 
-/* set the current CPU defined by the user */
+/* set the current CPU defined by the user.  BQL needed. */
 int monitor_set_cpu(int cpu_index)
 {
     CPUState *cpu;
@@ -1330,6 +1331,7 @@ int monitor_set_cpu(int cpu_index)
     return 0;
 }
 
+/* BQL neeeded. */
 static CPUState *mon_get_cpu_sync(bool synchronize)
 {
     CPUState *cpu;
-- 
2.14.3
