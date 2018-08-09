Received: from eggs.gnu.org ([2001:4830:134:3::10]:60229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fnlF2-0005qD-OR
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:44:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fnlF0-0001JE-3P
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:44:40 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu,  9 Aug 2018 16:44:13 +0300
Message-Id: <20180809134413.30823-1-berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2] qcow2: Release dirty entries with
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
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

The cache-clean-interval option is used to periodically release unused
entries from the L2 and refcount caches. Dirty cache entries are left
untouched, even if they are otherwise valid candidates for removal.

This patch allows releasing those entries by flushing them to disk
first. This is a blocking operation, so we need to do it in coroutine
context.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cache.c | 26 ++++++++++++++++++++------
 block/qcow2.c       | 15 ++++++++++++---
 block/qcow2.h       |  2 +-
 3 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index d9dafa31e5..33207eca9b 100644
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
@@ -86,26 +88,36 @@ static void qcow2_cache_table_release(Qcow2Cache *c, int i, int num_tables)
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
+
+    bdrv_inc_in_flight(bs);
+
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
@@ -118,6 +130,8 @@ void qcow2_cache_clean_unused(Qcow2Cache *c)
     }
 
     c->cache_clean_lru_counter = c->lru_counter;
+
+    bdrv_dec_in_flight(bs);
 }
 
 Qcow2Cache *qcow2_cache_create(BlockDriverState *bs, int num_tables,
diff --git a/block/qcow2.c b/block/qcow2.c
index ec9e6238a0..2fcb41b12f 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -728,16 +728,25 @@ static const char *overlap_bool_option_names[QCOW2_OL_MAX_BITNR] = {
     [QCOW2_OL_BITMAP_DIRECTORY_BITNR] = QCOW2_OPT_OVERLAP_BITMAP_DIRECTORY,
 };
 
-static void cache_clean_timer_cb(void *opaque)
+static void coroutine_fn cache_co_clean_unused(void *opaque)
 {
     BlockDriverState *bs = opaque;
     BDRVQcow2State *s = bs->opaque;
-    qcow2_cache_clean_unused(s->l2_table_cache);
-    qcow2_cache_clean_unused(s->refcount_block_cache);
+
+    qemu_co_mutex_lock(&s->lock);
+    qcow2_cache_clean_unused(bs, s->l2_table_cache);
+    qcow2_cache_clean_unused(bs, s->refcount_block_cache);
+    qemu_co_mutex_unlock(&s->lock);
+
     timer_mod(s->cache_clean_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
               (int64_t) s->cache_clean_interval * 1000);
 }
 
+static void cache_clean_timer_cb(void *opaque)
+{
+    qemu_coroutine_enter(qemu_coroutine_create(cache_co_clean_unused, opaque));
+}
+
 static void cache_clean_timer_init(BlockDriverState *bs, AioContext *context)
 {
     BDRVQcow2State *s = bs->opaque;
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
