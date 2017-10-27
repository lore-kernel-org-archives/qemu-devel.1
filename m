Received: from eggs.gnu.org ([2001:4830:134:3::10]:48904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gabriel291075@gmail.com>) id 1e87Uz-0006pe-VZ
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:28:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gabriel291075@gmail.com>) id 1e87Uy-00035A-7n
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:28:45 -0400
From: Gabriel Costa <gabriel291075@gmail.com>
Date: Fri, 27 Oct 2017 08:24:12 -0400
Message-Id: <1509107055-21978-3-git-send-email-costa@advantech.ca>
In-Reply-To: <1509107055-21978-1-git-send-email-costa@advantech.ca>
References: <1509107055-21978-1-git-send-email-costa@advantech.ca>
Subject: [Qemu-devel]  [PATCH v7 2/5] arm: kinetis_k64_mcg
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

This Patch include kinetis_k64_mcg.c/.h
mcg means Multipurpose Clock Generator (MCG)
More information about this peripheral can be found at:
pag 579, K64P144M120SF5RM.pdf.

Signed-off-by: Gabriel Augusto Costa <gabriel291075@gmail.com>
---
 hw/misc/kinetis_k64_mcg.c         | 208 ++++++++++++++++++++++++++++++++++++++
 include/hw/misc/kinetis_k64_mcg.h |  43 ++++++++
 2 files changed, 251 insertions(+)
 create mode 100644 hw/misc/kinetis_k64_mcg.c
 create mode 100644 include/hw/misc/kinetis_k64_mcg.h

