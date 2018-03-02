Received: from eggs.gnu.org ([2001:4830:134:3::10]:43429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWe-0002wz-2y
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWc-0004uf-EY
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:56 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eriWc-0004uL-3I
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:06:54 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWb-0001MX-52
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:06:53 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  2 Mar 2018 11:06:18 +0000
Message-Id: <20180302110640.28004-18-peter.maydell@linaro.org>
In-Reply-To: <20180302110640.28004-1-peter.maydell@linaro.org>
References: <20180302110640.28004-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 17/39] hw/misc/mps2-fpgaio: FPGA control block
 for MPS2 AN505
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The MPS2 AN505 FPGA image includes a "FPGA control block"
which is a small set of registers handling LEDs, buttons
and some counters.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180220180325.29818-14-peter.maydell@linaro.org
---
 hw/misc/Makefile.objs           |   1 +
 include/hw/misc/mps2-fpgaio.h   |  43 ++++++++++
 hw/misc/mps2-fpgaio.c           | 176 ++++++++++++++++++++++++++++++++++++++++
 default-configs/arm-softmmu.mak |   1 +
 hw/misc/trace-events            |   6 ++
 5 files changed, 227 insertions(+)
 create mode 100644 include/hw/misc/mps2-fpgaio.h
 create mode 100644 hw/misc/mps2-fpgaio.c

diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index f33b37a8e5..31f83dcfe7 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -58,6 +58,7 @@ obj-$(CONFIG_STM32F2XX_SYSCFG) += stm32f2xx_syscfg.o
 obj-$(CONFIG_MIPS_CPS) += mips_cmgcr.o
 obj-$(CONFIG_MIPS_CPS) += mips_cpc.o
 obj-$(CONFIG_MIPS_ITU) += mips_itu.o
+obj-$(CONFIG_MPS2_FPGAIO) += mps2-fpgaio.o
 obj-$(CONFIG_MPS2_SCC) += mps2-scc.o
 
 obj-$(CONFIG_PVPANIC) += pvpanic.o
