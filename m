Received: from eggs.gnu.org ([2001:4830:134:3::10]:36294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fqXA9-0000dG-2f
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 01:19:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fqXA7-0005bR-Ic
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 01:19:05 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34387)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fqXA6-0005Yn-LV
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 01:19:03 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 17 Aug 2018 01:18:47 -0400
Message-Id: <20180817051853.23792-4-cota@braap.org>
In-Reply-To: <20180817051853.23792-1-cota@braap.org>
References: <20180817051853.23792-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 3/9] qsp: add qsp_reset
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

I first implemented this by deleting all entries in the global
hash table. But doing that safely slows down profiling, since
we'd need to introduce rcu_read_lock/unlock in the fast path.

What's implemented here avoids messing with the thread-local
data in the global hash table. It achieves this by taking a snapshot
of the current state, so that subsequent reports present the delta
wrt to the snapshot.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qemu/qsp.h |  1 +
 util/qsp.c         | 94 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)

diff --git a/include/qemu/qsp.h b/include/qemu/qsp.h
index 209480b687..f8c6c9648a 100644
--- a/include/qemu/qsp.h
+++ b/include/qemu/qsp.h
@@ -24,5 +24,6 @@ void qsp_report(FILE *f, fprintf_function cpu_fprintf, size_t max,
 bool qsp_is_enabled(void);
 void qsp_enable(void);
 void qsp_disable(void);
+void qsp_reset(void);
 
 #endif /* QEMU_QSP_H */
diff --git a/util/qsp.c b/util/qsp.c
index b04d4d9986..ea4bb82a03 100644
--- a/util/qsp.c
+++ b/util/qsp.c
@@ -47,6 +47,11 @@
  *   an intermediate hash table. This would simplify the code only slightly, but
  *   would perform badly if there were many threads and objects to track.
  *
+ * - Wrap operations on qsp entries with RCU read-side critical sections, so
+ *   that qsp_reset() can delete entries. Unfortunately, the overhead of calling
+ *   rcu_read_lock/unlock slows down atomic_add-bench -m by 24%. Having
+ *   a snapshot that is updated on qsp_reset() avoids this overhead.
+ *
  * Related Work:
  * - Lennart Poettering's mutrace: http://0pointer.de/blog/projects/mutrace.html
  * - Lozi, David, Thomas, Lawall and Muller. "Remote Core Locking: Migrating
@@ -57,6 +62,7 @@
 #include "qemu/thread.h"
 #include "qemu/timer.h"
 #include "qemu/qht.h"
+#include "qemu/rcu.h"
 #include "exec/tb-hash-xx.h"
 
 enum QSPType {
@@ -81,6 +87,12 @@ struct QSPEntry {
 };
 typedef struct QSPEntry QSPEntry;
 
+struct QSPSnapshot {
+    struct rcu_head rcu;
+    struct qht ht;
+};
+typedef struct QSPSnapshot QSPSnapshot;
+
 /* initial sizing for hash tables */
 #define QSP_INITIAL_SIZE 64
 
@@ -100,6 +112,7 @@ static __thread int qsp_thread;
 static struct qht qsp_callsite_ht;
 
 static struct qht qsp_ht;
+static QSPSnapshot *qsp_snapshot;
 static bool qsp_initialized, qsp_initializing;
 
 static const char * const qsp_typenames[] = {
@@ -456,15 +469,69 @@ static void qsp_aggregate(struct qht *global_ht, void *p, uint32_t h, void *up)
     agg->n_acqs += e->n_acqs;
 }
 
+static void qsp_iter_diff(struct qht *orig, void *p, uint32_t hash, void *htp)
+{
+    struct qht *ht = htp;
+    QSPEntry *old = p;
+    QSPEntry *new;
+
+    new = qht_lookup(ht, old, hash);
+    /* entries are never deleted, so we must have this one */
+    g_assert(new != NULL);
+    /* our reading of the stats happened after the snapshot was taken */
+    g_assert(new->n_acqs >= old->n_acqs);
+    g_assert(new->ns >= old->ns);
+
+    new->n_acqs -= old->n_acqs;
+    new->ns -= old->ns;
+
+    /* No point in reporting an empty entry */
+    if (new->n_acqs == 0 && new->ns == 0) {
+        bool removed = qht_remove(ht, new, hash);
+
+        g_assert(removed);
+        g_free(new);
+    }
+}
+
+static void qsp_diff(struct qht *orig, struct qht *new)
+{
+    qht_iter(orig, qsp_iter_diff, new);
+}
+
+static void qsp_ht_delete(struct qht *ht, void *p, uint32_t h, void *htp)
+{
+    g_free(p);
+}
+
 static void qsp_mktree(GTree *tree)
 {
+    QSPSnapshot *snap;
     struct qht ht;
 
+    /*
+     * First, see if there's a prior snapshot, so that we read the global hash
+     * table _after_ the snapshot has been created, which guarantees that
+     * the entries we'll read will be a superset of the snapshot's entries.
+     *
+     * We must remain in an RCU read-side critical section until we're done
+     * with the snapshot.
+     */
+    rcu_read_lock();
+    snap = atomic_rcu_read(&qsp_snapshot);
+
     /* Aggregate all results from the global hash table into a local one */
     qht_init(&ht, qsp_entry_no_thread_cmp, QSP_INITIAL_SIZE,
              QHT_MODE_AUTO_RESIZE | QHT_MODE_RAW_MUTEXES);
     qht_iter(&qsp_ht, qsp_aggregate, &ht);
 
+    /* compute the difference wrt the snapshot, if any */
+    if (snap) {
+        qsp_diff(&snap->ht, &ht);
+    }
+    /* done with the snapshot; RCU can reclaim it */
+    rcu_read_unlock();
+
     /* sort the hash table elements by using a tree */
     qht_iter(&ht, qsp_sort, tree);
 
@@ -603,3 +670,30 @@ void qsp_report(FILE *f, fprintf_function cpu_fprintf, size_t max,
     pr_report(&rep, f, cpu_fprintf);
     report_destroy(&rep);
 }
+
+static void qsp_snapshot_destroy(QSPSnapshot *snap)
+{
+    qht_iter(&snap->ht, qsp_ht_delete, NULL);
+    qht_destroy(&snap->ht);
+    g_free(snap);
+}
+
+void qsp_reset(void)
+{
+    QSPSnapshot *new = g_new(QSPSnapshot, 1);
+    QSPSnapshot *old;
+
+    qsp_init();
+
+    qht_init(&new->ht, qsp_entry_cmp, QSP_INITIAL_SIZE,
+             QHT_MODE_AUTO_RESIZE | QHT_MODE_RAW_MUTEXES);
+
+    /* take a snapshot of the current state */
+    qht_iter(&qsp_ht, qsp_aggregate, &new->ht);
+
+    /* replace the previous snapshot, if any */
+    old = atomic_xchg(&qsp_snapshot, new);
+    if (old) {
+        call_rcu(old, qsp_snapshot_destroy, rcu);
+    }
+}
-- 
2.17.1
