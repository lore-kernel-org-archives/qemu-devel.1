Received: from eggs.gnu.org ([2001:4830:134:3::10]:49259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzRPX-0001Nw-5w
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 14:59:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzRPP-0001Dq-Fw
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 14:59:43 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:32811)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fzRPP-000195-5r
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 14:59:39 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 10 Sep 2018 14:58:54 -0400
Message-Id: <20180910185859.27917-8-cota@braap.org>
In-Reply-To: <20180910185859.27917-1-cota@braap.org>
References: <20180910185859.27917-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 07/12] qht: drop ht argument from qht
 iterators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Accessing the HT from an iterator results almost always
in a deadlock. Given that only one qht-internal function
uses this argument, drop it from the interface.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qemu/qht.h        |  5 ++---
 accel/tcg/translate-all.c |  6 ++----
 tests/test-qht.c          |  6 +++---
 util/qht.c                | 29 +++++++++++++++++++----------
 util/qsp.c                | 11 +++++------
 5 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/include/qemu/qht.h b/include/qemu/qht.h
index 3a9618db69..6484837487 100644
--- a/include/qemu/qht.h
+++ b/include/qemu/qht.h
@@ -43,9 +43,8 @@ struct qht_stats {
 };
 
 typedef bool (*qht_lookup_func_t)(const void *obj, const void *userp);
-typedef void (*qht_iter_func_t)(struct qht *ht, void *p, uint32_t h, void *up);
-typedef bool (*qht_iter_bool_func_t)(struct qht *ht, void *p, uint32_t h,
-                                     void *up);
+typedef void (*qht_iter_func_t)(void *p, uint32_t h, void *up);
+typedef bool (*qht_iter_bool_func_t)(void *p, uint32_t h, void *up);
 
 #define QHT_MODE_AUTO_RESIZE 0x1 /* auto-resize when heavily loaded */
 #define QHT_MODE_RAW_MUTEXES 0x2 /* bypass the profiler (QSP) */
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 898c3bb3d1..9ffbbc2fbd 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1282,8 +1282,7 @@ void tb_flush(CPUState *cpu)
  */
 #ifdef CONFIG_USER_ONLY
 
-static void
-do_tb_invalidate_check(struct qht *ht, void *p, uint32_t hash, void *userp)
+static void do_tb_invalidate_check(void *p, uint32_t hash, void *userp)
 {
     TranslationBlock *tb = p;
     target_ulong addr = *(target_ulong *)userp;
@@ -1304,8 +1303,7 @@ static void tb_invalidate_check(target_ulong address)
     qht_iter(&tb_ctx.htable, do_tb_invalidate_check, &address);
 }
 
-static void
-do_tb_page_check(struct qht *ht, void *p, uint32_t hash, void *userp)
+static void do_tb_page_check(void *p, uint32_t hash, void *userp)
 {
     TranslationBlock *tb = p;
     int flags1, flags2;
diff --git a/tests/test-qht.c b/tests/test-qht.c
index 1ec039d636..4d23cefab6 100644
--- a/tests/test-qht.c
+++ b/tests/test-qht.c
@@ -98,7 +98,7 @@ static void check(int a, int b, bool expected)
     qht_statistics_destroy(&stats);
 }
 
-static void count_func(struct qht *ht, void *p, uint32_t hash, void *userp)
+static void count_func(void *p, uint32_t hash, void *userp)
 {
     unsigned int *curr = userp;
 
@@ -122,7 +122,7 @@ static void iter_check(unsigned int count)
     g_assert_cmpuint(curr, ==, count);
 }
 
-static void sum_func(struct qht *ht, void *p, uint32_t hash, void *userp)
+static void sum_func(void *p, uint32_t hash, void *userp)
 {
     uint32_t *sum = userp;
     uint32_t a = *(uint32_t *)p;
@@ -138,7 +138,7 @@ static void iter_sum_check(unsigned int expected)
     g_assert_cmpuint(sum, ==, expected);
 }
 
-static bool rm_mod_func(struct qht *ht, void *p, uint32_t hash, void *userp)
+static bool rm_mod_func(void *p, uint32_t hash, void *userp)
 {
     uint32_t a = *(uint32_t *)p;
     unsigned int mod = *(unsigned int *)userp;
diff --git a/util/qht.c b/util/qht.c
index c190e89f5b..50ed7a2102 100644
--- a/util/qht.c
+++ b/util/qht.c
@@ -746,7 +746,7 @@ bool qht_remove(struct qht *ht, const void *p, uint32_t hash)
     return ret;
 }
 
