Received: from eggs.gnu.org ([2001:4830:134:3::10]:56005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gabriel291075@gmail.com>) id 1e7jIw-0007H7-Mj
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:38:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gabriel291075@gmail.com>) id 1e7jIv-0007hO-5U
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:38:42 -0400
From: Gabriel Costa <gabriel291075@gmail.com>
Date: Thu, 26 Oct 2017 06:34:10 -0400
Message-Id: <1509014053-28134-4-git-send-email-costa@advantech.ca>
In-Reply-To: <1509014053-28134-1-git-send-email-costa@advantech.ca>
References: <1509014053-28134-1-git-send-email-costa@advantech.ca>
Subject: [Qemu-devel] [PATCH v5 3/5]arm: kinetis_k64_system
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, f4bug@amsat.org, Gabriel Augusto Costa <gabriel291075@gmail.com>

From: Gabriel Augusto Costa <gabriel291075@gmail.com>

This Patch include kinetis_k64_system.c and .h
sim means System Integration Module (SIM)
More information about this peripheral can be found at:
pag 291, K64P144M120SF5RM.pdf.

Signed-off-by: Gabriel Augusto Costa <gabriel291075@gmail.com>
---
 hw/misc/kinetis_k64_system.c         | 274 +++++++++++++++++++++++++++++++++++
 include/hw/misc/kinetis_k64_system.h |  52 +++++++
 2 files changed, 326 insertions(+)
 create mode 100644 hw/misc/kinetis_k64_system.c
 create mode 100644 include/hw/misc/kinetis_k64_system.h

