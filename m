Received: from eggs.gnu.org ([2001:4830:134:3::10]:35775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1faBCp-0005JG-Ey
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:38:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1faBCo-0008DY-Ir
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:38:15 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue,  3 Jul 2018 10:37:56 +0800
Message-Id: <20180703023758.14422-2-famz@redhat.com>
In-Reply-To: <20180703023758.14422-1-famz@redhat.com>
References: <20180703023758.14422-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 1/3] block: Fix parameter checking in
 bdrv_co_copy_range_internal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>

src may be NULL if BDRV_REQ_ZERO_WRITE flag is set, in this case only
check dst and dst->bs. This bug was introduced when moving in the
request tracking code from bdrv_co_copy_range, in 37aec7d75eb.

This especially fixes the possible segfault when initializing src_bs
with a NULL src.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/io.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/block/io.c b/block/io.c
index 7035b78a20..b8845708d7 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2897,18 +2897,11 @@ static int coroutine_fn bdrv_co_copy_range_internal(BdrvChild *src,
                                                     bool recurse_src)
 {
     BdrvTrackedRequest src_req, dst_req;
-    BlockDriverState *src_bs = src->bs;
-    BlockDriverState *dst_bs = dst->bs;
     int ret;
 
-    if (!src || !dst || !src->bs || !dst->bs) {
+    if (!dst || !dst->bs) {
         return -ENOMEDIUM;
     }
-    ret = bdrv_check_byte_request(src->bs, src_offset, bytes);
-    if (ret) {
-        return ret;
-    }
-
     ret = bdrv_check_byte_request(dst->bs, dst_offset, bytes);
     if (ret) {
         return ret;
@@ -2917,16 +2910,24 @@ static int coroutine_fn bdrv_co_copy_range_internal(BdrvChild *src,
         return bdrv_co_pwrite_zeroes(dst, dst_offset, bytes, flags);
     }
 
+    if (!src || !src->bs) {
+        return -ENOMEDIUM;
+    }
+    ret = bdrv_check_byte_request(src->bs, src_offset, bytes);
+    if (ret) {
+        return ret;
+    }
+
     if (!src->bs->drv->bdrv_co_copy_range_from
         || !dst->bs->drv->bdrv_co_copy_range_to
         || src->bs->encrypted || dst->bs->encrypted) {
         return -ENOTSUP;
     }
-    bdrv_inc_in_flight(src_bs);
-    bdrv_inc_in_flight(dst_bs);
-    tracked_request_begin(&src_req, src_bs, src_offset,
+    bdrv_inc_in_flight(src->bs);
+    bdrv_inc_in_flight(dst->bs);
+    tracked_request_begin(&src_req, src->bs, src_offset,
                           bytes, BDRV_TRACKED_READ);
-    tracked_request_begin(&dst_req, dst_bs, dst_offset,
+    tracked_request_begin(&dst_req, dst->bs, dst_offset,
                           bytes, BDRV_TRACKED_WRITE);
 
     wait_serialising_requests(&src_req);
@@ -2944,8 +2945,8 @@ static int coroutine_fn bdrv_co_copy_range_internal(BdrvChild *src,
     }
     tracked_request_end(&src_req);
     tracked_request_end(&dst_req);
-    bdrv_dec_in_flight(src_bs);
-    bdrv_dec_in_flight(dst_bs);
+    bdrv_dec_in_flight(src->bs);
+    bdrv_dec_in_flight(dst->bs);
     return ret;
 }
 
-- 
2.17.1
