Received: from eggs.gnu.org ([2001:4830:134:3::10]:46359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ecdkg-0001Zp-20
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 15:59:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ecdkf-0005x6-DU
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 15:59:06 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 19 Jan 2018 15:58:38 -0500
Message-Id: <20180119205847.7141-5-jsnow@redhat.com>
In-Reply-To: <20180119205847.7141-1-jsnow@redhat.com>
References: <20180119205847.7141-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 04/13] blockjob: allow block_job_throttle to
 take delay_ns
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

Instead of only sleeping for 0ms when we've hit a timeout, optionally
take a longer more explicit delay_ns that always forces the sleep.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/mirror.c               |  4 ++--
 blockjob.c                   |  9 ++++-----
 include/block/blockjob_int.h | 10 +++++++---
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 36c681c7a1..3c73caed5e 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -610,7 +610,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
             int bytes = MIN(s->bdev_length - offset,
                             QEMU_ALIGN_DOWN(INT_MAX, s->granularity));
 
-            block_job_relax(&s->common);
+            block_job_relax(&s->common, 0);
 
             if (block_job_is_cancelled(&s->common)) {
                 s->initial_zeroing_ongoing = false;
@@ -638,7 +638,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
         int bytes = MIN(s->bdev_length - offset,
                         QEMU_ALIGN_DOWN(INT_MAX, s->granularity));
 
-        block_job_relax(&s->common);
+        block_job_relax(&s->common, 0);
 
         if (block_job_is_cancelled(&s->common)) {
             return 0;
diff --git a/blockjob.c b/blockjob.c
index 6f2e709b51..51c0eb5d9e 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -906,12 +906,11 @@ void block_job_yield(BlockJob *job)
     block_job_pause_point(job);
 }
 
-void block_job_relax(BlockJob *job)
+void block_job_relax(BlockJob *job, int64_t delay_ns)
 {
-    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
-
-    if (now - job->last_enter_ns > SLICE_TIME) {
-        block_job_sleep_ns(job, 0);
+    if (delay_ns || (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - \
+                     job->last_enter_ns > SLICE_TIME)) {
+        block_job_sleep_ns(job, delay_ns);
     } else {
         block_job_pause_point(job);
     }
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index 553784d86f..5f1520fab7 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -160,11 +160,15 @@ void block_job_yield(BlockJob *job);
 /**
  * block_job_relax:
  * @job: The job that calls the function.
+ * @delay_ns: The amount of time to sleep for
  *
- * Yield if it has been SLICE_TIME nanoseconds since the last yield.
- * Otherwise, check if we need to pause, and yield if so.
+ * Sleep for delay_ns nanoseconds.
+ *
+ * If delay_ns is 0, yield if it has been SLICE_TIME
+ * nanoseconds since the last yield. Otherwise, check
+ * if we need to yield for a pause event.
  */
-void block_job_relax(BlockJob *job);
+void block_job_relax(BlockJob *job, int64_t delay_ns);
 
 /**
  * block_job_pause_all:
-- 
2.14.3
