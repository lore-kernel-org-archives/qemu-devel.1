Received: from eggs.gnu.org ([2001:4830:134:3::10]:46596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ecdl3-0001z7-GF
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 15:59:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ecdl2-00066g-G5
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 15:59:29 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 19 Jan 2018 15:58:45 -0500
Message-Id: <20180119205847.7141-12-jsnow@redhat.com>
In-Reply-To: <20180119205847.7141-1-jsnow@redhat.com>
References: <20180119205847.7141-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 11/13] block/mirror: remove
 block_job_sleep_ns calls
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

We're attempting to slacken the mirror loop in three different places,
but we can combine these three attempts. Combine the early loop call to
block_job_pause_point with the two late-loop calls to block_job_sleep_ns.

When delay_ns is 0 and it has not been SLICE_TIME since the last yield,
block_job_relax is merely a call to block_job_pause_point, so this should
be equivalent with the exception that if we have managed to not yield at
all in the last SLICE_TIME ns, we will now do so.

I am not sure that condition was possible,
so this loop should be equivalent.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/mirror.c     | 22 +++++++++++-----------
 block/trace-events |  2 +-
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index a0e0044de2..192e03694f 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -761,7 +761,7 @@ static void coroutine_fn mirror_run(void *opaque)
     assert(!s->dbi);
     s->dbi = bdrv_dirty_iter_new(s->dirty_bitmap);
     for (;;) {
-        uint64_t delay_ns = 0;
+        static uint64_t delay_ns = 0;
         int64_t cnt, delta;
         bool should_complete;
 
@@ -770,9 +770,16 @@ static void coroutine_fn mirror_run(void *opaque)
             goto immediate_exit;
         }
 
-        block_job_pause_point(&s->common);
-
         cnt = bdrv_get_dirty_count(s->dirty_bitmap);
+
+        trace_mirror_before_relax(s, cnt, s->synced, delay_ns);
+        if (block_job_relax(&s->common, delay_ns)) {
+            if (!s->synced) {
+                goto immediate_exit;
+            }
+        }
+        delay_ns = 0;
+
         /* s->common.offset contains the number of bytes already processed so
          * far, cnt is the number of dirty bytes remaining and
          * s->bytes_in_flight is the number of bytes currently being
@@ -849,15 +856,8 @@ static void coroutine_fn mirror_run(void *opaque)
         }
 
         ret = 0;
-        trace_mirror_before_sleep(s, cnt, s->synced, delay_ns);
-        if (!s->synced) {
-            block_job_sleep_ns(&s->common, delay_ns);
-            if (block_job_is_cancelled(&s->common)) {
-                break;
-            }
-        } else if (!should_complete) {
+        if (s->synced && !should_complete) {
             delay_ns = (s->in_flight == 0 && cnt == 0 ? SLICE_TIME : 0);
-            block_job_sleep_ns(&s->common, delay_ns);
         }
     }
 
diff --git a/block/trace-events b/block/trace-events
index 11c8d5f590..60f36f929a 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -27,7 +27,7 @@ mirror_start(void *bs, void *s, void *opaque) "bs %p s %p opaque %p"
 mirror_restart_iter(void *s, int64_t cnt) "s %p dirty count %"PRId64
 mirror_before_flush(void *s) "s %p"
 mirror_before_drain(void *s, int64_t cnt) "s %p dirty count %"PRId64
-mirror_before_sleep(void *s, int64_t cnt, int synced, uint64_t delay_ns) "s %p dirty count %"PRId64" synced %d delay %"PRIu64"ns"
+mirror_before_relax(void *s, int64_t cnt, int synced, uint64_t delay_ns) "s %p dirty count %"PRId64" synced %d delay %"PRIu64"ns"
 mirror_one_iteration(void *s, int64_t offset, uint64_t bytes) "s %p offset %" PRId64 " bytes %" PRIu64
 mirror_iteration_done(void *s, int64_t offset, uint64_t bytes, int ret) "s %p offset %" PRId64 " bytes %" PRIu64 " ret %d"
 mirror_yield(void *s, int64_t cnt, int buf_free_count, int in_flight) "s %p dirty count %"PRId64" free buffers %d in_flight %d"
-- 
2.14.3
