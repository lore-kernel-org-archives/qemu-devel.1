Received: from eggs.gnu.org ([2001:4830:134:3::10]:49151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzRPR-0001IA-5j
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 14:59:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzRPP-0001DV-8y
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 14:59:41 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46327)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fzRPO-0001Cu-VB
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 14:59:39 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 10 Sep 2018 14:58:57 -0400
Message-Id: <20180910185859.27917-11-cota@braap.org>
In-Reply-To: <20180910185859.27917-1-cota@braap.org>
References: <20180910185859.27917-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 10/12] qht: constify qht_statistics_init
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

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qemu/qht.h | 2 +-
 util/qht.c         | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/qemu/qht.h b/include/qemu/qht.h
index 2e2d6bca93..758c7ac6c8 100644
--- a/include/qemu/qht.h
+++ b/include/qemu/qht.h
@@ -211,7 +211,7 @@ void qht_iter_remove(struct qht *ht, qht_iter_bool_func_t func, void *userp);
  * When done with @stats, pass the struct to qht_statistics_destroy().
  * Failing to do this will leak memory.
  */
-void qht_statistics_init(struct qht *ht, struct qht_stats *stats);
+void qht_statistics_init(const struct qht *ht, struct qht_stats *stats);
 
 /**
  * qht_statistics_destroy - Destroy a &struct qht_stats
diff --git a/util/qht.c b/util/qht.c
index 020dfe6912..4378775d68 100644
--- a/util/qht.c
+++ b/util/qht.c
@@ -895,9 +895,9 @@ bool qht_resize(struct qht *ht, size_t n_elems)
 }
 
 /* pass @stats to qht_statistics_destroy() when done */
-void qht_statistics_init(struct qht *ht, struct qht_stats *stats)
+void qht_statistics_init(const struct qht *ht, struct qht_stats *stats)
 {
-    struct qht_map *map;
+    const struct qht_map *map;
     int i;
 
     map = atomic_rcu_read(&ht->map);
@@ -914,8 +914,8 @@ void qht_statistics_init(struct qht *ht, struct qht_stats *stats)
     stats->head_buckets = map->n_buckets;
 
     for (i = 0; i < map->n_buckets; i++) {
-        struct qht_bucket *head = &map->buckets[i];
-        struct qht_bucket *b;
+        const struct qht_bucket *head = &map->buckets[i];
+        const struct qht_bucket *b;
         unsigned int version;
         size_t buckets;
         size_t entries;
-- 
2.17.1
