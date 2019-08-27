Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AD5C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 20:22:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF0920679
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 20:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF0920679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2hyk-00032w-09
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 16:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i2hu9-0005y2-Cf
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:17:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i2hu7-0000kH-AR
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:17:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52138)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1i2hu3-0000j0-7Y; Tue, 27 Aug 2019 16:17:19 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8B4653082E10;
 Tue, 27 Aug 2019 20:17:18 +0000 (UTC)
Received: from localhost (ovpn-116-148.ams2.redhat.com [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC7996107E;
 Tue, 27 Aug 2019 20:17:09 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 27 Aug 2019 21:16:30 +0100
Message-Id: <20190827201639.30368-4-stefanha@redhat.com>
In-Reply-To: <20190827201639.30368-1-stefanha@redhat.com>
References: <20190827201639.30368-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 27 Aug 2019 20:17:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 03/12] block/io: refactor padding
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

We have similar padding code in bdrv_co_pwritev,
bdrv_co_do_pwrite_zeroes and bdrv_co_preadv. Let's combine and unify
it.

[Squashed in Vladimir's qemu-iotests 077 fix
--Stefan]

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20190604161514.262241-4-vsementsov@virtuozzo.com
Message-Id: <20190604161514.262241-4-vsementsov@virtuozzo.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io.c | 365 +++++++++++++++++++++++++++++------------------------
 1 file changed, 200 insertions(+), 165 deletions(-)

diff --git a/block/io.c b/block/io.c
index f656fb2dce..04e69400d8 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1415,28 +1415,177 @@ out:
 }
