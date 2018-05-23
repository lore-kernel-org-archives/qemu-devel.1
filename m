Received: from eggs.gnu.org ([2001:4830:134:3::10]:52891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLTZ5-0001sy-TL
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:12:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLTYz-0006yh-Dy
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:12:27 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 23 May 2018 15:11:26 +0200
Message-Id: <20180523131155.12359-18-kwolf@redhat.com>
In-Reply-To: <20180523131155.12359-1-kwolf@redhat.com>
References: <20180523131155.12359-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 17/46] job: Add Job.aio_context
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

When block jobs need an AioContext, they just take it from their main
block node. Generic jobs don't have a main block node, so we need to
assign them an AioContext explicitly.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 include/qemu/job.h | 7 ++++++-
 blockjob.c         | 5 ++++-
 job.c              | 4 +++-
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/qemu/job.h b/include/qemu/job.h
index 5dfbec5d69..01e083f97a 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -47,6 +47,9 @@ typedef struct Job {
     /** Current state; See @JobStatus for details. */
     JobStatus status;
 
+    /** AioContext to run the job coroutine in */
+    AioContext *aio_context;
+
     /**
      * Set to true if the job should cancel itself.  The flag must
      * always be tested just before toggling the busy flag from false
@@ -79,9 +82,11 @@ struct JobDriver {
  *
  * @job_id: The id of the newly-created job, or %NULL for internal jobs
  * @driver: The class object for the newly-created job.
+ * @ctx: The AioContext to run the job coroutine in.
  * @errp: Error object.
  */
-void *job_create(const char *job_id, const JobDriver *driver, Error **errp);
+void *job_create(const char *job_id, const JobDriver *driver, AioContext *ctx,
+                 Error **errp);
 
 /**
  * Add a reference to Job refcnt, it will be decreased with job_unref, and then
diff --git a/blockjob.c b/blockjob.c
index f4f9956678..0a0b1c41dd 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -216,6 +216,7 @@ static void block_job_attached_aio_context(AioContext *new_context,
 {
     BlockJob *job = opaque;
 
+    job->job.aio_context = new_context;
     if (job->driver->attached_aio_context) {
         job->driver->attached_aio_context(job, new_context);
     }
@@ -247,6 +248,7 @@ static void block_job_detach_aio_context(void *opaque)
         block_job_drain(job);
     }
 
+    job->job.aio_context = NULL;
     job_unref(&job->job);
 }
 
@@ -899,7 +901,8 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
         return NULL;
     }
 
-    job = job_create(job_id, &driver->job_driver, errp);
+    job = job_create(job_id, &driver->job_driver, blk_get_aio_context(blk),
+                     errp);
     if (job == NULL) {
         blk_unref(blk);
         return NULL;
diff --git a/job.c b/job.c
index 1abca6a2fc..01074d0fae 100644
--- a/job.c
+++ b/job.c
@@ -121,7 +121,8 @@ Job *job_get(const char *id)
     return NULL;
 }
 
-void *job_create(const char *job_id, const JobDriver *driver, Error **errp)
+void *job_create(const char *job_id, const JobDriver *driver, AioContext *ctx,
+                 Error **errp)
 {
     Job *job;
 
@@ -140,6 +141,7 @@ void *job_create(const char *job_id, const JobDriver *driver, Error **errp)
     job->driver        = driver;
     job->id            = g_strdup(job_id);
     job->refcnt        = 1;
+    job->aio_context   = ctx;
 
     job_state_transition(job, JOB_STATUS_CREATED);
 
-- 
2.13.6
