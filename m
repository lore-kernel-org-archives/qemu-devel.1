Received: from eggs.gnu.org ([2001:4830:134:3::10]:50384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fcmCf-00024c-GF
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 02:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fcmCe-0007yi-OD
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 02:32:49 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 10 Jul 2018 14:31:22 +0800
Message-Id: <20180710063124.2263-9-famz@redhat.com>
In-Reply-To: <20180710063124.2263-1-famz@redhat.com>
References: <20180710063124.2263-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 08/10] block: Use common req handling in
 copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This brings the request handling logic inline with write and discard,
fixing write_gen, resize_cb, dirty bitmaps and image size refreshing.
The last of these issues broke iotest case 222, which is now fixed.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/io.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/block/io.c b/block/io.c
index cc426bab2e..9687da1ce9 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3007,20 +3007,16 @@ static int coroutine_fn bdrv_co_copy_range_internal(
         bdrv_inc_in_flight(dst->bs);
         tracked_request_begin(&req, dst->bs, dst_offset, bytes,
                               BDRV_TRACKED_WRITE);
-
-        /* BDRV_REQ_NO_SERIALISING is only for read operation */
-        assert(!(write_flags & BDRV_REQ_NO_SERIALISING));
-        if (write_flags & BDRV_REQ_SERIALISING) {
-            mark_request_serialising(&req, bdrv_get_cluster_size(dst->bs));
+        ret = bdrv_co_write_req_prepare(dst, dst_offset, bytes, &req,
+                                        write_flags);
+        if (!ret) {
+            ret = dst->bs->drv->bdrv_co_copy_range_to(dst->bs,
+                                                      src, src_offset,
+                                                      dst, dst_offset,
+                                                      bytes,
+                                                      read_flags, write_flags);
         }
-        wait_serialising_requests(&req);
-
-        ret = dst->bs->drv->bdrv_co_copy_range_to(dst->bs,
-                                                  src, src_offset,
-                                                  dst, dst_offset,
-                                                  bytes,
-                                                  read_flags, write_flags);
-
+        bdrv_co_write_req_finish(dst, dst_offset, bytes, &req, ret);
         tracked_request_end(&req);
         bdrv_dec_in_flight(dst->bs);
     }
-- 
2.17.1