diff --git a/include/hw/misc/mps2-fpgaio.h b/include/hw/misc/mps2-fpgaio.h
new file mode 100644
index 0000000000..eedf17ebc6
--- /dev/null
+++ b/include/hw/misc/mps2-fpgaio.h
@@ -0,0 +1,43 @@
+/*
+ * ARM MPS2 FPGAIO emulation
+ *
+ * Copyright (c) 2018 Linaro Limited
+ * Written by Peter Maydell
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 or
+ *  (at your option) any later version.
+ */
+
+/* This is a model of the FPGAIO register block in the AN505
+ * FPGA image for the MPS2 dev board; it is documented in the
+ * application note:
+ * http://infocenter.arm.com/help/topic/com.arm.doc.dai0505b/index.html
+ *
+ * QEMU interface:
+ *  + sysbus MMIO region 0: the register bank
+ */
+
+#ifndef MPS2_FPGAIO_H
+#define MPS2_FPGAIO_H
+
+#include "hw/sysbus.h"
+
+#define TYPE_MPS2_FPGAIO "mps2-fpgaio"
+#define MPS2_FPGAIO(obj) OBJECT_CHECK(MPS2FPGAIO, (obj), TYPE_MPS2_FPGAIO)
+
+typedef struct {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion iomem;
+
+    uint32_t led0;
+    uint32_t prescale;
+    uint32_t misc;
+
+    uint32_t prescale_clk;
+} MPS2FPGAIO;
+
+#endif
diff --git a/hw/misc/mps2-fpgaio.c b/hw/misc/mps2-fpgaio.c
new file mode 100644
index 0000000000..7394a057d8
--- /dev/null
+++ b/hw/misc/mps2-fpgaio.c
@@ -0,0 +1,176 @@
+/*
+ * ARM MPS2 AN505 FPGAIO emulation
+ *
+ * Copyright (c) 2018 Linaro Limited
+ * Written by Peter Maydell
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 or
+ *  (at your option) any later version.
+ */
+
+/* This is a model of the "FPGA system control and I/O" block found
+ * in the AN505 FPGA image for the MPS2 devboard.
+ * It is documented in AN505:
+ * http://infocenter.arm.com/help/topic/com.arm.doc.dai0505b/index.html
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "trace.h"
+#include "hw/sysbus.h"
+#include "hw/registerfields.h"
+#include "hw/misc/mps2-fpgaio.h"
+
+REG32(LED0, 0)
+REG32(BUTTON, 8)
+REG32(CLK1HZ, 0x10)
+REG32(CLK100HZ, 0x14)
+REG32(COUNTER, 0x18)
+REG32(PRESCALE, 0x1c)
+REG32(PSCNTR, 0x20)
+REG32(MISC, 0x4c)
+
+static uint64_t mps2_fpgaio_read(void *opaque, hwaddr offset, unsigned size)
+{
+    MPS2FPGAIO *s = MPS2_FPGAIO(opaque);
+    uint64_t r;
+
+    switch (offset) {
+    case A_LED0:
+        r = s->led0;
+        break;
+    case A_BUTTON:
+        /* User-pressable board buttons. We don't model that, so just return
+         * zeroes.
+         */
+        r = 0;
+        break;
+    case A_PRESCALE:
+        r = s->prescale;
+        break;
+    case A_MISC:
+        r = s->misc;
+        break;
+    case A_CLK1HZ:
+    case A_CLK100HZ:
+    case A_COUNTER:
+    case A_PSCNTR:
+        /* These are all upcounters of various frequencies. */
+        qemu_log_mask(LOG_UNIMP, "MPS2 FPGAIO: counters unimplemented\n");
+        r = 0;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "MPS2 FPGAIO read: bad offset %x\n", (int) offset);
+        r = 0;
+        break;
+    }
+
+    trace_mps2_fpgaio_read(offset, r, size);
+    return r;
+}
+
+static void mps2_fpgaio_write(void *opaque, hwaddr offset, uint64_t value,
+                              unsigned size)
+{
+    MPS2FPGAIO *s = MPS2_FPGAIO(opaque);
+
+    trace_mps2_fpgaio_write(offset, value, size);
+
+    switch (offset) {
+    case A_LED0:
+        /* LED bits [1:0] control board LEDs. We don't currently have
+         * a mechanism for displaying this graphically, so use a trace event.
+         */
+        trace_mps2_fpgaio_leds(value & 0x02 ? '*' : '.',
+                               value & 0x01 ? '*' : '.');
+        s->led0 = value & 0x3;
+        break;
+    case A_PRESCALE:
+        s->prescale = value;
+        break;
+    case A_MISC:
+        /* These are control bits for some of the other devices on the
+         * board (SPI, CLCD, etc). We don't implement that yet, so just
+         * make the bits read as written.
+         */
+        qemu_log_mask(LOG_UNIMP,
+                      "MPS2 FPGAIO: MISC control bits unimplemented\n");
+        s->misc = value;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "MPS2 FPGAIO write: bad offset 0x%x\n", (int) offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps mps2_fpgaio_ops = {
+    .read = mps2_fpgaio_read,
+    .write = mps2_fpgaio_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void mps2_fpgaio_reset(DeviceState *dev)
+{
+    MPS2FPGAIO *s = MPS2_FPGAIO(dev);
+
+    trace_mps2_fpgaio_reset();
+    s->led0 = 0;
+    s->prescale = 0;
+    s->misc = 0;
+}
+
+static void mps2_fpgaio_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    MPS2FPGAIO *s = MPS2_FPGAIO(obj);
+
+    memory_region_init_io(&s->iomem, obj, &mps2_fpgaio_ops, s,
+                          "mps2-fpgaio", 0x1000);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static const VMStateDescription mps2_fpgaio_vmstate = {
+    .name = "mps2-fpgaio",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(led0, MPS2FPGAIO),
+        VMSTATE_UINT32(prescale, MPS2FPGAIO),
+        VMSTATE_UINT32(misc, MPS2FPGAIO),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property mps2_fpgaio_properties[] = {
+    /* Frequency of the prescale counter */
+    DEFINE_PROP_UINT32("prescale-clk", MPS2FPGAIO, prescale_clk, 20000000),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void mps2_fpgaio_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &mps2_fpgaio_vmstate;
+    dc->reset = mps2_fpgaio_reset;
+    dc->props = mps2_fpgaio_properties;
+}
+
+static const TypeInfo mps2_fpgaio_info = {
+    .name = TYPE_MPS2_FPGAIO,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(MPS2FPGAIO),
+    .instance_init = mps2_fpgaio_init,
+    .class_init = mps2_fpgaio_class_init,
+};
+
+static void mps2_fpgaio_register_types(void)
+{
+    type_register_static(&mps2_fpgaio_info);
+}
+
+type_init(mps2_fpgaio_register_types);
diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 54f855d072..5eaafee394 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -102,6 +102,7 @@ CONFIG_STM32F205_SOC=y
 CONFIG_CMSDK_APB_TIMER=y
 CONFIG_CMSDK_APB_UART=y
 
+CONFIG_MPS2_FPGAIO=y
 CONFIG_MPS2_SCC=y
 
 CONFIG_VERSATILE_PCI=y
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index b340d4e81c..ef852ffae7 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -62,6 +62,12 @@ mps2_scc_leds(char led7, char led6, char led5, char led4, char led3, char led2,
 mps2_scc_cfg_write(unsigned function, unsigned device, uint32_t value) "MPS2 SCC config write: function %d device %d data 0x%" PRIx32
 mps2_scc_cfg_read(unsigned function, unsigned device, uint32_t value) "MPS2 SCC config read: function %d device %d data 0x%" PRIx32
 
+# hw/misc/mps2_fpgaio.c
+mps2_fpgaio_read(uint64_t offset, uint64_t data, unsigned size) "MPS2 FPGAIO read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
+mps2_fpgaio_write(uint64_t offset, uint64_t data, unsigned size) "MPS2 FPGAIO write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
+mps2_fpgaio_reset(void) "MPS2 FPGAIO: reset"
+mps2_fpgaio_leds(char led1, char led0) "MPS2 FPGAIO LEDs: %c%c"
+
 # hw/misc/msf2-sysreg.c
 msf2_sysreg_write(uint64_t offset, uint32_t val, uint32_t prev) "msf2-sysreg write: addr 0x%08" HWADDR_PRIx " data 0x%" PRIx32 " prev 0x%" PRIx32
 msf2_sysreg_read(uint64_t offset, uint32_t val) "msf2-sysreg read: addr 0x%08" HWADDR_PRIx " data 0x%08" PRIx32
-- 
2.16.2
