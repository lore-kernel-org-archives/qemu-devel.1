Received: from eggs.gnu.org ([2001:4830:134:3::10]:57850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fcZAH-0002bq-7J
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 12:37:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fcZAB-0002cr-AP
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 12:37:29 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon,  9 Jul 2018 19:37:16 +0300
Message-Id: <20180709163719.87107-2-vsementsov@virtuozzo.com>
In-Reply-To: <20180709163719.87107-1-vsementsov@virtuozzo.com>
References: <20180709163719.87107-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v5 1/4] block/io: fix copy_range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pl@kamp.de, pbonzini@redhat.com, ronniesahlberg@gmail.com, famz@redhat.com, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, jsnow@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Here two things are fixed:

1. Architecture

On each recursion step, we go to the child of src or dst, only for one
of them. So, it's wrong to create tracked requests for both on each
step. It leads to tracked requests duplication.

2. Wait for serializing requests on write path independently of
   BDRV_REQ_NO_SERIALISING

Before commit 9ded4a01149 "backup: Use copy offloading",
BDRV_REQ_NO_SERIALISING was used for only one case: read in
copy-on-write operation during backup. Also, the flag was handled only
on read path (in bdrv_co_preadv and bdrv_aligned_preadv).

After 9ded4a01149, flag is used for not waiting serializing operations
on backup target (in same case of copy-on-write operation). This
behavior change is unsubstantiated and potentially dangerous, let's
drop it and add additional asserts and documentation.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block.h | 11 +++++++++++
 block/io.c            | 42 +++++++++++++++++++++++++++---------------
 2 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index bc76b1e59f..5320f82ac9 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -50,6 +50,17 @@ typedef enum {
      * opened with BDRV_O_UNMAP.
      */
     BDRV_REQ_MAY_UNMAP          = 0x4,
+
+    /* The BDRV_REQ_NO_SERIALISING flag is only valid for reads and means that
+     * we don't want wait_serialising_requests() during read operation.
+     *
+     * This flag is used for backup copy on write operation, when we need to
+     * read old data before write (write notifier triggered). It is okay since
+     * we already waited for other serializing requests in the initiating write
+     * (see bdrv_aligned_pwritev), and it is necessary if the initiating write
+     * is already serializing (without the flag, the read would deadlock
+     * waiting for the serialising write to complete).
+     */
     BDRV_REQ_NO_SERIALISING     = 0x8,
     BDRV_REQ_FUA                = 0x10,
     BDRV_REQ_WRITE_COMPRESSED   = 0x20,
diff --git a/block/io.c b/block/io.c
index 1a2272fad3..94b6ec94e2 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1572,6 +1572,8 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     max_transfer = QEMU_ALIGN_DOWN(MIN_NON_ZERO(bs->bl.max_transfer, INT_MAX),
                                    align);
 
+    /* BDRV_REQ_NO_SERIALISING is only for read operation */
+    assert(!(flags & BDRV_REQ_NO_SERIALISING));
     waited = wait_serialising_requests(req);
     assert(!waited || !req->serialising);
     assert(req->overlap_offset <= offset);
@@ -2896,7 +2898,7 @@ static int coroutine_fn bdrv_co_copy_range_internal(BdrvChild *src,
                                                     BdrvRequestFlags flags,
                                                     bool recurse_src)
 {
-    BdrvTrackedRequest src_req, dst_req;
+    BdrvTrackedRequest req;
     int ret;
 
     if (!dst || !dst->bs) {
@@ -2923,32 +2925,42 @@ static int coroutine_fn bdrv_co_copy_range_internal(BdrvChild *src,
         || src->bs->encrypted || dst->bs->encrypted) {
         return -ENOTSUP;
     }
-    bdrv_inc_in_flight(src->bs);
-    bdrv_inc_in_flight(dst->bs);
-    tracked_request_begin(&src_req, src->bs, src_offset,
-                          bytes, BDRV_TRACKED_READ);
-    tracked_request_begin(&dst_req, dst->bs, dst_offset,
-                          bytes, BDRV_TRACKED_WRITE);
 
-    if (!(flags & BDRV_REQ_NO_SERIALISING)) {
-        wait_serialising_requests(&src_req);
-        wait_serialising_requests(&dst_req);
-    }
     if (recurse_src) {
+        bdrv_inc_in_flight(src->bs);
+        tracked_request_begin(&req, src->bs, src_offset, bytes,
+                              BDRV_TRACKED_READ);
+
+        if (!(flags & BDRV_REQ_NO_SERIALISING)) {
+            wait_serialising_requests(&req);
+        }
+
         ret = src->bs->drv->bdrv_co_copy_range_from(src->bs,
                                                     src, src_offset,
                                                     dst, dst_offset,
                                                     bytes, flags);
+
+        tracked_request_end(&req);
+        bdrv_dec_in_flight(src->bs);
     } else {
+        bdrv_inc_in_flight(dst->bs);
+        tracked_request_begin(&req, dst->bs, dst_offset, bytes,
+                              BDRV_TRACKED_WRITE);
+
+        /* BDRV_REQ_NO_SERIALISING is only for read operation,
+         * so we ignore it in flags.
+         */
+        wait_serialising_requests(&req);
+
         ret = dst->bs->drv->bdrv_co_copy_range_to(dst->bs,
                                                   src, src_offset,
                                                   dst, dst_offset,
                                                   bytes, flags);
+
+        tracked_request_end(&req);
+        bdrv_dec_in_flight(dst->bs);
     }
-    tracked_request_end(&src_req);
-    tracked_request_end(&dst_req);
-    bdrv_dec_in_flight(src->bs);
-    bdrv_dec_in_flight(dst->bs);
+
     return ret;
 }
 
-- 
2.11.1
