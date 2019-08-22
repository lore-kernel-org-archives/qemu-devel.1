Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB39EC3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 08:13:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9018E20870
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 08:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9018E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0iDu-0007Vm-Fz
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 04:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1i0i5p-0007OX-3e
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:05:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1i0i5n-0005rz-KE
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:05:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56054)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1i0i5n-0005rF-Bp
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:05:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9FBDB18C890E;
 Thu, 22 Aug 2019 08:05:10 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-60.ams2.redhat.com
 [10.36.116.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9E2A21001B20;
 Thu, 22 Aug 2019 08:05:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 52B8C783A; Thu, 22 Aug 2019 10:05:03 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 10:05:02 +0200
Message-Id: <20190822080503.12063-9-kraxel@redhat.com>
In-Reply-To: <20190822080503.12063-1-kraxel@redhat.com>
References: <20190822080503.12063-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Thu, 22 Aug 2019 08:05:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 8/8] ati-vga: Implement dummy VBlank IRQ
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

The MacOS driver exits if the card does not have an interrupt. If we
set PCI_INTERRUPT_PIN to 1 then it enables VBlank interrupts and it
boots but the mouse pointer cannot be moved. This patch implements a
dummy VBlank interrupt triggered by a 60 Hz timer. With this the
pointer now moves but MacOS still hangs somewhere before completely
finishing boot.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-Id: <89364275f2fb5f85ee73c0e76528aa91691a499a.1565907489.git.balaton@eik.bme.hu>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/ati_int.h  |  4 ++++
 hw/display/ati_regs.h |  6 ++++++
 hw/display/ati.c      | 44 +++++++++++++++++++++++++++++++++++++++++++
 hw/display/ati_dbg.c  |  1 +
 4 files changed, 55 insertions(+)

diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index 5b4d3be1e626..2a16708e4f3e 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -9,6 +9,7 @@
 #ifndef ATI_INT_H
 #define ATI_INT_H
 
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
index 02046e97c298..ebd37ee30d3f 100644
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
 
+/* GEN_INT_CNTL) */
+#define CRTC_VBLANK_INT                         0x00000001
+#define CRTC_VLINE_INT                          0x00000002
+#define CRTC_VSYNC_INT                          0x00000004
+
 /* Config control values (CONFIG_CNTL) */
 #define APER_0_ENDIAN                           0x00000003
 #define APER_1_ENDIAN                           0x0000000c
diff --git a/hw/display/ati.c b/hw/display/ati.c
index cceb45b34a58..8f940eee221a 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -243,6 +243,21 @@ static uint64_t ati_i2c(bitbang_i2c_interface *i2c, uint64_t data, int base)
     return data;
 }
 
+static void ati_vga_update_irq(ATIVGAState *s)
+{
+    pci_set_irq(&s->dev, !!(s->regs.gen_int_status & s->regs.gen_int_cntl));
+}
+
+static void ati_vga_vblank_irq(void *opaque)
+{
+    ATIVGAState *s = opaque;
+
+    timer_mod(&s->vblank_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+              NANOSECONDS_PER_SECOND / 60);
+    s->regs.gen_int_status |= CRTC_VBLANK_INT;
+    ati_vga_update_irq(s);
+}
+
 static inline uint64_t ati_reg_read_offs(uint32_t reg, int offs,
                                          unsigned int size)
 {
@@ -283,6 +298,12 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
                                 addr - (BIOS_0_SCRATCH + i * 4), size);
         break;
     }
+    case GEN_INT_CNTL:
+        val = s->regs.gen_int_cntl;
+        break;
+    case GEN_INT_STATUS:
+        val = s->regs.gen_int_status;
+        break;
     case CRTC_GEN_CNTL ... CRTC_GEN_CNTL + 3:
         val = ati_reg_read_offs(s->regs.crtc_gen_cntl,
                                 addr - CRTC_GEN_CNTL, size);
@@ -512,6 +533,21 @@ static void ati_mm_write(void *opaque, hwaddr addr,
                            addr - (BIOS_0_SCRATCH + i * 4), data, size);
         break;
     }
+    case GEN_INT_CNTL:
+        s->regs.gen_int_cntl = data;
+        if (data & CRTC_VBLANK_INT) {
+            ati_vga_vblank_irq(s);
+        } else {
+            timer_del(&s->vblank_timer);
+            ati_vga_update_irq(s);
+        }
+        break;
+    case GEN_INT_STATUS:
+        data &= (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF ?
+                 0x000f040fUL : 0xfc080effUL);
+        s->regs.gen_int_status &= ~data;
+        ati_vga_update_irq(s);
+        break;
     case CRTC_GEN_CNTL ... CRTC_GEN_CNTL + 3:
     {
         uint32_t val = s->regs.crtc_gen_cntl;
@@ -902,12 +938,19 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
     pci_register_bar(dev, 0, PCI_BASE_ADDRESS_MEM_PREFETCH, &vga->vram);
     pci_register_bar(dev, 1, PCI_BASE_ADDRESS_SPACE_IO, &s->io);
     pci_register_bar(dev, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mm);
+
+    /* most interrupts are not yet emulated but MacOS needs at least VBlank */
+    dev->config[PCI_INTERRUPT_PIN] = 1;
+    timer_init_ns(&s->vblank_timer, QEMU_CLOCK_VIRTUAL, ati_vga_vblank_irq, s);
 }
 
 static void ati_vga_reset(DeviceState *dev)
 {
     ATIVGAState *s = ATI_VGA(dev);
 
+    timer_del(&s->vblank_timer);
+    ati_vga_update_irq(s);
+
     /* reset vga */
     vga_common_reset(&s->vga);
     s->mode = VGA_MODE;
@@ -917,6 +960,7 @@ static void ati_vga_exit(PCIDevice *dev)
 {
     ATIVGAState *s = ATI_VGA(dev);
 
+    timer_del(&s->vblank_timer);
     graphic_console_close(s->vga.con);
 }
 
diff --git a/hw/display/ati_dbg.c b/hw/display/ati_dbg.c
index 7e59c41ac2ce..0ebbd36f1477 100644
--- a/hw/display/ati_dbg.c
+++ b/hw/display/ati_dbg.c
@@ -16,6 +16,7 @@ static struct ati_regdesc ati_reg_names[] = {
     {"BUS_CNTL", 0x0030},
     {"BUS_CNTL1", 0x0034},
     {"GEN_INT_CNTL", 0x0040},
+    {"GEN_INT_STATUS", 0x0044},
     {"CRTC_GEN_CNTL", 0x0050},
     {"CRTC_EXT_CNTL", 0x0054},
     {"DAC_CNTL", 0x0058},
-- 
2.18.1


