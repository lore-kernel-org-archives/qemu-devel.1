Received: from eggs.gnu.org ([2001:4830:134:3::10]:37583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fpYDs-0002e8-TS
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:14:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fpYDn-00052R-SA
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:14:52 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 14 Aug 2018 15:14:41 +0300
Message-Id: <20180814121443.33114-7-vsementsov@virtuozzo.com>
In-Reply-To: <20180814121443.33114-1-vsementsov@virtuozzo.com>
References: <20180814121443.33114-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 6/8] Revert "block/dirty-bitmap: Add
 bdrv_dirty_iter_next_area"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

This reverts commit 72d10a94213a954ad569095cb4491f2ae0853c40.

The function is unused now.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/dirty-bitmap.h |  2 --
 block/dirty-bitmap.c         | 55 --------------------------------------------
 2 files changed, 57 deletions(-)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index cb9162fa7e..20e1d86cb1 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -83,8 +83,6 @@ void bdrv_set_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
 void bdrv_reset_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
                                     int64_t offset, int64_t bytes);
 int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter);
-bool bdrv_dirty_iter_next_area(BdrvDirtyBitmapIter *iter, uint64_t max_offset,
-                               uint64_t *offset, int *bytes);
 void bdrv_set_dirty_iter(BdrvDirtyBitmapIter *hbi, int64_t offset);
 int64_t bdrv_get_dirty_count(BdrvDirtyBitmap *bitmap);
 int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap);
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 4af20a1beb..d9333175b3 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -528,61 +528,6 @@ int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter)
     return hbitmap_iter_next(&iter->hbi, true);
 }
 
-/**
- * Return the next consecutively dirty area in the dirty bitmap
- * belonging to the given iterator @iter.
- *
- * @max_offset: Maximum value that may be returned for
- *              *offset + *bytes
- * @offset:     Will contain the start offset of the next dirty area
- * @bytes:      Will contain the length of the next dirty area
- *
- * Returns: True if a dirty area could be found before max_offset
- *          (which means that *offset and *bytes then contain valid
- *          values), false otherwise.
- *
- * Note that @iter is never advanced if false is returned.  If an area
- * is found (which means that true is returned), it will be advanced
- * past that area.
- */
-bool bdrv_dirty_iter_next_area(BdrvDirtyBitmapIter *iter, uint64_t max_offset,
-                               uint64_t *offset, int *bytes)
-{
-    uint32_t granularity = bdrv_dirty_bitmap_granularity(iter->bitmap);
-    uint64_t gran_max_offset;
-    int64_t ret;
-    int size;
-
-    if (max_offset == iter->bitmap->size) {
-        /* If max_offset points to the image end, round it up by the
-         * bitmap granularity */
-        gran_max_offset = ROUND_UP(max_offset, granularity);
-    } else {
-        gran_max_offset = max_offset;
-    }
-
-    ret = hbitmap_iter_next(&iter->hbi, false);
-    if (ret < 0 || ret + granularity > gran_max_offset) {
-        return false;
-    }
-
-    *offset = ret;
-    size = 0;
-
-    assert(granularity <= INT_MAX);
-
-    do {
-        /* Advance iterator */
-        ret = hbitmap_iter_next(&iter->hbi, true);
-        size += granularity;
-    } while (ret + granularity <= gran_max_offset &&
-             hbitmap_iter_next(&iter->hbi, false) == ret + granularity &&
-             size <= INT_MAX - granularity);
-
-    *bytes = MIN(size, max_offset - *offset);
-    return true;
-}
-
 /* Called within bdrv_dirty_bitmap_lock..unlock */
 void bdrv_set_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
                                   int64_t offset, int64_t bytes)
-- 
2.11.1
