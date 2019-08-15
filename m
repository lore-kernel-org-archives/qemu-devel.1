Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF37C3A59B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 22:33:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 830A8206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 22:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830A8206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyOIu-0004Ps-UH
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 18:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1hyOH9-00034f-O4
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 18:31:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1hyOH8-0006Ln-4f
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 18:31:19 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:47229)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1hyOH7-0006KU-Q2
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 18:31:18 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 9CB9174B841;
 Fri, 16 Aug 2019 00:31:14 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0A6407456D5; Fri, 16 Aug 2019 00:31:14 +0200 (CEST)
Message-Id: <89364275f2fb5f85ee73c0e76528aa91691a499a.1565907489.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1565907489.git.balaton@eik.bme.hu>
References: <cover.1565907489.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Fri, 16 Aug 2019 00:18:09 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
Subject: [Qemu-devel] [PATCH 1/3] ati-vga: Implement dummy VBlank IRQ
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

The MacOS driver exits if the card does not have an interrupt. If we
set PCI_INTERRUPT_PIN to 1 then it enables VBlank interrupts and it
boots but the mouse pointer cannot be moved. This patch implements a
dummy VBlank interrupt triggered by a 60 Hz timer. With this the
pointer now moves but MacOS still hangs somewhere before completely
finishing boot.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati.c      | 44 ++++++++++++++++++++++++++++++++++++++++++++
 hw/display/ati_dbg.c  |  1 +
 hw/display/ati_int.h  |  4 ++++
 hw/display/ati_regs.h |  6 ++++++
 4 files changed, 55 insertions(+)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index a365e2455d..87ad18664d 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -243,6 +243,21 @@ static uint64_t ati_i2c(bitbang_i2c_interface *i2c, =
uint64_t data, int base)
     return data;
 }
=20
+static void ati_vga_update_irq(ATIVGAState *s)
+{
+    pci_set_irq(&s->dev, !!(s->regs.gen_int_status & s->regs.gen_int_cnt=
l));
+}
+
+static void ati_vga_vblank_irq(void *opaque)
+{
+    ATIVGAState *s =3D opaque;
+
+    timer_mod(&s->vblank_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+              NANOSECONDS_PER_SECOND / 60);
+    s->regs.gen_int_status |=3D CRTC_VBLANK_INT;
+    ati_vga_update_irq(s);
+}
+
 static inline uint64_t ati_reg_read_offs(uint32_t reg, int offs,
                                          unsigned int size)
 {
@@ -283,6 +298,12 @@ static uint64_t ati_mm_read(void *opaque, hwaddr add=
r, unsigned int size)
                                 addr - (BIOS_0_SCRATCH + i * 4), size);
         break;
     }
+    case GEN_INT_CNTL:
+        val =3D s->regs.gen_int_cntl;
+        break;
+    case GEN_INT_STATUS:
+        val =3D s->regs.gen_int_status;
+        break;
     case CRTC_GEN_CNTL ... CRTC_GEN_CNTL + 3:
         val =3D ati_reg_read_offs(s->regs.crtc_gen_cntl,
                                 addr - CRTC_GEN_CNTL, size);
@@ -512,6 +533,21 @@ static void ati_mm_write(void *opaque, hwaddr addr,
                            addr - (BIOS_0_SCRATCH + i * 4), data, size);
         break;
     }
+    case GEN_INT_CNTL:
+        s->regs.gen_int_cntl =3D data;
+        if (data & CRTC_VBLANK_INT) {
+            ati_vga_vblank_irq(s);
+        } else {
+            timer_del(&s->vblank_timer);
+            ati_vga_update_irq(s);
+        }
+        break;
+    case GEN_INT_STATUS:
+        data &=3D (s->dev_id =3D=3D PCI_DEVICE_ID_ATI_RAGE128_PF ?
+                 0x000f040fUL : 0xfc080effUL);
+        s->regs.gen_int_status &=3D ~data;
+        ati_vga_update_irq(s);
+        break;
     case CRTC_GEN_CNTL ... CRTC_GEN_CNTL + 3:
     {
         uint32_t val =3D s->regs.crtc_gen_cntl;
@@ -902,12 +938,19 @@ static void ati_vga_realize(PCIDevice *dev, Error *=
*errp)
     pci_register_bar(dev, 0, PCI_BASE_ADDRESS_MEM_PREFETCH, &vga->vram);
     pci_register_bar(dev, 1, PCI_BASE_ADDRESS_SPACE_IO, &s->io);
     pci_register_bar(dev, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mm);
+
+    /* most interrupts are not yet emulated but MacOS needs at least VBl=
ank */
+    dev->config[PCI_INTERRUPT_PIN] =3D 1;
+    timer_init_ns(&s->vblank_timer, QEMU_CLOCK_VIRTUAL, ati_vga_vblank_i=
rq, s);
 }
