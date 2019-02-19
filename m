Received: from eggs.gnu.org ([209.51.188.92]:53137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw4yW-0001fV-7y
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:58:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw4yU-0002n1-Mx
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:58:16 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gw4yU-0002mS-D3
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:58:14 -0500
Received: by mail-wr1-x444.google.com with SMTP id l5so20769199wrw.6
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 04:58:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Feb 2019 12:58:01 +0000
Message-Id: <20190219125808.25174-2-peter.maydell@linaro.org>
In-Reply-To: <20190219125808.25174-1-peter.maydell@linaro.org>
References: <20190219125808.25174-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/8] hw/misc/armsse-mhu.c: Model the SSE-200
 Message Handling Unit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

Implement a model of the Message Handling Unit (MHU) found in
the Arm SSE-200. This is a simple device which just contains
some registers which allow the two cores of the SSE-200
to raise interrupts on each other.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/Makefile.objs           |   1 +
 include/hw/misc/armsse-mhu.h    |  44 +++++++
 hw/misc/armsse-mhu.c            | 198 ++++++++++++++++++++++++++++++++
 MAINTAINERS                     |   2 +
 default-configs/arm-softmmu.mak |   1 +
 hw/misc/trace-events            |   4 +
 6 files changed, 250 insertions(+)
 create mode 100644 include/hw/misc/armsse-mhu.h
 create mode 100644 hw/misc/armsse-mhu.c

diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 74c91d250c8..c71e07ae35d 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -70,6 +70,7 @@ obj-$(CONFIG_IOTKIT_SECCTL) += iotkit-secctl.o
 obj-$(CONFIG_IOTKIT_SYSCTL) += iotkit-sysctl.o
 obj-$(CONFIG_IOTKIT_SYSINFO) += iotkit-sysinfo.o
 obj-$(CONFIG_ARMSSE_CPUID) += armsse-cpuid.o
+obj-$(CONFIG_ARMSSE_MHU) += armsse-mhu.o
 
 obj-$(CONFIG_PVPANIC) += pvpanic.o
 obj-$(CONFIG_AUX) += auxbus.o
