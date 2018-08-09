Received: from eggs.gnu.org ([2001:4830:134:3::10]:47357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fnkZX-000631-Co
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:01:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fnkZR-0003Pe-Lw
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:01:47 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  9 Aug 2018 14:01:04 +0100
Message-Id: <20180809130115.28951-6-peter.maydell@linaro.org>
In-Reply-To: <20180809130115.28951-1-peter.maydell@linaro.org>
References: <20180809130115.28951-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 05/16] hw/misc/iotkit-sysctl: Implement IoTKit
 system control element
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

The Arm IoTKit includes a system control element which
provides a block of read-only ID registers and a block
of read-write control registers. Implement a minimal
version of this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/Makefile.objs           |   1 +
 include/hw/misc/iotkit-sysctl.h |  50 +++++
 hw/misc/iotkit-sysctl.c         | 324 ++++++++++++++++++++++++++++++++
 MAINTAINERS                     |   2 +
 default-configs/arm-softmmu.mak |   1 +
 hw/misc/trace-events            |   7 +
 6 files changed, 385 insertions(+)
 create mode 100644 include/hw/misc/iotkit-sysctl.h
 create mode 100644 hw/misc/iotkit-sysctl.c

diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 93509008451..dbadb41d57a 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -65,6 +65,7 @@ obj-$(CONFIG_MPS2_SCC) += mps2-scc.o
 obj-$(CONFIG_TZ_MPC) += tz-mpc.o
 obj-$(CONFIG_TZ_PPC) += tz-ppc.o
 obj-$(CONFIG_IOTKIT_SECCTL) += iotkit-secctl.o
+obj-$(CONFIG_IOTKIT_SYSCTL) += iotkit-sysctl.o
 
 obj-$(CONFIG_PVPANIC) += pvpanic.o
 obj-$(CONFIG_HYPERV_TESTDEV) += hyperv_testdev.o
