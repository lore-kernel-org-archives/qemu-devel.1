Received: from eggs.gnu.org ([2001:4830:134:3::10]:46685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0R78-0002CT-08
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0R77-0001nX-2z
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:52:53 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 13 Sep 2018 14:52:05 +0200
Message-Id: <20180913125217.23173-6-kwolf@redhat.com>
In-Reply-To: <20180913125217.23173-1-kwolf@redhat.com>
References: <20180913125217.23173-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 05/17] test-blockjob: Acquire AioContext
 around job_cancel_sync()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, famz@redhat.com, pbonzini@redhat.com, slp@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org

All callers in QEMU proper hold the AioContext lock when calling
job_finish_sync(). test-blockjob should do the same when it calls the
function indirectly through job_cancel_sync().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
---
 include/qemu/job.h    | 6 ++++++
 tests/test-blockjob.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/include/qemu/job.h b/include/qemu/job.h
index b4a784d3cc..63c60ef1ba 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -524,6 +524,8 @@ void job_user_cancel(Job *job, bool force, Error **errp);
  *
  * Returns the return value from the job if the job actually completed
  * during the call, or -ECANCELED if it was canceled.
+ *
+ * Callers must hold the AioContext lock of job->aio_context.
  */
 int job_cancel_sync(Job *job);
 
@@ -541,6 +543,8 @@ void job_cancel_sync_all(void);
  * function).
  *
  * Returns the return value from the job.
+ *
+ * Callers must hold the AioContext lock of job->aio_context.
  */
 int job_complete_sync(Job *job, Error **errp);
 
@@ -566,6 +570,8 @@ void job_dismiss(Job **job, Error **errp);
  *
  * Returns 0 if the job is successfully completed, -ECANCELED if the job was
  * cancelled before completing, and -errno in other error cases.
+ *
+ * Callers must hold the AioContext lock of job->aio_context.
  */
 int job_finish_sync(Job *job, void (*finish)(Job *, Error **errp), Error **errp);
 
diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
index de4c1c20aa..652d1e8359 100644
--- a/tests/test-blockjob.c
+++ b/tests/test-blockjob.c
@@ -223,6 +223,10 @@ static void cancel_common(CancelJob *s)
     BlockJob *job = &s->common;
     BlockBackend *blk = s->blk;
     JobStatus sts = job->job.status;
+    AioContext *ctx;
+
+    ctx = job->job.aio_context;
+    aio_context_acquire(ctx);
 
     job_cancel_sync(&job->job);
     if (sts != JOB_STATUS_CREATED && sts != JOB_STATUS_CONCLUDED) {
@@ -232,6 +236,8 @@ static void cancel_common(CancelJob *s)
     assert(job->job.status == JOB_STATUS_NULL);
     job_unref(&job->job);
     destroy_blk(blk);
+
+    aio_context_release(ctx);
 }
 
 static void test_cancel_created(void)
-- 
2.13.6
