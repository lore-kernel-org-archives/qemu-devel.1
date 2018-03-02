Received: from eggs.gnu.org ([2001:4830:134:3::10]:43303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWV-0002lx-UU
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWT-0004l1-JU
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:47 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46748)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eriWT-0004kH-9J
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:45 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWP-0001IV-SJ
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:06:41 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  2 Mar 2018 11:06:02 +0000
Message-Id: <20180302110640.28004-2-peter.maydell@linaro.org>
In-Reply-To: <20180302110640.28004-1-peter.maydell@linaro.org>
References: <20180302110640.28004-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/39] xlnx-zynqmp-rtc: Initial commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alistair Francis <alistair.francis@xilinx.com>

Initial commit of the ZynqMP RTC device.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/Makefile.objs             |   1 +
 include/hw/timer/xlnx-zynqmp-rtc.h |  84 +++++++++++++++
 hw/timer/xlnx-zynqmp-rtc.c         | 214 +++++++++++++++++++++++++++++++++++++
 3 files changed, 299 insertions(+)
 create mode 100644 include/hw/timer/xlnx-zynqmp-rtc.h
 create mode 100644 hw/timer/xlnx-zynqmp-rtc.c

diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 8c19eac3b6..8b27a4b7ef 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -21,6 +21,7 @@ common-obj-$(CONFIG_IMX) += imx_epit.o
 common-obj-$(CONFIG_IMX) += imx_gpt.o
 common-obj-$(CONFIG_LM32) += lm32_timer.o
 common-obj-$(CONFIG_MILKYMIST) += milkymist-sysctl.o
+common-obj-$(CONFIG_XLNX_ZYNQMP) += xlnx-zynqmp-rtc.o
 
 obj-$(CONFIG_ALTERA_TIMER) += altera_timer.o
 obj-$(CONFIG_EXYNOS4) += exynos4210_mct.o
