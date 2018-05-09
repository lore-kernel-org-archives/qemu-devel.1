Received: from eggs.gnu.org ([2001:4830:134:3::10]:52616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fGRwW-0005nm-OH
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:27:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fGRwV-0002Xk-FM
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:27:52 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  9 May 2018 18:26:21 +0200
Message-Id: <20180509162637.15575-27-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-1-kwolf@redhat.com>
References: <20180509162637.15575-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 26/42] job: Convert block_job_cancel_async() to
 Job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

block_job_cancel_async() did two things that were still block job
specific:

* Setting job->force. This field makes sense on the Job level, so we can
  just move it. While at it, rename it to job->force_cancel to make its
  purpose more obvious.

* Resetting the I/O status. This can't be moved because generic Jobs
  don't have an I/O status. What the function really implements is a
  user resume, except without entering the coroutine. Consequently, it
  makes sense to call the .user_resume driver callback here which
  already resets the I/O status.

  The old block_job_cancel_async() has two separate if statements that
  check job->iostatus != BLOCK_DEVICE_IO_STATUS_OK and job->user_paused.
  However, the former condition always implies the latter (as is
  asserted in block_job_iostatus_reset()), so changing the explicit call
  of block_job_iostatus_reset() on the former condition with the
  .user_resume callback on the latter condition is equivalent and
  doesn't need to access any BlockJob specific state.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/blockjob.h |  6 ------
 include/qemu/job.h       |  6 ++++++
 block/mirror.c           |  4 ++--
 blockjob.c               | 25 +++++++++++++------------
 4 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index e5af02f751..8477fc5a78 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -51,12 +51,6 @@ typedef struct BlockJob {
     BlockBackend *blk;
 
     /**
-     * Set to true if the job should abort immediately without waiting
-     * for data to be in sync.
-     */
-    bool force;
-
-    /**
      * Set to true when the job is ready to be completed.
      */
     bool ready;
diff --git a/include/qemu/job.h b/include/qemu/job.h
index 12edb822d8..b96ec10413 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -97,6 +97,12 @@ typedef struct Job {
      */
     bool cancelled;
 
+    /**
+     * Set to true if the job should abort immediately without waiting
+     * for data to be in sync.
+     */
+    bool force_cancel;
+
     /** Set to true when the job has deferred work to the main loop. */
     bool deferred_to_main_loop;
 
diff --git a/block/mirror.c b/block/mirror.c
index dcf0856c97..f18240e34c 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -871,7 +871,7 @@ static void coroutine_fn mirror_run(void *opaque)
         trace_mirror_before_sleep(s, cnt, s->synced, delay_ns);
         job_sleep_ns(&s->common.job, delay_ns);
         if (job_is_cancelled(&s->common.job) &&
-            (!s->synced || s->common.force))
+            (!s->synced || s->common.job.force_cancel))
         {
             break;
         }
@@ -884,7 +884,7 @@ immediate_exit:
          * or it was cancelled prematurely so that we do not guarantee that
          * the target is a copy of the source.
          */
-        assert(ret < 0 || ((s->common.force || !s->synced) &&
+        assert(ret < 0 || ((s->common.job.force_cancel || !s->synced) &&
                job_is_cancelled(&s->common.job)));
         assert(need_drain);
         mirror_wait_for_all_io(s);
diff --git a/blockjob.c b/blockjob.c
index 9280e92062..ca88e166e1 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -271,19 +271,20 @@ static int block_job_prepare(BlockJob *job)
     return job->job.ret;
 }
 
-static void block_job_cancel_async(BlockJob *job, bool force)
+static void job_cancel_async(Job *job, bool force)
 {
-    if (job->iostatus != BLOCK_DEVICE_IO_STATUS_OK) {
-        block_job_iostatus_reset(job);
-    }
-    if (job->job.user_paused) {
-        /* Do not call block_job_enter here, the caller will handle it.  */
-        job->job.user_paused = false;
-        job->job.pause_count--;
+    if (job->user_paused) {
+        /* Do not call job_enter here, the caller will handle it.  */
+        job->user_paused = false;
+        if (job->driver->user_resume) {
+            job->driver->user_resume(job);
+        }
+        assert(job->pause_count > 0);
+        job->pause_count--;
     }
-    job->job.cancelled = true;
+    job->cancelled = true;
     /* To prevent 'force == false' overriding a previous 'force == true' */
-    job->force |= force;
+    job->force_cancel |= force;
 }
 
 static int block_job_txn_apply(BlockJobTxn *txn, int fn(BlockJob *), bool lock)
@@ -368,7 +369,7 @@ static void block_job_completed_txn_abort(BlockJob *job)
      * on the caller, so leave it. */
     QLIST_FOREACH(other_job, &txn->jobs, txn_list) {
         if (other_job != job) {
-            block_job_cancel_async(other_job, false);
+            job_cancel_async(&other_job->job, false);
         }
     }
     while (!QLIST_EMPTY(&txn->jobs)) {
@@ -528,7 +529,7 @@ void block_job_cancel(BlockJob *job, bool force)
         job_do_dismiss(&job->job);
         return;
     }
-    block_job_cancel_async(job, force);
+    job_cancel_async(&job->job, force);
     if (!job_started(&job->job)) {
         block_job_completed(job, -ECANCELED);
     } else if (job->job.deferred_to_main_loop) {
-- 
2.13.6
