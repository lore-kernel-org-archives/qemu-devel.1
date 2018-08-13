Received: from eggs.gnu.org ([2001:4830:134:3::10]:53230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fp2TF-0003aU-Tn
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:20:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fp2TE-0008Do-U3
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:20:37 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 13 Aug 2018 04:19:58 +0200
Message-Id: <20180813022006.7216-10-mreitz@redhat.com>
In-Reply-To: <20180813022006.7216-1-mreitz@redhat.com>
References: <20180813022006.7216-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 09/17] mirror: Lock AioContext in
 mirror_co_perform()
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

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 85b08086cc..6330269156 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -196,7 +196,6 @@ static void coroutine_fn mirror_write_complete(MirrorOp *op, int ret)
 {
     MirrorBlockJob *s = op->s;
 
-    aio_context_acquire(blk_get_aio_context(s->common.blk));
     if (ret < 0) {
         BlockErrorAction action;
 
@@ -207,14 +206,12 @@ static void coroutine_fn mirror_write_complete(MirrorOp *op, int ret)
         }
     }
     mirror_iteration_done(op, ret);
-    aio_context_release(blk_get_aio_context(s->common.blk));
 }
 
 static void coroutine_fn mirror_read_complete(MirrorOp *op, int ret)
 {
     MirrorBlockJob *s = op->s;
 
-    aio_context_acquire(blk_get_aio_context(s->common.blk));
     if (ret < 0) {
         BlockErrorAction action;
 
@@ -230,7 +227,6 @@ static void coroutine_fn mirror_read_complete(MirrorOp *op, int ret)
                              op->qiov.size, &op->qiov, 0);
         mirror_write_complete(op, ret);
     }
-    aio_context_release(blk_get_aio_context(s->common.blk));
 }
 
 /* Clip bytes relative to offset to not exceed end-of-file */
@@ -387,12 +383,16 @@ static void coroutine_fn mirror_co_perform(void *opaque)
 {
     MirrorOp *op = opaque;
     MirrorBlockJob *s = op->s;
+    AioContext *aio_context;
     int ret;
 
+    aio_context = blk_get_aio_context(s->common.blk);
+    aio_context_acquire(aio_context);
+
     switch (op->mirror_method) {
     case MIRROR_METHOD_COPY:
         mirror_co_read(opaque);
-        return;
+        goto done;
     case MIRROR_METHOD_ZERO:
         ret = mirror_co_zero(s, op->offset, op->bytes);
         break;
@@ -404,6 +404,9 @@ static void coroutine_fn mirror_co_perform(void *opaque)
     }
 
     mirror_write_complete(op, ret);
+
+done:
+    aio_context_release(aio_context);
 }
 
 /* If mirror_method == MIRROR_METHOD_COPY, *offset and *bytes will be
-- 
2.17.1
