Received: from eggs.gnu.org ([2001:4830:134:3::10]:52033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHX-00050z-DV
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHU-0006LU-Q8
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:31 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 18 Jun 2018 18:44:46 +0200
Message-Id: <20180618164504.24488-18-kwolf@redhat.com>
In-Reply-To: <20180618164504.24488-1-kwolf@redhat.com>
References: <20180618164504.24488-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 17/35] block: Move bdrv_drain_all_begin() out of
 coroutine context
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

Before we can introduce a single polling loop for all nodes in
bdrv_drain_all_begin(), we must make sure to run it outside of coroutine
context like we already do for bdrv_do_drained_begin().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/block/io.c b/block/io.c
index e08d53c8a5..1a9974c136 100644
--- a/block/io.c
+++ b/block/io.c
@@ -264,11 +264,16 @@ static void bdrv_co_drain_bh_cb(void *opaque)
     Coroutine *co = data->co;
     BlockDriverState *bs = data->bs;
 
-    bdrv_dec_in_flight(bs);
-    if (data->begin) {
-        bdrv_do_drained_begin(bs, data->recursive, data->parent, data->poll);
+    if (bs) {
+        bdrv_dec_in_flight(bs);
+        if (data->begin) {
+            bdrv_do_drained_begin(bs, data->recursive, data->parent, data->poll);
+        } else {
+            bdrv_do_drained_end(bs, data->recursive, data->parent);
+        }
     } else {
-        bdrv_do_drained_end(bs, data->recursive, data->parent);
+        assert(data->begin);
+        bdrv_drain_all_begin();
     }
 
     data->done = true;
@@ -294,7 +299,9 @@ static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
         .parent = parent,
         .poll = poll,
     };
-    bdrv_inc_in_flight(bs);
+    if (bs) {
+        bdrv_inc_in_flight(bs);
+    }
     aio_bh_schedule_oneshot(bdrv_get_aio_context(bs),
                             bdrv_co_drain_bh_cb, &data);
 
@@ -464,6 +471,11 @@ void bdrv_drain_all_begin(void)
     BlockDriverState *bs;
     BdrvNextIterator it;
 
+    if (qemu_in_coroutine()) {
+        bdrv_co_yield_to_drain(NULL, true, false, NULL, true);
+        return;
+    }
+
     /* BDRV_POLL_WHILE() for a node can only be called from its own I/O thread
      * or the main loop AioContext. We potentially use BDRV_POLL_WHILE() on
      * nodes in several different AioContexts, so make sure we're in the main
-- 
2.13.6
