Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0682C2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:18:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AF7C249C0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gtgoaV1Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF7C249C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLVNn-0004A8-MV
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 13:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57558)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jLVL4-0008S7-4e
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:15:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jLVL2-0007zc-Je
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:15:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53621
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jLVL2-0007zW-Fz
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586193308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZN2/Xav/cHCLfERaCl6an3xHsCGU37logxuocf2uq6A=;
 b=gtgoaV1QlVucoBVso+tP57BTX0guidCvsnp6C9TuEF+ss6cP0NLR7j/3Ntdbqcp8WgePfJ
 nzDaM+gHfMPHw19W+IU9LosmVxlVDfqajR6/ePy3dY0D2MQOm0rUXgTHEeBKfRoUiRIVJL
 p3ZeROEqgkAmQ5oZ1b73gvsfvzfuHEA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-iCHzJDrrMTObu264NITJuA-1; Mon, 06 Apr 2020 13:15:03 -0400
X-MC-Unique: iCHzJDrrMTObu264NITJuA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD0A318A3010;
 Mon,  6 Apr 2020 17:14:13 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-74.ams2.redhat.com [10.36.113.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9267D11CC05;
 Mon,  6 Apr 2020 17:14:11 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 v2 2/3] block: Increase BB.in_flight for coroutine
 interfaces
Date: Mon,  6 Apr 2020 19:14:02 +0200
Message-Id: <20200406171403.6761-3-kwolf@redhat.com>
In-Reply-To: <20200406171403.6761-1-kwolf@redhat.com>
References: <20200406171403.6761-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

External callers of blk_co_*() don't currently increase the
BlockBackend.in_flight counter, but calls from blk_aio_*() do, so there
is an inconsistency whether the counter has been increased or not.

This patch moves the actual operations to static functions that can
later know they will always be called with in_flight increased exactly
once, even for external callers using the blk_co_*() coroutine
interfaces.

If the public blk_co_*() interface is unused, remove it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/sysemu/block-backend.h |  1 -
 block/block-backend.c          | 94 +++++++++++++++++++++++++++-------
 2 files changed, 76 insertions(+), 19 deletions(-)

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
index 17b2e87afa..d330e08b05 100644
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
@@ -1394,7 +1423,7 @@ static void blk_aio_read_entry(void *opaque)
     }
=20
     assert(qiov->size =3D=3D acb->bytes);
-    rwco->ret =3D blk_co_preadv(rwco->blk, rwco->offset, acb->bytes,
+    rwco->ret =3D blk_do_preadv(rwco->blk, rwco->offset, acb->bytes,
                               qiov, rwco->flags);
     blk_aio_complete(acb);
 }
@@ -1412,8 +1441,8 @@ static void blk_aio_write_entry(void *opaque)
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
@@ -1498,7 +1527,9 @@ void blk_aio_cancel_async(BlockAIOCB *acb)
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
@@ -1514,8 +1545,10 @@ static void blk_ioctl_entry(void *opaque)
     BlkRwCo *rwco =3D opaque;
     QEMUIOVector *qiov =3D rwco->iobuf;
=20
-    rwco->ret =3D blk_co_ioctl(rwco->blk, rwco->offset,
-                             qiov->iov[0].iov_base);
+    blk_inc_in_flight(rwco->blk);
+    rwco->ret =3D blk_do_ioctl(rwco->blk, rwco->offset, qiov->iov[0].iov_b=
ase);
+    blk_dec_in_flight(rwco->blk);
+
     aio_wait_kick();
 }
=20
@@ -1529,7 +1562,7 @@ static void blk_aio_ioctl_entry(void *opaque)
     BlkAioEmAIOCB *acb =3D opaque;
     BlkRwCo *rwco =3D &acb->rwco;
=20
-    rwco->ret =3D blk_co_ioctl(rwco->blk, rwco->offset, rwco->iobuf);
+    rwco->ret =3D blk_do_ioctl(rwco->blk, rwco->offset, rwco->iobuf);
=20
     blk_aio_complete(acb);
 }
@@ -1540,7 +1573,9 @@ BlockAIOCB *blk_aio_ioctl(BlockBackend *blk, unsigned=
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
@@ -1559,7 +1594,7 @@ static void blk_aio_pdiscard_entry(void *opaque)
     BlkAioEmAIOCB *acb =3D opaque;
     BlkRwCo *rwco =3D &acb->rwco;
=20
-    rwco->ret =3D blk_co_pdiscard(rwco->blk, rwco->offset, acb->bytes);
+    rwco->ret =3D blk_do_pdiscard(rwco->blk, rwco->offset, acb->bytes);
     blk_aio_complete(acb);
 }
=20
@@ -1571,6 +1606,17 @@ BlockAIOCB *blk_aio_pdiscard(BlockBackend *blk,
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
@@ -1585,7 +1631,8 @@ int blk_pdiscard(BlockBackend *blk, int64_t offset, i=
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
@@ -1601,7 +1648,7 @@ static void blk_aio_flush_entry(void *opaque)
     BlkAioEmAIOCB *acb =3D opaque;
     BlkRwCo *rwco =3D &acb->rwco;
=20
-    rwco->ret =3D blk_co_flush(rwco->blk);
+    rwco->ret =3D blk_do_flush(rwco->blk);
     blk_aio_complete(acb);
 }
=20
@@ -1611,6 +1658,17 @@ BlockAIOCB *blk_aio_flush(BlockBackend *blk,
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
--=20
2.20.1


