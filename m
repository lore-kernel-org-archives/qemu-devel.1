Received: from eggs.gnu.org ([209.51.188.92]:52555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair@alistair23.me>) id 1hKyua-0006Uv-NS
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 01:33:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair@alistair23.me>) id 1hKyuY-0005JZ-O1
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 01:33:08 -0400
Received: from mail-oln040092253089.outbound.protection.outlook.com
	([40.92.253.89]:12303
	helo=APC01-SG2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistair@alistair23.me>)
	id 1hKyuW-0005FM-Vj
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 01:33:06 -0400
From: Alistair Francis <alistair@alistair23.me>
Date: Mon, 29 Apr 2019 05:32:59 +0000
Message-ID: <PSXP216MB02776A12DAB1C4523F67837EDD390@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
References: <cover.1556515687.git.alistair@alistair23.me>
In-Reply-To: <cover.1556515687.git.alistair@alistair23.me>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 2/5] hw/misc: Add the STM32F4xx Sysconfig
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 default-configs/arm-softmmu.mak    |   1 +
 hw/misc/Kconfig                    |   3 +
 hw/misc/Makefile.objs              |   1 +
 hw/misc/stm32f4xx_syscfg.c         | 275 +++++++++++++++++++++++++++++
 include/hw/misc/stm32f4xx_syscfg.h |  62 +++++++
 5 files changed, 342 insertions(+)
 create mode 100644 hw/misc/stm32f4xx_syscfg.c
 create mode 100644 include/hw/misc/stm32f4xx_syscfg.h

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.=
mak
index 613d19a06d..c5cfdb857d 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -96,6 +96,7 @@ CONFIG_STM32F2XX_SYSCFG=3Dy
 CONFIG_STM32F2XX_ADC=3Dy
 CONFIG_STM32F2XX_SPI=3Dy
 CONFIG_STM32F205_SOC=3Dy
+CONFIG_STM32F4XX_SYSCFG=3Dy
 CONFIG_NRF51_SOC=3Dy
=20
 CONFIG_CMSDK_APB_TIMER=3Dy
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 5f67d0d6d9..c6ff39aeeb 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -80,6 +80,9 @@ config IMX
 config STM32F2XX_SYSCFG
     bool
=20
+config STM32F4XX_SYSCFG
+    bool
+
 config MIPS_ITU
     bool
=20
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index c71e07ae35..1413b1f232 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -57,6 +57,7 @@ obj-$(CONFIG_SLAVIO) +=3D slavio_misc.o
 obj-$(CONFIG_ZYNQ) +=3D zynq_slcr.o
 obj-$(CONFIG_ZYNQ) +=3D zynq-xadc.o
 obj-$(CONFIG_STM32F2XX_SYSCFG) +=3D stm32f2xx_syscfg.o
+obj-$(CONFIG_STM32F4XX_SYSCFG) +=3D stm32f4xx_syscfg.o
 obj-$(CONFIG_MIPS_CPS) +=3D mips_cmgcr.o
 obj-$(CONFIG_MIPS_CPS) +=3D mips_cpc.o
 obj-$(CONFIG_MIPS_ITU) +=3D mips_itu.o
