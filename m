Received: from eggs.gnu.org ([2001:4830:134:3::10]:58789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGeA-0002Db-8Z
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGe3-0003I5-66
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:26 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  8 Sep 2017 20:35:43 +1000
Message-Id: <20170908103558.31632-26-david@gibson.dropbear.id.au>
In-Reply-To: <20170908103558.31632-1-david@gibson.dropbear.id.au>
References: <20170908103558.31632-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 25/40] ppc4xx_i2c: QOMify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, sam.bobroff@au1.ibm.com, imammedo@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>, David Gibson <david@gibson.dropbear.id.au>

From: BALATON Zoltan <balaton@eik.bme.hu>

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/ppc405.h             |   2 -
 hw/ppc/ppc405_uc.c          |   5 +-
 hw/ppc/ppc4xx_i2c.c         | 154 ++++++++++++++------------------------------
 include/hw/i2c/ppc4xx_i2c.h |  61 ++++++++++++++++++
 4 files changed, 113 insertions(+), 109 deletions(-)
 create mode 100644 include/hw/i2c/ppc4xx_i2c.h

diff --git a/hw/ppc/ppc405.h b/hw/ppc/ppc405.h
index 61ec739ebf..a9ffc87f19 100644
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
index 3925e4c60b..8f44cb46d0 100644
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
index 15f2dea69e..5a6bde951e 100644
--- a/hw/ppc/ppc4xx_i2c.c
+++ b/hw/ppc/ppc4xx_i2c.c
@@ -27,42 +27,20 @@
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
+static uint64_t ppc4xx_i2c_readb(void *opaque, hwaddr addr, unsigned int size)
 {
-    ppc4xx_i2c_t *i2c;
-    uint32_t ret;
+    PPC4xxI2CState *i2c = PPC4xx_I2C(opaque);
+    uint64_t ret;
 
 #ifdef DEBUG_I2C
     printf("%s: addr " TARGET_FMT_plx "\n", __func__, addr);
 #endif
-    i2c = opaque;
     switch (addr) {
     case 0x00:
         /*i2c_readbyte(&i2c->mdata);*/
@@ -115,22 +93,20 @@ static uint32_t ppc4xx_i2c_readb(void *opaque, hwaddr addr)
         break;
     }
 #ifdef DEBUG_I2C
-    printf("%s: addr " TARGET_FMT_plx " %02" PRIx32 "\n", __func__, addr, ret);
+    printf("%s: addr " TARGET_FMT_plx " %02" PRIx64 "\n", __func__, addr, ret);
 #endif
 
     return ret;
 }
 
-static void ppc4xx_i2c_writeb(void *opaque,
-                              hwaddr addr, uint32_t value)
+static void ppc4xx_i2c_writeb(void *opaque, hwaddr addr, uint64_t value,
+                              unsigned int size)
 {
-    ppc4xx_i2c_t *i2c;
-
+    PPC4xxI2CState *i2c = opaque;
 #ifdef DEBUG_I2C
-    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx32 "\n", __func__, addr,
-           value);
+    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx64 "\n",
+           __func__, addr, value);
 #endif
-    i2c = opaque;
     switch (addr) {
     case 0x00:
         i2c->mdata = value;
@@ -181,71 +157,20 @@ static void ppc4xx_i2c_writeb(void *opaque,
     }
 }
 
-static uint32_t ppc4xx_i2c_readw(void *opaque, hwaddr addr)
-{
-    uint32_t ret;
-
-#ifdef DEBUG_I2C
-    printf("%s: addr " TARGET_FMT_plx "\n", __func__, addr);
-#endif
-    ret = ppc4xx_i2c_readb(opaque, addr) << 8;
-    ret |= ppc4xx_i2c_readb(opaque, addr + 1);
-
-    return ret;
-}
-
-static void ppc4xx_i2c_writew(void *opaque,
-                              hwaddr addr, uint32_t value)
-{
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
-
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
-}
-
-static const MemoryRegionOps i2c_ops = {
-    .old_mmio = {
-        .read = { ppc4xx_i2c_readb, ppc4xx_i2c_readw, ppc4xx_i2c_readl, },
-        .write = { ppc4xx_i2c_writeb, ppc4xx_i2c_writew, ppc4xx_i2c_writel, },
-    },
+static const MemoryRegionOps ppc4xx_i2c_ops = {
+    .read = ppc4xx_i2c_readb,
+    .write = ppc4xx_i2c_writeb,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+    .impl.min_access_size = 1,
+    .impl.max_access_size = 1,
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
@@ -257,16 +182,35 @@ static void ppc4xx_i2c_reset(void *opaque)
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
index 0000000000..e53042f6d4
--- /dev/null
+++ b/include/hw/i2c/ppc4xx_i2c.h
@@ -0,0 +1,61 @@
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
+#include "hw/i2c/i2c.h"
+
+#define TYPE_PPC4xx_I2C "ppc4xx-i2c"
+#define PPC4xx_I2C(obj) OBJECT_CHECK(PPC4xxI2CState, (obj), TYPE_PPC4xx_I2C)
+
+typedef struct PPC4xxI2CState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    I2CBus *bus;
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
2.13.5
