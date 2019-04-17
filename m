Received: from eggs.gnu.org ([209.51.188.92]:44212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hGhVX-00038M-Rg
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 06:09:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hGhVW-0003tq-Oa
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 06:09:35 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 17 Apr 2019 13:09:28 +0300
Message-Id: <20190417100929.39943-2-vsementsov@virtuozzo.com>
In-Reply-To: <20190417100929.39943-1-vsementsov@virtuozzo.com>
References: <20190417100929.39943-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 1/2] block/io: bdrv_pdiscard: support int64_t
 bytes parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, fam@euphon.net, stefanha@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com

This fixes at least one overflow in qcow2_process_discards.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block.h |  4 ++--
 block/io.c            | 19 ++++++++++---------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index c7a26199aa..69fa18867e 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -432,8 +432,8 @@ void bdrv_drain_all(void);
     AIO_WAIT_WHILE(bdrv_get_aio_context(bs_),              \
                    cond); })
 
-int bdrv_pdiscard(BdrvChild *child, int64_t offset, int bytes);
-int bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int bytes);
+int bdrv_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes);
+int bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes);
 int bdrv_has_zero_init_1(BlockDriverState *bs);
 int bdrv_has_zero_init(BlockDriverState *bs);
 bool bdrv_unallocated_blocks_are_zero(BlockDriverState *bs);
diff --git a/block/io.c b/block/io.c
index dfc153b8d8..c6429380e8 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2653,7 +2653,7 @@ int bdrv_flush(BlockDriverState *bs)
 typedef struct DiscardCo {
     BdrvChild *child;
     int64_t offset;
-    int bytes;
+    int64_t bytes;
     int ret;
 } DiscardCo;
 static void coroutine_fn bdrv_pdiscard_co_entry(void *opaque)
@@ -2664,14 +2664,15 @@ static void coroutine_fn bdrv_pdiscard_co_entry(void *opaque)
     aio_wait_kick();
 }
 
-int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int bytes)
+int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset,
+                                  int64_t bytes)
 {
     BdrvTrackedRequest req;
     int max_pdiscard, ret;
     int head, tail, align;
     BlockDriverState *bs = child->bs;
 
-    if (!bs || !bs->drv) {
+    if (!bs || !bs->drv || !bdrv_is_inserted(bs)) {
         return -ENOMEDIUM;
     }
 
@@ -2679,9 +2680,8 @@ int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int bytes)
         return -EPERM;
     }
 
-    ret = bdrv_check_byte_request(bs, offset, bytes);
-    if (ret < 0) {
-        return ret;
+    if (offset < 0) {
+        return -EIO;
     }
 
     /* Do nothing if disabled.  */
@@ -2711,12 +2711,13 @@ int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int bytes)
         goto out;
     }
 
-    max_pdiscard = QEMU_ALIGN_DOWN(MIN_NON_ZERO(bs->bl.max_pdiscard, INT_MAX),
+    max_pdiscard = QEMU_ALIGN_DOWN(MIN_NON_ZERO(bs->bl.max_pdiscard,
+                                                BDRV_REQUEST_MAX_BYTES),
                                    align);
     assert(max_pdiscard >= bs->bl.request_alignment);
 
     while (bytes > 0) {
-        int num = bytes;
+        int64_t num = bytes;
 
         if (head) {
             /* Make small requests to get to alignment boundaries. */
@@ -2778,7 +2779,7 @@ out:
     return ret;
 }
 
-int bdrv_pdiscard(BdrvChild *child, int64_t offset, int bytes)
+int bdrv_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes)
 {
     Coroutine *co;
     DiscardCo rwco = {
-- 
2.18.0
