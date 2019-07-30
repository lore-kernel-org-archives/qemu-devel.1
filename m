Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23216C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 01:57:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E38E7206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 01:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38E7206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsHNy-00086R-5E
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 21:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42890)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <balaton@eik.bme.hu>) id 1hsHNN-0007cJ-Qg
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 21:56:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1hsHNM-0000jB-QW
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 21:56:29 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:22716)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1hsHNM-0000h4-GY
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 21:56:28 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id EE6F87456E3;
 Tue, 30 Jul 2019 03:56:15 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 59D897456E0; Tue, 30 Jul 2019 03:56:15 +0200 (CEST)
Message-Id: <5778864958ee7bcaec1c77eed8e40c9e07ed6784.1564451616.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Tue, 30 Jul 2019 03:53:36 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
Subject: [Qemu-devel] [PATCH] ati-vga: Add limited support for big endian
 frame buffer aperture
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

Set frame buffer endianness according to requested endianness for
frame buffer aperture 0. This fixes inverted colors with Xorg frame
buffer driver. Setting endianness of aperture 1 and reg aperture are
not implemented.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati.c      | 9 ++++++++-
 hw/display/ati_int.h  | 1 +
 hw/display/ati_regs.h | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index d1db07dd2f..84961d193f 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -90,7 +90,8 @@ static void ati_vga_switch_mode(ATIVGAState *s)
             DPRINTF("Switching to %dx%d %d %d @ %x\n", h, v, stride, bpp=
, offs);
             vbe_ioport_write_index(&s->vga, 0, VBE_DISPI_INDEX_ENABLE);
             vbe_ioport_write_data(&s->vga, 0, VBE_DISPI_DISABLED);
-            s->vga.big_endian_fb =3D false;
+            s->vga.big_endian_fb =3D (s->regs.config_cntl & APER_0_ENDIA=
N ?
+                                    true : false);
             /* reset VBE regs then set up mode */
             s->vga.vbe_regs[VBE_DISPI_INDEX_XRES] =3D h;
             s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] =3D v;
@@ -311,6 +312,9 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr=
, unsigned int size)
     case PALETTE_DATA:
         val =3D vga_ioport_read(&s->vga, VGA_PEL_D);
         break;
+    case CNFG_CNTL:
+        val =3D s->regs.config_cntl;
+        break;
     case CNFG_MEMSIZE:
         val =3D s->vga.vram_size;
         break;
@@ -605,6 +609,9 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         data >>=3D 8;
         vga_ioport_write(&s->vga, VGA_PEL_D, data & 0xff);
         break;
+    case CNFG_CNTL:
+        s->regs.config_cntl =3D data;
+        break;
     case CRTC_H_TOTAL_DISP:
         s->regs.crtc_h_total_disp =3D data & 0x07ff07ff;
         break;
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index 31a1927b3e..5b4d3be1e6 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -39,6 +39,7 @@ typedef struct ATIVGARegs {
     uint32_t gpio_vga_ddc;
     uint32_t gpio_dvi_ddc;
     uint32_t gpio_monid;
+    uint32_t config_cntl;
     uint32_t crtc_h_total_disp;
     uint32_t crtc_h_sync_strt_wid;
     uint32_t crtc_v_total_disp;
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index 81fb5302c0..11a54caa83 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -313,6 +313,7 @@
 #define X_MPLL_REF_DIV_MASK                     0x000000FF
=20
 /* Config control values (CONFIG_CNTL) */
+#define APER_0_ENDIAN                           0x00000003
 #define CFG_VGA_IO_DIS                          0x00000400
=20
 /* CRTC control values (CRTC_GEN_CNTL) */
--=20
2.13.7