diff --git a/include/hw/misc/iotkit-sysctl.h b/include/hw/misc/iotkit-sysctl.h
new file mode 100644
index 00000000000..c3b14ccee4c
--- /dev/null
+++ b/include/hw/misc/iotkit-sysctl.h
@@ -0,0 +1,50 @@
+/*
+ * ARM IoTKit system control element
+ *
+ * Copyright (c) 2018 Linaro Limited
+ * Written by Peter Maydell
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 or
+ *  (at your option) any later version.
+ */
+
+/*
+ * This is a model of the "system control element" which is part of the
+ * Arm IoTKit and documented in
+ * http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ecm0601256/index.html
+ * Specifically, it implements the "system information block" and
+ * "system control register" blocks.
+ *
+ * QEMU interface:
+ *  + sysbus MMIO region 0: the system information register bank
+ *  + sysbus MMIO region 1: the system control register bank
+ */
+
+#ifndef HW_MISC_IOTKIT_SYSCTL_H
+#define HW_MISC_IOTKIT_SYSCTL_H
+
+#include "hw/sysbus.h"
+
+#define TYPE_IOTKIT_SYSCTL "iotkit-sysctl"
+#define IOTKIT_SYSCTL(obj) OBJECT_CHECK(IoTKitSysCtl, (obj), \
+                                        TYPE_IOTKIT_SYSCTL)
+
+typedef struct IoTKitSysCtl {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion sysinfo_iomem;
+    MemoryRegion sysctl_iomem;
+
+    uint32_t secure_debug;
+    uint32_t reset_syndrome;
+    uint32_t reset_mask;
+    uint32_t gretreg;
+    uint32_t initsvrtor0;
+    uint32_t cpuwait;
+    uint32_t wicctrl;
+} IoTKitSysCtl;
+
+#endif
diff --git a/hw/misc/iotkit-sysctl.c b/hw/misc/iotkit-sysctl.c
new file mode 100644
index 00000000000..9445500be76
--- /dev/null
+++ b/hw/misc/iotkit-sysctl.c
@@ -0,0 +1,324 @@
+/*
+ * ARM IoTKit system control element
+ *
+ * Copyright (c) 2018 Linaro Limited
+ * Written by Peter Maydell
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 or
+ *  (at your option) any later version.
+ */
+
+/*
+ * This is a model of the "system control element" which is part of the
+ * Arm IoTKit and documented in
+ * http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ecm0601256/index.html
+ * Specifically, it implements the "system information block" and
+ * "system control register" blocks.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "trace.h"
+#include "qapi/error.h"
+#include "sysemu/sysemu.h"
+#include "hw/sysbus.h"
+#include "hw/registerfields.h"
+#include "hw/misc/iotkit-sysctl.h"
+
+/* sysinfo block registers */
+REG32(SYS_VERSION, 0x0)
+REG32(SYS_CONFIG, 0x4)
+
+/* sysctl block registers */
+REG32(SECDBGSTAT, 0x0)
+REG32(SECDBGSET, 0x4)
+REG32(SECDBGCLR, 0x8)
+REG32(RESET_SYNDROME, 0x100)
+REG32(RESET_MASK, 0x104)
+REG32(SWRESET, 0x108)
+    FIELD(SWRESET, SWRESETREQ, 9, 1)
+REG32(GRETREG, 0x10c)
+REG32(INITSVRTOR0, 0x110)
+REG32(CPUWAIT, 0x118)
+REG32(BUSWAIT, 0x11c)
+REG32(WICCTRL, 0x120)
+
+/* PID registers, same offset in both blocks */
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
+static const int sysctl_id[] = {
+    0x04, 0x00, 0x00, 0x00, /* PID4..PID7 */
+    0x54, 0xb8, 0x0b, 0x00, /* PID0..PID3 */
+    0x0d, 0xf0, 0x05, 0xb1, /* CID0..CID3 */
+};
+
+static uint64_t iotkit_sysinfo_read(void *opaque, hwaddr offset,
+                                    unsigned size)
+{
+    uint64_t r;
+
+    switch (offset) {
+    case A_SYS_VERSION:
+        r = 0x41743;
+        break;
+
+    case A_SYS_CONFIG:
+        r = 0x31;
+        break;
+    case A_PID4 ... A_CID3:
+        r = sysinfo_id[(offset - A_PID4) / 4];
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "IoTKit SysInfo read: bad offset %x\n", (int)offset);
+        r = 0;
+        break;
+    }
+    trace_iotkit_sysinfo_read(offset, r, size);
+    return r;
+}
+
+static void iotkit_sysinfo_write(void *opaque, hwaddr offset,
+                                 uint64_t value, unsigned size)
+{
+    trace_iotkit_sysinfo_write(offset, value, size);
+
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "IoTKit SysInfo: write to RO offset 0x%x\n", (int)offset);
+}
+
+static const MemoryRegionOps iotkit_sysinfo_ops = {
+    .read = iotkit_sysinfo_read,
+    .write = iotkit_sysinfo_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    /* byte/halfword accesses are just zero-padded on reads and writes */
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+};
+
+static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
+                                    unsigned size)
+{
+    IoTKitSysCtl *s = IOTKIT_SYSCTL(opaque);
+    uint64_t r;
+
+    switch (offset) {
+    case A_SECDBGSTAT:
+        r = s->secure_debug;
+        break;
+    case A_RESET_SYNDROME:
+        r = s->reset_syndrome;
+        break;
+    case A_RESET_MASK:
+        r = s->reset_mask;
+        break;
+    case A_GRETREG:
+        r = s->gretreg;
+        break;
+    case A_INITSVRTOR0:
+        r = s->initsvrtor0;
+        break;
+    case A_CPUWAIT:
+        r = s->cpuwait;
+        break;
+    case A_BUSWAIT:
+        /* In IoTKit BUSWAIT is reserved, R/O, zero */
+        r = 0;
+        break;
+    case A_WICCTRL:
+        r = s->wicctrl;
+        break;
+    case A_PID4 ... A_CID3:
+        r = sysctl_id[(offset - A_PID4) / 4];
+        break;
+    case A_SECDBGSET:
+    case A_SECDBGCLR:
+    case A_SWRESET:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "IoTKit SysCtl read: read of WO offset %x\n",
+                      (int)offset);
+        r = 0;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "IoTKit SysCtl read: bad offset %x\n", (int)offset);
+        r = 0;
+        break;
+    }
+    trace_iotkit_sysctl_read(offset, r, size);
+    return r;
+}
+
+static void iotkit_sysctl_write(void *opaque, hwaddr offset,
+                                 uint64_t value, unsigned size)
+{
+    IoTKitSysCtl *s = IOTKIT_SYSCTL(opaque);
+
+    trace_iotkit_sysctl_write(offset, value, size);
+
+    /*
+     * Most of the state here has to do with control of reset and
+     * similar kinds of power up -- for instance the guest can ask
+     * what the reason for the last reset was, or forbid reset for
+     * some causes (like the non-secure watchdog). Most of this is
+     * not relevant to QEMU, which doesn't really model anything other
+     * than a full power-on reset.
+     * We just model the registers as reads-as-written.
+     */
+
+    switch (offset) {
+    case A_RESET_SYNDROME:
+        qemu_log_mask(LOG_UNIMP,
+                      "IoTKit SysCtl RESET_SYNDROME unimplemented\n");
+        s->reset_syndrome = value;
+        break;
+    case A_RESET_MASK:
+        qemu_log_mask(LOG_UNIMP, "IoTKit SysCtl RESET_MASK unimplemented\n");
+        s->reset_mask = value;
+        break;
+    case A_GRETREG:
+        /*
+         * General retention register, which is only reset by a power-on
+         * reset. Technically this implementation is complete, since
+         * QEMU only supports power-on resets...
+         */
+        s->gretreg = value;
+        break;
+    case A_INITSVRTOR0:
+        qemu_log_mask(LOG_UNIMP, "IoTKit SysCtl INITSVRTOR0 unimplemented\n");
+        s->initsvrtor0 = value;
+        break;
+    case A_CPUWAIT:
+        qemu_log_mask(LOG_UNIMP, "IoTKit SysCtl CPUWAIT unimplemented\n");
+        s->cpuwait = value;
+        break;
+    case A_WICCTRL:
+        qemu_log_mask(LOG_UNIMP, "IoTKit SysCtl WICCTRL unimplemented\n");
+        s->wicctrl = value;
+        break;
+    case A_SECDBGSET:
+        /* write-1-to-set */
+        qemu_log_mask(LOG_UNIMP, "IoTKit SysCtl SECDBGSET unimplemented\n");
+        s->secure_debug |= value;
+        break;
+    case A_SECDBGCLR:
+        /* write-1-to-clear */
+        s->secure_debug &= ~value;
+        break;
+    case A_SWRESET:
+        /* One w/o bit to request a reset; all other bits reserved */
+        if (value & R_SWRESET_SWRESETREQ_MASK) {
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+        }
+        break;
+    case A_BUSWAIT:        /* In IoTKit BUSWAIT is reserved, R/O, zero */
+    case A_SECDBGSTAT:
+    case A_PID4 ... A_CID3:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "IoTKit SysCtl write: write of RO offset %x\n",
+                      (int)offset);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "IoTKit SysCtl write: bad offset %x\n", (int)offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps iotkit_sysctl_ops = {
+    .read = iotkit_sysctl_read,
+    .write = iotkit_sysctl_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    /* byte/halfword accesses are just zero-padded on reads and writes */
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+};
+
+static void iotkit_sysctl_reset(DeviceState *dev)
+{
+    IoTKitSysCtl *s = IOTKIT_SYSCTL(dev);
+
+    trace_iotkit_sysctl_reset();
+    s->secure_debug = 0;
+    s->reset_syndrome = 1;
+    s->reset_mask = 0;
+    s->gretreg = 0;
+    s->initsvrtor0 = 0x10000000;
+    s->cpuwait = 0;
+    s->wicctrl = 0;
+}
+
+static void iotkit_sysctl_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    IoTKitSysCtl *s = IOTKIT_SYSCTL(obj);
+
+    memory_region_init_io(&s->sysinfo_iomem, obj, &iotkit_sysinfo_ops,
+                          s, "iotkit-sysinfo", 0x1000);
+    memory_region_init_io(&s->sysctl_iomem, obj, &iotkit_sysctl_ops,
+                          s, "iotkit-sysctl", 0x1000);
+    sysbus_init_mmio(sbd, &s->sysinfo_iomem);
+    sysbus_init_mmio(sbd, &s->sysctl_iomem);
+}
+
+static const VMStateDescription iotkit_sysctl_vmstate = {
+    .name = "iotkit-sysctl",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(secure_debug, IoTKitSysCtl),
+        VMSTATE_UINT32(reset_syndrome, IoTKitSysCtl),
+        VMSTATE_UINT32(reset_mask, IoTKitSysCtl),
+        VMSTATE_UINT32(gretreg, IoTKitSysCtl),
+        VMSTATE_UINT32(initsvrtor0, IoTKitSysCtl),
+        VMSTATE_UINT32(cpuwait, IoTKitSysCtl),
+        VMSTATE_UINT32(wicctrl, IoTKitSysCtl),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void iotkit_sysctl_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &iotkit_sysctl_vmstate;
+    dc->reset = iotkit_sysctl_reset;
+}
+
+static const TypeInfo iotkit_sysctl_info = {
+    .name = TYPE_IOTKIT_SYSCTL,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(IoTKitSysCtl),
+    .instance_init = iotkit_sysctl_init,
+    .class_init = iotkit_sysctl_class_init,
+};
+
+static void iotkit_sysctl_register_types(void)
+{
+    type_register_static(&iotkit_sysctl_info);
+}
+
+type_init(iotkit_sysctl_register_types);
diff --git a/MAINTAINERS b/MAINTAINERS
index 7ea39c0176b..96fe011e952 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -537,6 +537,8 @@ F: hw/misc/mps2-*.c
 F: include/hw/misc/mps2-*.h
 F: hw/arm/iotkit.c
 F: include/hw/arm/iotkit.h
