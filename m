Received: from eggs.gnu.org ([2001:4830:134:3::10]:47112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0R7b-0002dg-Tc
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:53:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0R7b-0002Ex-1A
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:53:23 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 13 Sep 2018 14:52:14 +0200
Message-Id: <20180913125217.23173-15-kwolf@redhat.com>
In-Reply-To: <20180913125217.23173-1-kwolf@redhat.com>
References: <20180913125217.23173-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 14/17] block: Remove aio_poll() in
 bdrv_drain_poll variants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, famz@redhat.com, pbonzini@redhat.com, slp@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org

bdrv_drain_poll_top_level() was buggy because it didn't release the
AioContext lock of the node to be drained before calling aio_poll().
This way, callbacks called by aio_poll() would possibly take the lock a
second time and run into a deadlock with a nested AIO_WAIT_WHILE() call.

However, it turns out that the aio_poll() call isn't actually needed any
more. It was introduced in commit 91af091f923, which is effectively
reverted by this patch. The cases it was supposed to fix are now covered
by bdrv_drain_poll(), which waits for block jobs to reach a quiescent
state.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
---
 block/io.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/block/io.c b/block/io.c
index 914ba78f1a..8b81ff3913 100644
--- a/block/io.c
+++ b/block/io.c
@@ -268,10 +268,6 @@ bool bdrv_drain_poll(BlockDriverState *bs, bool recursive,
 static bool bdrv_drain_poll_top_level(BlockDriverState *bs, bool recursive,
                                       BdrvChild *ignore_parent)
 {
-    /* Execute pending BHs first and check everything else only after the BHs
-     * have executed. */
-    while (aio_poll(bs->aio_context, false));
-
     return bdrv_drain_poll(bs, recursive, ignore_parent, false);
 }
 
@@ -511,10 +507,6 @@ static bool bdrv_drain_all_poll(void)
     BlockDriverState *bs = NULL;
     bool result = false;
 
-    /* Execute pending BHs first (may modify the graph) and check everything
-     * else only after the BHs have executed. */
-    while (aio_poll(qemu_get_aio_context(), false));
-
     /* bdrv_drain_poll() can't make changes to the graph and we are holding the
      * main AioContext lock, so iterating bdrv_next_all_states() is safe. */
     while ((bs = bdrv_next_all_states(bs))) {
-- 
2.13.6
