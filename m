Received: from eggs.gnu.org ([2001:4830:134:3::10]:49684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fvCDX-000119-E2
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 21:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fvCDU-0006h8-O1
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 21:57:51 -0400
From: John Snow <jsnow@redhat.com>
Date: Wed, 29 Aug 2018 21:57:26 -0400
Message-Id: <20180830015734.19765-2-jsnow@redhat.com>
In-Reply-To: <20180830015734.19765-1-jsnow@redhat.com>
References: <20180830015734.19765-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/9] jobs: change start callback to run
 callback
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

Presently we codify the entry point for a job as the "start" callback,
but a more apt name would be "run" to clarify the idea that when this
function returns we consider the job to have "finished," except for
any cleanup which occurs in separate callbacks later.

As part of this clarification, change the signature to include an error
object and a return code. The error ptr is not yet used, and the return
code while captured, will be overwritten by actions in the job_completed
function.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/backup.c            |  7 ++++---
 block/commit.c            |  7 ++++---
 block/create.c            |  8 +++++---
 block/mirror.c            | 10 ++++++----
 block/stream.c            |  7 ++++---
 include/qemu/job.h        |  2 +-
 job.c                     |  6 +++---
 tests/test-bdrv-drain.c   |  7 ++++---
 tests/test-blockjob-txn.c | 16 ++++++++--------
 tests/test-blockjob.c     |  7 ++++---
 10 files changed, 43 insertions(+), 34 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 8630d32926..5d47781840 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -480,9 +480,9 @@ static void backup_incremental_init_copy_bitmap(BackupBlockJob *job)
     bdrv_dirty_iter_free(dbi);
 }
 
-static void coroutine_fn backup_run(void *opaque)
+static int coroutine_fn backup_run(Job *opaque_job, Error **errp)
 {
-    BackupBlockJob *job = opaque;
+    BackupBlockJob *job = container_of(opaque_job, BackupBlockJob, common.job);
     BackupCompleteData *data;
     BlockDriverState *bs = blk_bs(job->common.blk);
     int64_t offset, nb_clusters;
@@ -587,6 +587,7 @@ static void coroutine_fn backup_run(void *opaque)
     data = g_malloc(sizeof(*data));
     data->ret = ret;
     job_defer_to_main_loop(&job->common.job, backup_complete, data);
+    return ret;
 }
 
 static const BlockJobDriver backup_job_driver = {
@@ -596,7 +597,7 @@ static const BlockJobDriver backup_job_driver = {
         .free                   = block_job_free,
         .user_resume            = block_job_user_resume,
         .drain                  = block_job_drain,
-        .start                  = backup_run,
+        .run                    = backup_run,
         .commit                 = backup_commit,
         .abort                  = backup_abort,
         .clean                  = backup_clean,
diff --git a/block/commit.c b/block/commit.c
index eb414579bd..a0ea86ff64 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -134,9 +134,9 @@ static void commit_complete(Job *job, void *opaque)
     bdrv_unref(top);
 }
 
-static void coroutine_fn commit_run(void *opaque)
+static int coroutine_fn commit_run(Job *job, Error **errp)
 {
-    CommitBlockJob *s = opaque;
+    CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
     CommitCompleteData *data;
     int64_t offset;
     uint64_t delay_ns = 0;
@@ -213,6 +213,7 @@ out:
     data = g_malloc(sizeof(*data));
     data->ret = ret;
     job_defer_to_main_loop(&s->common.job, commit_complete, data);
+    return ret;
 }
 
 static const BlockJobDriver commit_job_driver = {
@@ -222,7 +223,7 @@ static const BlockJobDriver commit_job_driver = {
         .free          = block_job_free,
         .user_resume   = block_job_user_resume,
         .drain         = block_job_drain,
-        .start         = commit_run,
+        .run           = commit_run,
     },
 };
 
diff --git a/block/create.c b/block/create.c
index 915cd41bcc..04733c3618 100644
--- a/block/create.c
+++ b/block/create.c
@@ -45,9 +45,9 @@ static void blockdev_create_complete(Job *job, void *opaque)
     job_completed(job, s->ret, s->err);
 }
 
