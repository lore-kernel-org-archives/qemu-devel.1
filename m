Received: from eggs.gnu.org ([2001:4830:134:3::10]:52788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLTZ1-0001p8-Gy
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:12:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLTYz-0006yn-Ff
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:12:23 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 23 May 2018 15:11:22 +0200
Message-Id: <20180523131155.12359-14-kwolf@redhat.com>
In-Reply-To: <20180523131155.12359-1-kwolf@redhat.com>
References: <20180523131155.12359-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 13/46] job: Maintain a list of all jobs
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

This moves the job list from BlockJob to Job. Now we can check for
duplicate IDs in job_create().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 include/block/blockjob.h |  3 ---
 include/qemu/job.h       | 19 +++++++++++++++++++
 blockjob.c               | 46 ++++++++++++++++++++++++----------------------
 job.c                    | 31 +++++++++++++++++++++++++++++++
 4 files changed, 74 insertions(+), 25 deletions(-)

diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 640e649034..10bd9f7059 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -105,9 +105,6 @@ typedef struct BlockJob {
      */
     bool deferred_to_main_loop;
 
-    /** Element of the list of block jobs */
-    QLIST_ENTRY(BlockJob) job_list;
-
     /** Status that is published by the query-block-jobs QMP API */
     BlockDeviceIoStatus iostatus;
 
diff --git a/include/qemu/job.h b/include/qemu/job.h
index 43dc2e4a7d..bae2b0920c 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -27,6 +27,7 @@
 #define JOB_H
 
 #include "qapi/qapi-types-block-core.h"
+#include "qemu/queue.h"
 
 typedef struct JobDriver JobDriver;
 
@@ -39,6 +40,9 @@ typedef struct Job {
 
     /** The type of this job. */
     const JobDriver *driver;
+
+    /** Element of the list of jobs */
+    QLIST_ENTRY(Job) job_list;
 } Job;
 
 /**
@@ -71,4 +75,19 @@ JobType job_type(const Job *job);
 /** Returns the enum string for the JobType of a given Job. */
 const char *job_type_str(const Job *job);
 
+/**
+ * Get the next element from the list of block jobs after @job, or the
+ * first one if @job is %NULL.
+ *
+ * Returns the requested job, or %NULL if there are no more jobs left.
+ */
+Job *job_next(Job *job);
+
+/**
+ * Get the job identified by @id (which must not be %NULL).
+ *
+ * Returns the requested job, or %NULL if it doesn't exist.
+ */
+Job *job_get(const char *id);
+
 #endif
diff --git a/blockjob.c b/blockjob.c
index 430a67ba63..c69b2e7cf5 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -129,8 +129,6 @@ struct BlockJobTxn {
     int refcnt;
 };
 
-static QLIST_HEAD(, BlockJob) block_jobs = QLIST_HEAD_INITIALIZER(block_jobs);
-
 /*
  * The block job API is composed of two categories of functions.
  *
@@ -146,25 +144,34 @@ static QLIST_HEAD(, BlockJob) block_jobs = QLIST_HEAD_INITIALIZER(block_jobs);
  * blockjob_int.h.
  */
 
-BlockJob *block_job_next(BlockJob *job)
+static bool is_block_job(Job *job)
 {
-    if (!job) {
-        return QLIST_FIRST(&block_jobs);
-    }
-    return QLIST_NEXT(job, job_list);
+    return job_type(job) == JOB_TYPE_BACKUP ||
+           job_type(job) == JOB_TYPE_COMMIT ||
+           job_type(job) == JOB_TYPE_MIRROR ||
+           job_type(job) == JOB_TYPE_STREAM;
+}
+
+BlockJob *block_job_next(BlockJob *bjob)
+{
+    Job *job = bjob ? &bjob->job : NULL;
+
+    do {
+        job = job_next(job);
+    } while (job && !is_block_job(job));
+
+    return job ? container_of(job, BlockJob, job) : NULL;
 }
 
 BlockJob *block_job_get(const char *id)
 {
-    BlockJob *job;
+    Job *job = job_get(id);
 
-    QLIST_FOREACH(job, &block_jobs, job_list) {
-        if (job->job.id && !strcmp(id, job->job.id)) {
-            return job;
-        }
+    if (job && is_block_job(job)) {
+        return container_of(job, BlockJob, job);
+    } else {
+        return NULL;
     }
-
-    return NULL;
 }
 
 BlockJobTxn *block_job_txn_new(void)
@@ -253,7 +260,6 @@ void block_job_unref(BlockJob *job)
         assert(job->status == BLOCK_JOB_STATUS_NULL);
         assert(!job->txn);
         BlockDriverState *bs = blk_bs(job->blk);
-        QLIST_REMOVE(job, job_list);
         bs->job = NULL;
         block_job_remove_all_bdrv(job);
         blk_remove_aio_context_notifier(job->blk,
@@ -812,7 +818,7 @@ void block_job_cancel_sync_all(void)
     BlockJob *job;
     AioContext *aio_context;
 
-    while ((job = QLIST_FIRST(&block_jobs))) {
+    while ((job = block_job_next(NULL))) {
         aio_context = blk_get_aio_context(job->blk);
         aio_context_acquire(aio_context);
         block_job_cancel_sync(job);
@@ -942,10 +948,6 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
             error_setg(errp, "Cannot specify job ID for internal block job");
             return NULL;
         }
-        if (block_job_get(job_id)) {
-            error_setg(errp, "Job ID '%s' already in use", job_id);
-            return NULL;
-        }
     }
 
     blk = blk_new(perm, shared_perm);
@@ -961,6 +963,8 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
         return NULL;
     }
 
+    assert(is_block_job(&job->job));
+
     job->driver        = driver;
     job->blk           = blk;
     job->cb            = cb;
@@ -983,8 +987,6 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
 
     bdrv_op_unblock(bs, BLOCK_OP_TYPE_DATAPLANE, job->blocker);
 
-    QLIST_INSERT_HEAD(&block_jobs, job, job_list);
-
     blk_add_aio_context_notifier(blk, block_job_attached_aio_context,
                                  block_job_detach_aio_context, job);
 
diff --git a/job.c b/job.c
index cfdd008c52..e57303c6bb 100644
--- a/job.c
+++ b/job.c
@@ -29,6 +29,8 @@
 #include "qemu/job.h"
 #include "qemu/id.h"
 
+static QLIST_HEAD(, Job) jobs = QLIST_HEAD_INITIALIZER(jobs);
+
 JobType job_type(const Job *job)
 {
     return job->driver->job_type;
@@ -39,6 +41,27 @@ const char *job_type_str(const Job *job)
     return JobType_str(job_type(job));
 }
 
+Job *job_next(Job *job)
+{
+    if (!job) {
+        return QLIST_FIRST(&jobs);
+    }
+    return QLIST_NEXT(job, job_list);
+}
+
+Job *job_get(const char *id)
+{
+    Job *job;
+
+    QLIST_FOREACH(job, &jobs, job_list) {
+        if (job->id && !strcmp(id, job->id)) {
+            return job;
+        }
+    }
+
+    return NULL;
+}
+
 void *job_create(const char *job_id, const JobDriver *driver, Error **errp)
 {
     Job *job;
@@ -48,17 +71,25 @@ void *job_create(const char *job_id, const JobDriver *driver, Error **errp)
             error_setg(errp, "Invalid job ID '%s'", job_id);
             return NULL;
         }
+        if (job_get(job_id)) {
+            error_setg(errp, "Job ID '%s' already in use", job_id);
+            return NULL;
+        }
     }
 
     job = g_malloc0(driver->instance_size);
     job->driver        = driver;
     job->id            = g_strdup(job_id);
 
+    QLIST_INSERT_HEAD(&jobs, job, job_list);
+
     return job;
 }
 
 void job_delete(Job *job)
 {
+    QLIST_REMOVE(job, job_list);
+
     g_free(job->id);
     g_free(job);
 }
-- 
2.13.6
