Received: from eggs.gnu.org ([2001:4830:134:3::10]:48306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fAzpd-0008WL-Rr
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:26:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fAzpc-0000Ln-MK
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:26:13 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 24 Apr 2018 17:25:15 +0200
Message-Id: <20180424152515.25664-34-kwolf@redhat.com>
In-Reply-To: <20180424152515.25664-1-kwolf@redhat.com>
References: <20180424152515.25664-1-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 33/33] job: Add job_dismiss()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

This moves block_job_dismiss() to the Job layer.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/blockjob.h |  9 ---------
 include/qemu/job.h       |  6 ++++++
 blockdev.c               |  8 +++++---
 blockjob.c               | 13 -------------
 job.c                    | 13 +++++++++++++
 tests/test-blockjob.c    |  4 ++--
 6 files changed, 26 insertions(+), 27 deletions(-)

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
index 1a4d6167e6..f0af1db123 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -463,6 +463,12 @@ int job_complete_sync(Job *job, Error **errp);
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
diff --git a/blockdev.c b/blockdev.c
index c3e5f6a804..87993de5b7 100644
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
index 6569624691..87dfe10130 100644
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
index 5bc98b9794..b8c89e3fec 100644
--- a/job.c
+++ b/job.c
@@ -582,6 +582,19 @@ void job_do_dismiss(Job *job)
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
