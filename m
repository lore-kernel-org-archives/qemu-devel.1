Received: from eggs.gnu.org ([2001:4830:134:3::10]:46415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQHBx-0000Z6-0z
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 13:55:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQHBv-0002K1-UI
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 13:55:53 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 28 Jun 2017 12:55:27 -0500
Message-Id: <20170628175534.14295-5-eblake@redhat.com>
In-Reply-To: <20170628175534.14295-1-eblake@redhat.com>
References: <20170628175534.14295-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 04/11] dirty-bitmap: Set iterator start by
 offset, not sector
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>

All callers to bdrv_dirty_iter_new() passed 0 for their initial
starting point, drop that parameter.

All callers to bdrv_set_dirty_iter() were scaling an offset to
a sector number; move the scaling to occur internally to dirty
bitmap code instead.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>

---
v2: no change
---
 include/block/dirty-bitmap.h | 5 ++---
 block/backup.c               | 5 ++---
 block/dirty-bitmap.c         | 9 ++++-----
 block/mirror.c               | 4 ++--
 4 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 35a0a83..bc34832 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -39,8 +39,7 @@ void bdrv_set_dirty_bitmap(BdrvDirtyBitmap *bitmap,
 void bdrv_reset_dirty_bitmap(BdrvDirtyBitmap *bitmap,
                              int64_t cur_sector, int64_t nr_sectors);
 BdrvDirtyBitmapIter *bdrv_dirty_meta_iter_new(BdrvDirtyBitmap *bitmap);
-BdrvDirtyBitmapIter *bdrv_dirty_iter_new(BdrvDirtyBitmap *bitmap,
-                                         uint64_t first_sector);
+BdrvDirtyBitmapIter *bdrv_dirty_iter_new(BdrvDirtyBitmap *bitmap);
 void bdrv_dirty_iter_free(BdrvDirtyBitmapIter *iter);

 uint64_t bdrv_dirty_bitmap_serialization_size(const BdrvDirtyBitmap *bitmap,
@@ -67,7 +66,7 @@ void bdrv_set_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
 void bdrv_reset_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
                                     int64_t cur_sector, int64_t nr_sectors);
 int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter);
-void bdrv_set_dirty_iter(BdrvDirtyBitmapIter *hbi, int64_t sector_num);
+void bdrv_set_dirty_iter(BdrvDirtyBitmapIter *hbi, int64_t offset);
 int64_t bdrv_get_dirty_count(BdrvDirtyBitmap *bitmap);
 int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap);
 void bdrv_dirty_bitmap_truncate(BlockDriverState *bs);
diff --git a/block/backup.c b/block/backup.c
index b2048bf..2a94e8b 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -372,7 +372,7 @@ static int coroutine_fn backup_run_incremental(BackupBlockJob *job)

     granularity = bdrv_dirty_bitmap_granularity(job->sync_bitmap);
     clusters_per_iter = MAX((granularity / job->cluster_size), 1);
-    dbi = bdrv_dirty_iter_new(job->sync_bitmap, 0);
+    dbi = bdrv_dirty_iter_new(job->sync_bitmap);

     /* Find the next dirty sector(s) */
     while ((offset = bdrv_dirty_iter_next(dbi) * BDRV_SECTOR_SIZE) >= 0) {
@@ -403,8 +403,7 @@ static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
         /* If the bitmap granularity is smaller than the backup granularity,
          * we need to advance the iterator pointer to the next cluster. */
         if (granularity < job->cluster_size) {
-            bdrv_set_dirty_iter(dbi,
-                                cluster * job->cluster_size / BDRV_SECTOR_SIZE);
+            bdrv_set_dirty_iter(dbi, cluster * job->cluster_size);
         }

         last_cluster = cluster - 1;
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index b2b9342..faf5a4c 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -419,11 +419,10 @@ uint32_t bdrv_dirty_bitmap_granularity(BdrvDirtyBitmap *bitmap)
     return BDRV_SECTOR_SIZE << hbitmap_granularity(bitmap->bitmap);
 }

-BdrvDirtyBitmapIter *bdrv_dirty_iter_new(BdrvDirtyBitmap *bitmap,
-                                         uint64_t first_sector)
+BdrvDirtyBitmapIter *bdrv_dirty_iter_new(BdrvDirtyBitmap *bitmap)
 {
     BdrvDirtyBitmapIter *iter = g_new(BdrvDirtyBitmapIter, 1);
-    hbitmap_iter_init(&iter->hbi, bitmap->bitmap, first_sector);
+    hbitmap_iter_init(&iter->hbi, bitmap->bitmap, 0);
     iter->bitmap = bitmap;
     bitmap->active_iterators++;
     return iter;
@@ -567,9 +566,9 @@ void bdrv_set_dirty(BlockDriverState *bs, int64_t cur_sector,
 /**
  * Advance a BdrvDirtyBitmapIter to an arbitrary offset.
  */
-void bdrv_set_dirty_iter(BdrvDirtyBitmapIter *iter, int64_t sector_num)
+void bdrv_set_dirty_iter(BdrvDirtyBitmapIter *iter, int64_t offset)
 {
-    hbitmap_iter_init(&iter->hbi, iter->hbi.hb, sector_num);
+    hbitmap_iter_init(&iter->hbi, iter->hbi.hb, offset >> BDRV_SECTOR_BITS);
 }

 int64_t bdrv_get_dirty_count(BdrvDirtyBitmap *bitmap)
diff --git a/block/mirror.c b/block/mirror.c
index 8c3752b..3869450 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -373,7 +373,7 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
         next_dirty = bdrv_dirty_iter_next(s->dbi) * BDRV_SECTOR_SIZE;
         if (next_dirty > next_offset || next_dirty < 0) {
             /* The bitmap iterator's cache is stale, refresh it */
-            bdrv_set_dirty_iter(s->dbi, next_offset >> BDRV_SECTOR_BITS);
+            bdrv_set_dirty_iter(s->dbi, next_offset);
             next_dirty = bdrv_dirty_iter_next(s->dbi) * BDRV_SECTOR_SIZE;
         }
         assert(next_dirty == next_offset);
@@ -791,7 +791,7 @@ static void coroutine_fn mirror_run(void *opaque)
     }

     assert(!s->dbi);
-    s->dbi = bdrv_dirty_iter_new(s->dirty_bitmap, 0);
+    s->dbi = bdrv_dirty_iter_new(s->dirty_bitmap);
     for (;;) {
         uint64_t delay_ns = 0;
         int64_t cnt, delta;
-- 
2.9.4
