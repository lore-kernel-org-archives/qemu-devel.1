Received: from eggs.gnu.org ([2001:4830:134:3::10]:41250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAjNm-0002gO-IU
	for qemu-devel@nongnu.org; Tue, 16 May 2017 16:47:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAjNl-0003bS-OA
	for qemu-devel@nongnu.org; Tue, 16 May 2017 16:47:50 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 16 May 2017 15:47:18 -0500
Message-Id: <20170516204724.1617-7-eblake@redhat.com>
In-Reply-To: <20170516204724.1617-1-eblake@redhat.com>
References: <20170516204724.1617-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 06/12] dirty-bitmap: Change
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
Cc: jsnow@redhat.com, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>

Thanks to recent cleanups, all callers were scaling a return value
of sectors into bytes; do the scaling internally instead.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>

---
v2: no change
---
 block/backup.c       | 2 +-
 block/dirty-bitmap.c | 2 +-
 block/mirror.c       | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 70126b8..dc3c7f2 100644
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
index 885cc29..8428733 100644
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
2.9.4
