Received: from eggs.gnu.org ([2001:4830:134:3::10]:58904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cKTE4-0000Ww-TZ
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 12:01:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cKTE4-0005Rn-5l
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 12:01:49 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 23 Dec 2016 17:28:46 +0300
Message-ID: <1482503344-6424-4-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 03/21] backup: improve non-dirty bits progress
 processing
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

Set fake progress for non-dirty clusters in copy_bitmap initialization,
to:
1. set progress in the same place where corresponding clusters are
consumed from copy_bitmap (or not initialized, as here)
2. earlier progress information for user
3. simplify the code

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 621b1c0..f1f87f6 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -383,7 +383,6 @@ static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
     int64_t sector;
     int64_t cluster;
     int64_t end;
-    int64_t last_cluster = -1;
     int64_t sectors_per_cluster = cluster_size_sectors(job);
     BdrvDirtyBitmapIter *dbi;
 
@@ -395,12 +394,6 @@ static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
     while ((sector = bdrv_dirty_iter_next(dbi)) != -1) {
         cluster = sector / sectors_per_cluster;
 
-        /* Fake progress updates for any clusters we skipped */
-        if (cluster != last_cluster + 1) {
-            job->common.offset += ((cluster - last_cluster - 1) *
-                                   job->cluster_size);
-        }
-
         for (end = cluster + clusters_per_iter; cluster < end; cluster++) {
             do {
                 if (yield_and_check(job)) {
@@ -422,14 +415,6 @@ static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
         if (granularity < job->cluster_size) {
             bdrv_set_dirty_iter(dbi, cluster * sectors_per_cluster);
         }
-
-        last_cluster = cluster - 1;
-    }
-
-    /* Play some final catchup with the progress meter */
-    end = DIV_ROUND_UP(job->common.len, job->cluster_size);
-    if (last_cluster + 1 < end) {
-        job->common.offset += ((end - last_cluster - 1) * job->cluster_size);
     }
 
 out:
@@ -462,6 +447,9 @@ static void backup_incremental_init_copy_bitmap(BackupBlockJob *job)
         bdrv_set_dirty_iter(dbi, (cluster + cl_gran) * sectors_per_cluster);
     }
 
+    job->common.offset = job->common.len -
+                         hbitmap_count(job->copy_bitmap) * job->cluster_size;
+
     bdrv_dirty_iter_free(dbi);
 }
 
-- 
1.8.3.1
