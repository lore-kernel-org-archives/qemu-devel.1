Received: from eggs.gnu.org ([2001:4830:134:3::10]:59334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fmgGY-0006tG-NC
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:13:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fmgGU-00011E-Mi
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 10:13:46 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Mon,  6 Aug 2018 17:13:22 +0300
Message-Id: <20180806141322.14427-1-berto@igalia.com>
Subject: [Qemu-devel] [PATCH] qcow2: Release dirty entries with
 cache-clean-interval
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

The cache-clean-interval option is used to periodically release unused
entries from the L2 and refcount caches. Dirty cache entries are left
untouched, even if they are otherwise valid candidates for removal.

This patch allows releasing those entries by flushing them to disk
first.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cache.c | 21 +++++++++++++++------
 block/qcow2.c       |  4 ++--
 block/qcow2.h       |  2 +-
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index d9dafa31e5..0812164e46 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -46,6 +46,8 @@ struct Qcow2Cache {
     uint64_t                cache_clean_lru_counter;
 };
 
+static int qcow2_cache_entry_flush(BlockDriverState *bs, Qcow2Cache *c, int i);
+
 static inline void *qcow2_cache_get_table_addr(Qcow2Cache *c, int table)
 {
     return (uint8_t *) c->table_array + (size_t) table * c->table_size;
@@ -86,26 +88,33 @@ static void qcow2_cache_table_release(Qcow2Cache *c, int i, int num_tables)
 #endif
 }
 
-static inline bool can_clean_entry(Qcow2Cache *c, int i)
+static inline bool can_clean_entry(BlockDriverState *bs, Qcow2Cache *c, int i)
 {
     Qcow2CachedTable *t = &c->entries[i];
-    return t->ref == 0 && !t->dirty && t->offset != 0 &&
-        t->lru_counter <= c->cache_clean_lru_counter;
+    if (t->ref || !t->offset || t->lru_counter > c->cache_clean_lru_counter) {
+        return false;
+    }
+
+    if (qcow2_cache_entry_flush(bs, c, i) < 0) {
+        return false;
+    }
+
+    return true;
 }
 
-void qcow2_cache_clean_unused(Qcow2Cache *c)
+void qcow2_cache_clean_unused(BlockDriverState *bs, Qcow2Cache *c)
 {
     int i = 0;
     while (i < c->size) {
         int to_clean = 0;
 
         /* Skip the entries that we don't need to clean */
-        while (i < c->size && !can_clean_entry(c, i)) {
+        while (i < c->size && !can_clean_entry(bs, c, i)) {
             i++;
         }
 
         /* And count how many we can clean in a row */
-        while (i < c->size && can_clean_entry(c, i)) {
+        while (i < c->size && can_clean_entry(bs, c, i)) {
             c->entries[i].offset = 0;
             c->entries[i].lru_counter = 0;
             i++;
diff --git a/block/qcow2.c b/block/qcow2.c
index ec9e6238a0..f44ce85a5b 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -732,8 +732,8 @@ static void cache_clean_timer_cb(void *opaque)
 {
     BlockDriverState *bs = opaque;
     BDRVQcow2State *s = bs->opaque;
-    qcow2_cache_clean_unused(s->l2_table_cache);
-    qcow2_cache_clean_unused(s->refcount_block_cache);
+    qcow2_cache_clean_unused(bs, s->l2_table_cache);
+    qcow2_cache_clean_unused(bs, s->refcount_block_cache);
     timer_mod(s->cache_clean_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
               (int64_t) s->cache_clean_interval * 1000);
 }
diff --git a/block/qcow2.h b/block/qcow2.h
index 81b844e936..e8b390ba4b 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -659,7 +659,7 @@ int qcow2_cache_set_dependency(BlockDriverState *bs, Qcow2Cache *c,
     Qcow2Cache *dependency);
 void qcow2_cache_depends_on_flush(Qcow2Cache *c);
 
-void qcow2_cache_clean_unused(Qcow2Cache *c);
+void qcow2_cache_clean_unused(BlockDriverState *bs, Qcow2Cache *c);
 int qcow2_cache_empty(BlockDriverState *bs, Qcow2Cache *c);
 
 int qcow2_cache_get(BlockDriverState *bs, Qcow2Cache *c, uint64_t offset,
-- 
2.11.0
