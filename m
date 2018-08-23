Received: from eggs.gnu.org ([2001:4830:134:3::10]:55712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fsxn6-0001kQ-JN
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 18:09:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fsxn2-0001zk-Ct
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 18:09:20 -0400
From: John Snow <jsnow@redhat.com>
Date: Thu, 23 Aug 2018 18:08:56 -0400
Message-Id: <20180823220856.10094-10-jsnow@redhat.com>
In-Reply-To: <20180823220856.10094-1-jsnow@redhat.com>
References: <20180823220856.10094-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 9/9] jobs: remove job_defer_to_main_loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, jtc@redhat.com, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

Now that the job infrastructure is handling the job_completed call for
all implemented jobs, we can remove the interface that allowed jobs to
schedule their own completion.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 include/qemu/job.h | 17 -----------------
 job.c              | 40 ++--------------------------------------
 2 files changed, 2 insertions(+), 55 deletions(-)

diff --git a/include/qemu/job.h b/include/qemu/job.h
index 2990f28edc..858cc2b37a 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -560,23 +560,6 @@ void job_finalize(Job *job, Error **errp);
  */
 void job_dismiss(Job **job, Error **errp);
 
-typedef void JobDeferToMainLoopFn(Job *job, void *opaque);
-
-/**
- * @job: The job
- * @fn: The function to run in the main loop
- * @opaque: The opaque value that is passed to @fn
- *
- * This function must be called by the main job coroutine just before it
- * returns.  @fn is executed in the main loop with the job AioContext acquired.
- *
- * Block jobs must call bdrv_unref(), bdrv_close(), and anything that uses
- * bdrv_drain_all() in the main loop.
- *
- * The @job AioContext is held while @fn executes.
- */
-void job_defer_to_main_loop(Job *job, JobDeferToMainLoopFn *fn, void *opaque);
-
 /**
  * Synchronously finishes the given @job. If @finish is given, it is called to
  * trigger completion or cancellation of the job.
diff --git a/job.c b/job.c
index 213042b762..01dd97fee3 100644
--- a/job.c
+++ b/job.c
@@ -561,12 +561,8 @@ static void coroutine_fn job_co_entry(void *opaque)
     assert(job && job->driver && job->driver->run);
     job_pause_point(job);
     job->ret = job->driver->run(job, &job->err);
-    if (!job->deferred_to_main_loop) {
-        job->deferred_to_main_loop = true;
-        aio_bh_schedule_oneshot(qemu_get_aio_context(),
-                                job_exit,
-                                job);
-    }
+    job->deferred_to_main_loop = true;
+    aio_bh_schedule_oneshot(qemu_get_aio_context(), job_exit, job);
 }
 
 
@@ -969,38 +965,6 @@ void job_complete(Job *job, Error **errp)
     job->driver->complete(job, errp);
 }
 
-
-typedef struct {
-    Job *job;
-    JobDeferToMainLoopFn *fn;
-    void *opaque;
-} JobDeferToMainLoopData;
-
-static void job_defer_to_main_loop_bh(void *opaque)
-{
-    JobDeferToMainLoopData *data = opaque;
-    Job *job = data->job;
-    AioContext *aio_context = job->aio_context;
-
-    aio_context_acquire(aio_context);
-    data->fn(data->job, data->opaque);
-    aio_context_release(aio_context);
-
-    g_free(data);
-}
-
-void job_defer_to_main_loop(Job *job, JobDeferToMainLoopFn *fn, void *opaque)
-{
-    JobDeferToMainLoopData *data = g_malloc(sizeof(*data));
-    data->job = job;
-    data->fn = fn;
-    data->opaque = opaque;
-    job->deferred_to_main_loop = true;
-
-    aio_bh_schedule_oneshot(qemu_get_aio_context(),
-                            job_defer_to_main_loop_bh, data);
-}
-
 int job_finish_sync(Job *job, void (*finish)(Job *, Error **errp), Error **errp)
 {
     Error *local_err = NULL;
-- 
2.14.4
