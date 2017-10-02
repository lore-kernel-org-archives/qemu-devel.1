Received: from eggs.gnu.org ([2001:4830:134:3::10]:52141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dz1sX-0001YF-HL
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:39:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dz1sW-000326-Ei
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:39:29 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:24581 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dz1sW-00031R-21
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:39:28 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon,  2 Oct 2017 17:39:17 +0300
Message-Id: <20171002143919.207741-4-vsementsov@virtuozzo.com>
In-Reply-To: <20171002143919.207741-1-vsementsov@virtuozzo.com>
References: <20171002143919.207741-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 3/5] backup: init copy_bitmap from sync_bitmap
 for incremental
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

We should not copy non-dirty clusters in write notifiers. So,
initialize copy_bitmap from sync_bitmap.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/block/backup.c b/block/backup.c
index 08efec639f..07f4ae846b 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -422,6 +422,43 @@ out:
     return ret;
 }
 
+/* init copy_bitmap from sync_bitmap */
+static void backup_incremental_init_copy_bitmap(BackupBlockJob *job)
+{
+    BdrvDirtyBitmapIter *dbi;
+    int64_t offset;
+    int64_t end = DIV_ROUND_UP(bdrv_dirty_bitmap_size(job->sync_bitmap),
+                               job->cluster_size);
+
+    dbi = bdrv_dirty_iter_new(job->sync_bitmap);
+    while ((offset = bdrv_dirty_iter_next(dbi)) != -1) {
+        int64_t cluster = offset / job->cluster_size;
+        int64_t next_cluster;
+
+        offset += bdrv_dirty_bitmap_granularity(job->sync_bitmap);
+        if (offset >= bdrv_dirty_bitmap_size(job->sync_bitmap)) {
+            hbitmap_set(job->copy_bitmap, cluster, end - cluster);
+            break;
+        }
+
+        offset = bdrv_dirty_bitmap_next_zero(job->sync_bitmap, offset);
+        if (offset == -1) {
+            hbitmap_set(job->copy_bitmap, cluster, end - cluster);
+            break;
+        }
+
+        next_cluster = DIV_ROUND_UP(offset, job->cluster_size);
+        hbitmap_set(job->copy_bitmap, cluster, next_cluster - cluster);
+        if (next_cluster >= end) {
+            break;
+        }
+
+        bdrv_set_dirty_iter(dbi, next_cluster * job->cluster_size);
+    }
+
+    bdrv_dirty_iter_free(dbi);
+}
+
 static void coroutine_fn backup_run(void *opaque)
 {
     BackupBlockJob *job = opaque;
@@ -435,20 +472,26 @@ static void coroutine_fn backup_run(void *opaque)
 
     nb_clusters = DIV_ROUND_UP(job->common.len, job->cluster_size);
     job->copy_bitmap = hbitmap_alloc(nb_clusters, 0);
-    hbitmap_set(job->copy_bitmap, 0, nb_clusters);
 
     job->before_write.notify = backup_before_write_notify;
     bdrv_add_before_write_notifier(bs, &job->before_write);
 
     if (job->sync_mode == MIRROR_SYNC_MODE_NONE) {
+        /* Here we set all bits in job->copy_bitmap to allow copying clusters
+         * which are going to be changed (none-mode semantics). It doesn't mean
+         * that we want to copy _all_ clusters.
+         */
+        hbitmap_set(job->copy_bitmap, 0, nb_clusters);
         while (!block_job_is_cancelled(&job->common)) {
             /* Yield until the job is cancelled.  We just let our before_write
              * notify callback service CoW requests. */
             block_job_yield(&job->common);
         }
     } else if (job->sync_mode == MIRROR_SYNC_MODE_INCREMENTAL) {
+        backup_incremental_init_copy_bitmap(job);
         ret = backup_run_incremental(job);
     } else {
+        hbitmap_set(job->copy_bitmap, 0, nb_clusters);
         /* Both FULL and TOP SYNC_MODE's require copying.. */
         for (offset = 0; offset < job->common.len;
              offset += job->cluster_size) {
-- 
2.11.1
