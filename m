Received: from eggs.gnu.org ([2001:4830:134:3::10]:53189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fp2TC-0003XV-6q
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:20:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fp2TB-0008CP-8v
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:20:34 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 13 Aug 2018 04:19:57 +0200
Message-Id: <20180813022006.7216-9-mreitz@redhat.com>
In-Reply-To: <20180813022006.7216-1-mreitz@redhat.com>
References: <20180813022006.7216-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 08/17] mirror: Make mirror_co_discard() nicer
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
 block/mirror.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index df8e0242dc..85b08086cc 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -374,16 +374,13 @@ static int coroutine_fn mirror_co_zero(MirrorBlockJob *s,
                                 s->unmap ? BDRV_REQ_MAY_UNMAP : 0);
 }
 
-static void coroutine_fn mirror_co_discard(void *opaque)
+static int coroutine_fn mirror_co_discard(MirrorBlockJob *s,
+                                          int64_t offset, int64_t bytes)
 {
-    MirrorOp *op = opaque;
-    int ret;
-
-    op->s->in_flight++;
-    op->s->bytes_in_flight += op->bytes;
+    s->in_flight++;
+    s->bytes_in_flight += bytes;
 
-    ret = blk_co_pdiscard(op->s->target, op->offset, op->bytes);
-    mirror_write_complete(op, ret);
+    return blk_co_pdiscard(s->target, offset, bytes);
 }
 
 static void coroutine_fn mirror_co_perform(void *opaque)
@@ -400,8 +397,8 @@ static void coroutine_fn mirror_co_perform(void *opaque)
         ret = mirror_co_zero(s, op->offset, op->bytes);
         break;
     case MIRROR_METHOD_DISCARD:
-        mirror_co_discard(opaque);
-        return;
+        ret = mirror_co_discard(s, op->offset, op->bytes);
+        break;
     default:
         abort();
     }
-- 
2.17.1
