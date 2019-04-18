Received: from eggs.gnu.org ([209.51.188.92]:54744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0d-0005CS-4G
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0V-0005HI-Jo
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hHE0V-0005Df-2K
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 21F0EC04B94F
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:51:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BB69660857
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:51:40 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 18 Apr 2019 22:51:24 +0200
Message-Id: <20190418205135.6686-26-armbru@redhat.com>
In-Reply-To: <20190418205135.6686-1-armbru@redhat.com>
References: <20190418205135.6686-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL for-4.1 25/36] qsp: Simplify how qsp_report()
 prints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

qsp_report() takes an fprintf()-like callback and a FILE * to pass to
it.

Its only caller hmp_sync_profile() passes monitor_fprintf() and the
current monitor cast to FILE *.  monitor_fprintf() casts it right
back, and is otherwise identical to monitor_printf().  The
type-punning is ugly.

Drop the callback, and call qemu_printf() instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190417191805.28198-7-armbru@redhat.com>
---
 include/block/qapi.h |  1 +
 include/qemu/qsp.h   |  6 ++----
 monitor.c            |  2 +-
 util/qsp.c           | 21 +++++++++++----------
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/block/qapi.h b/include/block/qapi.h
index 83bdb098bd..a891f43b9c 100644
--- a/include/block/qapi.h
+++ b/include/block/qapi.h
@@ -27,6 +27,7 @@
 
 #include "block/block.h"
 #include "block/snapshot.h"
+#include "qemu/fprintf-fn.h"
 
 BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
                                         BlockDriverState *bs, Error **errp);
diff --git a/include/qemu/qsp.h b/include/qemu/qsp.h
index a94c464f90..bf36aabfa8 100644
--- a/include/qemu/qsp.h
+++ b/include/qemu/qsp.h
@@ -11,15 +11,13 @@
 #ifndef QEMU_QSP_H
 #define QEMU_QSP_H
 
-#include "qemu/fprintf-fn.h"
-
 enum QSPSortBy {
     QSP_SORT_BY_TOTAL_WAIT_TIME,
     QSP_SORT_BY_AVG_WAIT_TIME,
 };
 
-void qsp_report(FILE *f, fprintf_function cpu_fprintf, size_t max,
-                enum QSPSortBy sort_by, bool callsite_coalesce);
+void qsp_report(size_t max, enum QSPSortBy sort_by,
+                bool callsite_coalesce);
 
 bool qsp_is_enabled(void);
 void qsp_enable(void);
diff --git a/monitor.c b/monitor.c
index 7573689585..1650ceec3a 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1336,7 +1336,7 @@ static void hmp_info_sync_profile(Monitor *mon, const QDict *qdict)
     enum QSPSortBy sort_by;
 
     sort_by = mean ? QSP_SORT_BY_AVG_WAIT_TIME : QSP_SORT_BY_TOTAL_WAIT_TIME;
-    qsp_report((FILE *)mon, monitor_fprintf, max, sort_by, coalesce);
+    qsp_report(max, sort_by, coalesce);
 }
 
 static void hmp_info_history(Monitor *mon, const QDict *qdict)
diff --git a/util/qsp.c b/util/qsp.c
index 410f1ba004..5264c97342 100644
--- a/util/qsp.c
+++ b/util/qsp.c
@@ -56,7 +56,9 @@
  *   Critical-Section Execution to Improve the Performance of Multithreaded
  *   Applications", USENIX ATC'12.
  */
+
 #include "qemu/osdep.h"
+#include "qemu/qemu-print.h"
 #include "qemu/thread.h"
 #include "qemu/timer.h"
 #include "qemu/qht.h"
@@ -678,8 +680,7 @@ static gboolean qsp_tree_report(gpointer key, gpointer value, gpointer udata)
     return FALSE;
 }
 
-static void
-pr_report(const QSPReport *rep, FILE *f, fprintf_function pr)
+static void pr_report(const QSPReport *rep)
 {
     char *dashes;
     size_t max_len = 0;
@@ -702,15 +703,15 @@ pr_report(const QSPReport *rep, FILE *f, fprintf_function pr)
     /* white space to leave to the right of "Call site" */
     callsite_rspace = callsite_len - strlen("Call site");
 
-    pr(f, "Type               Object  Call site%*s  Wait Time (s)  "
-       "       Count  Average (us)\n", callsite_rspace, "");
+    qemu_printf("Type               Object  Call site%*s  Wait Time (s)  "
+                "       Count  Average (us)\n", callsite_rspace, "");
 
     /* build a horizontal rule with dashes */
     n_dashes = 79 + callsite_rspace;
     dashes = g_malloc(n_dashes + 1);
     memset(dashes, '-', n_dashes);
     dashes[n_dashes] = '\0';
-    pr(f, "%s\n", dashes);
+    qemu_printf("%s\n", dashes);
 
     for (i = 0; i < rep->n_entries; i++) {
         const QSPReportEntry *e = &rep->entries[i];
@@ -726,11 +727,11 @@ pr_report(const QSPReport *rep, FILE *f, fprintf_function pr)
                                e->callsite_at,
                                callsite_len - (int)strlen(e->callsite_at), "",
                                e->time_s, e->n_acqs, e->ns_avg * 1e-3);
-        pr(f, "%s", s->str);
+        qemu_printf("%s", s->str);
         g_string_free(s, TRUE);
     }
 
-    pr(f, "%s\n", dashes);
+    qemu_printf("%s\n", dashes);
     g_free(dashes);
 }
 
@@ -746,8 +747,8 @@ static void report_destroy(QSPReport *rep)
     g_free(rep->entries);
 }
 
-void qsp_report(FILE *f, fprintf_function cpu_fprintf, size_t max,
-                enum QSPSortBy sort_by, bool callsite_coalesce)
+void qsp_report(size_t max, enum QSPSortBy sort_by,
+                bool callsite_coalesce)
 {
     GTree *tree = g_tree_new_full(qsp_tree_cmp, &sort_by, g_free, NULL);
     QSPReport rep;
@@ -762,7 +763,7 @@ void qsp_report(FILE *f, fprintf_function cpu_fprintf, size_t max,
     g_tree_foreach(tree, qsp_tree_report, &rep);
     g_tree_destroy(tree);
 
-    pr_report(&rep, f, cpu_fprintf);
+    pr_report(&rep);
     report_destroy(&rep);
 }
 
-- 
2.17.2
