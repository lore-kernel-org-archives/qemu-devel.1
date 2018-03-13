Received: from eggs.gnu.org ([2001:4830:134:3::10]:59250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmd6-0001Kf-Lb
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmd4-0004Y1-Ji
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:24 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Mar 2018 17:17:29 +0100
Message-Id: <20180313161803.1814-8-kwolf@redhat.com>
In-Reply-To: <20180313161803.1814-1-kwolf@redhat.com>
References: <20180313161803.1814-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 07/41] blockjobs: add block_job_verb permission
 table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: John Snow <jsnow@redhat.com>

Which commands ("verbs") are appropriate for jobs in which state is
also somewhat burdensome to keep track of.

As of this commit, it looks rather useless, but begins to look more
interesting the more states we add to the STM table.

A recurring theme is that no verb will apply to an 'undefined' job.

Further, it's not presently possible to restrict the "pause" or "resume"
verbs any more than they are in this commit because of the asynchronous
nature of how jobs enter the PAUSED state; justifications for some
seemingly erroneous applications are given below.

=====
Verbs
=====

Cancel:    Any state except undefined.
Pause:     Any state except undefined;
           'created': Requests that the job pauses as it starts.
           'running': Normal usage. (PAUSED)
           'paused':  The job may be paused for internal reasons,
                      but the user may wish to force an indefinite
                      user-pause, so this is allowed.
           'ready':   Normal usage. (STANDBY)
           'standby': Same logic as above.
Resume:    Any state except undefined;
           'created': Will lift a user's pause-on-start request.
           'running': Will lift a pause request before it takes effect.
           'paused':  Normal usage.
           'ready':   Will lift a pause request before it takes effect.
           'standby': Normal usage.
Set-speed: Any state except undefined, though ready may not be meaningful.
Complete:  Only a 'ready' job may accept a complete request.

=======
Changes
=======

(1)

To facilitate "nice" error checking, all five major block-job verb
interfaces in blockjob.c now support an errp parameter:

- block_job_user_cancel is added as a new interface.
- block_job_user_pause gains an errp paramter
- block_job_user_resume gains an errp parameter
- block_job_set_speed already had an errp parameter.
- block_job_complete already had an errp parameter.

(2)

block-job-pause and block-job-resume will no longer no-op when trying
to pause an already paused job, or trying to resume a job that isn't
paused. These functions will now report that they did not perform the
action requested because it was not possible.

iotests have been adjusted to address this new behavior.

(3)

block-job-complete doesn't worry about checking !block_job_started,
because the permission table guards against this.

(4)

test-bdrv-drain's job implementation needs to announce that it is
'ready' now, in order to be completed.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json     | 20 ++++++++++++++
 include/block/blockjob.h | 13 +++++++--
 blockdev.c               | 10 +++----
 blockjob.c               | 71 ++++++++++++++++++++++++++++++++++++++++++------
 tests/test-bdrv-drain.c  |  1 +
 block/trace-events       |  1 +
 6 files changed, 100 insertions(+), 16 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index f8c19a9a2b..217a31385f 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -956,6 +956,26 @@
   'data': ['commit', 'stream', 'mirror', 'backup'] }
 
 ##
+# @BlockJobVerb:
+#
+# Represents command verbs that can be applied to a blockjob.
+#
+# @cancel: see @block-job-cancel
+#
+# @pause: see @block-job-pause
+#
+# @resume: see @block-job-resume
+#
+# @set-speed: see @block-job-set-speed
+#
+# @complete: see @block-job-complete
+#
+# Since: 2.12
+##
+{ 'enum': 'BlockJobVerb',
+  'data': ['cancel', 'pause', 'resume', 'set-speed', 'complete' ] }
+
+##
 # @BlockJobStatus:
 #
 # Indicates the present state of a given blockjob in its lifetime.
diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index b39a2f9521..df0a9773d1 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -249,7 +249,7 @@ BlockJobInfo *block_job_query(BlockJob *job, Error **errp);
  * Asynchronously pause the specified job.
  * Do not allow a resume until a matching call to block_job_user_resume.
  */
-void block_job_user_pause(BlockJob *job);
+void block_job_user_pause(BlockJob *job, Error **errp);
 
 /**
  * block_job_paused:
@@ -266,7 +266,16 @@ bool block_job_user_paused(BlockJob *job);
  * Resume the specified job.
  * Must be paired with a preceding block_job_user_pause.
  */
