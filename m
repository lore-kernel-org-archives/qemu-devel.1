Received: from eggs.gnu.org ([2001:4830:134:3::10]:59858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e2dvX-0007xy-U6
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:53:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e2dvW-0004w1-S2
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:53:31 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:46410 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1e2dvW-0004v9-F6
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:53:30 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 12 Oct 2017 16:53:11 +0300
Message-Id: <20171012135313.227864-4-vsementsov@virtuozzo.com>
In-Reply-To: <20171012135313.227864-1-vsementsov@virtuozzo.com>
References: <20171012135313.227864-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 3/5] backup: init copy_bitmap from sync_bitmap
 for incremental
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: jsnow@redhat.com, famz@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, stefanha@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

We should not copy non-dirty clusters in write notifiers. So,
initialize copy_bitmap from sync_bitmap.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/block/backup.c b/block/backup.c
index 6fdb4c33f7..71ad59b417 100644
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
2.11.1
