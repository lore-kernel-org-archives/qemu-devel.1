Received: from eggs.gnu.org ([2001:4830:134:3::10]:60242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eCk36-0001b9-TF
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 05:27:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eCk36-000529-1M
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 05:27:04 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu,  9 Nov 2017 10:26:52 +0000
Message-Id: <20171109102652.6360-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH] coroutine: simplify co_aio_sleep_ns() prototype
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

The AioContext pointer argument to co_aio_sleep_ns() is only used for
the sleep timer.  It does not affect where the caller coroutine is
resumed.

Due to changes to coroutine and AIO APIs it is now possible to drop the
AioContext pointer argument.  This is safe to do since no caller has
specific requirements for which AioContext the timer must run in.

This patch drops the AioContext pointer argument and renames the
function to simplify the API.

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Reported-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/qemu/coroutine.h    | 6 +-----
 block/null.c                | 3 +--
 block/sheepdog.c            | 3 +--
 blockjob.c                  | 2 +-
 util/qemu-coroutine-sleep.c | 4 ++--
 5 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index 9aff9a735e..ce2eb73670 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -261,12 +261,8 @@ void qemu_co_rwlock_unlock(CoRwlock *lock);
 
 /**
  * Yield the coroutine for a given duration
- *
- * Behaves similarly to co_sleep_ns(), but the sleeping coroutine will be
- * resumed when using aio_poll().
  */
-void coroutine_fn co_aio_sleep_ns(AioContext *ctx, QEMUClockType type,
-                                  int64_t ns);
+void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns);
 
 /**
  * Yield until a file descriptor becomes readable
diff --git a/block/null.c b/block/null.c
index dd9c13f9ba..0cdabaa440 100644
--- a/block/null.c
+++ b/block/null.c
@@ -110,8 +110,7 @@ static coroutine_fn int null_co_common(BlockDriverState *bs)
     BDRVNullState *s = bs->opaque;
 
     if (s->latency_ns) {
-        co_aio_sleep_ns(bdrv_get_aio_context(bs), QEMU_CLOCK_REALTIME,
-                        s->latency_ns);
+        qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, s->latency_ns);
     }
     return 0;
 }
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 696a71442a..a1edb992ff 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -776,8 +776,7 @@ static coroutine_fn void reconnect_to_sdog(void *opaque)
         if (s->fd < 0) {
             DPRINTF("Wait for connection to be established\n");
             error_report_err(local_err);
-            co_aio_sleep_ns(bdrv_get_aio_context(s->bs), QEMU_CLOCK_REALTIME,
-                            1000000000ULL);
+            qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 1000000000ULL);
         }
     };
 
diff --git a/blockjob.c b/blockjob.c
index 3a0c49137e..24d912161f 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -799,7 +799,7 @@ void block_job_sleep_ns(BlockJob *job, QEMUClockType type, int64_t ns)
 
     job->busy = false;
     if (!block_job_should_pause(job)) {
-        co_aio_sleep_ns(blk_get_aio_context(job->blk), type, ns);
+        qemu_co_sleep_ns(type, ns);
     }
     job->busy = true;
 
diff --git a/util/qemu-coroutine-sleep.c b/util/qemu-coroutine-sleep.c
index 9c5655041b..b345a55994 100644
--- a/util/qemu-coroutine-sleep.c
+++ b/util/qemu-coroutine-sleep.c
@@ -28,9 +28,9 @@ static void co_sleep_cb(void *opaque)
     aio_co_wake(sleep_cb->co);
 }
 
-void coroutine_fn co_aio_sleep_ns(AioContext *ctx, QEMUClockType type,
-                                  int64_t ns)
+void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns)
 {
+    AioContext *ctx = qemu_get_current_aio_context();
     CoSleepCB sleep_cb = {
         .co = qemu_coroutine_self(),
     };
-- 
2.13.6
