Received: from eggs.gnu.org ([2001:4830:134:3::10]:59867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eR2eR-0001vK-4p
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:08:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eR2eP-0003PL-Lu
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:08:42 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Mon, 18 Dec 2017 16:08:14 -0500
Message-Id: <20171218210819.31576-6-jcody@redhat.com>
In-Reply-To: <20171218210819.31576-1-jcody@redhat.com>
References: <20171218210819.31576-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 05/10] backup: use copy_bitmap in incremental
 backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com, qemu-devel@nongnu.org

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

We can use copy_bitmap instead of sync_bitmap. copy_bitmap is
initialized from sync_bitmap and it is more informative: we will not try
to process data, that is already in progress (by write notifier).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Message-id: 20171012135313.227864-6-vsementsov@virtuozzo.com
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/backup.c | 55 +++++++++++++++++--------------------------------------
 1 file changed, 17 insertions(+), 38 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 8ee2200..4a16a37 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -362,49 +362,28 @@ static bool coroutine_fn yield_and_check(BackupBlockJob *job)
 
 static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
 {
+    int ret;
     bool error_is_read;
-    int ret = 0;
-    int clusters_per_iter;
-    uint32_t granularity;
-    int64_t offset;
     int64_t cluster;
-    int64_t end;
-    BdrvDirtyBitmapIter *dbi;
+    HBitmapIter hbi;
 
-    granularity = bdrv_dirty_bitmap_granularity(job->sync_bitmap);
-    clusters_per_iter = MAX((granularity / job->cluster_size), 1);
-    dbi = bdrv_dirty_iter_new(job->sync_bitmap);
-
-    /* Find the next dirty sector(s) */
-    while ((offset = bdrv_dirty_iter_next(dbi)) >= 0) {
-        cluster = offset / job->cluster_size;
-
-        for (end = cluster + clusters_per_iter; cluster < end; cluster++) {
-            do {
-                if (yield_and_check(job)) {
-                    goto out;
-                }
-                ret = backup_do_cow(job, cluster * job->cluster_size,
-                                    job->cluster_size, &error_is_read,
-                                    false);
-                if ((ret < 0) &&
-                    backup_error_action(job, error_is_read, -ret) ==
-                    BLOCK_ERROR_ACTION_REPORT) {
-                    goto out;
-                }
-            } while (ret < 0);
-        }
-
-        /* If the bitmap granularity is smaller than the backup granularity,
-         * we need to advance the iterator pointer to the next cluster. */
-        if (granularity < job->cluster_size) {
-            bdrv_set_dirty_iter(dbi, cluster * job->cluster_size);
-        }
+    hbitmap_iter_init(&hbi, job->copy_bitmap, 0);
+    while ((cluster = hbitmap_iter_next(&hbi)) != -1) {
+        do {
+            if (yield_and_check(job)) {
+                return 0;
+            }
+            ret = backup_do_cow(job, cluster * job->cluster_size,
+                                job->cluster_size, &error_is_read, false);
+            if (ret < 0 && backup_error_action(job, error_is_read, -ret) ==
+                           BLOCK_ERROR_ACTION_REPORT)
+            {
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
2.9.5