diff --git a/include/hw/misc/armsse-mhu.h b/include/hw/misc/armsse-mhu.h
new file mode 100644
index 00000000000..e57eafc2521
--- /dev/null
+++ b/include/hw/misc/armsse-mhu.h
@@ -0,0 +1,44 @@
+/*
+ * ARM SSE-200 Message Handling Unit (MHU)
+ *
+ * Copyright (c) 2019 Linaro Limited
+ * Written by Peter Maydell
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 or
+ *  (at your option) any later version.
+ */
+
+/*
+ * This is a model of the Message Handling Unit (MHU) which is part of the
+ * Arm SSE-200 and documented in
+ * http://infocenter.arm.com/help/topic/com.arm.doc.101104_0100_00_en/corelink_sse200_subsystem_for_embedded_technical_reference_manual_101104_0100_00_en.pdf
+ *
+ * QEMU interface:
+ *  + sysbus MMIO region 0: the system information register bank
+ *  + sysbus IRQ 0: interrupt for CPU 0
+ *  + sysbus IRQ 1: interrupt for CPU 1
+ */
+
+#ifndef HW_MISC_SSE_MHU_H
+#define HW_MISC_SSE_MHU_H
+
+#include "hw/sysbus.h"
+
+#define TYPE_ARMSSE_MHU "armsse-mhu"
+#define ARMSSE_MHU(obj) OBJECT_CHECK(ARMSSEMHU, (obj), TYPE_ARMSSE_MHU)
+
+typedef struct ARMSSEMHU {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion iomem;
+    qemu_irq cpu0irq;
+    qemu_irq cpu1irq;
+
+    uint32_t cpu0intr;
+    uint32_t cpu1intr;
+} ARMSSEMHU;
+
+#endif
diff --git a/hw/misc/armsse-mhu.c b/hw/misc/armsse-mhu.c
new file mode 100644
index 00000000000..9ebca32e9aa
--- /dev/null
+++ b/hw/misc/armsse-mhu.c
@@ -0,0 +1,198 @@
+/*
+ * ARM SSE-200 Message Handling Unit (MHU)
+ *
+ * Copyright (c) 2019 Linaro Limited
+ * Written by Peter Maydell
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 or
+ *  (at your option) any later version.
+ */
+
+/*
+ * This is a model of the Message Handling Unit (MHU) which is part of the
+ * Arm SSE-200 and documented in
+ * http://infocenter.arm.com/help/topic/com.arm.doc.101104_0100_00_en/corelink_sse200_subsystem_for_embedded_technical_reference_manual_101104_0100_00_en.pdf
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "trace.h"
+#include "qapi/error.h"
+#include "sysemu/sysemu.h"
+#include "hw/sysbus.h"
+#include "hw/registerfields.h"
+#include "hw/misc/armsse-mhu.h"
+
+REG32(CPU0INTR_STAT, 0x0)
+REG32(CPU0INTR_SET, 0x4)
+REG32(CPU0INTR_CLR, 0x8)
+REG32(CPU1INTR_STAT, 0x10)
+REG32(CPU1INTR_SET, 0x14)
+REG32(CPU1INTR_CLR, 0x18)
+REG32(PID4, 0xfd0)
+REG32(PID5, 0xfd4)
+REG32(PID6, 0xfd8)
+REG32(PID7, 0xfdc)
+REG32(PID0, 0xfe0)
+REG32(PID1, 0xfe4)
+REG32(PID2, 0xfe8)
+REG32(PID3, 0xfec)
+REG32(CID0, 0xff0)
+REG32(CID1, 0xff4)
+REG32(CID2, 0xff8)
+REG32(CID3, 0xffc)
+
+/* Valid bits in the interrupt registers. If any are set the IRQ is raised */
+#define INTR_MASK 0xf
+
+/* PID/CID values */
+static const int armsse_mhu_id[] = {
+    0x04, 0x00, 0x00, 0x00, /* PID4..PID7 */
+    0x56, 0xb8, 0x0b, 0x00, /* PID0..PID3 */
+    0x0d, 0xf0, 0x05, 0xb1, /* CID0..CID3 */
+};
+
+static void armsse_mhu_update(ARMSSEMHU *s)
+{
+    qemu_set_irq(s->cpu0irq, s->cpu0intr != 0);
+    qemu_set_irq(s->cpu1irq, s->cpu1intr != 0);
+}
+
+static uint64_t armsse_mhu_read(void *opaque, hwaddr offset, unsigned size)
+{
+    ARMSSEMHU *s = ARMSSE_MHU(opaque);
+    uint64_t r;
+
+    switch (offset) {
+    case A_CPU0INTR_STAT:
+        r = s->cpu0intr;
+        break;
+
+    case A_CPU1INTR_STAT:
+        r = s->cpu1intr;
+        break;
+
+    case A_PID4 ... A_CID3:
+        r = armsse_mhu_id[(offset - A_PID4) / 4];
+        break;
+
+    case A_CPU0INTR_SET:
+    case A_CPU0INTR_CLR:
+    case A_CPU1INTR_SET:
+    case A_CPU1INTR_CLR:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "SSE MHU: read of write-only register at offset 0x%x\n",
+                      (int)offset);
+        r = 0;
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "SSE MHU read: bad offset 0x%x\n", (int)offset);
+        r = 0;
+        break;
+    }
+    trace_armsse_mhu_read(offset, r, size);
+    return r;
+}
+
+static void armsse_mhu_write(void *opaque, hwaddr offset,
+                             uint64_t value, unsigned size)
+{
+    ARMSSEMHU *s = ARMSSE_MHU(opaque);
+
+    trace_armsse_mhu_write(offset, value, size);
+
+    switch (offset) {
+    case A_CPU0INTR_SET:
+        s->cpu0intr |= (value & INTR_MASK);
+        break;
+    case A_CPU0INTR_CLR:
+        s->cpu0intr &= ~(value & INTR_MASK);
+        break;
+    case A_CPU1INTR_SET:
+        s->cpu1intr |= (value & INTR_MASK);
+        break;
+    case A_CPU1INTR_CLR:
+        s->cpu1intr &= ~(value & INTR_MASK);
+        break;
+
+    case A_CPU0INTR_STAT:
+    case A_CPU1INTR_STAT:
+    case A_PID4 ... A_CID3:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "SSE MHU: write to read-only register at offset 0x%x\n",
+                      (int)offset);
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "SSE MHU write: bad offset 0x%x\n", (int)offset);
+        break;
+    }
+
+    armsse_mhu_update(s);
+}
+
+static const MemoryRegionOps armsse_mhu_ops = {
+    .read = armsse_mhu_read,
+    .write = armsse_mhu_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+};
+
+static void armsse_mhu_reset(DeviceState *dev)
+{
+    ARMSSEMHU *s = ARMSSE_MHU(dev);
+
+    s->cpu0intr = 0;
+    s->cpu1intr = 0;
+}
+
+static const VMStateDescription armsse_mhu_vmstate = {
+    .name = "armsse-mhu",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(cpu0intr, ARMSSEMHU),
+        VMSTATE_UINT32(cpu1intr, ARMSSEMHU),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void armsse_mhu_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    ARMSSEMHU *s = ARMSSE_MHU(obj);
+
+    memory_region_init_io(&s->iomem, obj, &armsse_mhu_ops,
+                          s, "armsse-mhu", 0x1000);
+    sysbus_init_mmio(sbd, &s->iomem);
+    sysbus_init_irq(sbd, &s->cpu0irq);
+    sysbus_init_irq(sbd, &s->cpu1irq);
+}
+
+static void armsse_mhu_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = armsse_mhu_reset;
+    dc->vmsd = &armsse_mhu_vmstate;
+}
+
+static const TypeInfo armsse_mhu_info = {
+    .name = TYPE_ARMSSE_MHU,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(ARMSSEMHU),
+    .instance_init = armsse_mhu_init,
+    .class_init = armsse_mhu_class_init,
+};
+
+static void armsse_mhu_register_types(void)
+{
+    type_register_static(&armsse_mhu_info);
+}
+
+type_init(armsse_mhu_register_types);
diff --git a/MAINTAINERS b/MAINTAINERS
index 770b2eaaf91..f198d510e89 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -633,6 +633,8 @@ F: hw/misc/iotkit-sysinfo.c
 F: include/hw/misc/iotkit-sysinfo.h
 F: hw/misc/armsse-cpuid.c
 F: include/hw/misc/armsse-cpuid.h
