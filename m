Received: from eggs.gnu.org ([2001:4830:134:3::10]:46545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0R6v-000227-Df
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:52:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0R6u-0001b5-Bi
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:52:41 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 13 Sep 2018 14:52:02 +0200
Message-Id: <20180913125217.23173-3-kwolf@redhat.com>
In-Reply-To: <20180913125217.23173-1-kwolf@redhat.com>
References: <20180913125217.23173-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 02/17] blockjob: Wake up BDS when job
 becomes idle
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

In the context of draining a BDS, the .drained_poll callback of block
jobs is called. If this returns true (i.e. there is still some activity
pending), the drain operation may call aio_poll() with blocking=true to
wait for completion.

As soon as the pending activity is completed and the job finally arrives
in a quiescent state (i.e. its coroutine either yields with busy=false
or terminates), the block job must notify the aio_poll() loop to wake
up, otherwise we get a deadlock if both are running in different
threads.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
---
 include/block/blockjob.h | 13 +++++++++++++
 include/qemu/job.h       |  3 +++
 blockjob.c               | 18 ++++++++++++++++++
 job.c                    |  7 +++++++
 4 files changed, 41 insertions(+)

diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 32c00b7dc0..2290bbb824 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -70,6 +70,9 @@ typedef struct BlockJob {
     /** Called when the job transitions to READY */
     Notifier ready_notifier;
 
+    /** Called when the job coroutine yields or terminates */
+    Notifier idle_notifier;
+
     /** BlockDriverStates that are involved in this block job */
     GSList *nodes;
 } BlockJob;
@@ -119,6 +122,16 @@ int block_job_add_bdrv(BlockJob *job, const char *name, BlockDriverState *bs,
 void block_job_remove_all_bdrv(BlockJob *job);
 
 /**
+ * block_job_wakeup_all_bdrv:
+ * @job: The block job
+ *
+ * Calls bdrv_wakeup() for all BlockDriverStates that have been added to the
+ * job. This function is to be called whenever child_job_drained_poll() would
+ * go from true to false to notify waiting drain requests.
+ */
+void block_job_wakeup_all_bdrv(BlockJob *job);
+
+/**
  * block_job_set_speed:
  * @job: The job to set the speed for.
  * @speed: The new value
diff --git a/include/qemu/job.h b/include/qemu/job.h
index 5cb0681834..b4a784d3cc 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -156,6 +156,9 @@ typedef struct Job {
     /** Notifiers called when the job transitions to READY */
     NotifierList on_ready;
 
+    /** Notifiers called when the job coroutine yields or terminates */
+    NotifierList on_idle;
+
     /** Element of the list of jobs */
     QLIST_ENTRY(Job) job_list;
 
diff --git a/blockjob.c b/blockjob.c
index be5903aa96..8d27e8e1ea 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -221,6 +221,22 @@ int block_job_add_bdrv(BlockJob *job, const char *name, BlockDriverState *bs,
     return 0;
 }
 
+void block_job_wakeup_all_bdrv(BlockJob *job)
+{
+    GSList *l;
+
+    for (l = job->nodes; l; l = l->next) {
+        BdrvChild *c = l->data;
+        bdrv_wakeup(c->bs);
+    }
+}
+
+static void block_job_on_idle(Notifier *n, void *opaque)
+{
+    BlockJob *job = opaque;
+    block_job_wakeup_all_bdrv(job);
+}
+
 bool block_job_is_internal(BlockJob *job)
 {
     return (job->job.id == NULL);
@@ -419,6 +435,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     job->finalize_completed_notifier.notify = block_job_event_completed;
     job->pending_notifier.notify = block_job_event_pending;
     job->ready_notifier.notify = block_job_event_ready;
+    job->idle_notifier.notify = block_job_on_idle;
 
     notifier_list_add(&job->job.on_finalize_cancelled,
                       &job->finalize_cancelled_notifier);
@@ -426,6 +443,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
                       &job->finalize_completed_notifier);
     notifier_list_add(&job->job.on_pending, &job->pending_notifier);
     notifier_list_add(&job->job.on_ready, &job->ready_notifier);
+    notifier_list_add(&job->job.on_idle, &job->idle_notifier);
 
     error_setg(&job->blocker, "block device is in use by block job: %s",
                job_type_str(&job->job));
diff --git a/job.c b/job.c
index 5c4e84f007..48a767c102 100644
--- a/job.c
+++ b/job.c
@@ -402,6 +402,11 @@ static void job_event_ready(Job *job)
     notifier_list_notify(&job->on_ready, job);
 }
 
+static void job_event_idle(Job *job)
+{
+    notifier_list_notify(&job->on_idle, job);
+}
+
 void job_enter_cond(Job *job, bool(*fn)(Job *job))
 {
     if (!job_started(job)) {
@@ -447,6 +452,7 @@ static void coroutine_fn job_do_yield(Job *job, uint64_t ns)
         timer_mod(&job->sleep_timer, ns);
     }
     job->busy = false;
+    job_event_idle(job);
     job_unlock();
     qemu_coroutine_yield();
 
@@ -865,6 +871,7 @@ static void coroutine_fn job_co_entry(void *opaque)
     assert(job && job->driver && job->driver->run);
     job_pause_point(job);
     job->ret = job->driver->run(job, &job->err);
+    job_event_idle(job);
     job->deferred_to_main_loop = true;
     aio_bh_schedule_oneshot(qemu_get_aio_context(), job_exit, job);
 }
-- 
2.13.6
