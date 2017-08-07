Received: from eggs.gnu.org ([2001:4830:134:3::10]:47797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1derpN-0005yY-4K
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:53:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1derpG-0005iD-V7
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:52:53 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42171)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1derpG-0005hU-Pd
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:52:46 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  7 Aug 2017 19:52:21 -0400
Message-Id: <1502149958-23381-6-git-send-email-cota@braap.org>
In-Reply-To: <1502149958-23381-1-git-send-email-cota@braap.org>
References: <1502149958-23381-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 05/22] qht: require a default comparison
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

qht_lookup now uses the default cmp function. qht_lookup_custom is defined
to retain the old behaviour, that is a cmp function is explicitly provided.

qht_insert will gain use of the default cmp in the next patch.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qemu/qht.h        | 23 +++++++++++++++++++----
 accel/tcg/cpu-exec.c      |  4 ++--
 accel/tcg/translate-all.c | 16 +++++++++++++++-
 tests/qht-bench.c         | 14 +++++++-------
 tests/test-qht.c          | 15 ++++++++++-----
 util/qht.c                | 13 ++++++++++---
 6 files changed, 63 insertions(+), 22 deletions(-)

diff --git a/include/qemu/qht.h b/include/qemu/qht.h
index 531aa95..dd512bf 100644
--- a/include/qemu/qht.h
+++ b/include/qemu/qht.h
@@ -11,8 +11,11 @@
 #include "qemu/thread.h"
 #include "qemu/qdist.h"
 
+typedef bool (*qht_cmp_func_t)(const void *a, const void *b);
+
 struct qht {
     struct qht_map *map;
+    qht_cmp_func_t cmp;
     QemuMutex lock; /* serializes setters of ht->map */
     unsigned int mode;
 };
@@ -47,10 +50,12 @@ typedef void (*qht_iter_func_t)(struct qht *ht, void *p, uint32_t h, void *up);
 /**
  * qht_init - Initialize a QHT
  * @ht: QHT to be initialized
+ * @cmp: default comparison function. Cannot be NULL.
  * @n_elems: number of entries the hash table should be optimized for.
  * @mode: bitmask with OR'ed QHT_MODE_*
  */
-void qht_init(struct qht *ht, size_t n_elems, unsigned int mode);
+void qht_init(struct qht *ht, qht_cmp_func_t cmp, size_t n_elems,
+              unsigned int mode);
 
 /**
  * qht_destroy - destroy a previously initialized QHT
@@ -78,7 +83,7 @@ void qht_destroy(struct qht *ht);
 bool qht_insert(struct qht *ht, void *p, uint32_t hash);
 
 /**
- * qht_lookup - Look up a pointer in a QHT
+ * qht_lookup_custom - Look up a pointer using a custom comparison function.
  * @ht: QHT to be looked up
  * @func: function to compare existing pointers against @userp
  * @userp: pointer to pass to @func
@@ -94,8 +99,18 @@ bool qht_insert(struct qht *ht, void *p, uint32_t hash);
  * Returns the corresponding pointer when a match is found.
  * Returns NULL otherwise.
  */
-void *qht_lookup(struct qht *ht, qht_lookup_func_t func, const void *userp,
-                 uint32_t hash);
+void *qht_lookup_custom(struct qht *ht, qht_lookup_func_t func,
+                        const void *userp, uint32_t hash);
+
+/**
+ * qht_lookup - Look up a pointer in a QHT
+ * @ht: QHT to be looked up
+ * @userp: pointer to pass to @func
+ * @hash: hash of the pointer to be looked up
+ *
+ * Calls qht_lookup_custom() using @ht's default comparison function.
+ */
+void *qht_lookup(struct qht *ht, const void *userp, uint32_t hash);
 
 /**
  * qht_remove - remove a pointer from the hash table
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index f42096a..d2b9411 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -280,7 +280,7 @@ struct tb_desc {
     uint32_t trace_vcpu_dstate;
 };
 
-static bool tb_cmp(const void *p, const void *d)
+static bool tb_lookup_cmp(const void *p, const void *d)
 {
     const TranslationBlock *tb = p;
     const struct tb_desc *desc = d;
@@ -325,7 +325,7 @@ TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
     phys_pc = get_page_addr_code(desc.env, pc);
     desc.phys_page1 = phys_pc & TARGET_PAGE_MASK;
     h = tb_hash_func(phys_pc, pc, flags, cf_mask, *cpu->trace_dstate);
-    return qht_lookup(&tb_ctx.htable, tb_cmp, &desc, h);
+    return qht_lookup_custom(&tb_ctx.htable, tb_lookup_cmp, &desc, h);
 }
 
 static inline TranslationBlock *tb_find(CPUState *cpu,
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index fe3388a..4ed402e 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -782,11 +782,25 @@ static inline void code_gen_alloc(size_t tb_size)
     qemu_mutex_init(&tb_ctx.tb_lock);
 }
 
+static bool tb_cmp(const void *ap, const void *bp)
+{
+    const TranslationBlock *a = ap;
+    const TranslationBlock *b = bp;
+
+    return a->pc == b->pc &&
+        a->cs_base == b->cs_base &&
+        a->flags == b->flags &&
+        (tb_cflags(a) & CF_HASH_MASK) == (tb_cflags(b) & CF_HASH_MASK) &&
+        a->trace_vcpu_dstate == b->trace_vcpu_dstate &&
+        a->page_addr[0] == b->page_addr[0] &&
+        a->page_addr[1] == b->page_addr[1];
+}
+
 static void tb_htable_init(void)
 {
     unsigned int mode = QHT_MODE_AUTO_RESIZE;
 
-    qht_init(&tb_ctx.htable, CODE_GEN_HTABLE_SIZE, mode);
+    qht_init(&tb_ctx.htable, tb_cmp, CODE_GEN_HTABLE_SIZE, mode);
 }
 
 /* Must be called before using the QEMU cpus. 'tb_size' is the size
diff --git a/tests/qht-bench.c b/tests/qht-bench.c
index 4cabdfd..c94ac25 100644
--- a/tests/qht-bench.c
+++ b/tests/qht-bench.c
@@ -93,10 +93,10 @@ static void usage_complete(int argc, char *argv[])
     exit(-1);
 }
 
-static bool is_equal(const void *obj, const void *userp)
+static bool is_equal(const void *ap, const void *bp)
 {
-    const long *a = obj;
-    const long *b = userp;
+    const long *a = ap;
+    const long *b = bp;
 
     return *a == *b;
 }
@@ -150,7 +150,7 @@ static void do_rw(struct thread_info *info)
 
         p = &keys[info->r & (lookup_range - 1)];
         hash = h(*p);
-        read = qht_lookup(&ht, is_equal, p, hash);
+        read = qht_lookup(&ht, p, hash);
         if (read) {
             stats->rd++;
         } else {
@@ -162,7 +162,7 @@ static void do_rw(struct thread_info *info)
         if (info->write_op) {
             bool written = false;
 
-            if (qht_lookup(&ht, is_equal, p, hash) == NULL) {
+            if (qht_lookup(&ht, p, hash) == NULL) {
                 written = qht_insert(&ht, p, hash);
             }
             if (written) {
@@ -173,7 +173,7 @@ static void do_rw(struct thread_info *info)
         } else {
             bool removed = false;
 
-            if (qht_lookup(&ht, is_equal, p, hash)) {
+            if (qht_lookup(&ht, p, hash)) {
                 removed = qht_remove(&ht, p, hash);
             }
             if (removed) {
@@ -308,7 +308,7 @@ static void htable_init(void)
     }
 
     /* initialize the hash table */
