Received: from eggs.gnu.org ([2001:4830:134:3::10]:44596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcunn-0005N6-5t
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:43:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcunm-0001m5-B1
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:43:43 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 10 Jul 2018 17:43:02 +0200
Message-Id: <20180710154304.18304-23-kwolf@redhat.com>
In-Reply-To: <20180710154304.18304-1-kwolf@redhat.com>
References: <20180710154304.18304-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 22/24] block: Use common req handling in copy
 offloading
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

This brings the request handling logic inline with write and discard,
fixing write_gen, resize_cb, dirty bitmaps and image size refreshing.
The last of these issues broke iotest case 222, which is now fixed.

Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/block/io.c b/block/io.c
index 72cfd9bd16..2832214db4 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3030,20 +3030,16 @@ static int coroutine_fn bdrv_co_copy_range_internal(
         bdrv_inc_in_flight(dst->bs);
         tracked_request_begin(&req, dst->bs, dst_offset, bytes,
                               BDRV_TRACKED_WRITE);
-
-        /* BDRV_REQ_NO_SERIALISING is only for read operation */
-        assert(!(write_flags & BDRV_REQ_NO_SERIALISING));
-        if (write_flags & BDRV_REQ_SERIALISING) {
-            mark_request_serialising(&req, bdrv_get_cluster_size(dst->bs));
-        }
-        wait_serialising_requests(&req);
-
-        ret = dst->bs->drv->bdrv_co_copy_range_to(dst->bs,
-                                                  src, src_offset,
-                                                  dst, dst_offset,
-                                                  bytes,
-                                                  read_flags, write_flags);
-
+        ret = bdrv_co_write_req_prepare(dst, dst_offset, bytes, &req,
+                                        write_flags);
+        if (!ret) {
+            ret = dst->bs->drv->bdrv_co_copy_range_to(dst->bs,
+                                                      src, src_offset,
+                                                      dst, dst_offset,
+                                                      bytes,
+                                                      read_flags, write_flags);
+        }
+        bdrv_co_write_req_finish(dst, dst_offset, bytes, &req, ret);
         tracked_request_end(&req);
         bdrv_dec_in_flight(dst->bs);
     }
-- 
2.13.6
