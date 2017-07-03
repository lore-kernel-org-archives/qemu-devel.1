Received: from eggs.gnu.org ([2001:4830:134:3::10]:55313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS30e-0007FB-Hb
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 11:11:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS30X-0008Hb-Lp
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 11:11:27 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  3 Jul 2017 10:10:42 -0500
Message-Id: <20170703151051.31327-9-eblake@redhat.com>
In-Reply-To: <20170703151051.31327-1-eblake@redhat.com>
References: <20170703151051.31327-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 08/17] dirty-bitmap: Set iterator start by
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
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>

All callers to bdrv_dirty_iter_new() passed 0 for their initial
starting point, drop that parameter.

Most callers to bdrv_set_dirty_iter() were scaling a byte offset to
a sector number; the exception qcow2-bitmap will be converted later
to use byte rather than sector iteration.  Move the scaling to occur
internally to dirty bitmap code instead, so that callers now pass
in bytes.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v4: rebase to persistent bitmaps
v3: no change
v2: no change
---
 include/block/dirty-bitmap.h | 5 ++---
 block/backup.c               | 5 ++---
 block/dirty-bitmap.c         | 9 ++++-----
 block/mirror.c               | 4 ++--
 block/qcow2-bitmap.c         | 4 ++--
 5 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index f4ccd3f..ece28e1 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -44,8 +44,7 @@ void bdrv_set_dirty_bitmap(BdrvDirtyBitmap *bitmap,
 void bdrv_reset_dirty_bitmap(BdrvDirtyBitmap *bitmap,
                              int64_t cur_sector, int64_t nr_sectors);
 BdrvDirtyBitmapIter *bdrv_dirty_meta_iter_new(BdrvDirtyBitmap *bitmap);
-BdrvDirtyBitmapIter *bdrv_dirty_iter_new(BdrvDirtyBitmap *bitmap,
-                                         uint64_t first_sector);
+BdrvDirtyBitmapIter *bdrv_dirty_iter_new(BdrvDirtyBitmap *bitmap);
 void bdrv_dirty_iter_free(BdrvDirtyBitmapIter *iter);

 uint64_t bdrv_dirty_bitmap_serialization_size(const BdrvDirtyBitmap *bitmap,
@@ -80,7 +79,7 @@ void bdrv_set_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
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
index dc5c205..83049f4 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -476,11 +476,10 @@ uint32_t bdrv_dirty_bitmap_granularity(const BdrvDirtyBitmap *bitmap)
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
@@ -648,9 +647,9 @@ void bdrv_set_dirty(BlockDriverState *bs, int64_t cur_sector,
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
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 7fce226..533e9fd 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1099,7 +1099,7 @@ static uint64_t *store_bitmap_data(BlockDriverState *bs,
         return NULL;
     }

-    dbi = bdrv_dirty_iter_new(bitmap, 0);
+    dbi = bdrv_dirty_iter_new(bitmap);
     buf = g_malloc(s->cluster_size);
     limit = bytes_covered_by_bitmap_cluster(s, bitmap);
     sbc = limit >> BDRV_SECTOR_BITS;
@@ -1149,7 +1149,7 @@ static uint64_t *store_bitmap_data(BlockDriverState *bs,
             break;
         }

-        bdrv_set_dirty_iter(dbi, end);
+        bdrv_set_dirty_iter(dbi, end * BDRV_SECTOR_SIZE);
     }

     *bitmap_table_size = tb_size;
-- 
2.9.4
