Received: from eggs.gnu.org ([2001:4830:134:3::10]:46726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0R79-0002EL-Mm
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:53:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0R78-0001pu-Ss
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:52:55 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 13 Sep 2018 14:52:06 +0200
Message-Id: <20180913125217.23173-7-kwolf@redhat.com>
In-Reply-To: <20180913125217.23173-1-kwolf@redhat.com>
References: <20180913125217.23173-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 06/17] job: Use AIO_WAIT_WHILE() in
 job_finish_sync()
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

job_finish_sync() needs to release the AioContext lock of the job before
calling aio_poll(). Otherwise, callbacks called by aio_poll() would
possibly take the lock a second time and run into a deadlock with a
nested AIO_WAIT_WHILE() call.

Also, job_drain() without aio_poll() isn't necessarily enough to make
progress on a job, it could depend on bottom halves to be executed.

Combine both open-coded while loops into a single AIO_WAIT_WHILE() call
that solves both of these problems.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
---
 job.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/job.c b/job.c
index 48a767c102..fa74558ba0 100644
--- a/job.c
+++ b/job.c
@@ -29,6 +29,7 @@
 #include "qemu/job.h"
 #include "qemu/id.h"
 #include "qemu/main-loop.h"
+#include "block/aio-wait.h"
 #include "trace-root.h"
 #include "qapi/qapi-events-job.h"
 
@@ -962,6 +963,7 @@ void job_complete(Job *job, Error **errp)
 int job_finish_sync(Job *job, void (*finish)(Job *, Error **errp), Error **errp)
 {
     Error *local_err = NULL;
+    AioWait dummy_wait = {};
     int ret;
 
     job_ref(job);
@@ -974,14 +976,10 @@ int job_finish_sync(Job *job, void (*finish)(Job *, Error **errp), Error **errp)
         job_unref(job);
         return -EBUSY;
     }
-    /* job_drain calls job_enter, and it should be enough to induce progress
-     * until the job completes or moves to the main thread. */
-    while (!job->deferred_to_main_loop && !job_is_completed(job)) {
-        job_drain(job);
-    }
-    while (!job_is_completed(job)) {
-        aio_poll(qemu_get_aio_context(), true);
-    }
+
+    AIO_WAIT_WHILE(&dummy_wait, job->aio_context,
+                   (job_drain(job), !job_is_completed(job)));
+
     ret = (job_is_cancelled(job) && job->ret == 0) ? -ECANCELED : job->ret;
     job_unref(job);
     return ret;
-- 
2.13.6
