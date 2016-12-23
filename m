Received: from eggs.gnu.org ([2001:4830:134:3::10]:40371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cKUAF-00005N-Qr
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 13:02:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cKUAE-0004V2-U6
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 13:01:55 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 23 Dec 2016 17:28:50 +0300
Message-ID: <1482503344-6424-8-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 07/21] backup: refactor: merge
 top/full/incremental backup code
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

Merge top/full/incremental modes backup into one backup_loop.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c | 41 +++++++++--------------------------------
 1 file changed, 9 insertions(+), 32 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index e2b944a..2afd1b6 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -474,7 +474,7 @@ static void backup_skip_loop(BackupBlockJob *job, BlockDriverState *base)
     }
 }
 
-static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
+static int coroutine_fn backup_loop(BackupBlockJob *job)
 {
     int ret;
     bool error_is_read;
@@ -538,14 +538,12 @@ static void coroutine_fn backup_run(void *opaque)
     BackupBlockJob *job = opaque;
     BackupCompleteData *data;
     BlockDriverState *bs = blk_bs(job->common.blk);
-    int64_t start, end;
-    int64_t sectors_per_cluster = cluster_size_sectors(job);
+    int64_t end;
     int ret = 0;
 
     QLIST_INIT(&job->inflight_reqs);
     qemu_co_rwlock_init(&job->flush_rwlock);
 
-    start = 0;
     end = DIV_ROUND_UP(job->common.len, job->cluster_size);
 
     job->copy_bitmap = hbitmap_alloc(end, 0);
@@ -560,37 +558,16 @@ static void coroutine_fn backup_run(void *opaque)
              * notify callback service CoW requests. */
             block_job_yield(&job->common);
         }
-    } else if (job->sync_mode == MIRROR_SYNC_MODE_INCREMENTAL) {
-        backup_incremental_init_copy_bitmap(job);
-        ret = backup_run_incremental(job);
     } else {
-        hbitmap_set(job->copy_bitmap, 0, end);
-        if (job->sync_mode == MIRROR_SYNC_MODE_TOP) {
-            backup_skip_loop(job, backing_bs(blk_bs(job->common.blk)));
-        }
-
-        /* Both FULL and TOP SYNC_MODE's require copying.. */
-        for (; start < end; start++) {
-            bool error_is_read;
-            if (yield_and_check(job)) {
-                break;
-            }
-
-            /* FULL sync mode we copy the whole drive. */
-            ret = backup_do_cow(job, start * sectors_per_cluster,
-                                sectors_per_cluster, &error_is_read, false);
-            if (ret < 0) {
-                /* Depending on error action, fail now or retry cluster */
-                BlockErrorAction action =
-                    backup_error_action(job, error_is_read, -ret);
-                if (action == BLOCK_ERROR_ACTION_REPORT) {
-                    break;
-                } else {
-                    start--;
-                    continue;
-                }
+        if (job->sync_mode == MIRROR_SYNC_MODE_INCREMENTAL) {
+            backup_incremental_init_copy_bitmap(job);
+        } else {
+            hbitmap_set(job->copy_bitmap, 0, end);
+            if (job->sync_mode == MIRROR_SYNC_MODE_TOP) {
+                backup_skip_loop(job, backing_bs(blk_bs(job->common.blk)));
             }
         }
+        ret = backup_loop(job);
     }
 
     notifier_with_return_remove(&job->before_write);
-- 
1.8.3.1