diff --git a/include/hw/timer/xlnx-zynqmp-rtc.h b/include/hw/timer/xlnx-zynqmp-rtc.h
new file mode 100644
index 0000000000..87649836cc
--- /dev/null
+++ b/include/hw/timer/xlnx-zynqmp-rtc.h
@@ -0,0 +1,84 @@
+/*
+ * QEMU model of the Xilinx ZynqMP Real Time Clock (RTC).
+ *
+ * Copyright (c) 2017 Xilinx Inc.
+ *
+ * Written-by: Alistair Francis <alistair.francis@xilinx.com>
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
+#include "hw/register.h"
+
+#define TYPE_XLNX_ZYNQMP_RTC "xlnx-zynmp.rtc"
+
+#define XLNX_ZYNQMP_RTC(obj) \
+     OBJECT_CHECK(XlnxZynqMPRTC, (obj), TYPE_XLNX_ZYNQMP_RTC)
+
+REG32(SET_TIME_WRITE, 0x0)
+REG32(SET_TIME_READ, 0x4)
+REG32(CALIB_WRITE, 0x8)
+    FIELD(CALIB_WRITE, FRACTION_EN, 20, 1)
+    FIELD(CALIB_WRITE, FRACTION_DATA, 16, 4)
+    FIELD(CALIB_WRITE, MAX_TICK, 0, 16)
+REG32(CALIB_READ, 0xc)
+    FIELD(CALIB_READ, FRACTION_EN, 20, 1)
+    FIELD(CALIB_READ, FRACTION_DATA, 16, 4)
+    FIELD(CALIB_READ, MAX_TICK, 0, 16)
+REG32(CURRENT_TIME, 0x10)
+REG32(CURRENT_TICK, 0x14)
+    FIELD(CURRENT_TICK, VALUE, 0, 16)
+REG32(ALARM, 0x18)
+REG32(RTC_INT_STATUS, 0x20)
+    FIELD(RTC_INT_STATUS, ALARM, 1, 1)
+    FIELD(RTC_INT_STATUS, SECONDS, 0, 1)
+REG32(RTC_INT_MASK, 0x24)
+    FIELD(RTC_INT_MASK, ALARM, 1, 1)
+    FIELD(RTC_INT_MASK, SECONDS, 0, 1)
+REG32(RTC_INT_EN, 0x28)
+    FIELD(RTC_INT_EN, ALARM, 1, 1)
+    FIELD(RTC_INT_EN, SECONDS, 0, 1)
+REG32(RTC_INT_DIS, 0x2c)
+    FIELD(RTC_INT_DIS, ALARM, 1, 1)
+    FIELD(RTC_INT_DIS, SECONDS, 0, 1)
+REG32(ADDR_ERROR, 0x30)
+    FIELD(ADDR_ERROR, STATUS, 0, 1)
+REG32(ADDR_ERROR_INT_MASK, 0x34)
+    FIELD(ADDR_ERROR_INT_MASK, MASK, 0, 1)
+REG32(ADDR_ERROR_INT_EN, 0x38)
+    FIELD(ADDR_ERROR_INT_EN, MASK, 0, 1)
+REG32(ADDR_ERROR_INT_DIS, 0x3c)
+    FIELD(ADDR_ERROR_INT_DIS, MASK, 0, 1)
+REG32(CONTROL, 0x40)
+    FIELD(CONTROL, BATTERY_DISABLE, 31, 1)
+    FIELD(CONTROL, OSC_CNTRL, 24, 4)
+    FIELD(CONTROL, SLVERR_ENABLE, 0, 1)
+REG32(SAFETY_CHK, 0x50)
+
+#define XLNX_ZYNQMP_RTC_R_MAX (R_SAFETY_CHK + 1)
+
+typedef struct XlnxZynqMPRTC {
+    SysBusDevice parent_obj;
+    MemoryRegion iomem;
+    qemu_irq irq_rtc_int;
+    qemu_irq irq_addr_error_int;
+
+    uint32_t regs[XLNX_ZYNQMP_RTC_R_MAX];
+    RegisterInfo regs_info[XLNX_ZYNQMP_RTC_R_MAX];
+} XlnxZynqMPRTC;
diff --git a/hw/timer/xlnx-zynqmp-rtc.c b/hw/timer/xlnx-zynqmp-rtc.c
new file mode 100644
index 0000000000..707f145027
--- /dev/null
+++ b/hw/timer/xlnx-zynqmp-rtc.c
@@ -0,0 +1,214 @@
+/*
+ * QEMU model of the Xilinx ZynqMP Real Time Clock (RTC).
+ *
+ * Copyright (c) 2017 Xilinx Inc.
+ *
+ * Written-by: Alistair Francis <alistair.francis@xilinx.com>
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
+#include "hw/sysbus.h"
+#include "hw/register.h"
+#include "qemu/bitops.h"
+#include "qemu/log.h"
+#include "hw/timer/xlnx-zynqmp-rtc.h"
+
+#ifndef XLNX_ZYNQMP_RTC_ERR_DEBUG
+#define XLNX_ZYNQMP_RTC_ERR_DEBUG 0
+#endif
+
+static void rtc_int_update_irq(XlnxZynqMPRTC *s)
+{
+    bool pending = s->regs[R_RTC_INT_STATUS] & ~s->regs[R_RTC_INT_MASK];
+    qemu_set_irq(s->irq_rtc_int, pending);
+}
+
+static void addr_error_int_update_irq(XlnxZynqMPRTC *s)
+{
+    bool pending = s->regs[R_ADDR_ERROR] & ~s->regs[R_ADDR_ERROR_INT_MASK];
+    qemu_set_irq(s->irq_addr_error_int, pending);
+}
+
+static void rtc_int_status_postw(RegisterInfo *reg, uint64_t val64)
+{
+    XlnxZynqMPRTC *s = XLNX_ZYNQMP_RTC(reg->opaque);
+    rtc_int_update_irq(s);
+}
+
+static uint64_t rtc_int_en_prew(RegisterInfo *reg, uint64_t val64)
+{
+    XlnxZynqMPRTC *s = XLNX_ZYNQMP_RTC(reg->opaque);
+
+    s->regs[R_RTC_INT_MASK] &= (uint32_t) ~val64;
+    rtc_int_update_irq(s);
+    return 0;
+}
+
+static uint64_t rtc_int_dis_prew(RegisterInfo *reg, uint64_t val64)
+{
+    XlnxZynqMPRTC *s = XLNX_ZYNQMP_RTC(reg->opaque);
+
+    s->regs[R_RTC_INT_MASK] |= (uint32_t) val64;
+    rtc_int_update_irq(s);
+    return 0;
+}
+
+static void addr_error_postw(RegisterInfo *reg, uint64_t val64)
+{
+    XlnxZynqMPRTC *s = XLNX_ZYNQMP_RTC(reg->opaque);
+    addr_error_int_update_irq(s);
+}
+
+static uint64_t addr_error_int_en_prew(RegisterInfo *reg, uint64_t val64)
+{
+    XlnxZynqMPRTC *s = XLNX_ZYNQMP_RTC(reg->opaque);
+
+    s->regs[R_ADDR_ERROR_INT_MASK] &= (uint32_t) ~val64;
+    addr_error_int_update_irq(s);
+    return 0;
+}
+
+static uint64_t addr_error_int_dis_prew(RegisterInfo *reg, uint64_t val64)
+{
+    XlnxZynqMPRTC *s = XLNX_ZYNQMP_RTC(reg->opaque);
+
+    s->regs[R_ADDR_ERROR_INT_MASK] |= (uint32_t) val64;
+    addr_error_int_update_irq(s);
+    return 0;
+}
+
+static const RegisterAccessInfo rtc_regs_info[] = {
+    {   .name = "SET_TIME_WRITE",  .addr = A_SET_TIME_WRITE,
+    },{ .name = "SET_TIME_READ",  .addr = A_SET_TIME_READ,
+        .ro = 0xffffffff,
+    },{ .name = "CALIB_WRITE",  .addr = A_CALIB_WRITE,
+    },{ .name = "CALIB_READ",  .addr = A_CALIB_READ,
+        .ro = 0x1fffff,
+    },{ .name = "CURRENT_TIME",  .addr = A_CURRENT_TIME,
+        .ro = 0xffffffff,
+    },{ .name = "CURRENT_TICK",  .addr = A_CURRENT_TICK,
+        .ro = 0xffff,
+    },{ .name = "ALARM",  .addr = A_ALARM,
+    },{ .name = "RTC_INT_STATUS",  .addr = A_RTC_INT_STATUS,
+        .w1c = 0x3,
+        .post_write = rtc_int_status_postw,
+    },{ .name = "RTC_INT_MASK",  .addr = A_RTC_INT_MASK,
+        .reset = 0x3,
+        .ro = 0x3,
+    },{ .name = "RTC_INT_EN",  .addr = A_RTC_INT_EN,
+        .pre_write = rtc_int_en_prew,
+    },{ .name = "RTC_INT_DIS",  .addr = A_RTC_INT_DIS,
+        .pre_write = rtc_int_dis_prew,
+    },{ .name = "ADDR_ERROR",  .addr = A_ADDR_ERROR,
+        .w1c = 0x1,
+        .post_write = addr_error_postw,
+    },{ .name = "ADDR_ERROR_INT_MASK",  .addr = A_ADDR_ERROR_INT_MASK,
+        .reset = 0x1,
+        .ro = 0x1,
+    },{ .name = "ADDR_ERROR_INT_EN",  .addr = A_ADDR_ERROR_INT_EN,
+        .pre_write = addr_error_int_en_prew,
+    },{ .name = "ADDR_ERROR_INT_DIS",  .addr = A_ADDR_ERROR_INT_DIS,
+        .pre_write = addr_error_int_dis_prew,
+    },{ .name = "CONTROL",  .addr = A_CONTROL,
+        .reset = 0x1000000,
+        .rsvd = 0x70fffffe,
+    },{ .name = "SAFETY_CHK",  .addr = A_SAFETY_CHK,
+    }
+};
+
+static void rtc_reset(DeviceState *dev)
+{
+    XlnxZynqMPRTC *s = XLNX_ZYNQMP_RTC(dev);
+    unsigned int i;
+
+    for (i = 0; i < ARRAY_SIZE(s->regs_info); ++i) {
+        register_reset(&s->regs_info[i]);
+    }
+
+    rtc_int_update_irq(s);
+    addr_error_int_update_irq(s);
+}
+
+static const MemoryRegionOps rtc_ops = {
+    .read = register_read_memory,
+    .write = register_write_memory,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void rtc_init(Object *obj)
+{
+    XlnxZynqMPRTC *s = XLNX_ZYNQMP_RTC(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    RegisterInfoArray *reg_array;
+
+    memory_region_init(&s->iomem, obj, TYPE_XLNX_ZYNQMP_RTC,
+                       XLNX_ZYNQMP_RTC_R_MAX * 4);
+    reg_array =
+        register_init_block32(DEVICE(obj), rtc_regs_info,
+                              ARRAY_SIZE(rtc_regs_info),
+                              s->regs_info, s->regs,
+                              &rtc_ops,
+                              XLNX_ZYNQMP_RTC_ERR_DEBUG,
+                              XLNX_ZYNQMP_RTC_R_MAX * 4);
+    memory_region_add_subregion(&s->iomem,
+                                0x0,
+                                &reg_array->mem);
+    sysbus_init_mmio(sbd, &s->iomem);
+    sysbus_init_irq(sbd, &s->irq_rtc_int);
+    sysbus_init_irq(sbd, &s->irq_addr_error_int);
+}
+
+static const VMStateDescription vmstate_rtc = {
+    .name = TYPE_XLNX_ZYNQMP_RTC,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, XlnxZynqMPRTC, XLNX_ZYNQMP_RTC_R_MAX),
+        VMSTATE_END_OF_LIST(),
+    }
+};
+
+static void rtc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = rtc_reset;
+    dc->vmsd = &vmstate_rtc;
+}
+
+static const TypeInfo rtc_info = {
+    .name          = TYPE_XLNX_ZYNQMP_RTC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(XlnxZynqMPRTC),
+    .class_init    = rtc_class_init,
+    .instance_init = rtc_init,
+};
+
+static void rtc_register_types(void)
+{
+    type_register_static(&rtc_info);
+}
+
+type_init(rtc_register_types)
-- 
2.16.2
