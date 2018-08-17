Received: from eggs.gnu.org ([2001:4830:134:3::10]:36602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fqk8z-0001Dr-Qi
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 15:10:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fqk3n-0006qB-PT
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 15:05:27 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 17 Aug 2018 15:04:53 -0400
Message-Id: <20180817190457.8292-4-jsnow@redhat.com>
In-Reply-To: <20180817190457.8292-1-jsnow@redhat.com>
References: <20180817190457.8292-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 3/7] jobs: add exit shim
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

All jobs do the same thing when they leave their running loop:
- Store the return code in a structure
- wait to receive this structure in the main thread
- signal job completion via job_completed

Few jobs do anything beyond exactly this. Consolidate this exit
logic for a net reduction in SLOC.

More seriously, when we utilize job_defer_to_main_loop_bh to call
a function that calls job_completed, job_finalize_single will run
in a context where it has recursively taken the aio_context lock,
which can cause hangs if it puts down a reference that causes a flush.

You can observe this in practice by looking at mirror_exit's careful
placement of job_completed and bdrv_unref calls.

If we centralize job exiting, we can signal job completion from outside
of the aio_context, which should allow for job cleanup code to run with
only one lock, which makes cleanup callbacks less tricky to write.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 include/qemu/job.h |  7 +++++++
 job.c              | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/qemu/job.h b/include/qemu/job.h
index 5c92c53ef0..6f5b13751a 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -204,6 +204,13 @@ struct JobDriver {
      */
     void (*drain)(Job *job);
 
+    /**
+     * If the callback is not NULL, exit will be invoked from the main thread
+     * when the job's coroutine has finished, but before transactional
+     * convergence; before @prepare or @abort.
+     */
+    void (*exit)(Job *job);
+
     /**
      * If the callback is not NULL, prepare will be invoked when all the jobs
      * belonging to the same transaction complete; or upon this job's completion
diff --git a/job.c b/job.c
index c9de1af556..fae8e6047c 100644
--- a/job.c
+++ b/job.c
@@ -535,6 +535,19 @@ void job_drain(Job *job)
     }
 }
 
+static void job_exit(void *opaque)
+{
+    Job *job = (Job *)opaque;
+    AioContext *aio_context = job->aio_context;
+
+    if (job->driver->exit) {
+        aio_context_acquire(aio_context);
+        job->driver->exit(job);
+        aio_context_release(aio_context);
+    }
+    job_completed(job, job->ret);
+}
+
 /**
  * All jobs must allow a pause point before entering their job proper. This
  * ensures that jobs can be paused prior to being started, then resumed later.
@@ -546,6 +559,12 @@ static void coroutine_fn job_co_entry(void *opaque)
     assert(job && job->driver && job->driver->run);
     job_pause_point(job);
     job->ret = job->driver->run(job, &job->err);
+    if (!job->deferred_to_main_loop) {
+        job->deferred_to_main_loop = true;
+        aio_bh_schedule_oneshot(qemu_get_aio_context(),
+                                job_exit,
+                                job);
+    }
 }
 
 
-- 
2.14.4
