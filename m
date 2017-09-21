Received: from eggs.gnu.org ([2001:4830:134:3::10]:56359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dv1Mo-000580-Qu
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:18:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dv1Mn-00049c-CO
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:18:10 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Thu, 21 Sep 2017 16:17:06 +0300
Message-Id: <20170921131707.17364-3-el13635@mail.ntua.gr>
In-Reply-To: <20170921131707.17364-1-el13635@mail.ntua.gr>
References: <20170921131707.17364-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH v2 2/3] block: rename bdrv_co_drain to
 bdrv_co_drain_begin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 include/block/block_int.h | 2 +-
 block/io.c                | 4 ++--
 block/qed.c               | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 21950cfda3..205d088271 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -362,7 +362,7 @@ struct BlockDriver {
      * manage scheduled I/O requests, or toggle an internal state. After an
      * bdrv_co_drain_end() invocation new requests will continue normally.
      */
-    void coroutine_fn (*bdrv_co_drain)(BlockDriverState *bs);
+    void coroutine_fn (*bdrv_co_drain_begin)(BlockDriverState *bs);
     void coroutine_fn (*bdrv_co_drain_end)(BlockDriverState *bs);
 
     void (*bdrv_add_child)(BlockDriverState *parent, BlockDriverState *child,
diff --git a/block/io.c b/block/io.c
index b0a10ad3ef..65e8094d7c 100644
--- a/block/io.c
+++ b/block/io.c
@@ -162,7 +162,7 @@ static void coroutine_fn bdrv_drain_invoke_entry(void *opaque)
     BlockDriverState *bs = data->bs;
 
     if (data->begin) {
-        bs->drv->bdrv_co_drain(bs);
+        bs->drv->bdrv_co_drain_begin(bs);
     } else {
         bs->drv->bdrv_co_drain_end(bs);
     }
@@ -176,7 +176,7 @@ static void bdrv_drain_invoke(BlockDriverState *bs, bool begin)
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
2.11.0
