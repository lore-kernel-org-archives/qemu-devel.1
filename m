Received: from eggs.gnu.org ([2001:4830:134:3::10]:43896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liliang.opensource@gmail.com>) id 1eqUeg-0003qo-Og
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 21:06:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liliang.opensource@gmail.com>) id 1eqUef-0000Ie-Bf
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 21:06:10 -0500
From: Liang Li <liliang.opensource@gmail.com>
Date: Tue, 27 Feb 2018 10:05:54 +0800
Message-ID: <20180227020550.GA5602@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH v2 resend] block/mirror: change the semantic of
 'force' of block-job-cancel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Huaitong Han <huanhuaitong@didichuxing.com>, Liang Li <liliangleo@didichuxing.com>

When doing drive mirror to a low speed shared storage, if there was heavy
BLK IO write workload in VM after the 'ready' event, drive mirror block job
can't be canceled immediately, it would keep running until the heavy BLK IO
workload stopped in the VM.

Libvirt depends on the current block-job-cancel semantics, which is that
when used without a flag after the 'ready' event, the command blocks
until data is in sync.  However, these semantics are awkward in other
situations, for example, people may use drive mirror for realtime
backups while still wanting to use block live migration.  Libvirt cannot
start a block live migration while another drive mirror is in progress,
but the user would rather abandon the backup attempt as broken and
proceed with the live migration than be stuck waiting for the current
drive mirror backup to finish.

The drive-mirror command already includes a 'force' flag, which libvirt
does not use, although it documented the flag as only being useful to
quit a job which is paused.  However, since quitting a paused job has
the same effect as abandoning a backup in a non-paused job (namely, the
destination file is not in sync, and the command completes immediately),
we can just improve the documentation to make the force flag obviously
useful.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Jeff Cody <jcody@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: John Snow <jsnow@redhat.com>
Reported-by: Huaitong Han <huanhuaitong@didichuxing.com>
Signed-off-by: Huaitong Han <huanhuaitong@didichuxing.com>
Signed-off-by: Liang Li <liliangleo@didichuxing.com>
---
 block/mirror.c            | 10 ++++------
 blockdev.c                |  4 ++--
 blockjob.c                | 12 +++++++-----
 hmp-commands.hx           |  3 ++-
 include/block/blockjob.h  |  9 ++++++++-
 qapi/block-core.json      |  5 +++--
 tests/test-blockjob-txn.c |  8 ++++----
 7 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index c9badc1..9190b1c 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -869,11 +869,8 @@ static void coroutine_fn mirror_run(void *opaque)
 
         ret = 0;
         trace_mirror_before_sleep(s, cnt, s->synced, delay_ns);
-        if (!s->synced) {
-            block_job_sleep_ns(&s->common, delay_ns);
-            if (block_job_is_cancelled(&s->common)) {
-                break;
-            }
+        if (block_job_is_cancelled(&s->common) && s->common.force) {
+            break;
         } else if (!should_complete) {
             delay_ns = (s->in_flight == 0 && cnt == 0 ? SLICE_TIME : 0);
             block_job_sleep_ns(&s->common, delay_ns);
@@ -887,7 +884,8 @@ immediate_exit:
          * or it was cancelled prematurely so that we do not guarantee that
          * the target is a copy of the source.
          */
-        assert(ret < 0 || (!s->synced && block_job_is_cancelled(&s->common)));
+        assert(ret < 0 || ((s->common.force || !s->synced) &&
+               block_job_is_cancelled(&s->common)));
         assert(need_drain);
         mirror_wait_for_all_io(s);
     }
diff --git a/blockdev.c b/blockdev.c
index 8e977ee..039f156 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -145,7 +145,7 @@ void blockdev_mark_auto_del(BlockBackend *blk)
         aio_context_acquire(aio_context);
 
         if (bs->job) {
-            block_job_cancel(bs->job);
+            block_job_cancel(bs->job, false);
         }
 
         aio_context_release(aio_context);
@@ -3802,7 +3802,7 @@ void qmp_block_job_cancel(const char *device,
     }
 
     trace_qmp_block_job_cancel(job);
-    block_job_cancel(job);
+    block_job_cancel(job, force);
 out:
     aio_context_release(aio_context);
 }
diff --git a/blockjob.c b/blockjob.c
index f5cea84..9b0b1a4 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -365,7 +365,7 @@ static void block_job_completed_single(BlockJob *job)
     block_job_unref(job);
 }
 
