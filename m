Received: from eggs.gnu.org ([209.51.188.92]:38929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glevP-00081G-LA
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:08:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gleff-0002ue-Q6
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:51:48 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38218)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gleff-0002sP-Gy
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:51:43 -0500
Received: by mail-wm1-x342.google.com with SMTP id m22so11907574wml.3
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:51:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jan 2019 18:51:14 +0000
Message-Id: <20190121185118.18550-20-peter.maydell@linaro.org>
In-Reply-To: <20190121185118.18550-1-peter.maydell@linaro.org>
References: <20190121185118.18550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 19/23] hw/misc/armsse-cpuid: Implement SSE-200
 CPU_IDENTITY register block
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

The SSE-200 has a CPU_IDENTITY register block, which is a set of
read-only registers. As well as the usual PID/CID registers, there
is a single CPUID register which indicates whether the CPU is CPU 0
or CPU 1. Implement a model of this register block.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/Makefile.objs           |   1 +
 include/hw/misc/armsse-cpuid.h  |  41 ++++++++++
 hw/misc/armsse-cpuid.c          | 134 ++++++++++++++++++++++++++++++++
 MAINTAINERS                     |   2 +
 default-configs/arm-softmmu.mak |   1 +
 hw/misc/trace-events            |   4 +
 6 files changed, 183 insertions(+)
 create mode 100644 include/hw/misc/armsse-cpuid.h
 create mode 100644 hw/misc/armsse-cpuid.c

diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 04f3bfa516e..74c91d250c8 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -69,6 +69,7 @@ obj-$(CONFIG_TZ_PPC) += tz-ppc.o
 obj-$(CONFIG_IOTKIT_SECCTL) += iotkit-secctl.o
 obj-$(CONFIG_IOTKIT_SYSCTL) += iotkit-sysctl.o
 obj-$(CONFIG_IOTKIT_SYSINFO) += iotkit-sysinfo.o
+obj-$(CONFIG_ARMSSE_CPUID) += armsse-cpuid.o
 
 obj-$(CONFIG_PVPANIC) += pvpanic.o
 obj-$(CONFIG_AUX) += auxbus.o
