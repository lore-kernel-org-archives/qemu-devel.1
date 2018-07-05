Received: from eggs.gnu.org ([2001:4830:134:3::10]:53420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fayq1-0001pp-PE
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 03:38:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fayq0-0001oQ-UZ
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 03:38:01 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu,  5 Jul 2018 15:36:59 +0800
Message-Id: <20180705073701.10558-8-famz@redhat.com>
In-Reply-To: <20180705073701.10558-1-famz@redhat.com>
References: <20180705073701.10558-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 7/9] block: Use common req handling in copy
 offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This brings the request handling logic inline with write and discard,
fixing write_gen, resize_cb, dirty bitmaps and image size refreshing.
The last of these issues broke iotest case 222, which is now fixed.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/io.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index 912fcb962a..d07849fa96 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2962,7 +2962,11 @@ static int coroutine_fn bdrv_co_copy_range_internal(BdrvChild *src,
 
     if (!(flags & BDRV_REQ_NO_SERIALISING)) {
         wait_serialising_requests(&src_req);
-        wait_serialising_requests(&dst_req);
+    }
+
+    ret = bdrv_co_write_req_prepare(dst, &dst_req, flags);
+    if (ret) {
+        goto out;
     }
     if (recurse_src) {
         ret = src->bs->drv->bdrv_co_copy_range_from(src->bs,
@@ -2975,6 +2979,8 @@ static int coroutine_fn bdrv_co_copy_range_internal(BdrvChild *src,
                                                   dst, dst_offset,
                                                   bytes, flags);
     }
+out:
+    bdrv_co_write_req_finish(dst, &dst_req, ret);
     tracked_request_end(&src_req);
     tracked_request_end(&dst_req);
     bdrv_dec_in_flight(src->bs);
-- 
2.17.1
