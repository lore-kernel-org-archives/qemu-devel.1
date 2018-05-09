Received: from eggs.gnu.org ([2001:4830:134:3::10]:52830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fGRwh-0005yH-FI
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:28:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fGRwg-0002u0-Bl
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:28:03 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  9 May 2018 18:26:30 +0200
Message-Id: <20180509162637.15575-36-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-1-kwolf@redhat.com>
References: <20180509162637.15575-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 35/42] job: Add job_is_ready()
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
---
 include/block/blockjob.h |  5 -----
 include/qemu/job.h       |  3 +++
 blockjob.c               |  3 +--
 job.c                    | 22 ++++++++++++++++++++++
 qemu-img.c               |  2 +-
 tests/test-blockjob.c    |  2 +-
 6 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index ba08bcf7c0..932a12d1a6 100644
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
index f3acebbc17..fb81cc7c09 100644
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
index 5ab22596bf..0512b41901 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -270,7 +270,7 @@ BlockJobInfo *block_job_query(BlockJob *job, Error **errp)
     info->offset    = job->offset;
     info->speed     = job->speed;
     info->io_status = job->iostatus;
-    info->ready     = job->ready;
+    info->ready     = job_is_ready(&job->job),
     info->status    = job->job.status;
     info->auto_finalize = job->job.auto_finalize;
     info->auto_dismiss  = job->job.auto_dismiss;
@@ -438,7 +438,6 @@ void block_job_user_resume(Job *job)
 void block_job_event_ready(BlockJob *job)
 {
     job_state_transition(&job->job, JOB_STATUS_READY);
-    job->ready = true;
 
     if (block_job_is_internal(job)) {
         return;
diff --git a/job.c b/job.c
index 744490dffe..a500e8d1fd 100644
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
index 176eb630a1..6361d4edf5 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -867,7 +867,7 @@ static void run_block_job(BlockJob *job, Error **errp)
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