+F: hw/misc/armsse-mhu.c
+F: include/hw/misc/armsse-mhu.h
 
 Musca
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 87ad2674946..bd6943b691a 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -119,6 +119,7 @@ CONFIG_IOTKIT_SECCTL=y
 CONFIG_IOTKIT_SYSCTL=y
 CONFIG_IOTKIT_SYSINFO=y
 CONFIG_ARMSSE_CPUID=y
+CONFIG_ARMSSE_MHU=y
 
 CONFIG_VERSATILE=y
 CONFIG_VERSATILE_PCI=y
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index b0701bddd3c..c1795bb54b8 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -136,3 +136,7 @@ iotkit_sysctl_reset(void) "IoTKit SysCtl: reset"
 # hw/misc/armsse-cpuid.c
 armsse_cpuid_read(uint64_t offset, uint64_t data, unsigned size) "SSE-200 CPU_IDENTITY read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 armsse_cpuid_write(uint64_t offset, uint64_t data, unsigned size) "SSE-200 CPU_IDENTITY write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
+
+# hw/misc/armsse-mhu.c
+armsse_mhu_read(uint64_t offset, uint64_t data, unsigned size) "SSE-200 MHU read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
+armsse_mhu_write(uint64_t offset, uint64_t data, unsigned size) "SSE-200 MHU write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
-- 
2.20.1
