Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2F0C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 08:49:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13A4E2075B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 08:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A4E2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59294 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVXn2-0008Q0-C2
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 04:49:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hVXjz-0006X4-Qy
	for qemu-devel@nongnu.org; Tue, 28 May 2019 04:45:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hVXjy-00038Y-1J
	for qemu-devel@nongnu.org; Tue, 28 May 2019 04:45:51 -0400
Received: from relay.sw.ru ([185.231.240.75]:57170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hVXjx-00035v-NF; Tue, 28 May 2019 04:45:49 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hVXju-0001Ec-Pi; Tue, 28 May 2019 11:45:46 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Tue, 28 May 2019 11:45:44 +0300
Message-Id: <20190528084544.183558-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190528084544.183558-1-vsementsov@virtuozzo.com>
References: <20190528084544.183558-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 2/2] block/io: refactor padding
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have similar padding code in bdrv_co_pwritev,
bdrv_co_do_pwrite_zeroes and bdrv_co_preadv. Let's combine and unify
it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 344 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 179 insertions(+), 165 deletions(-)

diff --git a/block/io.c b/block/io.c
index 3134a60a48..840e276269 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1344,28 +1344,155 @@ out:
 }
 
 /*
- * Handle a read request in coroutine context
+ * Request padding
+ *
+ *  |<---- align ---->|                     |<---- align ---->|
+ *  |<- head ->|<------------ bytes ------------>|<-- tail -->|
+ *  |          |      |                     |    |            |
+ * -*----------$------*-------- ... --------*----$------------*---
+ *  |          |      |                     |    |            |
+ *  |          offset |                     |    end          |
+ *  ALIGN_UP(offset)  ALIGN_DOWN(offset)    ALIGN_DOWN(end)   ALIGN_UP(end)
+ *  [buf   ... )                            [tail_buf         )
+ *
+ * @buf is an aligned allocation needed to store @head and @tail paddings. @head
+ * is placed at the beginning of @buf and @tail at the @end.
+ *
+ * @tail_buf is a pointer to sub-buffer, corresponding to align-sized chunk
+ * around tail, if tail exists.
+ *
+ * @merge_reads is true for small requests,
+ * if @buf_len == @head + bytes + @tail. In this case it is possible that both
+ * head and tail exist but @buf_len == align and @tail_buf == @buf.
  */