-    qht_init(&ht, qht_n_elems, qht_mode);
+    qht_init(&ht, is_equal, qht_n_elems, qht_mode);
     assert(init_size <= init_range);
 
     pr_params();
diff --git a/tests/test-qht.c b/tests/test-qht.c
index 9b7423a..f8f2886 100644
--- a/tests/test-qht.c
+++ b/tests/test-qht.c
@@ -13,10 +13,10 @@
 static struct qht ht;
 static int32_t arr[N * 2];
 
-static bool is_equal(const void *obj, const void *userp)
+static bool is_equal(const void *ap, const void *bp)
 {
-    const int32_t *a = obj;
-    const int32_t *b = userp;
+    const int32_t *a = ap;
+    const int32_t *b = bp;
 
     return *a == *b;
 }
@@ -60,7 +60,12 @@ static void check(int a, int b, bool expected)
 
         val = i;
         hash = i;
-        p = qht_lookup(&ht, is_equal, &val, hash);
+        /* test both lookup variants; results should be the same */
+        if (i % 2) {
+            p = qht_lookup(&ht, &val, hash);
+        } else {
+            p = qht_lookup_custom(&ht, is_equal, &val, hash);
+        }
         g_assert_true(!!p == expected);
     }
     rcu_read_unlock();
@@ -102,7 +107,7 @@ static void qht_do_test(unsigned int mode, size_t init_entries)
     /* under KVM we might fetch stats from an uninitialized qht */
     check_n(0);
 
-    qht_init(&ht, 0, mode);
+    qht_init(&ht, is_equal, 0, mode);
 
     check_n(0);
     insert(0, N);
diff --git a/util/qht.c b/util/qht.c
index ff4d2e6..b69457d 100644
--- a/util/qht.c
+++ b/util/qht.c
@@ -351,11 +351,13 @@ static struct qht_map *qht_map_create(size_t n_buckets)
     return map;
 }
 
-void qht_init(struct qht *ht, size_t n_elems, unsigned int mode)
+void qht_init(struct qht *ht, qht_cmp_func_t cmp, size_t n_elems,
+              unsigned int mode)
 {
     struct qht_map *map;
     size_t n_buckets = qht_elems_to_buckets(n_elems);
 
+    ht->cmp = cmp;
     ht->mode = mode;
     qemu_mutex_init(&ht->lock);
     map = qht_map_create(n_buckets);
@@ -479,8 +481,8 @@ void *qht_lookup__slowpath(struct qht_bucket *b, qht_lookup_func_t func,
     return ret;
 }
 
-void *qht_lookup(struct qht *ht, qht_lookup_func_t func, const void *userp,
-                 uint32_t hash)
+void *qht_lookup_custom(struct qht *ht, qht_lookup_func_t func,
+                        const void *userp, uint32_t hash)
 {
     struct qht_bucket *b;
     struct qht_map *map;
@@ -502,6 +504,11 @@ void *qht_lookup(struct qht *ht, qht_lookup_func_t func, const void *userp,
     return qht_lookup__slowpath(b, func, userp, hash);
 }
 
+void *qht_lookup(struct qht *ht, const void *userp, uint32_t hash)
+{
+    return qht_lookup_custom(ht, ht->cmp, userp, hash);
+}
+
 /* call with head->lock held */
 static bool qht_insert__locked(struct qht *ht, struct qht_map *map,
                                struct qht_bucket *head, void *p, uint32_t hash,
-- 
2.7.4
