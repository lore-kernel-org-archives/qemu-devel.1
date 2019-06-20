Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B95C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 11:59:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 995EB206E0
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 11:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 995EB206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46668 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdvjK-0000wz-Ht
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 07:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55387)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <balaton@eik.bme.hu>) id 1hdvYa-0008DQ-L7
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 07:48:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1hdvT2-00007y-Kr
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 07:43:02 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:12613)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1hduqT-0008RC-Lf
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 07:03:09 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 14261746395;
 Thu, 20 Jun 2019 13:02:50 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6352E7462BB; Thu, 20 Jun 2019 13:02:49 +0200 (CEST)
Message-Id: <046ddebb7ec8db48c4e877ee444ec1c41e385a74.1561028123.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1561028123.git.balaton@eik.bme.hu>
References: <cover.1561028123.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Thu, 20 Jun 2019 12:55:23 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
Subject: [Qemu-devel] [PATCH v5 2/2] ati-vga: Implement DDC and EDID info
 from monitor
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
Cc: Corey Minyard <cminyard@mvista.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds DDC support to ati-vga and connects i2c-ddc to it. This
allows at least MacOS with an ATI ndrv, Linux radeonfb and MorphOS to
get monitor EDID info (although MorphOS splash screen is not displayed
and radeonfb needs additional tables from vgabios-rv100). Xorg needs
additional support from VESA vgabios, it's missing INT10 0x4F15
function (see
https://gitlab.freedesktop.org/xorg/xserver/blob/master/hw/xfree86/vbe/vb=
e.c)
without which no DDC is available that also prevents loading the
accelerated X driver.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/Kconfig    |  2 ++
 hw/display/ati.c      | 60 +++++++++++++++++++++++++++++++++++++++++++++=
++++--
 hw/display/ati_int.h  |  5 +++++
 hw/display/ati_regs.h |  2 ++
 4 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index 910dccb2f7..cbdf7b1a67 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -130,3 +130,5 @@ config ATI_VGA
     default y if PCI_DEVICES
     depends on PCI
     select VGA
+    select BITBANG_I2C
+    select DDC
diff --git a/hw/display/ati.c b/hw/display/ati.c
index 76595d9511..61e351a024 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -26,6 +26,7 @@
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "ui/console.h"
+#include "hw/display/i2c-ddc.h"
 #include "trace.h"
=20
 #define ATI_DEBUG_HW_CURSOR 0
@@ -215,6 +216,24 @@ static void ati_cursor_draw_line(VGACommonState *vga=
, uint8_t *d, int scr_y)
     }
 }
