Received: from eggs.gnu.org ([2001:4830:134:3::10]:39861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1djUL0-00045a-3C
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 13:48:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1djUKw-00055i-Ul
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 13:48:38 -0400
Message-Id: <b08c0b6ffb65d9073cc729f274317b689dce593c.1503249785.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1503249785.git.balaton@eik.bme.hu>
References: <cover.1503249785.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Sun, 20 Aug 2017 19:23:05 +0200
Subject: [Qemu-devel] [PATCH 07/15] ppc4xx_i2c: Move to hw/i2c
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
 default-configs/ppc-softmmu.mak    |   1 +
 default-configs/ppc64-softmmu.mak  |   1 +
 default-configs/ppcemb-softmmu.mak |   1 +
 hw/i2c/Makefile.objs               |   1 +
 hw/i2c/ppc4xx_i2c.c                | 216 +++++++++++++++++++++++++++++++++++++
 hw/ppc/Makefile.objs               |   2 +-
 hw/ppc/ppc4xx_i2c.c                | 216 -------------------------------------
 7 files changed, 221 insertions(+), 217 deletions(-)
 create mode 100644 hw/i2c/ppc4xx_i2c.c
 delete mode 100644 hw/ppc/ppc4xx_i2c.c

diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index 1f1cd85..d4d44eb 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -3,6 +3,7 @@
 include pci.mak
 include sound.mak
 include usb.mak
+CONFIG_PPC4XX=y
 CONFIG_ESCC=y
 CONFIG_M48T59=y
 CONFIG_SERIAL=y
diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-softmmu.mak
index 46c9599..af32589 100644
--- a/default-configs/ppc64-softmmu.mak
+++ b/default-configs/ppc64-softmmu.mak
@@ -3,6 +3,7 @@
 include pci.mak
 include sound.mak
 include usb.mak
+CONFIG_PPC4XX=y
 CONFIG_VIRTIO_VGA=y
 CONFIG_ESCC=y
 CONFIG_M48T59=y
diff --git a/default-configs/ppcemb-softmmu.mak b/default-configs/ppcemb-softmmu.mak
index 94340de..635923a 100644
--- a/default-configs/ppcemb-softmmu.mak
+++ b/default-configs/ppcemb-softmmu.mak
@@ -3,6 +3,7 @@
 include pci.mak
 include sound.mak
 include usb.mak
+CONFIG_PPC4XX=y
 CONFIG_M48T59=y
 CONFIG_SERIAL=y
 CONFIG_SERIAL_ISA=y
diff --git a/hw/i2c/Makefile.objs b/hw/i2c/Makefile.objs
index a081b8e..0594dea 100644
--- a/hw/i2c/Makefile.objs
+++ b/hw/i2c/Makefile.objs
@@ -8,3 +8,4 @@ common-obj-$(CONFIG_EXYNOS4) += exynos4210_i2c.o
 common-obj-$(CONFIG_IMX_I2C) += imx_i2c.o
 common-obj-$(CONFIG_ASPEED_SOC) += aspeed_i2c.o
 obj-$(CONFIG_OMAP) += omap_i2c.o
+obj-$(CONFIG_PPC4XX) += ppc4xx_i2c.o
diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
new file mode 100644
index 0000000..5a6bde9
--- /dev/null
+++ b/hw/i2c/ppc4xx_i2c.c
@@ -0,0 +1,216 @@
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
+#include "hw/i2c/ppc4xx_i2c.h"
+
+/*#define DEBUG_I2C*/
+
+#define PPC4xx_I2C_MEM_SIZE 0x11
+
+static uint64_t ppc4xx_i2c_readb(void *opaque, hwaddr addr, unsigned int size)
+{
+    PPC4xxI2CState *i2c = PPC4xx_I2C(opaque);
+    uint64_t ret;
+
+#ifdef DEBUG_I2C
+    printf("%s: addr " TARGET_FMT_plx "\n", __func__, addr);
+#endif
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
+    printf("%s: addr " TARGET_FMT_plx " %02" PRIx64 "\n", __func__, addr, ret);
+#endif
+
+    return ret;
+}
+
+static void ppc4xx_i2c_writeb(void *opaque, hwaddr addr, uint64_t value,
+                              unsigned int size)
+{
+    PPC4xxI2CState *i2c = opaque;
+#ifdef DEBUG_I2C
+    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx64 "\n",
+           __func__, addr, value);
+#endif
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
+static const MemoryRegionOps ppc4xx_i2c_ops = {
+    .read = ppc4xx_i2c_readb,
+    .write = ppc4xx_i2c_writeb,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+    .impl.min_access_size = 1,
+    .impl.max_access_size = 1,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void ppc4xx_i2c_reset(DeviceState *s)
+{
+    PPC4xxI2CState *i2c = PPC4xx_I2C(s);
+
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
+static void ppc4xx_i2c_init(Object *o)
+{
+    PPC4xxI2CState *s = PPC4xx_I2C(o);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &ppc4xx_i2c_ops, s,
+                          TYPE_PPC4xx_I2C, PPC4xx_I2C_MEM_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
+    sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq);
+    s->bus = i2c_init_bus(DEVICE(s), "i2c");
+}
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
diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index 2077216..7efc686 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -13,7 +13,7 @@ endif
 obj-$(CONFIG_PSERIES) += spapr_rtas_ddw.o
 # PowerPC 4xx boards
 obj-y += ppc405_boards.o ppc4xx_devs.o ppc405_uc.o ppc440_bamboo.o
-obj-y += ppc4xx_pci.o ppc4xx_i2c.o
+obj-y += ppc4xx_pci.o
 # PReP
 obj-$(CONFIG_PREP) += prep.o
 obj-$(CONFIG_PREP) += prep_systemio.o
diff --git a/hw/ppc/ppc4xx_i2c.c b/hw/ppc/ppc4xx_i2c.c
deleted file mode 100644
index 5a6bde9..0000000
--- a/hw/ppc/ppc4xx_i2c.c
+++ /dev/null
@@ -1,216 +0,0 @@
-/*
- * PPC4xx I2C controller emulation
- *
- * Copyright (c) 2007 Jocelyn Mayer
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-#include "qemu/osdep.h"
-#include "qapi/error.h"
-#include "qemu-common.h"
-#include "cpu.h"
-#include "hw/hw.h"
-#include "hw/i2c/ppc4xx_i2c.h"
-
-/*#define DEBUG_I2C*/
-
-#define PPC4xx_I2C_MEM_SIZE 0x11
-
-static uint64_t ppc4xx_i2c_readb(void *opaque, hwaddr addr, unsigned int size)
-{
-    PPC4xxI2CState *i2c = PPC4xx_I2C(opaque);
-    uint64_t ret;
-
-#ifdef DEBUG_I2C
-    printf("%s: addr " TARGET_FMT_plx "\n", __func__, addr);
-#endif
-    switch (addr) {
-    case 0x00:
-        /*i2c_readbyte(&i2c->mdata);*/
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
-    printf("%s: addr " TARGET_FMT_plx " %02" PRIx64 "\n", __func__, addr, ret);
-#endif
-
-    return ret;
-}
-
-static void ppc4xx_i2c_writeb(void *opaque, hwaddr addr, uint64_t value,
-                              unsigned int size)
-{
-    PPC4xxI2CState *i2c = opaque;
-#ifdef DEBUG_I2C
-    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx64 "\n",
-           __func__, addr, value);
-#endif
-    switch (addr) {
-    case 0x00:
-        i2c->mdata = value;
-        /*i2c_sendbyte(&i2c->mdata);*/
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
-static const MemoryRegionOps ppc4xx_i2c_ops = {
-    .read = ppc4xx_i2c_readb,
-    .write = ppc4xx_i2c_writeb,
-    .valid.min_access_size = 1,
-    .valid.max_access_size = 4,
-    .impl.min_access_size = 1,
-    .impl.max_access_size = 1,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-};
-
-static void ppc4xx_i2c_reset(DeviceState *s)
-{
-    PPC4xxI2CState *i2c = PPC4xx_I2C(s);
-
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
-static void ppc4xx_i2c_init(Object *o)
-{
-    PPC4xxI2CState *s = PPC4xx_I2C(o);
-
-    memory_region_init_io(&s->iomem, OBJECT(s), &ppc4xx_i2c_ops, s,
-                          TYPE_PPC4xx_I2C, PPC4xx_I2C_MEM_SIZE);
-    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
-    sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq);
-    s->bus = i2c_init_bus(DEVICE(s), "i2c");
-}
-
-static void ppc4xx_i2c_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->reset = ppc4xx_i2c_reset;
-}
-
-static const TypeInfo ppc4xx_i2c_type_info = {
-    .name = TYPE_PPC4xx_I2C,
-    .parent = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(PPC4xxI2CState),
-    .instance_init = ppc4xx_i2c_init,
-    .class_init = ppc4xx_i2c_class_init,
-};
-
-static void ppc4xx_i2c_register_types(void)
-{
-    type_register_static(&ppc4xx_i2c_type_info);
-}
-
-type_init(ppc4xx_i2c_register_types)
-- 
2.7.6
