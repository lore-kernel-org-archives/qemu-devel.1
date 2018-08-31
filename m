Received: from eggs.gnu.org ([2001:4830:134:3::10]:50667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fvkQL-0001A5-Al
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 10:29:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fvkMO-0000si-Hb
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 10:25:17 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 31 Aug 2018 16:24:46 +0200
Message-Id: <20180831142446.22264-12-mreitz@redhat.com>
In-Reply-To: <20180831142446.22264-1-mreitz@redhat.com>
References: <20180831142446.22264-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 11/11] jobs: remove job_defer_to_main_loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>

From: John Snow <jsnow@redhat.com>

Now that the job infrastructure is handling the job_completed call for
all implemented jobs, we can remove the interface that allowed jobs to
schedule their own completion.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20180830015734.19765-10-jsnow@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/qemu/job.h | 17 -----------------
 job.c              | 40 ++--------------------------------------
 2 files changed, 2 insertions(+), 55 deletions(-)

diff --git a/include/qemu/job.h b/include/qemu/job.h
index 23395c17fa..e0cff702b7 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -568,23 +568,6 @@ void job_finalize(Job *job, Error **errp);
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
index 37d828f964..b960e72710 100644
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
2.17.1
