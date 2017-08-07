Received: from eggs.gnu.org ([2001:4830:134:3::10]:49201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJE-0007Y7-QH
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIw-000411-S5
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:08 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:32 +0200
Message-Id: <1502117160-24655-29-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 28/56] block: Widen dirty bitmap
 granularity to uint64_t for safety
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, quintela@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

Block dirty bitmaps represent granularity in bytes as uint32_t.  It
must be a power of two and a multiple of BDRV_SECTOR_SIZE.

The trouble with uint32_t is computations like this one in
mirror_do_read():

    uint64_t max_bytes;

    max_bytes = s->granularity * s->max_iov;

The operands of * are uint32_t and int, so the product is computed in
uint32_t (assuming 32 bit int), then zero-extended to uint64_t.

Since granularity is generally combined with 64 bit file offsets, it's
best to make it 64 bits, too.  Less opportunity to screw up.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block.c                      |  2 +-
 block/backup.c               |  2 +-
 block/dirty-bitmap.c         | 19 +++++++------------
 block/mirror.c               |  6 +++---
 block/qcow2-bitmap.c         | 18 +++++++++---------
 block/qcow2.h                |  2 +-
 blockdev.c                   |  6 +++---
 include/block/block.h        |  2 +-
 include/block/block_int.h    |  4 ++--
 include/block/dirty-bitmap.h |  7 +++----
 qapi/block-core.json         |  8 ++++----
 11 files changed, 35 insertions(+), 41 deletions(-)

diff --git a/block.c b/block.c
index 04cce0d..fe4b089 100644
--- a/block.c
+++ b/block.c
@@ -4922,7 +4922,7 @@ void bdrv_del_child(BlockDriverState *parent_bs, BdrvChild *child, Error **errp)
 }
 
 bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
-                                     uint32_t granularity, Error **errp)
+                                     uint64_t granularity, Error **errp)
 {
     BlockDriver *drv = bs->drv;
 
diff --git a/block/backup.c b/block/backup.c
index 504a089..a37c944 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -363,7 +363,7 @@ static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
     bool error_is_read;
     int ret = 0;
     int clusters_per_iter;
-    uint32_t granularity;
+    uint64_t granularity;
     int64_t offset;
     int64_t cluster;
     int64_t end;
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 5b1699c..c0b5952 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -109,13 +109,13 @@ void bdrv_dirty_bitmap_make_anon(BdrvDirtyBitmap *bitmap)
 
 /* Called with BQL taken.  */
 BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverState *bs,
-                                          uint32_t granularity,
+                                          uint64_t granularity,
                                           const char *name,
                                           Error **errp)
 {
     int64_t bitmap_size;
     BdrvDirtyBitmap *bitmap;
-    uint32_t sector_granularity;
+    uint64_t sector_granularity;
 
     assert((granularity & (granularity - 1)) == 0);
 
@@ -133,7 +133,7 @@ BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverState *bs,
     }
     bitmap = g_new0(BdrvDirtyBitmap, 1);
     bitmap->mutex = &bs->dirty_bitmap_mutex;
-    bitmap->bitmap = hbitmap_alloc(bitmap_size, ctz32(sector_granularity));
+    bitmap->bitmap = hbitmap_alloc(bitmap_size, ctz64(sector_granularity));
     bitmap->size = bitmap_size;
     bitmap->name = g_strdup(name);
     bitmap->disabled = false;
