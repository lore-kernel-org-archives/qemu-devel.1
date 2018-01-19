Received: from eggs.gnu.org ([2001:4830:134:3::10]:46504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ecdku-0001qM-MT
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 15:59:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ecdkt-000636-NS
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 15:59:20 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 19 Jan 2018 15:58:42 -0500
Message-Id: <20180119205847.7141-9-jsnow@redhat.com>
In-Reply-To: <20180119205847.7141-1-jsnow@redhat.com>
References: <20180119205847.7141-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 08/13] allow block_job_relax to return
 -ECANCELED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com, John Snow <jsnow@redhat.com>

This is just an optimization for callers who are likely going to
want to check quite close to this call if the job was canceled or
not anyway.

Along the same lines, add the return to block_job_pause_point and
block_job_sleep_ns, so we don't have to re-check it quite so
excessively.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockjob.c                   | 28 +++++++++++++++++-----------
 include/block/blockjob_int.h |  8 +++++---
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 51c0eb5d9e..b5a0cda412 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -793,15 +793,15 @@ static void block_job_do_yield(BlockJob *job, uint64_t ns)
     assert(job->busy);
 }
 
-void coroutine_fn block_job_pause_point(BlockJob *job)
+int coroutine_fn block_job_pause_point(BlockJob *job)
 {
     assert(job && block_job_started(job));
 
-    if (!block_job_should_pause(job)) {
-        return;
-    }
     if (block_job_is_cancelled(job)) {
-        return;
+        return -ECANCELED;
+    }
+    if (!block_job_should_pause(job)) {
+        return 0;
     }
 
     if (job->driver->pause) {
@@ -817,6 +817,8 @@ void coroutine_fn block_job_pause_point(BlockJob *job)
     if (job->driver->resume) {
         job->driver->resume(job);
     }
+
+    return 0;
 }
 
 void block_job_resume_all(void)
@@ -874,20 +876,20 @@ bool block_job_is_cancelled(BlockJob *job)
     return job->cancelled;
 }
 
-void block_job_sleep_ns(BlockJob *job, int64_t ns)
+int block_job_sleep_ns(BlockJob *job, int64_t ns)
 {
     assert(job->busy);
 
     /* Check cancellation *before* setting busy = false, too!  */
     if (block_job_is_cancelled(job)) {
-        return;
+        return -ECANCELED;
     }
 
     if (!block_job_should_pause(job)) {
         block_job_do_yield(job, qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + ns);
     }
 
-    block_job_pause_point(job);
+    return block_job_pause_point(job);
 }
 
 void block_job_yield(BlockJob *job)
@@ -906,13 +908,17 @@ void block_job_yield(BlockJob *job)
     block_job_pause_point(job);
 }
 
-void block_job_relax(BlockJob *job, int64_t delay_ns)
+int block_job_relax(BlockJob *job, int64_t delay_ns)
 {
+    if (block_job_is_cancelled(job)) {
+        return -ECANCELED;
+    }
+
     if (delay_ns || (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - \
                      job->last_enter_ns > SLICE_TIME)) {
-        block_job_sleep_ns(job, delay_ns);
+        return block_job_sleep_ns(job, delay_ns);
     } else {
-        block_job_pause_point(job);
+        return block_job_pause_point(job);
     }
 }
 
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index 5f1520fab7..1ceb47e1e6 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -147,7 +147,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
  * %QEMU_CLOCK_REALTIME nanoseconds.  Canceling the job will immediately
  * interrupt the wait.
  */
-void block_job_sleep_ns(BlockJob *job, int64_t ns);
+int block_job_sleep_ns(BlockJob *job, int64_t ns);
 
 /**
  * block_job_yield:
@@ -167,8 +167,10 @@ void block_job_yield(BlockJob *job);
  * If delay_ns is 0, yield if it has been SLICE_TIME
  * nanoseconds since the last yield. Otherwise, check
  * if we need to yield for a pause event.
+ *
+ * returns ECANCELED if the job has been canceled.
  */
-void block_job_relax(BlockJob *job, int64_t delay_ns);
+int block_job_relax(BlockJob *job, int64_t delay_ns);
 
 /**
  * block_job_pause_all:
@@ -217,7 +219,7 @@ bool block_job_is_cancelled(BlockJob *job);
  * Pause now if block_job_pause() has been called.  Block jobs that perform
  * lots of I/O must call this between requests so that the job can be paused.
  */
-void coroutine_fn block_job_pause_point(BlockJob *job);
+int coroutine_fn block_job_pause_point(BlockJob *job);
 
 /**
  * block_job_enter:
-- 
2.14.3
