Received: from eggs.gnu.org ([2001:4830:134:3::10]:47093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0R7b-0002dT-6M
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:53:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0R7a-0002EU-3o
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:53:23 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 13 Sep 2018 14:52:13 +0200
Message-Id: <20180913125217.23173-14-kwolf@redhat.com>
In-Reply-To: <20180913125217.23173-1-kwolf@redhat.com>
References: <20180913125217.23173-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 13/17] blockjob: Lie better in
 child_job_drained_poll()
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

Block jobs claim in .drained_poll() that they are in a quiescent state
as soon as job->deferred_to_main_loop is true. This is obviously wrong,
they still have a completion BH to run. We only get away with this
because commit 91af091f923 added an unconditional aio_poll(false) to the
drain functions, but this is bypassing the regular drain mechanisms.

However, just removing this and telling that the job is still active
doesn't work either: The completion callbacks themselves call drain
functions (directly, or indirectly with bdrv_reopen), so they would
deadlock then.

As a better lie, tell that the job is active as long as the BH is
pending, but falsely call it quiescent from the point in the BH when the
completion callback is called. At this point, nested drain calls won't
deadlock because they ignore the job, and outer drains will wait for the
job to really reach a quiescent state because the callback is already
running.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/qemu/job.h |  3 +++
 blockjob.c         |  2 +-
 job.c              | 11 ++++++++++-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/qemu/job.h b/include/qemu/job.h
index 63c60ef1ba..9e7cd1e4a0 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -76,6 +76,9 @@ typedef struct Job {
      * Set to false by the job while the coroutine has yielded and may be
      * re-entered by job_enter(). There may still be I/O or event loop activity
      * pending. Accessed under block_job_mutex (in blockjob.c).
+     *
+     * When the job is deferred to the main loop, busy is true as long as the
+     * bottom half is still pending.
      */
     bool busy;
 
diff --git a/blockjob.c b/blockjob.c
index 8d27e8e1ea..617d86fe93 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -164,7 +164,7 @@ static bool child_job_drained_poll(BdrvChild *c)
     /* An inactive or completed job doesn't have any pending requests. Jobs
      * with !job->busy are either already paused or have a pause point after
      * being reentered, so no job driver code will run before they pause. */
-    if (!job->busy || job_is_completed(job) || job->deferred_to_main_loop) {
+    if (!job->busy || job_is_completed(job)) {
         return false;
     }
 
diff --git a/job.c b/job.c
index fa74558ba0..00a1cd128d 100644
--- a/job.c
+++ b/job.c
@@ -857,7 +857,16 @@ static void job_exit(void *opaque)
     AioContext *ctx = job->aio_context;
 
     aio_context_acquire(ctx);
+
+    /* This is a lie, we're not quiescent, but still doing the completion
+     * callbacks. However, completion callbacks tend to involve operations that
+     * drain block nodes, and if .drained_poll still returned true, we would
+     * deadlock. */
+    job->busy = false;
+    job_event_idle(job);
+
     job_completed(job);
+
     aio_context_release(ctx);
 }
 
@@ -872,8 +881,8 @@ static void coroutine_fn job_co_entry(void *opaque)
     assert(job && job->driver && job->driver->run);
     job_pause_point(job);
     job->ret = job->driver->run(job, &job->err);
-    job_event_idle(job);
     job->deferred_to_main_loop = true;
+    job->busy = true;
     aio_bh_schedule_oneshot(qemu_get_aio_context(), job_exit, job);
 }
 
-- 
2.13.6
