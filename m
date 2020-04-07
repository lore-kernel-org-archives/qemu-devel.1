Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC6DC2BB54
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 12:16:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BCB72078A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 12:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWYyKbAb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BCB72078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLn9e-0000Sh-Ml
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 08:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jLn6l-0004GL-IL
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:13:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jLn6i-0007wP-SN
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:13:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32600
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jLn6b-0007tq-UD
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586261605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hNwU38LjWdImE3Qi0Bio20etKsSSTB9jHnypWGuwgvg=;
 b=BWYyKbAb0B2q21m2XEI99b28VNdwOI5OUlDC0H3RNF6qi2XheIhbgCJwl4jyN9yStKoWp3
 SajEA71QNda2hwuzzWIqEGHS/Z7xFFc06KR87Ycw2JH3TTR0mshyS/RjLf4g+uajXb8Bo1
 L2A1pOiNsC7nAO4TehjzeOUzKPKqc+E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-NbEjZp6ONq6Wd0sDTWdAEg-1; Tue, 07 Apr 2020 08:13:20 -0400
X-MC-Unique: NbEjZp6ONq6Wd0sDTWdAEg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3577107ACC9;
 Tue,  7 Apr 2020 12:13:18 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-253.ams2.redhat.com
 [10.36.113.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EEBE610002AA;
 Tue,  7 Apr 2020 12:13:16 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 v3 2/3] block: Increase BB.in_flight for coroutine and
 sync interfaces
Date: Tue,  7 Apr 2020 14:12:58 +0200
Message-Id: <20200407121259.21350-3-kwolf@redhat.com>
In-Reply-To: <20200407121259.21350-1-kwolf@redhat.com>
References: <20200407121259.21350-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, s.reiter@proxmox.com,
 qemu-devel@nongnu.org, dietmar@proxmox.com, stefanha@redhat.com,
 mreitz@redhat.com, t.lamprecht@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

External callers of blk_co_*() and of the synchronous blk_*() functions
don't currently increase the BlockBackend.in_flight counter, but calls
from blk_aio_*() do, so there is an inconsistency whether the counter
has been increased or not.

This patch moves the actual operations to static functions that can
later know they will always be called with in_flight increased exactly
once, even for external callers using the blk_co_*() coroutine
interfaces.

If the public blk_co_*() interface is unused, remove it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/sysemu/block-backend.h |   1 -
 block/block-backend.c          | 103 +++++++++++++++++++++++++--------
 2 files changed, 80 insertions(+), 24 deletions(-)

diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.=
h
index b198deca0b..9bbdbd63d7 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -171,7 +171,6 @@ BlockAIOCB *blk_aio_pdiscard(BlockBackend *blk, int64_t=
 offset, int bytes,
                              BlockCompletionFunc *cb, void *opaque);
 void blk_aio_cancel(BlockAIOCB *acb);
 void blk_aio_cancel_async(BlockAIOCB *acb);
-int blk_co_ioctl(BlockBackend *blk, unsigned long int req, void *buf);
 int blk_ioctl(BlockBackend *blk, unsigned long int req, void *buf);
 BlockAIOCB *blk_aio_ioctl(BlockBackend *blk, unsigned long int req, void *=
buf,
                           BlockCompletionFunc *cb, void *opaque);
diff --git a/block/block-backend.c b/block/block-backend.c
index 17b2e87afa..610dbfa0b2 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1147,9 +1147,10 @@ static void coroutine_fn blk_wait_while_drained(Bloc=
kBackend *blk)
     }
 }