-void block_job_user_resume(BlockJob *job);
+void block_job_user_resume(BlockJob *job, Error **errp);
+
+/**
+ * block_job_user_cancel:
+ * @job: The job to be cancelled.
+ *
+ * Cancels the specified job, but may refuse to do so if the
+ * operation isn't currently meaningful.
+ */
+void block_job_user_cancel(BlockJob *job, Error **errp);
 
 /**
  * block_job_cancel_sync:
diff --git a/blockdev.c b/blockdev.c
index 1fbfd3a2c4..f70a783803 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3806,7 +3806,7 @@ void qmp_block_job_cancel(const char *device,
     }
 
     trace_qmp_block_job_cancel(job);
-    block_job_cancel(job);
+    block_job_user_cancel(job, errp);
 out:
     aio_context_release(aio_context);
 }
@@ -3816,12 +3816,12 @@ void qmp_block_job_pause(const char *device, Error **errp)
     AioContext *aio_context;
     BlockJob *job = find_block_job(device, &aio_context, errp);
 
-    if (!job || block_job_user_paused(job)) {
+    if (!job) {
         return;
     }
 
     trace_qmp_block_job_pause(job);
-    block_job_user_pause(job);
+    block_job_user_pause(job, errp);
     aio_context_release(aio_context);
 }
 
@@ -3830,12 +3830,12 @@ void qmp_block_job_resume(const char *device, Error **errp)
     AioContext *aio_context;
     BlockJob *job = find_block_job(device, &aio_context, errp);
 
-    if (!job || !block_job_user_paused(job)) {
+    if (!job) {
         return;
     }
 
     trace_qmp_block_job_resume(job);
-    block_job_user_resume(job);
+    block_job_user_resume(job, errp);
     aio_context_release(aio_context);
 }
 
diff --git a/blockjob.c b/blockjob.c
index 442426e27b..d369c0cb4d 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -53,6 +53,15 @@ bool BlockJobSTT[BLOCK_JOB_STATUS__MAX][BLOCK_JOB_STATUS__MAX] = {
     /* S: */ [BLOCK_JOB_STATUS_STANDBY]   = {0, 0, 0, 0, 1, 0},
 };
 
+bool BlockJobVerbTable[BLOCK_JOB_VERB__MAX][BLOCK_JOB_STATUS__MAX] = {
+                                          /* U, C, R, P, Y, S */
+    [BLOCK_JOB_VERB_CANCEL]               = {0, 1, 1, 1, 1, 1},
+    [BLOCK_JOB_VERB_PAUSE]                = {0, 1, 1, 1, 1, 1},
+    [BLOCK_JOB_VERB_RESUME]               = {0, 1, 1, 1, 1, 1},
+    [BLOCK_JOB_VERB_SET_SPEED]            = {0, 1, 1, 1, 1, 1},
+    [BLOCK_JOB_VERB_COMPLETE]             = {0, 0, 0, 0, 1, 0},
+};
+
 static void block_job_state_transition(BlockJob *job, BlockJobStatus s1)
 {
     BlockJobStatus s0 = job->status;
@@ -67,6 +76,23 @@ static void block_job_state_transition(BlockJob *job, BlockJobStatus s1)
     job->status = s1;
 }
 
+static int block_job_apply_verb(BlockJob *job, BlockJobVerb bv, Error **errp)
+{
+    assert(bv >= 0 && bv <= BLOCK_JOB_VERB__MAX);
+    trace_block_job_apply_verb(job, qapi_enum_lookup(&BlockJobStatus_lookup,
+                                                     job->status),
+                               qapi_enum_lookup(&BlockJobVerb_lookup, bv),
+                               BlockJobVerbTable[bv][job->status] ?
+                               "allowed" : "prohibited");
+    if (BlockJobVerbTable[bv][job->status]) {
+        return 0;
+    }
+    error_setg(errp, "Job '%s' in state '%s' cannot accept command verb '%s'",
+               job->id, qapi_enum_lookup(&BlockJobStatus_lookup, job->status),
+               qapi_enum_lookup(&BlockJobVerb_lookup, bv));
+    return -EPERM;
+}
+
 static void block_job_lock(void)
 {
     qemu_mutex_lock(&block_job_mutex);
@@ -517,6 +543,9 @@ void block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
         error_setg(errp, QERR_UNSUPPORTED);
         return;
     }
