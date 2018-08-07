Received: from eggs.gnu.org ([2001:4830:134:3::10]:54095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fmth7-0004ku-6j
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 00:34:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fmth5-0001MA-3v
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 00:34:05 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  7 Aug 2018 00:33:40 -0400
Message-Id: <20180807043349.27196-13-jsnow@redhat.com>
In-Reply-To: <20180807043349.27196-1-jsnow@redhat.com>
References: <20180807043349.27196-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 12/21] jobs: allow entrypoints to return status
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, jtc@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

Instead of awkwardly setting the return code in the job object, we can
just return this on the stack and catch it in the caller. This also has
the side-effect of changing the "opaque" type in the entrypoint to the
more specific "Job" type, so change function signatures accordingly.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/backup.c            |  6 +++---
 block/commit.c            |  6 +++---
 block/create.c            |  8 +++++---
 block/mirror.c            |  6 +++---
 block/stream.c            |  6 +++---
 include/qemu/job.h        |  2 +-
 job.c                     |  2 +-
 tests/test-bdrv-drain.c   |  6 ++++--
 tests/test-blockjob-txn.c | 13 ++++++-------
 tests/test-blockjob.c     |  9 ++++++---
 10 files changed, 35 insertions(+), 29 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index af6ee5ab54..c903416c5f 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -468,9 +468,9 @@ static void backup_incremental_init_copy_bitmap(BackupBlockJob *job)
     bdrv_dirty_iter_free(dbi);
 }
 
-static void coroutine_fn backup_run(void *opaque)
+static int coroutine_fn backup_run(Job *opaque_job)
 {
-    BackupBlockJob *job = opaque;
+    BackupBlockJob *job = container_of(opaque_job, BackupBlockJob, common.job);
     BlockDriverState *bs = blk_bs(job->common.blk);
     int64_t offset, nb_clusters;
     int ret = 0;
@@ -571,7 +571,7 @@ static void coroutine_fn backup_run(void *opaque)
     qemu_co_rwlock_unlock(&job->flush_rwlock);
     hbitmap_free(job->copy_bitmap);
 
-    job->common.job.ret = ret;
+    return ret;
 }
 
 static const BlockJobDriver backup_job_driver = {
diff --git a/block/commit.c b/block/commit.c
index 5bed098d5f..22712cac2d 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -127,9 +127,9 @@ static void commit_exit(Job *job)
     job->ret = ret;
 }
 
-static void coroutine_fn commit_run(void *opaque)
+static int coroutine_fn commit_run(Job *job)
 {
-    CommitBlockJob *s = opaque;
+    CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
     int64_t offset;
     uint64_t delay_ns = 0;
     int ret = 0;
@@ -202,7 +202,7 @@ static void coroutine_fn commit_run(void *opaque)
 out:
     qemu_vfree(buf);
 
-    s->common.job.ret = ret;
+    return ret;
 }
 
 static const BlockJobDriver commit_job_driver = {
diff --git a/block/create.c b/block/create.c
index 3aeafc68cf..9de55b973a 100644
--- a/block/create.c
+++ b/block/create.c
@@ -36,15 +36,17 @@ typedef struct BlockdevCreateJob {
     BlockdevCreateOptions *opts;
 } BlockdevCreateJob;
 
-static void coroutine_fn blockdev_create_run(void *opaque)
+static int coroutine_fn blockdev_create_run(Job *job)
 {
-    BlockdevCreateJob *s = opaque;
+    int ret;
+    BlockdevCreateJob *s = container_of(job, BlockdevCreateJob, common);
 
     job_progress_set_remaining(&s->common, 1);
-    s->common.ret = s->drv->bdrv_co_create(s->opts, &s->common.err);
+    ret = s->drv->bdrv_co_create(s->opts, &s->common.err);
     job_progress_update(&s->common, 1);
 
     qapi_free_BlockdevCreateOptions(s->opts);
+    return ret;
 }
 
 static const JobDriver blockdev_create_job_driver = {
diff --git a/block/mirror.c b/block/mirror.c
index e3404e2518..acf874393e 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -808,9 +808,9 @@ static int mirror_flush(MirrorBlockJob *s)
     return ret;
 }
 
-static void coroutine_fn mirror_run(void *opaque)
+static int coroutine_fn mirror_run(Job *job)
 {
-    MirrorBlockJob *s = opaque;
+    MirrorBlockJob *s = container_of(job, MirrorBlockJob, common.job);
     BlockDriverState *bs = s->mirror_top_bs->backing->bs;
     BlockDriverState *target_bs = blk_bs(s->target);
     bool need_drain = true;
@@ -1034,7 +1034,7 @@ immediate_exit:
         bdrv_drained_begin(bs);
     }
 
-    s->common.job.ret = ret;
+    return ret;
 }
 
 static void mirror_complete(Job *job, Error **errp)
