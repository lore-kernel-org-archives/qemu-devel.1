Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D900C282DC
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 11:54:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3193220835
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 11:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3193220835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51130 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGj9S-0006XK-9l
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 07:54:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hGj8S-00066V-UT
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 07:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hGj8R-0003Rx-SZ
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 07:53:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>)
	id 1hGj8P-0003PL-Ln; Wed, 17 Apr 2019 07:53:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7EA854E93D;
	Wed, 17 Apr 2019 11:53:48 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-112-44.ams2.redhat.com
	[10.36.112.44])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B77F7608C1;
	Wed, 17 Apr 2019 11:53:44 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 17 Apr 2019 13:53:43 +0200
Message-Id: <20190417115343.30527-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Wed, 17 Apr 2019 11:53:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] scsi-generic: prevent guest from exceeding
 SG_IO limits
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-stable@nongnu.org,
	qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190417115343.lHjn8cubFaRKbB5cjzrRduAzg1spBOsy02QGH-_kyRY@z>

Linux places a limit of UIO_MAXIOV pages on SG_IO ioctls (and if the limi=
t
is exceeded, a confusing ENOMEM error is returned[1]).  Prevent the guest
from exceeding these limits, by capping the maximum transfer length to
that value in the block limits VPD page.

[1] Oh well, at least it was easier to follow the kernel source knowing
    it had to end as ENOMEM...

Cc: qemu-stable@nongnu.org
Cc: qemu-block@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-generic.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index d82b462be4..4134d8389b 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -131,6 +131,17 @@ static int execute_command(BlockBackend *blk,
     return 0;
 }
=20
+/*
+ * Linux places a hard limit on SG_IO transfers equal to UIO_MAXIOV
+ * pages, which we need to factor in the block limits we return.
+ */
+static uint32_t sg_max_transfer(SCSIDevice *s)
+{
+    uint32_t max_transfer =3D blk_get_max_transfer(s->conf.blk);
+    max_transfer =3D MIN_NON_ZERO(max_transfer, UIO_MAXIOV * qemu_real_h=
ost_page_size);
+    return max_transfer / s->blocksize;
+}
+
 static void scsi_handle_inquiry_reply(SCSIGenericReq *r, SCSIDevice *s)
 {
     uint8_t page, page_idx;
@@ -162,10 +173,8 @@ static void scsi_handle_inquiry_reply(SCSIGenericReq=
 *r, SCSIDevice *s)
     if (s->type =3D=3D TYPE_DISK && (r->req.cmd.buf[1] & 0x01)) {
         page =3D r->req.cmd.buf[2];
         if (page =3D=3D 0xb0) {
-            uint32_t max_transfer =3D
-                blk_get_max_transfer(s->conf.blk) / s->blocksize;
+            uint32_t max_transfer =3D sg_max_transfer(s);
=20
-            assert(max_transfer);
             stl_be_p(&r->buf[8], max_transfer);
             /* Also take care of the opt xfer len. */
             stl_be_p(&r->buf[12],
@@ -206,7 +215,7 @@ static int scsi_generic_emulate_block_limits(SCSIGene=
ricReq *r, SCSIDevice *s)
     uint8_t buf[64];
=20
     SCSIBlockLimits bl =3D {
-        .max_io_sectors =3D blk_get_max_transfer(s->conf.blk) / s->block=
size
+        .max_io_sectors =3D sg_max_transfer(s)
     };
=20
     memset(r->buf, 0, r->buflen);
--=20
2.21.0