diff --git a/hw/misc/kinetis_k64_mcg.c b/hw/misc/kinetis_k64_mcg.c
new file mode 100644
index 0000000..37f4201
--- /dev/null
+++ b/hw/misc/kinetis_k64_mcg.c
@@ -0,0 +1,208 @@
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
+#include "hw/misc/kinetis_k64_mcg.h"
+
+static const VMStateDescription vmstate_kinetis_k64_mcg = {
+    .name = TYPE_KINETIS_K64_MCG,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8(C1, kinetis_k64_mcg_state),
+        VMSTATE_UINT8(C2, kinetis_k64_mcg_state),
+        VMSTATE_UINT8(C3, kinetis_k64_mcg_state),
+        VMSTATE_UINT8(C4, kinetis_k64_mcg_state),
+        VMSTATE_UINT8(C5, kinetis_k64_mcg_state),
+        VMSTATE_UINT8(C6, kinetis_k64_mcg_state),
+        VMSTATE_UINT8(S, kinetis_k64_mcg_state),
+        VMSTATE_UINT8(SC, kinetis_k64_mcg_state),
+        VMSTATE_UINT8(ATCVH, kinetis_k64_mcg_state),
+        VMSTATE_UINT8(ATCVL, kinetis_k64_mcg_state),
+        VMSTATE_UINT8(C7, kinetis_k64_mcg_state),
+        VMSTATE_UINT8(C8, kinetis_k64_mcg_state),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void kinetis_k64_mcg_reset(DeviceState *dev)
+{
+    kinetis_k64_mcg_state *s = KINETIS_K64_MCG(dev);
+
+    s->C1 = 0x04;
+    s->C2 = 0x80;
+    s->C3 = 0x00;
+    s->C4 = 0x00;
+    s->C5 = 0x00;
+    s->C6 = 0x00;
+    s->S = 0x10;
+    s->SC = 0x02;
+    s->ATCVH = 0x00;
+    s->ATCVL = 0x00;
+    s->C7 = 0x00;
+    s->C8 = 0x80;
+}
+
+static void kinetis_k64_mcg_write(void *opaque, hwaddr offset, uint64_t value,
+        unsigned size)
+{
+    kinetis_k64_mcg_state *s = (kinetis_k64_mcg_state *)opaque;
+
+    value &= 0xFF;
+
+    switch (offset) {
+    case 0x00:
+        if (value & 1 << 2) { /*IREFS*/
+            s->S = 0;
+            s->S |= 1 << 3; /*10 Enconding 2 - External ref clk is selected*/
+        }
+        if ((s->C1 & 0x80) && (value >> 6 == 0)) {
+            s->S |= 1 << 2; /*11 Enconding 3 - Output of the PLL is selected*/
+        }
+        s->C1 = value;
+        break;
+    case 0x01:
+        s->C2 = value;
+        break;
+    case 0x02:
+        s->C3 = value;
+        break;
+    case 0x03:
+        s->C4 = value;
+        break;
+    case 0x04:
+        s->C5 = value;
+        if (s->C5 & 1 << 6) { /*PLLCLKEN0*/
+            s->S |= 1 << 6;  /*LOCK0*/
+        }
+        break;
+    case 0x05:
+        s->C6 = value;
+        if (s->C6 & 1 << 6) { /*PLLS*/
+            s->S |= 1 << 5;  /*PLLST*/
+        }
+        break;
+    case 0x06:
+        s->S = value;
+        break;
+    case 0x08:
+        s->SC = value;
+        break;
+    case 0x0A:
+        s->ATCVH = value;
+        break;
+    case 0x0B:
+        s->ATCVL = value;
+        break;
+    case 0x0C:
+        s->C7 = value;
+        break;
+    case 0x0D:
+        s->C8 = value;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "kinetis_k64_mcg: write at bad offset %"HWADDR_PRIx"\n", offset);
+    }
+}
+
+static uint64_t kinetis_k64_mcg_read(void *opaque, hwaddr offset, unsigned size)
+{
+    kinetis_k64_mcg_state *s = (kinetis_k64_mcg_state *)opaque;
+    uint8_t value;
+
+    switch (offset) {
+    case 0x00:
+        value = s->C1;
+        break;
+    case 0x01:
+        value = s->C2;
+        break;
+    case 0x02:
+        value = s->C3;
+        break;
+    case 0x03:
+        value = s->C4;
+        break;
+    case 0x04:
+        value = s->C5;
+        break;
+    case 0x05:
+        value = s->C6;
+        break;
+    case 0x06:
+        value = s->S;
+        break;
+    case 0x08:
+        value = s->SC;
+        break;
+    case 0x0A:
+        value = s->ATCVH;
+        break;
+    case 0x0B:
+        value = s->ATCVL;
+        break;
+    case 0x0C:
+        value = s->C7;
+        break;
+    case 0x0D:
+        value = s->C8;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "kinetis_k64_mcg: read at bad offset %"HWADDR_PRIx"\n", offset);
+        return 0;
+    }
+    return value;
+}
+
+static const MemoryRegionOps kinetis_k64_mcg_ops = {
+    .read = kinetis_k64_mcg_read,
+    .write = kinetis_k64_mcg_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void kinetis_k64_mcg_init(Object *obj)
+{
+    kinetis_k64_mcg_state *s = KINETIS_K64_MCG(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->iomem, obj, &kinetis_k64_mcg_ops, s,
+            TYPE_KINETIS_K64_MCG, 0x1000);
+    sysbus_init_mmio(sbd, &s->iomem);
+    sysbus_init_irq(sbd, &s->irq);
+}
+
+static void kinetis_k64_mcg_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_kinetis_k64_mcg;
+    dc->reset = kinetis_k64_mcg_reset;
+    dc->desc = "Kinetis K64 series MCG";
+}
+
+static const TypeInfo kinetis_k64_mcg_info = {
+    .name          = TYPE_KINETIS_K64_MCG,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(kinetis_k64_mcg_state),
+    .instance_init = kinetis_k64_mcg_init,
+    .class_init    = kinetis_k64_mcg_class_init,
+};
+
+static void kinetis_k64_mcg_register_types(void)
+{
+    type_register_static(&kinetis_k64_mcg_info);
+}
+
+type_init(kinetis_k64_mcg_register_types)
diff --git a/include/hw/misc/kinetis_k64_mcg.h b/include/hw/misc/kinetis_k64_mcg.h
new file mode 100644
index 0000000..3f105c5
--- /dev/null
+++ b/include/hw/misc/kinetis_k64_mcg.h
@@ -0,0 +1,43 @@
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
+#ifndef KINETIS_MCG_H
+#define KINETIS_MCG_H
+
+#include "hw/sysbus.h"
+#include "hw/hw.h"
+
+#define TYPE_KINETIS_K64_MCG "kinetis_k64_mcg"
+#define KINETIS_K64_MCG(obj) \
+    OBJECT_CHECK(kinetis_k64_mcg_state, (obj), TYPE_KINETIS_K64_MCG)
+
+typedef struct {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+
+    uint8_t C1;
+    uint8_t C2;
+    uint8_t C3;
+    uint8_t C4;
+    uint8_t C5;
+    uint8_t C6;
+    uint8_t S;
+    uint8_t SC;
+    uint8_t ATCVH;
+    uint8_t ATCVL;
+    uint8_t C7;
+    uint8_t C8;
+
+    qemu_irq irq;
+} kinetis_k64_mcg_state;
+
+#endif
-- 
2.1.4
