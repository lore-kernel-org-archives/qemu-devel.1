Received: from eggs.gnu.org ([2001:4830:134:3::10]:36279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fqXA8-0000d8-OR
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 01:19:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fqXA5-0005Yd-F3
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 01:19:04 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49223)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fqXA2-0005VS-Is
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 01:18:59 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 17 Aug 2018 01:18:46 -0400
Message-Id: <20180817051853.23792-3-cota@braap.org>
In-Reply-To: <20180817051853.23792-1-cota@braap.org>
References: <20180817051853.23792-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 2/9] qsp: add sort_by option to qsp_report
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, Fam Zheng <famz@redhat.com>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qemu/qsp.h |  8 +++++++-
 util/qsp.c         | 33 +++++++++++++++++++++++++++------
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/include/qemu/qsp.h b/include/qemu/qsp.h
index 9c2bb60ff0..209480b687 100644
--- a/include/qemu/qsp.h
+++ b/include/qemu/qsp.h
@@ -13,7 +13,13 @@
 
 #include "qemu/fprintf-fn.h"
 
-void qsp_report(FILE *f, fprintf_function cpu_fprintf, size_t max);
+enum QSPSortBy {
+    QSP_SORT_BY_TOTAL_WAIT_TIME,
+    QSP_SORT_BY_AVG_WAIT_TIME,
+};
+
+void qsp_report(FILE *f, fprintf_function cpu_fprintf, size_t max,
+                enum QSPSortBy sort_by);
 
 bool qsp_is_enabled(void);
 void qsp_enable(void);
diff --git a/util/qsp.c b/util/qsp.c
index a02c925fe6..b04d4d9986 100644
--- a/util/qsp.c
+++ b/util/qsp.c
@@ -379,14 +379,34 @@ static gint qsp_tree_cmp(gconstpointer ap, gconstpointer bp, gpointer up)
 {
     const QSPEntry *a = ap;
     const QSPEntry *b = bp;
+    enum QSPSortBy sort_by = *(enum QSPSortBy *)up;
     const QSPCallSite *ca;
     const QSPCallSite *cb;
 
-    if (a->ns > b->ns) {
-        return -1;
-    } else if (a->ns < b->ns) {
-        return 1;
+    switch (sort_by) {
+    case QSP_SORT_BY_TOTAL_WAIT_TIME:
+        if (a->ns > b->ns) {
+            return -1;
+        } else if (a->ns < b->ns) {
+            return 1;
+        }
+        break;
+    case QSP_SORT_BY_AVG_WAIT_TIME:
+    {
+        double avg_a = a->n_acqs ? a->ns / a->n_acqs : 0;
+        double avg_b = b->n_acqs ? b->ns / b->n_acqs : 0;
+
+        if (avg_a > avg_b) {
+            return -1;
+        } else if (avg_a < avg_b) {
+            return 1;
+        }
+        break;
     }
+    default:
+        g_assert_not_reached();
+    }
+
     ca = a->callsite;
     cb = b->callsite;
     /* Break the tie with the object's address */
@@ -564,9 +584,10 @@ static void report_destroy(QSPReport *rep)
     g_free(rep->entries);
 }
 
-void qsp_report(FILE *f, fprintf_function cpu_fprintf, size_t max)
+void qsp_report(FILE *f, fprintf_function cpu_fprintf, size_t max,
+                enum QSPSortBy sort_by)
 {
-    GTree *tree = g_tree_new_full(qsp_tree_cmp, NULL, g_free, NULL);
+    GTree *tree = g_tree_new_full(qsp_tree_cmp, &sort_by, g_free, NULL);
     QSPReport rep;
 
     qsp_init();
-- 
2.17.1
