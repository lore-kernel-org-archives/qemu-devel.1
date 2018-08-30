Received: from eggs.gnu.org ([2001:4830:134:3::10]:49737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fvCDc-00013d-D6
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 21:57:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fvCDa-0006mR-UW
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 21:57:56 -0400
From: John Snow <jsnow@redhat.com>
Date: Wed, 29 Aug 2018 21:57:31 -0400
Message-Id: <20180830015734.19765-7-jsnow@redhat.com>
In-Reply-To: <20180830015734.19765-1-jsnow@redhat.com>
References: <20180830015734.19765-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v3 6/9] jobs: utilize job_exit shim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, jtc@redhat.com, John Snow <jsnow@redhat.com>

Utilize the job_exit shim by not calling job_defer_to_main_loop, and
where applicable, converting the deferred callback into the job_exit
callback.

This converts backup, stream, create, and the unit tests all at once.
Most of these jobs do not see any changes to the order in which they
clean up their resources, except the test-blockjob-txn test, which
now puts down its bs before job_completed is called.

This is safe for the same reason the reordering in the mirror job is
safe, because job_completed no longer runs under two locks, making
the unref safe even if it causes a flush.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/backup.c            | 16 ----------------
 block/create.c            | 14 +++-----------
 block/stream.c            | 22 +++++++---------------
 tests/test-bdrv-drain.c   |  6 ------
 tests/test-blockjob-txn.c | 11 ++---------
 tests/test-blockjob.c     | 10 ++++------
 6 files changed, 16 insertions(+), 63 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 1e965d54e5..a67b7fa96b 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -380,18 +380,6 @@ static BlockErrorAction backup_error_action(BackupBlockJob *job,
     }
 }
 
-typedef struct {
-    int ret;
-} BackupCompleteData;
-
-static void backup_complete(Job *job, void *opaque)
-{
-    BackupCompleteData *data = opaque;
-
-    job_completed(job, data->ret);
-    g_free(data);
-}
-
 static bool coroutine_fn yield_and_check(BackupBlockJob *job)
 {
     uint64_t delay_ns;
@@ -483,7 +471,6 @@ static void backup_incremental_init_copy_bitmap(BackupBlockJob *job)
 static int coroutine_fn backup_run(Job *opaque_job, Error **errp)
 {
     BackupBlockJob *job = container_of(opaque_job, BackupBlockJob, common.job);
-    BackupCompleteData *data;
     BlockDriverState *bs = blk_bs(job->common.blk);
     int64_t offset, nb_clusters;
     int ret = 0;
@@ -584,9 +571,6 @@ static int coroutine_fn backup_run(Job *opaque_job, Error **errp)
     qemu_co_rwlock_unlock(&job->flush_rwlock);
     hbitmap_free(job->copy_bitmap);
 
-    data = g_malloc(sizeof(*data));
-    data->ret = ret;
-    job_defer_to_main_loop(&job->common.job, backup_complete, data);
     return ret;
 }
 
diff --git a/block/create.c b/block/create.c
index 26a385c6c7..95341219ef 100644
--- a/block/create.c
+++ b/block/create.c
@@ -34,28 +34,20 @@ typedef struct BlockdevCreateJob {
     Job common;
     BlockDriver *drv;
     BlockdevCreateOptions *opts;
-    int ret;
 } BlockdevCreateJob;
 
-static void blockdev_create_complete(Job *job, void *opaque)
-{
-    BlockdevCreateJob *s = container_of(job, BlockdevCreateJob, common);
-
-    job_completed(job, s->ret);
-}
-
 static int coroutine_fn blockdev_create_run(Job *job, Error **errp)
 {
     BlockdevCreateJob *s = container_of(job, BlockdevCreateJob, common);
+    int ret;
 
     job_progress_set_remaining(&s->common, 1);
-    s->ret = s->drv->bdrv_co_create(s->opts, errp);
+    ret = s->drv->bdrv_co_create(s->opts, errp);
     job_progress_update(&s->common, 1);
 
     qapi_free_BlockdevCreateOptions(s->opts);
-    job_defer_to_main_loop(&s->common, blockdev_create_complete, NULL);
 
-    return s->ret;
+    return ret;
 }
 
 static const JobDriver blockdev_create_job_driver = {
diff --git a/block/stream.c b/block/stream.c
index 26a775386b..67e1e72e23 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -54,20 +54,16 @@ static int coroutine_fn stream_populate(BlockBackend *blk,
     return blk_co_preadv(blk, offset, qiov.size, &qiov, BDRV_REQ_COPY_ON_READ);
 }
 
-typedef struct {
-    int ret;
-} StreamCompleteData;
-
-static void stream_complete(Job *job, void *opaque)
+static void stream_exit(Job *job)
 {
     StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
     BlockJob *bjob = &s->common;
-    StreamCompleteData *data = opaque;
     BlockDriverState *bs = blk_bs(bjob->blk);
     BlockDriverState *base = s->base;
     Error *local_err = NULL;
+    int ret = job->ret;
 
-    if (!job_is_cancelled(job) && bs->backing && data->ret == 0) {
+    if (!job_is_cancelled(job) && bs->backing && ret == 0) {
         const char *base_id = NULL, *base_fmt = NULL;
         if (base) {
             base_id = s->backing_file_str;
@@ -75,11 +71,11 @@ static void stream_complete(Job *job, void *opaque)
                 base_fmt = base->drv->format_name;
             }
         }
-        data->ret = bdrv_change_backing_file(bs, base_id, base_fmt);
+        ret = bdrv_change_backing_file(bs, base_id, base_fmt);
         bdrv_set_backing_hd(bs, base, &local_err);
         if (local_err) {
             error_report_err(local_err);
-            data->ret = -EPERM;
+            ret = -EPERM;
             goto out;
         }
     }
@@ -93,14 +89,12 @@ out:
     }
 
     g_free(s->backing_file_str);
-    job_completed(job, data->ret);
-    g_free(data);
+    job->ret = ret;
 }
 
 static int coroutine_fn stream_run(Job *job, Error **errp)
 {
     StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
-    StreamCompleteData *data;
     BlockBackend *blk = s->common.blk;
     BlockDriverState *bs = blk_bs(blk);
     BlockDriverState *base = s->base;
@@ -203,9 +197,6 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
 
 out:
     /* Modify backing chain and close BDSes in main loop */
-    data = g_malloc(sizeof(*data));
-    data->ret = ret;
-    job_defer_to_main_loop(&s->common.job, stream_complete, data);
     return ret;
 }
 
@@ -215,6 +206,7 @@ static const BlockJobDriver stream_job_driver = {
         .job_type      = JOB_TYPE_STREAM,
         .free          = block_job_free,
         .run           = stream_run,
+        .exit          = stream_exit,
         .user_resume   = block_job_user_resume,
         .drain         = block_job_drain,
     },
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 00604dfc0c..9bcb3c72af 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -752,11 +752,6 @@ typedef struct TestBlockJob {
     bool should_complete;
 } TestBlockJob;
 
-static void test_job_completed(Job *job, void *opaque)
-{
-    job_completed(job, 0);
-}
-
 static int coroutine_fn test_job_run(Job *job, Error **errp)
 {
     TestBlockJob *s = container_of(job, TestBlockJob, common.job);
@@ -770,7 +765,6 @@ static int coroutine_fn test_job_run(Job *job, Error **errp)
         job_pause_point(&s->common.job);
     }
 
-    job_defer_to_main_loop(&s->common.job, test_job_completed, NULL);
     return 0;
 }
 