diff --git a/hw/misc/stm32f4xx_syscfg.c b/hw/misc/stm32f4xx_syscfg.c
new file mode 100644
index 0000000000..c0aaeeaf6c
--- /dev/null
+++ b/hw/misc/stm32f4xx_syscfg.c
@@ -0,0 +1,275 @@
+/*
+ * STM32F4xx SYSCFG
+ *
+ * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy
+ * of this software and associated documentation files (the "Software"), t=
o deal
+ * in the Software without restriction, including without limitation the r=
ights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/misc/stm32f4xx_syscfg.h"
+
+#ifndef STM_SYSCFG_ERR_DEBUG
+#define STM_SYSCFG_ERR_DEBUG 0
+#endif
+
+#define DB_PRINT_L(lvl, fmt, args...) do { \
+    if (STM_SYSCFG_ERR_DEBUG >=3D lvl) { \
+        qemu_log("%s: " fmt, __func__, ## args); \
+    } \
+} while (0)
+
+#define DB_PRINT(fmt, args...) DB_PRINT_L(1, fmt, ## args)
+
+static void stm32f4xx_syscfg_reset(DeviceState *dev)
+{
+    STM32F4xxSyscfgState *s =3D STM32F4XX_SYSCFG(dev);
+
+    s->syscfg_memrmp =3D 0x00000000;
+    s->syscfg_pmc =3D 0x00000000;
+    s->syscfg_exticr1 =3D 0x00000000;
+    s->syscfg_exticr2 =3D 0x00000000;
+    s->syscfg_exticr3 =3D 0x00000000;
+    s->syscfg_exticr4 =3D 0x00000000;
+    s->syscfg_cmpcr =3D 0x00000000;
+}
+
+static void stm32f4xx_syscfg_set_irq(void *opaque, int irq, int level)
+{
+    STM32F4xxSyscfgState *s =3D opaque;
+    uint8_t config;
+
+    DB_PRINT("Interupt: GPIO: %d, Line: %d; Level: %d\n", irq / 16,
+             irq % 16, level);
+
+    config =3D irq / 16;
+
+    switch (irq % 16) {
+    case 0:
+        if ((s->syscfg_exticr1 & 0xF) =3D=3D config) {
+            qemu_set_irq(s->gpio_out[0], level);
+            DB_PRINT("Pulse EXTI: 0\n");
+        }
+        break;
+    case 1:
+        if (((s->syscfg_exticr1 & 0xF0) >> 4) =3D=3D config) {
+            qemu_set_irq(s->gpio_out[1], level);
+            DB_PRINT("Pulse EXTI: 1\n");
+        }
+        break;
+    case 2:
+        if (((s->syscfg_exticr1 & 0xF00) >> 8) =3D=3D config) {
+            qemu_set_irq(s->gpio_out[2], level);
+            DB_PRINT("Pulse EXTI: 2\n");
+        }
+        break;
+    case 3:
+        if (((s->syscfg_exticr1 & 0xF000) >> 12) =3D=3D config) {
+            qemu_set_irq(s->gpio_out[3], level);
+            DB_PRINT("Pulse EXTI: 3\n");
+        }
+        break;
+    case 4:
+        if ((s->syscfg_exticr2 & 0xF) =3D=3D config) {
+            qemu_set_irq(s->gpio_out[4], level);
+            DB_PRINT("Pulse EXTI: 4\n");
+        }
+        break;
+    case 5:
+        if (((s->syscfg_exticr2 & 0xF0) >> 4) =3D=3D config) {
+            qemu_set_irq(s->gpio_out[5], level);
+            DB_PRINT("Pulse EXTI: 5\n");
+        }
+        break;
+    case 6:
+        if (((s->syscfg_exticr2 & 0xF00) >> 8) =3D=3D config) {
+            qemu_set_irq(s->gpio_out[6], level);
+            DB_PRINT("Pulse EXTI: 6\n");
+        }
+        break;
+    case 7:
+        if (((s->syscfg_exticr2 & 0xF000) >> 12) =3D=3D config) {
+            qemu_set_irq(s->gpio_out[7], level);
+            DB_PRINT("Pulse EXTI: 7\n");
+        }
+        break;
+    case 8:
+        if ((s->syscfg_exticr3 & 0xF) =3D=3D config) {
+            qemu_set_irq(s->gpio_out[8], level);
+            DB_PRINT("Pulse EXTI: 8\n");
+        }
+        break;
+    case 9:
+        if (((s->syscfg_exticr3 & 0xF0) >> 4) =3D=3D config) {
+            qemu_set_irq(s->gpio_out[9], level);
+            DB_PRINT("Pulse EXTI: 9\n");
+        }
+        break;
+    case 10:
+        if (((s->syscfg_exticr3 & 0xF00) >> 8) =3D=3D config) {
+            qemu_set_irq(s->gpio_out[10], level);
+            DB_PRINT("Pulse EXTI: 10\n");
+        }
+        break;
+    case 11:
+        if (((s->syscfg_exticr3 & 0xF000) >> 12) =3D=3D config) {
+            qemu_set_irq(s->gpio_out[11], level);
+            DB_PRINT("Pulse EXTI: 11\n");
+        }
+        break;
+    case 12:
+        if ((s->syscfg_exticr4 & 0xF) =3D=3D config) {
+            qemu_set_irq(s->gpio_out[12], level);
+            DB_PRINT("Pulse EXTI: 12\n");
+        }
+        break;
+    case 13:
+        if (((s->syscfg_exticr4 & 0xF0) >> 4) =3D=3D config) {
+            qemu_set_irq(s->gpio_out[13], level);
+            DB_PRINT("Pulse EXTI: 13\n");
+        }
+        break;
+    case 14:
+        if (((s->syscfg_exticr4 & 0xF00) >> 8) =3D=3D config) {
+            qemu_set_irq(s->gpio_out[14], level);
+            DB_PRINT("Pulse EXTI: 14\n");
+        }
+        break;
+    case 15:
+        if (((s->syscfg_exticr4 & 0xF000) >> 12) =3D=3D config) {
+            qemu_set_irq(s->gpio_out[15], level);
+            DB_PRINT("Pulse EXTI: 15\n");
+        }
+        break;
+    }
+}
+
+static uint64_t stm32f4xx_syscfg_read(void *opaque, hwaddr addr,
+                                     unsigned int size)
+{
+    STM32F4xxSyscfgState *s =3D opaque;
+
+    DB_PRINT("0x%"HWADDR_PRIx"\n", addr);
+
+    switch (addr) {
+    case SYSCFG_MEMRMP:
+        return s->syscfg_memrmp;
+    case SYSCFG_PMC:
+        return s->syscfg_pmc;
+    case SYSCFG_EXTICR1:
+        return s->syscfg_exticr1;
+    case SYSCFG_EXTICR2:
+        return s->syscfg_exticr2;
+    case SYSCFG_EXTICR3:
+        return s->syscfg_exticr3;
+    case SYSCFG_EXTICR4:
+        return s->syscfg_exticr4;
+    case SYSCFG_CMPCR:
+        return s->syscfg_cmpcr;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, addr)=
;
+        return 0;
+    }
+
+    return 0;
+}
+
+static void stm32f4xx_syscfg_write(void *opaque, hwaddr addr,
+                       uint64_t val64, unsigned int size)
+{
+    STM32F4xxSyscfgState *s =3D opaque;
+    uint32_t value =3D val64;
+
+    DB_PRINT("0x%x, 0x%"HWADDR_PRIx"\n", value, addr);
+
+    switch (addr) {
+    case SYSCFG_MEMRMP:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Changeing the memory mapping isn't supported " =
\
+                      "in QEMU\n", __func__);
+        return;
+    case SYSCFG_PMC:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Changeing the memory mapping isn't supported " =
\
+                      "in QEMU\n", __func__);
+        return;
+    case SYSCFG_EXTICR1:
+        s->syscfg_exticr1 =3D (value & 0xFFFF);
+        return;
+    case SYSCFG_EXTICR2:
+        s->syscfg_exticr2 =3D (value & 0xFFFF);
+        return;
+    case SYSCFG_EXTICR3:
+        s->syscfg_exticr3 =3D (value & 0xFFFF);
+        return;
+    case SYSCFG_EXTICR4:
+        s->syscfg_exticr4 =3D (value & 0xFFFF);
+        return;
+    case SYSCFG_CMPCR:
+        s->syscfg_cmpcr =3D value;
+        return;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, addr)=
;
+    }
+}
+
+static const MemoryRegionOps stm32f4xx_syscfg_ops =3D {
+    .read =3D stm32f4xx_syscfg_read,
+    .write =3D stm32f4xx_syscfg_write,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+};
+
+static void stm32f4xx_syscfg_init(Object *obj)
+{
+    STM32F4xxSyscfgState *s =3D STM32F4XX_SYSCFG(obj);
+
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
+
+    memory_region_init_io(&s->mmio, obj, &stm32f4xx_syscfg_ops, s,
+                          TYPE_STM32F4XX_SYSCFG, 0x400);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+
+    qdev_init_gpio_in(DEVICE(obj), stm32f4xx_syscfg_set_irq, 16 * 9);
+    qdev_init_gpio_out(DEVICE(obj), s->gpio_out, 16);
+}
+
+static void stm32f4xx_syscfg_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->reset =3D stm32f4xx_syscfg_reset;
+}
+
+static const TypeInfo stm32f4xx_syscfg_info =3D {
+    .name          =3D TYPE_STM32F4XX_SYSCFG,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(STM32F4xxSyscfgState),
+    .instance_init =3D stm32f4xx_syscfg_init,
+    .class_init    =3D stm32f4xx_syscfg_class_init,
+};
+
+static void stm32f4xx_syscfg_register_types(void)
+{
+    type_register_static(&stm32f4xx_syscfg_info);
+}
+
+type_init(stm32f4xx_syscfg_register_types)
diff --git a/include/hw/misc/stm32f4xx_syscfg.h b/include/hw/misc/stm32f4xx=
_syscfg.h
new file mode 100644
index 0000000000..790f60746f
--- /dev/null
+++ b/include/hw/misc/stm32f4xx_syscfg.h
@@ -0,0 +1,62 @@
+/*
+ * STM32F4xx SYSCFG
+ *
+ * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy
+ * of this software and associated documentation files (the "Software"), t=
o deal
+ * in the Software without restriction, including without limitation the r=
ights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN
+ * THE SOFTWARE.
+ */
+
+#ifndef HW_STM_SYSCFG_H
+#define HW_STM_SYSCFG_H
+
+#include "hw/sysbus.h"
+#include "hw/hw.h"
+
+#define SYSCFG_MEMRMP  0x00
+#define SYSCFG_PMC     0x04
+#define SYSCFG_EXTICR1 0x08
+#define SYSCFG_EXTICR2 0x0C
+#define SYSCFG_EXTICR3 0x10
+#define SYSCFG_EXTICR4 0x14
+#define SYSCFG_CMPCR   0x20
+
+#define TYPE_STM32F4XX_SYSCFG "stm32f4xx-syscfg"
+#define STM32F4XX_SYSCFG(obj) \
+    OBJECT_CHECK(STM32F4xxSyscfgState, (obj), TYPE_STM32F4XX_SYSCFG)
+
+typedef struct {
+    /* <private> */
+    SysBusDevice parent_obj;
+
+    /* <public> */
+    MemoryRegion mmio;
+
+    uint32_t syscfg_memrmp;
+    uint32_t syscfg_pmc;
+    uint32_t syscfg_exticr1;
+    uint32_t syscfg_exticr2;
+    uint32_t syscfg_exticr3;
+    uint32_t syscfg_exticr4;
+    uint32_t syscfg_cmpcr;
+
+    qemu_irq irq;
+    qemu_irq gpio_out[16];
+} STM32F4xxSyscfgState;
+
+#endif
--=20
2.21.0