diff --git a/hw/misc/kinetis_k64_system.c b/hw/misc/kinetis_k64_system.c
new file mode 100644
index 0000000..6421153
--- /dev/null
+++ b/hw/misc/kinetis_k64_system.c
@@ -0,0 +1,274 @@
+/*
+ * Kinetis K64 peripheral microcontroller emulation.
+ *
+ * Copyright (c) 2017 Advantech Wireless
+ * Written by Gabriel Costa <gabriel291075@gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 or
+ *  (at your option) any later version.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+#include "qemu/log.h"
+#include "hw/misc/kinetis_k64_system.h"
+
+static const VMStateDescription vmstate_kinetis_k64_sim = {
+    .name = TYPE_KINETIS_K64_SIM,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(SOPT1, kinetis_k64_sim_state),
+        VMSTATE_UINT32(SOPT1CFG, kinetis_k64_sim_state),
+        VMSTATE_UINT32(SOPT2, kinetis_k64_sim_state),
+        VMSTATE_UINT32(SOPT4, kinetis_k64_sim_state),
+        VMSTATE_UINT32(SOPT5, kinetis_k64_sim_state),
+        VMSTATE_UINT32(SOPT7, kinetis_k64_sim_state),
+        VMSTATE_UINT32(SDID, kinetis_k64_sim_state),
+        VMSTATE_UINT32(SCGC1, kinetis_k64_sim_state),
+        VMSTATE_UINT32(SCGC2, kinetis_k64_sim_state),
+        VMSTATE_UINT32(SCGC3, kinetis_k64_sim_state),
+        VMSTATE_UINT32(SCGC4, kinetis_k64_sim_state),
+        VMSTATE_UINT32(SCGC5, kinetis_k64_sim_state),
+        VMSTATE_UINT32(SCGC6, kinetis_k64_sim_state),
+        VMSTATE_UINT32(SCGC7, kinetis_k64_sim_state),
+        VMSTATE_UINT32(CLKDIV1, kinetis_k64_sim_state),
+        VMSTATE_UINT32(CLKDIV2, kinetis_k64_sim_state),
+        VMSTATE_UINT32(FCFG1, kinetis_k64_sim_state),
+        VMSTATE_UINT32(FCFG2, kinetis_k64_sim_state),
+        VMSTATE_UINT32(UIDH, kinetis_k64_sim_state),
+        VMSTATE_UINT32(UIDMH, kinetis_k64_sim_state),
+        VMSTATE_UINT32(UIDML, kinetis_k64_sim_state),
+        VMSTATE_UINT32(UIDL, kinetis_k64_sim_state),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void kinetis_k64_sim_reset(DeviceState *dev)
+{
+    kinetis_k64_sim_state *s = KINETIS_K64_SIM(dev);
+
+    s->SOPT1 = 0x00008000;
+    s->SOPT1CFG = 0x00000000;
+    s->SOPT2 = 0x00001000;
+    s->SOPT4 = 0x00000000;
+    s->SOPT5 = 0x00000000;
+    s->SOPT7 = 0x00000000;
+    s->SDID = 0x00000000;
+    s->SCGC1 = 0x00000000;
+    s->SCGC2 = 0x00000000;
+    s->SCGC3 = 0x00000000;
+    s->SCGC4 = 0xF0100030;
+    s->SCGC5 = 0x00040182;
+    s->SCGC6 = 0x40000001;
+    s->SCGC7 = 0x00000006;
+    s->CLKDIV1 = 0x00000000;
+    s->CLKDIV2 = 0x00000000;
+    s->FCFG1 = 0xFF000000;
+    s->FCFG2 = 0x00000000;
+    s->UIDH = 0x00000000;
+    s->UIDMH = 0x00000000;
+    s->UIDML = 0x00000000;
+    s->UIDL = 0x00000000;
+}
+
+static void kinetis_k64_sim_write(void *opaque, hwaddr offset, uint64_t value,
+        unsigned size)
+{
+    kinetis_k64_sim_state *s = (kinetis_k64_sim_state *)opaque;
+
+    value &= 0xFFFFFFFF;
+
+    switch (offset) {
+    case 0x0000:
+        s->SOPT1 = value;
+        break;
+    case 0x0004:
+        s->SOPT1CFG = value;
+        break;
+    case 0x1004:
+        s->SOPT2 = value;
+        break;
+    case 0x100C:
+        s->SOPT4 = value;
+        break;
+    case 0x1010:
+        s->SOPT5 = value;
+        break;
+    case 0x1018:
+        s->SOPT7 = value;
+        break;
+    case 0x1024:
+        s->SDID = value;
+        break;
+    case 0x1028:
+        s->SCGC1 = value;
+        break;
+    case 0x102C:
+        s->SCGC2 = value;
+        break;
+    case 0x1030:
+        s->SCGC3 = value;
+        break;
+    case 0x1034:
+        s->SCGC4 = value;
+        break;
+    case 0x1013:
+        s->SCGC5 = value;
+        break;
+    case 0x103C:
+        s->SCGC6 = value;
+        break;
+    case 0x1040:
+        s->SCGC7 = value;
+        break;
+    case 0x1044:
+        s->CLKDIV1 = value;
+        break;
+    case 0x1048:
+        s->CLKDIV2 = value;
+        break;
+    case 0x104C:
+        s->FCFG1 = value;
+        break;
+    case 0x1050:
+        s->FCFG2 = value;
+        break;
+    case 0x1054:
+        s->UIDH = value;
+        break;
+    case 0x1058:
+        s->UIDMH = value;
+        break;
+    case 0x105C:
+        s->UIDML = value;
+        break;
+    case 0x1060:
+        s->UIDL = value;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                "kinetis_k64_sim: write at bad offset 0x%x\n", (int)offset);
+    }
+}
+
+static uint64_t kinetis_k64_sim_read(void *opaque, hwaddr offset, unsigned size)
+{
+    kinetis_k64_sim_state *s = (kinetis_k64_sim_state *)opaque;
+    uint32_t value;
+
+    switch (offset) {
+    case 0x0000:
+        value = s->SOPT1;
+        break;
+    case 0x0004:
+        value = s->SOPT1CFG;
+        break;
+    case 0x1004:
+        value = s->SOPT2;
+        break;
+    case 0x100C:
+        value = s->SOPT4;
+        break;
+    case 0x1010:
+        value = s->SOPT5;
+        break;
+    case 0x1018:
+        value = s->SOPT7;
+        break;
+    case 0x1024:
+        value = s->SDID;
+        break;
+    case 0x1028:
+        value = s->SCGC1;
+        break;
+    case 0x102C:
+        value = s->SCGC2;
+        break;
+    case 0x1030:
+        value = s->SCGC3;
+        break;
+    case 0x1034:
+        value = s->SCGC4;
+        break;
+    case 0x1013:
+        value = s->SCGC5;
+        break;
+    case 0x103C:
+        value = s->SCGC6;
+        break;
+    case 0x1040:
+        value = s->SCGC7;
+        break;
+    case 0x1044:
+        value = s->CLKDIV1;
+        break;
+    case 0x1048:
+        value = s->CLKDIV2;
+        break;
+    case 0x104C:
+        value = s->FCFG1;
+        break;
+    case 0x1050:
+        value = s->FCFG2;
+        break;
+    case 0x1054:
+        value = s->UIDH;
+        break;
+    case 0x1058:
+        value = s->UIDMH;
+        break;
+    case 0x105C:
+        value = s->UIDML;
+        break;
+    case 0x1060:
+        value = s->UIDL;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                "kinetis_k64_sim: read at bad offset 0x%x\n", (int)offset);
+        return 0;
+    }
+    return value;
+}
+
+static const MemoryRegionOps kinetis_k64_sim_ops = {
+    .read = kinetis_k64_sim_read,
+    .write = kinetis_k64_sim_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void kinetis_k64_sim_init(Object *obj)
+{
+    kinetis_k64_sim_state *s = KINETIS_K64_SIM(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->iomem, obj, &kinetis_k64_sim_ops, s,
+            TYPE_KINETIS_K64_SIM, 0x2000);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static void kinetis_k64_sim_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_kinetis_k64_sim;
+    dc->reset = kinetis_k64_sim_reset;
+    dc->desc = "Kinetis K64 series SIM";
+}
+
+static const TypeInfo kinetis_k64_sim_info = {
+    .name          = TYPE_KINETIS_K64_SIM,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(kinetis_k64_sim_state),
+    .instance_init = kinetis_k64_sim_init,
+    .class_init    = kinetis_k64_sim_class_init,
+};
+
+static void kinetis_k64_sim_register_types(void)
+{
+    type_register_static(&kinetis_k64_sim_info);
+}
+
+type_init(kinetis_k64_sim_register_types)
diff --git a/include/hw/misc/kinetis_k64_system.h b/include/hw/misc/kinetis_k64_system.h
new file mode 100644
index 0000000..8774eaa
--- /dev/null
+++ b/include/hw/misc/kinetis_k64_system.h
@@ -0,0 +1,52 @@
+/*
+ * Kinetis K64 peripheral microcontroller emulation.
+ *
+ * Copyright (c) 2017 Advantech Wireless
+ * Written by Gabriel Costa <gabriel291075@gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 or
+ *  (at your option) any later version.
+ */
+
+#ifndef KINETIS_SYSTEM_H
+#define KINETIS_SYSTEM_H
+
+#include "hw/sysbus.h"
+#include "hw/hw.h"
+
+#define TYPE_KINETIS_K64_SIM "kinetis_k64_sim"
+#define KINETIS_K64_SIM(obj) \
+    OBJECT_CHECK(kinetis_k64_sim_state, (obj), TYPE_KINETIS_K64_SIM)
+
+typedef struct {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+
+    uint32_t SOPT1;
+    uint32_t SOPT1CFG;
+    uint32_t SOPT2;
+    uint32_t SOPT4;
+    uint32_t SOPT5;
+    uint32_t SOPT7;
+    uint32_t SDID;
+    uint32_t SCGC1;
+    uint32_t SCGC2;
+    uint32_t SCGC3;
+    uint32_t SCGC4;
+    uint32_t SCGC5;
+    uint32_t SCGC6;
+    uint32_t SCGC7;
+    uint32_t CLKDIV1;
+    uint32_t CLKDIV2;
+    uint32_t FCFG1;
+    uint32_t FCFG2;
+    uint32_t UIDH;
+    uint32_t UIDMH;
+    uint32_t UIDML;
+    uint32_t UIDL;
+
+} kinetis_k64_sim_state;
+
+#endif
-- 
2.1.4
