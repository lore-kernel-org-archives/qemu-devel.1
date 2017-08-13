Received: from eggs.gnu.org ([2001:4830:134:3::10]:51817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dh271-0007Pi-O0
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 19:16:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dh26y-0005u7-OC
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 19:16:03 -0400
Message-Id: <d3e53aa950aad746a7c9ddf46528b4bffa1e13ed.1502643878.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1502643878.git.balaton@eik.bme.hu>
References: <cover.1502643878.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Sun, 13 Aug 2017 19:04:38 +0200
Subject: [Qemu-devel] [RFC PATCH 06/12] ppc4xx_i2c: QOMify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Francois Revol <revol@free.fr>

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/ppc405.h             |   2 -
 hw/ppc/ppc405_uc.c          |   5 +-
 hw/ppc/ppc4xx_i2c.c         | 153 +++++++++++++++++---------------------------
 include/hw/i2c/ppc4xx_i2c.h |  59 +++++++++++++++++
 4 files changed, 121 insertions(+), 98 deletions(-)
 create mode 100644 include/hw/i2c/ppc4xx_i2c.h

diff --git a/hw/ppc/ppc405.h b/hw/ppc/ppc405.h
index 61ec739..a9ffc87 100644
--- a/hw/ppc/ppc405.h
+++ b/hw/ppc/ppc405.h
@@ -59,8 +59,6 @@ struct ppc4xx_bd_info_t {
 ram_addr_t ppc405_set_bootinfo (CPUPPCState *env, ppc4xx_bd_info_t *bd,
                                 uint32_t flags);
 
-void ppc405_i2c_init(hwaddr base, qemu_irq irq);
-
 CPUPPCState *ppc405cr_init(MemoryRegion *address_space_mem,
                         MemoryRegion ram_memories[4],
                         hwaddr ram_bases[4],
diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
index 3925e4c..8f44cb4 100644
--- a/hw/ppc/ppc405_uc.c
+++ b/hw/ppc/ppc405_uc.c
@@ -28,6 +28,7 @@
 #include "hw/hw.h"
 #include "hw/ppc/ppc.h"
 #include "hw/boards.h"
+#include "hw/i2c/ppc4xx_i2c.h"
 #include "ppc405.h"
 #include "hw/char/serial.h"
 #include "qemu/timer.h"
@@ -1663,7 +1664,7 @@ CPUPPCState *ppc405cr_init(MemoryRegion *address_space_mem,
                        DEVICE_BIG_ENDIAN);
     }
     /* IIC controller */
-    ppc405_i2c_init(0xef600500, pic[2]);
+    sysbus_create_simple(TYPE_PPC4xx_I2C, 0xef600500, pic[2]);
     /* GPIO */
     ppc405_gpio_init(0xef600700);
     /* CPU control */
@@ -2010,7 +2011,7 @@ CPUPPCState *ppc405ep_init(MemoryRegion *address_space_mem,
     dma_irqs[3] = pic[8];
     ppc405_dma_init(env, dma_irqs);
     /* IIC controller */
-    ppc405_i2c_init(0xef600500, pic[2]);
+    sysbus_create_simple(TYPE_PPC4xx_I2C, 0xef600500, pic[2]);
     /* GPIO */
     ppc405_gpio_init(0xef600700);
     /* Serial ports */
diff --git a/hw/ppc/ppc4xx_i2c.c b/hw/ppc/ppc4xx_i2c.c
index 15f2dea..fafbb34 100644
--- a/hw/ppc/ppc4xx_i2c.c
+++ b/hw/ppc/ppc4xx_i2c.c
@@ -27,42 +27,19 @@
 #include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
-#include "exec/address-spaces.h"
-#include "hw/ppc/ppc.h"
-#include "ppc405.h"
+#include "hw/i2c/ppc4xx_i2c.h"
 
 /*#define DEBUG_I2C*/
 
-typedef struct ppc4xx_i2c_t ppc4xx_i2c_t;
-struct ppc4xx_i2c_t {
-    qemu_irq irq;
-    MemoryRegion iomem;
-    uint8_t mdata;
-    uint8_t lmadr;
-    uint8_t hmadr;
-    uint8_t cntl;
-    uint8_t mdcntl;
-    uint8_t sts;
-    uint8_t extsts;
-    uint8_t sdata;
-    uint8_t lsadr;
-    uint8_t hsadr;
-    uint8_t clkdiv;
-    uint8_t intrmsk;
-    uint8_t xfrcnt;
-    uint8_t xtcntlss;
-    uint8_t directcntl;
-};
+#define PPC4xx_I2C_MEM_SIZE 0x11
 
-static uint32_t ppc4xx_i2c_readb(void *opaque, hwaddr addr)
+static uint8_t ppc4xx_i2c_readb(PPC4xxI2CState *i2c, hwaddr addr)
 {
-    ppc4xx_i2c_t *i2c;
-    uint32_t ret;
+    uint8_t ret;
 
 #ifdef DEBUG_I2C
     printf("%s: addr " TARGET_FMT_plx "\n", __func__, addr);
 #endif
-    i2c = opaque;
     switch (addr) {
     case 0x00:
         /*i2c_readbyte(&i2c->mdata);*/
@@ -121,16 +98,12 @@ static uint32_t ppc4xx_i2c_readb(void *opaque, hwaddr addr)
     return ret;
 }
 
-static void ppc4xx_i2c_writeb(void *opaque,
-                              hwaddr addr, uint32_t value)
+static void ppc4xx_i2c_writeb(PPC4xxI2CState *i2c, hwaddr addr, uint8_t value)
 {
-    ppc4xx_i2c_t *i2c;
-
 #ifdef DEBUG_I2C
-    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx32 "\n", __func__, addr,
-           value);
+    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx32 "\n",
+           __func__, addr, value);
 #endif
-    i2c = opaque;
     switch (addr) {
     case 0x00:
         i2c->mdata = value;
@@ -181,71 +154,44 @@ static void ppc4xx_i2c_writeb(void *opaque,
     }
 }
 
-static uint32_t ppc4xx_i2c_readw(void *opaque, hwaddr addr)
+static uint64_t ppc4xx_i2c_read(void *opaque, hwaddr addr, unsigned int size)
 {
-    uint32_t ret;
+    PPC4xxI2CState *s = PPC4xx_I2C(opaque);
+    int i;
+    uint64_t ret = 0;
 
-#ifdef DEBUG_I2C
-    printf("%s: addr " TARGET_FMT_plx "\n", __func__, addr);
-#endif
-    ret = ppc4xx_i2c_readb(opaque, addr) << 8;
-    ret |= ppc4xx_i2c_readb(opaque, addr + 1);
+    for (i = 0; i < size; i++) {
+        ret <<= 8;
+        ret |= ppc4xx_i2c_readb(s, addr + i);
+    }
 
     return ret;
 }
 
-static void ppc4xx_i2c_writew(void *opaque,
-                              hwaddr addr, uint32_t value)
+static void ppc4xx_i2c_write(void *opaque, hwaddr addr, uint64_t value,
+                             unsigned int size)
 {
-#ifdef DEBUG_I2C
-    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx32 "\n", __func__, addr,
-           value);
-#endif
-    ppc4xx_i2c_writeb(opaque, addr, value >> 8);
-    ppc4xx_i2c_writeb(opaque, addr + 1, value);
-}
-
-static uint32_t ppc4xx_i2c_readl(void *opaque, hwaddr addr)
-{
-    uint32_t ret;
-
-#ifdef DEBUG_I2C
-    printf("%s: addr " TARGET_FMT_plx "\n", __func__, addr);
-#endif
-    ret = ppc4xx_i2c_readb(opaque, addr) << 24;
-    ret |= ppc4xx_i2c_readb(opaque, addr + 1) << 16;
-    ret |= ppc4xx_i2c_readb(opaque, addr + 2) << 8;
-    ret |= ppc4xx_i2c_readb(opaque, addr + 3);
-
-    return ret;
-}
+    PPC4xxI2CState *s = PPC4xx_I2C(opaque);
+    int i;
 
-static void ppc4xx_i2c_writel(void *opaque,
-                              hwaddr addr, uint32_t value)
-{
-#ifdef DEBUG_I2C
-    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx32 "\n", __func__, addr,
-           value);
-#endif
-    ppc4xx_i2c_writeb(opaque, addr, value >> 24);
-    ppc4xx_i2c_writeb(opaque, addr + 1, value >> 16);
-    ppc4xx_i2c_writeb(opaque, addr + 2, value >> 8);
-    ppc4xx_i2c_writeb(opaque, addr + 3, value);
+    for (i = 0; i < size; i++) {
+        ppc4xx_i2c_writeb(s, addr + i, value & 0xff);
+        value >>= 8;
+    }
 }
 
-static const MemoryRegionOps i2c_ops = {
-    .old_mmio = {
-        .read = { ppc4xx_i2c_readb, ppc4xx_i2c_readw, ppc4xx_i2c_readl, },
-        .write = { ppc4xx_i2c_writeb, ppc4xx_i2c_writew, ppc4xx_i2c_writel, },
-    },
+static const MemoryRegionOps ppc4xx_i2c_ops = {
+    .read = ppc4xx_i2c_read,
+    .write = ppc4xx_i2c_write,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static void ppc4xx_i2c_reset(void *opaque)
+static void ppc4xx_i2c_reset(DeviceState *s)
 {
-    ppc4xx_i2c_t *i2c;
+    PPC4xxI2CState *i2c = PPC4xx_I2C(s);
 
-    i2c = opaque;
     i2c->mdata = 0x00;
     i2c->sdata = 0x00;
     i2c->cntl = 0x00;
@@ -257,16 +203,35 @@ static void ppc4xx_i2c_reset(void *opaque)
     i2c->directcntl = 0x0F;
 }
 
-void ppc405_i2c_init(hwaddr base, qemu_irq irq)
+static void ppc4xx_i2c_init(Object *o)
 {
-    ppc4xx_i2c_t *i2c;
+    PPC4xxI2CState *s = PPC4xx_I2C(o);
 
-    i2c = g_malloc0(sizeof(ppc4xx_i2c_t));
-    i2c->irq = irq;
-#ifdef DEBUG_I2C
-    printf("%s: offset " TARGET_FMT_plx "\n", __func__, base);
-#endif
-    memory_region_init_io(&i2c->iomem, NULL, &i2c_ops, i2c, "i2c", 0x011);
-    memory_region_add_subregion(get_system_memory(), base, &i2c->iomem);
-    qemu_register_reset(ppc4xx_i2c_reset, i2c);
+    memory_region_init_io(&s->iomem, OBJECT(s), &ppc4xx_i2c_ops, s,
+                          TYPE_PPC4xx_I2C, PPC4xx_I2C_MEM_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
+    sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq);
+    s->bus = i2c_init_bus(DEVICE(s), "i2c");
 }
+
+static void ppc4xx_i2c_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = ppc4xx_i2c_reset;
+}
+
+static const TypeInfo ppc4xx_i2c_type_info = {
+    .name = TYPE_PPC4xx_I2C,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(PPC4xxI2CState),
+    .instance_init = ppc4xx_i2c_init,
+    .class_init = ppc4xx_i2c_class_init,
+};
+
+static void ppc4xx_i2c_register_types(void)
+{
+    type_register_static(&ppc4xx_i2c_type_info);
+}
+
+type_init(ppc4xx_i2c_register_types)
diff --git a/include/hw/i2c/ppc4xx_i2c.h b/include/hw/i2c/ppc4xx_i2c.h
new file mode 100644
index 0000000..7f1e6be
--- /dev/null
+++ b/include/hw/i2c/ppc4xx_i2c.h
@@ -0,0 +1,59 @@
+/*
+ * PPC4xx I2C controller emulation
+ *
+ * Copyright (c) 2007 Jocelyn Mayer
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef PPC4XX_I2C_H
+#define PPC4XX_I2C_H
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "hw/sysbus.h"
+
+#define TYPE_PPC4xx_I2C "ppc4xx-i2c"
+#define PPC4xx_I2C(obj) OBJECT_CHECK(PPC4xxI2CState, (obj), TYPE_PPC4xx_I2C)
+
+typedef struct PPC4xxI2CState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    qemu_irq irq;
+    MemoryRegion iomem;
+    uint8_t mdata;
+    uint8_t lmadr;
+    uint8_t hmadr;
+    uint8_t cntl;
+    uint8_t mdcntl;
+    uint8_t sts;
+    uint8_t extsts;
+    uint8_t sdata;
+    uint8_t lsadr;
+    uint8_t hsadr;
+    uint8_t clkdiv;
+    uint8_t intrmsk;
+    uint8_t xfrcnt;
+    uint8_t xtcntlss;
+    uint8_t directcntl;
+} PPC4xxI2CState;
+
+#endif /* PPC4XX_I2C_H */
-- 
2.7.4
