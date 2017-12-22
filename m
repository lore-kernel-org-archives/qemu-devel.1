Received: from eggs.gnu.org ([2001:4830:134:3::10]:57325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSP6l-0005o1-3g
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:19:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSP6g-0002Uk-1h
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:19:30 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 22 Dec 2017 16:18:30 +0100
Message-Id: <20171222151846.28110-20-kwolf@redhat.com>
In-Reply-To: <20171222151846.28110-1-kwolf@redhat.com>
References: <20171222151846.28110-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL v3 19/35] block: Make bdrv_drain() driver
 callbacks non-recursive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

bdrv_drained_begin() doesn't increase bs->quiesce_counter recursively
and also doesn't notify other parent nodes of children, which both means
that the child nodes are not actually drained, and bdrv_drained_begin()
is providing useful functionality only on a single node.

To keep things consistent, we also shouldn't call the block driver
callbacks recursively.

A proper recursive drain version that provides an actually working
drained section for child nodes will be introduced later.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
---
 block/io.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/block/io.c b/block/io.c
index b94740b8ff..91a52e2d82 100644
--- a/block/io.c
+++ b/block/io.c
@@ -158,7 +158,7 @@ static void coroutine_fn bdrv_drain_invoke_entry(void *opaque)
 }
 
 /* Recursively call BlockDriver.bdrv_co_drain_begin/end callbacks */
-static void bdrv_drain_invoke(BlockDriverState *bs, bool begin)
+static void bdrv_drain_invoke(BlockDriverState *bs, bool begin, bool recursive)
 {
     BdrvChild *child, *tmp;
     BdrvCoDrainData data = { .bs = bs, .done = false, .begin = begin};
@@ -172,8 +172,10 @@ static void bdrv_drain_invoke(BlockDriverState *bs, bool begin)
     bdrv_coroutine_enter(bs, data.co);
     BDRV_POLL_WHILE(bs, !data.done);
 
-    QLIST_FOREACH_SAFE(child, &bs->children, next, tmp) {
-        bdrv_drain_invoke(child->bs, begin);
+    if (recursive) {
+        QLIST_FOREACH_SAFE(child, &bs->children, next, tmp) {
+            bdrv_drain_invoke(child->bs, begin, true);
+        }
     }
 }
 
@@ -265,7 +267,7 @@ void bdrv_drained_begin(BlockDriverState *bs)
         bdrv_parent_drained_begin(bs);
     }
 
-    bdrv_drain_invoke(bs, true);
+    bdrv_drain_invoke(bs, true, false);
     bdrv_drain_recurse(bs);
 }
 
@@ -281,7 +283,7 @@ void bdrv_drained_end(BlockDriverState *bs)
     }
 
     /* Re-enable things in child-to-parent order */
-    bdrv_drain_invoke(bs, false);
+    bdrv_drain_invoke(bs, false, false);
     bdrv_parent_drained_end(bs);
     aio_enable_external(bdrv_get_aio_context(bs));
 }
@@ -345,7 +347,7 @@ void bdrv_drain_all_begin(void)
         aio_context_acquire(aio_context);
         aio_disable_external(aio_context);
         bdrv_parent_drained_begin(bs);
-        bdrv_drain_invoke(bs, true);
+        bdrv_drain_invoke(bs, true, true);
         aio_context_release(aio_context);
 
         if (!g_slist_find(aio_ctxs, aio_context)) {
@@ -388,7 +390,7 @@ void bdrv_drain_all_end(void)
 
         /* Re-enable things in child-to-parent order */
         aio_context_acquire(aio_context);
-        bdrv_drain_invoke(bs, false);
+        bdrv_drain_invoke(bs, false, true);
         bdrv_parent_drained_end(bs);
         aio_enable_external(aio_context);
         aio_context_release(aio_context);
-- 
2.13.6
