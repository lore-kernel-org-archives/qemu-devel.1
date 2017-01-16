Received: from eggs.gnu.org ([2001:4830:134:3::10]:41147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cT7VF-0007z5-2h
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:39:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cT7VE-0003ia-3K
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:39:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cT7VD-0003iU-Re
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:39:16 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 16 Jan 2017 13:39:01 +0000
Message-Id: <20170116133911.21684-2-stefanha@redhat.com>
In-Reply-To: <20170116133911.21684-1-stefanha@redhat.com>
References: <20170116133911.21684-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 01/11] block: get rid of
 bdrv_io_unplugged_begin/end
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

bdrv_io_plug and bdrv_io_unplug are only called (via their
BlockBackend equivalents) after starting asynchronous I/O.
bdrv_drain is not going to be called while they are running,
because---even if a coroutine runs for some reason---it will
only drain in the next iteration of the event loop through
bdrv_co_yield_to_drain.

So this mechanism is unnecessary, get rid of it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20161129113334.605-1-pbonzini@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/block.h     |  2 --
 include/block/block_int.h |  3 +--
 block/io.c                | 41 ++---------------------------------------
 3 files changed, 3 insertions(+), 43 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 49bb0b2..8b0dcda 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -526,8 +526,6 @@ int bdrv_probe_geometry(BlockDriverState *bs, HDGeometry *geo);
 
 void bdrv_io_plug(BlockDriverState *bs);
 void bdrv_io_unplug(BlockDriverState *bs);
-void bdrv_io_unplugged_begin(BlockDriverState *bs);
-void bdrv_io_unplugged_end(BlockDriverState *bs);
 
 /**
  * bdrv_drained_begin:
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 4e4562d..2d92d7e 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -526,9 +526,8 @@ struct BlockDriverState {
     uint64_t write_threshold_offset;
     NotifierWithReturn write_threshold_notifier;
 
-    /* counters for nested bdrv_io_plug and bdrv_io_unplugged_begin */
+    /* counter for nested bdrv_io_plug */
     unsigned io_plugged;
-    unsigned io_plug_disabled;
 
     int quiesce_counter;
 };
diff --git a/block/io.c b/block/io.c
index 4f00562..c42b34a 100644
--- a/block/io.c
+++ b/block/io.c
@@ -228,9 +228,7 @@ void bdrv_drained_begin(BlockDriverState *bs)
         bdrv_parent_drained_begin(bs);
     }
 
-    bdrv_io_unplugged_begin(bs);
     bdrv_drain_recurse(bs);
-    bdrv_io_unplugged_end(bs);
 }
 
 void bdrv_drained_end(BlockDriverState *bs)
@@ -302,7 +300,6 @@ void bdrv_drain_all_begin(void)
 
         aio_context_acquire(aio_context);
         bdrv_parent_drained_begin(bs);
-        bdrv_io_unplugged_begin(bs);
         aio_disable_external(aio_context);
         aio_context_release(aio_context);
 
@@ -347,7 +344,6 @@ void bdrv_drain_all_end(void)
 
         aio_context_acquire(aio_context);
         aio_enable_external(aio_context);
-        bdrv_io_unplugged_end(bs);
         bdrv_parent_drained_end(bs);
         aio_context_release(aio_context);
     }
@@ -2650,7 +2646,7 @@ void bdrv_io_plug(BlockDriverState *bs)
         bdrv_io_plug(child->bs);
     }
 
-    if (bs->io_plugged++ == 0 && bs->io_plug_disabled == 0) {
+    if (bs->io_plugged++ == 0) {
         BlockDriver *drv = bs->drv;
         if (drv && drv->bdrv_io_plug) {
             drv->bdrv_io_plug(bs);
@@ -2663,7 +2659,7 @@ void bdrv_io_unplug(BlockDriverState *bs)
     BdrvChild *child;
 
     assert(bs->io_plugged);
-    if (--bs->io_plugged == 0 && bs->io_plug_disabled == 0) {
+    if (--bs->io_plugged == 0) {
         BlockDriver *drv = bs->drv;
         if (drv && drv->bdrv_io_unplug) {
             drv->bdrv_io_unplug(bs);
@@ -2674,36 +2670,3 @@ void bdrv_io_unplug(BlockDriverState *bs)
         bdrv_io_unplug(child->bs);
     }
 }
-
-void bdrv_io_unplugged_begin(BlockDriverState *bs)
-{
-    BdrvChild *child;
-
-    if (bs->io_plug_disabled++ == 0 && bs->io_plugged > 0) {
-        BlockDriver *drv = bs->drv;
-        if (drv && drv->bdrv_io_unplug) {
-            drv->bdrv_io_unplug(bs);
-        }
-    }
-
-    QLIST_FOREACH(child, &bs->children, next) {
-        bdrv_io_unplugged_begin(child->bs);
-    }
-}
-
-void bdrv_io_unplugged_end(BlockDriverState *bs)
-{
-    BdrvChild *child;
-
-    assert(bs->io_plug_disabled);
-    QLIST_FOREACH(child, &bs->children, next) {
-        bdrv_io_unplugged_end(child->bs);
-    }
-
-    if (--bs->io_plug_disabled == 0 && bs->io_plugged > 0) {
-        BlockDriver *drv = bs->drv;
-        if (drv && drv->bdrv_io_plug) {
-            drv->bdrv_io_plug(bs);
-        }
-    }
-}
-- 
2.9.3
