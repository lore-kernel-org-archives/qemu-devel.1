Received: from eggs.gnu.org ([2001:4830:134:3::10]:59779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eR2eN-0001s0-0S
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:08:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eR2eL-0003M3-Ua
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:08:38 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Mon, 18 Dec 2017 16:08:12 -0500
Message-Id: <20171218210819.31576-4-jcody@redhat.com>
In-Reply-To: <20171218210819.31576-1-jcody@redhat.com>
References: <20171218210819.31576-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 03/10] backup: init copy_bitmap from sync_bitmap
 for incremental
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

We should not copy non-dirty clusters in write notifiers. So,
initialize copy_bitmap from sync_bitmap.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20171012135313.227864-4-vsementsov@virtuozzo.com
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/backup.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/block/backup.c b/block/backup.c
index 5175808..b8901ea 100644
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
@@ -435,7 +472,12 @@ static void coroutine_fn backup_run(void *opaque)
 
     nb_clusters = DIV_ROUND_UP(job->common.len, job->cluster_size);
     job->copy_bitmap = hbitmap_alloc(nb_clusters, 0);
-    hbitmap_set(job->copy_bitmap, 0, nb_clusters);
+    if (job->sync_mode == MIRROR_SYNC_MODE_INCREMENTAL) {
+        backup_incremental_init_copy_bitmap(job);
+    } else {
+        hbitmap_set(job->copy_bitmap, 0, nb_clusters);
+    }
+
 
     job->before_write.notify = backup_before_write_notify;
     bdrv_add_before_write_notifier(bs, &job->before_write);
-- 
2.9.5