+    if (block_job_apply_verb(job, BLOCK_JOB_VERB_SET_SPEED, errp)) {
+        return;
+    }
     job->driver->set_speed(job, speed, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -536,8 +565,10 @@ void block_job_complete(BlockJob *job, Error **errp)
 {
     /* Should not be reachable via external interface for internal jobs */
     assert(job->id);
-    if (job->pause_count || job->cancelled ||
-        !block_job_started(job) || !job->driver->complete) {
+    if (block_job_apply_verb(job, BLOCK_JOB_VERB_COMPLETE, errp)) {
+        return;
+    }
+    if (job->pause_count || job->cancelled || !job->driver->complete) {
         error_setg(errp, "The active block job '%s' cannot be completed",
                    job->id);
         return;
@@ -546,8 +577,15 @@ void block_job_complete(BlockJob *job, Error **errp)
     job->driver->complete(job, errp);
 }
 
-void block_job_user_pause(BlockJob *job)
+void block_job_user_pause(BlockJob *job, Error **errp)
 {
+    if (block_job_apply_verb(job, BLOCK_JOB_VERB_PAUSE, errp)) {
+        return;
+    }
+    if (job->user_paused) {
+        error_setg(errp, "Job is already paused");
+        return;
+    }
     job->user_paused = true;
     block_job_pause(job);
 }
@@ -557,13 +595,19 @@ bool block_job_user_paused(BlockJob *job)
     return job->user_paused;
 }
 
-void block_job_user_resume(BlockJob *job)
+void block_job_user_resume(BlockJob *job, Error **errp)
 {
-    if (job && job->user_paused && job->pause_count > 0) {
-        block_job_iostatus_reset(job);
-        job->user_paused = false;
-        block_job_resume(job);
+    assert(job);
+    if (!job->user_paused || job->pause_count <= 0) {
+        error_setg(errp, "Can't resume a job that was not paused");
+        return;
+    }
+    if (block_job_apply_verb(job, BLOCK_JOB_VERB_RESUME, errp)) {
+        return;
     }
+    block_job_iostatus_reset(job);
+    job->user_paused = false;
+    block_job_resume(job);
 }
 
 void block_job_cancel(BlockJob *job)
@@ -576,6 +620,14 @@ void block_job_cancel(BlockJob *job)
     }
 }
 
+void block_job_user_cancel(BlockJob *job, Error **errp)
+{
+    if (block_job_apply_verb(job, BLOCK_JOB_VERB_CANCEL, errp)) {
+        return;
+    }
+    block_job_cancel(job);
+}
+
 /* A wrapper around block_job_cancel() taking an Error ** parameter so it may be
  * used with block_job_finish_sync() without the need for (rather nasty)
  * function pointer casts there. */
@@ -999,8 +1051,9 @@ BlockErrorAction block_job_error_action(BlockJob *job, BlockdevOnError on_err,
                                         action, &error_abort);
     }
     if (action == BLOCK_ERROR_ACTION_STOP) {
+        block_job_pause(job);
         /* make the pause user visible, which will be resumed from QMP. */
-        block_job_user_pause(job);
+        job->user_paused = true;
         block_job_iostatus_set_err(job, error);
     }
     return action;
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index a7eecf1c1e..7673de1062 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -505,6 +505,7 @@ static void coroutine_fn test_job_start(void *opaque)
 {
     TestBlockJob *s = opaque;
 
+    block_job_event_ready(&s->common);
     while (!s->should_complete) {
         block_job_sleep_ns(&s->common, 100000);
     }
diff --git a/block/trace-events b/block/trace-events
index b75a0c8409..3fe89f7ea6 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -6,6 +6,7 @@ bdrv_lock_medium(void *bs, bool locked) "bs %p locked %d"
 
 # blockjob.c
 block_job_state_transition(void *job,  int ret, const char *legal, const char *s0, const char *s1) "job %p (ret: %d) attempting %s transition (%s-->%s)"
+block_job_apply_verb(void *job, const char *state, const char *verb, const char *legal) "job %p in state %s; applying verb %s (%s)"
 
 # block/block-backend.c
 blk_co_preadv(void *blk, void *bs, int64_t offset, unsigned int bytes, int flags) "blk %p bs %p offset %"PRId64" bytes %u flags 0x%x"
-- 
2.13.6
