Received: from eggs.gnu.org ([2001:4830:134:3::10]:52883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fGRwl-00063S-RJ
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:28:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fGRwi-0002x3-Hv
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:28:07 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  9 May 2018 18:26:31 +0200
Message-Id: <20180509162637.15575-37-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-1-kwolf@redhat.com>
References: <20180509162637.15575-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 36/42] job: Add job_transition_to_ready()
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

The transition to the READY state was still performed in the BlockJob
layer, in the same function that sent the BLOCK_JOB_READY QMP event.

This patch brings the state transition to the Job layer and implements
the QMP event using a notifier called from the Job layer, like we
already do for other events related to state transitions.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/blockjob.h     |  3 +++
 include/block/blockjob_int.h |  8 --------
 include/qemu/job.h           |  9 ++++++---
 block/mirror.c               |  6 +++---
 blockjob.c                   | 36 +++++++++++++++++++-----------------
 job.c                        | 16 +++++++++++++---
 tests/test-bdrv-drain.c      |  2 +-
 tests/test-blockjob.c        |  2 +-
 8 files changed, 46 insertions(+), 36 deletions(-)

diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 932a12d1a6..d2f0d81dfa 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -76,6 +76,9 @@ typedef struct BlockJob {
     /** Called when the job transitions to PENDING */
     Notifier pending_notifier;
 
+    /** Called when the job transitions to READY */
+    Notifier ready_notifier;
+
     /** BlockDriverStates that are involved in this block job */
     GSList *nodes;
 } BlockJob;
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index 806ac64d87..5cd50c6639 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -116,14 +116,6 @@ void block_job_drain(Job *job);
 int64_t block_job_ratelimit_get_delay(BlockJob *job, uint64_t n);
 
 /**
- * block_job_event_ready:
- * @job: The job which is now ready to be completed.
- *
- * Send a BLOCK_JOB_READY event for the specified job.
- */
-void block_job_event_ready(BlockJob *job);
-
-/**
  * block_job_error_action:
  * @job: The job to signal an error for.
  * @on_err: The error action setting.
diff --git a/include/qemu/job.h b/include/qemu/job.h
index fb81cc7c09..20b48926d9 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -132,6 +132,9 @@ typedef struct Job {
     /** Notifiers called when the job transitions to PENDING */
     NotifierList on_pending;
 
+    /** Notifiers called when the job transitions to READY */
+    NotifierList on_ready;
+
     /** Element of the list of jobs */
     QLIST_ENTRY(Job) job_list;
 
@@ -426,6 +429,9 @@ int job_apply_verb(Job *job, JobVerb bv, Error **errp);
 /** The @job could not be started, free it. */
 void job_early_fail(Job *job);
 
+/** Moves the @job from RUNNING to READY */
+void job_transition_to_ready(Job *job);
+
 /**
  * @job: The job being completed.
  * @ret: The status code.
@@ -522,7 +528,4 @@ void job_defer_to_main_loop(Job *job, JobDeferToMainLoopFn *fn, void *opaque);
  */
 int job_finish_sync(Job *job, void (*finish)(Job *, Error **errp), Error **errp);
 
-/* TODO To be removed from the public interface */
-void job_state_transition(Job *job, JobStatus s1);
-
 #endif
diff --git a/block/mirror.c b/block/mirror.c
index 67a9482c16..376b08bdcd 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -727,8 +727,8 @@ static void coroutine_fn mirror_run(void *opaque)
     }
 
     if (s->bdev_length == 0) {
-        /* Report BLOCK_JOB_READY and wait for complete. */
-        block_job_event_ready(&s->common);
+        /* Transition to the READY state and wait for complete. */
+        job_transition_to_ready(&s->common.job);
         s->synced = true;
         while (!job_is_cancelled(&s->common.job) && !s->should_complete) {
             job_yield(&s->common.job);
@@ -825,7 +825,7 @@ static void coroutine_fn mirror_run(void *opaque)
                  * report completion.  This way, block-job-cancel will leave
                  * the target in a consistent state.
                  */
-                block_job_event_ready(&s->common);
+                job_transition_to_ready(&s->common.job);
                 s->synced = true;
             }
 
diff --git a/blockjob.c b/blockjob.c
index 0512b41901..27f3199a20 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -339,6 +339,22 @@ static void block_job_event_pending(Notifier *n, void *opaque)
                                       &error_abort);
 }
 
