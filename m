Received: from eggs.gnu.org ([2001:4830:134:3::10]:40183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ePHsv-0001ZB-Io
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 20:00:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ePHsu-00035j-CX
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 20:00:25 -0500
From: John Snow <jsnow@redhat.com>
Date: Wed, 13 Dec 2017 19:59:50 -0500
Message-Id: <20171214005953.8898-5-jsnow@redhat.com>
In-Reply-To: <20171214005953.8898-1-jsnow@redhat.com>
References: <20171214005953.8898-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 4/7] blockjob: allow block_job_throttle to take
 delay_ns
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
index 60b52cfb19..81450e6ac4 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -610,7 +610,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
             int bytes = MIN(s->bdev_length - offset,
                             QEMU_ALIGN_DOWN(INT_MAX, s->granularity));
 
-            block_job_throttle(&s->common);
+            block_job_throttle(&s->common, 0);
 
             if (block_job_is_cancelled(&s->common)) {
                 s->initial_zeroing_ongoing = false;
@@ -638,7 +638,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
         int bytes = MIN(s->bdev_length - offset,
                         QEMU_ALIGN_DOWN(INT_MAX, s->granularity));
 
-        block_job_throttle(&s->common);
+        block_job_throttle(&s->common, 0);
 
         if (block_job_is_cancelled(&s->common)) {
             return 0;
diff --git a/blockjob.c b/blockjob.c
index 8d0c89a813..b0868c3ed5 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -882,12 +882,11 @@ void block_job_yield(BlockJob *job)
     block_job_pause_point(job);
 }
 
-void block_job_throttle(BlockJob *job)
+void block_job_throttle(BlockJob *job, int64_t delay_ns)
 {
-    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
-
-    if (now - job->last_yield_ns > SLICE_TIME) {
-        block_job_sleep_ns(job, 0);
+    if (delay_ns || (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - \
+                     job->last_yield_ns > SLICE_TIME)) {
+        block_job_sleep_ns(job, delay_ns);
     } else {
         block_job_pause_point(job);
     }
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index 1a771b1e2e..8faec3f5e0 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -160,11 +160,15 @@ void block_job_yield(BlockJob *job);
 /**
  * block_job_throttle:
  * @job: The job that calls the function.
+ * @delay_ns: The amount of time to sleep for
  *
- * Yield if it has been SLICE_TIME nanoseconds since the last yield.
- * Otherwise, check if we need to pause (and update the yield counter).
+ * Sleep for delay_ns nanoseconds.
+ *
+ * If delay_ns is 0, yield if it has been SLICE_TIME
+ * nanoseconds since the last yield. Otherwise, check
+ * if we need to yield for a pause event.
  */
-void block_job_throttle(BlockJob *job);
+void block_job_throttle(BlockJob *job, int64_t delay_ns);
 
 /**
  * block_job_pause_all:
-- 
2.14.3
