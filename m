Received: from eggs.gnu.org ([2001:4830:134:3::10]:46365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQHBu-0000W8-IQ
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 13:55:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQHBt-0002Hz-Jt
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 13:55:50 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 28 Jun 2017 12:55:25 -0500
Message-Id: <20170628175534.14295-3-eblake@redhat.com>
In-Reply-To: <20170628175534.14295-1-eblake@redhat.com>
References: <20170628175534.14295-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 02/11] dirty-bitmap: Drop unused functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, kwolf@redhat.com, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

We had several functions that no one is currently using, and which
use sector-based interfaces.  I'm trying to convert towards byte-based
interfaces, so it's easier to just drop the unused functions:

bdrv_dirty_bitmap_size
bdrv_dirty_bitmap_get_meta
bdrv_dirty_bitmap_get_meta_locked
bdrv_dirty_bitmap_reset_meta
bdrv_dirty_bitmap_meta_granularity

Vladimir may re-add bdrv_dirty_bitmap_size() for persistent
bitmaps, but has agreed to do so with byte rather than sector
access at the point where it is needed.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>

---
v3: rebase to upstream changes (bdrv_dirty_bitmap_get_meta_locked was
added in b64bd51e with no clients), kept R-b
v2: tweak commit message based on review, no code change
---
 include/block/dirty-bitmap.h | 11 ----------
 block/dirty-bitmap.c         | 49 --------------------------------------------
 2 files changed, 60 deletions(-)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index ad6558a..35a0a83 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -30,25 +30,14 @@ void bdrv_enable_dirty_bitmap(BdrvDirtyBitmap *bitmap);
 BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDriverState *bs);
 uint32_t bdrv_get_default_bitmap_granularity(BlockDriverState *bs);
 uint32_t bdrv_dirty_bitmap_granularity(BdrvDirtyBitmap *bitmap);
-uint32_t bdrv_dirty_bitmap_meta_granularity(BdrvDirtyBitmap *bitmap);
 bool bdrv_dirty_bitmap_enabled(BdrvDirtyBitmap *bitmap);
 bool bdrv_dirty_bitmap_frozen(BdrvDirtyBitmap *bitmap);
 const char *bdrv_dirty_bitmap_name(const BdrvDirtyBitmap *bitmap);
-int64_t bdrv_dirty_bitmap_size(const BdrvDirtyBitmap *bitmap);
 DirtyBitmapStatus bdrv_dirty_bitmap_status(BdrvDirtyBitmap *bitmap);
 void bdrv_set_dirty_bitmap(BdrvDirtyBitmap *bitmap,
                            int64_t cur_sector, int64_t nr_sectors);
 void bdrv_reset_dirty_bitmap(BdrvDirtyBitmap *bitmap,
                              int64_t cur_sector, int64_t nr_sectors);
-int bdrv_dirty_bitmap_get_meta(BlockDriverState *bs,
-                               BdrvDirtyBitmap *bitmap, int64_t sector,
-                               int nb_sectors);
-int bdrv_dirty_bitmap_get_meta_locked(BlockDriverState *bs,
-                                      BdrvDirtyBitmap *bitmap, int64_t sector,
-                                      int nb_sectors);
-void bdrv_dirty_bitmap_reset_meta(BlockDriverState *bs,
-                                  BdrvDirtyBitmap *bitmap, int64_t sector,
-                                  int nb_sectors);
 BdrvDirtyBitmapIter *bdrv_dirty_meta_iter_new(BdrvDirtyBitmap *bitmap);
 BdrvDirtyBitmapIter *bdrv_dirty_iter_new(BdrvDirtyBitmap *bitmap,
                                          uint64_t first_sector);
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index f17fc14..13febf2 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -161,50 +161,6 @@ void bdrv_release_meta_dirty_bitmap(BdrvDirtyBitmap *bitmap)
     qemu_mutex_unlock(bitmap->mutex);
 }

-int bdrv_dirty_bitmap_get_meta_locked(BlockDriverState *bs,
-                                      BdrvDirtyBitmap *bitmap, int64_t sector,
-                                      int nb_sectors)
-{
-    uint64_t i;
-    int sectors_per_bit = 1 << hbitmap_granularity(bitmap->meta);
-
-    /* To optimize: we can make hbitmap to internally check the range in a
-     * coarse level, or at least do it word by word. */
-    for (i = sector; i < sector + nb_sectors; i += sectors_per_bit) {
-        if (hbitmap_get(bitmap->meta, i)) {
-            return true;
-        }
-    }
-    return false;
-}
-
-int bdrv_dirty_bitmap_get_meta(BlockDriverState *bs,
-                               BdrvDirtyBitmap *bitmap, int64_t sector,
-                               int nb_sectors)
-{
-    bool dirty;
-
-    qemu_mutex_lock(bitmap->mutex);
-    dirty = bdrv_dirty_bitmap_get_meta_locked(bs, bitmap, sector, nb_sectors);
-    qemu_mutex_unlock(bitmap->mutex);
-
-    return dirty;
-}
-
-void bdrv_dirty_bitmap_reset_meta(BlockDriverState *bs,
-                                  BdrvDirtyBitmap *bitmap, int64_t sector,
-                                  int nb_sectors)
-{
-    qemu_mutex_lock(bitmap->mutex);
-    hbitmap_reset(bitmap->meta, sector, nb_sectors);
-    qemu_mutex_unlock(bitmap->mutex);
-}
-
-int64_t bdrv_dirty_bitmap_size(const BdrvDirtyBitmap *bitmap)
-{
-    return bitmap->size;
-}
-
 const char *bdrv_dirty_bitmap_name(const BdrvDirtyBitmap *bitmap)
 {
     return bitmap->name;
@@ -460,11 +416,6 @@ uint32_t bdrv_dirty_bitmap_granularity(BdrvDirtyBitmap *bitmap)
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
-- 
2.9.4
