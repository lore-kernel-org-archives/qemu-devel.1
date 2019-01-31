Received: from eggs.gnu.org ([209.51.188.92]:48178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gpC5l-0007Gz-Vd
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:09:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gpC5k-0000Ko-61
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:09:17 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gpC5j-0000KR-U2
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:09:16 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Thu, 31 Jan 2019 15:08:47 +0200
Message-Id: <20190131130850.6850-8-yuval.shaia@oracle.com>
In-Reply-To: <20190131130850.6850-1-yuval.shaia@oracle.com>
References: <20190131130850.6850-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH 07/10] monitor: Expose pvrdma device statistics
 counters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, armbru@redhat.com, qemu-devel@nongnu.org

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hmp-commands-info.hx | 14 ++++++++++++++
 monitor.c            |  6 ++++++
 2 files changed, 20 insertions(+)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index cbee8b944d..32f6215619 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -522,6 +522,20 @@ STEXI
 @item info cpustats
 @findex info cpustats
 Show CPU statistics.
+ETEXI
+
+    {
+        .name       = "pvrdmastats",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show pvrdma device statistics",
+        .cmd        = hmp_info_pvrdmastats,
+    },
+
+STEXI
+@item info pvrdmastats
+@findex info pvrdmastats
+Show pvrdma device statistics.
 ETEXI
 
 #if defined(CONFIG_SLIRP)
diff --git a/monitor.c b/monitor.c
index eb39fb015b..7a96c02438 100644
--- a/monitor.c
+++ b/monitor.c
@@ -84,6 +84,7 @@
 #include "sysemu/iothread.h"
 #include "qemu/cutils.h"
 #include "tcg/tcg.h"
+#include "hw/rdma/vmw/pvrdma.h"
 
 #if defined(TARGET_S390X)
 #include "hw/s390x/storage-keys.h"
@@ -1399,6 +1400,11 @@ static void hmp_info_cpustats(Monitor *mon, const QDict *qdict)
     cpu_dump_statistics(cs, (FILE *)mon, &monitor_fprintf, 0);
 }
 
+static void hmp_info_pvrdmastats(Monitor *mon, const QDict *qdict)
+{
+    pvrdma_dump_statistics((FILE *)mon, &monitor_fprintf);
+}
+
 static void hmp_info_trace_events(Monitor *mon, const QDict *qdict)
 {
     const char *name = qdict_get_try_str(qdict, "name");
-- 
2.17.2
