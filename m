Received: from eggs.gnu.org ([2001:4830:134:3::10]:41727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dufAV-00024V-PE
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dufAT-00011q-0S
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:35:59 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Wed, 20 Sep 2017 13:23:09 +0300
Message-Id: <20170920102311.25736-2-el13635@mail.ntua.gr>
In-Reply-To: <20170920102311.25736-1-el13635@mail.ntua.gr>
References: <20170920102311.25736-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH 1/3] block: add bdrv_co_drain_end callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>

BlockDriverState has a bdrv_do_drain() callback but no equivalent for the end
of the drain. The throttle driver (block/throttle.c) needs a way to mark the
end of the drain in order to toggle io_limits_disabled correctly, thus
bdrv_co_drain_end is needed.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 include/block/block_int.h |  2 ++
 block/io.c                | 43 +++++++++++++++++++++++++++++++------------
 2 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index ba4c383393..ea1326e3c7 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -359,6 +359,8 @@ struct BlockDriver {
      */
     void coroutine_fn (*bdrv_co_drain)(BlockDriverState *bs);
 
+    void coroutine_fn (*bdrv_co_drain_end)(BlockDriverState *bs);
+
     void (*bdrv_add_child)(BlockDriverState *parent, BlockDriverState *child,
                            Error **errp);
     void (*bdrv_del_child)(BlockDriverState *parent, BdrvChild *child,
diff --git a/block/io.c b/block/io.c
index 4378ae4c7d..465345289d 100644
--- a/block/io.c
+++ b/block/io.c
@@ -153,6 +153,7 @@ typedef struct {
     Coroutine *co;
     BlockDriverState *bs;
     bool done;
+    bool begin;
 } BdrvCoDrainData;
 
 static void coroutine_fn bdrv_drain_invoke_entry(void *opaque)
@@ -160,18 +161,23 @@ static void coroutine_fn bdrv_drain_invoke_entry(void *opaque)
     BdrvCoDrainData *data = opaque;
     BlockDriverState *bs = data->bs;
 
-    bs->drv->bdrv_co_drain(bs);
+    if (data->begin) {
+        bs->drv->bdrv_co_drain(bs);
+    } else {
+        bs->drv->bdrv_co_drain_end(bs);
+    }
 
     /* Set data->done before reading bs->wakeup.  */
     atomic_mb_set(&data->done, true);
     bdrv_wakeup(bs);
 }
 
-static void bdrv_drain_invoke(BlockDriverState *bs)
+static void bdrv_drain_invoke(BlockDriverState *bs, bool begin)
 {
-    BdrvCoDrainData data = { .bs = bs, .done = false };
+    BdrvCoDrainData data = { .bs = bs, .done = false, .begin = begin};
 
-    if (!bs->drv || !bs->drv->bdrv_co_drain) {
+    if (!bs->drv || (begin && !bs->drv->bdrv_co_drain) ||
+            (!begin && !bs->drv->bdrv_co_drain_end)) {
         return;
     }
 
@@ -180,7 +186,7 @@ static void bdrv_drain_invoke(BlockDriverState *bs)
     BDRV_POLL_WHILE(bs, !data.done);
 }
 
-static bool bdrv_drain_recurse(BlockDriverState *bs)
+static bool bdrv_drain_recurse(BlockDriverState *bs, bool begin)
 {
     BdrvChild *child, *tmp;
     bool waited;
@@ -188,7 +194,7 @@ static bool bdrv_drain_recurse(BlockDriverState *bs)
     waited = BDRV_POLL_WHILE(bs, atomic_read(&bs->in_flight) > 0);
 
     /* Ensure any pending metadata writes are submitted to bs->file.  */
-    bdrv_drain_invoke(bs);
+    bdrv_drain_invoke(bs, begin);
 
     QLIST_FOREACH_SAFE(child, &bs->children, next, tmp) {
         BlockDriverState *bs = child->bs;
@@ -205,7 +211,7 @@ static bool bdrv_drain_recurse(BlockDriverState *bs)
              */
             bdrv_ref(bs);
         }
-        waited |= bdrv_drain_recurse(bs);
+        waited |= bdrv_drain_recurse(bs, begin);
         if (in_main_loop) {
             bdrv_unref(bs);
         }
@@ -221,12 +227,18 @@ static void bdrv_co_drain_bh_cb(void *opaque)
     BlockDriverState *bs = data->bs;
 
     bdrv_dec_in_flight(bs);
-    bdrv_drained_begin(bs);
+    if (data->begin) {
+        bdrv_drained_begin(bs);
+    } else {
+        bdrv_drained_end(bs);
+    }
+
     data->done = true;
     aio_co_wake(co);
 }
 
-static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs)
+static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
+                                                bool begin)
 {
     BdrvCoDrainData data;
 
@@ -239,6 +251,7 @@ static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs)
         .co = qemu_coroutine_self(),
         .bs = bs,
         .done = false,
+        .begin = begin,
     };
     bdrv_inc_in_flight(bs);
     aio_bh_schedule_oneshot(bdrv_get_aio_context(bs),
@@ -253,7 +266,7 @@ static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs)
 void bdrv_drained_begin(BlockDriverState *bs)
 {
     if (qemu_in_coroutine()) {
-        bdrv_co_yield_to_drain(bs);
+        bdrv_co_yield_to_drain(bs, true);
         return;
     }
 
@@ -262,17 +275,22 @@ void bdrv_drained_begin(BlockDriverState *bs)
         bdrv_parent_drained_begin(bs);
     }
 
-    bdrv_drain_recurse(bs);
+    bdrv_drain_recurse(bs, true);
 }
 
 void bdrv_drained_end(BlockDriverState *bs)
 {
+    if (qemu_in_coroutine()) {
+        bdrv_co_yield_to_drain(bs, false);
+        return;
+    }
     assert(bs->quiesce_counter > 0);
     if (atomic_fetch_dec(&bs->quiesce_counter) > 1) {
         return;
     }
 
     bdrv_parent_drained_end(bs);
+    bdrv_drain_recurse(bs, false);
     aio_enable_external(bdrv_get_aio_context(bs));
 }
 
@@ -350,7 +368,7 @@ void bdrv_drain_all_begin(void)
             aio_context_acquire(aio_context);
             for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
                 if (aio_context == bdrv_get_aio_context(bs)) {
-                    waited |= bdrv_drain_recurse(bs);
+                    waited |= bdrv_drain_recurse(bs, true);
                 }
             }
             aio_context_release(aio_context);
@@ -371,6 +389,7 @@ void bdrv_drain_all_end(void)
         aio_context_acquire(aio_context);
         aio_enable_external(aio_context);
         bdrv_parent_drained_end(bs);
+        bdrv_drain_recurse(bs, false);
         aio_context_release(aio_context);
     }
 
-- 
2.11.0
