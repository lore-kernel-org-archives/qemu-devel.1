Return-Path: <SRS0=60Ee=WH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711F1C32756
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 21:34:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4993920844
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 21:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4993920844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwvTo-0003dy-HR
	for qemu-devel@archiver.kernel.org; Sun, 11 Aug 2019 17:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58195)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <balaton@eik.bme.hu>) id 1hwvSz-00020P-7w
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 17:33:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1hwvSy-000478-3m
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 17:33:29 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:55471)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1hwvSx-000465-QP
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 17:33:28 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id A29F974CED6;
 Sun, 11 Aug 2019 23:33:12 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id EDC1874C659; Sun, 11 Aug 2019 23:33:11 +0200 (CEST)
Message-Id: <e2a7ec7af3fc30523213bcd27832ccad34323f2c.1565558093.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1565558093.git.balaton@eik.bme.hu>
References: <cover.1565558093.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Sun, 11 Aug 2019 23:14:53 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
Subject: [Qemu-devel] [PATCH 7/7] ati-vga: Add limited support for big
 endian frame buffer aperture
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
frame buffer apertures. We set frame buffer to big endian if any of
the two apertures are set to big endian. Using different endianness
for the two apertures is not implemented. This fixes inverted colors
with MacOS and Xorg frame buffer driver but some Linux drivers may
have endianness issues even on real hardware so this may not fix all
cases. MorphOS uses aper0 in LE, Linux uses aper0 in BE and MacOS uses
aper1 in BE but not sure about others or if MacOS also may need aper0
in which case we'll need a more complex fix but MacOS has other
problems yet so for now this might work.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati.c      | 10 +++++++++-
 hw/display/ati_int.h  |  1 +
 hw/display/ati_regs.h |  2 ++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 0bfe73179d..a365e2455d 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -90,7 +90,9 @@ static void ati_vga_switch_mode(ATIVGAState *s)
             DPRINTF("Switching to %dx%d %d %d @ %x\n", h, v, stride, bpp=
, offs);
             vbe_ioport_write_index(&s->vga, 0, VBE_DISPI_INDEX_ENABLE);
             vbe_ioport_write_data(&s->vga, 0, VBE_DISPI_DISABLED);
-            s->vga.big_endian_fb =3D false;
+            s->vga.big_endian_fb =3D (s->regs.config_cntl & APER_0_ENDIA=
N ||
+                                    s->regs.config_cntl & APER_1_ENDIAN =
?
+                                    true : false);
             /* reset VBE regs then set up mode */
             s->vga.vbe_regs[VBE_DISPI_INDEX_XRES] =3D h;
             s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] =3D v;
@@ -310,6 +312,9 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr=
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
@@ -604,6 +609,9 @@ static void ati_mm_write(void *opaque, hwaddr addr,
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
index 91947ab1e7..02046e97c2 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -317,6 +317,8 @@
 #define X_MPLL_REF_DIV_MASK                     0x000000FF
=20
 /* Config control values (CONFIG_CNTL) */
+#define APER_0_ENDIAN                           0x00000003
+#define APER_1_ENDIAN                           0x0000000c
 #define CFG_VGA_IO_DIS                          0x00000400
=20
 /* CRTC control values (CRTC_GEN_CNTL) */
--=20
2.13.7


