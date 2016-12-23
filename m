Received: from eggs.gnu.org ([2001:4830:134:3::10]:40142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cKU93-0007dx-VC
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 13:00:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cKU93-00049r-4R
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 13:00:42 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 23 Dec 2016 17:28:45 +0300
Message-ID: <1482503344-6424-3-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 02/21] backup: init copy_bitmap from
 sync_bitmap for incremental
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, vsementsov@virtuozzo.com, pbonzini@redhat.com, jcody@redhat.com

We should not copy non-dirty clusters in write notifiers. So,
initialize copy_bitmap from sync_bitmap.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/block/backup.c b/block/backup.c
index 6b27e55..621b1c0 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -437,6 +437,34 @@ out:
     return ret;
 }
 
+/* init copy_bitmap from sync_bitmap */
+static void backup_incremental_init_copy_bitmap(BackupBlockJob *job)
+{
+    int64_t sector;
+    BdrvDirtyBitmapIter *dbi;
+    uint32_t sect_gran =
+        bdrv_dirty_bitmap_granularity(job->sync_bitmap) >> BDRV_SECTOR_BITS;
+    int64_t sz = bdrv_dirty_bitmap_size(job->sync_bitmap);
+    int64_t sectors_per_cluster = cluster_size_sectors(job);
+    uint32_t cl_gran = MAX(1, sect_gran / sectors_per_cluster);
+
+    dbi = bdrv_dirty_iter_new(job->sync_bitmap, 0);
+    while ((sector = bdrv_dirty_iter_next(dbi)) != -1) {
+        int64_t cluster = sector / sectors_per_cluster;
+        int64_t next_sector = (cluster + cl_gran) * sectors_per_cluster;
+
+        hbitmap_set(job->copy_bitmap, cluster, cl_gran);
+
+        if (next_sector >= sz) {
+            break;
+        }
+
+        bdrv_set_dirty_iter(dbi, (cluster + cl_gran) * sectors_per_cluster);
+    }
+
+    bdrv_dirty_iter_free(dbi);
+}
+
 static void coroutine_fn backup_run(void *opaque)
 {
     BackupBlockJob *job = opaque;
@@ -453,20 +481,22 @@ static void coroutine_fn backup_run(void *opaque)
     end = DIV_ROUND_UP(job->common.len, job->cluster_size);
 
     job->copy_bitmap = hbitmap_alloc(end, 0);
-    hbitmap_set(job->copy_bitmap, 0, end);
 
     job->before_write.notify = backup_before_write_notify;
     bdrv_add_before_write_notifier(bs, &job->before_write);
 
     if (job->sync_mode == MIRROR_SYNC_MODE_NONE) {
+        hbitmap_set(job->copy_bitmap, 0, end);
         while (!block_job_is_cancelled(&job->common)) {
             /* Yield until the job is cancelled.  We just let our before_write
              * notify callback service CoW requests. */
             block_job_yield(&job->common);
         }
     } else if (job->sync_mode == MIRROR_SYNC_MODE_INCREMENTAL) {
+        backup_incremental_init_copy_bitmap(job);
         ret = backup_run_incremental(job);
     } else {
+        hbitmap_set(job->copy_bitmap, 0, end);
         /* Both FULL and TOP SYNC_MODE's require copying.. */
         for (; start < end; start++) {
             bool error_is_read;
-- 
1.8.3.1
