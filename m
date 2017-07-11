Received: from eggs.gnu.org ([2001:4830:134:3::10]:45545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxkI-0008WS-TX
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxkH-0006Kk-5G
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:10:42 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Jul 2017 18:07:21 +0200
Message-Id: <20170711160814.20941-33-mreitz@redhat.com>
In-Reply-To: <20170711160814.20941-1-mreitz@redhat.com>
References: <20170711160814.20941-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 32/85] block/dirty-bitmap: add readonly field to
 BdrvDirtyBitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

It will be needed in following commits for persistent bitmaps.
If bitmap is loaded from read-only storage (and we can't mark it
"in use" in this storage) corresponding BdrvDirtyBitmap should be
read-only.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20170628120530.31251-11-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/dirty-bitmap.h |  4 ++++
 block/dirty-bitmap.c         | 36 ++++++++++++++++++++++++++++++++++++
 block/io.c                   |  8 ++++++++
 blockdev.c                   |  6 ++++++
 4 files changed, 54 insertions(+)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 05451c7..cb43fa3 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -71,6 +71,8 @@ void bdrv_dirty_bitmap_deserialize_ones(BdrvDirtyBitmap *bitmap,
                                         bool finish);
 void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyBitmap *bitmap);
 
+void bdrv_dirty_bitmap_set_readonly(BdrvDirtyBitmap *bitmap, bool value);
+
 /* Functions that require manual locking.  */
 void bdrv_dirty_bitmap_lock(BdrvDirtyBitmap *bitmap);
 void bdrv_dirty_bitmap_unlock(BdrvDirtyBitmap *bitmap);
@@ -85,5 +87,7 @@ void bdrv_set_dirty_iter(BdrvDirtyBitmapIter *hbi, int64_t sector_num);
 int64_t bdrv_get_dirty_count(BdrvDirtyBitmap *bitmap);
 int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap);
 void bdrv_dirty_bitmap_truncate(BlockDriverState *bs);
+bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap);
+bool bdrv_has_readonly_bitmaps(BlockDriverState *bs);
 
 #endif
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index a8fe149..17d3068 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -46,6 +46,12 @@ struct BdrvDirtyBitmap {
     bool disabled;              /* Bitmap is disabled. It ignores all writes to
                                    the device */
     int active_iterators;       /* How many iterators are active */
+    bool readonly;              /* Bitmap is read-only. This field also
+                                   prevents the respective image from being
+                                   modified (i.e. blocks writes and discards).
+                                   Such operations must fail and both the image
+                                   and this bitmap must remain unchanged while
+                                   this flag is set. */
     QLIST_ENTRY(BdrvDirtyBitmap) list;
 };
 
@@ -505,6 +511,7 @@ void bdrv_set_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
                                   int64_t cur_sector, int64_t nr_sectors)
 {
     assert(bdrv_dirty_bitmap_enabled(bitmap));
+    assert(!bdrv_dirty_bitmap_readonly(bitmap));
     hbitmap_set(bitmap->bitmap, cur_sector, nr_sectors);
 }
 
@@ -521,6 +528,7 @@ void bdrv_reset_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
                                     int64_t cur_sector, int64_t nr_sectors)
 {
     assert(bdrv_dirty_bitmap_enabled(bitmap));
+    assert(!bdrv_dirty_bitmap_readonly(bitmap));
     hbitmap_reset(bitmap->bitmap, cur_sector, nr_sectors);
 }
 
@@ -535,6 +543,7 @@ void bdrv_reset_dirty_bitmap(BdrvDirtyBitmap *bitmap,
 void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out)
 {
     assert(bdrv_dirty_bitmap_enabled(bitmap));
+    assert(!bdrv_dirty_bitmap_readonly(bitmap));
     bdrv_dirty_bitmap_lock(bitmap);
     if (!out) {
         hbitmap_reset_all(bitmap->bitmap);
@@ -551,6 +560,7 @@ void bdrv_undo_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap *in)
 {
     HBitmap *tmp = bitmap->bitmap;
     assert(bdrv_dirty_bitmap_enabled(bitmap));
+    assert(!bdrv_dirty_bitmap_readonly(bitmap));
     bitmap->bitmap = in;
     hbitmap_free(tmp);
 }
@@ -613,6 +623,7 @@ void bdrv_set_dirty(BlockDriverState *bs, int64_t cur_sector,
         if (!bdrv_dirty_bitmap_enabled(bitmap)) {
             continue;
         }
+        assert(!bdrv_dirty_bitmap_readonly(bitmap));
         hbitmap_set(bitmap->bitmap, cur_sector, nr_sectors);
     }
     bdrv_dirty_bitmaps_unlock(bs);
@@ -635,3 +646,28 @@ int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap)
 {
     return hbitmap_count(bitmap->meta);
 }
+
+bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap)
+{
+    return bitmap->readonly;
+}
+
+/* Called with BQL taken. */
+void bdrv_dirty_bitmap_set_readonly(BdrvDirtyBitmap *bitmap, bool value)
+{
+    qemu_mutex_lock(bitmap->mutex);
+    bitmap->readonly = value;
+    qemu_mutex_unlock(bitmap->mutex);
+}
+
+bool bdrv_has_readonly_bitmaps(BlockDriverState *bs)
+{
+    BdrvDirtyBitmap *bm;
+    QLIST_FOREACH(bm, &bs->dirty_bitmaps, list) {
+        if (bm->readonly) {
+            return true;
+        }
+    }
+
+    return false;
+}
diff --git a/block/io.c b/block/io.c
index 23170a5..b413727 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1315,6 +1315,10 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     uint64_t bytes_remaining = bytes;
     int max_transfer;
 
+    if (bdrv_has_readonly_bitmaps(bs)) {
+        return -EPERM;
+    }
+
     assert(is_power_of_2(align));
     assert((offset & (align - 1)) == 0);
     assert((bytes & (align - 1)) == 0);
@@ -2287,6 +2291,10 @@ int coroutine_fn bdrv_co_pdiscard(BlockDriverState *bs, int64_t offset,
         return -ENOMEDIUM;
     }
 
+    if (bdrv_has_readonly_bitmaps(bs)) {
+        return -EPERM;
+    }
+
     ret = bdrv_check_byte_request(bs, offset, bytes);
     if (ret < 0) {
         return ret;
diff --git a/blockdev.c b/blockdev.c
index 92c5991..edeb36b 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2033,6 +2033,9 @@ static void block_dirty_bitmap_clear_prepare(BlkActionState *common,
     } else if (!bdrv_dirty_bitmap_enabled(state->bitmap)) {
         error_setg(errp, "Cannot clear a disabled bitmap");
         return;
+    } else if (bdrv_dirty_bitmap_readonly(state->bitmap)) {
+        error_setg(errp, "Cannot clear a readonly bitmap");
+        return;
     }
 
     bdrv_clear_dirty_bitmap(state->bitmap, &state->backup);
@@ -2779,6 +2782,9 @@ void qmp_block_dirty_bitmap_clear(const char *node, const char *name,
                    "Bitmap '%s' is currently disabled and cannot be cleared",
                    name);
         return;
+    } else if (bdrv_dirty_bitmap_readonly(bitmap)) {
+        error_setg(errp, "Bitmap '%s' is readonly and cannot be cleared", name);
+        return;
     }
 
     bdrv_clear_dirty_bitmap(bitmap, NULL);
-- 
2.9.4
