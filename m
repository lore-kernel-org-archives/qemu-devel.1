Received: from eggs.gnu.org ([2001:4830:134:3::10]:53369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLTZT-0002MT-FE
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:12:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLTZQ-0007HX-4W
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:12:51 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 23 May 2018 15:11:46 +0200
Message-Id: <20180523131155.12359-38-kwolf@redhat.com>
In-Reply-To: <20180523131155.12359-1-kwolf@redhat.com>
References: <20180523131155.12359-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 37/46] job: Add job_is_ready()
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

Instead of having a 'bool ready' in BlockJob, add a function that
derives its value from the job status.

At the same time, this fixes the behaviour to match what the QAPI
documentation promises for query-block-job: 'true if the job may be
completed'. When the ready flag was introduced in commit ef6dbf1e46e,
the flag never had to be reset to match the description because after
being ready, the jobs would immediately complete and disappear.

Job transactions and manual job finalisation were introduced only later.
With these changes, jobs may stay around even after having completed
(and they are not ready to be completed a second time), however their
patches forgot to reset the ready flag.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 include/block/blockjob.h |  5 -----
 include/qemu/job.h       |  3 +++
 blockjob.c               |  3 +--
 job.c                    | 22 ++++++++++++++++++++++
 qemu-img.c               |  2 +-
 tests/test-blockjob.c    |  2 +-
 6 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 5a81afc6c3..8e1e1ee0de 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -49,11 +49,6 @@ typedef struct BlockJob {
     /** The block device on which the job is operating.  */
     BlockBackend *blk;
 
-    /**
-     * Set to true when the job is ready to be completed.
-     */
-    bool ready;
-
     /** Status that is published by the query-block-jobs QMP API */
     BlockDeviceIoStatus iostatus;
 
diff --git a/include/qemu/job.h b/include/qemu/job.h
index 1e8050c6fb..487f9d9a32 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -367,6 +367,9 @@ bool job_is_cancelled(Job *job);
 /** Returns whether the job is in a completed state. */
 bool job_is_completed(Job *job);
 
+/** Returns whether the job is ready to be completed. */
+bool job_is_ready(Job *job);
+
 /**
  * Request @job to pause at the next pause point. Must be paired with
  * job_resume(). If the job is supposed to be resumed by user action, call
diff --git a/blockjob.c b/blockjob.c
index 3ca009bea5..38f18e9ba3 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -269,7 +269,7 @@ BlockJobInfo *block_job_query(BlockJob *job, Error **errp)
     info->offset    = job->offset;
     info->speed     = job->speed;
     info->io_status = job->iostatus;
-    info->ready     = job->ready;
+    info->ready     = job_is_ready(&job->job),
     info->status    = job->job.status;
     info->auto_finalize = job->job.auto_finalize;
     info->auto_dismiss  = job->job.auto_dismiss;
@@ -436,7 +436,6 @@ void block_job_user_resume(Job *job)
 void block_job_event_ready(BlockJob *job)
 {
     job_state_transition(&job->job, JOB_STATUS_READY);
-    job->ready = true;
 
     if (block_job_is_internal(job)) {
         return;
diff --git a/job.c b/job.c
index 7cd3602782..aa4c746c8a 100644
--- a/job.c
+++ b/job.c
@@ -199,6 +199,28 @@ bool job_is_cancelled(Job *job)
     return job->cancelled;
 }
 
+bool job_is_ready(Job *job)
+{
+    switch (job->status) {
+    case JOB_STATUS_UNDEFINED:
+    case JOB_STATUS_CREATED:
+    case JOB_STATUS_RUNNING:
+    case JOB_STATUS_PAUSED:
+    case JOB_STATUS_WAITING:
+    case JOB_STATUS_PENDING:
+    case JOB_STATUS_ABORTING:
+    case JOB_STATUS_CONCLUDED:
+    case JOB_STATUS_NULL:
+        return false;
+    case JOB_STATUS_READY:
+    case JOB_STATUS_STANDBY:
+        return true;
+    default:
+        g_assert_not_reached();
+    }
+    return false;
+}
+
 bool job_is_completed(Job *job)
 {
     switch (job->status) {
diff --git a/qemu-img.c b/qemu-img.c
index efa7b755d4..700e4e187b 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -866,7 +866,7 @@ static void run_block_job(BlockJob *job, Error **errp)
         aio_poll(aio_context, true);
         qemu_progress_print(job->len ?
                             ((float)job->offset / job->len * 100.f) : 0.0f, 0);
-    } while (!job->ready && !job_is_completed(&job->job));
+    } while (!job_is_ready(&job->job) && !job_is_completed(&job->job));
 
     if (!job_is_completed(&job->job)) {
         ret = job_complete_sync(&job->job, errp);
diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
index 7131cabb16..8180d03a5f 100644
--- a/tests/test-blockjob.c
+++ b/tests/test-blockjob.c
@@ -185,7 +185,7 @@ static void coroutine_fn cancel_job_start(void *opaque)
             goto defer;
         }
 
-        if (!s->common.ready && s->should_converge) {
+        if (!job_is_ready(&s->common.job) && s->should_converge) {
             block_job_event_ready(&s->common);
         }
 
-- 
2.13.6
