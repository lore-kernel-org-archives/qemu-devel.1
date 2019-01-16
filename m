Received: from eggs.gnu.org ([209.51.188.92]:57867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gjZaJ-0002n9-1Z
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 20:01:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gjZa3-0004Vv-SZ
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 20:01:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gjZa3-0004Rx-4j
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 20:01:19 -0500
From: John Snow <jsnow@redhat.com>
Date: Tue, 15 Jan 2019 20:01:04 -0500
Message-Id: <20190116010106.27626-7-jsnow@redhat.com>
In-Reply-To: <20190116010106.27626-1-jsnow@redhat.com>
References: <20190116010106.27626-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 6/8] Revert "block/dirty-bitmap: Add
 bdrv_dirty_iter_next_area"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This reverts commit 72d10a94213a954ad569095cb4491f2ae0853c40.

The function is unused now.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c         | 55 ------------------------------------
 include/block/dirty-bitmap.h |  2 --
 2 files changed, 57 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index c1518373f9..4d9a8af17d 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -518,61 +518,6 @@ int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter)
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
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 4ef00ca6ba..04a117fc81 100644
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
-- 
2.17.2
