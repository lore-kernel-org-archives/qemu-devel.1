Received: from eggs.gnu.org ([2001:4830:134:3::10]:53102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLTZG-00023v-At
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:12:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLTZ9-00075u-9A
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:12:38 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 23 May 2018 15:11:31 +0200
Message-Id: <20180523131155.12359-23-kwolf@redhat.com>
In-Reply-To: <20180523131155.12359-1-kwolf@redhat.com>
References: <20180523131155.12359-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 22/46] job: Replace BlockJob.completed with
 job_is_completed()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

Since we introduced an explicit status to block job, BlockJob.completed
is redundant because it can be derived from the status. Remove the field
from BlockJob and add a function to derive it from the status at the Job
level.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 include/block/blockjob.h |  3 ---
 include/qemu/job.h       |  3 +++
 blockjob.c               | 16 +++++++---------
 job.c                    | 22 ++++++++++++++++++++++
 qemu-img.c               |  4 ++--
 5 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 556a8f6375..3e94e18850 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -88,9 +88,6 @@ typedef struct BlockJob {
     /** The opaque value that is passed to the completion function.  */
     void *opaque;
 
-    /** True when job has reported completion by calling block_job_completed. */
-    bool completed;
-
     /** ret code passed to block_job_completed. */
     int ret;
 
diff --git a/include/qemu/job.h b/include/qemu/job.h
index bc6398568f..858f3beea4 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -214,6 +214,9 @@ const char *job_type_str(const Job *job);
 /** Returns whether the job is scheduled for cancellation. */
 bool job_is_cancelled(Job *job);
 
+/** Returns whether the job is in a completed state. */
+bool job_is_completed(Job *job);
+
 /**
  * Request @job to pause at the next pause point. Must be paired with
  * job_resume(). If the job is supposed to be resumed by user action, call
diff --git a/blockjob.c b/blockjob.c
index 6334a54f50..a1d1f488e9 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -193,7 +193,7 @@ static void block_job_detach_aio_context(void *opaque)
 
     job_pause(&job->job);
 
-    while (!job->job.paused && !job->completed) {
+    while (!job->job.paused && !job_is_completed(&job->job)) {
         block_job_drain(job);
     }
 
@@ -269,7 +269,6 @@ const BlockJobDriver *block_job_driver(BlockJob *job)
 static void block_job_decommission(BlockJob *job)
 {
     assert(job);
-    job->completed = true;
     job->job.busy = false;
     job->job.paused = false;
     job->job.deferred_to_main_loop = true;
@@ -334,7 +333,7 @@ static void block_job_clean(BlockJob *job)
 
 static int block_job_finalize_single(BlockJob *job)
 {
-    assert(job->completed);
+    assert(job_is_completed(&job->job));
 
     /* Ensure abort is called for late-transactional failures */
     block_job_update_rc(job);
@@ -427,10 +426,10 @@ static int block_job_finish_sync(BlockJob *job,
     /* block_job_drain calls block_job_enter, and it should be enough to
      * induce progress until the job completes or moves to the main thread.
     */
-    while (!job->job.deferred_to_main_loop && !job->completed) {
+    while (!job->job.deferred_to_main_loop && !job_is_completed(&job->job)) {
         block_job_drain(job);
     }
-    while (!job->completed) {
+    while (!job_is_completed(&job->job)) {
         aio_poll(qemu_get_aio_context(), true);
     }
     ret = (job_is_cancelled(&job->job) && job->ret == 0)
@@ -471,7 +470,7 @@ static void block_job_completed_txn_abort(BlockJob *job)
     while (!QLIST_EMPTY(&txn->jobs)) {
         other_job = QLIST_FIRST(&txn->jobs);
         ctx = blk_get_aio_context(other_job->blk);
-        if (!other_job->completed) {
+        if (!job_is_completed(&other_job->job)) {
             assert(job_is_cancelled(&other_job->job));
             block_job_finish_sync(other_job, NULL, NULL);
         }
@@ -513,7 +512,7 @@ static void block_job_completed_txn_success(BlockJob *job)
      * txn.
      */
     QLIST_FOREACH(other_job, &txn->jobs, txn_list) {
-        if (!other_job->completed) {
+        if (!job_is_completed(&other_job->job)) {
             return;
         }
         assert(other_job->ret == 0);
@@ -847,9 +846,8 @@ void block_job_early_fail(BlockJob *job)
 
 void block_job_completed(BlockJob *job, int ret)
 {
-    assert(job && job->txn && !job->completed);
+    assert(job && job->txn && !job_is_completed(&job->job));
     assert(blk_bs(job->blk)->job == job);
-    job->completed = true;
     job->ret = ret;
     block_job_update_rc(job);
     trace_block_job_completed(job, ret, job->ret);
diff --git a/job.c b/job.c
index fd10b1d267..aaacfcc93f 100644
--- a/job.c
+++ b/job.c
@@ -121,6 +121,28 @@ bool job_is_cancelled(Job *job)
     return job->cancelled;
 }
 
+bool job_is_completed(Job *job)
+{
+    switch (job->status) {
+    case JOB_STATUS_UNDEFINED:
+    case JOB_STATUS_CREATED:
+    case JOB_STATUS_RUNNING:
+    case JOB_STATUS_PAUSED:
+    case JOB_STATUS_READY:
+    case JOB_STATUS_STANDBY:
+        return false;
+    case JOB_STATUS_WAITING:
+    case JOB_STATUS_PENDING:
+    case JOB_STATUS_ABORTING:
+    case JOB_STATUS_CONCLUDED:
+    case JOB_STATUS_NULL:
+        return true;
+    default:
+        g_assert_not_reached();
+    }
+    return false;
+}
+
 bool job_started(Job *job)
 {
     return job->co;
diff --git a/qemu-img.c b/qemu-img.c
index 911456ba40..f3fe903c38 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -866,9 +866,9 @@ static void run_block_job(BlockJob *job, Error **errp)
         aio_poll(aio_context, true);
         qemu_progress_print(job->len ?
                             ((float)job->offset / job->len * 100.f) : 0.0f, 0);
-    } while (!job->ready && !job->completed);
+    } while (!job->ready && !job_is_completed(&job->job));
 
-    if (!job->completed) {
+    if (!job_is_completed(&job->job)) {
         ret = block_job_complete_sync(job, errp);
     } else {
         ret = job->ret;
-- 
2.13.6
