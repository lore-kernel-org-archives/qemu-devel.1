Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6170C32771
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 01:08:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 826CF21739
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 01:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BImSBpsV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826CF21739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52875 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwFMf-0003bh-Op
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 20:08:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iwFLc-0002CY-0w
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 20:07:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iwFLa-0003TV-NM
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 20:07:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20228
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1iwFLa-0003TA-Jw
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 20:07:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580173638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O9xC74yWJ9mbCiU1xQq2wAud7U8Mw1JfFxaKeDu30EI=;
 b=BImSBpsVJMXI8MfJEko28nJYMZNfyVvs6/Ib1GOQatOkqm+Yl91j2aw6lztqGwlXQBERKT
 ii/+1OTI4MUEoXBCbwy454EUrPWIUgN+3SIMG+wCVolBqQxkL3+MaETVKMn4/qoV3em4CV
 YIUT6gyka+BAmmMUMJeSFfnXWGj2b0w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-bSvrcc-lOoqm9vXI7wTj7g-1; Mon, 27 Jan 2020 20:07:13 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66D1B1800D41;
 Tue, 28 Jan 2020 01:07:12 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-116.bos.redhat.com [10.18.17.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 92D035D9CA;
 Tue, 28 Jan 2020 01:07:11 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 1/2] ide: Fix incorrect handling of some PRDTs in ide_dma_cb()
Date: Mon, 27 Jan 2020 20:07:06 -0500
Message-Id: <20200128010707.19572-2-jsnow@redhat.com>
In-Reply-To: <20200128010707.19572-1-jsnow@redhat.com>
References: <20200128010707.19572-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: bSvrcc-lOoqm9vXI7wTj7g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alexander Popov <alex.popov@linux.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Popov <alex.popov@linux.com>

The commit a718978ed58a from July 2015 introduced the assertion which
implies that the size of successful DMA transfers handled in ide_dma_cb()
should be multiple of 512 (the size of a sector). But guest systems can
initiate DMA transfers that don't fit this requirement.

For fixing that let's check the number of bytes prepared for the transfer
by the prepare_buf() handler. The code in ide_dma_cb() must behave
according to the Programming Interface for Bus Master IDE Controller
(Revision 1.0 5/16/94):
1. If PRDs specified a smaller size than the IDE transfer
   size, then the Interrupt and Active bits in the Controller
   status register are not set (Error Condition).
2. If the size of the physical memory regions was equal to
   the IDE device transfer size, the Interrupt bit in the
   Controller status register is set to 1, Active bit is set to 0.
3. If PRDs specified a larger size than the IDE transfer size,
   the Interrupt and Active bits in the Controller status register
   are both set to 1.

Signed-off-by: Alexander Popov <alex.popov@linux.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-id: 20191223175117.508990-2-alex.popov@linux.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/core.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 754ff4dc34..80000eb766 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -849,6 +849,7 @@ static void ide_dma_cb(void *opaque, int ret)
     int64_t sector_num;
     uint64_t offset;
     bool stay_active =3D false;
+    int32_t prep_size =3D 0;
=20
     if (ret =3D=3D -EINVAL) {
         ide_dma_error(s);
@@ -863,13 +864,15 @@ static void ide_dma_cb(void *opaque, int ret)
         }
     }
=20
-    n =3D s->io_buffer_size >> 9;
-    if (n > s->nsector) {
-        /* The PRDs were longer than needed for this request. Shorten them=
 so
-         * we don't get a negative remainder. The Active bit must remain s=
et
-         * after the request completes. */
+    if (s->io_buffer_size > s->nsector * 512) {
+        /*
+         * The PRDs were longer than needed for this request.
+         * The Active bit must remain set after the request completes.
+         */
         n =3D s->nsector;
         stay_active =3D true;
+    } else {
+        n =3D s->io_buffer_size >> 9;
     }
=20
     sector_num =3D ide_get_sector(s);
@@ -892,9 +895,20 @@ static void ide_dma_cb(void *opaque, int ret)
     n =3D s->nsector;
     s->io_buffer_index =3D 0;
     s->io_buffer_size =3D n * 512;
-    if (s->bus->dma->ops->prepare_buf(s->bus->dma, s->io_buffer_size) < 51=
2) {
-        /* The PRDs were too short. Reset the Active bit, but don't raise =
an
-         * interrupt. */
+    prep_size =3D s->bus->dma->ops->prepare_buf(s->bus->dma, s->io_buffer_=
size);
+    /* prepare_buf() must succeed and respect the limit */
+    assert(prep_size >=3D 0 && prep_size <=3D n * 512);
+
+    /*
+     * Now prep_size stores the number of bytes in the sglist, and
+     * s->io_buffer_size stores the number of bytes described by the PRDs.
+     */
+
+    if (prep_size < n * 512) {
+        /*
+         * The PRDs are too short for this request. Error condition!
+         * Reset the Active bit and don't raise the interrupt.
+         */
         s->status =3D READY_STAT | SEEK_STAT;
         dma_buf_commit(s, 0);
         goto eot;
--=20
2.21.0