-static void coroutine_fn blockdev_create_run(void *opaque)
+static int coroutine_fn blockdev_create_run(Job *job, Error **errp)
 {
-    BlockdevCreateJob *s = opaque;
+    BlockdevCreateJob *s = container_of(job, BlockdevCreateJob, common);
 
     job_progress_set_remaining(&s->common, 1);
     s->ret = s->drv->bdrv_co_create(s->opts, &s->err);
@@ -55,12 +55,14 @@ static void coroutine_fn blockdev_create_run(void *opaque)
 
     qapi_free_BlockdevCreateOptions(s->opts);
     job_defer_to_main_loop(&s->common, blockdev_create_complete, NULL);
+
+    return s->ret;
 }
 
 static const JobDriver blockdev_create_job_driver = {
     .instance_size = sizeof(BlockdevCreateJob),
     .job_type      = JOB_TYPE_CREATE,
-    .start         = blockdev_create_run,
+    .run           = blockdev_create_run,
 };
 
 void qmp_blockdev_create(const char *job_id, BlockdevCreateOptions *options,
diff --git a/block/mirror.c b/block/mirror.c
index 6cc10df5c9..691763db41 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -812,9 +812,9 @@ static int mirror_flush(MirrorBlockJob *s)
     return ret;
 }
 
-static void coroutine_fn mirror_run(void *opaque)
+static int coroutine_fn mirror_run(Job *job, Error **errp)
 {
-    MirrorBlockJob *s = opaque;
+    MirrorBlockJob *s = container_of(job, MirrorBlockJob, common.job);
     MirrorExitData *data;
     BlockDriverState *bs = s->mirror_top_bs->backing->bs;
     BlockDriverState *target_bs = blk_bs(s->target);
@@ -1041,7 +1041,9 @@ immediate_exit:
     if (need_drain) {
         bdrv_drained_begin(bs);
     }
+
     job_defer_to_main_loop(&s->common.job, mirror_exit, data);
+    return ret;
 }
 
 static void mirror_complete(Job *job, Error **errp)
@@ -1138,7 +1140,7 @@ static const BlockJobDriver mirror_job_driver = {
         .free                   = block_job_free,
         .user_resume            = block_job_user_resume,
         .drain                  = block_job_drain,
-        .start                  = mirror_run,
+        .run                    = mirror_run,
         .pause                  = mirror_pause,
         .complete               = mirror_complete,
     },
@@ -1154,7 +1156,7 @@ static const BlockJobDriver commit_active_job_driver = {
         .free                   = block_job_free,
         .user_resume            = block_job_user_resume,
         .drain                  = block_job_drain,
-        .start                  = mirror_run,
+        .run                    = mirror_run,
         .pause                  = mirror_pause,
         .complete               = mirror_complete,
     },
diff --git a/block/stream.c b/block/stream.c
index 9264b68a1e..b4b987df7e 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -97,9 +97,9 @@ out:
     g_free(data);
 }
 
