Received: from eggs.gnu.org ([2001:4830:134:3::10]:49045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzRPM-0001Fl-3R
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 14:59:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzRP6-00013B-UN
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 14:59:30 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51791)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fzROy-0000zG-Lv
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 14:59:15 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 10 Sep 2018 14:58:49 -0400
Message-Id: <20180910185859.27917-3-cota@braap.org>
In-Reply-To: <20180910185859.27917-1-cota@braap.org>
References: <20180910185859.27917-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 02/12] qht: add qht_iter_remove
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

This currently has no users, but the use case is so common that I
think we must support it.

Note that without the appended we cannot safely remove a set of
elements; a 2-step approach (i.e. qht_iter first, keep track of
the to-be-deleted elements, and then a bunch of qht_remove calls)
would be racy, since between the iteration and the removals other
threads might insert additional elements.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qemu/qht.h | 19 ++++++++++++
 util/qht.c         | 74 +++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 85 insertions(+), 8 deletions(-)

diff --git a/include/qemu/qht.h b/include/qemu/qht.h
index c9a11cc29a..3a9618db69 100644
--- a/include/qemu/qht.h
+++ b/include/qemu/qht.h
@@ -44,6 +44,8 @@ struct qht_stats {
 
 typedef bool (*qht_lookup_func_t)(const void *obj, const void *userp);
 typedef void (*qht_iter_func_t)(struct qht *ht, void *p, uint32_t h, void *up);
+typedef bool (*qht_iter_bool_func_t)(struct qht *ht, void *p, uint32_t h,
+                                     void *up);
 
 #define QHT_MODE_AUTO_RESIZE 0x1 /* auto-resize when heavily loaded */
 #define QHT_MODE_RAW_MUTEXES 0x2 /* bypass the profiler (QSP) */
@@ -179,9 +181,26 @@ bool qht_resize(struct qht *ht, size_t n_elems);
  *
  * Each time it is called, user-provided @func is passed a pointer-hash pair,
  * plus @userp.
+ *
+ * Note: @ht cannot be accessed from @func
+ * See also: qht_iter_remove()
  */
 void qht_iter(struct qht *ht, qht_iter_func_t func, void *userp);
 
+/**
+ * qht_iter_remove - Iterate over a QHT, optionally removing entries
+ * @ht: QHT to be iterated over
+ * @func: function to be called for each entry in QHT
+ * @userp: additional pointer to be passed to @func
+ *
+ * Each time it is called, user-provided @func is passed a pointer-hash pair,
+ * plus @userp. If @func returns true, the pointer-hash pair is removed.
+ *
+ * Note: @ht cannot be accessed from @func
+ * See also: qht_iter()
+ */
+void qht_iter_remove(struct qht *ht, qht_iter_bool_func_t func, void *userp);
+
 /**
  * qht_statistics_init - Gather statistics from a QHT
  * @ht: QHT to gather statistics from
diff --git a/util/qht.c b/util/qht.c
index 28d9273371..c190e89f5b 100644
--- a/util/qht.c
+++ b/util/qht.c
@@ -89,6 +89,19 @@
 #define QHT_BUCKET_ENTRIES 4
 #endif
 
+enum qht_iter_type {
+    QHT_ITER_VOID,    /* do nothing; use retvoid */
+    QHT_ITER_RM,      /* remove element if retbool returns true */
+};
+
+struct qht_iter {
+    union {
+        qht_iter_func_t retvoid;
+        qht_iter_bool_func_t retbool;
+    } f;
+    enum qht_iter_type type;
+};
+
 /*
  * Do _not_ use qemu_mutex_[try]lock directly! Use these macros, otherwise
  * the profiler (QSP) will deadlock.
@@ -733,9 +746,10 @@ bool qht_remove(struct qht *ht, const void *p, uint32_t hash)
     return ret;
 }
 
-static inline void qht_bucket_iter(struct qht *ht, struct qht_bucket *b,
-                                   qht_iter_func_t func, void *userp)
+static inline void qht_bucket_iter(struct qht *ht, struct qht_bucket *head,
+                                   const struct qht_iter *iter, void *userp)
 {
+    struct qht_bucket *b = head;
     int i;
 
     do {
@@ -743,7 +757,25 @@ static inline void qht_bucket_iter(struct qht *ht, struct qht_bucket *b,
             if (b->pointers[i] == NULL) {
                 return;
             }
-            func(ht, b->pointers[i], b->hashes[i], userp);
+            switch (iter->type) {
+            case QHT_ITER_VOID:
+                iter->f.retvoid(ht, b->pointers[i], b->hashes[i], userp);
+                break;
+            case QHT_ITER_RM:
+                if (iter->f.retbool(ht, b->pointers[i], b->hashes[i], userp)) {
+                    /* replace i with the last valid element in the bucket */
+                    seqlock_write_begin(&head->sequence);
+                    qht_bucket_remove_entry(b, i);
+                    seqlock_write_end(&head->sequence);
+                    qht_bucket_debug__locked(b);
+                    /* reevaluate i, since it just got replaced */
+                    i--;
+                    continue;
+                }
+                break;
+            default:
+                g_assert_not_reached();
+            }
         }
         b = b->next;
     } while (b);
