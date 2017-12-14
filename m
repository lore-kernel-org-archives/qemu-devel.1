Received: from eggs.gnu.org ([2001:4830:134:3::10]:40044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ePHsi-0001Ow-LR
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 20:00:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ePHsh-0002xo-Ot
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 20:00:12 -0500
From: John Snow <jsnow@redhat.com>
Date: Wed, 13 Dec 2017 19:59:47 -0500
Message-Id: <20171214005953.8898-2-jsnow@redhat.com>
In-Reply-To: <20171214005953.8898-1-jsnow@redhat.com>
References: <20171214005953.8898-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 1/7] blockjob: record time of last yield
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

The mirror job makes a semi-inaccurate record of the last time we left
a "pause", but this doesn't always correlate to the time we actually
last successfully yielded control.

Record the time we last left a yield centrally.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/mirror.c           | 8 ++------
 blockjob.c               | 2 ++
 include/block/blockjob.h | 5 +++++
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index c9badc1203..d35c688faa 100644
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
+    if (now - s->common.last_yield_ns > SLICE_TIME) {
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
+        delta = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - s->common.last_yield_ns;
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
index 715c2c2680..8cbc142f57 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -692,6 +692,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     job->paused        = true;
     job->pause_count   = 1;
     job->refcnt        = 1;
+    job->last_yield_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
     aio_timer_init(qemu_get_aio_context(), &job->sleep_timer,
                    QEMU_CLOCK_REALTIME, SCALE_NS,
                    block_job_sleep_timer_cb, job);
@@ -776,6 +777,7 @@ static void block_job_do_yield(BlockJob *job, uint64_t ns)
     job->busy = false;
     block_job_unlock();
     qemu_coroutine_yield();
+    job->last_yield_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
 
     /* Set by block_job_enter before re-entering the coroutine.  */
     assert(job->busy);
diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 00403d9482..2712e2fd4e 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -141,6 +141,11 @@ typedef struct BlockJob {
      */
     QEMUTimer sleep_timer;
 
+    /**
+     * Timestamp of the last yield
+     */
+    uint64_t last_yield_ns;
+
     /** Non-NULL if this job is part of a transaction */
     BlockJobTxn *txn;
     QLIST_ENTRY(BlockJob) txn_list;
-- 
2.14.3
