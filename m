Received: from eggs.gnu.org ([209.51.188.92]:34169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h2yoU-0004uh-NT
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 09:48:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h2yoT-0005KZ-O5
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 09:48:26 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:29495)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1h2yoT-0005K8-Cj
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 09:48:25 -0400
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Sun, 10 Mar 2019 00:22:17 +0100
Message-Id: <20190309232719.43A8074862C@zero.eik.bme.hu>
Subject: [Qemu-devel] [PATCH] ati-vga: Implement DDC and EDID info from
 monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

This adds DDC support to ati-vga and connects i2c-ddc to provide EDID
info that is read by guests to find available screen modes. Not sure
if this is 100% correct yet but at least MorphOS is happy with it and
starts in a high resolution mode instead of 640x480 (although its
splash screen is still not correct). Linux needs support from VESA
vgabios, it seems to be missing INT10 0x4F15 function (see
https://gitlab.freedesktop.org/xorg/xserver/blob/master/hw/xfree86/vbe/vbe.c)
without which no DDC is available that also prevents loading the
accelerated X driver.

Besides, this depends on bitbang_i2c.h which is now in hw/i2c so if
including it from there is not desirable that may need to be moved
somewhere.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/Kconfig   |  2 ++
 hw/display/ati.c     | 24 ++++++++++++++++++++++--
 hw/display/ati_int.h |  3 +++
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index 86c1d544c5..f8d65802a9 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -112,3 +112,5 @@ config ATI_VGA
     default y if PCI_DEVICES
     depends on PCI
     select VGA
+    select BITBANG_I2C
+    select DDC
diff --git a/hw/display/ati.c b/hw/display/ati.c
index 8322f52aff..260cd803d8 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -24,6 +24,8 @@
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "ui/console.h"
+#include "hw/i2c/i2c-ddc.h"
+#include "../i2c/bitbang_i2c.h"
 #include "trace.h"
 
 #define ATI_DEBUG_HW_CURSOR 0
@@ -267,7 +269,9 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
     case DAC_CNTL:
         val = s->regs.dac_cntl;
         break;
-/*    case GPIO_MONID: FIXME hook up DDC I2C here */
+    case GPIO_MONID:
+        val = s->regs.gpio_monid;
+        break;
     case PALETTE_INDEX:
         /* FIXME unaligned access */
         val = vga_ioport_read(&s->vga, VGA_PEL_IR) << 16;
@@ -501,7 +505,17 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         s->regs.dac_cntl = data & 0xffffe3ff;
         s->vga.dac_8bit = !!(data & DAC_8BIT_EN);
         break;
-/*    case GPIO_MONID: FIXME hook up DDC I2C here */
+    case GPIO_MONID:
+        s->regs.gpio_monid = data & 0x0f0f000f;
+        if (data & BIT(2) << 24) {
+            s->regs.gpio_monid |= !!(data & BIT(2)) << 10;
+            bitbang_i2c_set(s->bbi2c, BITBANG_I2C_SCL, (data & BIT(2)) != 0);
+        }
+        if (data & BIT(1) << 24) {
+            s->regs.gpio_monid |= bitbang_i2c_set(s->bbi2c, BITBANG_I2C_SDA,
+                                                  (data & BIT(1)) != 0) << 9;
+        }
+        break;
     case PALETTE_INDEX ... PALETTE_INDEX + 3:
         if (size == 4) {
             vga_ioport_write(&s->vga, VGA_PEL_IR, (data >> 16) & 0xff);
@@ -792,6 +806,12 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
         vga->cursor_draw_line = ati_cursor_draw_line;
     }
 
+    /* ddc, edid */
+    I2CBus *i2cbus = i2c_init_bus(DEVICE(s), "ati-vga.ddc");
+    s->bbi2c = bitbang_i2c_init(i2cbus);
+    I2CSlave *i2cddc = I2C_SLAVE(qdev_create(BUS(i2cbus), TYPE_I2CDDC));
+    i2c_set_slave_address(i2cddc, 0x50);
+
     /* mmio register space */
     memory_region_init_io(&s->mm, OBJECT(s), &ati_mm_ops, s,
                           "ati.mmregs", 0x4000);
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index a6f3e20e63..8df00efd93 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
+#include "hw/i2c/i2c.h"
 #include "vga_int.h"
 
 /*#define DEBUG_ATI*/
@@ -36,6 +37,7 @@ typedef struct ATIVGARegs {
     uint32_t crtc_gen_cntl;
     uint32_t crtc_ext_cntl;
     uint32_t dac_cntl;
+    uint32_t gpio_monid;
     uint32_t crtc_h_total_disp;
     uint32_t crtc_h_sync_strt_wid;
     uint32_t crtc_v_total_disp;
@@ -84,6 +86,7 @@ typedef struct ATIVGAState {
     uint16_t cursor_size;
     uint32_t cursor_offset;
     QEMUCursor *cursor;
+    bitbang_i2c_interface *bbi2c;
     MemoryRegion io;
     MemoryRegion mm;
     ATIVGARegs regs;
-- 
2.13.7
