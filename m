Received: from eggs.gnu.org ([2001:4830:134:3::10]:53227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gC5OD-0008JB-VZ
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:06:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gC5OA-000539-LV
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:06:41 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 15 Oct 2018 19:06:23 +0300
Message-Id: <20181015160633.63130-2-vsementsov@virtuozzo.com>
In-Reply-To: <20181015160633.63130-1-vsementsov@virtuozzo.com>
References: <20181015160633.63130-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 01/11] block/backup: simplify
 backup_incremental_init_copy_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com, jcody@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, eblake@redhat.com

Simplify backup_incremental_init_copy_bitmap using the function
bdrv_dirty_bitmap_next_dirty_area.

Note: move to job->len instead of bitmap size: it should not matter but
less code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c | 40 ++++++++++++----------------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 435414e964..fbe7ce19e1 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -406,43 +406,27 @@ static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
 /* init copy_bitmap from sync_bitmap */
 static void backup_incremental_init_copy_bitmap(BackupBlockJob *job)
 {
-    BdrvDirtyBitmapIter *dbi;
-    int64_t offset;
-    int64_t end = DIV_ROUND_UP(bdrv_dirty_bitmap_size(job->sync_bitmap),
-                               job->cluster_size);
-
-    dbi = bdrv_dirty_iter_new(job->sync_bitmap);
-    while ((offset = bdrv_dirty_iter_next(dbi)) != -1) {
-        int64_t cluster = offset / job->cluster_size;
-        int64_t next_cluster;
-
-        offset += bdrv_dirty_bitmap_granularity(job->sync_bitmap);
-        if (offset >= bdrv_dirty_bitmap_size(job->sync_bitmap)) {
-            hbitmap_set(job->copy_bitmap, cluster, end - cluster);
-            break;
-        }
+    uint64_t offset = 0;
+    uint64_t bytes = job->len;
 
-        offset = bdrv_dirty_bitmap_next_zero(job->sync_bitmap, offset,
-                                             UINT64_MAX);
-        if (offset == -1) {
-            hbitmap_set(job->copy_bitmap, cluster, end - cluster);
-            break;
-        }
+    while (bdrv_dirty_bitmap_next_dirty_area(job->sync_bitmap,
+                                             &offset, &bytes))
+    {
+        uint64_t cluster = offset / job->cluster_size;
+        uint64_t last_cluster = (offset + bytes) / job->cluster_size;
 
-        next_cluster = DIV_ROUND_UP(offset, job->cluster_size);
-        hbitmap_set(job->copy_bitmap, cluster, next_cluster - cluster);
-        if (next_cluster >= end) {
+        hbitmap_set(job->copy_bitmap, cluster, last_cluster - cluster + 1);
+
+        offset = (last_cluster + 1) * job->cluster_size;
+        if (offset >= job->len) {
             break;
         }
-
-        bdrv_set_dirty_iter(dbi, next_cluster * job->cluster_size);
+        bytes = job->len - offset;
     }
 
     /* TODO job_progress_set_remaining() would make more sense */
     job_progress_update(&job->common.job,
         job->len - hbitmap_count(job->copy_bitmap) * job->cluster_size);
-
-    bdrv_dirty_iter_free(dbi);
 }
 
 static int coroutine_fn backup_run(Job *job, Error **errp)
-- 
2.18.0
