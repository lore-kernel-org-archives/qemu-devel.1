Received: from eggs.gnu.org ([2001:4830:134:3::10]:53467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fyJQg-0006M0-Qk
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 12:16:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fyJQb-0004M3-3p
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 12:16:16 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Sep 2018 18:15:18 +0200
Message-Id: <20180907161520.26349-13-kwolf@redhat.com>
In-Reply-To: <20180907161520.26349-1-kwolf@redhat.com>
References: <20180907161520.26349-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 12/14] blockjob: Lie better in
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
Cc: kwolf@redhat.com, mreitz@redhat.com, famz@redhat.com, pbonzini@redhat.com, slp@redhat.com, qemu-devel@nongnu.org

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
 include/qemu/job.h | 3 +++
 blockjob.c         | 2 +-
 job.c              | 8 ++++++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/qemu/job.h b/include/qemu/job.h
index 8ac48dbd28..5a49d6f9a5 100644
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
index 8480eda188..d05795843b 100644
--- a/job.c
+++ b/job.c
@@ -978,6 +978,13 @@ static void job_defer_to_main_loop_bh(void *opaque)
     AioContext *aio_context = job->aio_context;
 
     aio_context_acquire(aio_context);
+
+    /* This is a lie, we're not quiescent, but still doing the completion
+     * callbacks. However, completion callbacks tend to involve operations that
+     * drain block nodes, and if .drained_poll still returned true, we would
+     * deadlock. */
+    job->busy = false;
+
     data->fn(data->job, data->opaque);
     aio_context_release(aio_context);
 
@@ -991,6 +998,7 @@ void job_defer_to_main_loop(Job *job, JobDeferToMainLoopFn *fn, void *opaque)
     data->fn = fn;
     data->opaque = opaque;
     job->deferred_to_main_loop = true;
+    job->busy = true;
 
     aio_bh_schedule_oneshot(qemu_get_aio_context(),
                             job_defer_to_main_loop_bh, data);
-- 
2.13.6
