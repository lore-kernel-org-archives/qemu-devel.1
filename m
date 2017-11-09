Received: from eggs.gnu.org ([2001:4830:134:3::10]:37831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eCfy4-00056z-HN
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 01:05:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eCfy3-0003DM-DH
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 01:05:36 -0500
Date: Thu, 9 Nov 2017 14:05:26 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171109060526.GA30991@lemon>
References: <dd350838-9132-e787-10b1-4cb200076ec9@virtuozzo.com>
	<w51inekzv59.fsf@maestria.local.igalia.com>
	<84b1b069-642e-2b33-7723-70edce3aea43@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84b1b069-642e-2b33-7723-70edce3aea43@virtuozzo.com>
Subject: Re: [Qemu-devel] [Qemu-block] segfault in parallel blockjobs
 (iotest 30)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>
Cc: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On Wed, 11/08 18:50, Anton Nefedov wrote:
> 
> 
> On 8/11/2017 5:45 PM, Alberto Garcia wrote:
> > On Tue 07 Nov 2017 05:19:41 PM CET, Anton Nefedov wrote:
> > > BlockBackend gets deleted by another job's stream_complete(), deferred
> > > to the main loop, so the fact that the job is put to sleep by
> > > bdrv_drain_all_begin() doesn't really stop it from execution.
> > 
> > I was debugging this a bit, and the block_job_defer_to_main_loop() call
> > happens _after_ all jobs have been paused, so I think that when the BDS
> > is drained then stream_run() finishes the last iteration without
> > checking if it's paused.
> > 
> > Without your patch (i.e. with a smaller STREAM_BUFFER_SIZE) then I
> > assume that the function would have to continue looping and
> > block_job_sleep_ns() would make the job coroutine yield, effectively
> > pausing the job and preventing the crash.
> > 
> > I can fix the crash by adding block_job_pause_point(&s->common) at the
> > end of stream_run() (where the 'out' label is).
> > 
> > I'm thinking that perhaps we should add the pause point directly to
> > block_job_defer_to_main_loop(), to prevent any block job from running
> > the exit function when it's paused.
> > 
> 
> Is it possible that the exit function is already deferred when the jobs
> are being paused? (even though it's at least less likely to happen)
> 
> Then should we flush the bottom halves somehow in addition to putting
> the jobs to sleep? And also then it all probably has to happen before
> bdrv_reopen_queue()

Or we can stash away the BH temporarily during pause period:

---

diff --git a/blockjob.c b/blockjob.c
index 3a0c49137e..7058ff7ae1 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -127,6 +127,9 @@ void block_job_txn_add_job(BlockJobTxn *txn, BlockJob *job)
 static void block_job_pause(BlockJob *job)
 {
     job->pause_count++;
+    if (job->defer_to_main_loop_bh) {
+        qemu_bh_cancel(job->defer_to_main_loop_bh);
+    }
 }
 
 static void block_job_resume(BlockJob *job)
@@ -136,6 +139,9 @@ static void block_job_resume(BlockJob *job)
     if (job->pause_count) {
         return;
     }
+    if (job->defer_to_main_loop_bh) {
+        qemu_bh_schedule(job->defer_to_main_loop_bh);
+    }
     block_job_enter(job);
 }
 
@@ -900,6 +906,9 @@ static void block_job_defer_to_main_loop_bh(void *opaque)
     /* Prevent race with block_job_defer_to_main_loop() */
     aio_context_acquire(data->aio_context);
 
+    qemu_bh_delete(data->job->defer_to_main_loop_bh);
+    data->job->defer_to_main_loop_bh = NULL;
+
     /* Fetch BDS AioContext again, in case it has changed */
     aio_context = blk_get_aio_context(data->job->blk);
     if (aio_context != data->aio_context) {
@@ -927,7 +936,9 @@ void block_job_defer_to_main_loop(BlockJob *job,
     data->fn = fn;
     data->opaque = opaque;
     job->deferred_to_main_loop = true;
+    assert(!job->defer_to_main_loop_bh);
+    job->defer_to_main_loop_bh = aio_bh_new(qemu_get_aio_context(),
+                                 block_job_defer_to_main_loop_bh, data);
 
-    aio_bh_schedule_oneshot(qemu_get_aio_context(),
-                            block_job_defer_to_main_loop_bh, data);
+    qemu_bh_schedule(job->defer_to_main_loop_bh);
 }
diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 67c0968fa5..28d29b3be6 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -97,6 +97,11 @@ typedef struct BlockJob {
      */
     bool deferred_to_main_loop;
 
+    /**
+     * The main loop BH for "defer to main loop" operation.
+     */
+    QEMUBH *defer_to_main_loop_bh;
+
     /** Element of the list of block jobs */
     QLIST_ENTRY(BlockJob) job_list;
 
