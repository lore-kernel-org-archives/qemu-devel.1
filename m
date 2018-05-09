Received: from eggs.gnu.org ([2001:4830:134:3::10]:56649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fGQYF-0006pw-Mp
	for qemu-devel@nongnu.org; Wed, 09 May 2018 10:58:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fGQYE-0006Bs-CM
	for qemu-devel@nongnu.org; Wed, 09 May 2018 10:58:43 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed,  9 May 2018 22:58:07 +0800
Message-Id: <20180509145815.3330-2-famz@redhat.com>
In-Reply-To: <20180509145815.3330-1-famz@redhat.com>
References: <20180509145815.3330-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/9] block: Introduce API for copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/io.c                | 91 +++++++++++++++++++++++++++++++++++++++++++++++
 include/block/block.h     |  4 +++
 include/block/block_int.h | 30 ++++++++++++++++
 3 files changed, 125 insertions(+)

diff --git a/block/io.c b/block/io.c
index bd9a19a9c4..d274e9525f 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2826,3 +2826,94 @@ void bdrv_unregister_buf(BlockDriverState *bs, void *host)
         bdrv_unregister_buf(child->bs, host);
     }
 }
+
+static int bdrv_co_copy_range_internal(BdrvChild *src,
+                                       uint64_t src_offset,
+                                       BdrvChild *dst,
+                                       uint64_t dst_offset,
+                                       uint64_t bytes, BdrvRequestFlags flags,
+                                       bool recurse_src)
+{
+    int ret;
+
+    if (!src || !dst || !src->bs || !dst->bs) {
+        return -ENOMEDIUM;
+    }
+    ret = bdrv_check_byte_request(src->bs, src_offset, bytes);
+    if (ret) {
+        return ret;
+    }
+
+    ret = bdrv_check_byte_request(dst->bs, dst_offset, bytes);
+    if (ret) {
+        return ret;
+    }
+    if (flags & BDRV_REQ_ZERO_WRITE) {
+        return bdrv_co_pwrite_zeroes(dst, dst_offset, bytes, flags);
+    }
+
+    if (!src->bs->drv->bdrv_co_copy_range_from
+        || !dst->bs->drv->bdrv_co_copy_range_to
+        || src->bs->encrypted || dst->bs->encrypted) {
+        return -ENOTSUP;
+    }
+    if (recurse_src) {
+        return src->bs->drv->bdrv_co_copy_range_from(src->bs,
+                                                     src, src_offset,
+                                                     dst, dst_offset,
+                                                     bytes, flags);
+    } else {
+        return dst->bs->drv->bdrv_co_copy_range_to(dst->bs,
+                                                   src, src_offset,
+                                                   dst, dst_offset,
+                                                   bytes, flags);
+    }
+}
+
+/* Copy range from @bs to @dst. */
+int bdrv_co_copy_range_from(BdrvChild *src, uint64_t src_offset,
+                            BdrvChild *dst, uint64_t dst_offset,
+                            uint64_t bytes, BdrvRequestFlags flags)
+{
+    return bdrv_co_copy_range_internal(src, src_offset, dst, dst_offset,
+                                       bytes, flags, true);
+}
+
+/* Copy range from @src to @bs. Should only be called by block drivers when @bs
+ * is the leaf. */
+int bdrv_co_copy_range_to(BdrvChild *src, uint64_t src_offset,
+                          BdrvChild *dst, uint64_t dst_offset,
+                          uint64_t bytes, BdrvRequestFlags flags)
+{
+    return bdrv_co_copy_range_internal(src, src_offset, dst, dst_offset,
+                                       bytes, flags, false);
+}
+
+int bdrv_co_copy_range(BdrvChild *src, uint64_t src_offset,
+                       BdrvChild *dst, uint64_t dst_offset,
+                       uint64_t bytes, BdrvRequestFlags flags)
+{
+    BdrvTrackedRequest src_req, dst_req;
+    BlockDriverState *src_bs = src->bs;
+    BlockDriverState *dst_bs = dst->bs;
+    int ret;
+
+    bdrv_inc_in_flight(src_bs);
+    bdrv_inc_in_flight(dst_bs);
+    tracked_request_begin(&src_req, src_bs, src_offset,
+                          bytes, BDRV_TRACKED_READ);
+    tracked_request_begin(&dst_req, dst_bs, dst_offset,
+                          bytes, BDRV_TRACKED_WRITE);
+
+    wait_serialising_requests(&src_req);
+    wait_serialising_requests(&dst_req);
+    ret = bdrv_co_copy_range_from(src, src_offset,
+                                  dst, dst_offset,
+                                  bytes, flags);
+
+    tracked_request_end(&src_req);
+    tracked_request_end(&dst_req);
+    bdrv_dec_in_flight(src_bs);
+    bdrv_dec_in_flight(dst_bs);
+    return ret;
+}
diff --git a/include/block/block.h b/include/block/block.h
index cdec3639a3..72ac011b2b 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -604,4 +604,8 @@ bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
  */
 void bdrv_register_buf(BlockDriverState *bs, void *host, size_t size);
 void bdrv_unregister_buf(BlockDriverState *bs, void *host);
