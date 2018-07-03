Received: from eggs.gnu.org ([2001:4830:134:3::10]:49285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1faCHe-0004Tu-Dg
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 23:47:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1faCHd-0001nC-HN
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 23:47:18 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Mon,  2 Jul 2018 23:46:54 -0400
Message-Id: <20180703034655.792039-3-jcody@redhat.com>
In-Reply-To: <20180703034655.792039-1-jcody@redhat.com>
References: <20180703034655.792039-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] block: Honour BDRV_REQ_NO_SERIALISING in
 copy range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Fam Zheng <famz@redhat.com>

This semantics is needed by drive-backup so implement it before using
this API there.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
Message-id: 20180703023758.14422-3-famz@redhat.com
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/io.c            | 6 ++++--
 include/block/block.h | 5 +++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/io.c b/block/io.c
index b8845708d7..1a2272fad3 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2930,8 +2930,10 @@ static int coroutine_fn bdrv_co_copy_range_internal(BdrvChild *src,
     tracked_request_begin(&dst_req, dst->bs, dst_offset,
                           bytes, BDRV_TRACKED_WRITE);
 
-    wait_serialising_requests(&src_req);
-    wait_serialising_requests(&dst_req);
+    if (!(flags & BDRV_REQ_NO_SERIALISING)) {
+        wait_serialising_requests(&src_req);
+        wait_serialising_requests(&dst_req);
+    }
     if (recurse_src) {
         ret = src->bs->drv->bdrv_co_copy_range_from(src->bs,
                                                     src, src_offset,
diff --git a/include/block/block.h b/include/block/block.h
index 2ffc1c64c6..e5c7759a0c 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -659,13 +659,14 @@ void bdrv_unregister_buf(BlockDriverState *bs, void *host);
  * @dst: Destination child to copy data to
  * @dst_offset: offset in @dst image to write data
  * @bytes: number of bytes to copy
- * @flags: request flags. Must be one of:
- *         0 - actually read data from src;
+ * @flags: request flags. Supported flags:
  *         BDRV_REQ_ZERO_WRITE - treat the @src range as zero data and do zero
  *                               write on @dst as if bdrv_co_pwrite_zeroes is
  *                               called. Used to simplify caller code, or
  *                               during BlockDriver.bdrv_co_copy_range_from()
  *                               recursion.
+ *         BDRV_REQ_NO_SERIALISING - do not serialize with other overlapping
+ *                                   requests currently in flight.
  *
  * Returns: 0 if succeeded; negative error code if failed.
  **/
-- 
2.17.1
