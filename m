Received: from eggs.gnu.org ([2001:4830:134:3::10]:57697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e30LP-0007oO-6D
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 09:49:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e30LO-0006Tb-4W
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 09:49:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1e30LN-0006T2-S9
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 09:49:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 13 Oct 2017 14:49:29 +0100
Message-Id: <20171013134930.20200-3-stefanha@redhat.com>
In-Reply-To: <20171013134930.20200-1-stefanha@redhat.com>
References: <20171013134930.20200-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] block: rename bdrv_co_drain to
 bdrv_co_drain_begin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Manos Pitsidianakis <el13635@mail.ntua.gr>, Stefan Hajnoczi <stefanha@redhat.com>

From: Manos Pitsidianakis <el13635@mail.ntua.gr>

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/block_int.h | 4 ++--
 block/io.c                | 4 ++--
 block/qed.c               | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index dd62f4d083..885c08e989 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -354,7 +354,7 @@ struct BlockDriver {
     int (*bdrv_probe_geometry)(BlockDriverState *bs, HDGeometry *geo);
 
     /**
-     * bdrv_co_drain is called if implemented in the beginning of a
+     * bdrv_co_drain_begin is called if implemented in the beginning of a
      * drain operation to drain and stop any internal sources of requests in
      * the driver.
      * bdrv_co_drain_end is called if implemented at the end of the drain.
@@ -363,7 +363,7 @@ struct BlockDriver {
      * requests, or toggle an internal state. After the end of the drain new
      * requests will continue normally.
      */
-    void coroutine_fn (*bdrv_co_drain)(BlockDriverState *bs);
+    void coroutine_fn (*bdrv_co_drain_begin)(BlockDriverState *bs);
     void coroutine_fn (*bdrv_co_drain_end)(BlockDriverState *bs);
 
     void (*bdrv_add_child)(BlockDriverState *parent, BlockDriverState *child,
diff --git a/block/io.c b/block/io.c
index 342fb571cf..0854e0fdac 100644
--- a/block/io.c
+++ b/block/io.c
@@ -165,7 +165,7 @@ static void coroutine_fn bdrv_drain_invoke_entry(void *opaque)
     BlockDriverState *bs = data->bs;
 
     if (data->begin) {
-        bs->drv->bdrv_co_drain(bs);
+        bs->drv->bdrv_co_drain_begin(bs);
     } else {
         bs->drv->bdrv_co_drain_end(bs);
     }
@@ -179,7 +179,7 @@ static void bdrv_drain_invoke(BlockDriverState *bs, bool begin)
 {
     BdrvCoDrainData data = { .bs = bs, .done = false, .begin = begin};
 
-    if (!bs->drv || (begin && !bs->drv->bdrv_co_drain) ||
+    if (!bs->drv || (begin && !bs->drv->bdrv_co_drain_begin) ||
             (!begin && !bs->drv->bdrv_co_drain_end)) {
         return;
     }
diff --git a/block/qed.c b/block/qed.c
index 28e2ec89e8..821dcaa055 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -265,7 +265,7 @@ static bool qed_plug_allocating_write_reqs(BDRVQEDState *s)
     assert(!s->allocating_write_reqs_plugged);
     if (s->allocating_acb != NULL) {
         /* Another allocating write came concurrently.  This cannot happen
-         * from bdrv_qed_co_drain, but it can happen when the timer runs.
+         * from bdrv_qed_co_drain_begin, but it can happen when the timer runs.
          */
         qemu_co_mutex_unlock(&s->table_lock);
         return false;
@@ -358,7 +358,7 @@ static void bdrv_qed_attach_aio_context(BlockDriverState *bs,
     }
 }
 
-static void coroutine_fn bdrv_qed_co_drain(BlockDriverState *bs)
+static void coroutine_fn bdrv_qed_co_drain_begin(BlockDriverState *bs)
 {
     BDRVQEDState *s = bs->opaque;
 
@@ -1608,7 +1608,7 @@ static BlockDriver bdrv_qed = {
     .bdrv_check               = bdrv_qed_check,
     .bdrv_detach_aio_context  = bdrv_qed_detach_aio_context,
     .bdrv_attach_aio_context  = bdrv_qed_attach_aio_context,
-    .bdrv_co_drain            = bdrv_qed_co_drain,
+    .bdrv_co_drain_begin      = bdrv_qed_co_drain_begin,
 };
 
 static void bdrv_qed_init(void)
-- 
2.13.6
