Received: from eggs.gnu.org ([2001:4830:134:3::10]:53180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fp2TB-0003X4-Nf
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:20:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fp2TA-0008C4-N1
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:20:33 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 13 Aug 2018 04:19:56 +0200
Message-Id: <20180813022006.7216-8-mreitz@redhat.com>
In-Reply-To: <20180813022006.7216-1-mreitz@redhat.com>
References: <20180813022006.7216-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 07/17] mirror: Make mirror_co_zero() nicer
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
 block/mirror.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 89452ad371..df8e0242dc 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -364,17 +364,14 @@ static void coroutine_fn mirror_co_read(void *opaque)
     mirror_read_complete(op, ret);
 }
 
-static void coroutine_fn mirror_co_zero(void *opaque)
+static int coroutine_fn mirror_co_zero(MirrorBlockJob *s,
+                                       int64_t offset, int64_t bytes)
 {
-    MirrorOp *op = opaque;
-    int ret;
-
-    op->s->in_flight++;
-    op->s->bytes_in_flight += op->bytes;
+    s->in_flight++;
+    s->bytes_in_flight += bytes;
 
-    ret = blk_co_pwrite_zeroes(op->s->target, op->offset, op->bytes,
-                               op->s->unmap ? BDRV_REQ_MAY_UNMAP : 0);
-    mirror_write_complete(op, ret);
+    return blk_co_pwrite_zeroes(s->target, offset, bytes,
+                                s->unmap ? BDRV_REQ_MAY_UNMAP : 0);
 }
 
 static void coroutine_fn mirror_co_discard(void *opaque)
@@ -392,20 +389,24 @@ static void coroutine_fn mirror_co_discard(void *opaque)
 static void coroutine_fn mirror_co_perform(void *opaque)
 {
     MirrorOp *op = opaque;
+    MirrorBlockJob *s = op->s;
+    int ret;
 
     switch (op->mirror_method) {
     case MIRROR_METHOD_COPY:
         mirror_co_read(opaque);
         return;
     case MIRROR_METHOD_ZERO:
-        mirror_co_zero(opaque);
-        return;
+        ret = mirror_co_zero(s, op->offset, op->bytes);
+        break;
     case MIRROR_METHOD_DISCARD:
         mirror_co_discard(opaque);
         return;
     default:
         abort();
     }
+
+    mirror_write_complete(op, ret);
 }
 
 /* If mirror_method == MIRROR_METHOD_COPY, *offset and *bytes will be
-- 
2.17.1