+F: hw/misc/iotkit-sysctl.c
+F: include/hw/misc/iotkit-sysctl.h
 
 Musicpal
 M: Jan Kiszka <jan.kiszka@web.de>
diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 521c3d459fa..da59b820a4f 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -114,6 +114,7 @@ CONFIG_TZ_MPC=y
 CONFIG_TZ_PPC=y
 CONFIG_IOTKIT=y
 CONFIG_IOTKIT_SECCTL=y
+CONFIG_IOTKIT_SYSCTL=y
 
 CONFIG_VERSATILE=y
 CONFIG_VERSATILE_PCI=y
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index c956e1419b7..83ab58c30f5 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -109,3 +109,10 @@ iotkit_secctl_s_write(uint32_t offset, uint64_t data, unsigned size) "IoTKit Sec
 iotkit_secctl_ns_read(uint32_t offset, uint64_t data, unsigned size) "IoTKit SecCtl NS regs read: offset 0x%x data 0x%" PRIx64 " size %u"
 iotkit_secctl_ns_write(uint32_t offset, uint64_t data, unsigned size) "IoTKit SecCtl NS regs write: offset 0x%x data 0x%" PRIx64 " size %u"
 iotkit_secctl_reset(void) "IoTKit SecCtl: reset"
+
+# hw/misc/iotkit-sysctl.c
+iotkit_sysinfo_read(uint64_t offset, uint64_t data, unsigned size) "IoTKit SysInfo read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
+iotkit_sysinfo_write(uint64_t offset, uint64_t data, unsigned size) "IoTKit SysInfo write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
+iotkit_sysctl_read(uint64_t offset, uint64_t data, unsigned size) "IoTKit SysCtl read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
+iotkit_sysctl_write(uint64_t offset, uint64_t data, unsigned size) "IoTKit SysCtl write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
+iotkit_sysctl_reset(void) "IoTKit SysCtl: reset"
-- 
2.17.1