diff --git a/include/hw/misc/armsse-cpuid.h b/include/hw/misc/armsse-cpuid.h
new file mode 100644
index 00000000000..0ef33fcaba2
--- /dev/null
+++ b/include/hw/misc/armsse-cpuid.h
@@ -0,0 +1,41 @@
+/*
+ * ARM SSE-200 CPU_IDENTITY register block
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
+ * This is a model of the "CPU_IDENTITY" register block which is part of the
+ * Arm SSE-200 and documented in
+ * http://infocenter.arm.com/help/topic/com.arm.doc.101104_0100_00_en/corelink_sse200_subsystem_for_embedded_technical_reference_manual_101104_0100_00_en.pdf
+ *
+ * QEMU interface:
+ *  + QOM property "CPUID": the value to use for the CPUID register
+ *  + sysbus MMIO region 0: the system information register bank
+ */
+
+#ifndef HW_MISC_ARMSSE_CPUID_H
+#define HW_MISC_ARMSSE_CPUID_H
+
+#include "hw/sysbus.h"
+
+#define TYPE_ARMSSE_CPUID "armsse-cpuid"
+#define ARMSSE_CPUID(obj) OBJECT_CHECK(ARMSSECPUID, (obj), TYPE_ARMSSE_CPUID)
+
+typedef struct ARMSSECPUID {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion iomem;
+
+    /* Properties */
+    uint32_t cpuid;
+} ARMSSECPUID;
+
+#endif
diff --git a/hw/misc/armsse-cpuid.c b/hw/misc/armsse-cpuid.c
new file mode 100644
index 00000000000..7788f6ced6a
--- /dev/null
+++ b/hw/misc/armsse-cpuid.c
@@ -0,0 +1,134 @@
+/*
+ * ARM SSE-200 CPU_IDENTITY register block
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
+ * This is a model of the "CPU_IDENTITY" register block which is part of the
+ * Arm SSE-200 and documented in
+ * http://infocenter.arm.com/help/topic/com.arm.doc.101104_0100_00_en/corelink_sse200_subsystem_for_embedded_technical_reference_manual_101104_0100_00_en.pdf
+ *
+ * It consists of one read-only CPUID register (set by QOM property), plus the
+ * usual ID registers.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "trace.h"
+#include "qapi/error.h"
+#include "sysemu/sysemu.h"
+#include "hw/sysbus.h"
+#include "hw/registerfields.h"
+#include "hw/misc/armsse-cpuid.h"
+
+REG32(CPUID, 0x0)
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
+/* PID/CID values */
+static const int sysinfo_id[] = {
+    0x04, 0x00, 0x00, 0x00, /* PID4..PID7 */
+    0x58, 0xb8, 0x0b, 0x00, /* PID0..PID3 */
+    0x0d, 0xf0, 0x05, 0xb1, /* CID0..CID3 */
+};
+
+static uint64_t armsse_cpuid_read(void *opaque, hwaddr offset,
+                                    unsigned size)
+{
+    ARMSSECPUID *s = ARMSSE_CPUID(opaque);
+    uint64_t r;
+
+    switch (offset) {
+    case A_CPUID:
+        r = s->cpuid;
+        break;
+    case A_PID4 ... A_CID3:
+        r = sysinfo_id[(offset - A_PID4) / 4];
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "SSE CPU_IDENTITY read: bad offset 0x%x\n", (int)offset);
+        r = 0;
+        break;
+    }
+    trace_armsse_cpuid_read(offset, r, size);
+    return r;
+}
+
+static void armsse_cpuid_write(void *opaque, hwaddr offset,
+                                 uint64_t value, unsigned size)
+{
+    trace_armsse_cpuid_write(offset, value, size);
+
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "SSE CPU_IDENTITY: write to RO offset 0x%x\n", (int)offset);
+}
+
+static const MemoryRegionOps armsse_cpuid_ops = {
+    .read = armsse_cpuid_read,
+    .write = armsse_cpuid_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    /* byte/halfword accesses are just zero-padded on reads and writes */
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+};
+
+static Property armsse_cpuid_props[] = {
+    DEFINE_PROP_UINT32("CPUID", ARMSSECPUID, cpuid, 0),
+    DEFINE_PROP_END_OF_LIST()
+};
+
+static void armsse_cpuid_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    ARMSSECPUID *s = ARMSSE_CPUID(obj);
+
+    memory_region_init_io(&s->iomem, obj, &armsse_cpuid_ops,
+                          s, "armsse-cpuid", 0x1000);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static void armsse_cpuid_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    /*
+     * This device has no guest-modifiable state and so it
+     * does not need a reset function or VMState.
+     */
+
+    dc->props = armsse_cpuid_props;
+}
+
+static const TypeInfo armsse_cpuid_info = {
+    .name = TYPE_ARMSSE_CPUID,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(ARMSSECPUID),
+    .instance_init = armsse_cpuid_init,
+    .class_init = armsse_cpuid_class_init,
+};
+
+static void armsse_cpuid_register_types(void)
+{
+    type_register_static(&armsse_cpuid_info);
+}
+
+type_init(armsse_cpuid_register_types);
diff --git a/MAINTAINERS b/MAINTAINERS
index 52222117d77..42719880bad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -633,6 +633,8 @@ F: hw/misc/iotkit-sysctl.c
 F: include/hw/misc/iotkit-sysctl.h
 F: hw/misc/iotkit-sysinfo.c
 F: include/hw/misc/iotkit-sysinfo.h
+F: hw/misc/armsse-cpuid.c
+F: include/hw/misc/armsse-cpuid.h
 
 Musicpal
 M: Jan Kiszka <jan.kiszka@web.de>
diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 3f200157879..be88870799c 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -118,6 +118,7 @@ CONFIG_ARMSSE=y
 CONFIG_IOTKIT_SECCTL=y
 CONFIG_IOTKIT_SYSCTL=y
 CONFIG_IOTKIT_SYSINFO=y
+CONFIG_ARMSSE_CPUID=y
 
 CONFIG_VERSATILE=y
 CONFIG_VERSATILE_PCI=y
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 52466c77c4e..b0701bddd3c 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -132,3 +132,7 @@ iotkit_sysinfo_write(uint64_t offset, uint64_t data, unsigned size) "IoTKit SysI
 iotkit_sysctl_read(uint64_t offset, uint64_t data, unsigned size) "IoTKit SysCtl read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 iotkit_sysctl_write(uint64_t offset, uint64_t data, unsigned size) "IoTKit SysCtl write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 iotkit_sysctl_reset(void) "IoTKit SysCtl: reset"
+
+# hw/misc/armsse-cpuid.c
+armsse_cpuid_read(uint64_t offset, uint64_t data, unsigned size) "SSE-200 CPU_IDENTITY read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
+armsse_cpuid_write(uint64_t offset, uint64_t data, unsigned size) "SSE-200 CPU_IDENTITY write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
-- 
2.20.1
