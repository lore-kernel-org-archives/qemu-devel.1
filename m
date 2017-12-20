Received: from eggs.gnu.org ([2001:4830:134:3::10]:55954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eReIB-0004kA-MN
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:20:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eReIA-0006bx-Ql
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:20:15 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 20 Dec 2017 14:19:34 +0100
Message-Id: <20171220131939.27543-10-kwolf@redhat.com>
In-Reply-To: <20171220131939.27543-1-kwolf@redhat.com>
References: <20171220131939.27543-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 09/14] block: Unify order in drain functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

Drain requests are propagated to child nodes, parent nodes and directly
to the AioContext. The order in which this happened was different
between all combinations of drain/drain_all and begin/end.

The correct order is to keep children only drained when their parents
are also drained. This means that at the start of a drained section, the
AioContext needs to be drained first, the parents second and only then
the children. The correct order for the end of a drained section is the
opposite.

This patch changes the three other functions to follow the example of
bdrv_drained_begin(), which is the only one that got it right.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/io.c b/block/io.c
index 5fdb92a15e..1e92d2e5b2 100644
--- a/block/io.c
+++ b/block/io.c
@@ -277,6 +277,7 @@ void bdrv_drained_begin(BlockDriverState *bs)
         return;
     }
 
+    /* Stop things in parent-to-child order */
     if (atomic_fetch_inc(&bs->quiesce_counter) == 0) {
         aio_disable_external(bdrv_get_aio_context(bs));
         bdrv_parent_drained_begin(bs);
@@ -297,8 +298,9 @@ void bdrv_drained_end(BlockDriverState *bs)
         return;
     }
 
-    bdrv_parent_drained_end(bs);
+    /* Re-enable things in child-to-parent order */
     bdrv_drain_invoke(bs, false);
+    bdrv_parent_drained_end(bs);
     aio_enable_external(bdrv_get_aio_context(bs));
 }
 
@@ -351,9 +353,10 @@ void bdrv_drain_all_begin(void)
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
         AioContext *aio_context = bdrv_get_aio_context(bs);
 
+        /* Stop things in parent-to-child order */
         aio_context_acquire(aio_context);
-        bdrv_parent_drained_begin(bs);
         aio_disable_external(aio_context);
+        bdrv_parent_drained_begin(bs);
         bdrv_drain_invoke(bs, true);
         aio_context_release(aio_context);
 
@@ -395,10 +398,11 @@ void bdrv_drain_all_end(void)
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
         AioContext *aio_context = bdrv_get_aio_context(bs);
 
+        /* Re-enable things in child-to-parent order */
         aio_context_acquire(aio_context);
-        aio_enable_external(aio_context);
-        bdrv_parent_drained_end(bs);
         bdrv_drain_invoke(bs, false);
+        bdrv_parent_drained_end(bs);
+        aio_enable_external(aio_context);
         aio_context_release(aio_context);
     }
 
-- 
2.13.6
