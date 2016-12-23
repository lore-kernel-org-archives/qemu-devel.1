Received: from eggs.gnu.org ([2001:4830:134:3::10]:37064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cKRnc-0006n7-Kr
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 10:30:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cKRnb-0004fW-PV
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 10:30:24 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 23 Dec 2016 17:29:03 +0300
Message-ID: <1482503344-6424-21-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 20/21] backup: move bitmap handling from
 backup_do_cow to get_work
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 900bbd3..b79a481 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -383,19 +383,24 @@ static inline int64_t backup_get_work(BackupBlockJob *job)
     }
 
     cluster = next_notif_cluster(job);
-    if (cluster != -1) {
-        return cluster;
-    }
+    if (cluster == -1) {
+        if (block_job_should_pause(&job->common) ||
+            job->sync_mode == MIRROR_SYNC_MODE_NONE || check_delay(job))
+        {
+            return BACKUP_WORKER_PAUSE;
+        }
 
-    if (block_job_should_pause(&job->common) ||
-        job->sync_mode == MIRROR_SYNC_MODE_NONE || check_delay(job))
-    {
-        return BACKUP_WORKER_PAUSE;
+        cluster = hbitmap_iter_next(&job->linear_hbi);
+        if (cluster == -1) {
+            return BACKUP_WORKER_STOP;
+        }
     }
 
-    cluster = hbitmap_iter_next(&job->linear_hbi);
+    assert(hbitmap_get(job->copy_bitmap, cluster));
+    hbitmap_reset(job->copy_bitmap, cluster, 1);
+    set_bit(cluster, job->notif_wait_bitmap);
 
-    return cluster == -1 ? BACKUP_WORKER_STOP : cluster;
+    return cluster;
 }
 
 static void coroutine_fn backup_worker_co(void *opaque)
@@ -583,13 +588,6 @@ static void coroutine_fn backup_do_cow(BackupBlockJob *job, int64_t cluster)
 
     trace_backup_do_cow_enter(job, qemu_coroutine_self(), cluster);
 
-    if (!hbitmap_get(job->copy_bitmap, cluster)) {
-        trace_backup_do_cow_skip(job, cluster);
-        return; /* already copied */
-    }
-    hbitmap_reset(job->copy_bitmap, cluster, 1);
-    set_bit(cluster, job->notif_wait_bitmap);
-
     bounce_buffer = blk_blockalign(blk, job->cluster_size);
     backup_copy_cluster(job, cluster, bounce_buffer);
     qemu_vfree(bounce_buffer);
-- 
1.8.3.1
