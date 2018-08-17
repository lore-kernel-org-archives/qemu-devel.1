Received: from eggs.gnu.org ([2001:4830:134:3::10]:36708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fqk90-0001Jh-I3
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 15:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fqk3i-0006mR-2J
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 15:05:19 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 17 Aug 2018 15:04:52 -0400
Message-Id: <20180817190457.8292-3-jsnow@redhat.com>
In-Reply-To: <20180817190457.8292-1-jsnow@redhat.com>
References: <20180817190457.8292-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 2/7] jobs: canonize Error object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>, kwolf@redhat.com, jtc@redhat.com, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

Jobs presently use both an Error object in the case of the create job,
and char strings in the case of generic errors elsewhere.

Unify the two paths as just j->err, and remove the extra argument from
job_completed. The integer error code for job_completed is kept for now
for use by pre-emptive cancellation.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/backup.c            |  2 +-
 block/commit.c            |  2 +-
 block/create.c            |  5 ++---
 block/mirror.c            |  2 +-
 block/stream.c            |  2 +-
 include/qemu/job.h        | 10 ++++------
 job-qmp.c                 |  5 +++--
 job.c                     | 19 ++++++-------------
 tests/test-bdrv-drain.c   |  2 +-
 tests/test-blockjob-txn.c |  2 +-
 tests/test-blockjob.c     |  2 +-
 11 files changed, 22 insertions(+), 31 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 5d47781840..1e965d54e5 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -388,7 +388,7 @@ static void backup_complete(Job *job, void *opaque)
 {
     BackupCompleteData *data = opaque;
 
-    job_completed(job, data->ret, NULL);
+    job_completed(job, data->ret);
     g_free(data);
 }
 
diff --git a/block/commit.c b/block/commit.c
index a0ea86ff64..4a17bb73ec 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -117,7 +117,7 @@ static void commit_complete(Job *job, void *opaque)
      * bdrv_set_backing_hd() to fail. */
     block_job_remove_all_bdrv(bjob);
 
-    job_completed(job, ret, NULL);
+    job_completed(job, ret);
     g_free(data);
 
     /* If bdrv_drop_intermediate() didn't already do that, remove the commit
diff --git a/block/create.c b/block/create.c
index 04733c3618..26a385c6c7 100644
--- a/block/create.c
+++ b/block/create.c
@@ -35,14 +35,13 @@ typedef struct BlockdevCreateJob {
     BlockDriver *drv;
     BlockdevCreateOptions *opts;
     int ret;
-    Error *err;
 } BlockdevCreateJob;
 
 static void blockdev_create_complete(Job *job, void *opaque)
 {
     BlockdevCreateJob *s = container_of(job, BlockdevCreateJob, common);
 
-    job_completed(job, s->ret, s->err);
+    job_completed(job, s->ret);
 }
 
 static int coroutine_fn blockdev_create_run(Job *job, Error **errp)
@@ -50,7 +49,7 @@ static int coroutine_fn blockdev_create_run(Job *job, Error **errp)
     BlockdevCreateJob *s = container_of(job, BlockdevCreateJob, common);
 
     job_progress_set_remaining(&s->common, 1);
-    s->ret = s->drv->bdrv_co_create(s->opts, &s->err);
+    s->ret = s->drv->bdrv_co_create(s->opts, errp);
     job_progress_update(&s->common, 1);
 
     qapi_free_BlockdevCreateOptions(s->opts);
diff --git a/block/mirror.c b/block/mirror.c
index 691763db41..be5dc6b7b0 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -710,7 +710,7 @@ static void mirror_exit(Job *job, void *opaque)
     blk_insert_bs(bjob->blk, mirror_top_bs, &error_abort);
 
     bs_opaque->job = NULL;
-    job_completed(job, data->ret, NULL);
+    job_completed(job, data->ret);
 
     g_free(data);
     bdrv_drained_end(src);
diff --git a/block/stream.c b/block/stream.c
index b4b987df7e..26a775386b 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -93,7 +93,7 @@ out:
     }
 
     g_free(s->backing_file_str);
-    job_completed(job, data->ret, NULL);
+    job_completed(job, data->ret);
     g_free(data);
 }
 
diff --git a/include/qemu/job.h b/include/qemu/job.h
index 9cf463d228..5c92c53ef0 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -124,12 +124,12 @@ typedef struct Job {
     /** Estimated progress_current value at the completion of the job */
     int64_t progress_total;
 
-    /** Error string for a failed job (NULL if, and only if, job->ret == 0) */
-    char *error;
-
     /** ret code passed to job_completed. */
     int ret;
 
+    /** Error object for a failed job **/
+    Error *err;
+
     /** The completion function that will be called when the job completes.  */
     BlockCompletionFunc *cb;
 
