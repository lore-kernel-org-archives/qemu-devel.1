Received: from eggs.gnu.org ([2001:4830:134:3::10]:52807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fGRwg-0005w6-1e
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:28:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fGRwe-0002r1-V7
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:28:02 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  9 May 2018 18:26:29 +0200
Message-Id: <20180509162637.15575-35-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-1-kwolf@redhat.com>
References: <20180509162637.15575-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 34/42] job: Add job_dismiss()
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

This moves block_job_dismiss() to the Job layer.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/blockjob.h |  9 ---------
 include/qemu/job.h       |  7 ++++++-
 blockdev.c               |  8 +++++---
 blockjob.c               | 13 -------------
 job.c                    | 15 ++++++++++++++-
 tests/test-blockjob.c    |  4 ++--
 6 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 7a0d95e789..ba08bcf7c0 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -141,15 +141,6 @@ void block_job_remove_all_bdrv(BlockJob *job);
 void block_job_set_speed(BlockJob *job, int64_t speed, Error **errp);
 
 /**
- * block_job_dismiss:
- * @job: The job to be dismissed.
- * @errp: Error object.
- *
- * Remove a concluded job from the query list.
- */
-void block_job_dismiss(BlockJob **job, Error **errp);
-
-/**
  * block_job_progress_update:
  * @job: The job that has made progress
  * @done: How much progress the job made
diff --git a/include/qemu/job.h b/include/qemu/job.h
index 5ec3e3c01d..f3acebbc17 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -487,6 +487,12 @@ int job_complete_sync(Job *job, Error **errp);
  */
 void job_finalize(Job *job, Error **errp);
 
+/**
+ * Remove the concluded @job from the query list and resets the passed pointer
+ * to %NULL. Returns an error if the job is not actually concluded.
+ */
+void job_dismiss(Job **job, Error **errp);
+
 typedef void JobDeferToMainLoopFn(Job *job, void *opaque);
 
 /**
@@ -515,6 +521,5 @@ int job_finish_sync(Job *job, void (*finish)(Job *, Error **errp), Error **errp)
 
 /* TODO To be removed from the public interface */
 void job_state_transition(Job *job, JobStatus s1);
-void job_do_dismiss(Job *job);
 
 #endif
diff --git a/blockdev.c b/blockdev.c
index 31319a6d5a..15753d9719 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3915,14 +3915,16 @@ void qmp_block_job_finalize(const char *id, Error **errp)
 void qmp_block_job_dismiss(const char *id, Error **errp)
 {
     AioContext *aio_context;
-    BlockJob *job = find_block_job(id, &aio_context, errp);
+    BlockJob *bjob = find_block_job(id, &aio_context, errp);
+    Job *job;
 
-    if (!job) {
+    if (!bjob) {
         return;
     }
 
     trace_qmp_block_job_dismiss(job);
-    block_job_dismiss(&job, errp);
+    job = &bjob->job;
+    job_dismiss(&job, errp);
     aio_context_release(aio_context);
 }
 
diff --git a/blockjob.c b/blockjob.c
index e8d7e85d6b..5ab22596bf 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -243,19 +243,6 @@ int64_t block_job_ratelimit_get_delay(BlockJob *job, uint64_t n)
     return ratelimit_calculate_delay(&job->limit, n);
 }
 
-void block_job_dismiss(BlockJob **jobptr, Error **errp)
-{
-    BlockJob *job = *jobptr;
-    /* similarly to _complete, this is QMP-interface only. */
-    assert(job->job.id);
-    if (job_apply_verb(&job->job, JOB_VERB_DISMISS, errp)) {
-        return;
-    }
-
-    job_do_dismiss(&job->job);
-    *jobptr = NULL;
-}
-
 void block_job_progress_update(BlockJob *job, uint64_t done)
 {
     job->offset += done;
diff --git a/job.c b/job.c
index 1627118c26..744490dffe 100644
--- a/job.c
+++ b/job.c
@@ -561,7 +561,7 @@ void job_user_resume(Job *job, Error **errp)
     job_resume(job);
 }
 
-void job_do_dismiss(Job *job)
+static void job_do_dismiss(Job *job)
 {
     assert(job);
     job->busy = false;
@@ -574,6 +574,19 @@ void job_do_dismiss(Job *job)
     job_unref(job);
 }
 
+void job_dismiss(Job **jobptr, Error **errp)
+{
+    Job *job = *jobptr;
+    /* similarly to _complete, this is QMP-interface only. */
+    assert(job->id);
+    if (job_apply_verb(job, JOB_VERB_DISMISS, errp)) {
+        return;
+    }
+
+    job_do_dismiss(job);
+    *jobptr = NULL;
+}
+
 void job_early_fail(Job *job)
 {
     assert(job->status == JOB_STATUS_CREATED);
diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
index 46a78739aa..7131cabb16 100644
--- a/tests/test-blockjob.c
+++ b/tests/test-blockjob.c
@@ -233,8 +233,8 @@ static void cancel_common(CancelJob *s)
 
     job_cancel_sync(&job->job);
     if (sts != JOB_STATUS_CREATED && sts != JOB_STATUS_CONCLUDED) {
-        BlockJob *dummy = job;
-        block_job_dismiss(&dummy, &error_abort);
+        Job *dummy = &job->job;
+        job_dismiss(&dummy, &error_abort);
     }
     assert(job->job.status == JOB_STATUS_NULL);
     job_unref(&job->job);
-- 
2.13.6