+typedef struct BdrvRequestPadding {
+    uint8_t *buf;
+    size_t buf_len;
+    uint8_t *tail_buf;
+    size_t head;
+    size_t tail;
+    bool merge_reads;
+    QEMUIOVector local_qiov;
+} BdrvRequestPadding;
+
+static bool bdrv_init_padding(BlockDriverState *bs,
+                              int64_t offset, int64_t bytes,
+                              BdrvRequestPadding *pad)
+{
+    uint64_t align = bs->bl.request_alignment;
+    size_t sum;
+
+    memset(pad, 0, sizeof(*pad));
+
+    pad->head = offset & (align - 1);
+    pad->tail = ((offset + bytes) & (align - 1));
+    if (pad->tail) {
+        pad->tail = align - pad->tail;
+    }
+
+    if ((!pad->head && !pad->tail) || !bytes) {
+        return false;
+    }
+
+    sum = pad->head + bytes + pad->tail;
+    pad->buf_len = (sum > align && pad->head && pad->tail) ? 2 * align : align;
+    pad->buf = qemu_blockalign(bs, pad->buf_len);
+    pad->merge_reads = sum == pad->buf_len;
+    if (pad->tail) {
+        pad->tail_buf = pad->buf + pad->buf_len - align;
+    }
+
+    return true;
+}
+
+static int bdrv_padding_read(BdrvChild *child,
+                             BdrvTrackedRequest *req,
+                             BdrvRequestPadding *pad,
+                             bool zero_middle)
+{
+    QEMUIOVector local_qiov;
+    BlockDriverState *bs = child->bs;
+    uint64_t align = bs->bl.request_alignment;
+    int ret;
+
+    assert(req->serialising && pad->buf);
+
+    if (pad->head || pad->merge_reads) {
+        uint64_t bytes = pad->merge_reads ? pad->buf_len : align;
+
+        qemu_iovec_init_buf(&local_qiov, pad->buf, bytes);
+
+        bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_HEAD);
+        ret = bdrv_aligned_preadv(child, req, req->overlap_offset, bytes,
+                                  align, &local_qiov, 0);
+        if (ret < 0) {
+            return ret;
+        }
+        bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_AFTER_HEAD);
+
+        if (pad->merge_reads) {
+            goto zero_mem;
+        }
+    }
+
+    if (pad->tail) {
+        qemu_iovec_init_buf(&local_qiov, pad->tail_buf, align);
+
+        bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_TAIL);
+        ret = bdrv_aligned_preadv(
+                child, req,
+                req->overlap_offset + req->overlap_bytes - align,
+                align, align, &local_qiov, 0);
+        if (ret < 0) {
+            return ret;
+        }
+        bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_AFTER_TAIL);
+    }
+
+zero_mem:
+    if (zero_middle) {
+        memset(pad->buf + pad->head, 0, pad->buf_len - pad->head - pad->tail);
+    }
+
+    return 0;
+}
+
+static void bdrv_padding_destroy(BdrvRequestPadding *pad)
+{
+    if (pad->buf) {
+        qemu_vfree(pad->buf);
+        qemu_iovec_destroy(&pad->local_qiov);
+    }
+}
+
+static QEMUIOVector *bdrv_pad_request(BlockDriverState *bs, QEMUIOVector *qiov,
+                                      int64_t *offset, unsigned int *bytes,
+                                      BdrvRequestPadding *pad)
+{
+    bdrv_init_padding(bs, *offset, *bytes, pad);
+    if (!pad->buf) {
+        return qiov;
+    }
+
+    qemu_iovec_init_extended(&pad->local_qiov, pad->buf, pad->head,
+                             qiov, 0, *bytes,
+                             pad->buf + pad->buf_len - pad->tail, pad->tail);
+    *bytes += pad->head + pad->tail;
+    *offset -= pad->head;
+
+    return &pad->local_qiov;
+}
+
 int coroutine_fn bdrv_co_preadv(BdrvChild *child,
     int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
     BdrvRequestFlags flags)
 {
     BlockDriverState *bs = child->bs;
-    BlockDriver *drv = bs->drv;
     BdrvTrackedRequest req;
-
-    uint64_t align = bs->bl.request_alignment;
-    uint8_t *head_buf = NULL;
-    uint8_t *tail_buf = NULL;
-    QEMUIOVector local_qiov;
-    bool use_local_qiov = false;
+    BdrvRequestPadding pad;
     int ret;
 
-    trace_bdrv_co_preadv(child->bs, offset, bytes, flags);
-
-    if (!drv) {
-        return -ENOMEDIUM;
-    }
+    trace_bdrv_co_preadv(bs, offset, bytes, flags);
 
     ret = bdrv_check_byte_request(bs, offset, bytes);
     if (ret < 0) {
@@ -1379,43 +1506,16 @@ int coroutine_fn bdrv_co_preadv(BdrvChild *child,
         flags |= BDRV_REQ_COPY_ON_READ;
     }
 
-    /* Align read if necessary by padding qiov */
-    if (offset & (align - 1)) {
-        head_buf = qemu_blockalign(bs, align);
-        qemu_iovec_init(&local_qiov, qiov->niov + 2);
-        qemu_iovec_add(&local_qiov, head_buf, offset & (align - 1));
-        qemu_iovec_concat(&local_qiov, qiov, 0, qiov->size);
-        use_local_qiov = true;
-
-        bytes += offset & (align - 1);
-        offset = offset & ~(align - 1);
-    }
-
-    if ((offset + bytes) & (align - 1)) {
-        if (!use_local_qiov) {
-            qemu_iovec_init(&local_qiov, qiov->niov + 1);
-            qemu_iovec_concat(&local_qiov, qiov, 0, qiov->size);
-            use_local_qiov = true;
-        }
-        tail_buf = qemu_blockalign(bs, align);
-        qemu_iovec_add(&local_qiov, tail_buf,
-                       align - ((offset + bytes) & (align - 1)));
-
-        bytes = ROUND_UP(bytes, align);
-    }
+    qiov = bdrv_pad_request(bs, qiov, &offset, &bytes, &pad);
 
     tracked_request_begin(&req, bs, offset, bytes, BDRV_TRACKED_READ);
-    ret = bdrv_aligned_preadv(child, &req, offset, bytes, align,
-                              use_local_qiov ? &local_qiov : qiov,
-                              flags);
+    ret = bdrv_aligned_preadv(child, &req, offset, bytes,
+                              bs->bl.request_alignment,
+                              qiov, flags);
     tracked_request_end(&req);
     bdrv_dec_in_flight(bs);
 
-    if (use_local_qiov) {
-        qemu_iovec_destroy(&local_qiov);
-        qemu_vfree(head_buf);
-        qemu_vfree(tail_buf);
-    }
+    bdrv_padding_destroy(&pad);
 
     return ret;
 }
@@ -1711,44 +1811,34 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvChild *child,
                                                 BdrvTrackedRequest *req)
 {
     BlockDriverState *bs = child->bs;
-    uint8_t *buf = NULL;
     QEMUIOVector local_qiov;
     uint64_t align = bs->bl.request_alignment;
-    unsigned int head_padding_bytes, tail_padding_bytes;
     int ret = 0;
+    bool padding;
+    BdrvRequestPadding pad;
 
-    head_padding_bytes = offset & (align - 1);
-    tail_padding_bytes = (align - (offset + bytes)) & (align - 1);
-
-
-    assert(flags & BDRV_REQ_ZERO_WRITE);
-    if (head_padding_bytes || tail_padding_bytes) {
-        buf = qemu_blockalign(bs, align);
-        qemu_iovec_init_buf(&local_qiov, buf, align);
-    }
-    if (head_padding_bytes) {
-        uint64_t zero_bytes = MIN(bytes, align - head_padding_bytes);
-
-        /* RMW the unaligned part before head. */
+    padding = bdrv_init_padding(bs, offset, bytes, &pad);
+    if (padding) {
         mark_request_serialising(req, align);
         wait_serialising_requests(req);
-        bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_HEAD);
-        ret = bdrv_aligned_preadv(child, req, offset & ~(align - 1), align,
-                                  align, &local_qiov, 0);
-        if (ret < 0) {
-            goto fail;
-        }
-        bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_AFTER_HEAD);
 
-        memset(buf + head_padding_bytes, 0, zero_bytes);
-        ret = bdrv_aligned_pwritev(child, req, offset & ~(align - 1), align,
-                                   align, &local_qiov,
-                                   flags & ~BDRV_REQ_ZERO_WRITE);
-        if (ret < 0) {
-            goto fail;
+        bdrv_padding_read(child, req, &pad, true);
+
+        if (pad.head || pad.merge_reads) {
+            int64_t aligned_offset = offset & ~(align - 1);
+            int64_t write_bytes = pad.merge_reads ? pad.buf_len : align;
+
+            qemu_iovec_init_buf(&local_qiov, pad.buf, write_bytes);
+            ret = bdrv_aligned_pwritev(child, req, aligned_offset, write_bytes,
+                                       align, &local_qiov,
+                                       flags & ~BDRV_REQ_ZERO_WRITE);
+            if (ret < 0 || pad.merge_reads) {
+                /* Error or all work is done */
+                goto out;
+            }
+            offset += write_bytes - pad.head;
+            bytes -= write_bytes - pad.head;
         }
-        offset += zero_bytes;
-        bytes -= zero_bytes;
     }
 
     assert(!bytes || (offset & (align - 1)) == 0);
@@ -1758,7 +1848,7 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvChild *child,
         ret = bdrv_aligned_pwritev(child, req, offset, aligned_bytes, align,
                                    NULL, flags);
         if (ret < 0) {
-            goto fail;
+            goto out;
         }
         bytes -= aligned_bytes;
         offset += aligned_bytes;
@@ -1766,26 +1856,17 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvChild *child,
 
     assert(!bytes || (offset & (align - 1)) == 0);
     if (bytes) {
-        assert(align == tail_padding_bytes + bytes);
-        /* RMW the unaligned part after tail. */
-        mark_request_serialising(req, align);
-        wait_serialising_requests(req);
-        bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_TAIL);
-        ret = bdrv_aligned_preadv(child, req, offset, align,
-                                  align, &local_qiov, 0);
-        if (ret < 0) {
-            goto fail;
-        }
-        bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_AFTER_TAIL);
+        assert(align == pad.tail + bytes);
 