@@ -484,15 +484,13 @@ void job_transition_to_ready(Job *job);
 /**
  * @job: The job being completed.
  * @ret: The status code.
- * @error: The error message for a failing job (only with @ret < 0). If @ret is
- *         negative, but NULL is given for @error, strerror() is used.
  *
  * Marks @job as completed. If @ret is non-zero, the job transaction it is part
  * of is aborted. If @ret is zero, the job moves into the WAITING state. If it
  * is the last job to complete in its transaction, all jobs in the transaction
  * move from WAITING to PENDING.
  */
-void job_completed(Job *job, int ret, Error *error);
+void job_completed(Job *job, int ret);
 
 /** Asynchronously complete the specified @job. */
 void job_complete(Job *job, Error **errp);
diff --git a/job-qmp.c b/job-qmp.c
index 410775df61..a969b2bbf0 100644
--- a/job-qmp.c
+++ b/job-qmp.c
@@ -146,8 +146,9 @@ static JobInfo *job_query_single(Job *job, Error **errp)
         .status             = job->status,
         .current_progress   = job->progress_current,
         .total_progress     = job->progress_total,
-        .has_error          = !!job->error,
-        .error              = g_strdup(job->error),
+        .has_error          = !!job->err,
+        .error              = job->err ? \
+                              g_strdup(error_get_pretty(job->err)) : NULL,
     };
 
     return info;
diff --git a/job.c b/job.c
index 898260b2b3..c9de1af556 100644
--- a/job.c
+++ b/job.c
@@ -369,7 +369,7 @@ void job_unref(Job *job)
 
         QLIST_REMOVE(job, job_list);
 
-        g_free(job->error);
+        error_free(job->err);
         g_free(job->id);
         g_free(job);
     }
@@ -535,7 +535,6 @@ void job_drain(Job *job)
     }
 }
 
-
 /**
  * All jobs must allow a pause point before entering their job proper. This
  * ensures that jobs can be paused prior to being started, then resumed later.
@@ -546,7 +545,7 @@ static void coroutine_fn job_co_entry(void *opaque)
 
     assert(job && job->driver && job->driver->run);
     job_pause_point(job);
-    job->ret = job->driver->run(job, NULL);
+    job->ret = job->driver->run(job, &job->err);
 }
 
 
@@ -666,8 +665,8 @@ static void job_update_rc(Job *job)
         job->ret = -ECANCELED;
     }
     if (job->ret) {
-        if (!job->error) {
-            job->error = g_strdup(strerror(-job->ret));
+        if (!job->err) {
+            error_setg_errno(&job->err, -job->ret, "job failed");
         }
         job_state_transition(job, JOB_STATUS_ABORTING);
     }
@@ -865,17 +864,11 @@ static void job_completed_txn_success(Job *job)
     }
 }
 
-void job_completed(Job *job, int ret, Error *error)
+void job_completed(Job *job, int ret)
 {
     assert(job && job->txn && !job_is_completed(job));
 
     job->ret = ret;
-    if (error) {
-        assert(job->ret < 0);
-        job->error = g_strdup(error_get_pretty(error));
-        error_free(error);
-    }
-
     job_update_rc(job);
     trace_job_completed(job, ret, job->ret);
     if (job->ret) {
@@ -893,7 +886,7 @@ void job_cancel(Job *job, bool force)
     }
     job_cancel_async(job, force);
     if (!job_started(job)) {
-        job_completed(job, -ECANCELED, NULL);
+        job_completed(job, -ECANCELED);
     } else if (job->deferred_to_main_loop) {
         job_completed_txn_abort(job);
     } else {
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index a7533861f6..00604dfc0c 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -754,7 +754,7 @@ typedef struct TestBlockJob {
 
 static void test_job_completed(Job *job, void *opaque)
 {
-    job_completed(job, 0, NULL);
+    job_completed(job, 0);
 }
 
 static int coroutine_fn test_job_run(Job *job, Error **errp)
diff --git a/tests/test-blockjob-txn.c b/tests/test-blockjob-txn.c
index 3194924071..82cedee78b 100644
--- a/tests/test-blockjob-txn.c
+++ b/tests/test-blockjob-txn.c
@@ -34,7 +34,7 @@ static void test_block_job_complete(Job *job, void *opaque)
         rc = -ECANCELED;
     }
 
-    job_completed(job, rc, NULL);
+    job_completed(job, rc);
     bdrv_unref(bs);
 }
 
diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
index b0462bfdec..408a226939 100644
--- a/tests/test-blockjob.c
+++ b/tests/test-blockjob.c
@@ -167,7 +167,7 @@ static void cancel_job_completed(Job *job, void *opaque)
 {
     CancelJob *s = opaque;
     s->completed = true;
-    job_completed(job, 0, NULL);
+    job_completed(job, 0);
 }
 
 static void cancel_job_complete(Job *job, Error **errp)
-- 
2.14.4