+static void block_job_event_ready(Notifier *n, void *opaque)
+{
+    BlockJob *job = opaque;
+
+    if (block_job_is_internal(job)) {
+        return;
+    }
+
+    qapi_event_send_block_job_ready(job_type(&job->job),
+                                    job->job.id,
+                                    job->len,
+                                    job->offset,
+                                    job->speed, &error_abort);
+}
+
+
 /*
  * API for block job drivers and the block layer.  These functions are
  * declared in blockjob_int.h.
@@ -387,13 +403,14 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     job->finalize_cancelled_notifier.notify = block_job_event_cancelled;
     job->finalize_completed_notifier.notify = block_job_event_completed;
     job->pending_notifier.notify = block_job_event_pending;
+    job->ready_notifier.notify = block_job_event_ready;
 
     notifier_list_add(&job->job.on_finalize_cancelled,
                       &job->finalize_cancelled_notifier);
     notifier_list_add(&job->job.on_finalize_completed,
                       &job->finalize_completed_notifier);
-    notifier_list_add(&job->job.on_pending,
-                      &job->pending_notifier);
+    notifier_list_add(&job->job.on_pending, &job->pending_notifier);
+    notifier_list_add(&job->job.on_ready, &job->ready_notifier);
 
     error_setg(&job->blocker, "block device is in use by block job: %s",
                job_type_str(&job->job));
@@ -435,21 +452,6 @@ void block_job_user_resume(Job *job)
     block_job_iostatus_reset(bjob);
 }
 
-void block_job_event_ready(BlockJob *job)
-{
-    job_state_transition(&job->job, JOB_STATUS_READY);
-
-    if (block_job_is_internal(job)) {
-        return;
-    }
-
-    qapi_event_send_block_job_ready(job_type(&job->job),
-                                    job->job.id,
-                                    job->len,
-                                    job->offset,
-                                    job->speed, &error_abort);
-}
-
 BlockErrorAction block_job_error_action(BlockJob *job, BlockdevOnError on_err,
                                         int is_read, int error)
 {
diff --git a/job.c b/job.c
index a500e8d1fd..4e898b5c5e 100644
--- a/job.c
+++ b/job.c
@@ -157,9 +157,7 @@ static int job_txn_apply(JobTxn *txn, int fn(Job *), bool lock)
     return rc;
 }
 
-
-/* TODO Make static once the whole state machine is in job.c */
-void job_state_transition(Job *job, JobStatus s1)
+static void job_state_transition(Job *job, JobStatus s1)
 {
     JobStatus s0 = job->status;
     assert(s1 >= 0 && s1 <= JOB_STATUS__MAX);
@@ -321,6 +319,7 @@ void *job_create(const char *job_id, const JobDriver *driver, JobTxn *txn,
     notifier_list_init(&job->on_finalize_cancelled);
     notifier_list_init(&job->on_finalize_completed);
     notifier_list_init(&job->on_pending);
+    notifier_list_init(&job->on_ready);
 
     job_state_transition(job, JOB_STATUS_CREATED);
     aio_timer_init(qemu_get_aio_context(), &job->sleep_timer,
@@ -381,6 +380,11 @@ static int job_event_pending(Job *job)
     return 0;
 }
 
+static void job_event_ready(Job *job)
+{
+    notifier_list_notify(&job->on_ready, job);
+}
+
 void job_enter_cond(Job *job, bool(*fn)(Job *job))
 {
     if (!job_started(job)) {
@@ -792,6 +796,12 @@ static int job_transition_to_pending(Job *job)
     return 0;
 }
 
+void job_transition_to_ready(Job *job)
+{
+    job_state_transition(job, JOB_STATUS_READY);
+    job_event_ready(job);
+}
+
 static void job_completed_txn_success(Job *job)
 {
     JobTxn *txn = job->txn;
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 3600ffd3fb..2cba63b881 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -505,7 +505,7 @@ static void coroutine_fn test_job_start(void *opaque)
 {
     TestBlockJob *s = opaque;
 
-    block_job_event_ready(&s->common);
+    job_transition_to_ready(&s->common.job);
     while (!s->should_complete) {
         job_sleep_ns(&s->common.job, 100000);
     }
diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
index 8180d03a5f..e408d52351 100644
--- a/tests/test-blockjob.c
+++ b/tests/test-blockjob.c
@@ -186,7 +186,7 @@ static void coroutine_fn cancel_job_start(void *opaque)
         }
 
         if (!job_is_ready(&s->common.job) && s->should_converge) {
-            block_job_event_ready(&s->common);
+            job_transition_to_ready(&s->common.job);
         }
 
         job_sleep_ns(&s->common.job, 100000);
-- 
2.13.6