@@ -178,7 +178,7 @@ int bdrv_dirty_bitmap_get_meta_locked(BlockDriverState *bs,
                                       int nb_sectors)
 {
     uint64_t i;
-    int sectors_per_bit = 1 << hbitmap_granularity(bitmap->meta);
+    uint64_t sectors_per_bit = 1ull << hbitmap_granularity(bitmap->meta);
 
     /* To optimize: we can make hbitmap to internally check the range in a
      * coarse level, or at least do it word by word. */
@@ -491,10 +491,10 @@ int bdrv_get_dirty_locked(BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
  * but clamped between [4K, 64K]. Defaults to 64K in the case that there
  * is no cluster size information available.
  */
-uint32_t bdrv_get_default_bitmap_granularity(BlockDriverState *bs)
+uint64_t bdrv_get_default_bitmap_granularity(BlockDriverState *bs)
 {
     BlockDriverInfo bdi;
-    uint32_t granularity;
+    uint64_t granularity;
 
     if (bdrv_get_info(bs, &bdi) >= 0 && bdi.cluster_size > 0) {
         granularity = MAX(4096, bdi.cluster_size);
@@ -506,16 +506,11 @@ uint32_t bdrv_get_default_bitmap_granularity(BlockDriverState *bs)
     return granularity;
 }
 
-uint32_t bdrv_dirty_bitmap_granularity(const BdrvDirtyBitmap *bitmap)
+uint64_t bdrv_dirty_bitmap_granularity(const BdrvDirtyBitmap *bitmap)
 {
     return BDRV_SECTOR_SIZE << hbitmap_granularity(bitmap->bitmap);
 }
 
-uint32_t bdrv_dirty_bitmap_meta_granularity(BdrvDirtyBitmap *bitmap)
-{
-    return BDRV_SECTOR_SIZE << hbitmap_granularity(bitmap->meta);
-}
-
 BdrvDirtyBitmapIter *bdrv_dirty_iter_new(BdrvDirtyBitmap *bitmap,
                                          uint64_t first_sector)
 {
diff --git a/block/mirror.c b/block/mirror.c
index 14c34e9..37a8744 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -53,7 +53,7 @@ typedef struct MirrorBlockJob {
     BlockdevOnError on_source_error, on_target_error;
     bool synced;
     bool should_complete;
-    int64_t granularity;
+    uint64_t granularity;
     size_t buf_size;
     int64_t bdev_length;
     unsigned long *cow_bitmap;
@@ -1124,7 +1124,7 @@ static BlockDriver bdrv_mirror_top = {
 static void mirror_start_job(const char *job_id, BlockDriverState *bs,
                              int creation_flags, BlockDriverState *target,
                              const char *replaces, int64_t speed,
-                             uint32_t granularity, int64_t buf_size,
+                             uint64_t granularity, int64_t buf_size,
                              BlockMirrorBackingMode backing_mode,
                              BlockdevOnError on_source_error,
                              BlockdevOnError on_target_error,
@@ -1287,7 +1287,7 @@ fail:
 
 void mirror_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *target, const char *replaces,
-                  int64_t speed, uint32_t granularity, int64_t buf_size,
+                  int64_t speed, uint64_t granularity, int64_t buf_size,
                   MirrorSyncMode mode, BlockMirrorBackingMode backing_mode,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index e8d3bdb..356772c 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -147,11 +147,11 @@ static int check_table_entry(uint64_t entry, int cluster_size)
 
 static int check_constraints_on_bitmap(BlockDriverState *bs,
                                        const char *name,
-                                       uint32_t granularity,
+                                       uint64_t granularity,
                                        Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
-    int granularity_bits = ctz32(granularity);
+    int granularity_bits = ctz64(granularity);
     int64_t len = bdrv_getlength(bs);
 
     assert(granularity > 0);
@@ -274,10 +274,10 @@ static int free_bitmap_clusters(BlockDriverState *bs, Qcow2BitmapTable *tb)
 static uint64_t sectors_covered_by_bitmap_cluster(const BDRVQcow2State *s,
                                                   const BdrvDirtyBitmap *bitmap)
 {
-    uint32_t sector_granularity =
+    uint64_t sector_granularity =
             bdrv_dirty_bitmap_granularity(bitmap) >> BDRV_SECTOR_BITS;
 
-    return (uint64_t)sector_granularity * (s->cluster_size << 3);
+    return sector_granularity * (s->cluster_size << 3);
 }
 
 /* load_bitmap_data
@@ -342,7 +342,7 @@ static BdrvDirtyBitmap *load_bitmap(BlockDriverState *bs,
 {
     int ret;
     uint64_t *bitmap_table = NULL;
-    uint32_t granularity;
+    uint64_t granularity;
     BdrvDirtyBitmap *bitmap = NULL;
 
     if (bm->flags & BME_FLAG_IN_USE) {
@@ -358,7 +358,7 @@ static BdrvDirtyBitmap *load_bitmap(BlockDriverState *bs,
         goto fail;
     }
 
-    granularity = 1U << bm->granularity_bits;
+    granularity = 1ULL << bm->granularity_bits;
     bitmap = bdrv_create_dirty_bitmap(bs, granularity, bm->name, errp);
     if (bitmap == NULL) {
         goto fail;
@@ -1321,7 +1321,7 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
          bitmap = bdrv_dirty_bitmap_next(bs, bitmap))
     {
         const char *name = bdrv_dirty_bitmap_name(bitmap);
-        uint32_t granularity = bdrv_dirty_bitmap_granularity(bitmap);
+        uint64_t granularity = bdrv_dirty_bitmap_granularity(bitmap);
         Qcow2Bitmap *bm;
 
         if (!bdrv_dirty_bitmap_get_persistance(bitmap) ||
@@ -1364,7 +1364,7 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
             QSIMPLEQ_INSERT_TAIL(&drop_tables, tb, entry);
         }
         bm->flags = bdrv_dirty_bitmap_get_autoload(bitmap) ? BME_FLAG_AUTO : 0;
-        bm->granularity_bits = ctz32(bdrv_dirty_bitmap_granularity(bitmap));
+        bm->granularity_bits = ctz64(bdrv_dirty_bitmap_granularity(bitmap));
         bm->dirty_bitmap = bitmap;
     }
 
@@ -1436,7 +1436,7 @@ int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp)
 
 bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
                                       const char *name,
-                                      uint32_t granularity,
+                                      uint64_t granularity,
                                       Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
diff --git a/block/qcow2.h b/block/qcow2.h
index 0d7043e..6a7ca09 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -659,7 +659,7 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
 int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
 bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
                                       const char *name,
-                                      uint32_t granularity,
+                                      uint64_t granularity,
                                       Error **errp);
 void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
                                           const char *name,
diff --git a/blockdev.c b/blockdev.c
index 02cd69b..960c5be 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2708,7 +2708,7 @@ out:
 }
 
 void qmp_block_dirty_bitmap_add(const char *node, const char *name,
-                                bool has_granularity, uint32_t granularity,
+                                bool has_granularity, uint64_t granularity,
                                 bool has_persistent, bool persistent,
                                 bool has_autoload, bool autoload,
                                 Error **errp)
@@ -3401,7 +3401,7 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
                                    enum MirrorSyncMode sync,
                                    BlockMirrorBackingMode backing_mode,
                                    bool has_speed, int64_t speed,
-                                   bool has_granularity, uint32_t granularity,
+                                   bool has_granularity, uint64_t granularity,
                                    bool has_buf_size, int64_t buf_size,
                                    bool has_on_source_error,
                                    BlockdevOnError on_source_error,
@@ -3617,7 +3617,7 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
                          bool has_replaces, const char *replaces,
                          MirrorSyncMode sync,
                          bool has_speed, int64_t speed,
-                         bool has_granularity, uint32_t granularity,
+                         bool has_granularity, uint64_t granularity,
                          bool has_buf_size, int64_t buf_size,
                          bool has_on_source_error,
                          BlockdevOnError on_source_error,
diff --git a/include/block/block.h b/include/block/block.h
index 34770bb..3a4e980 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -620,6 +620,6 @@ void bdrv_add_child(BlockDriverState *parent, BlockDriverState *child,
 void bdrv_del_child(BlockDriverState *parent, BdrvChild *child, Error **errp);
 
 bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
-                                     uint32_t granularity, Error **errp);
+                                     uint64_t granularity, Error **errp);
 
 #endif
diff --git a/include/block/block_int.h b/include/block/block_int.h
index d4f4ea7..c09076e 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -392,7 +392,7 @@ struct BlockDriver {
     int (*bdrv_reopen_bitmaps_rw)(BlockDriverState *bs, Error **errp);
     bool (*bdrv_can_store_new_dirty_bitmap)(BlockDriverState *bs,
                                             const char *name,
-                                            uint32_t granularity,
+                                            uint64_t granularity,
                                             Error **errp);
     void (*bdrv_remove_persistent_dirty_bitmap)(BlockDriverState *bs,
                                                 const char *name,
@@ -896,7 +896,7 @@ void commit_active_start(const char *job_id, BlockDriverState *bs,
  */
 void mirror_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *target, const char *replaces,
-                  int64_t speed, uint32_t granularity, int64_t buf_size,
+                  int64_t speed, uint64_t granularity, int64_t buf_size,
                   MirrorSyncMode mode, BlockMirrorBackingMode backing_mode,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index d7e0f61..9058cef 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -5,7 +5,7 @@
 #include "qemu/hbitmap.h"
 
 BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverState *bs,
-                                          uint32_t granularity,
+                                          uint64_t granularity,
                                           const char *name,
                                           Error **errp);
 void bdrv_create_meta_dirty_bitmap(BdrvDirtyBitmap *bitmap,
@@ -32,9 +32,8 @@ void bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
 void bdrv_disable_dirty_bitmap(BdrvDirtyBitmap *bitmap);
 void bdrv_enable_dirty_bitmap(BdrvDirtyBitmap *bitmap);
 BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDriverState *bs);
-uint32_t bdrv_get_default_bitmap_granularity(BlockDriverState *bs);
-uint32_t bdrv_dirty_bitmap_granularity(const BdrvDirtyBitmap *bitmap);
-uint32_t bdrv_dirty_bitmap_meta_granularity(BdrvDirtyBitmap *bitmap);
+uint64_t bdrv_get_default_bitmap_granularity(BlockDriverState *bs);
+uint64_t bdrv_dirty_bitmap_granularity(const BdrvDirtyBitmap *bitmap);
 bool bdrv_dirty_bitmap_enabled(BdrvDirtyBitmap *bitmap);
 bool bdrv_dirty_bitmap_frozen(BdrvDirtyBitmap *bitmap);
 const char *bdrv_dirty_bitmap_name(const BdrvDirtyBitmap *bitmap);
diff --git a/qapi/block-core.json b/qapi/block-core.json
index bc8e5b6..1c4a08d 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -418,7 +418,7 @@
 # Since: 1.3
 ##
 { 'struct': 'BlockDirtyInfo',
-  'data': {'*name': 'str', 'count': 'int', 'granularity': 'uint32',
+  'data': {'*name': 'str', 'count': 'int', 'granularity': 'size',
            'status': 'DirtyBitmapStatus'} }
 
 ##
@@ -1532,7 +1532,7 @@
   'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
             '*format': 'str', '*node-name': 'str', '*replaces': 'str',
             'sync': 'MirrorSyncMode', '*mode': 'NewImageMode',
-            '*speed': 'int', '*granularity': 'uint32',
+            '*speed': 'int', '*granularity': 'size',
             '*buf-size': 'int', '*on-source-error': 'BlockdevOnError',
             '*on-target-error': 'BlockdevOnError',
             '*unmap': 'bool' } }
@@ -1571,7 +1571,7 @@
 # Since: 2.4
 ##
 { 'struct': 'BlockDirtyBitmapAdd',
-  'data': { 'node': 'str', 'name': 'str', '*granularity': 'uint32',
+  'data': { 'node': 'str', 'name': 'str', '*granularity': 'size',
             '*persistent': 'bool', '*autoload': 'bool' } }
 
 ##
@@ -1731,7 +1731,7 @@
   'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
             '*replaces': 'str',
             'sync': 'MirrorSyncMode',
-            '*speed': 'int', '*granularity': 'uint32',
+            '*speed': 'int', '*granularity': 'size',
             '*buf-size': 'int', '*on-source-error': 'BlockdevOnError',
             '*on-target-error': 'BlockdevOnError',
             '*filter-node-name': 'str' } }
-- 
2.7.5
