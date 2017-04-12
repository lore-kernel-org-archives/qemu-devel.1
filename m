Received: from eggs.gnu.org ([2001:4830:134:3::10]:45165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyMP8-0003pX-Ez
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 13:50:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyMP6-0007Bp-0o
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 13:50:06 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 12 Apr 2017 12:49:14 -0500
Message-Id: <20170412174920.8744-7-eblake@redhat.com>
In-Reply-To: <20170412174920.8744-1-eblake@redhat.com>
References: <20170412174920.8744-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 06/12] dirty-bitmap: Change
 bdrv_dirty_iter_next() to report byte offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, famz@redhat.com, jsnow@redhat.com, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>

Thanks to recent cleanups, all callers were scaling a return value
of sectors into bytes; do the scaling internally instead.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/backup.c       | 2 +-
 block/dirty-bitmap.c | 2 +-
 block/mirror.c       | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index efa4896..6efd864 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -375,7 +375,7 @@ static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
     dbi = bdrv_dirty_iter_new(job->sync_bitmap);

     /* Find the next dirty sector(s) */
-    while ((offset = bdrv_dirty_iter_next(dbi) * BDRV_SECTOR_SIZE) >= 0) {
+    while ((offset = bdrv_dirty_iter_next(dbi)) >= 0) {
         cluster = offset / job->cluster_size;

         /* Fake progress updates for any clusters we skipped */
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 3fb4871..2f9f554 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -397,7 +397,7 @@ void bdrv_dirty_iter_free(BdrvDirtyBitmapIter *iter)

 int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter)
 {
-    return hbitmap_iter_next(&iter->hbi);
+    return hbitmap_iter_next(&iter->hbi) * BDRV_SECTOR_SIZE;
 }

 void bdrv_set_dirty_bitmap(BdrvDirtyBitmap *bitmap,
diff --git a/block/mirror.c b/block/mirror.c
index 7c1d6bf..f404ff3 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -335,10 +335,10 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
     bool write_zeroes_ok = bdrv_can_write_zeroes_with_unmap(blk_bs(s->target));
     int max_io_bytes = MAX(s->buf_size / MAX_IN_FLIGHT, MAX_IO_BYTES);

-    offset = bdrv_dirty_iter_next(s->dbi) * BDRV_SECTOR_SIZE;
+    offset = bdrv_dirty_iter_next(s->dbi);
     if (offset < 0) {
         bdrv_set_dirty_iter(s->dbi, 0);
-        offset = bdrv_dirty_iter_next(s->dbi) * BDRV_SECTOR_SIZE;
+        offset = bdrv_dirty_iter_next(s->dbi);
         trace_mirror_restart_iter(s, bdrv_get_dirty_count(s->dirty_bitmap) *
                                   BDRV_SECTOR_SIZE);
         assert(offset >= 0);
@@ -367,11 +367,11 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
             break;
         }

-        next_dirty = bdrv_dirty_iter_next(s->dbi) * BDRV_SECTOR_SIZE;
+        next_dirty = bdrv_dirty_iter_next(s->dbi);
         if (next_dirty > next_offset || next_dirty < 0) {
             /* The bitmap iterator's cache is stale, refresh it */
             bdrv_set_dirty_iter(s->dbi, next_offset);
-            next_dirty = bdrv_dirty_iter_next(s->dbi) * BDRV_SECTOR_SIZE;
+            next_dirty = bdrv_dirty_iter_next(s->dbi);
         }
         assert(next_dirty == next_offset);
         nb_chunks++;
-- 
2.9.3
