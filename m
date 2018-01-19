Received: from eggs.gnu.org ([2001:4830:134:3::10]:46313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ecdkd-0001X6-PA
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 15:59:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ecdkc-0005vU-VI
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 15:59:03 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 19 Jan 2018 15:58:35 -0500
Message-Id: <20180119205847.7141-2-jsnow@redhat.com>
In-Reply-To: <20180119205847.7141-1-jsnow@redhat.com>
References: <20180119205847.7141-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 01/13] blockjob: record time of last entrance
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

The mirror job makes a semi-inaccurate record of the last time we yielded
by recording the last time we left a "pause", but this doesn't always
correlate to the time we actually last successfully ceded control.

Record the time we last *exited* a yield centrally. In other words, record
the time we began execution of this job to know how long we have been
selfish for.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/mirror.c           | 8 ++------
 blockjob.c               | 2 ++
 include/block/blockjob.h | 5 +++++
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index c9badc1203..88f4e8964d 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -63,7 +63,6 @@ typedef struct MirrorBlockJob {
     QSIMPLEQ_HEAD(, MirrorBuffer) buf_free;
     int buf_free_count;
 
-    uint64_t last_pause_ns;
     unsigned long *in_flight_bitmap;
     int in_flight;
     int64_t bytes_in_flight;
@@ -596,8 +595,7 @@ static void mirror_throttle(MirrorBlockJob *s)
 {
     int64_t now = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
 
-    if (now - s->last_pause_ns > SLICE_TIME) {
-        s->last_pause_ns = now;
+    if (now - s->common.last_enter_ns > SLICE_TIME) {
         block_job_sleep_ns(&s->common, 0);
     } else {
         block_job_pause_point(&s->common);
@@ -769,7 +767,6 @@ static void coroutine_fn mirror_run(void *opaque)
 
     mirror_free_init(s);
 
-    s->last_pause_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
     if (!s->is_none_mode) {
         ret = mirror_dirty_init(s);
         if (ret < 0 || block_job_is_cancelled(&s->common)) {
@@ -803,7 +800,7 @@ static void coroutine_fn mirror_run(void *opaque)
          * We do so every SLICE_TIME nanoseconds, or when there is an error,
          * or when the source is clean, whichever comes first.
          */
-        delta = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - s->last_pause_ns;
+        delta = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - s->common.last_enter_ns;
         if (delta < SLICE_TIME &&
             s->common.iostatus == BLOCK_DEVICE_IO_STATUS_OK) {
             if (s->in_flight >= MAX_IN_FLIGHT || s->buf_free_count == 0 ||
@@ -878,7 +875,6 @@ static void coroutine_fn mirror_run(void *opaque)
             delay_ns = (s->in_flight == 0 && cnt == 0 ? SLICE_TIME : 0);
             block_job_sleep_ns(&s->common, delay_ns);
         }
-        s->last_pause_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
     }
 
 immediate_exit:
diff --git a/blockjob.c b/blockjob.c
index f5cea84e73..2a9ff66b95 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -321,6 +321,7 @@ void block_job_start(BlockJob *job)
     job->pause_count--;
     job->busy = true;
     job->paused = false;
+    job->last_enter_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
     bdrv_coroutine_enter(blk_bs(job->blk), job->co);
 }
 
@@ -786,6 +787,7 @@ static void block_job_do_yield(BlockJob *job, uint64_t ns)
     job->busy = false;
     block_job_unlock();
     qemu_coroutine_yield();
+    job->last_enter_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
 
     /* Set by block_job_enter before re-entering the coroutine.  */
     assert(job->busy);
diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 00403d9482..e965845c94 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -141,6 +141,11 @@ typedef struct BlockJob {
      */
     QEMUTimer sleep_timer;
 
+    /**
+     * Timestamp of the last yield
+     */
+    uint64_t last_enter_ns;
+
     /** Non-NULL if this job is part of a transaction */
     BlockJobTxn *txn;
     QLIST_ENTRY(BlockJob) txn_list;
-- 
2.14.3
