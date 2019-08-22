Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6448C3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 08:09:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E26A20870
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 08:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E26A20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0iAL-0003tJ-E7
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 04:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53946)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1i0i5m-0007M0-LN
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1i0i5l-0005pq-7q
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:05:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56048)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1i0i5k-0005on-Ue
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:05:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2349C18C8905;
 Thu, 22 Aug 2019 08:05:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-60.ams2.redhat.com
 [10.36.116.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A04F85DC1E;
 Thu, 22 Aug 2019 08:05:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 46891935A; Thu, 22 Aug 2019 10:05:03 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 10:05:01 +0200
Message-Id: <20190822080503.12063-8-kraxel@redhat.com>
In-Reply-To: <20190822080503.12063-1-kraxel@redhat.com>
References: <20190822080503.12063-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Thu, 22 Aug 2019 08:05:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 7/8] ati-vga: Add limited support for big endian
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

From: BALATON Zoltan <balaton@eik.bme.hu>

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
Message-id: e2a7ec7af3fc30523213bcd27832ccad34323f2c.1565558093.git.balaton@eik.bme.hu
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/ati_int.h  |  1 +
 hw/display/ati_regs.h |  2 ++
 hw/display/ati.c      | 10 +++++++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index 31a1927b3ecb..5b4d3be1e626 100644
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
index 91947ab1e7f7..02046e97c298 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -317,6 +317,8 @@
 #define X_MPLL_REF_DIV_MASK                     0x000000FF
 
 /* Config control values (CONFIG_CNTL) */
+#define APER_0_ENDIAN                           0x00000003
+#define APER_1_ENDIAN                           0x0000000c
 #define CFG_VGA_IO_DIS                          0x00000400
 
 /* CRTC control values (CRTC_GEN_CNTL) */
diff --git a/hw/display/ati.c b/hw/display/ati.c
index f24c23fa89c8..cceb45b34a58 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -90,7 +90,9 @@ static void ati_vga_switch_mode(ATIVGAState *s)
             DPRINTF("Switching to %dx%d %d %d @ %x\n", h, v, stride, bpp, offs);
             vbe_ioport_write_index(&s->vga, 0, VBE_DISPI_INDEX_ENABLE);
             vbe_ioport_write_data(&s->vga, 0, VBE_DISPI_DISABLED);
-            s->vga.big_endian_fb = false;
+            s->vga.big_endian_fb = (s->regs.config_cntl & APER_0_ENDIAN ||
+                                    s->regs.config_cntl & APER_1_ENDIAN ?
+                                    true : false);
             /* reset VBE regs then set up mode */
             s->vga.vbe_regs[VBE_DISPI_INDEX_XRES] = h;
             s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] = v;
@@ -310,6 +312,9 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
     case PALETTE_DATA:
         val = vga_ioport_read(&s->vga, VGA_PEL_D);
         break;
+    case CNFG_CNTL:
+        val = s->regs.config_cntl;
+        break;
     case CNFG_MEMSIZE:
         val = s->vga.vram_size;
         break;
@@ -604,6 +609,9 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         data >>= 8;
         vga_ioport_write(&s->vga, VGA_PEL_D, data & 0xff);
         break;
+    case CNFG_CNTL:
+        s->regs.config_cntl = data;
+        break;
     case CRTC_H_TOTAL_DISP:
         s->regs.crtc_h_total_disp = data & 0x07ff07ff;
         break;
-- 
2.18.1