-static inline void qht_bucket_iter(struct qht *ht, struct qht_bucket *head,
+static inline void qht_bucket_iter(struct qht_bucket *head,
                                    const struct qht_iter *iter, void *userp)
 {
     struct qht_bucket *b = head;
@@ -759,10 +759,10 @@ static inline void qht_bucket_iter(struct qht *ht, struct qht_bucket *head,
             }
             switch (iter->type) {
             case QHT_ITER_VOID:
-                iter->f.retvoid(ht, b->pointers[i], b->hashes[i], userp);
+                iter->f.retvoid(b->pointers[i], b->hashes[i], userp);
                 break;
             case QHT_ITER_RM:
-                if (iter->f.retbool(ht, b->pointers[i], b->hashes[i], userp)) {
+                if (iter->f.retbool(b->pointers[i], b->hashes[i], userp)) {
                     /* replace i with the last valid element in the bucket */
                     seqlock_write_begin(&head->sequence);
                     qht_bucket_remove_entry(b, i);
@@ -782,14 +782,14 @@ static inline void qht_bucket_iter(struct qht *ht, struct qht_bucket *head,
 }
 
 /* call with all of the map's locks held */
-static inline void qht_map_iter__all_locked(struct qht *ht, struct qht_map *map,
+static inline void qht_map_iter__all_locked(struct qht_map *map,
                                             const struct qht_iter *iter,
                                             void *userp)
 {
     size_t i;
 
     for (i = 0; i < map->n_buckets; i++) {
-        qht_bucket_iter(ht, &map->buckets[i], iter, userp);
+        qht_bucket_iter(&map->buckets[i], iter, userp);
     }
 }
 
@@ -800,8 +800,7 @@ do_qht_iter(struct qht *ht, const struct qht_iter *iter, void *userp)
 
     map = atomic_rcu_read(&ht->map);
     qht_map_lock_buckets(map);
-    /* Note: ht here is merely for carrying ht->mode; ht->map won't be read */
-    qht_map_iter__all_locked(ht, map, iter, userp);
+    qht_map_iter__all_locked(map, iter, userp);
     qht_map_unlock_buckets(map);
 }
 
@@ -825,9 +824,16 @@ void qht_iter_remove(struct qht *ht, qht_iter_bool_func_t func, void *userp)
     do_qht_iter(ht, &iter, userp);
 }
 
-static void qht_map_copy(struct qht *ht, void *p, uint32_t hash, void *userp)
+struct qht_map_copy_data {
+    struct qht *ht;
+    struct qht_map *new;
+};
+
+static void qht_map_copy(void *p, uint32_t hash, void *userp)
 {
-    struct qht_map *new = userp;
+    struct qht_map_copy_data *data = userp;
+    struct qht *ht = data->ht;
+    struct qht_map *new = data->new;
     struct qht_bucket *b = qht_map_to_bucket(new, hash);
 
     /* no need to acquire b->lock because no thread has seen this map yet */
@@ -845,6 +851,7 @@ static void qht_do_resize_reset(struct qht *ht, struct qht_map *new, bool reset)
         .f.retvoid = qht_map_copy,
         .type = QHT_ITER_VOID,
     };
+    struct qht_map_copy_data data;
 
     old = ht->map;
     qht_map_lock_buckets(old);
@@ -859,7 +866,9 @@ static void qht_do_resize_reset(struct qht *ht, struct qht_map *new, bool reset)
     }
 
     g_assert(new->n_buckets != old->n_buckets);
-    qht_map_iter__all_locked(ht, old, &iter, new);
+    data.ht = ht;
+    data.new = new;
+    qht_map_iter__all_locked(old, &iter, &data);
     qht_map_debug__all_locked(new);
 
     atomic_rcu_set(&ht->map, new);
diff --git a/util/qsp.c b/util/qsp.c
index b0c2575d10..2de3a97594 100644
--- a/util/qsp.c
+++ b/util/qsp.c
@@ -533,7 +533,7 @@ static gint qsp_tree_cmp(gconstpointer ap, gconstpointer bp, gpointer up)
     }
 }
 
-static void qsp_sort(struct qht *ht, void *p, uint32_t h, void *userp)
+static void qsp_sort(void *p, uint32_t h, void *userp)
 {
     QSPEntry *e = p;
     GTree *tree = userp;
@@ -541,7 +541,7 @@ static void qsp_sort(struct qht *ht, void *p, uint32_t h, void *userp)
     g_tree_insert(tree, e, NULL);
 }
 
-static void qsp_aggregate(struct qht *global_ht, void *p, uint32_t h, void *up)
+static void qsp_aggregate(void *p, uint32_t h, void *up)
 {
     struct qht *ht = up;
     const QSPEntry *e = p;
@@ -553,7 +553,7 @@ static void qsp_aggregate(struct qht *global_ht, void *p, uint32_t h, void *up)
     qsp_entry_aggregate(agg, e);
 }
 
-static void qsp_iter_diff(struct qht *orig, void *p, uint32_t hash, void *htp)
+static void qsp_iter_diff(void *p, uint32_t hash, void *htp)
 {
     struct qht *ht = htp;
     QSPEntry *old = p;
@@ -583,8 +583,7 @@ static void qsp_diff(struct qht *orig, struct qht *new)
     qht_iter(orig, qsp_iter_diff, new);
 }
 
-static void
-qsp_iter_callsite_coalesce(struct qht *orig, void *p, uint32_t h, void *htp)
+static void qsp_iter_callsite_coalesce(void *p, uint32_t h, void *htp)
 {
     struct qht *ht = htp;
     QSPEntry *old = p;
@@ -603,7 +602,7 @@ qsp_iter_callsite_coalesce(struct qht *orig, void *p, uint32_t h, void *htp)
     e->n_acqs += old->n_acqs;
 }
 
-static void qsp_ht_delete(struct qht *ht, void *p, uint32_t h, void *htp)
+static void qsp_ht_delete(void *p, uint32_t h, void *htp)
 {
     g_free(p);
 }
-- 
2.17.1
