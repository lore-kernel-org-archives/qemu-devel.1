Received: from eggs.gnu.org ([2001:4830:134:3::10]:41496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gabriel291075@gmail.com>) id 1e5dFI-0008BF-2R
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 15:46:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gabriel291075@gmail.com>) id 1e5dFG-0007dd-Aq
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 15:46:16 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:49448)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gabriel291075@gmail.com>)
	id 1e5dFG-0007dS-4p
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 15:46:14 -0400
Received: by mail-qt0-x241.google.com with SMTP id k31so19830302qta.6
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 12:46:14 -0700 (PDT)
From: Gabriel Augusto Costa <gabriel291075@gmail.com>
Date: Fri, 20 Oct 2017 11:41:57 -0400
Message-Id: <1508514117-15880-1-git-send-email-gabriel291075@gmail.com>
Subject: [Qemu-devel] [PATCH v3 08/11] kinetis_k64_pmux.c has been added
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

I made a new arm machine with some peripherals. The machine is mk64fn1m0, a
cortex-m4 microcontroller from NXP Kinetis family. The machine can run a
simple arm binary file using UART0 in polling mode.
I have prepared a series of patchs to include this machine:
PATCH v3 n/11: It adds the machine and peripherals devices;
PATCH v4 n/2: It changes the Make files to compile this machine.

Signed-off-by: Gabriel Augusto Costa <gabriel291075@gmail.com>
---
 hw/misc/kinetis_k64_pmux.c | 417 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 417 insertions(+)
 create mode 100644 hw/misc/kinetis_k64_pmux.c