@@ -751,26 +783,48 @@ static inline void qht_bucket_iter(struct qht *ht, struct qht_bucket *b,
 
 /* call with all of the map's locks held */
 static inline void qht_map_iter__all_locked(struct qht *ht, struct qht_map *map,
-                                            qht_iter_func_t func, void *userp)
+                                            const struct qht_iter *iter,
+                                            void *userp)
 {
     size_t i;
 
     for (i = 0; i < map->n_buckets; i++) {
-        qht_bucket_iter(ht, &map->buckets[i], func, userp);
+        qht_bucket_iter(ht, &map->buckets[i], iter, userp);
     }
 }
 
-void qht_iter(struct qht *ht, qht_iter_func_t func, void *userp)
+static inline void
+do_qht_iter(struct qht *ht, const struct qht_iter *iter, void *userp)
 {
     struct qht_map *map;
 
     map = atomic_rcu_read(&ht->map);
     qht_map_lock_buckets(map);
     /* Note: ht here is merely for carrying ht->mode; ht->map won't be read */
-    qht_map_iter__all_locked(ht, map, func, userp);
+    qht_map_iter__all_locked(ht, map, iter, userp);
     qht_map_unlock_buckets(map);
 }
 
+void qht_iter(struct qht *ht, qht_iter_func_t func, void *userp)
+{
+    const struct qht_iter iter = {
+        .f.retvoid = func,
+        .type = QHT_ITER_VOID,
+    };
+
+    do_qht_iter(ht, &iter, userp);
+}
+
+void qht_iter_remove(struct qht *ht, qht_iter_bool_func_t func, void *userp)
+{
+    const struct qht_iter iter = {
+        .f.retbool = func,
+        .type = QHT_ITER_RM,
+    };
+
+    do_qht_iter(ht, &iter, userp);
+}
+
 static void qht_map_copy(struct qht *ht, void *p, uint32_t hash, void *userp)
 {
     struct qht_map *new = userp;
@@ -787,6 +841,10 @@ static void qht_map_copy(struct qht *ht, void *p, uint32_t hash, void *userp)
 static void qht_do_resize_reset(struct qht *ht, struct qht_map *new, bool reset)
 {
     struct qht_map *old;
+    const struct qht_iter iter = {
+        .f.retvoid = qht_map_copy,
+        .type = QHT_ITER_VOID,
+    };
 
     old = ht->map;
     qht_map_lock_buckets(old);
@@ -801,7 +859,7 @@ static void qht_do_resize_reset(struct qht *ht, struct qht_map *new, bool reset)
     }
 
     g_assert(new->n_buckets != old->n_buckets);
-    qht_map_iter__all_locked(ht, old, qht_map_copy, new);
+    qht_map_iter__all_locked(ht, old, &iter, new);
     qht_map_debug__all_locked(new);
 
     atomic_rcu_set(&ht->map, new);
-- 
2.17.1
