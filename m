Received: from eggs.gnu.org ([2001:4830:134:3::10]:49734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fvCDc-00013U-94
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 21:57:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fvCDb-0006mg-3p
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 21:57:56 -0400
From: John Snow <jsnow@redhat.com>
Date: Wed, 29 Aug 2018 21:57:33 -0400
Message-Id: <20180830015734.19765-9-jsnow@redhat.com>
In-Reply-To: <20180830015734.19765-1-jsnow@redhat.com>
References: <20180830015734.19765-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v3 8/9] jobs: remove ret argument to
 job_completed; privatize it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, jtc@redhat.com, John Snow <jsnow@redhat.com>

Jobs are now expected to return their retcode on the stack, from the
.run callback, so we can remove that argument.

job_cancel does not need to set -ECANCELED because job_completed will
update the return code itself if the job was canceled.

While we're here, make job_completed static to job.c and remove it from
job.h; move the documentation of return code to the .run() callback and
to the job->ret property, accordingly.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 include/qemu/job.h | 28 +++++++++++++++-------------
 job.c              | 11 ++++++-----
 trace-events       |  2 +-
 3 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/include/qemu/job.h b/include/qemu/job.h
index 1144d671a1..23395c17fa 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -124,7 +124,11 @@ typedef struct Job {
     /** Estimated progress_current value at the completion of the job */
     int64_t progress_total;
 
-    /** ret code passed to job_completed. */
+    /**
+     * Return code from @run and/or @prepare callback(s).
+     * Not final until the job has reached the CONCLUDED status.
+     * 0 on success, -errno on failure.
+     */
     int ret;
 
     /**
@@ -172,7 +176,16 @@ struct JobDriver {
     /** Enum describing the operation */
     JobType job_type;
 
-    /** Mandatory: Entrypoint for the Coroutine. */
+    /**
+     * Mandatory: Entrypoint for the Coroutine.
+     *
+     * This callback will be invoked when moving from CREATED to RUNNING.
+     *
+     * If this callback returns nonzero, the job transaction it is part of is
+     * aborted. If it returns zero, the job moves into the WAITING state. If it
+     * is the last job to complete in its transaction, all jobs in the
+     * transaction move from WAITING to PENDING.
+     */
     int coroutine_fn (*run)(Job *job, Error **errp);
 
     /**
@@ -496,17 +509,6 @@ void job_early_fail(Job *job);
 /** Moves the @job from RUNNING to READY */
 void job_transition_to_ready(Job *job);
 
-/**
- * @job: The job being completed.
- * @ret: The status code.
- *
- * Marks @job as completed. If @ret is non-zero, the job transaction it is part
- * of is aborted. If @ret is zero, the job moves into the WAITING state. If it
- * is the last job to complete in its transaction, all jobs in the transaction
- * move from WAITING to PENDING.
- */
-void job_completed(Job *job, int ret);
-
 /** Asynchronously complete the specified @job. */
 void job_complete(Job *job, Error **errp);
 
diff --git a/job.c b/job.c
index bc8dad4e71..213042b762 100644
--- a/job.c
+++ b/job.c
@@ -535,6 +535,8 @@ void job_drain(Job *job)
     }
 }
 
+static void job_completed(Job *job);
+
 static void job_exit(void *opaque)
 {
     Job *job = (Job *)opaque;
@@ -545,7 +547,7 @@ static void job_exit(void *opaque)
         job->driver->exit(job);
         aio_context_release(aio_context);
     }
-    job_completed(job, job->ret);
+    job_completed(job);
 }
 
 /**
@@ -883,13 +885,12 @@ static void job_completed_txn_success(Job *job)
     }
 }
 
-void job_completed(Job *job, int ret)
+static void job_completed(Job *job)
 {
     assert(job && job->txn && !job_is_completed(job));
 
-    job->ret = ret;
     job_update_rc(job);
-    trace_job_completed(job, ret, job->ret);
+    trace_job_completed(job, job->ret);
     if (job->ret) {
         job_completed_txn_abort(job);
     } else {
@@ -905,7 +906,7 @@ void job_cancel(Job *job, bool force)
     }
     job_cancel_async(job, force);
     if (!job_started(job)) {
-        job_completed(job, -ECANCELED);
+        job_completed(job);
     } else if (job->deferred_to_main_loop) {
         job_completed_txn_abort(job);
     } else {
diff --git a/trace-events b/trace-events
index c445f54773..4fd2cb4b97 100644
--- a/trace-events
+++ b/trace-events
@@ -107,7 +107,7 @@ gdbstub_err_checksum_incorrect(uint8_t expected, uint8_t got) "got command packe
 # job.c
 job_state_transition(void *job,  int ret, const char *legal, const char *s0, const char *s1) "job %p (ret: %d) attempting %s transition (%s-->%s)"
 job_apply_verb(void *job, const char *state, const char *verb, const char *legal) "job %p in state %s; applying verb %s (%s)"
-job_completed(void *job, int ret, int jret) "job %p ret %d corrected ret %d"
+job_completed(void *job, int ret) "job %p ret %d"
 
 # job-qmp.c
 qmp_job_cancel(void *job) "job %p"
-- 
2.14.4
