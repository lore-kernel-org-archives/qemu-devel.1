Received: from eggs.gnu.org ([2001:4830:134:3::10]:49218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzRPT-0001Jy-0E
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 14:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzRPQ-0001FU-UF
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 14:59:42 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55397)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fzRPQ-0001DQ-La
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 14:59:40 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 10 Sep 2018 14:58:58 -0400
Message-Id: <20180910185859.27917-12-cota@braap.org>
In-Reply-To: <20180910185859.27917-1-cota@braap.org>
References: <20180910185859.27917-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 11/12] qht: constify arguments to some
 internal functions
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

These functions do not modify their @ht or @bucket arguments.
Constify those arguments.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 util/qht.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/util/qht.c b/util/qht.c
index 4378775d68..aa51be3c52 100644
--- a/util/qht.c
+++ b/util/qht.c
@@ -268,7 +268,8 @@ static void qht_map_unlock_buckets(struct qht_map *map)
  * Call with at least a bucket lock held.
  * @map should be the value read before acquiring the lock (or locks).
  */
-static inline bool qht_map_is_stale__locked(struct qht *ht, struct qht_map *map)
+static inline bool qht_map_is_stale__locked(const struct qht *ht,
+                                            const struct qht_map *map)
 {
     return map != ht->map;
 }
@@ -337,12 +338,12 @@ struct qht_bucket *qht_bucket_lock__no_stale(struct qht *ht, uint32_t hash,
     return b;
 }
 
-static inline bool qht_map_needs_resize(struct qht_map *map)
+static inline bool qht_map_needs_resize(const struct qht_map *map)
 {
     return atomic_read(&map->n_added_buckets) > map->n_added_buckets_threshold;
 }
 
-static inline void qht_chain_destroy(struct qht_bucket *head)
+static inline void qht_chain_destroy(const struct qht_bucket *head)
 {
     struct qht_bucket *curr = head->next;
     struct qht_bucket *prev;
@@ -550,8 +551,11 @@ void *qht_lookup(const struct qht *ht, const void *userp, uint32_t hash)
     return qht_lookup_custom(ht, userp, hash, ht->cmp);
 }
 
-/* call with head->lock held */
-static void *qht_insert__locked(struct qht *ht, struct qht_map *map,
+/*
+ * call with head->lock held
+ * @ht is const since it is only used for ht->cmp()
+ */
+static void *qht_insert__locked(const struct qht *ht, struct qht_map *map,
                                 struct qht_bucket *head, void *p, uint32_t hash,
                                 bool *needs_resize)
 {
@@ -645,7 +649,7 @@ bool qht_insert(struct qht *ht, void *p, uint32_t hash, void **existing)
     return false;
 }
 
-static inline bool qht_entry_is_last(struct qht_bucket *b, int pos)
+static inline bool qht_entry_is_last(const struct qht_bucket *b, int pos)
 {
     if (pos == QHT_BUCKET_ENTRIES - 1) {
         if (b->next == NULL) {
-- 
2.17.1
