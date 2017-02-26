Received: from eggs.gnu.org ([2001:4830:134:3::10]:44986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1ci4r5-00055B-Uf
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 14:51:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1ci4r4-0003gb-El
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 14:51:40 -0500
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 26 Feb 2017 21:51:14 +0200
Message-Id: <20170226195115.26564-1-krzk@kernel.org>
Subject: [Qemu-devel] [PATCH 1/2] hw/arm/exynos: Fix Linux kernel division
 by zero for PLLs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mitsyanko <i.mitsyanko@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>

Without any clock controller, the Linux kernel was hitting division by
zero during boot or with clk_summary:
[    0.000000] [<c031054c>] (unwind_backtrace) from [<c030ba6c>] (show_stack+0x10/0x14)
[    0.000000] [<c030ba6c>] (show_stack) from [<c05b2660>] (dump_stack+0x88/0x9c)
[    0.000000] [<c05b2660>] (dump_stack) from [<c05b11a4>] (Ldiv0+0x8/0x10)
[    0.000000] [<c05b11a4>] (Ldiv0) from [<c06ad1e0>] (samsung_pll45xx_recalc_rate+0x58/0x74)
[    0.000000] [<c06ad1e0>] (samsung_pll45xx_recalc_rate) from [<c0692ec0>] (clk_register+0x39c/0x63c)
[    0.000000] [<c0692ec0>] (clk_register) from [<c125d360>] (samsung_clk_register_pll+0x2e0/0x3d4)
[    0.000000] [<c125d360>] (samsung_clk_register_pll) from [<c125d7e8>] (exynos4_clk_init+0x1b0/0x5e4)
[    0.000000] [<c125d7e8>] (exynos4_clk_init) from [<c12335f4>] (of_clk_init+0x17c/0x210)
[    0.000000] [<c12335f4>] (of_clk_init) from [<c1204700>] (time_init+0x24/0x2c)
[    0.000000] [<c1204700>] (time_init) from [<c1200b2c>] (start_kernel+0x24c/0x38c)
[    0.000000] [<c1200b2c>] (start_kernel) from [<4020807c>] (0x4020807c)

Provide stub for clock controller returning reset values for PLLs.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 hw/arm/exynos4210.c      |   6 ++
 hw/misc/Makefile.objs    |   2 +-
 hw/misc/exynos4210_clk.c | 164 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 171 insertions(+), 1 deletion(-)
 create mode 100644 hw/misc/exynos4210_clk.c

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index be3c96d21ea3..a0ecbe8c1ffc 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -24,6 +24,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
+#include "qemu/log.h"
 #include "cpu.h"
 #include "hw/boards.h"
 #include "sysemu/sysemu.h"
@@ -74,6 +75,9 @@
 /* PMU SFR base address */
 #define EXYNOS4210_PMU_BASE_ADDR            0x10020000
 
+/* Clock controller SFR base address */
+#define EXYNOS4210_CLK_BASE_ADDR            0x10030000
+
 /* Display controllers (FIMD) */
 #define EXYNOS4210_FIMD0_BASE_ADDR          0x11C00000
 
@@ -297,6 +301,8 @@ Exynos4210State *exynos4210_init(MemoryRegion *system_mem,
     */
     sysbus_create_simple("exynos4210.pmu", EXYNOS4210_PMU_BASE_ADDR, NULL);
 
+    sysbus_create_simple("exynos4210.clk", EXYNOS4210_CLK_BASE_ADDR, NULL);
+
     /* PWM */
     sysbus_create_varargs("exynos4210.pwm", EXYNOS4210_PWM_BASE_ADDR,
                           s->irq_table[exynos4210_get_irq(22, 0)],
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 898e4ccfb1ee..8e080def33ae 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -26,7 +26,7 @@ obj-$(CONFIG_IVSHMEM) += ivshmem.o
 obj-$(CONFIG_REALVIEW) += arm_sysctl.o
 obj-$(CONFIG_NSERIES) += cbus.o
 obj-$(CONFIG_ECCMEMCTL) += eccmemctl.o
-obj-$(CONFIG_EXYNOS4) += exynos4210_pmu.o
+obj-$(CONFIG_EXYNOS4) += exynos4210_pmu.o exynos4210_clk.o
 obj-$(CONFIG_IMX) += imx_ccm.o
 obj-$(CONFIG_IMX) += imx31_ccm.o
 obj-$(CONFIG_IMX) += imx25_ccm.o
diff --git a/hw/misc/exynos4210_clk.c b/hw/misc/exynos4210_clk.c
new file mode 100644
index 000000000000..0ad89bb7d39b
--- /dev/null
+++ b/hw/misc/exynos4210_clk.c
@@ -0,0 +1,164 @@
+/*
+ *  Exynos4210 Clock Controller Emulation
+ *
+ *  Copyright (c) 2017 Krzysztof Kozlowski <krzk@kernel.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+#include "qemu/log.h"
+
+#define TYPE_EXYNOS4210_CLK             "exynos4210.clk"
+#define EXYNOS4210_CLK(obj) \
+    OBJECT_CHECK(Exynos4210ClkState, (obj), TYPE_EXYNOS4210_CLK)
+
+#define CLK_PLL_LOCKED                  BIT(29)
+
+#define EXYNOS4210_CLK_REGS_MEM_SIZE    0x15104
+
+typedef struct Exynos4210Reg {
+    const char   *name; /* for debug only */
+    uint32_t     offset;
+    uint32_t     reset_value;
+} Exynos4210Reg;
+
+/* Clock controller register base: 0x10030000 */
+static const Exynos4210Reg exynos4210_clk_regs[] = {
+    {"EPLL_LOCK",                     0xc010, 0x00000fff},
+    {"VPLL_LOCK",                     0xc020, 0x00000fff},
+    {"EPLL_CON0",                     0xc110, 0x00300301 + CLK_PLL_LOCKED},
+    {"EPLL_CON1",                     0xc114, 0x00000000},
+    {"VPLL_CON0",                     0xc120, 0x00240201 + CLK_PLL_LOCKED},
+    {"VPLL_CON1",                     0xc124, 0x66010464},
+    {"APLL_LOCK",                    0x14000, 0x00000fff},
+    {"MPLL_LOCK",                    0x14004, 0x00000fff},
+    {"APLL_CON0",                    0x14100, 0x00c80601 + CLK_PLL_LOCKED},
+    {"APLL_CON1",                    0x14104, 0x0000001c},
+    {"MPLL_CON0",                    0x14108, 0x00c80601 + CLK_PLL_LOCKED},
+    {"MPLL_CON1",                    0x1410c, 0x0000001c},
+};
+
+#define EXYNOS4210_REGS_NUM       ARRAY_SIZE(exynos4210_clk_regs)
+
+typedef struct Exynos4210ClkState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    uint32_t reg[EXYNOS4210_REGS_NUM];
+} Exynos4210ClkState;
+
+static uint64_t exynos4210_clk_read(void *opaque, hwaddr offset,
+                                    unsigned size)
+{
+    const Exynos4210ClkState *s = (Exynos4210ClkState *)opaque;
+    const Exynos4210Reg *regs = exynos4210_clk_regs;
+    unsigned int i;
+
+    for (i = 0; i < EXYNOS4210_REGS_NUM; i++) {
+        if (regs->offset == offset) {
+            return s->reg[i];
+        }
+        regs++;
+    }
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: bad read offset 0x%04x\n",
+                  __func__, (uint32_t)offset);
+    return 0;
+}
+
+static void exynos4210_clk_write(void *opaque, hwaddr offset,
+                                 uint64_t val, unsigned size)
+{
+    Exynos4210ClkState *s = (Exynos4210ClkState *)opaque;
+    const Exynos4210Reg *regs = exynos4210_clk_regs;
+    unsigned int i;
+
+    for (i = 0; i < EXYNOS4210_REGS_NUM; i++) {
+        if (regs->offset == offset) {
+            s->reg[i] = val;
+            return;
+        }
+        regs++;
+    }
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: bad write offset 0x%04x\n",
+                  __func__, (uint32_t)offset);
+}
+
+static const MemoryRegionOps exynos4210_clk_ops = {
+    .read = exynos4210_clk_read,
+    .write = exynos4210_clk_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false
+    }
+};
+
+static void exynos4210_clk_reset(DeviceState *dev)
+{
+    Exynos4210ClkState *s = EXYNOS4210_CLK(dev);
+    unsigned int i;
+
+    /* Set default values for registers */
+    for (i = 0; i < EXYNOS4210_REGS_NUM; i++) {
+        s->reg[i] = exynos4210_clk_regs[i].reset_value;
+    }
+}
+
+static void exynos4210_clk_init(Object *obj)
+{
+    Exynos4210ClkState *s = EXYNOS4210_CLK(obj);
+    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
+
+    /* memory mapping */
+    memory_region_init_io(&s->iomem, obj, &exynos4210_clk_ops, s,
+                          TYPE_EXYNOS4210_CLK, EXYNOS4210_CLK_REGS_MEM_SIZE);
+    sysbus_init_mmio(dev, &s->iomem);
+}
+
+static const VMStateDescription exynos4210_clk_vmstate = {
+    .name = TYPE_EXYNOS4210_CLK,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(reg, Exynos4210ClkState, EXYNOS4210_REGS_NUM),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void exynos4210_clk_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = exynos4210_clk_reset;
+    dc->vmsd = &exynos4210_clk_vmstate;
+}
+
+static const TypeInfo exynos4210_clk_info = {
+    .name          = TYPE_EXYNOS4210_CLK,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(Exynos4210ClkState),
+    .instance_init = exynos4210_clk_init,
+    .class_init    = exynos4210_clk_class_init,
+};
+
+static void exynos4210_clk_register(void)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "Clock init\n");
+    type_register_static(&exynos4210_clk_info);
+}
+
+type_init(exynos4210_clk_register)
-- 
2.9.3
