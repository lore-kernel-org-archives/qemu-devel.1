Received: from eggs.gnu.org ([2001:4830:134:3::10]:52126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dz1sW-0001Xj-UP
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:39:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dz1sU-00031D-BP
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:39:28 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:3879 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dz1sT-0002yr-7H
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:39:26 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon,  2 Oct 2017 17:39:19 +0300
Message-Id: <20171002143919.207741-6-vsementsov@virtuozzo.com>
In-Reply-To: <20171002143919.207741-1-vsementsov@virtuozzo.com>
References: <20171002143919.207741-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 5/5] backup: use copy_bitmap in incremental
 backup
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, famz@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, stefanha@redhat.com, den@openvz.org, vsementsov@virtuozzo.com
List-ID: <qemu-devel.nongnu.org>

We can use copy_bitmap instead of sync_bitmap. copy_bitmap is
initialized from sync_bitmap and it is more informative: we will not try
to process data, that is already in progress (by write notifier).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/backup.c | 55 +++++++++++++++++--------------------------------------
 1 file changed, 17 insertions(+), 38 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 52df7bb19e..c933cfafc3 100644
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
-
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
+    HBitmapIter hbi;
 
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
2.11.1
