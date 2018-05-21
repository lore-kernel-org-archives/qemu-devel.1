Received: from eggs.gnu.org ([2001:4830:134:3::10]:57823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fKuOt-0002eD-4v
	for qemu-devel@nongnu.org; Mon, 21 May 2018 19:39:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fKuOo-0005Wp-J0
	for qemu-devel@nongnu.org; Mon, 21 May 2018 19:39:35 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58847)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fKuOo-0005Uo-EV
	for qemu-devel@nongnu.org; Mon, 21 May 2018 19:39:30 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 21 May 2018 19:39:11 -0400
Message-Id: <1526945967-9687-2-git-send-email-cota@braap.org>
In-Reply-To: <1526945967-9687-1-git-send-email-cota@braap.org>
References: <1526945967-9687-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 01/17] qht: require a default comparison
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
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

qht_lookup now uses the default cmp function. qht_lookup_custom is defined
to retain the old behaviour, that is a cmp function is explicitly provided.

qht_insert will gain use of the default cmp in the next patch.

Note that we move qht_lookup_custom's @func to be the last argument,
which makes the new qht_lookup as simple as possible.
Instead of this (i.e. keeping @func 2nd):
0000000000010750 <qht_lookup>:
   10750:       89 d1                   mov    %edx,%ecx
   10752:       48 89 f2                mov    %rsi,%rdx
   10755:       48 8b 77 08             mov    0x8(%rdi),%rsi
   10759:       e9 22 ff ff ff          jmpq   10680 <qht_lookup_custom>
   1075e:       66 90                   xchg   %ax,%ax

We get:
0000000000010740 <qht_lookup>:
   10740:       48 8b 4f 08             mov    0x8(%rdi),%rcx
   10744:       e9 37 ff ff ff          jmpq   10680 <qht_lookup_custom>
   10749:       0f 1f 80 00 00 00 00    nopl   0x0(%rax)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qemu/qht.h        | 25 ++++++++++++++++++++-----
 accel/tcg/cpu-exec.c      |  4 ++--
 accel/tcg/translate-all.c | 16 +++++++++++++++-
 tests/qht-bench.c         | 14 +++++++-------
 tests/test-qht.c          | 15 ++++++++++-----
 util/qht.c                | 14 +++++++++++---
 6 files changed, 65 insertions(+), 23 deletions(-)

diff --git a/include/qemu/qht.h b/include/qemu/qht.h
index 531aa95..5f03a0f 100644
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
@@ -78,11 +83,11 @@ void qht_destroy(struct qht *ht);
 bool qht_insert(struct qht *ht, void *p, uint32_t hash);
 
 /**
- * qht_lookup - Look up a pointer in a QHT
+ * qht_lookup_custom - Look up a pointer using a custom comparison function.
  * @ht: QHT to be looked up
- * @func: function to compare existing pointers against @userp
  * @userp: pointer to pass to @func
  * @hash: hash of the pointer to be looked up
+ * @func: function to compare existing pointers against @userp
  *
  * Needs to be called under an RCU read-critical section.
  *
@@ -94,8 +99,18 @@ bool qht_insert(struct qht *ht, void *p, uint32_t hash);
  * Returns the corresponding pointer when a match is found.
  * Returns NULL otherwise.
  */
-void *qht_lookup(struct qht *ht, qht_lookup_func_t func, const void *userp,
-                 uint32_t hash);
+void *qht_lookup_custom(struct qht *ht, const void *userp, uint32_t hash,
+                        qht_lookup_func_t func);
+
+/**
+ * qht_lookup - Look up a pointer in a QHT
+ * @ht: QHT to be looked up
+ * @userp: pointer to pass to the comparison function
+ * @hash: hash of the pointer to be looked up
+ *
+ * Calls qht_lookup_custom() using @ht's default comparison function.
+ */
+void *qht_lookup(struct qht *ht, const void *userp, uint32_t hash);
 
 /**
  * qht_remove - remove a pointer from the hash table
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 0b154cc..aefc682 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -296,7 +296,7 @@ struct tb_desc {
     uint32_t trace_vcpu_dstate;
 };
 
-static bool tb_cmp(const void *p, const void *d)
+static bool tb_lookup_cmp(const void *p, const void *d)
 {
     const TranslationBlock *tb = p;
     const struct tb_desc *desc = d;
@@ -341,7 +341,7 @@ TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
     phys_pc = get_page_addr_code(desc.env, pc);
     desc.phys_page1 = phys_pc & TARGET_PAGE_MASK;
     h = tb_hash_func(phys_pc, pc, flags, cf_mask, *cpu->trace_dstate);
-    return qht_lookup(&tb_ctx.htable, tb_cmp, &desc, h);
+    return qht_lookup_custom(&tb_ctx.htable, &desc, h, tb_lookup_cmp);
 }
 
 void tb_set_jmp_target(TranslationBlock *tb, int n, uintptr_t addr)
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 732c919..5b7b91d 100644
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
index 9b7423a..b069881 100644
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
+            p = qht_lookup_custom(&ht, &val, hash, is_equal);
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
index ff4d2e6..8610ce3 100644
--- a/util/qht.c
+++ b/util/qht.c
@@ -351,11 +351,14 @@ static struct qht_map *qht_map_create(size_t n_buckets)
     return map;
 }
 
-void qht_init(struct qht *ht, size_t n_elems, unsigned int mode)
+void qht_init(struct qht *ht, qht_cmp_func_t cmp, size_t n_elems,
+              unsigned int mode)
 {
     struct qht_map *map;
     size_t n_buckets = qht_elems_to_buckets(n_elems);
 
+    g_assert(cmp);
+    ht->cmp = cmp;
     ht->mode = mode;
     qemu_mutex_init(&ht->lock);
     map = qht_map_create(n_buckets);
@@ -479,8 +482,8 @@ void *qht_lookup__slowpath(struct qht_bucket *b, qht_lookup_func_t func,
     return ret;
 }
 
-void *qht_lookup(struct qht *ht, qht_lookup_func_t func, const void *userp,
-                 uint32_t hash)
+void *qht_lookup_custom(struct qht *ht, const void *userp, uint32_t hash,
+                        qht_lookup_func_t func)
 {
     struct qht_bucket *b;
     struct qht_map *map;
@@ -502,6 +505,11 @@ void *qht_lookup(struct qht *ht, qht_lookup_func_t func, const void *userp,
     return qht_lookup__slowpath(b, func, userp, hash);
 }
 
+void *qht_lookup(struct qht *ht, const void *userp, uint32_t hash)
+{
+    return qht_lookup_custom(ht, userp, hash, ht->cmp);
+}
+
 /* call with head->lock held */
 static bool qht_insert__locked(struct qht *ht, struct qht_map *map,
                                struct qht_bucket *head, void *p, uint32_t hash,
-- 
2.7.4
