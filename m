Received: from eggs.gnu.org ([2001:4830:134:3::10]:41489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er66W-00044E-TX
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:05:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er66V-00042e-Oe
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:05:24 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 28 Feb 2018 19:04:52 +0100
Message-Id: <20180228180507.3964-2-mreitz@redhat.com>
In-Reply-To: <20180228180507.3964-1-mreitz@redhat.com>
References: <20180228180507.3964-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 01/16] block: BDS deletion during
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Draining a BDS child may lead to other children of the same parent being
detached and/or deleted.  We should prepare for the former case (by
copying the children list before iterating through it) and prevent the
latter (by bdrv_ref()'ing all nodes if we are in the main loop).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/io.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/block/io.c b/block/io.c
index 4d3d1f640a..ead12c4136 100644
--- a/block/io.c
+++ b/block/io.c
@@ -189,31 +189,51 @@ static void bdrv_drain_invoke(BlockDriverState *bs, bool begin, bool recursive)
 
 static bool bdrv_drain_recurse(BlockDriverState *bs)
 {
-    BdrvChild *child, *tmp;
+    BdrvChild *child;
     bool waited;
+    struct BDSToDrain {
+        BlockDriverState *bs;
+        QLIST_ENTRY(BDSToDrain) next;
+    };
+    QLIST_HEAD(, BDSToDrain) bs_list = QLIST_HEAD_INITIALIZER(bs_list);
+    bool in_main_loop =
+        qemu_get_current_aio_context() == qemu_get_aio_context();
 
     /* Wait for drained requests to finish */
     waited = BDRV_POLL_WHILE(bs, atomic_read(&bs->in_flight) > 0);
 
-    QLIST_FOREACH_SAFE(child, &bs->children, next, tmp) {
-        BlockDriverState *bs = child->bs;
-        bool in_main_loop =
-            qemu_get_current_aio_context() == qemu_get_aio_context();
-        assert(bs->refcnt > 0);
+    /* Draining children may result in other children being removed from this
+     * parent and maybe even deleted, so copy the children list first */
+    QLIST_FOREACH(child, &bs->children, next) {
+        struct BDSToDrain *bs2d = g_new0(struct BDSToDrain, 1);
+
+        bs2d->bs = child->bs;
         if (in_main_loop) {
             /* In case the recursive bdrv_drain_recurse processes a
              * block_job_defer_to_main_loop BH and modifies the graph,
-             * let's hold a reference to bs until we are done.
+             * let's hold a reference to the BDS until we are done.
              *
              * IOThread doesn't have such a BH, and it is not safe to call
              * bdrv_unref without BQL, so skip doing it there.
              */
-            bdrv_ref(bs);
+            bdrv_ref(bs2d->bs);
         }
-        waited |= bdrv_drain_recurse(bs);
+
+        QLIST_INSERT_HEAD(&bs_list, bs2d, next);
+    }
+
+    while (!QLIST_EMPTY(&bs_list)) {
+        struct BDSToDrain *bs2d = QLIST_FIRST(&bs_list);
+        QLIST_REMOVE(bs2d, next);
+
+        assert(bs2d->bs->refcnt > 0);
+
+        waited |= bdrv_drain_recurse(bs2d->bs);
         if (in_main_loop) {
-            bdrv_unref(bs);
+            bdrv_unref(bs2d->bs);
         }
+
+        g_free(bs2d);
     }
 
     return waited;
-- 
2.14.3
