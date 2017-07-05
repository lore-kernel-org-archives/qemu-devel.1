Received: from eggs.gnu.org ([2001:4830:134:3::10]:38180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSrY8-0005Ca-1d
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 17:09:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSrY6-0002pq-QF
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 17:09:27 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed,  5 Jul 2017 16:08:39 -0500
Message-Id: <20170705210842.960-19-eblake@redhat.com>
In-Reply-To: <20170705210842.960-1-eblake@redhat.com>
References: <20170705210842.960-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 18/21] backup: Switch backup_run() to
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

We are gradually converting to byte-based interfaces, as they are
easier to reason about than sector-based.  Change the internal
loop iteration of backups to track by bytes instead of sectors
(although we are still guaranteed that we iterate by steps that
are cluster-aligned).

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
---
v2-v4: no change
---
 block/backup.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index c029d44..04def91 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -370,11 +370,10 @@ static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
     int ret = 0;
     int clusters_per_iter;
     uint32_t granularity;
-    int64_t sector;
+    int64_t offset;
     int64_t cluster;
     int64_t end;
     int64_t last_cluster = -1;
-    int64_t sectors_per_cluster = cluster_size_sectors(job);
     BdrvDirtyBitmapIter *dbi;

     granularity = bdrv_dirty_bitmap_granularity(job->sync_bitmap);
@@ -382,8 +381,8 @@ static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
     dbi = bdrv_dirty_iter_new(job->sync_bitmap, 0);

     /* Find the next dirty sector(s) */
-    while ((sector = bdrv_dirty_iter_next(dbi)) != -1) {
-        cluster = sector / sectors_per_cluster;
+    while ((offset = bdrv_dirty_iter_next(dbi) * BDRV_SECTOR_SIZE) >= 0) {
+        cluster = offset / job->cluster_size;

         /* Fake progress updates for any clusters we skipped */
         if (cluster != last_cluster + 1) {
@@ -410,7 +409,8 @@ static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
         /* If the bitmap granularity is smaller than the backup granularity,
          * we need to advance the iterator pointer to the next cluster. */
         if (granularity < job->cluster_size) {
-            bdrv_set_dirty_iter(dbi, cluster * sectors_per_cluster);
+            bdrv_set_dirty_iter(dbi,
+                                cluster * job->cluster_size / BDRV_SECTOR_SIZE);
         }

         last_cluster = cluster - 1;
@@ -432,17 +432,15 @@ static void coroutine_fn backup_run(void *opaque)
     BackupBlockJob *job = opaque;
     BackupCompleteData *data;
     BlockDriverState *bs = blk_bs(job->common.blk);
-    int64_t start, end;
+    int64_t offset;
     int64_t sectors_per_cluster = cluster_size_sectors(job);
     int ret = 0;

     QLIST_INIT(&job->inflight_reqs);
     qemu_co_rwlock_init(&job->flush_rwlock);

-    start = 0;
-    end = DIV_ROUND_UP(job->common.len, job->cluster_size);
-
-    job->done_bitmap = bitmap_new(end);
+    job->done_bitmap = bitmap_new(DIV_ROUND_UP(job->common.len,
+                                               job->cluster_size));

     job->before_write.notify = backup_before_write_notify;
     bdrv_add_before_write_notifier(bs, &job->before_write);
@@ -457,7 +455,8 @@ static void coroutine_fn backup_run(void *opaque)
         ret = backup_run_incremental(job);
     } else {
         /* Both FULL and TOP SYNC_MODE's require copying.. */
-        for (; start < end; start++) {
+        for (offset = 0; offset < job->common.len;
+             offset += job->cluster_size) {
             bool error_is_read;
             int alloced = 0;

@@ -480,8 +479,8 @@ static void coroutine_fn backup_run(void *opaque)
                      * needed but at some point that is always the case. */
                     alloced =
                         bdrv_is_allocated(bs,
-                                start * sectors_per_cluster + i,
-                                sectors_per_cluster - i, &n);
+                                          (offset >> BDRV_SECTOR_BITS) + i,
+                                          sectors_per_cluster - i, &n);
                     i += n;

                     if (alloced || n == 0) {
@@ -499,9 +498,8 @@ static void coroutine_fn backup_run(void *opaque)
             if (alloced < 0) {
                 ret = alloced;
             } else {
-                ret = backup_do_cow(job, start * job->cluster_size,
-                                    job->cluster_size, &error_is_read,
-                                    false);
+                ret = backup_do_cow(job, offset, job->cluster_size,
+                                    &error_is_read, false);
             }
             if (ret < 0) {
                 /* Depending on error action, fail now or retry cluster */
@@ -510,7 +508,7 @@ static void coroutine_fn backup_run(void *opaque)
                 if (action == BLOCK_ERROR_ACTION_REPORT) {
                     break;
                 } else {
-                    start--;
+                    offset -= job->cluster_size;
                     continue;
                 }
             }
-- 
2.9.4
