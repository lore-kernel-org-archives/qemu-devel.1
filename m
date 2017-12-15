Received: from eggs.gnu.org ([2001:4830:134:3::10]:55501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVG-0000Wo-VJ
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVC-0003GZ-0m
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:14 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 15 Dec 2017 13:53:30 +0100
Message-Id: <97419f591a3aeb5c69c9b24a495f3e603cacb32f.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 02/32] qcow2: Add table size field to
 Qcow2Cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>

The table size in the qcow2 cache is currently equal to the cluster
size. This doesn't allow us to use the cache memory efficiently,
particularly with large cluster sizes, so we need to be able to have
smaller cache tables that are independent from the cluster size. This
patch adds a new field to Qcow2Cache that we can use instead of the
cluster size.

The current table size is still being initialized to the cluster size,
so there are no semantic changes yet, but this patch will allow us to
prepare the rest of the code and simplify a few function calls.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cache.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index c48ffebd8f..d068fed98e 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -39,6 +39,7 @@ struct Qcow2Cache {
     Qcow2CachedTable       *entries;
     struct Qcow2Cache      *depends;
     int                     size;
+    int                     table_size;
     bool                    depends_on_flush;
     void                   *table_array;
     uint64_t                lru_counter;
@@ -48,17 +49,15 @@ struct Qcow2Cache {
 static inline void *qcow2_cache_get_table_addr(BlockDriverState *bs,
                     Qcow2Cache *c, int table)
 {
-    BDRVQcow2State *s = bs->opaque;
-    return (uint8_t *) c->table_array + (size_t) table * s->cluster_size;
+    return (uint8_t *) c->table_array + (size_t) table * c->table_size;
 }
 
 static inline int qcow2_cache_get_table_idx(BlockDriverState *bs,
                   Qcow2Cache *c, void *table)
 {
-    BDRVQcow2State *s = bs->opaque;
     ptrdiff_t table_offset = (uint8_t *) table - (uint8_t *) c->table_array;
-    int idx = table_offset / s->cluster_size;
-    assert(idx >= 0 && idx < c->size && table_offset % s->cluster_size == 0);
+    int idx = table_offset / c->table_size;
+    assert(idx >= 0 && idx < c->size && table_offset % c->table_size == 0);
     return idx;
 }
 
@@ -79,10 +78,9 @@ static void qcow2_cache_table_release(BlockDriverState *bs, Qcow2Cache *c,
 {
 /* Using MADV_DONTNEED to discard memory is a Linux-specific feature */
 #ifdef CONFIG_LINUX
-    BDRVQcow2State *s = bs->opaque;
     void *t = qcow2_cache_get_table_addr(bs, c, i);
     int align = getpagesize();
-    size_t mem_size = (size_t) s->cluster_size * num_tables;
+    size_t mem_size = (size_t) c->table_size * num_tables;
     size_t offset = QEMU_ALIGN_UP((uintptr_t) t, align) - (uintptr_t) t;
     size_t length = QEMU_ALIGN_DOWN(mem_size - offset, align);
     if (mem_size > offset && length > 0) {
@@ -132,9 +130,10 @@ Qcow2Cache *qcow2_cache_create(BlockDriverState *bs, int num_tables)
 
     c = g_new0(Qcow2Cache, 1);
     c->size = num_tables;
+    c->table_size = s->cluster_size;
     c->entries = g_try_new0(Qcow2CachedTable, num_tables);
     c->table_array = qemu_try_blockalign(bs->file->bs,
-                                         (size_t) num_tables * s->cluster_size);
+                                         (size_t) num_tables * c->table_size);
 
     if (!c->entries || !c->table_array) {
         qemu_vfree(c->table_array);
@@ -203,13 +202,13 @@ static int qcow2_cache_entry_flush(BlockDriverState *bs, Qcow2Cache *c, int i)
 
     if (c == s->refcount_block_cache) {
         ret = qcow2_pre_write_overlap_check(bs, QCOW2_OL_REFCOUNT_BLOCK,
-                c->entries[i].offset, s->cluster_size);
+                c->entries[i].offset, c->table_size);
     } else if (c == s->l2_table_cache) {
         ret = qcow2_pre_write_overlap_check(bs, QCOW2_OL_ACTIVE_L2,
-                c->entries[i].offset, s->cluster_size);
+                c->entries[i].offset, c->table_size);
     } else {
         ret = qcow2_pre_write_overlap_check(bs, 0,
-                c->entries[i].offset, s->cluster_size);
+                c->entries[i].offset, c->table_size);
     }
 
     if (ret < 0) {
@@ -223,7 +222,7 @@ static int qcow2_cache_entry_flush(BlockDriverState *bs, Qcow2Cache *c, int i)
     }
 
     ret = bdrv_pwrite(bs->file, c->entries[i].offset,
-                      qcow2_cache_get_table_addr(bs, c, i), s->cluster_size);
+                      qcow2_cache_get_table_addr(bs, c, i), c->table_size);
     if (ret < 0) {
         return ret;
     }
@@ -331,7 +330,7 @@ static int qcow2_cache_do_get(BlockDriverState *bs, Qcow2Cache *c,
     trace_qcow2_cache_get(qemu_coroutine_self(), c == s->l2_table_cache,
                           offset, read_from_disk);
 
-    if (offset_into_cluster(s, offset)) {
+    if (offset & (c->table_size - 1)) {
         qcow2_signal_corruption(bs, true, -1, -1, "Cannot get entry from %s "
                                 "cache: Offset %#" PRIx64 " is unaligned",
                                 qcow2_cache_get_name(s, c), offset);
@@ -339,7 +338,7 @@ static int qcow2_cache_do_get(BlockDriverState *bs, Qcow2Cache *c,
     }
 
     /* Check if the table is already cached */
-    i = lookup_index = (offset / s->cluster_size * 4) % c->size;
+    i = lookup_index = (offset / c->table_size * 4) % c->size;
     do {
         const Qcow2CachedTable *t = &c->entries[i];
         if (t->offset == offset) {
@@ -380,7 +379,7 @@ static int qcow2_cache_do_get(BlockDriverState *bs, Qcow2Cache *c,
 
         ret = bdrv_pread(bs->file, offset,
                          qcow2_cache_get_table_addr(bs, c, i),
-                         s->cluster_size);
+                         c->table_size);
         if (ret < 0) {
             return ret;
         }
-- 
2.11.0
