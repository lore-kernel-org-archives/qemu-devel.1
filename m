Received: from eggs.gnu.org ([2001:4830:134:3::10]:46314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ecdkd-0001X7-Pt
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 15:59:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ecdkd-0005vh-4l
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 15:59:03 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 19 Jan 2018 15:58:37 -0500
Message-Id: <20180119205847.7141-4-jsnow@redhat.com>
In-Reply-To: <20180119205847.7141-1-jsnow@redhat.com>
References: <20180119205847.7141-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 03/13] blockjob: create block_job_relax
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

This will replace mirror_throttle, for reuse in other jobs.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/mirror.c               | 15 ++-------------
 blockjob.c                   | 11 +++++++++++
 include/block/blockjob_int.h |  9 +++++++++
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 1fb5fc0cb8..36c681c7a1 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -590,17 +590,6 @@ static void mirror_exit(BlockJob *job, void *opaque)
     bdrv_unref(src);
 }
 
-static void mirror_throttle(MirrorBlockJob *s)
-{
-    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
-
-    if (now - s->common.last_enter_ns > SLICE_TIME) {
-        block_job_sleep_ns(&s->common, 0);
-    } else {
-        block_job_pause_point(&s->common);
-    }
-}
-
 static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
 {
     int64_t offset;
@@ -621,7 +610,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
             int bytes = MIN(s->bdev_length - offset,
                             QEMU_ALIGN_DOWN(INT_MAX, s->granularity));
 
-            mirror_throttle(s);
+            block_job_relax(&s->common);
 
             if (block_job_is_cancelled(&s->common)) {
                 s->initial_zeroing_ongoing = false;
@@ -649,7 +638,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
         int bytes = MIN(s->bdev_length - offset,
                         QEMU_ALIGN_DOWN(INT_MAX, s->granularity));
 
-        mirror_throttle(s);
+        block_job_relax(&s->common);
 
         if (block_job_is_cancelled(&s->common)) {
             return 0;
diff --git a/blockjob.c b/blockjob.c
index 2a9ff66b95..6f2e709b51 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -906,6 +906,17 @@ void block_job_yield(BlockJob *job)
     block_job_pause_point(job);
 }
 
+void block_job_relax(BlockJob *job)
+{
+    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
+
+    if (now - job->last_enter_ns > SLICE_TIME) {
+        block_job_sleep_ns(job, 0);
+    } else {
+        block_job_pause_point(job);
+    }
+}
+
 void block_job_iostatus_reset(BlockJob *job)
 {
     if (job->iostatus == BLOCK_DEVICE_IO_STATUS_OK) {
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index 209fa1bb3e..553784d86f 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -157,6 +157,15 @@ void block_job_sleep_ns(BlockJob *job, int64_t ns);
  */
 void block_job_yield(BlockJob *job);
 
+/**
+ * block_job_relax:
+ * @job: The job that calls the function.
+ *
+ * Yield if it has been SLICE_TIME nanoseconds since the last yield.
+ * Otherwise, check if we need to pause, and yield if so.
+ */
+void block_job_relax(BlockJob *job);
+
 /**
  * block_job_pause_all:
  *
-- 
2.14.3