diff --git a/tests/test-blockjob-txn.c b/tests/test-blockjob-txn.c
index 82cedee78b..ef29f35e44 100644
--- a/tests/test-blockjob-txn.c
+++ b/tests/test-blockjob-txn.c
@@ -24,17 +24,11 @@ typedef struct {
     int *result;
 } TestBlockJob;
 
-static void test_block_job_complete(Job *job, void *opaque)
+static void test_block_job_exit(Job *job)
 {
     BlockJob *bjob = container_of(job, BlockJob, job);
     BlockDriverState *bs = blk_bs(bjob->blk);
-    int rc = (intptr_t)opaque;
 
-    if (job_is_cancelled(job)) {
-        rc = -ECANCELED;
-    }
-
-    job_completed(job, rc);
     bdrv_unref(bs);
 }
 
@@ -54,8 +48,6 @@ static int coroutine_fn test_block_job_run(Job *job, Error **errp)
         }
     }
 
-    job_defer_to_main_loop(job, test_block_job_complete,
-                           (void *)(intptr_t)s->rc);
     return s->rc;
 }
 
@@ -81,6 +73,7 @@ static const BlockJobDriver test_block_job_driver = {
         .user_resume   = block_job_user_resume,
         .drain         = block_job_drain,
         .run           = test_block_job_run,
+        .exit          = test_block_job_exit,
     },
 };
 
diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
index 408a226939..ad4a65bc78 100644
--- a/tests/test-blockjob.c
+++ b/tests/test-blockjob.c
@@ -163,11 +163,10 @@ typedef struct CancelJob {
     bool completed;
 } CancelJob;
 
-static void cancel_job_completed(Job *job, void *opaque)
+static void cancel_job_exit(Job *job)
 {
-    CancelJob *s = opaque;
+    CancelJob *s = container_of(job, CancelJob, common.job);
     s->completed = true;
-    job_completed(job, 0);
 }
 
 static void cancel_job_complete(Job *job, Error **errp)
@@ -182,7 +181,7 @@ static int coroutine_fn cancel_job_run(Job *job, Error **errp)
 
     while (!s->should_complete) {
         if (job_is_cancelled(&s->common.job)) {
-            goto defer;
+            return 0;
         }
 
         if (!job_is_ready(&s->common.job) && s->should_converge) {
@@ -192,8 +191,6 @@ static int coroutine_fn cancel_job_run(Job *job, Error **errp)
         job_sleep_ns(&s->common.job, 100000);
     }
 
- defer:
-    job_defer_to_main_loop(&s->common.job, cancel_job_completed, s);
     return 0;
 }
 
@@ -204,6 +201,7 @@ static const BlockJobDriver test_cancel_driver = {
         .user_resume   = block_job_user_resume,
         .drain         = block_job_drain,
         .run           = cancel_job_run,
+        .exit          = cancel_job_exit,
         .complete      = cancel_job_complete,
     },
 };
-- 
2.14.4