=20
 static void ati_vga_reset(DeviceState *dev)
 {
     ATIVGAState *s =3D ATI_VGA(dev);
=20
+    timer_del(&s->vblank_timer);
+    ati_vga_update_irq(s);
+
     /* reset vga */
     vga_common_reset(&s->vga);
     s->mode =3D VGA_MODE;
@@ -917,6 +960,7 @@ static void ati_vga_exit(PCIDevice *dev)
 {
     ATIVGAState *s =3D ATI_VGA(dev);
=20
+    timer_del(&s->vblank_timer);
     graphic_console_close(s->vga.con);
 }
=20
diff --git a/hw/display/ati_dbg.c b/hw/display/ati_dbg.c
index 7e59c41ac2..0ebbd36f14 100644
--- a/hw/display/ati_dbg.c
+++ b/hw/display/ati_dbg.c
@@ -16,6 +16,7 @@ static struct ati_regdesc ati_reg_names[] =3D {
     {"BUS_CNTL", 0x0030},
     {"BUS_CNTL1", 0x0034},
     {"GEN_INT_CNTL", 0x0040},
+    {"GEN_INT_STATUS", 0x0044},
     {"CRTC_GEN_CNTL", 0x0050},
     {"CRTC_EXT_CNTL", 0x0054},
     {"DAC_CNTL", 0x0058},
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index 5b4d3be1e6..2a16708e4f 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -9,6 +9,7 @@
 #ifndef ATI_INT_H
 #define ATI_INT_H
=20
+#include "qemu/timer.h"
 #include "hw/pci/pci.h"
 #include "hw/i2c/bitbang_i2c.h"
 #include "vga_int.h"
@@ -33,6 +34,8 @@
 typedef struct ATIVGARegs {
     uint32_t mm_index;
     uint32_t bios_scratch[8];
+    uint32_t gen_int_cntl;
+    uint32_t gen_int_status;
     uint32_t crtc_gen_cntl;
     uint32_t crtc_ext_cntl;
     uint32_t dac_cntl;
@@ -89,6 +92,7 @@ typedef struct ATIVGAState {
     uint16_t cursor_size;
     uint32_t cursor_offset;
     QEMUCursor *cursor;
+    QEMUTimer vblank_timer;
     bitbang_i2c_interface bbi2c;
     MemoryRegion io;
     MemoryRegion mm;
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index 02046e97c2..ebd37ee30d 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -34,6 +34,7 @@
 #define BUS_CNTL                                0x0030
 #define BUS_CNTL1                               0x0034
 #define GEN_INT_CNTL                            0x0040
+#define GEN_INT_STATUS                          0x0044
 #define CRTC_GEN_CNTL                           0x0050
 #define CRTC_EXT_CNTL                           0x0054
 #define DAC_CNTL                                0x0058
@@ -316,6 +317,11 @@
 #define XPLL_FB_DIV_MASK                        0x0000FF00
 #define X_MPLL_REF_DIV_MASK                     0x000000FF
=20
+/* GEN_INT_CNTL) */
+#define CRTC_VBLANK_INT                         0x00000001
+#define CRTC_VLINE_INT                          0x00000002
+#define CRTC_VSYNC_INT                          0x00000004
+
 /* Config control values (CONFIG_CNTL) */
 #define APER_0_ENDIAN                           0x00000003
 #define APER_1_ENDIAN                           0x0000000c
--=20
2.13.7


