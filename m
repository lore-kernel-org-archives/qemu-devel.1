Received: from eggs.gnu.org ([2001:4830:134:3::10]:58542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cKTDF-0008Dq-BV
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 12:00:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cKTDE-00050f-D5
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 12:00:57 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 23 Dec 2016 17:28:47 +0300
Message-ID: <1482503344-6424-5-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 04/21] backup: use copy_bitmap in incremental
 backup
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

We can use copy_bitmap instead of sync_bitmap. copy_bitmap is
initialized from sync_bitmap and it is more informative: we will not try
to process data, that is already in progress (by write notifier).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c | 58 +++++++++++++++++++---------------------------------------
 1 file changed, 19 insertions(+), 39 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index f1f87f6..938b7df 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -376,50 +376,30 @@ static bool coroutine_fn yield_and_check(BackupBlockJob *job)
 
 static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
 {
+    int ret;
     bool error_is_read;
-    int ret = 0;
-    int clusters_per_iter;
-    uint32_t granularity;
-    int64_t sector;
-    int64_t cluster;
-    int64_t end;
     int64_t sectors_per_cluster = cluster_size_sectors(job);
-    BdrvDirtyBitmapIter *dbi;
-
-    granularity = bdrv_dirty_bitmap_granularity(job->sync_bitmap);
-    clusters_per_iter = MAX((granularity / job->cluster_size), 1);
-    dbi = bdrv_dirty_iter_new(job->sync_bitmap, 0);
-
-    /* Find the next dirty sector(s) */
-    while ((sector = bdrv_dirty_iter_next(dbi)) != -1) {
-        cluster = sector / sectors_per_cluster;
-
-        for (end = cluster + clusters_per_iter; cluster < end; cluster++) {
-            do {
-                if (yield_and_check(job)) {
-                    goto out;
-                }
-                ret = backup_do_cow(job, cluster * sectors_per_cluster,
-                                    sectors_per_cluster, &error_is_read,
-                                    false);
-                if ((ret < 0) &&
-                    backup_error_action(job, error_is_read, -ret) ==
-                    BLOCK_ERROR_ACTION_REPORT) {
-                    goto out;
-                }
-            } while (ret < 0);
-        }
+    int64_t cluster;
+    HBitmapIter hbi;
 
-        /* If the bitmap granularity is smaller than the backup granularity,
-         * we need to advance the iterator pointer to the next cluster. */
-        if (granularity < job->cluster_size) {
-            bdrv_set_dirty_iter(dbi, cluster * sectors_per_cluster);
-        }
+    hbitmap_iter_init(&hbi, job->copy_bitmap, 0);
+    while ((cluster = hbitmap_iter_next(&hbi)) != -1) {
+        do {
+            if (yield_and_check(job)) {
+                return 0;
+            }
+            ret = backup_do_cow(job, cluster * sectors_per_cluster,
+                                sectors_per_cluster, &error_is_read,
+                                false);
+            if ((ret < 0) &&
+                backup_error_action(job, error_is_read, -ret) ==
+                BLOCK_ERROR_ACTION_REPORT) {
+                return ret;
+            }
+        } while (ret < 0);
     }
 
-out:
-    bdrv_dirty_iter_free(dbi);
-    return ret;
+    return 0;
 }
 
 /* init copy_bitmap from sync_bitmap */
-- 
1.8.3.1
