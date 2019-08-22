Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B66C3A5A2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 08:13:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2E9020870
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 08:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E9020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0iDu-0007UZ-Oe
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 04:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53987)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1i0i5q-0007QY-Op
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:05:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1i0i5p-0005tD-Ff
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:05:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44736)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1i0i5p-0005sb-8C
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:05:13 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8FDBC308427C;
 Thu, 22 Aug 2019 08:05:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-60.ams2.redhat.com
 [10.36.116.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F70D60E1C;
 Thu, 22 Aug 2019 08:05:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3BDCD934B; Thu, 22 Aug 2019 10:05:03 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 10:05:00 +0200
Message-Id: <20190822080503.12063-7-kraxel@redhat.com>
In-Reply-To: <20190822080503.12063-1-kraxel@redhat.com>
References: <20190822080503.12063-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 22 Aug 2019 08:05:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 6/8] ati-vga: Attempt to handle CRTC offset not
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

From: BALATON Zoltan <balaton@eik.bme.hu>

MacOS uses non-0 offset so it needs this and the resulting
vbe_start_addr seems correct but picture is still broken with OpenBIOS
after FCode runs but that maybe due to firmware problems now. After
boot, picture is now correct.

It also occured to me that these CRTC regs are also present in VGA so
I wonder if they should be shared in case some drivers try to poke
them via VGA regs or these are a separate set of regs for extended
mode. Added a comment noting this but drivers I've tried so far
program the card accessing ati regs so I did not attempt to change it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-id: 1c6fce457ef7e6f889e38dc0423791be92310a62.1565558093.git.balaton@eik.bme.hu
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/ati.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index ff04f7eb4a2d..f24c23fa89c8 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -50,6 +50,7 @@ static void ati_vga_switch_mode(ATIVGAState *s)
         s->mode = EXT_MODE;
         if (s->regs.crtc_gen_cntl & CRTC2_EN) {
             /* CRT controller enabled, use CRTC values */
+            /* FIXME Should these be the same as VGA CRTC regs? */
             uint32_t offs = s->regs.crtc_offset & 0x07ffffff;
             int stride = (s->regs.crtc_pitch & 0x7ff) * 8;
             int bpp = 0;
@@ -101,16 +102,23 @@ static void ati_vga_switch_mode(ATIVGAState *s)
                 (s->regs.dac_cntl & DAC_8BIT_EN ? VBE_DISPI_8BIT_DAC : 0));
             /* now set offset and stride after enable as that resets these */
             if (stride) {
+                int bypp = DIV_ROUND_UP(bpp, BITS_PER_BYTE);
+
                 vbe_ioport_write_index(&s->vga, 0, VBE_DISPI_INDEX_VIRT_WIDTH);
                 vbe_ioport_write_data(&s->vga, 0, stride);
-                if (offs % stride == 0) {
-                    vbe_ioport_write_index(&s->vga, 0, VBE_DISPI_INDEX_Y_OFFSET);
-                    vbe_ioport_write_data(&s->vga, 0, offs / stride);
-                } else {
-                    /* FIXME what to do with this? */
-                    error_report("VGA offset is not multiple of pitch, "
-                                 "expect bad picture");
+                stride *= bypp;
+                if (offs % stride) {
+                    DPRINTF("CRTC offset is not multiple of pitch\n");
+                    vbe_ioport_write_index(&s->vga, 0,
+                                           VBE_DISPI_INDEX_X_OFFSET);
+                    vbe_ioport_write_data(&s->vga, 0, offs % stride / bypp);
                 }
+                vbe_ioport_write_index(&s->vga, 0, VBE_DISPI_INDEX_Y_OFFSET);
+                vbe_ioport_write_data(&s->vga, 0, offs / stride);
+                DPRINTF("VBE offset (%d,%d), vbe_start_addr=%x\n",
+                        s->vga.vbe_regs[VBE_DISPI_INDEX_X_OFFSET],
+                        s->vga.vbe_regs[VBE_DISPI_INDEX_Y_OFFSET],
+                        s->vga.vbe_start_addr);
             }
         }
     } else {
-- 
2.18.1


