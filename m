Received: from eggs.gnu.org ([2001:4830:134:3::10]:50935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eqXzG-0004aY-9a
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 00:39:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eqXzC-0000Po-De
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 00:39:38 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:41993)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eqXzC-0000Ob-A2
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 00:39:34 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 27 Feb 2018 00:39:11 -0500
Message-Id: <1519709965-29833-3-git-send-email-cota@braap.org>
In-Reply-To: <1519709965-29833-1-git-send-email-cota@braap.org>
References: <1519709965-29833-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 02/16] qht: return existing entry when
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
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

The meaning of "existing" is now changed to "matches in hash and
ht->cmp result". This is saner than just checking the pointer value.

Note that we now return NULL on insertion success, or the existing
pointer on failure. We can do this because NULL pointers are not
allowed to be inserted in QHT.

Suggested-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qemu/qht.h |  7 ++++---
 tests/qht-bench.c  |  4 ++--
 tests/test-qht.c   |  5 ++++-
 util/qht.c         | 17 +++++++++--------
 4 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/include/qemu/qht.h b/include/qemu/qht.h
index dd512bf..c320cb6 100644
--- a/include/qemu/qht.h
+++ b/include/qemu/qht.h
@@ -77,10 +77,11 @@ void qht_destroy(struct qht *ht);
  * In case of successful operation, smp_wmb() is implied before the pointer is
  * inserted into the hash table.
  *
- * Returns true on success.
- * Returns false if the @p-@hash pair already exists in the hash table.
+ * On success, returns NULL.
+ * On failure, returns the pointer from an entry that is equivalent (i.e.
+ * ht->cmp matches and the hash is the same) to @p-@h.
  */
-bool qht_insert(struct qht *ht, void *p, uint32_t hash);
+void *qht_insert(struct qht *ht, void *p, uint32_t hash);
 
 /**
  * qht_lookup_custom - Look up a pointer using a custom comparison function.
diff --git a/tests/qht-bench.c b/tests/qht-bench.c
index c94ac25..2f88400 100644
--- a/tests/qht-bench.c
+++ b/tests/qht-bench.c
@@ -163,7 +163,7 @@ static void do_rw(struct thread_info *info)
             bool written = false;
 
             if (qht_lookup(&ht, p, hash) == NULL) {
-                written = qht_insert(&ht, p, hash);
+                written = !qht_insert(&ht, p, hash);
             }
             if (written) {
                 stats->in++;
@@ -322,7 +322,7 @@ static void htable_init(void)
             r = xorshift64star(r);
             p = &keys[r & (init_range - 1)];
             hash = h(*p);
-            if (qht_insert(&ht, p, hash)) {
+            if (qht_insert(&ht, p, hash) == NULL) {
                 break;
             }
             retries++;
diff --git a/tests/test-qht.c b/tests/test-qht.c
index f8f2886..7164ae4 100644
--- a/tests/test-qht.c
+++ b/tests/test-qht.c
@@ -27,11 +27,14 @@ static void insert(int a, int b)
 
     for (i = a; i < b; i++) {
         uint32_t hash;
+        void *existing;
 
         arr[i] = i;
         hash = i;
 
-        qht_insert(&ht, &arr[i], hash);
+        g_assert_true(!qht_insert(&ht, &arr[i], hash));
+        existing = qht_insert(&ht, &arr[i], hash);
+        g_assert_true(existing == &arr[i]);
     }
 }
 
diff --git a/util/qht.c b/util/qht.c
index dcb3ee1..f9f49a9 100644
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
@@ -577,12 +578,12 @@ static __attribute__((noinline)) void qht_grow_maybe(struct qht *ht)
     qemu_mutex_unlock(&ht->lock);
 }
 
-bool qht_insert(struct qht *ht, void *p, uint32_t hash)
+void *qht_insert(struct qht *ht, void *p, uint32_t hash)
 {
     struct qht_bucket *b;
     struct qht_map *map;
     bool needs_resize = false;
-    bool ret;
+    void *ret;
 
     /* NULL pointers are not supported */
     qht_debug_assert(p);
-- 
2.7.4
