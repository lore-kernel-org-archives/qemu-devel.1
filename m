Received: from eggs.gnu.org ([2001:4830:134:3::10]:36832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTXyS-0006qQ-0K
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:32:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTXyQ-0005hO-Ml
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:32:00 -0400
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:40832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTXyQ-0005h6-FK
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:31:58 -0400
Received: by mail-pg0-x22a.google.com with SMTP id w8-v6so330697pgp.7
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 12:31:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 14 Jun 2018 09:31:32 -1000
Message-Id: <20180614193147.29680-4-richard.henderson@linaro.org>
In-Reply-To: <20180614193147.29680-1-richard.henderson@linaro.org>
References: <20180614193147.29680-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/18] qht: return existing entry when
 qht_insert fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

The meaning of "existing" is now changed to "matches in hash and
ht->cmp result". This is saner than just checking the pointer value.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by:  Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/qht.h        |  7 +++++--
 accel/tcg/translate-all.c |  2 +-
 tests/qht-bench.c         |  4 ++--
 tests/test-qht.c          |  8 +++++++-
 util/qht.c                | 27 +++++++++++++++++----------
 5 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/include/qemu/qht.h b/include/qemu/qht.h
index 5f03a0f4cb..1fb9116fa0 100644
--- a/include/qemu/qht.h
+++ b/include/qemu/qht.h
@@ -70,6 +70,7 @@ void qht_destroy(struct qht *ht);
  * @ht: QHT to insert to
  * @p: pointer to be inserted
  * @hash: hash corresponding to @p
+ * @existing: address where the pointer to an existing entry can be copied to
  *
  * Attempting to insert a NULL @p is a bug.
  * Inserting the same pointer @p with different @hash values is a bug.
@@ -78,9 +79,11 @@ void qht_destroy(struct qht *ht);
  * inserted into the hash table.
  *
  * Returns true on success.
- * Returns false if the @p-@hash pair already exists in the hash table.
+ * Returns false if there is an existing entry in the table that is equivalent
+ * (i.e. ht->cmp matches and the hash is the same) to @p-@h. If @existing
+ * is !NULL, a pointer to this existing entry is copied to it.
  */
-bool qht_insert(struct qht *ht, void *p, uint32_t hash);
+bool qht_insert(struct qht *ht, void *p, uint32_t hash, void **existing);
 
 /**
  * qht_lookup_custom - Look up a pointer using a custom comparison function.
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index f39123bd5a..1695f8c352 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1242,7 +1242,7 @@ static void tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
     /* add in the hash table */
     h = tb_hash_func(phys_pc, tb->pc, tb->flags, tb->cflags & CF_HASH_MASK,
                      tb->trace_vcpu_dstate);
-    qht_insert(&tb_ctx.htable, tb, h);
+    qht_insert(&tb_ctx.htable, tb, h, NULL);
 
 #ifdef CONFIG_USER_ONLY
     if (DEBUG_TB_CHECK_GATE) {
diff --git a/tests/qht-bench.c b/tests/qht-bench.c
index c94ac25158..f492b3a20a 100644
--- a/tests/qht-bench.c
+++ b/tests/qht-bench.c
@@ -163,7 +163,7 @@ static void do_rw(struct thread_info *info)
             bool written = false;
 
             if (qht_lookup(&ht, p, hash) == NULL) {
-                written = qht_insert(&ht, p, hash);
+                written = qht_insert(&ht, p, hash, NULL);
             }
             if (written) {
                 stats->in++;
@@ -322,7 +322,7 @@ static void htable_init(void)
             r = xorshift64star(r);
             p = &keys[r & (init_range - 1)];
             hash = h(*p);
-            if (qht_insert(&ht, p, hash)) {
+            if (qht_insert(&ht, p, hash, NULL)) {
                 break;
             }
             retries++;
diff --git a/tests/test-qht.c b/tests/test-qht.c
index b069881342..dda6a067be 100644
--- a/tests/test-qht.c
+++ b/tests/test-qht.c
@@ -27,11 +27,17 @@ static void insert(int a, int b)
 
     for (i = a; i < b; i++) {
         uint32_t hash;
+        void *existing;
+        bool inserted;
 
         arr[i] = i;
         hash = i;
 
-        qht_insert(&ht, &arr[i], hash);
+        inserted = qht_insert(&ht, &arr[i], hash, NULL);
+        g_assert_true(inserted);
+        inserted = qht_insert(&ht, &arr[i], hash, &existing);
+        g_assert_false(inserted);
+        g_assert_true(existing == &arr[i]);
     }
 }
 
diff --git a/util/qht.c b/util/qht.c
index 8610ce3644..9d030e7b76 100644
--- a/util/qht.c
+++ b/util/qht.c
@@ -511,9 +511,9 @@ void *qht_lookup(struct qht *ht, const void *userp, uint32_t hash)
 }
 
 /* call with head->lock held */
-static bool qht_insert__locked(struct qht *ht, struct qht_map *map,
-                               struct qht_bucket *head, void *p, uint32_t hash,
-                               bool *needs_resize)
+static void *qht_insert__locked(struct qht *ht, struct qht_map *map,
+                                struct qht_bucket *head, void *p, uint32_t hash,
+                                bool *needs_resize)
 {
     struct qht_bucket *b = head;
     struct qht_bucket *prev = NULL;
@@ -523,8 +523,9 @@ static bool qht_insert__locked(struct qht *ht, struct qht_map *map,
     do {
         for (i = 0; i < QHT_BUCKET_ENTRIES; i++) {
             if (b->pointers[i]) {
-                if (unlikely(b->pointers[i] == p)) {
-                    return false;
+                if (unlikely(b->hashes[i] == hash &&
+                             ht->cmp(b->pointers[i], p))) {
+                    return b->pointers[i];
                 }
             } else {
                 goto found;
@@ -553,7 +554,7 @@ static bool qht_insert__locked(struct qht *ht, struct qht_map *map,
     atomic_set(&b->hashes[i], hash);
     atomic_set(&b->pointers[i], p);
     seqlock_write_end(&head->sequence);
-    return true;
+    return NULL;
 }
 
 static __attribute__((noinline)) void qht_grow_maybe(struct qht *ht)
@@ -577,25 +578,31 @@ static __attribute__((noinline)) void qht_grow_maybe(struct qht *ht)
     qemu_mutex_unlock(&ht->lock);
 }
 
-bool qht_insert(struct qht *ht, void *p, uint32_t hash)
+bool qht_insert(struct qht *ht, void *p, uint32_t hash, void **existing)
 {
     struct qht_bucket *b;
     struct qht_map *map;
     bool needs_resize = false;
-    bool ret;
+    void *prev;
 
     /* NULL pointers are not supported */
     qht_debug_assert(p);
 
     b = qht_bucket_lock__no_stale(ht, hash, &map);
-    ret = qht_insert__locked(ht, map, b, p, hash, &needs_resize);
+    prev = qht_insert__locked(ht, map, b, p, hash, &needs_resize);
     qht_bucket_debug__locked(b);
     qemu_spin_unlock(&b->lock);
 
     if (unlikely(needs_resize) && ht->mode & QHT_MODE_AUTO_RESIZE) {
         qht_grow_maybe(ht);
     }
-    return ret;
+    if (likely(prev == NULL)) {
+        return true;
+    }
+    if (existing) {
+        *existing = prev;
+    }
+    return false;
 }
 
 static inline bool qht_entry_is_last(struct qht_bucket *b, int pos)
-- 
2.17.1
