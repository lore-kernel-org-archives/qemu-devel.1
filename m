Received: from eggs.gnu.org ([2001:4830:134:3::10]:33195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4P-0001jX-2I
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4E-0006NS-PG
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:46 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45267)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA47-0005uV-S4
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:37 -0400
Received: by mail-wr1-x442.google.com with SMTP id 20-v6so10506583wrb.12
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:25 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:01:51 +0200
Message-Id: <1534870966-9287-20-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 19/74] qsp: add sort_by option to qsp_report
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/qsp.h |  8 +++++++-
 util/qsp.c         | 33 +++++++++++++++++++++++++++------
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/include/qemu/qsp.h b/include/qemu/qsp.h
index 9c2bb60..209480b 100644
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
index c5fce4b..80dbd4c 100644
--- a/util/qsp.c
+++ b/util/qsp.c
@@ -429,14 +429,34 @@ static gint qsp_tree_cmp(gconstpointer ap, gconstpointer bp, gpointer up)
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
@@ -613,9 +633,10 @@ static void report_destroy(QSPReport *rep)
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
1.8.3.1
