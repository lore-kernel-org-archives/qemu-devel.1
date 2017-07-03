Received: from eggs.gnu.org ([2001:4830:134:3::10]:55132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS30L-00070g-9q
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 11:11:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS30K-000885-3G
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 11:11:13 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  3 Jul 2017 10:10:38 -0500
Message-Id: <20170703151051.31327-5-eblake@redhat.com>
In-Reply-To: <20170703151051.31327-1-eblake@redhat.com>
References: <20170703151051.31327-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 04/17] dirty-bitmap: Drop unused functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

We had several functions that no one is currently using, and which
use sector-based interfaces.  I'm trying to convert towards byte-based
interfaces, so it's easier to just drop the unused functions:

bdrv_dirty_bitmap_get_meta
bdrv_dirty_bitmap_get_meta_locked
bdrv_dirty_bitmap_reset_meta
bdrv_dirty_bitmap_meta_granularity

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v4: rebase to Vladimir's persistent bitmaps (bdrv_dirty_bitmap_size now
in use), dropped R-b
v3: rebase to upstream changes (bdrv_dirty_bitmap_get_meta_locked was
added in b64bd51e with no clients), kept R-b
v2: tweak commit message based on review, no code change
---
 include/block/dirty-bitmap.h | 10 ----------
 block/dirty-bitmap.c         | 44 --------------------------------------------
 2 files changed, 54 deletions(-)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index a79a58d..8fd842e 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -34,7 +34,6 @@ void bdrv_enable_dirty_bitmap(BdrvDirtyBitmap *bitmap);
 BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDriverState *bs);
 uint32_t bdrv_get_default_bitmap_granularity(BlockDriverState *bs);
 uint32_t bdrv_dirty_bitmap_granularity(const BdrvDirtyBitmap *bitmap);
-uint32_t bdrv_dirty_bitmap_meta_granularity(BdrvDirtyBitmap *bitmap);
 bool bdrv_dirty_bitmap_enabled(BdrvDirtyBitmap *bitmap);
 bool bdrv_dirty_bitmap_frozen(BdrvDirtyBitmap *bitmap);
 const char *bdrv_dirty_bitmap_name(const BdrvDirtyBitmap *bitmap);
@@ -44,15 +43,6 @@ void bdrv_set_dirty_bitmap(BdrvDirtyBitmap *bitmap,
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
index 0490ca3..42a55e4 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -173,45 +173,6 @@ void bdrv_release_meta_dirty_bitmap(BdrvDirtyBitmap *bitmap)
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
 int64_t bdrv_dirty_bitmap_size(const BdrvDirtyBitmap *bitmap)
 {
     return bitmap->size;
@@ -511,11 +472,6 @@ uint32_t bdrv_dirty_bitmap_granularity(const BdrvDirtyBitmap *bitmap)
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
