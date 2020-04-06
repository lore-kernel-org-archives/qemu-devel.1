Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9D0C2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:16:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 556E2249BC
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S4GvjuCd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 556E2249BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLVLw-0001A1-FE
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 13:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jLVKu-0008Ek-Gf
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:15:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jLVKt-0007v5-9G
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:15:00 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21852
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jLVKt-0007ut-5B
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586193298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ffrbOYKKpOtjyl53EK/Dus3PVGrjCSoSZ4IwVsA07g8=;
 b=S4GvjuCdFl51CfOEpc1fPBl15QVsxIDR9Vq0ZhAzaRGtAOgK8y7yPTdrMywd0P/0m751MT
 ilAvYHn74/dMeXSuLbYQCuV7L4PTNoIstEiQuIsLQiHCIGh7eWDIlAKbPPiFqxXsoCBKTy
 w8Zv7ywmTmscujLISkVQTjrxCUQb5rw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-Mqg5bKTWNIuUP5DzvUb17Q-1; Mon, 06 Apr 2020 13:14:53 -0400
X-MC-Unique: Mqg5bKTWNIuUP5DzvUb17Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54593804E28;
 Mon,  6 Apr 2020 17:14:11 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-74.ams2.redhat.com [10.36.113.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C8B414FE5E;
 Mon,  6 Apr 2020 17:14:09 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 v2 1/3] block-backend: Reorder flush/pdiscard function
 definitions
Date: Mon,  6 Apr 2020 19:14:01 +0200
Message-Id: <20200406171403.6761-2-kwolf@redhat.com>
In-Reply-To: <20200406171403.6761-1-kwolf@redhat.com>
References: <20200406171403.6761-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

Move all variants of the flush/pdiscard functions to a single place and
put the blk_co_*() version first because it is called by all other
variants (and will become static in the next patch).

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/block-backend.c | 92 +++++++++++++++++++++----------------------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 8b8f2a80a0..17b2e87afa 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1488,38 +1488,6 @@ BlockAIOCB *blk_aio_pwritev(BlockBackend *blk, int64=
_t offset,
                         blk_aio_write_entry, flags, cb, opaque);
 }
=20
-static void blk_aio_flush_entry(void *opaque)
-{
-    BlkAioEmAIOCB *acb =3D opaque;
-    BlkRwCo *rwco =3D &acb->rwco;
-
-    rwco->ret =3D blk_co_flush(rwco->blk);
-    blk_aio_complete(acb);
-}
-
-BlockAIOCB *blk_aio_flush(BlockBackend *blk,
-                          BlockCompletionFunc *cb, void *opaque)
-{
-    return blk_aio_prwv(blk, 0, 0, NULL, blk_aio_flush_entry, 0, cb, opaqu=
e);
-}
-
-static void blk_aio_pdiscard_entry(void *opaque)
-{
-    BlkAioEmAIOCB *acb =3D opaque;
-    BlkRwCo *rwco =3D &acb->rwco;
-
-    rwco->ret =3D blk_co_pdiscard(rwco->blk, rwco->offset, acb->bytes);
-    blk_aio_complete(acb);
-}
-
-BlockAIOCB *blk_aio_pdiscard(BlockBackend *blk,
-                             int64_t offset, int bytes,
-                             BlockCompletionFunc *cb, void *opaque)
-{
-    return blk_aio_prwv(blk, offset, bytes, NULL, blk_aio_pdiscard_entry, =
0,
-                        cb, opaque);
-}
-
 void blk_aio_cancel(BlockAIOCB *acb)
 {
     bdrv_aio_cancel(acb);
@@ -1586,6 +1554,37 @@ int blk_co_pdiscard(BlockBackend *blk, int64_t offse=
t, int bytes)
     return bdrv_co_pdiscard(blk->root, offset, bytes);
 }
=20
+static void blk_aio_pdiscard_entry(void *opaque)
+{
+    BlkAioEmAIOCB *acb =3D opaque;
+    BlkRwCo *rwco =3D &acb->rwco;
+
+    rwco->ret =3D blk_co_pdiscard(rwco->blk, rwco->offset, acb->bytes);
+    blk_aio_complete(acb);
+}
+
+BlockAIOCB *blk_aio_pdiscard(BlockBackend *blk,
+                             int64_t offset, int bytes,
+                             BlockCompletionFunc *cb, void *opaque)
+{
+    return blk_aio_prwv(blk, offset, bytes, NULL, blk_aio_pdiscard_entry, =
0,
+                        cb, opaque);
+}
+
+static void blk_pdiscard_entry(void *opaque)
+{
+    BlkRwCo *rwco =3D opaque;
+    QEMUIOVector *qiov =3D rwco->iobuf;
+
+    rwco->ret =3D blk_co_pdiscard(rwco->blk, rwco->offset, qiov->size);
+    aio_wait_kick();
+}
+
+int blk_pdiscard(BlockBackend *blk, int64_t offset, int bytes)
+{
+    return blk_prw(blk, offset, NULL, bytes, blk_pdiscard_entry, 0);
+}
+
 int blk_co_flush(BlockBackend *blk)
 {
     blk_wait_while_drained(blk);
@@ -1597,6 +1596,21 @@ int blk_co_flush(BlockBackend *blk)
     return bdrv_co_flush(blk_bs(blk));
 }
=20
+static void blk_aio_flush_entry(void *opaque)
+{
+    BlkAioEmAIOCB *acb =3D opaque;
+    BlkRwCo *rwco =3D &acb->rwco;
+
+    rwco->ret =3D blk_co_flush(rwco->blk);
+    blk_aio_complete(acb);
+}
+
+BlockAIOCB *blk_aio_flush(BlockBackend *blk,
+                          BlockCompletionFunc *cb, void *opaque)
+{
+    return blk_aio_prwv(blk, 0, 0, NULL, blk_aio_flush_entry, 0, cb, opaqu=
e);
+}
+
 static void blk_flush_entry(void *opaque)
 {
     BlkRwCo *rwco =3D opaque;
@@ -2083,20 +2097,6 @@ int blk_truncate(BlockBackend *blk, int64_t offset, =
bool exact,
     return bdrv_truncate(blk->root, offset, exact, prealloc, errp);
 }
=20
-static void blk_pdiscard_entry(void *opaque)
-{
-    BlkRwCo *rwco =3D opaque;
-    QEMUIOVector *qiov =3D rwco->iobuf;
-
-    rwco->ret =3D blk_co_pdiscard(rwco->blk, rwco->offset, qiov->size);
-    aio_wait_kick();
-}
-
-int blk_pdiscard(BlockBackend *blk, int64_t offset, int bytes)
-{
-    return blk_prw(blk, offset, NULL, bytes, blk_pdiscard_entry, 0);
-}
-
 int blk_save_vmstate(BlockBackend *blk, const uint8_t *buf,
                      int64_t pos, int size)
 {
--=20
2.20.1


