Received: from eggs.gnu.org ([2001:4830:134:3::10]:55640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fsxn0-0001cY-2W
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 18:09:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fsxmy-0001xj-FV
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 18:09:14 -0400
From: John Snow <jsnow@redhat.com>
Date: Thu, 23 Aug 2018 18:08:54 -0400
Message-Id: <20180823220856.10094-8-jsnow@redhat.com>
In-Reply-To: <20180823220856.10094-1-jsnow@redhat.com>
References: <20180823220856.10094-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 7/9] block/backup: make function variables
 consistently named
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, jtc@redhat.com, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

Rename opaque_job to job to be consistent with other job implementations.
Rename 'job', the BackupBlockJob object, to 's' to also be consistent.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/backup.c | 62 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index a67b7fa96b..4d084f6ca6 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -468,59 +468,59 @@ static void backup_incremental_init_copy_bitmap(BackupBlockJob *job)
     bdrv_dirty_iter_free(dbi);
 }
 
-static int coroutine_fn backup_run(Job *opaque_job, Error **errp)
+static int coroutine_fn backup_run(Job *job, Error **errp)
 {
-    BackupBlockJob *job = container_of(opaque_job, BackupBlockJob, common.job);
-    BlockDriverState *bs = blk_bs(job->common.blk);
+    BackupBlockJob *s = container_of(job, BackupBlockJob, common.job);
+    BlockDriverState *bs = blk_bs(s->common.blk);
     int64_t offset, nb_clusters;
     int ret = 0;
 
-    QLIST_INIT(&job->inflight_reqs);
-    qemu_co_rwlock_init(&job->flush_rwlock);
+    QLIST_INIT(&s->inflight_reqs);
+    qemu_co_rwlock_init(&s->flush_rwlock);
 
-    nb_clusters = DIV_ROUND_UP(job->len, job->cluster_size);
-    job_progress_set_remaining(&job->common.job, job->len);
+    nb_clusters = DIV_ROUND_UP(s->len, s->cluster_size);
+    job_progress_set_remaining(job, s->len);
 
-    job->copy_bitmap = hbitmap_alloc(nb_clusters, 0);
-    if (job->sync_mode == MIRROR_SYNC_MODE_INCREMENTAL) {
-        backup_incremental_init_copy_bitmap(job);
+    s->copy_bitmap = hbitmap_alloc(nb_clusters, 0);
+    if (s->sync_mode == MIRROR_SYNC_MODE_INCREMENTAL) {
+        backup_incremental_init_copy_bitmap(s);
     } else {
-        hbitmap_set(job->copy_bitmap, 0, nb_clusters);
+        hbitmap_set(s->copy_bitmap, 0, nb_clusters);
     }
 
 
-    job->before_write.notify = backup_before_write_notify;
-    bdrv_add_before_write_notifier(bs, &job->before_write);
+    s->before_write.notify = backup_before_write_notify;
+    bdrv_add_before_write_notifier(bs, &s->before_write);
 
-    if (job->sync_mode == MIRROR_SYNC_MODE_NONE) {
+    if (s->sync_mode == MIRROR_SYNC_MODE_NONE) {
         /* All bits are set in copy_bitmap to allow any cluster to be copied.
          * This does not actually require them to be copied. */
-        while (!job_is_cancelled(&job->common.job)) {
+        while (!job_is_cancelled(job)) {
             /* Yield until the job is cancelled.  We just let our before_write
              * notify callback service CoW requests. */
-            job_yield(&job->common.job);
+            job_yield(job);
         }
-    } else if (job->sync_mode == MIRROR_SYNC_MODE_INCREMENTAL) {
-        ret = backup_run_incremental(job);
+    } else if (s->sync_mode == MIRROR_SYNC_MODE_INCREMENTAL) {
+        ret = backup_run_incremental(s);
     } else {
         /* Both FULL and TOP SYNC_MODE's require copying.. */
-        for (offset = 0; offset < job->len;
-             offset += job->cluster_size) {
+        for (offset = 0; offset < s->len;
+             offset += s->cluster_size) {
             bool error_is_read;
             int alloced = 0;
 
-            if (yield_and_check(job)) {
+            if (yield_and_check(s)) {
                 break;
             }
 
-            if (job->sync_mode == MIRROR_SYNC_MODE_TOP) {
+            if (s->sync_mode == MIRROR_SYNC_MODE_TOP) {
                 int i;
                 int64_t n;
 
                 /* Check to see if these blocks are already in the
                  * backing file. */
 
-                for (i = 0; i < job->cluster_size;) {
+                for (i = 0; i < s->cluster_size;) {
                     /* bdrv_is_allocated() only returns true/false based
                      * on the first set of sectors it comes across that
                      * are are all in the same state.
@@ -529,7 +529,7 @@ static int coroutine_fn backup_run(Job *opaque_job, Error **errp)
                      * needed but at some point that is always the case. */
                     alloced =
                         bdrv_is_allocated(bs, offset + i,
-                                          job->cluster_size - i, &n);
+                                          s->cluster_size - i, &n);
                     i += n;
 
                     if (alloced || n == 0) {
@@ -547,29 +547,29 @@ static int coroutine_fn backup_run(Job *opaque_job, Error **errp)
             if (alloced < 0) {
                 ret = alloced;
             } else {
-                ret = backup_do_cow(job, offset, job->cluster_size,
+                ret = backup_do_cow(s, offset, s->cluster_size,
                                     &error_is_read, false);
             }
             if (ret < 0) {
                 /* Depending on error action, fail now or retry cluster */
                 BlockErrorAction action =
-                    backup_error_action(job, error_is_read, -ret);
+                    backup_error_action(s, error_is_read, -ret);
                 if (action == BLOCK_ERROR_ACTION_REPORT) {
                     break;
                 } else {
-                    offset -= job->cluster_size;
+                    offset -= s->cluster_size;
                     continue;
                 }
             }
         }
     }
 
-    notifier_with_return_remove(&job->before_write);
+    notifier_with_return_remove(&s->before_write);
 
     /* wait until pending backup_do_cow() calls have completed */
-    qemu_co_rwlock_wrlock(&job->flush_rwlock);
-    qemu_co_rwlock_unlock(&job->flush_rwlock);
-    hbitmap_free(job->copy_bitmap);
+    qemu_co_rwlock_wrlock(&s->flush_rwlock);
+    qemu_co_rwlock_unlock(&s->flush_rwlock);
+    hbitmap_free(s->copy_bitmap);
 
     return ret;
 }
-- 
2.14.4
