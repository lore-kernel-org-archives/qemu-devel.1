Received: from eggs.gnu.org ([2001:4830:134:3::10]:40898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f6In2-0002Ua-P9
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 12:40:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f6In2-0004Nw-1s
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 12:40:08 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 11 Apr 2018 18:39:24 +0200
Message-Id: <20180411163940.2523-4-kwolf@redhat.com>
In-Reply-To: <20180411163940.2523-1-kwolf@redhat.com>
References: <20180411163940.2523-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 03/19] block: Remove 'recursive' parameter from
 bdrv_drain_invoke()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, famz@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

All callers pass false for the 'recursive' parameter now. Remove it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/block/io.c b/block/io.c
index cad59db2f4..d2bd89c3bb 100644
--- a/block/io.c
+++ b/block/io.c
@@ -167,9 +167,8 @@ static void coroutine_fn bdrv_drain_invoke_entry(void *opaque)
 }
 
 /* Recursively call BlockDriver.bdrv_co_drain_begin/end callbacks */
-static void bdrv_drain_invoke(BlockDriverState *bs, bool begin, bool recursive)
+static void bdrv_drain_invoke(BlockDriverState *bs, bool begin)
 {
-    BdrvChild *child, *tmp;
     BdrvCoDrainData data = { .bs = bs, .done = false, .begin = begin};
 
     if (!bs->drv || (begin && !bs->drv->bdrv_co_drain_begin) ||
@@ -180,12 +179,6 @@ static void bdrv_drain_invoke(BlockDriverState *bs, bool begin, bool recursive)
     data.co = qemu_coroutine_create(bdrv_drain_invoke_entry, &data);
     bdrv_coroutine_enter(bs, data.co);
     BDRV_POLL_WHILE(bs, !data.done);
-
-    if (recursive) {
-        QLIST_FOREACH_SAFE(child, &bs->children, next, tmp) {
-            bdrv_drain_invoke(child->bs, begin, true);
-        }
-    }
 }
 
 static bool bdrv_drain_recurse(BlockDriverState *bs)
@@ -286,7 +279,7 @@ void bdrv_do_drained_begin(BlockDriverState *bs, bool recursive,
     }
 
     bdrv_parent_drained_begin(bs, parent);
-    bdrv_drain_invoke(bs, true, false);
+    bdrv_drain_invoke(bs, true);
     bdrv_drain_recurse(bs);
 
     if (recursive) {
@@ -321,7 +314,7 @@ void bdrv_do_drained_end(BlockDriverState *bs, bool recursive,
     old_quiesce_counter = atomic_fetch_dec(&bs->quiesce_counter);
 
     /* Re-enable things in child-to-parent order */
-    bdrv_drain_invoke(bs, false, false);
+    bdrv_drain_invoke(bs, false);
     bdrv_parent_drained_end(bs, parent);
     if (old_quiesce_counter == 1) {
         aio_enable_external(bdrv_get_aio_context(bs));
-- 
2.13.6
