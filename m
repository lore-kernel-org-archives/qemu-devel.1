Received: from eggs.gnu.org ([2001:4830:134:3::10]:36470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dsCGE-0007jD-BK
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:19:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dsCGD-0004ia-3M
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:19:42 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 13 Sep 2017 20:18:54 +0200
Message-Id: <20170913181910.29688-3-mreitz@redhat.com>
In-Reply-To: <20170913181910.29688-1-mreitz@redhat.com>
References: <20170913181910.29688-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 02/18] block: BDS deletion during
 bdrv_drain_recurse
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

Drainined a BDS child may lead to both the original BDS and/or its other
children being deleted (e.g. if the original BDS represents a block
job).  We should prepare for this in both bdrv_drain_recurse() and
bdrv_drained_begin() by monitoring whether the BDS we are about to drain
still exists at all.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/io.c | 72 +++++++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 52 insertions(+), 20 deletions(-)

diff --git a/block/io.c b/block/io.c
index 4378ae4c7d..8ec1a564ad 100644
--- a/block/io.c
+++ b/block/io.c
@@ -182,33 +182,57 @@ static void bdrv_drain_invoke(BlockDriverState *bs)
 
 static bool bdrv_drain_recurse(BlockDriverState *bs)
 {
-    BdrvChild *child, *tmp;
+    BdrvChild *child;
     bool waited;
+    struct BDSToDrain {
+        BlockDriverState *bs;
+        BdrvDeletedStatus del_stat;
+        QLIST_ENTRY(BDSToDrain) next;
+    };
+    QLIST_HEAD(, BDSToDrain) bs_list = QLIST_HEAD_INITIALIZER(bs_list);
+    bool in_main_loop =
+        qemu_get_current_aio_context() == qemu_get_aio_context();
 
     waited = BDRV_POLL_WHILE(bs, atomic_read(&bs->in_flight) > 0);
 
     /* Ensure any pending metadata writes are submitted to bs->file.  */
     bdrv_drain_invoke(bs);
 
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
-        waited |= bdrv_drain_recurse(bs);
-        if (in_main_loop) {
-            bdrv_unref(bs);
+    /* Draining children may result in other children being removed and maybe
+     * even deleted, so copy the children list first */
+    QLIST_FOREACH(child, &bs->children, next) {
+        struct BDSToDrain *bs2d = g_new0(struct BDSToDrain, 1);
+
+        bs2d->bs = child->bs;
+        QLIST_INSERT_HEAD(&bs->deleted_status, &bs2d->del_stat, next);
+
+        QLIST_INSERT_HEAD(&bs_list, bs2d, next);
+    }
+
+    while (!QLIST_EMPTY(&bs_list)) {
+        struct BDSToDrain *bs2d = QLIST_FIRST(&bs_list);
+        QLIST_REMOVE(bs2d, next);
+
+        if (!bs2d->del_stat.deleted) {
+            QLIST_REMOVE(&bs2d->del_stat, next);
+
+            if (in_main_loop) {
+                /* In case the recursive bdrv_drain_recurse processes a
+                 * block_job_defer_to_main_loop BH and modifies the graph,
+                 * let's hold a reference to the BDS until we are done.
+                 *
+                 * IOThread doesn't have such a BH, and it is not safe to call
+                 * bdrv_unref without BQL, so skip doing it there.
+                 */
+                bdrv_ref(bs2d->bs);
+            }
+            waited |= bdrv_drain_recurse(bs2d->bs);
+            if (in_main_loop) {
+                bdrv_unref(bs2d->bs);
+            }
         }
+
+        g_free(bs2d);
     }
 
     return waited;
@@ -252,17 +276,25 @@ static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs)
 
 void bdrv_drained_begin(BlockDriverState *bs)
 {
+    BdrvDeletedStatus del_stat = { .deleted = false };
+
     if (qemu_in_coroutine()) {
         bdrv_co_yield_to_drain(bs);
         return;
     }
 
+    QLIST_INSERT_HEAD(&bs->deleted_status, &del_stat, next);
+
     if (atomic_fetch_inc(&bs->quiesce_counter) == 0) {
         aio_disable_external(bdrv_get_aio_context(bs));
         bdrv_parent_drained_begin(bs);
     }
 
-    bdrv_drain_recurse(bs);
+    if (!del_stat.deleted) {
+        QLIST_REMOVE(&del_stat, next);
+
+        bdrv_drain_recurse(bs);
+    }
 }
 
 void bdrv_drained_end(BlockDriverState *bs)
-- 
2.13.5