=20
 /*
- * Handle a read request in coroutine context
+ * Request padding
+ *
+ *  |<---- align ----->|                     |<----- align ---->|
+ *  |<- head ->|<------------- bytes ------------->|<-- tail -->|
+ *  |          |       |                     |     |            |
+ * -*----------$-------*-------- ... --------*-----$------------*---
+ *  |          |       |                     |     |            |
+ *  |          offset  |                     |     end          |
+ *  ALIGN_DOWN(offset) ALIGN_UP(offset)      ALIGN_DOWN(end)   ALIGN_UP(=
end)
+ *  [buf   ... )                             [tail_buf          )
+ *
+ * @buf is an aligned allocation needed to store @head and @tail padding=
s. @head
+ * is placed at the beginning of @buf and @tail at the @end.
+ *
+ * @tail_buf is a pointer to sub-buffer, corresponding to align-sized ch=
unk
+ * around tail, if tail exists.
+ *
+ * @merge_reads is true for small requests,
+ * if @buf_len =3D=3D @head + bytes + @tail. In this case it is possible=
 that both
+ * head and tail exist but @buf_len =3D=3D align and @tail_buf =3D=3D @b=
uf.
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
+    uint64_t align =3D bs->bl.request_alignment;
+    size_t sum;
+
+    memset(pad, 0, sizeof(*pad));
+
+    pad->head =3D offset & (align - 1);
+    pad->tail =3D ((offset + bytes) & (align - 1));
+    if (pad->tail) {
+        pad->tail =3D align - pad->tail;
+    }
+
+    if ((!pad->head && !pad->tail) || !bytes) {
+        return false;
+    }
+
+    sum =3D pad->head + bytes + pad->tail;
+    pad->buf_len =3D (sum > align && pad->head && pad->tail) ? 2 * align=
 : align;
+    pad->buf =3D qemu_blockalign(bs, pad->buf_len);
+    pad->merge_reads =3D sum =3D=3D pad->buf_len;
+    if (pad->tail) {
+        pad->tail_buf =3D pad->buf + pad->buf_len - align;
+    }
+
+    return true;
+}
+
+static int bdrv_padding_rmw_read(BdrvChild *child,
+                                 BdrvTrackedRequest *req,
+                                 BdrvRequestPadding *pad,
+                                 bool zero_middle)
+{
+    QEMUIOVector local_qiov;
+    BlockDriverState *bs =3D child->bs;
+    uint64_t align =3D bs->bl.request_alignment;
+    int ret;
+
+    assert(req->serialising && pad->buf);
+
+    if (pad->head || pad->merge_reads) {
+        uint64_t bytes =3D pad->merge_reads ? pad->buf_len : align;
+
+        qemu_iovec_init_buf(&local_qiov, pad->buf, bytes);
+
+        if (pad->head) {
+            bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_HEAD);
+        }
+        if (pad->merge_reads && pad->tail) {
+            bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_TAIL);
+        }
+        ret =3D bdrv_aligned_preadv(child, req, req->overlap_offset, byt=
es,
+                                  align, &local_qiov, 0);
+        if (ret < 0) {
+            return ret;
+        }
+        if (pad->head) {
+            bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_AFTER_HEAD);
+        }
+        if (pad->merge_reads && pad->tail) {
+            bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_AFTER_TAIL);
+        }
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
+        ret =3D bdrv_aligned_preadv(
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
+        memset(pad->buf + pad->head, 0, pad->buf_len - pad->head - pad->=
tail);
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
+/*
+ * bdrv_pad_request
+ *
+ * Exchange request parameters with padded request if needed. Don't incl=
ude RMW
+ * read of padding, bdrv_padding_rmw_read() should be called separately =
if
+ * needed.
+ *
+ * All parameters except @bs are in-out: they represent original request=
 at
+ * function call and padded (if padding needed) at function finish.
+ *
+ * Function always succeeds.
+ */
+static bool bdrv_pad_request(BlockDriverState *bs, QEMUIOVector **qiov,
+                             int64_t *offset, unsigned int *bytes,
+                             BdrvRequestPadding *pad)
+{
+    if (!bdrv_init_padding(bs, *offset, *bytes, pad)) {
+        return false;
+    }
+
+    qemu_iovec_init_extended(&pad->local_qiov, pad->buf, pad->head,
+                             *qiov, 0, *bytes,
+                             pad->buf + pad->buf_len - pad->tail, pad->t=
ail);
+    *bytes +=3D pad->head + pad->tail;
+    *offset -=3D pad->head;
+    *qiov =3D &pad->local_qiov;
+
+    return true;
+}
+
 int coroutine_fn bdrv_co_preadv(BdrvChild *child,
     int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
     BdrvRequestFlags flags)
 {
     BlockDriverState *bs =3D child->bs;
-    BlockDriver *drv =3D bs->drv;
     BdrvTrackedRequest req;
-
-    uint64_t align =3D bs->bl.request_alignment;
-    uint8_t *head_buf =3D NULL;
-    uint8_t *tail_buf =3D NULL;
-    QEMUIOVector local_qiov;
-    bool use_local_qiov =3D false;
+    BdrvRequestPadding pad;
     int ret;
=20
-    trace_bdrv_co_preadv(child->bs, offset, bytes, flags);
-
-    if (!drv) {
-        return -ENOMEDIUM;
-    }
+    trace_bdrv_co_preadv(bs, offset, bytes, flags);
=20
     ret =3D bdrv_check_byte_request(bs, offset, bytes);
     if (ret < 0) {
@@ -1450,43 +1599,16 @@ int coroutine_fn bdrv_co_preadv(BdrvChild *child,
         flags |=3D BDRV_REQ_COPY_ON_READ;
     }
=20
-    /* Align read if necessary by padding qiov */
-    if (offset & (align - 1)) {
-        head_buf =3D qemu_blockalign(bs, align);
-        qemu_iovec_init(&local_qiov, qiov->niov + 2);
-        qemu_iovec_add(&local_qiov, head_buf, offset & (align - 1));
-        qemu_iovec_concat(&local_qiov, qiov, 0, qiov->size);
-        use_local_qiov =3D true;
-
-        bytes +=3D offset & (align - 1);
-        offset =3D offset & ~(align - 1);
-    }
-
-    if ((offset + bytes) & (align - 1)) {
-        if (!use_local_qiov) {
-            qemu_iovec_init(&local_qiov, qiov->niov + 1);
-            qemu_iovec_concat(&local_qiov, qiov, 0, qiov->size);
-            use_local_qiov =3D true;
-        }
-        tail_buf =3D qemu_blockalign(bs, align);
-        qemu_iovec_add(&local_qiov, tail_buf,
-                       align - ((offset + bytes) & (align - 1)));
-
-        bytes =3D ROUND_UP(bytes, align);
-    }
+    bdrv_pad_request(bs, &qiov, &offset, &bytes, &pad);
=20
     tracked_request_begin(&req, bs, offset, bytes, BDRV_TRACKED_READ);
-    ret =3D bdrv_aligned_preadv(child, &req, offset, bytes, align,
-                              use_local_qiov ? &local_qiov : qiov,
-                              flags);
+    ret =3D bdrv_aligned_preadv(child, &req, offset, bytes,
+                              bs->bl.request_alignment,
+                              qiov, flags);
     tracked_request_end(&req);
     bdrv_dec_in_flight(bs);
=20
-    if (use_local_qiov) {
-        qemu_iovec_destroy(&local_qiov);
-        qemu_vfree(head_buf);
-        qemu_vfree(tail_buf);
-    }
+    bdrv_padding_destroy(&pad);
=20
     return ret;
 }
@@ -1782,44 +1904,34 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(B=
drvChild *child,
                                                 BdrvTrackedRequest *req)
 {
     BlockDriverState *bs =3D child->bs;
-    uint8_t *buf =3D NULL;
     QEMUIOVector local_qiov;
     uint64_t align =3D bs->bl.request_alignment;
-    unsigned int head_padding_bytes, tail_padding_bytes;
     int ret =3D 0;
+    bool padding;
+    BdrvRequestPadding pad;
=20
-    head_padding_bytes =3D offset & (align - 1);
-    tail_padding_bytes =3D (align - (offset + bytes)) & (align - 1);
-
-
-    assert(flags & BDRV_REQ_ZERO_WRITE);
-    if (head_padding_bytes || tail_padding_bytes) {
-        buf =3D qemu_blockalign(bs, align);
-        qemu_iovec_init_buf(&local_qiov, buf, align);
-    }
-    if (head_padding_bytes) {
-        uint64_t zero_bytes =3D MIN(bytes, align - head_padding_bytes);
-
-        /* RMW the unaligned part before head. */
+    padding =3D bdrv_init_padding(bs, offset, bytes, &pad);
+    if (padding) {
         mark_request_serialising(req, align);
         wait_serialising_requests(req);
-        bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_HEAD);
-        ret =3D bdrv_aligned_preadv(child, req, offset & ~(align - 1), a=
lign,
-                                  align, &local_qiov, 0);
-        if (ret < 0) {
-            goto fail;
-        }
-        bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_AFTER_HEAD);
=20
-        memset(buf + head_padding_bytes, 0, zero_bytes);
-        ret =3D bdrv_aligned_pwritev(child, req, offset & ~(align - 1), =
align,
-                                   align, &local_qiov,
-                                   flags & ~BDRV_REQ_ZERO_WRITE);
-        if (ret < 0) {
-            goto fail;
+        bdrv_padding_rmw_read(child, req, &pad, true);
+
+        if (pad.head || pad.merge_reads) {
+            int64_t aligned_offset =3D offset & ~(align - 1);
+            int64_t write_bytes =3D pad.merge_reads ? pad.buf_len : alig=
n;
+
+            qemu_iovec_init_buf(&local_qiov, pad.buf, write_bytes);
+            ret =3D bdrv_aligned_pwritev(child, req, aligned_offset, wri=
te_bytes,
+                                       align, &local_qiov,
+                                       flags & ~BDRV_REQ_ZERO_WRITE);
+            if (ret < 0 || pad.merge_reads) {
+                /* Error or all work is done */
+                goto out;
+            }
+            offset +=3D write_bytes - pad.head;
+            bytes -=3D write_bytes - pad.head;
         }
-        offset +=3D zero_bytes;
-        bytes -=3D zero_bytes;
     }
=20
     assert(!bytes || (offset & (align - 1)) =3D=3D 0);
@@ -1829,7 +1941,7 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(Bdr=
vChild *child,
         ret =3D bdrv_aligned_pwritev(child, req, offset, aligned_bytes, =
align,
                                    NULL, flags);
         if (ret < 0) {
-            goto fail;
+            goto out;
         }
         bytes -=3D aligned_bytes;
         offset +=3D aligned_bytes;
@@ -1837,26 +1949,17 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(B=
drvChild *child,
=20
     assert(!bytes || (offset & (align - 1)) =3D=3D 0);
     if (bytes) {
-        assert(align =3D=3D tail_padding_bytes + bytes);
-        /* RMW the unaligned part after tail. */
-        mark_request_serialising(req, align);
-        wait_serialising_requests(req);
-        bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_TAIL);
-        ret =3D bdrv_aligned_preadv(child, req, offset, align,
-                                  align, &local_qiov, 0);
-        if (ret < 0) {
-            goto fail;
-        }
-        bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_AFTER_TAIL);
+        assert(align =3D=3D pad.tail + bytes);
=20
-        memset(buf, 0, bytes);
+        qemu_iovec_init_buf(&local_qiov, pad.tail_buf, align);
         ret =3D bdrv_aligned_pwritev(child, req, offset, align, align,
                                    &local_qiov, flags & ~BDRV_REQ_ZERO_W=
RITE);
     }
-fail:
-    qemu_vfree(buf);
+
+out:
+    bdrv_padding_destroy(&pad);
+
     return ret;
-
 }
=20
 /*
@@ -1869,10 +1972,7 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
     BlockDriverState *bs =3D child->bs;
     BdrvTrackedRequest req;
     uint64_t align =3D bs->bl.request_alignment;
-    uint8_t *head_buf =3D NULL;
-    uint8_t *tail_buf =3D NULL;
-    QEMUIOVector local_qiov;
-    bool use_local_qiov =3D false;
+    BdrvRequestPadding pad;
     int ret;
=20
     trace_bdrv_co_pwritev(child->bs, offset, bytes, flags);
@@ -1899,86 +1999,21 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child=
,
         goto out;
     }
=20
-    if (offset & (align - 1)) {
-        QEMUIOVector head_qiov;
-
+    if (bdrv_pad_request(bs, &qiov, &offset, &bytes, &pad)) {
         mark_request_serialising(&req, align);
         wait_serialising_requests(&req);
-
-        head_buf =3D qemu_blockalign(bs, align);
-        qemu_iovec_init_buf(&head_qiov, head_buf, align);
-
-        bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_HEAD);
-        ret =3D bdrv_aligned_preadv(child, &req, offset & ~(align - 1), =
align,
-                                  align, &head_qiov, 0);
-        if (ret < 0) {
-            goto fail;
-        }
-        bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_AFTER_HEAD);
-
-        qemu_iovec_init(&local_qiov, qiov->niov + 2);
-        qemu_iovec_add(&local_qiov, head_buf, offset & (align - 1));
-        qemu_iovec_concat(&local_qiov, qiov, 0, qiov->size);
-        use_local_qiov =3D true;
-
-        bytes +=3D offset & (align - 1);
-        offset =3D offset & ~(align - 1);
-
-        /* We have read the tail already if the request is smaller
-         * than one aligned block.
-         */
-        if (bytes < align) {
-            qemu_iovec_add(&local_qiov, head_buf + bytes, align - bytes)=
;
-            bytes =3D align;
-        }
-    }
-
-    if ((offset + bytes) & (align - 1)) {
-        QEMUIOVector tail_qiov;
-        size_t tail_bytes;
-        bool waited;
-
-        mark_request_serialising(&req, align);
-        waited =3D wait_serialising_requests(&req);
-        assert(!waited || !use_local_qiov);
-
-        tail_buf =3D qemu_blockalign(bs, align);
-        qemu_iovec_init_buf(&tail_qiov, tail_buf, align);
-
-        bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_TAIL);
-        ret =3D bdrv_aligned_preadv(child, &req, (offset + bytes) & ~(al=
ign - 1),
-                                  align, align, &tail_qiov, 0);
-        if (ret < 0) {
-            goto fail;
-        }
-        bdrv_debug_event(bs, BLKDBG_PWRITEV_RMW_AFTER_TAIL);
-
-        if (!use_local_qiov) {
-            qemu_iovec_init(&local_qiov, qiov->niov + 1);
-            qemu_iovec_concat(&local_qiov, qiov, 0, qiov->size);
-            use_local_qiov =3D true;
-        }
-
-        tail_bytes =3D (offset + bytes) & (align - 1);
-        qemu_iovec_add(&local_qiov, tail_buf + tail_bytes, align - tail_=
bytes);
-
-        bytes =3D ROUND_UP(bytes, align);
+        bdrv_padding_rmw_read(child, &req, &pad, false);
     }
=20
     ret =3D bdrv_aligned_pwritev(child, &req, offset, bytes, align,
-                               use_local_qiov ? &local_qiov : qiov,
-                               flags);
+                               qiov, flags);
=20
-fail:
+    bdrv_padding_destroy(&pad);
=20
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
=20
--=20
2.21.0


