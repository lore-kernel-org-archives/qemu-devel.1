Received: from eggs.gnu.org ([2001:4830:134:3::10]:49572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYu6S-0003vA-0C
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:10:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYu6Q-0003ue-5N
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:10:23 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 29 Jun 2018 16:09:43 +0200
Message-Id: <20180629140959.6690-14-kwolf@redhat.com>
In-Reply-To: <20180629140959.6690-1-kwolf@redhat.com>
References: <20180629140959.6690-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 13/29] block: Move request tracking to children
 in copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

in_flight and tracked requests need to be tracked in every layer during
recursion. For now the only user is qemu-img convert where overlapping
requests and IOThreads don't exist, therefore this change doesn't make
much difference form user point of view, but it is incorrect as part of
the API. Fix it.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 59 ++++++++++++++++++++++++++++-------------------------------
 1 file changed, 28 insertions(+), 31 deletions(-)

diff --git a/block/io.c b/block/io.c
index 01a3c4eac5..b63822280a 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2932,6 +2932,9 @@ static int coroutine_fn bdrv_co_copy_range_internal(BdrvChild *src,
                                                     BdrvRequestFlags flags,
                                                     bool recurse_src)
 {
+    BdrvTrackedRequest src_req, dst_req;
+    BlockDriverState *src_bs = src->bs;
+    BlockDriverState *dst_bs = dst->bs;
     int ret;
 
     if (!src || !dst || !src->bs || !dst->bs) {
@@ -2955,17 +2958,31 @@ static int coroutine_fn bdrv_co_copy_range_internal(BdrvChild *src,
         || src->bs->encrypted || dst->bs->encrypted) {
         return -ENOTSUP;
     }
+    bdrv_inc_in_flight(src_bs);
+    bdrv_inc_in_flight(dst_bs);
+    tracked_request_begin(&src_req, src_bs, src_offset,
+                          bytes, BDRV_TRACKED_READ);
+    tracked_request_begin(&dst_req, dst_bs, dst_offset,
+                          bytes, BDRV_TRACKED_WRITE);
+
+    wait_serialising_requests(&src_req);
+    wait_serialising_requests(&dst_req);
     if (recurse_src) {
-        return src->bs->drv->bdrv_co_copy_range_from(src->bs,
-                                                     src, src_offset,
-                                                     dst, dst_offset,
-                                                     bytes, flags);
+        ret = src->bs->drv->bdrv_co_copy_range_from(src->bs,
+                                                    src, src_offset,
+                                                    dst, dst_offset,
+                                                    bytes, flags);
     } else {
-        return dst->bs->drv->bdrv_co_copy_range_to(dst->bs,
-                                                   src, src_offset,
-                                                   dst, dst_offset,
-                                                   bytes, flags);
+        ret = dst->bs->drv->bdrv_co_copy_range_to(dst->bs,
+                                                  src, src_offset,
+                                                  dst, dst_offset,
+                                                  bytes, flags);
     }
+    tracked_request_end(&src_req);
+    tracked_request_end(&dst_req);
+    bdrv_dec_in_flight(src_bs);
+    bdrv_dec_in_flight(dst_bs);
+    return ret;
 }
 
 /* Copy range from @src to @dst.
@@ -2996,29 +3013,9 @@ int coroutine_fn bdrv_co_copy_range(BdrvChild *src, uint64_t src_offset,
                                     BdrvChild *dst, uint64_t dst_offset,
                                     uint64_t bytes, BdrvRequestFlags flags)
 {
-    BdrvTrackedRequest src_req, dst_req;
-    BlockDriverState *src_bs = src->bs;
-    BlockDriverState *dst_bs = dst->bs;
-    int ret;
-
-    bdrv_inc_in_flight(src_bs);
-    bdrv_inc_in_flight(dst_bs);
-    tracked_request_begin(&src_req, src_bs, src_offset,
-                          bytes, BDRV_TRACKED_READ);
-    tracked_request_begin(&dst_req, dst_bs, dst_offset,
-                          bytes, BDRV_TRACKED_WRITE);
-
-    wait_serialising_requests(&src_req);
-    wait_serialising_requests(&dst_req);
-    ret = bdrv_co_copy_range_from(src, src_offset,
-                                  dst, dst_offset,
-                                  bytes, flags);
-
-    tracked_request_end(&src_req);
-    tracked_request_end(&dst_req);
-    bdrv_dec_in_flight(src_bs);
-    bdrv_dec_in_flight(dst_bs);
-    return ret;
+    return bdrv_co_copy_range_from(src, src_offset,
+                                   dst, dst_offset,
+                                   bytes, flags);
 }
 
 static void bdrv_parent_cb_resize(BlockDriverState *bs)
-- 
2.13.6
