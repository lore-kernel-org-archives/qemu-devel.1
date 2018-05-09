Received: from eggs.gnu.org ([2001:4830:134:3::10]:52404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fGRwN-0005db-LD
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:27:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fGRwM-0002GS-1p
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:27:43 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  9 May 2018 18:26:16 +0200
Message-Id: <20180509162637.15575-22-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-1-kwolf@redhat.com>
References: <20180509162637.15575-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 21/42] job: Replace BlockJob.completed with
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
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

Since we introduced an explicit status to block job, BlockJob.completed
is redundant because it can be derived from the status. Remove the field
from BlockJob and add a function to derive it from the status at the Job
level.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/blockjob.h |  3 ---
 include/qemu/job.h       |  3 +++
 blockjob.c               | 16 +++++++---------
 job.c                    | 22 ++++++++++++++++++++++
 qemu-img.c               |  4 ++--
 5 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index ce136ff2ac..a2d16a700d 100644
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
index 0ba6cb3161..87b0500795 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -214,6 +214,9 @@ const char *job_type_str(Job *job);
 /** Returns whether the job is scheduled for cancellation. */
 bool job_is_cancelled(Job *job);
 
+/** Returns whether the job is in a completed state. */
+bool job_is_completed(Job *job);
+
 /**
  * Request @job to pause at the next pause point. Must be paired with
  * job_resume(). If the job is supposed to be resumed by user action, call
diff --git a/blockjob.c b/blockjob.c
index a2b6bfc975..e0a51cfb3e 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -194,7 +194,7 @@ static void block_job_detach_aio_context(void *opaque)
 
     job_pause(&job->job);
 
-    while (!job->job.paused && !job->completed) {
+    while (!job->job.paused && !job_is_completed(&job->job)) {
         block_job_drain(job);
     }
 
@@ -270,7 +270,6 @@ const BlockJobDriver *block_job_driver(BlockJob *job)
 static void block_job_decommission(BlockJob *job)
 {
     assert(job);
-    job->completed = true;
     job->job.busy = false;
     job->job.paused = false;
     job->job.deferred_to_main_loop = true;
@@ -335,7 +334,7 @@ static void block_job_clean(BlockJob *job)
 
 static int block_job_finalize_single(BlockJob *job)
 {
-    assert(job->completed);
+    assert(job_is_completed(&job->job));
 
     /* Ensure abort is called for late-transactional failures */
     block_job_update_rc(job);
@@ -428,10 +427,10 @@ static int block_job_finish_sync(BlockJob *job,
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
@@ -472,7 +471,7 @@ static void block_job_completed_txn_abort(BlockJob *job)
     while (!QLIST_EMPTY(&txn->jobs)) {
         other_job = QLIST_FIRST(&txn->jobs);
         ctx = blk_get_aio_context(other_job->blk);
-        if (!other_job->completed) {
+        if (!job_is_completed(&other_job->job)) {
             assert(job_is_cancelled(&other_job->job));
             block_job_finish_sync(other_job, NULL, NULL);
         }
@@ -514,7 +513,7 @@ static void block_job_completed_txn_success(BlockJob *job)
      * txn.
      */
     QLIST_FOREACH(other_job, &txn->jobs, txn_list) {
-        if (!other_job->completed) {
+        if (!job_is_completed(&other_job->job)) {
             return;
         }
         assert(other_job->ret == 0);
@@ -848,9 +847,8 @@ void block_job_early_fail(BlockJob *job)
 
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
index 94ad01a51a..60ccb0640b 100644
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
index 82f69269ae..6a2431a653 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -867,9 +867,9 @@ static void run_block_job(BlockJob *job, Error **errp)
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
