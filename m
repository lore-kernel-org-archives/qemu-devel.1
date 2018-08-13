Received: from eggs.gnu.org ([2001:4830:134:3::10]:53387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fp2TT-0003nM-Go
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fp2TS-0008Kv-Mw
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:20:51 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 13 Aug 2018 04:20:03 +0200
Message-Id: <20180813022006.7216-15-mreitz@redhat.com>
In-Reply-To: <20180813022006.7216-1-mreitz@redhat.com>
References: <20180813022006.7216-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 14/17] mirror: Inline mirror_iteration_done()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, Fam Zheng <famz@redhat.com>

mirror_co_perform() is the sole user of that function, and it looks a
bit weird now.  This patch inlines it into mirror_co_perform().

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c | 53 ++++++++++++++++++++++----------------------------
 1 file changed, 23 insertions(+), 30 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 62fd499799..053c37b6a6 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -154,35 +154,6 @@ static void coroutine_fn mirror_wait_on_conflicts(MirrorOp *self,
     }
 }
 
-static void coroutine_fn mirror_iteration_done(MirrorOp *op, int ret)
-{
-    MirrorBlockJob *s = op->s;
-    int64_t chunk_num;
-    int nb_chunks;
-
-    trace_mirror_iteration_done(s, op->offset, op->bytes, ret);
-
-    s->in_flight--;
-    s->bytes_in_flight -= op->bytes;
-
-    chunk_num = op->offset / s->granularity;
-    nb_chunks = DIV_ROUND_UP(op->bytes, s->granularity);
-
-    bitmap_clear(s->in_flight_bitmap, chunk_num, nb_chunks);
-    QTAILQ_REMOVE(&s->ops_in_flight, op, next);
-    if (ret >= 0) {
-        if (s->cow_bitmap) {
-            bitmap_set(s->cow_bitmap, chunk_num, nb_chunks);
-        }
-        if (!s->initial_zeroing_ongoing) {
-            job_progress_update(&s->common.job, op->bytes);
-        }
-    }
-
-    qemu_co_queue_restart_all(&op->waiting_requests);
-    g_free(op);
-}
-
 /* Clip bytes relative to offset to not exceed end-of-file */
 static inline int64_t mirror_clip_bytes(MirrorBlockJob *s,
                                         int64_t offset,
@@ -373,6 +344,8 @@ static void coroutine_fn mirror_co_perform(void *opaque)
     MirrorOp *op = opaque;
     MirrorBlockJob *s = op->s;
     AioContext *aio_context;
+    int64_t chunk_num;
+    int nb_chunks;
     bool failed_on_read = false;
     int ret;
 
@@ -403,7 +376,27 @@ static void coroutine_fn mirror_co_perform(void *opaque)
         }
     }
 
-    mirror_iteration_done(op, ret);
+    trace_mirror_iteration_done(s, op->offset, op->bytes, ret);
+
+    s->in_flight--;
+    s->bytes_in_flight -= op->bytes;
+
+    chunk_num = op->offset / s->granularity;
+    nb_chunks = DIV_ROUND_UP(op->bytes, s->granularity);
+
+    bitmap_clear(s->in_flight_bitmap, chunk_num, nb_chunks);
+    QTAILQ_REMOVE(&s->ops_in_flight, op, next);
+    if (ret >= 0) {
+        if (s->cow_bitmap) {
+            bitmap_set(s->cow_bitmap, chunk_num, nb_chunks);
+        }
+        if (!s->initial_zeroing_ongoing) {
+            job_progress_update(&s->common.job, op->bytes);
+        }
+    }
+
+    qemu_co_queue_restart_all(&op->waiting_requests);
+    g_free(op);
 
     aio_context_release(aio_context);
 }
-- 
2.17.1