diff --git a/hw/misc/kinetis_k64_pmux.c b/hw/misc/kinetis_k64_pmux.c
new file mode 100644
index 0000000..02b31e1
--- /dev/null
+++ b/hw/misc/kinetis_k64_pmux.c
@@ -0,0 +1,417 @@
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
+/* Kinetis K64 series PMUX controller.  */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/sysbus.h"
+#include "hw/ssi/ssi.h"
+#include "hw/arm/arm.h"
+#include "hw/devices.h"
+#include "qemu/timer.h"
+#include "net/net.h"
+#include "hw/boards.h"
+#include "qemu/log.h"
+#include "exec/address-spaces.h"
+#include "sysemu/sysemu.h"
+#include "hw/char/pl011.h"
+#include "hw/misc/unimp.h"
+#include "hw/misc/kinetis_k64_pmux.h"
+
+static const VMStateDescription vmstate_kinetis_k64_pmux = {
+    .name = TYPE_KINETIS_K64_PMUX,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(PCR00, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR01, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR02, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR03, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR04, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR05, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR06, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR07, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR08, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR09, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR10, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR11, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR12, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR13, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR14, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR15, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR16, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR17, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR18, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR19, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR20, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR21, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR22, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR23, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR24, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR25, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR26, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR27, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR28, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR29, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR30, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(PCR31, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(GPCLR, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(GPCHR, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(ISFR, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(DFER, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(DFCR, kinetis_k64_pmux_state),
+        VMSTATE_UINT32(DFWR, kinetis_k64_pmux_state),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void kinetis_k64_pmux_reset(DeviceState *dev)
+{
+    kinetis_k64_pmux_state *s = KINETIS_K64_PMUX(dev);
+
+    s->PCR00 = 0x00000000;
+    s->PCR01 = 0x00000000;
+    s->PCR02 = 0x00000000;
+    s->PCR03 = 0x00000000;
+    s->PCR04 = 0x00000000;
+    s->PCR05 = 0x00000000;
+    s->PCR06 = 0x00000000;
+    s->PCR07 = 0x00000000;
+    s->PCR08 = 0x00000000;
+    s->PCR09 = 0x00000000;
+    s->PCR10 = 0x00000000;
+    s->PCR11 = 0x00000000;
+    s->PCR12 = 0x00000000;
+    s->PCR13 = 0x00000000;
+    s->PCR14 = 0x00000000;
+    s->PCR15 = 0x00000000;
+    s->PCR16 = 0x00000000;
+    s->PCR17 = 0x00000000;
+    s->PCR18 = 0x00000000;
+    s->PCR19 = 0x00000000;
+    s->PCR20 = 0x00000000;
+    s->PCR21 = 0x00000000;
+    s->PCR22 = 0x00000000;
+    s->PCR23 = 0x00000000;
+    s->PCR24 = 0x00000000;
+    s->PCR25 = 0x00000000;
+    s->PCR26 = 0x00000000;
+    s->PCR27 = 0x00000000;
+    s->PCR28 = 0x00000000;
+    s->PCR29 = 0x00000000;
+    s->PCR30 = 0x00000000;
+    s->PCR31 = 0x00000000;
+    s->GPCLR = 0x00000000;
+    s->GPCHR = 0x00000000;
+    s->ISFR = 0x00000000;
+    s->DFER = 0x00000000;
+    s->DFCR = 0x00000000;
+    s->DFWR = 0x00000000;
+}
+
+static void kinetis_k64_pmux_write(void *opaque, hwaddr offset, uint64_t value,
+        unsigned size)
+{
+    kinetis_k64_pmux_state *s = (kinetis_k64_pmux_state *)opaque;
+
+    value &= 0xFFFFFFFF;
+    switch (offset) {
+    case 0x00:
+        s->PCR00 = value;
+        break;
+    case 0x04:
+        s->PCR01 = value;
+        break;
+    case 0x08:
+        s->PCR02 = value;
+        break;
+    case 0x0C:
+        s->PCR03 = value;
+        break;
+    case 0x10:
+        s->PCR04 = value;
+        break;
+    case 0x14:
+        s->PCR05 = value;
+        break;
+    case 0x18:
+        s->PCR06 = value;
+        break;
+    case 0x1C:
+        s->PCR07 = value;
+        break;
+    case 0x20:
+        s->PCR08 = value;
+        break;
+    case 0x24:
+        s->PCR09 = value;
+        break;
+    case 0x28:
+        s->PCR10 = value;
+        break;
+    case 0x2C:
+        s->PCR11 = value;
+        break;
+    case 0x30:
+        s->PCR12 = value;
+        break;
+    case 0x34:
+        s->PCR13 = value;
+        break;
+    case 0x38:
+        s->PCR14 = value;
+        break;
+    case 0x3C:
+        s->PCR15 = value;
+        break;
+    case 0x40:
+        s->PCR16 = value;
+        break;
+    case 0x44:
+        s->PCR17 = value;
+        break;
+    case 0x48:
+        s->PCR18 = value;
+        break;
+    case 0x4C:
+        s->PCR19 = value;
+        break;
+    case 0x50:
+        s->PCR20 = value;
+        break;
+    case 0x54:
+        s->PCR21 = value;
+        break;
+    case 0x58:
+        s->PCR22 = value;
+        break;
+    case 0x5C:
+        s->PCR23 = value;
+        break;
+    case 0x60:
+        s->PCR24 = value;
+        break;
+    case 0x64:
+        s->PCR25 = value;
+        break;
+    case 0x68:
+        s->PCR26 = value;
+        break;
+    case 0x6C:
+        s->PCR27 = value;
+        break;
+    case 0x70:
+        s->PCR28 = value;
+        break;
+    case 0x74:
+        s->PCR29 = value;
+        break;
+    case 0x78:
+        s->PCR30 = value;
+        break;
+    case 0x7C:
+        s->PCR31 = value;
+        break;
+    case 0x80:
+        s->GPCLR = value;
+        break;
+    case 0x84:
+        s->GPCHR = value;
+        break;
+    case 0xA0:
+        s->ISFR = value;
+        break;
+    case 0xC0:
+        s->DFER = value;
+        break;
+    case 0xC4:
+        s->DFCR = value;
+        break;
+    case 0xC8:
+        s->DFWR = value;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                "kinetis_k64_pmux: write at bad offset 0x%x\n",
+                (int)offset);
+    }
+}
+
+static uint64_t kinetis_k64_pmux_read(void *opaque, hwaddr offset,
+        unsigned size)
+{
+    kinetis_k64_pmux_state *s = (kinetis_k64_pmux_state *)opaque;
+    uint8_t value;
+
+    switch (offset) {
+    case 0x00:
+        value = s->PCR00;
+        break;
+    case 0x04:
+        value = s->PCR01;
+        break;
+    case 0x08:
+        value = s->PCR02;
+        break;
+    case 0x0C:
+        value = s->PCR03;
+        break;
+    case 0x10:
+        value = s->PCR04;
+        break;
+    case 0x14:
+        value = s->PCR05;
+        break;
+    case 0x18:
+        value = s->PCR06;
+        break;
+    case 0x1C:
+        value = s->PCR07;
+        break;
+    case 0x20:
+        value = s->PCR08;
+        break;
+    case 0x24:
+        value = s->PCR09;
+        break;
+    case 0x28:
+        value = s->PCR10;
+        break;
+    case 0x2C:
+        value = s->PCR11;
+        break;
+    case 0x30:
+        value = s->PCR12;
+        break;
+    case 0x34:
+        value = s->PCR13;
+        break;
+    case 0x38:
+        value = s->PCR14;
+        break;
+    case 0x3C:
+        value = s->PCR15;
+        break;
+    case 0x40:
+        value = s->PCR16;
+        break;
+    case 0x44:
+        value = s->PCR17;
+        break;
+    case 0x48:
+        value = s->PCR18;
+        break;
+    case 0x4C:
+        value = s->PCR19;
+        break;
+    case 0x50:
+        value = s->PCR20;
+        break;
+    case 0x54:
+        value = s->PCR21;
+        break;
+    case 0x58:
+        value = s->PCR22;
+        break;
+    case 0x5C:
+        value = s->PCR23;
+        break;
+    case 0x60:
+        value = s->PCR24;
+        break;
+    case 0x64:
+        value = s->PCR25;
+        break;
+    case 0x68:
+        value = s->PCR26;
+        break;
+    case 0x6C:
+        value = s->PCR27;
+        break;
+    case 0x70:
+        value = s->PCR28;
+        break;
+    case 0x74:
+        value = s->PCR29;
+        break;
+    case 0x78:
+        value = s->PCR30;
+        break;
+    case 0x7C:
+        value = s->PCR31;
+        break;
+    case 0x80:
+        value = s->GPCLR;
+        break;
+    case 0x84:
+        value = s->GPCHR;
+        break;
+    case 0xA0:
+        value = s->ISFR;
+        break;
+    case 0xC0:
+        value = s->DFER;
+        break;
+    case 0xC4:
+        value = s->DFCR;
+        break;
+    case 0xC8:
+        value = s->DFWR;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                "kinetis_k64_pmux: read at bad offset 0x%x\n", (int)offset);
+        return 0;
+    }
+    return value;
+}
+
+static const MemoryRegionOps kinetis_k64_pmux_ops = {
+    .read = kinetis_k64_pmux_read,
+    .write = kinetis_k64_pmux_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void kinetis_k64_pmux_init(Object *obj)
+{
+    kinetis_k64_pmux_state *s = KINETIS_K64_PMUX(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->iomem, obj, &kinetis_k64_pmux_ops, s,
+            TYPE_KINETIS_K64_PMUX, 0x1000);
+    sysbus_init_mmio(sbd, &s->iomem);
+    sysbus_init_irq(sbd, &s->irq);
+}
+
+static void kinetis_k64_pmux_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_kinetis_k64_pmux;
+    dc->reset = kinetis_k64_pmux_reset;
+    dc->desc = "Kinetis K64 series PMUX";
+}
+
+static const TypeInfo kinetis_k64_pmux_info = {
+    .name          = TYPE_KINETIS_K64_PMUX,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(kinetis_k64_pmux_state),
+    .instance_init = kinetis_k64_pmux_init,
+    .class_init    = kinetis_k64_pmux_class_init,
+};
+
+static void kinetis_k64_pmux_register_types(void)
+{
+    type_register_static(&kinetis_k64_pmux_info);
+}
+
+type_init(kinetis_k64_pmux_register_types)
-- 
2.1.4
