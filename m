Received: from eggs.gnu.org ([2001:4830:134:3::10]:51818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dh271-0007Pk-OM
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 19:16:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dh26y-0005uP-Q0
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 19:16:03 -0400
Message-Id: <f07c7c77f83136f938f346e1f3b2aa5296ff4223.1502643878.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1502643878.git.balaton@eik.bme.hu>
References: <cover.1502643878.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Sun, 13 Aug 2017 19:04:38 +0200
Subject: [Qemu-devel] [RFC PATCH 05/12] ppc4xx: Split off 4xx I2C emulation
 from ppc405_uc to its own file
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
 hw/ppc/Makefile.objs |   2 +-
 hw/ppc/ppc405.h      |   2 +
 hw/ppc/ppc405_uc.c   | 241 ---------------------------------------------
 hw/ppc/ppc4xx_i2c.c  | 272 +++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 275 insertions(+), 242 deletions(-)
 create mode 100644 hw/ppc/ppc4xx_i2c.c

diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index 7efc686..2077216 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -13,7 +13,7 @@ endif
 obj-$(CONFIG_PSERIES) += spapr_rtas_ddw.o
 # PowerPC 4xx boards
 obj-y += ppc405_boards.o ppc4xx_devs.o ppc405_uc.o ppc440_bamboo.o
-obj-y += ppc4xx_pci.o
+obj-y += ppc4xx_pci.o ppc4xx_i2c.o
 # PReP
 obj-$(CONFIG_PREP) += prep.o
 obj-$(CONFIG_PREP) += prep_systemio.o
diff --git a/hw/ppc/ppc405.h b/hw/ppc/ppc405.h
index a9ffc87..61ec739 100644
--- a/hw/ppc/ppc405.h
+++ b/hw/ppc/ppc405.h
@@ -59,6 +59,8 @@ struct ppc4xx_bd_info_t {
 ram_addr_t ppc405_set_bootinfo (CPUPPCState *env, ppc4xx_bd_info_t *bd,
                                 uint32_t flags);
 
+void ppc405_i2c_init(hwaddr base, qemu_irq irq);
+
 CPUPPCState *ppc405cr_init(MemoryRegion *address_space_mem,
                         MemoryRegion ram_memories[4],
                         hwaddr ram_bases[4],
diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
index 03856d5..3925e4c 100644
--- a/hw/ppc/ppc405_uc.c
+++ b/hw/ppc/ppc405_uc.c
@@ -40,7 +40,6 @@
 //#define DEBUG_GPIO
 //#define DEBUG_SERIAL
 //#define DEBUG_OCM
-//#define DEBUG_I2C
 //#define DEBUG_GPT
 //#define DEBUG_CLOCKS
 //#define DEBUG_CLOCKS_LL
@@ -993,246 +992,6 @@ static void ppc405_ocm_init(CPUPPCState *env)
 }
 
 /*****************************************************************************/
-/* I2C controller */
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
-
-static uint32_t ppc4xx_i2c_readb (void *opaque, hwaddr addr)
-{
-    ppc4xx_i2c_t *i2c;
-    uint32_t ret;
-
-#ifdef DEBUG_I2C
-    printf("%s: addr " TARGET_FMT_plx "\n", __func__, addr);
-#endif
-    i2c = opaque;
-    switch (addr) {
-    case 0x00:
-        //        i2c_readbyte(&i2c->mdata);
-        ret = i2c->mdata;
-        break;
-    case 0x02:
-        ret = i2c->sdata;
-        break;
-    case 0x04:
-        ret = i2c->lmadr;
-        break;
-    case 0x05:
-        ret = i2c->hmadr;
-        break;
-    case 0x06:
-        ret = i2c->cntl;
-        break;
-    case 0x07:
-        ret = i2c->mdcntl;
-        break;
-    case 0x08:
-        ret = i2c->sts;
-        break;
-    case 0x09:
-        ret = i2c->extsts;
-        break;
-    case 0x0A:
-        ret = i2c->lsadr;
-        break;
-    case 0x0B:
-        ret = i2c->hsadr;
-        break;
-    case 0x0C:
-        ret = i2c->clkdiv;
-        break;
-    case 0x0D:
-        ret = i2c->intrmsk;
-        break;
-    case 0x0E:
-        ret = i2c->xfrcnt;
-        break;
-    case 0x0F:
-        ret = i2c->xtcntlss;
-        break;
-    case 0x10:
-        ret = i2c->directcntl;
-        break;
-    default:
-        ret = 0x00;
-        break;
-    }
-#ifdef DEBUG_I2C
-    printf("%s: addr " TARGET_FMT_plx " %02" PRIx32 "\n", __func__, addr, ret);
-#endif
-
-    return ret;
-}
-
-static void ppc4xx_i2c_writeb (void *opaque,
-                               hwaddr addr, uint32_t value)
-{
-    ppc4xx_i2c_t *i2c;
-
-#ifdef DEBUG_I2C
-    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx32 "\n", __func__, addr,
-           value);
-#endif
-    i2c = opaque;
-    switch (addr) {
-    case 0x00:
-        i2c->mdata = value;
-        //        i2c_sendbyte(&i2c->mdata);
-        break;
-    case 0x02:
-        i2c->sdata = value;
-        break;
-    case 0x04:
-        i2c->lmadr = value;
-        break;
-    case 0x05:
-        i2c->hmadr = value;
-        break;
-    case 0x06:
-        i2c->cntl = value;
-        break;
-    case 0x07:
-        i2c->mdcntl = value & 0xDF;
-        break;
-    case 0x08:
-        i2c->sts &= ~(value & 0x0A);
-        break;
-    case 0x09:
-        i2c->extsts &= ~(value & 0x8F);
-        break;
-    case 0x0A:
-        i2c->lsadr = value;
-        break;
-    case 0x0B:
-        i2c->hsadr = value;
-        break;
-    case 0x0C:
-        i2c->clkdiv = value;
-        break;
-    case 0x0D:
-        i2c->intrmsk = value;
-        break;
-    case 0x0E:
-        i2c->xfrcnt = value & 0x77;
-        break;
-    case 0x0F:
-        i2c->xtcntlss = value;
-        break;
-    case 0x10:
-        i2c->directcntl = value & 0x7;
-        break;
-    }
-}
-
-static uint32_t ppc4xx_i2c_readw (void *opaque, hwaddr addr)
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
-static void ppc4xx_i2c_writew (void *opaque,
-                               hwaddr addr, uint32_t value)
-{
-#ifdef DEBUG_I2C
-    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx32 "\n", __func__, addr,
-           value);
-#endif
-    ppc4xx_i2c_writeb(opaque, addr, value >> 8);
-    ppc4xx_i2c_writeb(opaque, addr + 1, value);
-}
-
-static uint32_t ppc4xx_i2c_readl (void *opaque, hwaddr addr)
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
-static void ppc4xx_i2c_writel (void *opaque,
-                               hwaddr addr, uint32_t value)
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
-    .endianness = DEVICE_NATIVE_ENDIAN,
-};
-
-static void ppc4xx_i2c_reset (void *opaque)
-{
-    ppc4xx_i2c_t *i2c;
-
-    i2c = opaque;
-    i2c->mdata = 0x00;
-    i2c->sdata = 0x00;
-    i2c->cntl = 0x00;
-    i2c->mdcntl = 0x00;
-    i2c->sts = 0x00;
-    i2c->extsts = 0x00;
-    i2c->clkdiv = 0x00;
-    i2c->xfrcnt = 0x00;
-    i2c->directcntl = 0x0F;
-}
-
-static void ppc405_i2c_init(hwaddr base, qemu_irq irq)
-{
-    ppc4xx_i2c_t *i2c;
-
-    i2c = g_malloc0(sizeof(ppc4xx_i2c_t));
-    i2c->irq = irq;
-#ifdef DEBUG_I2C
-    printf("%s: offset " TARGET_FMT_plx "\n", __func__, base);
-#endif
-    memory_region_init_io(&i2c->iomem, NULL, &i2c_ops, i2c, "i2c", 0x011);
-    memory_region_add_subregion(get_system_memory(), base, &i2c->iomem);
-    qemu_register_reset(ppc4xx_i2c_reset, i2c);
-}
-
-/*****************************************************************************/
 /* General purpose timers */
 typedef struct ppc4xx_gpt_t ppc4xx_gpt_t;
 struct ppc4xx_gpt_t {
diff --git a/hw/ppc/ppc4xx_i2c.c b/hw/ppc/ppc4xx_i2c.c
new file mode 100644
index 0000000..15f2dea
--- /dev/null
+++ b/hw/ppc/ppc4xx_i2c.c
@@ -0,0 +1,272 @@
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
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "cpu.h"
+#include "hw/hw.h"
+#include "exec/address-spaces.h"
+#include "hw/ppc/ppc.h"
+#include "ppc405.h"
+
+/*#define DEBUG_I2C*/
+
+typedef struct ppc4xx_i2c_t ppc4xx_i2c_t;
+struct ppc4xx_i2c_t {
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
+};
+
+static uint32_t ppc4xx_i2c_readb(void *opaque, hwaddr addr)
+{
+    ppc4xx_i2c_t *i2c;
+    uint32_t ret;
+
+#ifdef DEBUG_I2C
+    printf("%s: addr " TARGET_FMT_plx "\n", __func__, addr);
+#endif
+    i2c = opaque;
+    switch (addr) {
+    case 0x00:
+        /*i2c_readbyte(&i2c->mdata);*/
+        ret = i2c->mdata;
+        break;
+    case 0x02:
+        ret = i2c->sdata;
+        break;
+    case 0x04:
+        ret = i2c->lmadr;
+        break;
+    case 0x05:
+        ret = i2c->hmadr;
+        break;
+    case 0x06:
+        ret = i2c->cntl;
+        break;
+    case 0x07:
+        ret = i2c->mdcntl;
+        break;
+    case 0x08:
+        ret = i2c->sts;
+        break;
+    case 0x09:
+        ret = i2c->extsts;
+        break;
+    case 0x0A:
+        ret = i2c->lsadr;
+        break;
+    case 0x0B:
+        ret = i2c->hsadr;
+        break;
+    case 0x0C:
+        ret = i2c->clkdiv;
+        break;
+    case 0x0D:
+        ret = i2c->intrmsk;
+        break;
+    case 0x0E:
+        ret = i2c->xfrcnt;
+        break;
+    case 0x0F:
+        ret = i2c->xtcntlss;
+        break;
+    case 0x10:
+        ret = i2c->directcntl;
+        break;
+    default:
+        ret = 0x00;
+        break;
+    }
+#ifdef DEBUG_I2C
+    printf("%s: addr " TARGET_FMT_plx " %02" PRIx32 "\n", __func__, addr, ret);
+#endif
+
+    return ret;
+}
+
+static void ppc4xx_i2c_writeb(void *opaque,
+                              hwaddr addr, uint32_t value)
+{
+    ppc4xx_i2c_t *i2c;
+
+#ifdef DEBUG_I2C
+    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx32 "\n", __func__, addr,
+           value);
+#endif
+    i2c = opaque;
+    switch (addr) {
+    case 0x00:
+        i2c->mdata = value;
+        /*i2c_sendbyte(&i2c->mdata);*/
+        break;
+    case 0x02:
+        i2c->sdata = value;
+        break;
+    case 0x04:
+        i2c->lmadr = value;
+        break;
+    case 0x05:
+        i2c->hmadr = value;
+        break;
+    case 0x06:
+        i2c->cntl = value;
+        break;
+    case 0x07:
+        i2c->mdcntl = value & 0xDF;
+        break;
+    case 0x08:
+        i2c->sts &= ~(value & 0x0A);
+        break;
+    case 0x09:
+        i2c->extsts &= ~(value & 0x8F);
+        break;
+    case 0x0A:
+        i2c->lsadr = value;
+        break;
+    case 0x0B:
+        i2c->hsadr = value;
+        break;
+    case 0x0C:
+        i2c->clkdiv = value;
+        break;
+    case 0x0D:
+        i2c->intrmsk = value;
+        break;
+    case 0x0E:
+        i2c->xfrcnt = value & 0x77;
+        break;
+    case 0x0F:
+        i2c->xtcntlss = value;
+        break;
+    case 0x10:
+        i2c->directcntl = value & 0x7;
+        break;
+    }
+}
+
+static uint32_t ppc4xx_i2c_readw(void *opaque, hwaddr addr)
+{
+    uint32_t ret;
+
+#ifdef DEBUG_I2C
+    printf("%s: addr " TARGET_FMT_plx "\n", __func__, addr);
+#endif
+    ret = ppc4xx_i2c_readb(opaque, addr) << 8;
+    ret |= ppc4xx_i2c_readb(opaque, addr + 1);
+
+    return ret;
+}
+
+static void ppc4xx_i2c_writew(void *opaque,
+                              hwaddr addr, uint32_t value)
+{
+#ifdef DEBUG_I2C
+    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx32 "\n", __func__, addr,
+           value);
+#endif
+    ppc4xx_i2c_writeb(opaque, addr, value >> 8);
+    ppc4xx_i2c_writeb(opaque, addr + 1, value);
+}
+
+static uint32_t ppc4xx_i2c_readl(void *opaque, hwaddr addr)
+{
+    uint32_t ret;
+
+#ifdef DEBUG_I2C
+    printf("%s: addr " TARGET_FMT_plx "\n", __func__, addr);
+#endif
+    ret = ppc4xx_i2c_readb(opaque, addr) << 24;
+    ret |= ppc4xx_i2c_readb(opaque, addr + 1) << 16;
+    ret |= ppc4xx_i2c_readb(opaque, addr + 2) << 8;
+    ret |= ppc4xx_i2c_readb(opaque, addr + 3);
+
+    return ret;
+}
+
+static void ppc4xx_i2c_writel(void *opaque,
+                              hwaddr addr, uint32_t value)
+{
+#ifdef DEBUG_I2C
+    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx32 "\n", __func__, addr,
+           value);
+#endif
+    ppc4xx_i2c_writeb(opaque, addr, value >> 24);
+    ppc4xx_i2c_writeb(opaque, addr + 1, value >> 16);
+    ppc4xx_i2c_writeb(opaque, addr + 2, value >> 8);
+    ppc4xx_i2c_writeb(opaque, addr + 3, value);
+}
+
+static const MemoryRegionOps i2c_ops = {
+    .old_mmio = {
+        .read = { ppc4xx_i2c_readb, ppc4xx_i2c_readw, ppc4xx_i2c_readl, },
+        .write = { ppc4xx_i2c_writeb, ppc4xx_i2c_writew, ppc4xx_i2c_writel, },
+    },
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void ppc4xx_i2c_reset(void *opaque)
+{
+    ppc4xx_i2c_t *i2c;
+
+    i2c = opaque;
+    i2c->mdata = 0x00;
+    i2c->sdata = 0x00;
+    i2c->cntl = 0x00;
+    i2c->mdcntl = 0x00;
+    i2c->sts = 0x00;
+    i2c->extsts = 0x00;
+    i2c->clkdiv = 0x00;
+    i2c->xfrcnt = 0x00;
+    i2c->directcntl = 0x0F;
+}
+
+void ppc405_i2c_init(hwaddr base, qemu_irq irq)
+{
+    ppc4xx_i2c_t *i2c;
+
+    i2c = g_malloc0(sizeof(ppc4xx_i2c_t));
+    i2c->irq = irq;
+#ifdef DEBUG_I2C
+    printf("%s: offset " TARGET_FMT_plx "\n", __func__, base);
+#endif
+    memory_region_init_io(&i2c->iomem, NULL, &i2c_ops, i2c, "i2c", 0x011);
+    memory_region_add_subregion(get_system_memory(), base, &i2c->iomem);
+    qemu_register_reset(ppc4xx_i2c_reset, i2c);
+}
-- 
2.7.4