-        memset(buf, 0, bytes);
+        qemu_iovec_init_buf(&local_qiov, pad.tail_buf, align);
         ret = bdrv_aligned_pwritev(child, req, offset, align, align,
                                    &local_qiov, flags & ~BDRV_REQ_ZERO_WRITE);
     }
-fail:
-    qemu_vfree(buf);
-    return ret;
 
+out:
+    bdrv_padding_destroy(&pad);
+
+    return ret;
 }
 
 /*
@@ -1798,10 +1879,7 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
     BlockDriverState *bs = child->bs;
     BdrvTrackedRequest req;
     uint64_t align = bs->bl.request_alignment;
-    uint8_t *head_buf = NULL;
-    uint8_t *tail_buf = NULL;
-    QEMUIOVector local_qiov;
-    bool use_local_qiov = false;
+    BdrvRequestPadding pad;
     int ret;
 
     trace_bdrv_co_pwritev(child->bs, offset, bytes, flags);
@@ -1828,86 +1906,22 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
         goto out;
     }
 
-    if (offset & (align - 1)) {
-        QEMUIOVector head_qiov;
-
+    qiov = bdrv_pad_request(bs, qiov, &offset, &bytes, &pad);
+    if (pad.head || pad.tail) {
         mark_request_serialising(&req, align);
         wait_serialising_requests(&req);
-
-        head_buf = qemu_blockalign(bs, align);
-        qemu_iovec_init_buf(&head_qiov, head_buf, align);
-
-        bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_HEAD);
-        ret = bdrv_aligned_preadv(child, &req, offset & ~(align - 1), align,
-                                  align, &head_qiov, 0);
-        if (ret < 0) {
-            goto fail;
-        }
-        bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_AFTER_HEAD);
-
-        qemu_iovec_init(&local_qiov, qiov->niov + 2);
-        qemu_iovec_add(&local_qiov, head_buf, offset & (align - 1));
-        qemu_iovec_concat(&local_qiov, qiov, 0, qiov->size);
-        use_local_qiov = true;
-
-        bytes += offset & (align - 1);
-        offset = offset & ~(align - 1);
-
-        /* We have read the tail already if the request is smaller
-         * than one aligned block.
-         */
-        if (bytes < align) {
-            qemu_iovec_add(&local_qiov, head_buf + bytes, align - bytes);
-            bytes = align;
-        }
-    }
-
-    if ((offset + bytes) & (align - 1)) {
-        QEMUIOVector tail_qiov;
-        size_t tail_bytes;
-        bool waited;
-
-        mark_request_serialising(&req, align);
-        waited = wait_serialising_requests(&req);
-        assert(!waited || !use_local_qiov);
-
-        tail_buf = qemu_blockalign(bs, align);
-        qemu_iovec_init_buf(&tail_qiov, tail_buf, align);
-
-        bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_TAIL);
-        ret = bdrv_aligned_preadv(child, &req, (offset + bytes) & ~(align - 1),
-                                  align, align, &tail_qiov, 0);
-        if (ret < 0) {
-            goto fail;
-        }
-        bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_AFTER_TAIL);
-
-        if (!use_local_qiov) {
-            qemu_iovec_init(&local_qiov, qiov->niov + 1);
-            qemu_iovec_concat(&local_qiov, qiov, 0, qiov->size);
-            use_local_qiov = true;
-        }
-
-        tail_bytes = (offset + bytes) & (align - 1);
-        qemu_iovec_add(&local_qiov, tail_buf + tail_bytes, align - tail_bytes);
-
-        bytes = ROUND_UP(bytes, align);
+        bdrv_padding_read(child, &req, &pad, false);
     }
 
     ret = bdrv_aligned_pwritev(child, &req, offset, bytes, align,
-                               use_local_qiov ? &local_qiov : qiov,
-                               flags);
+                               qiov, flags);
 
-fail:
+    bdrv_padding_destroy(&pad);
 
-    if (use_local_qiov) {
-        qemu_iovec_destroy(&local_qiov);
-    }
-    qemu_vfree(head_buf);
-    qemu_vfree(tail_buf);
 out:
     tracked_request_end(&req);
     bdrv_dec_in_flight(bs);
+
     return ret;
 }
 
-- 
2.18.0


