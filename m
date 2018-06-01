Received: from eggs.gnu.org ([2001:4830:134:3::10]:55539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fOgL0-00063a-HQ
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:27:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fOgKz-0007P3-0n
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:27:10 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  1 Jun 2018 17:26:39 +0800
Message-Id: <20180601092648.24614-2-famz@redhat.com>
In-Reply-To: <20180601092648.24614-1-famz@redhat.com>
References: <20180601092648.24614-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v9 01/10] block: Introduce API for copy
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, eblake@redhat.com

Introduce the bdrv_co_copy_range() API for copy offloading.  Block
drivers implementing this API support efficient copy operations that
avoid reading each block from the source device and writing it to the
destination devices.  Examples of copy offload primitives are SCSI
EXTENDED COPY and Linux copy_file_range(2).

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io.c                | 97 +++++++++++++++++++++++++++++++++++++++
 include/block/block.h     | 32 +++++++++++++
 include/block/block_int.h | 38 +++++++++++++++
 3 files changed, 167 insertions(+)

diff --git a/block/io.c b/block/io.c
index ca96b487eb..b7beaeeb9f 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2835,3 +2835,100 @@ void bdrv_unregister_buf(BlockDriverState *bs, void *host)
         bdrv_unregister_buf(child->bs, host);
     }
 }
+
+static int coroutine_fn bdrv_co_copy_range_internal(BdrvChild *src,
+                                                    uint64_t src_offset,
+                                                    BdrvChild *dst,
+                                                    uint64_t dst_offset,
+                                                    uint64_t bytes,
+                                                    BdrvRequestFlags flags,
+                                                    bool recurse_src)
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
+/* Copy range from @src to @dst.
+ *
+ * See the comment of bdrv_co_copy_range for the parameter and return value
+ * semantics. */
+int coroutine_fn bdrv_co_copy_range_from(BdrvChild *src, uint64_t src_offset,
+                                         BdrvChild *dst, uint64_t dst_offset,
+                                         uint64_t bytes, BdrvRequestFlags flags)
+{
+    return bdrv_co_copy_range_internal(src, src_offset, dst, dst_offset,
+                                       bytes, flags, true);
+}
+
+/* Copy range from @src to @dst.
+ *
+ * See the comment of bdrv_co_copy_range for the parameter and return value
+ * semantics. */
+int coroutine_fn bdrv_co_copy_range_to(BdrvChild *src, uint64_t src_offset,
+                                       BdrvChild *dst, uint64_t dst_offset,
+                                       uint64_t bytes, BdrvRequestFlags flags)
+{
+    return bdrv_co_copy_range_internal(src, src_offset, dst, dst_offset,
+                                       bytes, flags, false);
+}
+
+int coroutine_fn bdrv_co_copy_range(BdrvChild *src, uint64_t src_offset,
+                                    BdrvChild *dst, uint64_t dst_offset,
+                                    uint64_t bytes, BdrvRequestFlags flags)
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
index 3894edda9d..6cc6c7e699 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -611,4 +611,36 @@ bool bdrv_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
  */
 void bdrv_register_buf(BlockDriverState *bs, void *host, size_t size);
 void bdrv_unregister_buf(BlockDriverState *bs, void *host);
+
+/**
+ *
+ * bdrv_co_copy_range:
+ *
+ * Do offloaded copy between two children. If the operation is not implemented
+ * by the driver, or if the backend storage doesn't support it, a negative
+ * error code will be returned.
+ *
+ * Note: block layer doesn't emulate or fallback to a bounce buffer approach
+ * because usually the caller shouldn't attempt offloaded copy any more (e.g.
+ * calling copy_file_range(2)) after the first error, thus it should fall back
+ * to a read+write path in the caller level.
+ *
+ * @src: Source child to copy data from
+ * @src_offset: offset in @src image to read data
+ * @dst: Destination child to copy data to
+ * @dst_offset: offset in @dst image to write data
+ * @bytes: number of bytes to copy
+ * @flags: request flags. Must be one of:
+ *         0 - actually read data from src;
+ *         BDRV_REQ_ZERO_WRITE - treat the @src range as zero data and do zero
+ *                               write on @dst as if bdrv_co_pwrite_zeroes is
+ *                               called. Used to simplify caller code, or
+ *                               during BlockDriver.bdrv_co_copy_range_from()
+ *                               recursion.
+ *
+ * Returns: 0 if succeeded; negative error code if failed.
+ **/
+int coroutine_fn bdrv_co_copy_range(BdrvChild *src, uint64_t src_offset,
+                                    BdrvChild *dst, uint64_t dst_offset,
+                                    uint64_t bytes, BdrvRequestFlags flags);
 #endif
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 6c0927bce3..888b7f7bff 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -204,6 +204,37 @@ struct BlockDriver {
     int coroutine_fn (*bdrv_co_pdiscard)(BlockDriverState *bs,
         int64_t offset, int bytes);
 
+    /* Map [offset, offset + nbytes) range onto a child of @bs to copy from,
+     * and invoke bdrv_co_copy_range_from(child, ...), or invoke
+     * bdrv_co_copy_range_to() if @bs is the leaf child to copy data from.
+     *
+     * See the comment of bdrv_co_copy_range for the parameter and return value
+     * semantics.
+     */
+    int coroutine_fn (*bdrv_co_copy_range_from)(BlockDriverState *bs,
+                                                BdrvChild *src,
+                                                uint64_t offset,
+                                                BdrvChild *dst,
+                                                uint64_t dst_offset,
+                                                uint64_t bytes,
+                                                BdrvRequestFlags flags);
+
+    /* Map [offset, offset + nbytes) range onto a child of bs to copy data to,
+     * and invoke bdrv_co_copy_range_to(child, src, ...), or perform the copy
+     * operation if @bs is the leaf and @src has the same BlockDriver.  Return
+     * -ENOTSUP if @bs is the leaf but @src has a different BlockDriver.
+     *
+     * See the comment of bdrv_co_copy_range for the parameter and return value
+     * semantics.
+     */
+    int coroutine_fn (*bdrv_co_copy_range_to)(BlockDriverState *bs,
+                                              BdrvChild *src,
+                                              uint64_t src_offset,
+                                              BdrvChild *dst,
+                                              uint64_t dst_offset,
+                                              uint64_t bytes,
+                                              BdrvRequestFlags flags);
+
     /*
      * Building block for bdrv_block_status[_above] and
      * bdrv_is_allocated[_above].  The driver should answer only
@@ -1102,4 +1133,11 @@ void bdrv_dec_in_flight(BlockDriverState *bs);
 
 void blockdev_close_all_bdrv_states(void);
 
+int coroutine_fn bdrv_co_copy_range_from(BdrvChild *src, uint64_t src_offset,
+                                         BdrvChild *dst, uint64_t dst_offset,
+                                         uint64_t bytes, BdrvRequestFlags flags);
+int coroutine_fn bdrv_co_copy_range_to(BdrvChild *src, uint64_t src_offset,
+                                       BdrvChild *dst, uint64_t dst_offset,
+                                       uint64_t bytes, BdrvRequestFlags flags);
+
 #endif /* BLOCK_INT_H */
-- 
2.17.0
