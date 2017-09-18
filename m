Received: from eggs.gnu.org ([2001:4830:134:3::10]:37560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1du251-00070z-00
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 15:51:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1du24z-0006Nh-AL
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 15:51:43 -0400
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon, 18 Sep 2017 12:50:55 -0700
Message-Id: <20170918195100.17593-13-andrew.smirnov@gmail.com>
In-Reply-To: <20170918195100.17593-1-andrew.smirnov@gmail.com>
References: <20170918195100.17593-1-andrew.smirnov@gmail.com>
Subject: [Qemu-devel] [PATCH 12/17] i.MX: Add i.MX7 CCM,
 PMU and ANALOG device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, yurovsky@gmail.com

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Cc: yurovsky@gmail.com
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 hw/misc/Makefile.objs      |   1 +
 hw/misc/imx7_ccm.c         | 201 +++++++++++++++++++++++++++++++++++++++++++++
 include/hw/misc/imx7_ccm.h |  76 +++++++++++++++++
 3 files changed, 278 insertions(+)
 create mode 100644 hw/misc/imx7_ccm.c
 create mode 100644 include/hw/misc/imx7_ccm.h

diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 29fb922cef..ac1be05a03 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -34,6 +34,7 @@ obj-$(CONFIG_IMX) += imx31_ccm.o
 obj-$(CONFIG_IMX) += imx25_ccm.o
 obj-$(CONFIG_IMX) += imx6_ccm.o
 obj-$(CONFIG_IMX) += imx6_src.o
+obj-$(CONFIG_IMX) += imx7_ccm.o
 obj-$(CONFIG_MILKYMIST) += milkymist-hpdmc.o
 obj-$(CONFIG_MILKYMIST) += milkymist-pfpu.o
 obj-$(CONFIG_MAINSTONE) += mst_fpga.o
diff --git a/hw/misc/imx7_ccm.c b/hw/misc/imx7_ccm.c
new file mode 100644
index 0000000000..418aafe7cc
--- /dev/null
+++ b/hw/misc/imx7_ccm.c
@@ -0,0 +1,201 @@
+/*
+ * Copyright (c) 2017, Impinj, Inc.
+ *
+ * i.MX7 CCM, PMU and ANALOG IP blocks emulation code
+ *
+ * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/sizes.h"
+#include "hw/misc/imx7_ccm.h"
+#include "qemu/log.h"
+
+static uint32_t imx7_ccm_get_clock_frequency(IMXCCMState *dev, IMXClk clock)
+{
+    /*
+     * This function is "consumed" by GPT emulation code, however on
+     * i.MX7 each GPT block can have their own clock root. This means
+     * that this functions needs somehow to know requester's identity
+     * and the way to pass it: be it via additional IMXClk constants
+     * or by adding another argument to this method needs to be
+     * figured out
+     */
+    qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Not implemented\n",
+                  TYPE_IMX7_CCM, __func__);
+    return 0;
+}
+
+static void imx7_ccm_reset(DeviceState *dev)
+{
+    IMX7CCMState *s = IMX7_CCM(dev);
+
+    s->analog[CCM_ANALOG_PLL_ARM]         = 0x00002042;
+    s->analog[CCM_ANALOG_PLL_DDR]         = 0x0060302c;
+    s->analog[CCM_ANALOG_PLL_DDR_SS]      = 0x00000000;
+    s->analog[CCM_ANALOG_PLL_DDR_NUM]     = 0x06aaac4d;
+    s->analog[CCM_ANALOG_PLL_DDR_DENOM]   = 0x100003ec;
+    s->analog[CCM_ANALOG_PLL_480]         = 0x00002000;    
+    s->analog[CCM_ANALOG_PLL_480A]        = 0x52605a56;
+    s->analog[CCM_ANALOG_PLL_480B]        = 0x52525216;
+    s->analog[CCM_ANALOG_PLL_ENET]        = 0x00001fc0;
+    s->analog[CCM_ANALOG_PLL_AUDIO]       = 0x0001301b;
+    s->analog[CCM_ANALOG_PLL_AUDIO_SS]    = 0x00000000;
+    s->analog[CCM_ANALOG_PLL_AUDIO_NUM]   = 0x05f5e100;
+    s->analog[CCM_ANALOG_PLL_AUDIO_DENOM] = 0x2964619c;
+    s->analog[CCM_ANALOG_PLL_VIDEO]       = 0x0008201b;
+    s->analog[CCM_ANALOG_PLL_VIDEO_SS]    = 0x00000000;
+    s->analog[CCM_ANALOG_PLL_VIDEO_NUM]   = 0x0000f699;
+    s->analog[CCM_ANALOG_PLL_VIDEO_DENOM] = 0x000f4240;
+    s->analog[CCM_ANALOG_PLL_MISC0]       = 0x00000000;
+
+    /* all PLLs need to be locked */
+    s->analog[CCM_ANALOG_PLL_ARM]   |= CCM_ANALOG_PLL_LOCK;
+    s->analog[CCM_ANALOG_PLL_DDR]   |= CCM_ANALOG_PLL_LOCK;
+    s->analog[CCM_ANALOG_PLL_480]   |= CCM_ANALOG_PLL_LOCK;
+    s->analog[CCM_ANALOG_PLL_480A]  |= CCM_ANALOG_PLL_LOCK;
+    s->analog[CCM_ANALOG_PLL_480B]  |= CCM_ANALOG_PLL_LOCK;
+    s->analog[CCM_ANALOG_PLL_ENET]  |= CCM_ANALOG_PLL_LOCK;
+    s->analog[CCM_ANALOG_PLL_AUDIO] |= CCM_ANALOG_PLL_LOCK;
+    s->analog[CCM_ANALOG_PLL_VIDEO] |= CCM_ANALOG_PLL_LOCK;
+    s->analog[CCM_ANALOG_PLL_MISC0] |= CCM_ANALOG_PLL_LOCK;
+}
+
+#define CCM_INDEX(offset)	(((offset) & ~(hwaddr)0xF) / sizeof(uint32_t))
+#define CCM_BITOP(offset)	((offset) & (hwaddr)0xF)
+
+enum {
+    CCM_BITOP_NONE = 0x00,
+    CCM_BITOP_SET  = 0x04,
+    CCM_BITOP_CLR  = 0x08,
+    CCM_BITOP_TOG  = 0x0C,
+};
+
+static uint64_t imx7_set_clr_tog_read(void *opaque, hwaddr offset,
+                                      unsigned size)
+{
+    const uint32_t *mmio = opaque;
+
+    return (uint64_t)mmio[CCM_INDEX(offset)];
+}
+
+static void imx7_set_clr_tog_write(void *opaque, hwaddr offset,
+                                   uint64_t value, unsigned size)
+{
+    const uint8_t  bitop = CCM_BITOP(offset);
+    const uint32_t index = CCM_INDEX(offset);
+    uint32_t *mmio = opaque;
+
+    switch (bitop) {
+    case CCM_BITOP_NONE:
+        mmio[index]  = value;
+        break;
+    case CCM_BITOP_SET:
+        mmio[index] |= value;
+        break;
+    case CCM_BITOP_CLR:
+        mmio[index] &= ~value;
+        break;
+    case CCM_BITOP_TOG:
+        mmio[index] ^= value;
+        break;
+    };
+}
+
+static const struct MemoryRegionOps imx7_set_clr_tog_ops = {
+    .read = imx7_set_clr_tog_read,
+    .write = imx7_set_clr_tog_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        /*
+         * Our device would not work correctly if the guest was doing
+         * unaligned access. This might not be a limitation on the real
+         * device but in practice there is no reason for a guest to access
+         * this device unaligned.
+         */
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void imx7_ccm_init(Object *obj)
+{
+    SysBusDevice *sd = SYS_BUS_DEVICE(obj);
+    IMX7CCMState *s = IMX7_CCM(obj);
+
+    memory_region_init(&s->mmio.container, obj, TYPE_IMX7_CCM,
+                       0x30000);
+
+    memory_region_init_io(&s->mmio.analog,
+                          obj,
+                          &imx7_set_clr_tog_ops,
+                          s->analog,
+                          TYPE_IMX7_CCM ".analog",
+                          sizeof(s->analog));
+
+    memory_region_add_subregion(&s->mmio.container,
+                                0x60, &s->mmio.analog);
+
+    memory_region_init_io(&s->mmio.pmu,
+                          obj,
+                          &imx7_set_clr_tog_ops,
+                          s->pmu,
+                          TYPE_IMX7_CCM ".pmu",
+                          sizeof(s->pmu));
+
+    memory_region_add_subregion(&s->mmio.container,
+                                0x200, &s->mmio.pmu);
+    
+    memory_region_init_io(&s->mmio.ccm,
+                          obj,
+                          &imx7_set_clr_tog_ops,
+                          s->ccm,
+                          TYPE_IMX7_CCM ".ccm",
+                          sizeof(s->ccm));
+
+    memory_region_add_subregion(&s->mmio.container,
+                                0x20000, &s->mmio.ccm);
+
+    sysbus_init_mmio(sd, &s->mmio.container);
+}
+
+static const VMStateDescription vmstate_imx7_ccm = {
+    .name = TYPE_IMX7_CCM,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(ccm, IMX7CCMState, CCM_MAX),
+        VMSTATE_UINT32_ARRAY(analog, IMX7CCMState, CCM_ANALOG_MAX),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void imx7_ccm_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    IMXCCMClass *ccm = IMX_CCM_CLASS(klass);
+
+    dc->reset = imx7_ccm_reset;
+    dc->vmsd  = &vmstate_imx7_ccm;
+    dc->desc  = "i.MX7 Clock Control Module";
+
+    ccm->get_clock_frequency = imx7_ccm_get_clock_frequency;
+}
+
+static const TypeInfo imx7_ccm_info = {
+    .name          = TYPE_IMX7_CCM,
+    .parent        = TYPE_IMX_CCM,
+    .instance_size = sizeof(IMX7CCMState),
+    .instance_init = imx7_ccm_init,
+    .class_init    = imx7_ccm_class_init,
+};
+
+static void imx7_ccm_register_type(void)
+{
+    type_register_static(&imx7_ccm_info);
+}
+type_init(imx7_ccm_register_type)
diff --git a/include/hw/misc/imx7_ccm.h b/include/hw/misc/imx7_ccm.h
new file mode 100644
index 0000000000..72ca10a04a
--- /dev/null
+++ b/include/hw/misc/imx7_ccm.h
@@ -0,0 +1,76 @@
+/*
+ * Copyright (c) 2017, Impinj, Inc.
+ *
+ * i.MX7 CCM, PMU and ANALOG IP blocks emulation code
+ *
+ * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef IMX7_CCM_H
+#define IMX7_CCM_H
+
+#include "hw/misc/imx_ccm.h"
+#include "qemu/bitops.h"
+
+#define REG_SET_CLR_TOG(name)  name, name##_SET, name##_CLR, name##_TOG
+
+enum IMX7AnalogRegisters {
+    REG_SET_CLR_TOG(CCM_ANALOG_PLL_ARM),
+    REG_SET_CLR_TOG(CCM_ANALOG_PLL_DDR),
+    REG_SET_CLR_TOG(CCM_ANALOG_PLL_DDR_SS),
+    REG_SET_CLR_TOG(CCM_ANALOG_PLL_DDR_NUM),
+    REG_SET_CLR_TOG(CCM_ANALOG_PLL_DDR_DENOM),
+    REG_SET_CLR_TOG(CCM_ANALOG_PLL_480),
+    REG_SET_CLR_TOG(CCM_ANALOG_PLL_480A),
+    REG_SET_CLR_TOG(CCM_ANALOG_PLL_480B),
+    REG_SET_CLR_TOG(CCM_ANALOG_PLL_ENET),
+    REG_SET_CLR_TOG(CCM_ANALOG_PLL_AUDIO),
+    REG_SET_CLR_TOG(CCM_ANALOG_PLL_AUDIO_SS),
+    REG_SET_CLR_TOG(CCM_ANALOG_PLL_AUDIO_NUM),
+    REG_SET_CLR_TOG(CCM_ANALOG_PLL_AUDIO_DENOM),
+    REG_SET_CLR_TOG(CCM_ANALOG_PLL_VIDEO),
+    REG_SET_CLR_TOG(CCM_ANALOG_PLL_VIDEO_SS),
+    REG_SET_CLR_TOG(CCM_ANALOG_PLL_VIDEO_NUM),
+    REG_SET_CLR_TOG(CCM_ANALOG_PLL_VIDEO_DENOM),
+    REG_SET_CLR_TOG(CCM_ANALOG_PLL_MISC0),
+
+    CCM_ANALOG_MAX,
+
+    CCM_ANALOG_PLL_LOCK = BIT(31)
+};
+
+enum IMX7CCMRegisters {
+    CCM_MAX = 0xBC80 / sizeof(uint32_t),
+};
+
+enum IMX7PMURegisters {
+    PMU_MAX = 0x140 / sizeof(uint32_t),
+};
+
+#undef REG_SET_CLR_TOG
+
+#define TYPE_IMX7_CCM "imx7.ccm"
+#define IMX7_CCM(obj) OBJECT_CHECK(IMX7CCMState, (obj), TYPE_IMX7_CCM)
+
+typedef struct IMX6CCMState {
+    /* <private> */
+    IMXCCMState parent_obj;
+
+    /* <public> */
+    struct {
+        MemoryRegion container;
+        MemoryRegion ccm;
+        MemoryRegion pmu;
+        MemoryRegion analog;
+    } mmio;
+
+    uint32_t ccm[CCM_MAX];
+    uint32_t pmu[PMU_MAX];
+    uint32_t analog[CCM_ANALOG_MAX];
+
+} IMX7CCMState;
+
+#endif /* IMX7_CCM_H */
-- 
2.13.5
