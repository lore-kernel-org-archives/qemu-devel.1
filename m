Received: from eggs.gnu.org ([2001:4830:134:3::10]:51789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHO-0004qN-EP
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHL-0006Ej-Hj
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:22 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 18 Jun 2018 18:44:37 +0200
Message-Id: <20180618164504.24488-9-kwolf@redhat.com>
In-Reply-To: <20180618164504.24488-1-kwolf@redhat.com>
References: <20180618164504.24488-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 08/35] block: Remove bdrv_drain_recurse()
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

For bdrv_drain(), recursively waiting for child node requests is
pointless because we didn't quiesce their parents, so new requests could
come in anyway. Letting the function work only on a single node makes it
more consistent.

For subtree drains and drain_all, we already have the recursion in
bdrv_do_drained_begin(), so the extra recursion doesn't add anything
either.

Remove the useless code.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io.c | 36 +++---------------------------------
 1 file changed, 3 insertions(+), 33 deletions(-)

diff --git a/block/io.c b/block/io.c
index 5820e73bb2..5f6d5eed52 100644
--- a/block/io.c
+++ b/block/io.c
@@ -219,38 +219,6 @@ static bool bdrv_drain_poll_top_level(BlockDriverState *bs,
     return bdrv_drain_poll(bs, ignore_parent);
 }
 
-static bool bdrv_drain_recurse(BlockDriverState *bs, BdrvChild *parent)
-{
-    BdrvChild *child, *tmp;
-    bool waited;
-
-    /* Wait for drained requests to finish */
-    waited = BDRV_POLL_WHILE(bs, bdrv_drain_poll_top_level(bs, parent));
-
-    QLIST_FOREACH_SAFE(child, &bs->children, next, tmp) {
-        BlockDriverState *bs = child->bs;
-        bool in_main_loop =
-            qemu_get_current_aio_context() == qemu_get_aio_context();
-        assert(bs->refcnt > 0);
-        if (in_main_loop) {
-            /* In case the recursive bdrv_drain_recurse processes a
-             * block_job_defer_to_main_loop BH and modifies the graph,
-             * let's hold a reference to bs until we are done.
-             *
-             * IOThread doesn't have such a BH, and it is not safe to call
-             * bdrv_unref without BQL, so skip doing it there.
-             */
-            bdrv_ref(bs);
-        }
-        waited |= bdrv_drain_recurse(bs, child);
-        if (in_main_loop) {
-            bdrv_unref(bs);
-        }
-    }
-
-    return waited;
-}
-
 static void bdrv_do_drained_begin(BlockDriverState *bs, bool recursive,
                                   BdrvChild *parent);
 static void bdrv_do_drained_end(BlockDriverState *bs, bool recursive,
@@ -318,7 +286,9 @@ void bdrv_do_drained_begin(BlockDriverState *bs, bool recursive,
 
     bdrv_parent_drained_begin(bs, parent);
     bdrv_drain_invoke(bs, true);
-    bdrv_drain_recurse(bs, parent);
+
+    /* Wait for drained requests to finish */
+    BDRV_POLL_WHILE(bs, bdrv_drain_poll_top_level(bs, parent));
 
     if (recursive) {
         bs->recursive_quiesce_counter++;
-- 
2.13.6
