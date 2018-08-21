Received: from eggs.gnu.org ([2001:4830:134:3::10]:33415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4X-0001us-70
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4U-0006iI-21
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:00 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:50857)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4P-0005y7-1U
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:55 -0400
Received: by mail-wm0-x231.google.com with SMTP id s12-v6so3659467wmc.0
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:27 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:01:53 +0200
Message-Id: <1534870966-9287-22-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 21/74] qsp: support call site coalescing
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
 include/qemu/qsp.h |   2 +-
 util/qsp.c         | 102 +++++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 89 insertions(+), 15 deletions(-)

diff --git a/include/qemu/qsp.h b/include/qemu/qsp.h
index f8c6c96..a94c464 100644
--- a/include/qemu/qsp.h
+++ b/include/qemu/qsp.h
@@ -19,7 +19,7 @@ enum QSPSortBy {
 };
 
 void qsp_report(FILE *f, fprintf_function cpu_fprintf, size_t max,
-                enum QSPSortBy sort_by);
+                enum QSPSortBy sort_by, bool callsite_coalesce);
 
 bool qsp_is_enabled(void);
 void qsp_enable(void);
diff --git a/util/qsp.c b/util/qsp.c
index 4b1308b..4dc851e 100644
--- a/util/qsp.c
+++ b/util/qsp.c
@@ -27,11 +27,9 @@
  * Reports are generated as a table where each row represents a call site. A
  * call site is the triplet formed by the __file__ and __LINE__ of the caller
  * as well as the address of the "object" (i.e. mutex, rec. mutex or condvar)
- * being operated on. Focusing on call sites instead of just on objects might
- * seem puzzling. However, it is a sensible choice since otherwise dealing with
- * dynamically-allocated objects becomes difficult (e.g. what to do when an
- * object is destroyed, or reused?). Furthermore, the call site info is of most
- * importance, since it is callers, and not objects, what cause wait time.
+ * being operated on. Optionally, call sites that operate on different objects
+ * of the same type can be coalesced, which can be particularly useful when
+ * profiling dynamically-allocated objects.
  *
  * Alternative designs considered:
  *
@@ -84,6 +82,7 @@ struct QSPEntry {
     const QSPCallSite *callsite;
     uint64_t n_acqs;
     uint64_t ns;
+    unsigned int n_objs; /* count of coalesced objs; only used for reporting */
 #ifndef CONFIG_ATOMIC64
     /*
      * If we cannot update the counts atomically, then use a seqlock.
@@ -170,6 +169,17 @@ static uint32_t qsp_entry_no_thread_hash(const QSPEntry *entry)
     return do_qsp_entry_hash(entry, 0);
 }
 
+/* without the objects we need to hash the file name to get a decent hash */
+static uint32_t qsp_entry_no_thread_obj_hash(const QSPEntry *entry)
+{
+    const QSPCallSite *callsite = entry->callsite;
+    uint64_t a = g_str_hash(callsite->file);
+    uint64_t b = callsite->line;
+    uint32_t e = callsite->type;
+
+    return tb_hash_func7(a, b, e, 0, 0);
+}
+
 static bool qsp_callsite_cmp(const void *ap, const void *bp)
 {
     const QSPCallSite *a = ap;
@@ -182,6 +192,17 @@ static bool qsp_callsite_cmp(const void *ap, const void *bp)
          (a->file == b->file || !strcmp(a->file, b->file)));
 }
 
+static bool qsp_callsite_no_obj_cmp(const void *ap, const void *bp)
+{
+    const QSPCallSite *a = ap;
+    const QSPCallSite *b = bp;
+
+    return a == b ||
+        (a->line == b->line &&
+         a->type == b->type &&
+         (a->file == b->file || !strcmp(a->file, b->file)));
+}
+
 static bool qsp_entry_no_thread_cmp(const void *ap, const void *bp)
 {
     const QSPEntry *a = ap;
@@ -190,6 +211,14 @@ static bool qsp_entry_no_thread_cmp(const void *ap, const void *bp)
     return qsp_callsite_cmp(a->callsite, b->callsite);
 }
 
+static bool qsp_entry_no_thread_obj_cmp(const void *ap, const void *bp)
+{
+    const QSPEntry *a = ap;
+    const QSPEntry *b = bp;
+
+    return qsp_callsite_no_obj_cmp(a->callsite, b->callsite);
+}
+
 static bool qsp_entry_cmp(const void *ap, const void *bp)
 {
     const QSPEntry *a = ap;
@@ -548,15 +577,36 @@ static void qsp_diff(struct qht *orig, struct qht *new)
     qht_iter(orig, qsp_iter_diff, new);
 }
 
