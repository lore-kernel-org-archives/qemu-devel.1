Received: from eggs.gnu.org ([2001:4830:134:3::10]:58630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fqi9M-0002i1-Cw
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:03:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fqi9L-0002CV-3a
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:03:00 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 17 Aug 2018 19:02:44 +0200
Message-Id: <20180817170246.14641-4-kwolf@redhat.com>
In-Reply-To: <20180817170246.14641-1-kwolf@redhat.com>
References: <20180817170246.14641-1-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 3/5] job: Drop AioContext lock around
 aio_poll()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org

Simimlar to AIO_WAIT_WHILE(), job_finish_sync() needs to release the
AioContext lock of the job before calling aio_poll(). Otherwise,
callbacks called by aio_poll() would possibly take the lock a second
time and run into a deadlock with a nested AIO_WAIT_WHILE() call.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 job.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/job.c b/job.c
index a746bfe70b..6acf55bceb 100644
--- a/job.c
+++ b/job.c
@@ -1016,7 +1016,10 @@ int job_finish_sync(Job *job, void (*finish)(Job *, Error **errp), Error **errp)
         job_drain(job);
     }
     while (!job_is_completed(job)) {
+        AioContext *aio_context = job->aio_context;
+        aio_context_release(aio_context);
         aio_poll(qemu_get_aio_context(), true);
+        aio_context_acquire(aio_context);
     }
     ret = (job_is_cancelled(job) && job->ret == 0) ? -ECANCELED : job->ret;
     job_unref(job);
-- 
2.13.6