=20
-int coroutine_fn blk_co_preadv(BlockBackend *blk, int64_t offset,
-                               unsigned int bytes, QEMUIOVector *qiov,
-                               BdrvRequestFlags flags)
+/* To be called between exactly one pair of blk_inc/dec_in_flight() */
+static int coroutine_fn
+blk_do_preadv(BlockBackend *blk, int64_t offset, unsigned int bytes,
+              QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
     int ret;
     BlockDriverState *bs;
@@ -1178,10 +1179,24 @@ int coroutine_fn blk_co_preadv(BlockBackend *blk, i=
nt64_t offset,
     return ret;
 }
=20
-int coroutine_fn blk_co_pwritev_part(BlockBackend *blk, int64_t offset,
-                                     unsigned int bytes,
-                                     QEMUIOVector *qiov, size_t qiov_offse=
t,
-                                     BdrvRequestFlags flags)
+int coroutine_fn blk_co_preadv(BlockBackend *blk, int64_t offset,
+                               unsigned int bytes, QEMUIOVector *qiov,
+                               BdrvRequestFlags flags)
+{
+    int ret;
+
+    blk_inc_in_flight(blk);
+    ret =3D blk_do_preadv(blk, offset, bytes, qiov, flags);
+    blk_dec_in_flight(blk);
+
+    return ret;
+}
+
+/* To be called between exactly one pair of blk_inc/dec_in_flight() */
+static int coroutine_fn
+blk_do_pwritev_part(BlockBackend *blk, int64_t offset, unsigned int bytes,
+                    QEMUIOVector *qiov, size_t qiov_offset,
+                    BdrvRequestFlags flags)
 {
     int ret;
     BlockDriverState *bs;
@@ -1214,6 +1229,20 @@ int coroutine_fn blk_co_pwritev_part(BlockBackend *b=
lk, int64_t offset,
     return ret;
 }
=20
+int coroutine_fn blk_co_pwritev_part(BlockBackend *blk, int64_t offset,
+                                     unsigned int bytes,
+                                     QEMUIOVector *qiov, size_t qiov_offse=
t,
+                                     BdrvRequestFlags flags)
+{
+    int ret;
+
+    blk_inc_in_flight(blk);
+    ret =3D blk_do_pwritev_part(blk, offset, bytes, qiov, qiov_offset, fla=
gs);
+    blk_dec_in_flight(blk);
+
+    return ret;
+}
+
 int coroutine_fn blk_co_pwritev(BlockBackend *blk, int64_t offset,
                                 unsigned int bytes, QEMUIOVector *qiov,
                                 BdrvRequestFlags flags)
@@ -1234,7 +1263,7 @@ static void blk_read_entry(void *opaque)
     BlkRwCo *rwco =3D opaque;
     QEMUIOVector *qiov =3D rwco->iobuf;
=20
-    rwco->ret =3D blk_co_preadv(rwco->blk, rwco->offset, qiov->size,
+    rwco->ret =3D blk_do_preadv(rwco->blk, rwco->offset, qiov->size,
                               qiov, rwco->flags);
     aio_wait_kick();
 }
@@ -1244,8 +1273,8 @@ static void blk_write_entry(void *opaque)
     BlkRwCo *rwco =3D opaque;
     QEMUIOVector *qiov =3D rwco->iobuf;
=20
-    rwco->ret =3D blk_co_pwritev(rwco->blk, rwco->offset, qiov->size,
-                               qiov, rwco->flags);
+    rwco->ret =3D blk_do_pwritev_part(rwco->blk, rwco->offset, qiov->size,
+                                    qiov, 0, rwco->flags);
     aio_wait_kick();
 }
=20
@@ -1262,6 +1291,7 @@ static int blk_prw(BlockBackend *blk, int64_t offset,=
 uint8_t *buf,
         .ret    =3D NOT_DONE,
     };
=20
+    blk_inc_in_flight(blk);
     if (qemu_in_coroutine()) {
         /* Fast-path if already in coroutine context */
         co_entry(&rwco);
@@ -1270,6 +1300,7 @@ static int blk_prw(BlockBackend *blk, int64_t offset,=
 uint8_t *buf,
         bdrv_coroutine_enter(blk_bs(blk), co);
         BDRV_POLL_WHILE(blk_bs(blk), rwco.ret =3D=3D NOT_DONE);
     }
+    blk_dec_in_flight(blk);
=20
     return rwco.ret;
 }
@@ -1394,7 +1425,7 @@ static void blk_aio_read_entry(void *opaque)
     }
=20
     assert(qiov->size =3D=3D acb->bytes);
-    rwco->ret =3D blk_co_preadv(rwco->blk, rwco->offset, acb->bytes,
+    rwco->ret =3D blk_do_preadv(rwco->blk, rwco->offset, acb->bytes,
                               qiov, rwco->flags);
     blk_aio_complete(acb);
 }
@@ -1412,8 +1443,8 @@ static void blk_aio_write_entry(void *opaque)
     }
=20
     assert(!qiov || qiov->size =3D=3D acb->bytes);
-    rwco->ret =3D blk_co_pwritev(rwco->blk, rwco->offset, acb->bytes,
-                               qiov, rwco->flags);
+    rwco->ret =3D blk_do_pwritev_part(rwco->blk, rwco->offset, acb->bytes,
+                                    qiov, 0, rwco->flags);
     blk_aio_complete(acb);
 }
=20
@@ -1498,7 +1529,9 @@ void blk_aio_cancel_async(BlockAIOCB *acb)
     bdrv_aio_cancel_async(acb);
 }
=20
-int blk_co_ioctl(BlockBackend *blk, unsigned long int req, void *buf)
+/* To be called between exactly one pair of blk_inc/dec_in_flight() */
+static int coroutine_fn
+blk_do_ioctl(BlockBackend *blk, unsigned long int req, void *buf)
 {
     blk_wait_while_drained(blk);
=20
@@ -1514,8 +1547,7 @@ static void blk_ioctl_entry(void *opaque)
     BlkRwCo *rwco =3D opaque;
     QEMUIOVector *qiov =3D rwco->iobuf;
=20
-    rwco->ret =3D blk_co_ioctl(rwco->blk, rwco->offset,
-                             qiov->iov[0].iov_base);
+    rwco->ret =3D blk_do_ioctl(rwco->blk, rwco->offset, qiov->iov[0].iov_b=
ase);
     aio_wait_kick();
 }
