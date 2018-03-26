Received: from eggs.gnu.org ([2001:4830:134:3::10]:48127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f0QBT-00045Z-OO
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 07:21:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f0QBQ-0007Mt-Fw
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 07:21:03 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 26 Mar 2018 14:20:53 +0300
Message-Id: <20180326112056.8420-5-vsementsov@virtuozzo.com>
In-Reply-To: <20180326112056.8420-1-vsementsov@virtuozzo.com>
References: <20180326112056.8420-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 4/7] dirty-bitmap: separate unused meta-bitmap
 related functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Separate them in the header and clarify needed locking in comments.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/dirty-bitmap.h | 14 +++++++++-----
 block/dirty-bitmap.c         |  5 +++++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index c7e910016d..b7ccfd1363 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -9,9 +9,6 @@ BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverState *bs,
                                           uint32_t granularity,
                                           const char *name,
                                           Error **errp);
-void bdrv_create_meta_dirty_bitmap(BdrvDirtyBitmap *bitmap,
-                                   int chunk_size);
-void bdrv_release_meta_dirty_bitmap(BdrvDirtyBitmap *bitmap);
 int bdrv_dirty_bitmap_create_successor(BlockDriverState *bs,
                                        BdrvDirtyBitmap *bitmap,
                                        Error **errp);
@@ -45,7 +42,6 @@ void bdrv_set_dirty_bitmap(BdrvDirtyBitmap *bitmap,
                            int64_t offset, int64_t bytes);
 void bdrv_reset_dirty_bitmap(BdrvDirtyBitmap *bitmap,
                              int64_t offset, int64_t bytes);
-BdrvDirtyBitmapIter *bdrv_dirty_meta_iter_new(BdrvDirtyBitmap *bitmap);
 BdrvDirtyBitmapIter *bdrv_dirty_iter_new(BdrvDirtyBitmap *bitmap);
 void bdrv_dirty_iter_free(BdrvDirtyBitmapIter *iter);
 
@@ -84,7 +80,6 @@ void bdrv_reset_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
 int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter);
 void bdrv_set_dirty_iter(BdrvDirtyBitmapIter *hbi, int64_t offset);
 int64_t bdrv_get_dirty_count(BdrvDirtyBitmap *bitmap);
-int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap);
 void bdrv_dirty_bitmap_truncate(BlockDriverState *bs, int64_t bytes);
 bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap);
 bool bdrv_has_readonly_bitmaps(BlockDriverState *bs);
@@ -99,4 +94,13 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState *bs,
                                                   BdrvDirtyBitmap *bitmap,
                                                   Error **errp);
 
+/*
+ * Unused for now meta-bitmaps related functions
+ */
+
+void bdrv_create_meta_dirty_bitmap(BdrvDirtyBitmap *bitmap, int chunk_size);
+void bdrv_release_meta_dirty_bitmap(BdrvDirtyBitmap *bitmap);
+BdrvDirtyBitmapIter *bdrv_dirty_meta_iter_new(BdrvDirtyBitmap *bitmap);
+int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap);
+
 #endif
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 6c00288fd7..1812e17549 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -149,6 +149,8 @@ BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverState *bs,
  * @bitmap: the block dirty bitmap for which to create a meta dirty bitmap.
  * @chunk_size: how many bytes of bitmap data does each bit in the meta bitmap
  * track.
+ *
+ * Called with BQL taken.
  */
 void bdrv_create_meta_dirty_bitmap(BdrvDirtyBitmap *bitmap,
                                    int chunk_size)
@@ -160,6 +162,7 @@ void bdrv_create_meta_dirty_bitmap(BdrvDirtyBitmap *bitmap,
     qemu_mutex_unlock(bitmap->mutex);
 }
 
+/* Called with BQL taken. */
 void bdrv_release_meta_dirty_bitmap(BdrvDirtyBitmap *bitmap)
 {
     assert(bitmap->meta);
@@ -529,6 +532,7 @@ BdrvDirtyBitmapIter *bdrv_dirty_iter_new(BdrvDirtyBitmap *bitmap)
     return iter;
 }
 
+/* Called with BQL and dirty_bitmap_mutex locked. */
 BdrvDirtyBitmapIter *bdrv_dirty_meta_iter_new(BdrvDirtyBitmap *bitmap)
 {
     BdrvDirtyBitmapIter *iter = g_new(BdrvDirtyBitmapIter, 1);
@@ -688,6 +692,7 @@ int64_t bdrv_get_dirty_count(BdrvDirtyBitmap *bitmap)
     return hbitmap_count(bitmap->bitmap);
 }
 
+/* Called with BQL or dirty_bitmap_mutex locked */
 int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap)
 {
     return hbitmap_count(bitmap->meta);
-- 
2.11.1
