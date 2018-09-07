Received: from eggs.gnu.org ([2001:4830:134:3::10]:53230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fyJQU-0006A8-7N
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 12:16:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fyJQS-00041B-2Z
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 12:16:05 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Sep 2018 18:15:09 +0200
Message-Id: <20180907161520.26349-4-kwolf@redhat.com>
In-Reply-To: <20180907161520.26349-1-kwolf@redhat.com>
References: <20180907161520.26349-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 03/14] test-blockjob: Acquire AioContext around
 job_finish_sync()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, famz@redhat.com, pbonzini@redhat.com, slp@redhat.com, qemu-devel@nongnu.org

All callers in QEMU proper hold the AioContext lock when calling
job_finish_sync(). test-blockjob should do the same.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/qemu/job.h    | 6 ++++++
 tests/test-blockjob.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/include/qemu/job.h b/include/qemu/job.h
index 0dae5b8481..8ac48dbd28 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -520,6 +520,8 @@ void job_user_cancel(Job *job, bool force, Error **errp);
  *
  * Returns the return value from the job if the job actually completed
  * during the call, or -ECANCELED if it was canceled.
+ *
+ * Callers must hold the AioContext lock of job->aio_context.
  */
 int job_cancel_sync(Job *job);
 
@@ -537,6 +539,8 @@ void job_cancel_sync_all(void);
  * function).
  *
  * Returns the return value from the job.
+ *
+ * Callers must hold the AioContext lock of job->aio_context.
  */
 int job_complete_sync(Job *job, Error **errp);
 
@@ -579,6 +583,8 @@ void job_defer_to_main_loop(Job *job, JobDeferToMainLoopFn *fn, void *opaque);
  *
  * Returns 0 if the job is successfully completed, -ECANCELED if the job was
  * cancelled before completing, and -errno in other error cases.
+ *
+ * Callers must hold the AioContext lock of job->aio_context.
  */
 int job_finish_sync(Job *job, void (*finish)(Job *, Error **errp), Error **errp);
 
diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
index cb42f06e61..8c2babbe35 100644
--- a/tests/test-blockjob.c
+++ b/tests/test-blockjob.c
@@ -230,6 +230,10 @@ static void cancel_common(CancelJob *s)
     BlockJob *job = &s->common;
     BlockBackend *blk = s->blk;
     JobStatus sts = job->job.status;
+    AioContext *ctx;
+
+    ctx = job->job.aio_context;
+    aio_context_acquire(ctx);
 
     job_cancel_sync(&job->job);
     if (sts != JOB_STATUS_CREATED && sts != JOB_STATUS_CONCLUDED) {
@@ -239,6 +243,8 @@ static void cancel_common(CancelJob *s)
     assert(job->job.status == JOB_STATUS_NULL);
     job_unref(&job->job);
     destroy_blk(blk);
+
+    aio_context_release(ctx);
 }
 
 static void test_cancel_created(void)
-- 
2.13.6