=20
@@ -1529,7 +1561,7 @@ static void blk_aio_ioctl_entry(void *opaque)
     BlkAioEmAIOCB *acb =3D opaque;
     BlkRwCo *rwco =3D &acb->rwco;
=20
-    rwco->ret =3D blk_co_ioctl(rwco->blk, rwco->offset, rwco->iobuf);
+    rwco->ret =3D blk_do_ioctl(rwco->blk, rwco->offset, rwco->iobuf);
=20
     blk_aio_complete(acb);
 }
@@ -1540,7 +1572,9 @@ BlockAIOCB *blk_aio_ioctl(BlockBackend *blk, unsigned=
 long int req, void *buf,
     return blk_aio_prwv(blk, req, 0, buf, blk_aio_ioctl_entry, 0, cb, opaq=
ue);
 }
=20
-int blk_co_pdiscard(BlockBackend *blk, int64_t offset, int bytes)
+/* To be called between exactly one pair of blk_inc/dec_in_flight() */
+static int coroutine_fn
+blk_do_pdiscard(BlockBackend *blk, int64_t offset, int bytes)
 {
     int ret;
=20
@@ -1559,7 +1593,7 @@ static void blk_aio_pdiscard_entry(void *opaque)
     BlkAioEmAIOCB *acb =3D opaque;
     BlkRwCo *rwco =3D &acb->rwco;
=20
-    rwco->ret =3D blk_co_pdiscard(rwco->blk, rwco->offset, acb->bytes);
+    rwco->ret =3D blk_do_pdiscard(rwco->blk, rwco->offset, acb->bytes);
     blk_aio_complete(acb);
 }
=20
@@ -1571,12 +1605,23 @@ BlockAIOCB *blk_aio_pdiscard(BlockBackend *blk,
                         cb, opaque);
 }
=20
+int coroutine_fn blk_co_pdiscard(BlockBackend *blk, int64_t offset, int by=
tes)
+{
+    int ret;
+
+    blk_inc_in_flight(blk);
+    ret =3D blk_do_pdiscard(blk, offset, bytes);
+    blk_dec_in_flight(blk);
+
+    return ret;
+}
+
 static void blk_pdiscard_entry(void *opaque)
 {
     BlkRwCo *rwco =3D opaque;
     QEMUIOVector *qiov =3D rwco->iobuf;
=20
-    rwco->ret =3D blk_co_pdiscard(rwco->blk, rwco->offset, qiov->size);
+    rwco->ret =3D blk_do_pdiscard(rwco->blk, rwco->offset, qiov->size);
     aio_wait_kick();
 }
=20
@@ -1585,7 +1630,8 @@ int blk_pdiscard(BlockBackend *blk, int64_t offset, i=
nt bytes)
     return blk_prw(blk, offset, NULL, bytes, blk_pdiscard_entry, 0);
 }
=20
-int blk_co_flush(BlockBackend *blk)
+/* To be called between exactly one pair of blk_inc/dec_in_flight() */
+static int coroutine_fn blk_do_flush(BlockBackend *blk)
 {
     blk_wait_while_drained(blk);
=20
@@ -1601,7 +1647,7 @@ static void blk_aio_flush_entry(void *opaque)
     BlkAioEmAIOCB *acb =3D opaque;
     BlkRwCo *rwco =3D &acb->rwco;
=20
-    rwco->ret =3D blk_co_flush(rwco->blk);
+    rwco->ret =3D blk_do_flush(rwco->blk);
     blk_aio_complete(acb);
 }
=20
@@ -1611,10 +1657,21 @@ BlockAIOCB *blk_aio_flush(BlockBackend *blk,
     return blk_aio_prwv(blk, 0, 0, NULL, blk_aio_flush_entry, 0, cb, opaqu=
e);
 }
=20
+int coroutine_fn blk_co_flush(BlockBackend *blk)
+{
+    int ret;
+
+    blk_inc_in_flight(blk);
+    ret =3D blk_do_flush(blk);
+    blk_dec_in_flight(blk);
+
+    return ret;
+}
+
 static void blk_flush_entry(void *opaque)
 {
     BlkRwCo *rwco =3D opaque;
-    rwco->ret =3D blk_co_flush(rwco->blk);
+    rwco->ret =3D blk_do_flush(rwco->blk);
     aio_wait_kick();
 }
=20
--=20
2.20.1