+
+int bdrv_co_copy_range(BdrvChild *bs, uint64_t offset,
+                       BdrvChild *src, uint64_t src_offset,
+                       uint64_t bytes, BdrvRequestFlags flags);
 #endif
diff --git a/include/block/block_int.h b/include/block/block_int.h
index c4dd1d4bb8..305c29b75e 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -206,6 +206,29 @@ struct BlockDriver {
     int coroutine_fn (*bdrv_co_pdiscard)(BlockDriverState *bs,
         int64_t offset, int bytes);
 
+    /* Map [offset, offset + nbytes) range onto a child of @bs to copy from,
+     * and invoke bdrv_co_copy_range_from(child, ...), or invoke
+     * bdrv_co_copy_range_to() if @bs is the leaf child to copy data from.
+     */
+    int coroutine_fn (*bdrv_co_copy_range_from)(BlockDriverState *bs,
+                                                BdrvChild *src,
+                                                uint64_t offset,
+                                                BdrvChild *dst,
+                                                uint64_t dst_offset,
+                                                uint64_t bytes, BdrvRequestFlags flags);
+
+    /* Map [offset, offset + nbytes) range onto a child of bs to copy data to,
+     * and invoke bdrv_co_copy_range_to(child, src, ...), or perform the copy
+     * operation if @bs is the leaf and @src has the same BlockDriver.  Return
+     * -ENOTSUP if @bs is the leaf but @src has a different BlockDriver.
+     */
+    int coroutine_fn (*bdrv_co_copy_range_to)(BlockDriverState *bs,
+                                              BdrvChild *src,
+                                              uint64_t src_offset,
+                                              BdrvChild *dst,
+                                              uint64_t dst_offset,
+                                              uint64_t bytes, BdrvRequestFlags flags);
+
     /*
      * Building block for bdrv_block_status[_above] and
      * bdrv_is_allocated[_above].  The driver should answer only
@@ -1090,4 +1113,11 @@ void bdrv_dec_in_flight(BlockDriverState *bs);
 
 void blockdev_close_all_bdrv_states(void);
 
+int bdrv_co_copy_range_from(BdrvChild *src, uint64_t src_offset,
+                            BdrvChild *dst, uint64_t dst_offset,
+                            uint64_t bytes, BdrvRequestFlags flags);
+int bdrv_co_copy_range_to(BdrvChild *src, uint64_t src_offset,
+                            BdrvChild *dst, uint64_t dst_offset,
+                            uint64_t bytes, BdrvRequestFlags flags);
+
 #endif /* BLOCK_INT_H */
-- 
2.14.3