=20
+static uint64_t ati_i2c(bitbang_i2c_interface *i2c, uint64_t data, int b=
ase)
+{
+    bool c =3D (data & BIT(base + 17) ? !!(data & BIT(base + 1)) : 1);
+    bool d =3D (data & BIT(base + 16) ? !!(data & BIT(base)) : 1);
+
+    bitbang_i2c_set(i2c, BITBANG_I2C_SCL, c);
+    d =3D bitbang_i2c_set(i2c, BITBANG_I2C_SDA, d);
+
+    data &=3D ~0xf00ULL;
+    if (c) {
+        data |=3D BIT(base + 9);
+    }
+    if (d) {
+        data |=3D BIT(base + 8);
+    }
+    return data;
+}
+
 static inline uint64_t ati_reg_read_offs(uint32_t reg, int offs,
                                          unsigned int size)
 {
@@ -266,7 +285,16 @@ static uint64_t ati_mm_read(void *opaque, hwaddr add=
r, unsigned int size)
     case DAC_CNTL:
         val =3D s->regs.dac_cntl;
         break;
-/*    case GPIO_MONID: FIXME hook up DDC I2C here */
+    case GPIO_VGA_DDC:
+        val =3D s->regs.gpio_vga_ddc;
+        break;
+    case GPIO_DVI_DDC:
+        val =3D s->regs.gpio_dvi_ddc;
+        break;
+    case GPIO_MONID ... GPIO_MONID + 3:
+        val =3D ati_reg_read_offs(s->regs.gpio_monid,
+                                addr - GPIO_MONID, size);
+        break;
     case PALETTE_INDEX:
         /* FIXME unaligned access */
         val =3D vga_ioport_read(&s->vga, VGA_PEL_IR) << 16;
@@ -497,7 +525,28 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         s->regs.dac_cntl =3D data & 0xffffe3ff;
         s->vga.dac_8bit =3D !!(data & DAC_8BIT_EN);
         break;
-/*    case GPIO_MONID: FIXME hook up DDC I2C here */
+    case GPIO_VGA_DDC:
+        if (s->dev_id !=3D PCI_DEVICE_ID_ATI_RAGE128_PF) {
+            /* FIXME: Maybe add a property to select VGA or DVI port? */
+        }
+        break;
+    case GPIO_DVI_DDC:
+        if (s->dev_id !=3D PCI_DEVICE_ID_ATI_RAGE128_PF) {
+            s->regs.gpio_dvi_ddc =3D ati_i2c(s->bbi2c, data, 0);
+        }
+        break;
+    case GPIO_MONID ... GPIO_MONID + 3:
+        /* FIXME What does Radeon have here? */
+        if (s->dev_id =3D=3D PCI_DEVICE_ID_ATI_RAGE128_PF) {
+            /* Rage128p accesses DDC used to get EDID on these pins */
+            ati_reg_write_offs(&s->regs.gpio_monid,
+                               addr - GPIO_MONID, data, size);
+            if ((s->regs.gpio_monid & BIT(25)) &&
+                addr <=3D GPIO_MONID + 2 && addr + size > GPIO_MONID + 2=
) {
+                s->regs.gpio_monid =3D ati_i2c(s->bbi2c, s->regs.gpio_mo=
nid, 1);
+            }
+        }
+        break;
     case PALETTE_INDEX ... PALETTE_INDEX + 3:
         if (size =3D=3D 4) {
             vga_ioport_write(&s->vga, VGA_PEL_IR, (data >> 16) & 0xff);
@@ -788,6 +837,12 @@ static void ati_vga_realize(PCIDevice *dev, Error **=
errp)
         vga->cursor_draw_line =3D ati_cursor_draw_line;
     }
=20
+    /* ddc, edid */
+    I2CBus *i2cbus =3D i2c_init_bus(DEVICE(s), "ati-vga.ddc");
+    s->bbi2c =3D bitbang_i2c_init(i2cbus);
+    I2CSlave *i2cddc =3D I2C_SLAVE(qdev_create(BUS(i2cbus), TYPE_I2CDDC)=
);
+    i2c_set_slave_address(i2cddc, 0x50);
+
     /* mmio register space */
     memory_region_init_io(&s->mm, OBJECT(s), &ati_mm_ops, s,
                           "ati.mmregs", 0x4000);
@@ -813,6 +868,7 @@ static void ati_vga_exit(PCIDevice *dev)
     ATIVGAState *s =3D ATI_VGA(dev);
=20
     graphic_console_close(s->vga.con);
+    g_free(s->bbi2c);
 }
=20
 static Property ati_vga_properties[] =3D {
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index 2f426064cf..51465f5630 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -10,6 +10,7 @@
 #define ATI_INT_H
=20
 #include "hw/pci/pci.h"
+#include "hw/i2c/bitbang_i2c.h"
 #include "vga_int.h"
=20
 /*#define DEBUG_ATI*/
@@ -35,6 +36,9 @@ typedef struct ATIVGARegs {
     uint32_t crtc_gen_cntl;
     uint32_t crtc_ext_cntl;
     uint32_t dac_cntl;
+    uint32_t gpio_vga_ddc;
+    uint32_t gpio_dvi_ddc;
+    uint32_t gpio_monid;
     uint32_t crtc_h_total_disp;
     uint32_t crtc_h_sync_strt_wid;
     uint32_t crtc_v_total_disp;
@@ -83,6 +87,7 @@ typedef struct ATIVGAState {
     uint16_t cursor_size;
     uint32_t cursor_offset;
     QEMUCursor *cursor;
+    bitbang_i2c_interface *bbi2c;
     MemoryRegion io;
     MemoryRegion mm;
     ATIVGARegs regs;
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index 923bfd33ce..1ec3498b73 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -37,6 +37,8 @@
 #define CRTC_GEN_CNTL                           0x0050
 #define CRTC_EXT_CNTL                           0x0054
 #define DAC_CNTL                                0x0058
+#define GPIO_VGA_DDC                            0x0060
+#define GPIO_DVI_DDC                            0x0064
 #define GPIO_MONID                              0x0068
 #define I2C_CNTL_1                              0x0094
 #define PALETTE_INDEX                           0x00b0
--=20
2.13.7


