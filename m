Received: from eggs.gnu.org ([2001:4830:134:3::10]:35241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1epH6m-0000U2-UD
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:26:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1epH6j-0004Cq-Hw
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:26:08 -0500
Received: from mail-sn1nam01on0041.outbound.protection.outlook.com
	([104.47.32.41]:13664
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1epH6i-0004AG-Rt
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:26:05 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 23 Feb 2018 09:21:19 -0800
Message-ID: <e7b623b75f374900b555fdcf5c22e0a73144fa64.1519406423.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1519406423.git.alistair.francis@xilinx.com>
References: <cover.1519406423.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 1/3] xlnx-zynqmp-rtc: Initial commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com, f4bug@amsat.org

Initial commit of the ZynqMP RTC device.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---

v5:
 - Don't use intermediate val
V2:
 - Delete unused realise function
 - Remove DB_PRINT()

 include/hw/timer/xlnx-zynqmp-rtc.h |  84 +++++++++++++++
 hw/timer/xlnx-zynqmp-rtc.c         | 214 +++++++++++++++++++++++++++++++++=
++++
 hw/timer/Makefile.objs             |   1 +
 3 files changed, 299 insertions(+)
 create mode 100644 include/hw/timer/xlnx-zynqmp-rtc.h
 create mode 100644 hw/timer/xlnx-zynqmp-rtc.c

diff --git a/include/hw/timer/xlnx-zynqmp-rtc.h b/include/hw/timer/xlnx-zyn=
qmp-rtc.h
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
+    bool pending =3D s->regs[R_RTC_INT_STATUS] & ~s->regs[R_RTC_INT_MASK];
+    qemu_set_irq(s->irq_rtc_int, pending);
+}
+
+static void addr_error_int_update_irq(XlnxZynqMPRTC *s)
+{
+    bool pending =3D s->regs[R_ADDR_ERROR] & ~s->regs[R_ADDR_ERROR_INT_MAS=
K];
+    qemu_set_irq(s->irq_addr_error_int, pending);
+}
+
+static void rtc_int_status_postw(RegisterInfo *reg, uint64_t val64)
+{
+    XlnxZynqMPRTC *s =3D XLNX_ZYNQMP_RTC(reg->opaque);
+    rtc_int_update_irq(s);
+}
+
+static uint64_t rtc_int_en_prew(RegisterInfo *reg, uint64_t val64)
+{
+    XlnxZynqMPRTC *s =3D XLNX_ZYNQMP_RTC(reg->opaque);
+
+    s->regs[R_RTC_INT_MASK] &=3D (uint32_t) ~val64;
+    rtc_int_update_irq(s);
+    return 0;
+}
+
+static uint64_t rtc_int_dis_prew(RegisterInfo *reg, uint64_t val64)
+{
+    XlnxZynqMPRTC *s =3D XLNX_ZYNQMP_RTC(reg->opaque);
+
+    s->regs[R_RTC_INT_MASK] |=3D (uint32_t) val64;
+    rtc_int_update_irq(s);
+    return 0;
+}
+
+static void addr_error_postw(RegisterInfo *reg, uint64_t val64)
+{
+    XlnxZynqMPRTC *s =3D XLNX_ZYNQMP_RTC(reg->opaque);
+    addr_error_int_update_irq(s);
+}
+
+static uint64_t addr_error_int_en_prew(RegisterInfo *reg, uint64_t val64)
+{
+    XlnxZynqMPRTC *s =3D XLNX_ZYNQMP_RTC(reg->opaque);
+
+    s->regs[R_ADDR_ERROR_INT_MASK] &=3D (uint32_t) ~val64;
+    addr_error_int_update_irq(s);
+    return 0;
+}
+
+static uint64_t addr_error_int_dis_prew(RegisterInfo *reg, uint64_t val64)
+{
+    XlnxZynqMPRTC *s =3D XLNX_ZYNQMP_RTC(reg->opaque);
+
+    s->regs[R_ADDR_ERROR_INT_MASK] |=3D (uint32_t) val64;
+    addr_error_int_update_irq(s);
+    return 0;
+}
+
+static const RegisterAccessInfo rtc_regs_info[] =3D {
+    {   .name =3D "SET_TIME_WRITE",  .addr =3D A_SET_TIME_WRITE,
+    },{ .name =3D "SET_TIME_READ",  .addr =3D A_SET_TIME_READ,
+        .ro =3D 0xffffffff,
+    },{ .name =3D "CALIB_WRITE",  .addr =3D A_CALIB_WRITE,
+    },{ .name =3D "CALIB_READ",  .addr =3D A_CALIB_READ,
+        .ro =3D 0x1fffff,
+    },{ .name =3D "CURRENT_TIME",  .addr =3D A_CURRENT_TIME,
+        .ro =3D 0xffffffff,
+    },{ .name =3D "CURRENT_TICK",  .addr =3D A_CURRENT_TICK,
+        .ro =3D 0xffff,
+    },{ .name =3D "ALARM",  .addr =3D A_ALARM,
+    },{ .name =3D "RTC_INT_STATUS",  .addr =3D A_RTC_INT_STATUS,
+        .w1c =3D 0x3,
+        .post_write =3D rtc_int_status_postw,
+    },{ .name =3D "RTC_INT_MASK",  .addr =3D A_RTC_INT_MASK,
+        .reset =3D 0x3,
+        .ro =3D 0x3,
+    },{ .name =3D "RTC_INT_EN",  .addr =3D A_RTC_INT_EN,
+        .pre_write =3D rtc_int_en_prew,
+    },{ .name =3D "RTC_INT_DIS",  .addr =3D A_RTC_INT_DIS,
+        .pre_write =3D rtc_int_dis_prew,
+    },{ .name =3D "ADDR_ERROR",  .addr =3D A_ADDR_ERROR,
+        .w1c =3D 0x1,
+        .post_write =3D addr_error_postw,
+    },{ .name =3D "ADDR_ERROR_INT_MASK",  .addr =3D A_ADDR_ERROR_INT_MASK,
+        .reset =3D 0x1,
+        .ro =3D 0x1,
+    },{ .name =3D "ADDR_ERROR_INT_EN",  .addr =3D A_ADDR_ERROR_INT_EN,
+        .pre_write =3D addr_error_int_en_prew,
+    },{ .name =3D "ADDR_ERROR_INT_DIS",  .addr =3D A_ADDR_ERROR_INT_DIS,
+        .pre_write =3D addr_error_int_dis_prew,
+    },{ .name =3D "CONTROL",  .addr =3D A_CONTROL,
+        .reset =3D 0x1000000,
+        .rsvd =3D 0x70fffffe,
+    },{ .name =3D "SAFETY_CHK",  .addr =3D A_SAFETY_CHK,
+    }
+};
+
+static void rtc_reset(DeviceState *dev)
+{
+    XlnxZynqMPRTC *s =3D XLNX_ZYNQMP_RTC(dev);
+    unsigned int i;
+
+    for (i =3D 0; i < ARRAY_SIZE(s->regs_info); ++i) {
+        register_reset(&s->regs_info[i]);
+    }
+
+    rtc_int_update_irq(s);
+    addr_error_int_update_irq(s);
+}
+
+static const MemoryRegionOps rtc_ops =3D {
+    .read =3D register_read_memory,
+    .write =3D register_write_memory,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+    .valid =3D {
+        .min_access_size =3D 4,
+        .max_access_size =3D 4,
+    },
+};
+
+static void rtc_init(Object *obj)
+{
+    XlnxZynqMPRTC *s =3D XLNX_ZYNQMP_RTC(obj);
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
+    RegisterInfoArray *reg_array;
+
+    memory_region_init(&s->iomem, obj, TYPE_XLNX_ZYNQMP_RTC,
+                       XLNX_ZYNQMP_RTC_R_MAX * 4);
+    reg_array =3D
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
+static const VMStateDescription vmstate_rtc =3D {
+    .name =3D TYPE_XLNX_ZYNQMP_RTC,
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, XlnxZynqMPRTC, XLNX_ZYNQMP_RTC_R_MAX),
+        VMSTATE_END_OF_LIST(),
+    }
+};
+
+static void rtc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->reset =3D rtc_reset;
+    dc->vmsd =3D &vmstate_rtc;
+}
+
+static const TypeInfo rtc_info =3D {
+    .name          =3D TYPE_XLNX_ZYNQMP_RTC,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(XlnxZynqMPRTC),
+    .class_init    =3D rtc_class_init,
+    .instance_init =3D rtc_init,
+};
+
+static void rtc_register_types(void)
+{
+    type_register_static(&rtc_info);
+}
+
+type_init(rtc_register_types)
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 8c19eac3b6..8b27a4b7ef 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -21,6 +21,7 @@ common-obj-$(CONFIG_IMX) +=3D imx_epit.o
 common-obj-$(CONFIG_IMX) +=3D imx_gpt.o
 common-obj-$(CONFIG_LM32) +=3D lm32_timer.o
 common-obj-$(CONFIG_MILKYMIST) +=3D milkymist-sysctl.o
+common-obj-$(CONFIG_XLNX_ZYNQMP) +=3D xlnx-zynqmp-rtc.o
=20
 obj-$(CONFIG_ALTERA_TIMER) +=3D altera_timer.o
 obj-$(CONFIG_EXYNOS4) +=3D exynos4210_mct.o
--=20
2.14.1
