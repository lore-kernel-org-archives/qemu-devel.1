Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA534C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:27:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD88821951
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD88821951
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqfel-00007I-0Q
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 11:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47867)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <balaton@eik.bme.hu>) id 1hqfeY-0007pf-R5
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:27:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1hqfeT-0008Su-Je
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:27:34 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:28210)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1hqfeT-0008S7-9X
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:27:29 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 1DC4C7456C8;
 Thu, 25 Jul 2019 17:27:27 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0019E7456B4; Thu, 25 Jul 2019 17:27:26 +0200 (CEST)
Message-Id: <e626b64a89116e519e6c307c83dc8624616cf309.1564068311.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Thu, 25 Jul 2019 17:25:11 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
Subject: [Qemu-devel] [PATCH] ati-vga: Attempt to handle CRTC offset not
 exact multiple of stride
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MacOS seems to need this and the resulting vbe_start_addr seems
correct but I'm not sure this is how it should work (picture is still
broken with MacOS but probably due to firmware problems now).

It also occured to me that these CRTC regs are also present in VGA so
I wonder if they should be shared in case some drivers try to poke
them via VGA regs. Added a comment noting this although in practice
drivers I've tried so far program the card accessing ati regs so I did
not attempt to change it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index b849f5d510..d1db07dd2f 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -50,6 +50,7 @@ static void ati_vga_switch_mode(ATIVGAState *s)
         s->mode =3D EXT_MODE;
         if (s->regs.crtc_gen_cntl & CRTC2_EN) {
             /* CRT controller enabled, use CRTC values */
+            /* FIXME Should these be the same as VGA CRTC regs? */
             uint32_t offs =3D s->regs.crtc_offset & 0x07ffffff;
             int stride =3D (s->regs.crtc_pitch & 0x7ff) * 8;
             int bpp =3D 0;
@@ -103,14 +104,20 @@ static void ati_vga_switch_mode(ATIVGAState *s)
             if (stride) {
                 vbe_ioport_write_index(&s->vga, 0, VBE_DISPI_INDEX_VIRT_=
WIDTH);
                 vbe_ioport_write_data(&s->vga, 0, stride);
-                if (offs % stride =3D=3D 0) {
-                    vbe_ioport_write_index(&s->vga, 0, VBE_DISPI_INDEX_Y=
_OFFSET);
-                    vbe_ioport_write_data(&s->vga, 0, offs / stride);
-                } else {
-                    /* FIXME what to do with this? */
-                    error_report("VGA offset is not multiple of pitch, "
-                                 "expect bad picture");
+                if (offs % stride) {
+                    /* FIXME Is this correct? */
+                    warn_report("CRTC offset is not multiple of pitch");
+                    vbe_ioport_write_index(&s->vga, 0,
+                                           VBE_DISPI_INDEX_X_OFFSET);
+                    vbe_ioport_write_data(&s->vga, 0,
+                                          offs % stride / (bpp / 8));
                 }
+                vbe_ioport_write_index(&s->vga, 0, VBE_DISPI_INDEX_Y_OFF=
SET);
+                vbe_ioport_write_data(&s->vga, 0, offs / stride);
+                DPRINTF("VBE offset (%d,%d), vbe_start_addr=3D%x\n",
+                        s->vga.vbe_regs[VBE_DISPI_INDEX_X_OFFSET],
+                        s->vga.vbe_regs[VBE_DISPI_INDEX_Y_OFFSET],
+                        s->vga.vbe_start_addr);
             }
         }
     } else {
--=20
2.13.7