+static void
+qsp_iter_callsite_coalesce(struct qht *orig, void *p, uint32_t h, void *htp)
+{
+    struct qht *ht = htp;
+    QSPEntry *old = p;
+    QSPEntry *e;
+    uint32_t hash;
+
+    hash = qsp_entry_no_thread_obj_hash(old);
+    e = qht_lookup(ht, old, hash);
+    if (e == NULL) {
+        e = qsp_entry_create(ht, old, hash);
+        e->n_objs = 1;
+    } else if (e->callsite->obj != old->callsite->obj) {
+        e->n_objs++;
+    }
+    e->ns += old->ns;
+    e->n_acqs += old->n_acqs;
+}
+
 static void qsp_ht_delete(struct qht *ht, void *p, uint32_t h, void *htp)
 {
     g_free(p);
 }
 
-static void qsp_mktree(GTree *tree)
+static void qsp_mktree(GTree *tree, bool callsite_coalesce)
 {
     QSPSnapshot *snap;
-    struct qht ht;
+    struct qht ht, coalesce_ht;
+    struct qht *htp;
 
     /*
      * First, see if there's a prior snapshot, so that we read the global hash
@@ -581,11 +631,23 @@ static void qsp_mktree(GTree *tree)
     /* done with the snapshot; RCU can reclaim it */
     rcu_read_unlock();
 
+    htp = &ht;
+    if (callsite_coalesce) {
+        qht_init(&coalesce_ht, qsp_entry_no_thread_obj_cmp, QSP_INITIAL_SIZE,
+                 QHT_MODE_AUTO_RESIZE | QHT_MODE_RAW_MUTEXES);
+        qht_iter(&ht, qsp_iter_callsite_coalesce, &coalesce_ht);
+
+        /* free the previous hash table, and point htp to coalesce_ht */
+        qht_iter(&ht, qsp_ht_delete, NULL);
+        qht_destroy(&ht);
+        htp = &coalesce_ht;
+    }
+
     /* sort the hash table elements by using a tree */
-    qht_iter(&ht, qsp_sort, tree);
+    qht_iter(htp, qsp_sort, tree);
 
     /* free the hash table, but keep the elements (those are in the tree now) */
-    qht_destroy(&ht);
+    qht_destroy(htp);
 }
 
 /* free string with g_free */
@@ -611,6 +673,7 @@ struct QSPReportEntry {
     double time_s;
     double ns_avg;
     uint64_t n_acqs;
+    unsigned int n_objs;
 };
 typedef struct QSPReportEntry QSPReportEntry;
 
@@ -634,6 +697,7 @@ static gboolean qsp_tree_report(gpointer key, gpointer value, gpointer udata)
     report->n_entries++;
 
     entry->obj = e->callsite->obj;
+    entry->n_objs = e->n_objs;
     entry->callsite_at = qsp_at(e->callsite);
     entry->typename = qsp_typenames[e->callsite->type];
     entry->time_s = e->ns * 1e-9;
@@ -678,10 +742,20 @@ pr_report(const QSPReport *rep, FILE *f, fprintf_function pr)
 
     for (i = 0; i < rep->n_entries; i++) {
         const QSPReportEntry *e = &rep->entries[i];
+        GString *s = g_string_new(NULL);
 
-        pr(f, "%-9s  %14p  %s%*s  %13.5f  %12" PRIu64 "  %12.2f\n", e->typename,
-           e->obj, e->callsite_at, callsite_len - (int)strlen(e->callsite_at),
-           "", e->time_s, e->n_acqs, e->ns_avg * 1e-3);
+        g_string_append_printf(s, "%-9s  ", e->typename);
+        if (e->n_objs > 1) {
+            g_string_append_printf(s, "[%12u]", e->n_objs);
+        } else {
+            g_string_append_printf(s, "%14p", e->obj);
+        }
+        g_string_append_printf(s, "  %s%*s  %13.5f  %12" PRIu64 "  %12.2f\n",
+                               e->callsite_at,
+                               callsite_len - (int)strlen(e->callsite_at), "",
+                               e->time_s, e->n_acqs, e->ns_avg * 1e-3);
+        pr(f, "%s", s->str);
+        g_string_free(s, TRUE);
     }
 
     pr(f, "%s\n", dashes);
@@ -701,7 +775,7 @@ static void report_destroy(QSPReport *rep)
 }
 
 void qsp_report(FILE *f, fprintf_function cpu_fprintf, size_t max,
-                enum QSPSortBy sort_by)
+                enum QSPSortBy sort_by, bool callsite_coalesce)
 {
     GTree *tree = g_tree_new_full(qsp_tree_cmp, &sort_by, g_free, NULL);
     QSPReport rep;
@@ -712,7 +786,7 @@ void qsp_report(FILE *f, fprintf_function cpu_fprintf, size_t max,
     rep.n_entries = 0;
     rep.max_n_entries = max;
 
-    qsp_mktree(tree);
+    qsp_mktree(tree, callsite_coalesce);
     g_tree_foreach(tree, qsp_tree_report, &rep);
     g_tree_destroy(tree);
 
-- 
1.8.3.1
