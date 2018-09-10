Received: from eggs.gnu.org ([2001:4830:134:3::10]:49252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzRPV-0001MS-RR
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 14:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzRPQ-0001FI-Pb
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 14:59:43 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35481)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fzRPQ-0001Cr-Gh
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 14:59:40 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 10 Sep 2018 14:58:56 -0400
Message-Id: <20180910185859.27917-10-cota@braap.org>
In-Reply-To: <20180910185859.27917-1-cota@braap.org>
References: <20180910185859.27917-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 09/12] qht: constify qht_lookup
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

seqlock_read_begin takes a const param since c04649eeea
("seqlock: constify seqlock_read_begin", 2018-08-23), so
we can constify the entire lookup.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qemu/qht.h |  4 ++--
 util/qht.c         | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/qemu/qht.h b/include/qemu/qht.h
index 6484837487..2e2d6bca93 100644
--- a/include/qemu/qht.h
+++ b/include/qemu/qht.h
@@ -104,7 +104,7 @@ bool qht_insert(struct qht *ht, void *p, uint32_t hash, void **existing);
  * Returns the corresponding pointer when a match is found.
  * Returns NULL otherwise.
  */
-void *qht_lookup_custom(struct qht *ht, const void *userp, uint32_t hash,
+void *qht_lookup_custom(const struct qht *ht, const void *userp, uint32_t hash,
                         qht_lookup_func_t func);
 
 /**
@@ -115,7 +115,7 @@ void *qht_lookup_custom(struct qht *ht, const void *userp, uint32_t hash,
  *
  * Calls qht_lookup_custom() using @ht's default comparison function.
  */
-void *qht_lookup(struct qht *ht, const void *userp, uint32_t hash);
+void *qht_lookup(const struct qht *ht, const void *userp, uint32_t hash);
 
 /**
  * qht_remove - remove a pointer from the hash table
diff --git a/util/qht.c b/util/qht.c
index 3564a7e20f..020dfe6912 100644
--- a/util/qht.c
+++ b/util/qht.c
@@ -236,7 +236,7 @@ static inline void qht_head_init(struct qht_bucket *b)
 }
 
 static inline
-struct qht_bucket *qht_map_to_bucket(struct qht_map *map, uint32_t hash)
+struct qht_bucket *qht_map_to_bucket(const struct qht_map *map, uint32_t hash)
 {
     return &map->buckets[hash & (map->n_buckets - 1)];
 }
@@ -482,10 +482,10 @@ bool qht_reset_size(struct qht *ht, size_t n_elems)
 }
 
 static inline
-void *qht_do_lookup(struct qht_bucket *head, qht_lookup_func_t func,
+void *qht_do_lookup(const struct qht_bucket *head, qht_lookup_func_t func,
                     const void *userp, uint32_t hash)
 {
-    struct qht_bucket *b = head;
+    const struct qht_bucket *b = head;
     int i;
 
     do {
@@ -509,7 +509,7 @@ void *qht_do_lookup(struct qht_bucket *head, qht_lookup_func_t func,
 }
 
 static __attribute__((noinline))
-void *qht_lookup__slowpath(struct qht_bucket *b, qht_lookup_func_t func,
+void *qht_lookup__slowpath(const struct qht_bucket *b, qht_lookup_func_t func,
                            const void *userp, uint32_t hash)
 {
     unsigned int version;
@@ -522,11 +522,11 @@ void *qht_lookup__slowpath(struct qht_bucket *b, qht_lookup_func_t func,
     return ret;
 }
 
-void *qht_lookup_custom(struct qht *ht, const void *userp, uint32_t hash,
+void *qht_lookup_custom(const struct qht *ht, const void *userp, uint32_t hash,
                         qht_lookup_func_t func)
 {
-    struct qht_bucket *b;
-    struct qht_map *map;
+    const struct qht_bucket *b;
+    const struct qht_map *map;
     unsigned int version;
     void *ret;
 
@@ -545,7 +545,7 @@ void *qht_lookup_custom(struct qht *ht, const void *userp, uint32_t hash,
     return qht_lookup__slowpath(b, func, userp, hash);
 }
 
-void *qht_lookup(struct qht *ht, const void *userp, uint32_t hash)
+void *qht_lookup(const struct qht *ht, const void *userp, uint32_t hash)
 {
     return qht_lookup_custom(ht, userp, hash, ht->cmp);
 }
-- 
2.17.1
