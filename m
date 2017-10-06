Received: from eggs.gnu.org ([2001:4830:134:3::10]:55562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0Uxj-0000Ll-9Z
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:54:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0Uxe-0002lp-BH
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:54:55 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  6 Oct 2017 17:53:40 +0200
Message-Id: <20171006155422.10135-13-kwolf@redhat.com>
In-Reply-To: <20171006155422.10135-1-kwolf@redhat.com>
References: <20171006155422.10135-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 12/54] dirty-bitmap: Change
 bdrv_dirty_iter_next() to report byte offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

Thanks to recent cleanups, most callers were scaling a return value
of sectors into bytes (the exception, in qcow2-bitmap, will be
converted to byte-based iteration later).  Update the interface to
do the scaling internally instead.

In qcow2-bitmap, the code was specifically checking for an error
return of -1.  To avoid a regression, we either have to make sure
we continue to return -1 (rather than a scaled -512) on error, or
we have to fix the caller to treat all negative values as error
rather than just one magic value.  It's easy enough to make both
changes at the same time, even though either one in isolation
would work.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/backup.c       | 2 +-
 block/dirty-bitmap.c | 3 ++-
 block/mirror.c       | 8 ++++----
 block/qcow2-bitmap.c | 2 +-
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index ac9c018717..06ddbfd03d 100644
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
index 84509476ba..e451916187 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -503,7 +503,8 @@ void bdrv_dirty_iter_free(BdrvDirtyBitmapIter *iter)
 
 int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter)
 {
-    return hbitmap_iter_next(&iter->hbi);
+    int64_t ret = hbitmap_iter_next(&iter->hbi);
+    return ret < 0 ? -1 : ret * BDRV_SECTOR_SIZE;
 }
 
 /* Called within bdrv_dirty_bitmap_lock..unlock */
diff --git a/block/mirror.c b/block/mirror.c
index 0c705e0b4f..de0a02778c 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -336,10 +336,10 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
     int max_io_bytes = MAX(s->buf_size / MAX_IN_FLIGHT, MAX_IO_BYTES);
 
     bdrv_dirty_bitmap_lock(s->dirty_bitmap);
-    offset = bdrv_dirty_iter_next(s->dbi) * BDRV_SECTOR_SIZE;
+    offset = bdrv_dirty_iter_next(s->dbi);
     if (offset < 0) {
         bdrv_set_dirty_iter(s->dbi, 0);
-        offset = bdrv_dirty_iter_next(s->dbi) * BDRV_SECTOR_SIZE;
+        offset = bdrv_dirty_iter_next(s->dbi);
         trace_mirror_restart_iter(s, bdrv_get_dirty_count(s->dirty_bitmap) *
                                   BDRV_SECTOR_SIZE);
         assert(offset >= 0);
@@ -370,11 +370,11 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
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
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 90756cf561..2d8dcba3e8 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1109,7 +1109,7 @@ static uint64_t *store_bitmap_data(BlockDriverState *bs,
     sbc = limit >> BDRV_SECTOR_BITS;
     assert(DIV_ROUND_UP(bm_size, limit) == tb_size);
 
-    while ((sector = bdrv_dirty_iter_next(dbi)) != -1) {
+    while ((sector = bdrv_dirty_iter_next(dbi) >> BDRV_SECTOR_BITS) >= 0) {
         uint64_t cluster = sector / sbc;
         uint64_t end, write_size;
         int64_t off;
-- 
2.13.6
