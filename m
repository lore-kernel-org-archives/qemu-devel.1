Received: from eggs.gnu.org ([2001:4830:134:3::10]:36966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnABc-0003o4-14
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 17:06:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnABb-0007VX-2d
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 17:06:08 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 30 Aug 2017 16:05:33 -0500
Message-Id: <20170830210542.2153-10-eblake@redhat.com>
In-Reply-To: <20170830210542.2153-1-eblake@redhat.com>
References: <20170830210542.2153-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v6 09/18] dirty-bitmap: Change
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
Cc: kwolf@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>

Thanks to recent cleanups, most callers were scaling a return value
of sectors into bytes (the exception, in qcow2-bitmap, will be
converted to byte-based iteration later).  Update the interface to
do the scaling internally instead.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-By: John Snow <jsnow@redhat.com>

---
v5: no change
v4: rebase to persistent bitmap
v3: no change
v2: no change
---
 block/backup.c       | 2 +-
 block/dirty-bitmap.c | 2 +-
 block/mirror.c       | 8 ++++----
 block/qcow2-bitmap.c | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 1a6ec7d079..f53cde90d6 100644
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
index c091f0c7ba..20f230867d 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -505,7 +505,7 @@ void bdrv_dirty_iter_free(BdrvDirtyBitmapIter *iter)

 int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter)
 {
-    return hbitmap_iter_next(&iter->hbi);
+    return hbitmap_iter_next(&iter->hbi) * BDRV_SECTOR_SIZE;
 }

 /* Called within bdrv_dirty_bitmap_lock..unlock */
diff --git a/block/mirror.c b/block/mirror.c
index 51824750ac..af13f5d658 100644
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
index 44329fc74f..c7c60dfca2 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1109,7 +1109,7 @@ static uint64_t *store_bitmap_data(BlockDriverState *bs,
     sbc = limit >> BDRV_SECTOR_BITS;
     assert(DIV_ROUND_UP(bm_size, limit) == tb_size);

-    while ((sector = bdrv_dirty_iter_next(dbi)) != -1) {
+    while ((sector = bdrv_dirty_iter_next(dbi) >> BDRV_SECTOR_BITS) != -1) {
         uint64_t cluster = sector / sbc;
         uint64_t end, write_size;
         int64_t off;
-- 
2.13.5