diff --git a/block/stream.c b/block/stream.c
index 163cd6431c..2bdbca779d 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -92,9 +92,9 @@ out:
     job->ret = ret;
 }
 
-static void coroutine_fn stream_run(void *opaque)
+static int coroutine_fn stream_run(Job *job)
 {
-    StreamBlockJob *s = opaque;
+    StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
     BlockBackend *blk = s->common.blk;
     BlockDriverState *bs = blk_bs(blk);
     BlockDriverState *base = s->base;
@@ -197,7 +197,7 @@ static void coroutine_fn stream_run(void *opaque)
 
 out:
     /* Modify backing chain and close BDSes in main loop */
-    s->common.job.ret = ret;
+    return ret;
 }
 
 static const BlockJobDriver stream_job_driver = {
diff --git a/include/qemu/job.h b/include/qemu/job.h
index 02df75f45d..eef03bb06d 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -169,7 +169,7 @@ struct JobDriver {
     JobType job_type;
 
     /** Mandatory: Entrypoint for the Coroutine. */
-    CoroutineEntry *start;
+    int coroutine_fn (*start)(Job *job);
 
     /**
      * If the callback is not NULL, it will be invoked when the job transitions
diff --git a/job.c b/job.c
index fa6a1cd62c..09ce8900df 100644
--- a/job.c
+++ b/job.c
@@ -558,7 +558,7 @@ static void coroutine_fn job_co_entry(void *opaque)
 
     assert(job && job->driver && job->driver->start);
     job_pause_point(job);
-    job->driver->start(job);
+    job->ret = job->driver->start(job);
     job->deferred_to_main_loop = true;
     aio_bh_schedule_oneshot(qemu_get_aio_context(), job_exit, job);
 }
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index f30310596c..64188970e8 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -752,9 +752,9 @@ typedef struct TestBlockJob {
     bool should_complete;
 } TestBlockJob;
 
-static void coroutine_fn test_job_start(void *opaque)
+static int coroutine_fn test_job_start(Job *job)
 {
-    TestBlockJob *s = opaque;
+    TestBlockJob *s = container_of(job, TestBlockJob, common.job);
 
     job_transition_to_ready(&s->common.job);
     while (!s->should_complete) {
@@ -764,6 +764,8 @@ static void coroutine_fn test_job_start(void *opaque)
         qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 100000);
         job_pause_point(&s->common.job);
     }
+
+    return 0;
 }
 
 static void test_job_complete(Job *job, Error **errp)
diff --git a/tests/test-blockjob-txn.c b/tests/test-blockjob-txn.c
index 307726d089..1128490c19 100644
--- a/tests/test-blockjob-txn.c
+++ b/tests/test-blockjob-txn.c
@@ -32,24 +32,23 @@ static void test_block_job_exit(Job *job)
     bdrv_unref(bs);
 }
 
-static void coroutine_fn test_block_job_run(void *opaque)
+static int coroutine_fn test_block_job_run(Job *job)
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
 
-    s->common.job.ret = s->rc;
+    return s->rc;
 }
 
 typedef struct {
diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
index 20563bde4f..7f6df29bcf 100644
--- a/tests/test-blockjob.c
+++ b/tests/test-blockjob.c
@@ -175,13 +175,13 @@ static void cancel_job_complete(Job *job, Error **errp)
     s->should_complete = true;
 }
 
-static void coroutine_fn cancel_job_start(void *opaque)
+static int coroutine_fn cancel_job_start(Job *job)
 {
-    CancelJob *s = opaque;
+    CancelJob *s = container_of(job, CancelJob, common.job);
 
     while (!s->should_complete) {
         if (job_is_cancelled(&s->common.job)) {
-            return;
+            goto out;
         }
 
         if (!job_is_ready(&s->common.job) && s->should_converge) {
@@ -190,6 +190,9 @@ static void coroutine_fn cancel_job_start(void *opaque)
 
         job_sleep_ns(&s->common.job, 100000);
     }
+
+ out:
+    return 0;
 }
 
 static const BlockJobDriver test_cancel_driver = {
-- 
2.14.4
