Received: from eggs.gnu.org ([2001:4830:134:3::10]:53338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fp2TO-0003iI-II
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fp2TN-0008Iu-BE
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:20:46 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 13 Aug 2018 04:20:01 +0200
Message-Id: <20180813022006.7216-13-mreitz@redhat.com>
In-Reply-To: <20180813022006.7216-1-mreitz@redhat.com>
References: <20180813022006.7216-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 12/17] mirror: Put QIOV locally into
 mirror_co_read
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

We only need the I/O vector for data copying operations, so we do not
need to put it into the MirrorOp structure and can keep it locally in
mirror_co_read().

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c | 43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 66746cf075..f3df7dd984 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -95,7 +95,6 @@ struct MirrorOp {
     MirrorBlockJob *s;
     MirrorMethod mirror_method;
 
-    QEMUIOVector qiov;
     int64_t offset;
     int64_t bytes;
 
@@ -155,7 +154,8 @@ static void coroutine_fn mirror_wait_on_conflicts(MirrorOp *self,
     }
 }
 
-static void coroutine_fn mirror_iteration_done(MirrorOp *op, int ret)
+static void coroutine_fn mirror_iteration_done(MirrorOp *op, int ret,
+                                               QEMUIOVector *qiov)
 {
     MirrorBlockJob *s = op->s;
     struct iovec *iov;
@@ -166,11 +166,13 @@ static void coroutine_fn mirror_iteration_done(MirrorOp *op, int ret)
 
     s->in_flight--;
     s->bytes_in_flight -= op->bytes;
-    iov = op->qiov.iov;
-    for (i = 0; i < op->qiov.niov; i++) {
-        MirrorBuffer *buf = (MirrorBuffer *) iov[i].iov_base;
-        QSIMPLEQ_INSERT_TAIL(&s->buf_free, buf, next);
-        s->buf_free_count++;
+    if (qiov) {
+        iov = qiov->iov;
+        for (i = 0; i < qiov->niov; i++) {
+            MirrorBuffer *buf = (MirrorBuffer *) iov[i].iov_base;
+            QSIMPLEQ_INSERT_TAIL(&s->buf_free, buf, next);
+            s->buf_free_count++;
+        }
     }
 
     chunk_num = op->offset / s->granularity;
@@ -186,13 +188,16 @@ static void coroutine_fn mirror_iteration_done(MirrorOp *op, int ret)
             job_progress_update(&s->common.job, op->bytes);
         }
     }
-    qemu_iovec_destroy(&op->qiov);
+    if (qiov) {
+        qemu_iovec_destroy(qiov);
+    }
 
     qemu_co_queue_restart_all(&op->waiting_requests);
     g_free(op);
 }
 
-static void coroutine_fn mirror_write_complete(MirrorOp *op, int ret)
+static void coroutine_fn mirror_write_complete(MirrorOp *op, int ret,
+                                               QEMUIOVector *qiov)
 {
     MirrorBlockJob *s = op->s;
 
@@ -205,10 +210,11 @@ static void coroutine_fn mirror_write_complete(MirrorOp *op, int ret)
             s->ret = ret;
         }
     }
-    mirror_iteration_done(op, ret);
+    mirror_iteration_done(op, ret, qiov);
 }
 
-static void coroutine_fn mirror_read_complete(MirrorOp *op, int ret)
+static void coroutine_fn mirror_read_complete(MirrorOp *op, int ret,
+                                              QEMUIOVector *qiov)
 {
     MirrorBlockJob *s = op->s;
 
@@ -221,11 +227,11 @@ static void coroutine_fn mirror_read_complete(MirrorOp *op, int ret)
             s->ret = ret;
         }
 
-        mirror_iteration_done(op, ret);
+        mirror_iteration_done(op, ret, qiov);
     } else {
         ret = blk_co_pwritev(s->target, op->offset,
-                             op->qiov.size, &op->qiov, 0);
-        mirror_write_complete(op, ret);
+                             qiov->size, qiov, 0);
+        mirror_write_complete(op, ret, qiov);
     }
 }
 
@@ -350,9 +356,10 @@ static void coroutine_fn mirror_co_read(void *opaque)
 {
     MirrorOp *op = opaque;
     MirrorBlockJob *s = op->s;
+    QEMUIOVector qiov;
     uint64_t ret;
 
-    mirror_co_alloc_qiov(s, &op->qiov, op->offset, op->bytes);
+    mirror_co_alloc_qiov(s, &qiov, op->offset, op->bytes);
 
     /* Copy the dirty cluster.  */
     s->in_flight++;
@@ -360,8 +367,8 @@ static void coroutine_fn mirror_co_read(void *opaque)
     trace_mirror_one_iteration(s, op->offset, op->bytes);
 
     ret = bdrv_co_preadv(s->mirror_top_bs->backing, op->offset, op->bytes,
-                         &op->qiov, 0);
-    mirror_read_complete(op, ret);
+                         &qiov, 0);
+    mirror_read_complete(op, ret, &qiov);
 }
 
 static int coroutine_fn mirror_co_zero(MirrorBlockJob *s,
@@ -417,7 +424,7 @@ static void coroutine_fn mirror_co_perform(void *opaque)
         }
     }
 
-    mirror_iteration_done(op, ret);
+    mirror_iteration_done(op, ret, NULL);
 
 done:
     aio_context_release(aio_context);
-- 
2.17.1