-static void coroutine_fn stream_run(void *opaque)
+static int coroutine_fn stream_run(Job *job, Error **errp)
 {
-    StreamBlockJob *s = opaque;
+    StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
     StreamCompleteData *data;
     BlockBackend *blk = s->common.blk;
     BlockDriverState *bs = blk_bs(blk);
@@ -206,6 +206,7 @@ out:
     data = g_malloc(sizeof(*data));
     data->ret = ret;
     job_defer_to_main_loop(&s->common.job, stream_complete, data);
+    return ret;
 }
 
 static const BlockJobDriver stream_job_driver = {
@@ -213,7 +214,7 @@ static const BlockJobDriver stream_job_driver = {
         .instance_size = sizeof(StreamBlockJob),
         .job_type      = JOB_TYPE_STREAM,
         .free          = block_job_free,
-        .start         = stream_run,
+        .run           = stream_run,
         .user_resume   = block_job_user_resume,
         .drain         = block_job_drain,
     },
diff --git a/include/qemu/job.h b/include/qemu/job.h
index 18c9223e31..9cf463d228 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -169,7 +169,7 @@ struct JobDriver {
     JobType job_type;
 
     /** Mandatory: Entrypoint for the Coroutine. */
-    CoroutineEntry *start;
+    int coroutine_fn (*run)(Job *job, Error **errp);
 
     /**
      * If the callback is not NULL, it will be invoked when the job transitions
diff --git a/job.c b/job.c
index e36ebaafd8..76988f6678 100644
--- a/job.c
+++ b/job.c
@@ -544,16 +544,16 @@ static void coroutine_fn job_co_entry(void *opaque)
 {
     Job *job = opaque;
 
-    assert(job && job->driver && job->driver->start);
+    assert(job && job->driver && job->driver->run);
     job_pause_point(job);
-    job->driver->start(job);
+    job->ret = job->driver->run(job, NULL);
 }
 
 
 void job_start(Job *job)
 {
     assert(job && !job_started(job) && job->paused &&
-           job->driver && job->driver->start);
+           job->driver && job->driver->run);
     job->co = qemu_coroutine_create(job_co_entry, job);
     job->pause_count--;
     job->busy = true;
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 17bb8508ae..a7533861f6 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -757,9 +757,9 @@ static void test_job_completed(Job *job, void *opaque)
     job_completed(job, 0, NULL);
 }
 
-static void coroutine_fn test_job_start(void *opaque)
+static int coroutine_fn test_job_run(Job *job, Error **errp)
 {
-    TestBlockJob *s = opaque;
+    TestBlockJob *s = container_of(job, TestBlockJob, common.job);
 
     job_transition_to_ready(&s->common.job);
     while (!s->should_complete) {
@@ -771,6 +771,7 @@ static void coroutine_fn test_job_start(void *opaque)
     }
 
     job_defer_to_main_loop(&s->common.job, test_job_completed, NULL);
+    return 0;
 }
 
 static void test_job_complete(Job *job, Error **errp)
@@ -785,7 +786,7 @@ BlockJobDriver test_job_driver = {
         .free           = block_job_free,
         .user_resume    = block_job_user_resume,
         .drain          = block_job_drain,
-        .start          = test_job_start,
+        .run            = test_job_run,
         .complete       = test_job_complete,
     },
 };
diff --git a/tests/test-blockjob-txn.c b/tests/test-blockjob-txn.c
index 58d9b87fb2..3194924071 100644
--- a/tests/test-blockjob-txn.c
+++ b/tests/test-blockjob-txn.c
@@ -38,25 +38,25 @@ static void test_block_job_complete(Job *job, void *opaque)
     bdrv_unref(bs);
 }
 
-static void coroutine_fn test_block_job_run(void *opaque)
+static int coroutine_fn test_block_job_run(Job *job, Error **errp)
 {
-    TestBlockJob *s = opaque;
-    BlockJob *job = &s->common;
+    TestBlockJob *s = container_of(job, TestBlockJob, common.job);
 
     while (s->iterations--) {
         if (s->use_timer) {
-            job_sleep_ns(&job->job, 0);
+            job_sleep_ns(job, 0);
         } else {
-            job_yield(&job->job);
+            job_yield(job);
         }
 
-        if (job_is_cancelled(&job->job)) {
+        if (job_is_cancelled(job)) {
             break;
         }
     }
 
-    job_defer_to_main_loop(&job->job, test_block_job_complete,
+    job_defer_to_main_loop(job, test_block_job_complete,
                            (void *)(intptr_t)s->rc);
+    return s->rc;
 }
 
 typedef struct {
@@ -80,7 +80,7 @@ static const BlockJobDriver test_block_job_driver = {
         .free          = block_job_free,
         .user_resume   = block_job_user_resume,
         .drain         = block_job_drain,
-        .start         = test_block_job_run,
+        .run           = test_block_job_run,
     },
 };
 
diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
index cb42f06e61..b0462bfdec 100644
--- a/tests/test-blockjob.c
+++ b/tests/test-blockjob.c
@@ -176,9 +176,9 @@ static void cancel_job_complete(Job *job, Error **errp)
     s->should_complete = true;
 }
 
-static void coroutine_fn cancel_job_start(void *opaque)
+static int coroutine_fn cancel_job_run(Job *job, Error **errp)
 {
-    CancelJob *s = opaque;
+    CancelJob *s = container_of(job, CancelJob, common.job);
 
     while (!s->should_complete) {
         if (job_is_cancelled(&s->common.job)) {
@@ -194,6 +194,7 @@ static void coroutine_fn cancel_job_start(void *opaque)
 
  defer:
     job_defer_to_main_loop(&s->common.job, cancel_job_completed, s);
+    return 0;
 }
 
 static const BlockJobDriver test_cancel_driver = {
@@ -202,7 +203,7 @@ static const BlockJobDriver test_cancel_driver = {
         .free          = block_job_free,
         .user_resume   = block_job_user_resume,
         .drain         = block_job_drain,
-        .start         = cancel_job_start,
+        .run           = cancel_job_run,
         .complete      = cancel_job_complete,
     },
 };
-- 
2.14.4