-static void block_job_cancel_async(BlockJob *job)
+static void block_job_cancel_async(BlockJob *job, bool force)
 {
     if (job->iostatus != BLOCK_DEVICE_IO_STATUS_OK) {
         block_job_iostatus_reset(job);
@@ -376,6 +376,8 @@ static void block_job_cancel_async(BlockJob *job)
         job->pause_count--;
     }
     job->cancelled = true;
+    /* To prevent 'force == false' overriding a previous 'force == true' */
+    job->force |= force;
 }
 
 static int block_job_finish_sync(BlockJob *job,
@@ -437,7 +439,7 @@ static void block_job_completed_txn_abort(BlockJob *job)
      * on the caller, so leave it. */
     QLIST_FOREACH(other_job, &txn->jobs, txn_list) {
         if (other_job != job) {
-            block_job_cancel_async(other_job);
+            block_job_cancel_async(other_job, false);
         }
     }
     while (!QLIST_EMPTY(&txn->jobs)) {
@@ -542,10 +544,10 @@ void block_job_user_resume(BlockJob *job)
     }
 }
 
-void block_job_cancel(BlockJob *job)
+void block_job_cancel(BlockJob *job, bool force)
 {
     if (block_job_started(job)) {
-        block_job_cancel_async(job);
+        block_job_cancel_async(job, force);
         block_job_enter(job);
     } else {
         block_job_completed(job, -ECANCELED);
@@ -557,7 +559,7 @@ void block_job_cancel(BlockJob *job)
  * function pointer casts there. */
 static void block_job_cancel_err(BlockJob *job, Error **errp)
 {
-    block_job_cancel(job);
+    block_job_cancel(job, false);
 }
 
 int block_job_cancel_sync(BlockJob *job)
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 15620c9..603941f 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -106,7 +106,8 @@ ETEXI
         .args_type  = "force:-f,device:B",
         .params     = "[-f] device",
         .help       = "stop an active background block operation (use -f"
-                      "\n\t\t\t if the operation is currently paused)",
+                      "\n\t\t\t if you want to abort the operation immediately"
+                      "\n\t\t\t instead of keep running until data is in sync)",
         .cmd        = hmp_block_job_cancel,
     },
 
diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 00403d9..f5a8ad1 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -63,6 +63,12 @@ typedef struct BlockJob {
     bool cancelled;
 
     /**
+     * Set to true if the job should abort immediately without waiting
+     * for data to be in sync.
+     */
+    bool force;
+
+    /**
      * Counter for pause request. If non-zero, the block job is either paused,
      * or if busy == true will pause itself as soon as possible.
      */
@@ -218,10 +224,11 @@ void block_job_start(BlockJob *job);
 /**
  * block_job_cancel:
  * @job: The job to be canceled.
+ * @force: Quit a job without waiting for data to be in sync.
  *
  * Asynchronously cancel the specified job.
  */
-void block_job_cancel(BlockJob *job);
+void block_job_cancel(BlockJob *job, bool force);
 
 /**
  * block_job_complete:
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 8225308..aeb0780 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2098,8 +2098,9 @@
 #          the name of the parameter), but since QEMU 2.7 it can have
 #          other values.
 #
-# @force: whether to allow cancellation of a paused job (default
-#         false).  Since 1.3.
+# @force: If true, and the job has already emitted the event BLOCK_JOB_READY,
+#         abandon the job immediately (even if it is paused) instead of waiting
+#         for the destination to complete its final synchronization (since 1.3)
 #
 # Returns: Nothing on success
 #          If no background operation is active on this device, DeviceNotActive
diff --git a/tests/test-blockjob-txn.c b/tests/test-blockjob-txn.c
index 3591c96..53daadb 100644
--- a/tests/test-blockjob-txn.c
+++ b/tests/test-blockjob-txn.c
@@ -125,7 +125,7 @@ static void test_single_job(int expected)
     block_job_start(job);
 
     if (expected == -ECANCELED) {
-        block_job_cancel(job);
+        block_job_cancel(job, false);
     }
 
     while (result == -EINPROGRESS) {
@@ -173,10 +173,10 @@ static void test_pair_jobs(int expected1, int expected2)
     block_job_txn_unref(txn);
 
     if (expected1 == -ECANCELED) {
-        block_job_cancel(job1);
+        block_job_cancel(job1, false);
     }
     if (expected2 == -ECANCELED) {
-        block_job_cancel(job2);
+        block_job_cancel(job2, false);
     }
 
     while (result1 == -EINPROGRESS || result2 == -EINPROGRESS) {
@@ -231,7 +231,7 @@ static void test_pair_jobs_fail_cancel_race(void)
     block_job_start(job1);
     block_job_start(job2);
 
-    block_job_cancel(job1);
+    block_job_cancel(job1, false);
 
     /* Now make job2 finish before the main loop kicks jobs.  This simulates
      * the race between a pending kick and another job completing.
-- 
1.8.3.1
