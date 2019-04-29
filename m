Received: from eggs.gnu.org ([209.51.188.92]:34069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hL2HL-0002RI-Hp
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:08:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hL2HJ-0003v8-FW
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:08:51 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 29 Apr 2019 12:08:41 +0300
Message-Id: <20190429090842.57910-5-vsementsov@virtuozzo.com>
In-Reply-To: <20190429090842.57910-1-vsementsov@virtuozzo.com>
References: <20190429090842.57910-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v7 4/5] block/backup: unify different modes
 code path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Do full, top and incremental mode copying all in one place. This
unifies the code path and helps further improvements.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/backup.c | 43 ++++++++++---------------------------------
 1 file changed, 10 insertions(+), 33 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 298e85f1a9..b54386b699 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -393,15 +393,23 @@ static bool bdrv_is_unallocated_range(BlockDriverState *bs,
     return offset >= end;
 }
 
-static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
+static int coroutine_fn backup_loop(BackupBlockJob *job)
 {
     int ret;
     bool error_is_read;
     int64_t offset;
     HBitmapIter hbi;
+    BlockDriverState *bs = blk_bs(job->common.blk);
 
     hbitmap_iter_init(&hbi, job->copy_bitmap, 0);
     while ((offset = hbitmap_iter_next(&hbi)) != -1) {
+        if (job->sync_mode == MIRROR_SYNC_MODE_TOP &&
+            bdrv_is_unallocated_range(bs, offset, job->cluster_size))
+        {
+            hbitmap_reset(job->copy_bitmap, offset, job->cluster_size);
+            continue;
+        }
+
         do {
             if (yield_and_check(job)) {
                 return 0;
@@ -446,7 +454,6 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
 {
     BackupBlockJob *s = container_of(job, BackupBlockJob, common.job);
     BlockDriverState *bs = blk_bs(s->common.blk);
-    int64_t offset;
     int ret = 0;
 
     QLIST_INIT(&s->inflight_reqs);
@@ -471,38 +478,8 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
              * notify callback service CoW requests. */
             job_yield(job);
         }
-    } else if (s->sync_mode == MIRROR_SYNC_MODE_INCREMENTAL) {
-        ret = backup_run_incremental(s);
     } else {
-        /* Both FULL and TOP SYNC_MODE's require copying.. */
-        for (offset = 0; offset < s->len;
-             offset += s->cluster_size) {
-            bool error_is_read;
-
-            if (yield_and_check(s)) {
-                break;
-            }
-
-            if (s->sync_mode == MIRROR_SYNC_MODE_TOP &&
-                bdrv_is_unallocated_range(bs, offset, s->cluster_size))
-            {
-                continue;
-            }
-
-            ret = backup_do_cow(s, offset, s->cluster_size,
-                                &error_is_read, false);
-            if (ret < 0) {
-                /* Depending on error action, fail now or retry cluster */
-                BlockErrorAction action =
-                    backup_error_action(s, error_is_read, -ret);
-                if (action == BLOCK_ERROR_ACTION_REPORT) {
-                    break;
-                } else {
-                    offset -= s->cluster_size;
-                    continue;
-                }
-            }
-        }
+        ret = backup_loop(s);
     }
 
     notifier_with_return_remove(&s->before_write);
-- 
2.18.0
