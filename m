Received: from eggs.gnu.org ([2001:4830:134:3::10]:41657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHL-00042Z-7D
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHJ-0007Zf-K4
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:43 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36567)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1elZHJ-0007ZQ-AL
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:41 -0500
Received: by mail-wm0-x244.google.com with SMTP id f3so15602470wmc.1
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 04:01:41 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Feb 2018 13:00:11 +0100
Message-Id: <1518523252-49106-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
References: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 07/48] hw/net/can: Kvaser PCI CAN-S (single
 SJA1000 channel) emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>

From: Pavel Pisa <pisa@cmp.felk.cvut.cz>

Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/pci.mak     |   1 +
 hw/net/can/Makefile.objs    |   1 +
 hw/net/can/can_kvaser_pci.c | 319 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 321 insertions(+)
 create mode 100644 hw/net/can/can_kvaser_pci.c

diff --git a/default-configs/pci.mak b/default-configs/pci.mak
index 23f91d0..35e7596 100644
--- a/default-configs/pci.mak
+++ b/default-configs/pci.mak
@@ -33,6 +33,7 @@ CONFIG_SERIAL_ISA=y
 CONFIG_SERIAL_PCI=y
 CONFIG_CAN_BUS=y
 CONFIG_CAN_SJA1000=y
+CONFIG_CAN_PCI=y
 CONFIG_IPACK=y
 CONFIG_WDT_IB6300ESB=y
 CONFIG_PCI_TESTDEV=y
diff --git a/hw/net/can/Makefile.objs b/hw/net/can/Makefile.objs
index c299f83..9d4a515 100644
--- a/hw/net/can/Makefile.objs
+++ b/hw/net/can/Makefile.objs
@@ -1 +1,2 @@
 common-obj-$(CONFIG_CAN_SJA1000) += can_sja1000.o
+common-obj-$(CONFIG_CAN_PCI) += can_kvaser_pci.o
diff --git a/hw/net/can/can_kvaser_pci.c b/hw/net/can/can_kvaser_pci.c
new file mode 100644
index 0000000..2d77ef2
--- /dev/null
+++ b/hw/net/can/can_kvaser_pci.c
@@ -0,0 +1,319 @@
+/*
+ * Kvaser PCI CAN device (SJA1000 based) emulation
+ *
+ * Copyright (c) 2013-2014 Jin Yang
+ * Copyright (c) 2014-2018 Pavel Pisa
+ *
+ * Partially based on educational PCIexpress APOHW hardware
+ * emulator used fro class A0B36APO at CTU FEE course by
+ *    Rostislav Lisovy and Pavel Pisa
+ *
+ * Initial development supported by Google GSoC 2013 from RTEMS project slot
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
+#include "qemu/event_notifier.h"
+#include "qemu/thread.h"
+#include "qemu/sockets.h"
+#include "qapi/error.h"
+#include "chardev/char.h"
+#include "hw/hw.h"
+#include "hw/pci/pci.h"
+#include "net/can_emu.h"
+
+#include "can_sja1000.h"
+
+#define TYPE_CAN_PCI_DEV "kvaser_pci"
+
+#define KVASER_PCI_DEV(obj) \
+    OBJECT_CHECK(KvaserPCIState, (obj), TYPE_CAN_PCI_DEV)
+
+#ifndef KVASER_PCI_VENDOR_ID1
+#define KVASER_PCI_VENDOR_ID1     0x10e8    /* the PCI device and vendor IDs */
+#endif
+
+#ifndef KVASER_PCI_DEVICE_ID1
+#define KVASER_PCI_DEVICE_ID1     0x8406
+#endif
+
+#define KVASER_PCI_S5920_RANGE    0x80
+#define KVASER_PCI_SJA_RANGE      0x80
+#define KVASER_PCI_XILINX_RANGE   0x8
+
+#define KVASER_PCI_BYTES_PER_SJA  0x20
+
+#define S5920_OMB                 0x0C
+#define S5920_IMB                 0x1C
+#define S5920_MBEF                0x34
+#define S5920_INTCSR              0x38
+#define S5920_RCR                 0x3C
+#define S5920_PTCR                0x60
+
+#define S5920_INTCSR_ADDON_INTENABLE_M        0x2000
+#define S5920_INTCSR_INTERRUPT_ASSERTED_M     0x800000
+
+#define KVASER_PCI_XILINX_VERINT  7   /* Lower nibble simulate interrupts,
+                                         high nibble version number. */
+
+#define KVASER_PCI_XILINX_VERSION_NUMBER 13
+
+typedef struct KvaserPCIState {
+    /*< private >*/
+    PCIDevice       dev;
+    /*< public >*/
+    MemoryRegion    s5920_io;
+    MemoryRegion    sja_io;
+    MemoryRegion    xilinx_io;
+
+    CanSJA1000State sja_state;
+    qemu_irq        irq;
+
+    uint32_t        s5920_intcsr;
+    uint32_t        s5920_irqstate;
+
+    CanBusState     *canbus;
+} KvaserPCIState;
+
+static void kvaser_pci_irq_handler(void *opaque, int irq_num, int level)
+{
+    KvaserPCIState *d = (KvaserPCIState *)opaque;
+
+    d->s5920_irqstate = level;
+    if (d->s5920_intcsr & S5920_INTCSR_ADDON_INTENABLE_M) {
+        pci_set_irq(&d->dev, level);
+    }
+}
+
+static void kvaser_pci_reset(DeviceState *dev)
+{
+    KvaserPCIState *d = KVASER_PCI_DEV(dev);
+    CanSJA1000State *s = &d->sja_state;
+
+    can_sja_hardware_reset(s);
+}
+
+static uint64_t kvaser_pci_s5920_io_read(void *opaque, hwaddr addr,
+                                         unsigned size)
+{
+    KvaserPCIState *d = opaque;
+    uint64_t val;
+
+    switch (addr) {
+    case S5920_INTCSR:
+        val = d->s5920_intcsr;
+        val &= ~S5920_INTCSR_INTERRUPT_ASSERTED_M;
+        if (d->s5920_irqstate) {
+            val |= S5920_INTCSR_INTERRUPT_ASSERTED_M;
+        }
+        return val;
+    }
+    return 0;
+}
+
+static void kvaser_pci_s5920_io_write(void *opaque, hwaddr addr, uint64_t data,
+                                      unsigned size)
+{
+    KvaserPCIState *d = opaque;
+
+    switch (addr) {
+    case S5920_INTCSR:
+        if (d->s5920_irqstate &&
+            ((d->s5920_intcsr ^ data) & S5920_INTCSR_ADDON_INTENABLE_M)) {
+            pci_set_irq(&d->dev, !!(data & S5920_INTCSR_ADDON_INTENABLE_M));
+        }
+        d->s5920_intcsr = data;
+        break;
+    }
+}
+
+static uint64_t kvaser_pci_sja_io_read(void *opaque, hwaddr addr, unsigned size)
+{
+    KvaserPCIState *d = opaque;
+    CanSJA1000State *s = &d->sja_state;
+
+    if (addr >= KVASER_PCI_BYTES_PER_SJA) {
+        return 0;
+    }
+
+    return can_sja_mem_read(s, addr, size);
+}
+
+static void kvaser_pci_sja_io_write(void *opaque, hwaddr addr, uint64_t data,
+                                    unsigned size)
+{
+    KvaserPCIState *d = opaque;
+    CanSJA1000State *s = &d->sja_state;
+
+    if (addr >= KVASER_PCI_BYTES_PER_SJA) {
+        return;
+    }
+
+    can_sja_mem_write(s, addr, data, size);
+}
+
+static uint64_t kvaser_pci_xilinx_io_read(void *opaque, hwaddr addr,
+                                          unsigned size)
+{
+    switch (addr) {
+    case KVASER_PCI_XILINX_VERINT:
+        return (KVASER_PCI_XILINX_VERSION_NUMBER << 4) | 0;
+    }
+
+    return 0;
+}
+
+static void kvaser_pci_xilinx_io_write(void *opaque, hwaddr addr, uint64_t data,
+                             unsigned size)
+{
+
+}
+
+static const MemoryRegionOps kvaser_pci_s5920_io_ops = {
+    .read = kvaser_pci_s5920_io_read,
+    .write = kvaser_pci_s5920_io_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static const MemoryRegionOps kvaser_pci_sja_io_ops = {
+    .read = kvaser_pci_sja_io_read,
+    .write = kvaser_pci_sja_io_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .max_access_size = 1,
+    },
+};
+
+static const MemoryRegionOps kvaser_pci_xilinx_io_ops = {
+    .read = kvaser_pci_xilinx_io_read,
+    .write = kvaser_pci_xilinx_io_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .max_access_size = 1,
+    },
+};
+
+static void kvaser_pci_realize(PCIDevice *pci_dev, Error **errp)
+{
+    KvaserPCIState *d = KVASER_PCI_DEV(pci_dev);
+    CanSJA1000State *s = &d->sja_state;
+    uint8_t *pci_conf;
+
+    pci_conf = pci_dev->config;
+    pci_conf[PCI_INTERRUPT_PIN] = 0x01; /* interrupt pin A */
+
+    d->irq = qemu_allocate_irq(kvaser_pci_irq_handler, d, 0);
+
+    can_sja_init(s, d->irq);
+
+    if (can_sja_connect_to_bus(s, d->canbus) < 0) {
+        error_setg(errp, "can_sja_connect_to_bus failed");
+        return;
+    }
+
+    memory_region_init_io(&d->s5920_io, OBJECT(d), &kvaser_pci_s5920_io_ops,
+                          d, "kvaser_pci-s5920", KVASER_PCI_S5920_RANGE);
+    memory_region_init_io(&d->sja_io, OBJECT(d), &kvaser_pci_sja_io_ops,
+                          d, "kvaser_pci-sja", KVASER_PCI_SJA_RANGE);
+    memory_region_init_io(&d->xilinx_io, OBJECT(d), &kvaser_pci_xilinx_io_ops,
+                          d, "kvaser_pci-xilinx", KVASER_PCI_XILINX_RANGE);
+
+    pci_register_bar(&d->dev, /*BAR*/ 0, PCI_BASE_ADDRESS_SPACE_IO,
+                                            &d->s5920_io);
+    pci_register_bar(&d->dev, /*BAR*/ 1, PCI_BASE_ADDRESS_SPACE_IO,
+                                            &d->sja_io);
+    pci_register_bar(&d->dev, /*BAR*/ 2, PCI_BASE_ADDRESS_SPACE_IO,
+                                            &d->xilinx_io);
+}
+
+static void kvaser_pci_exit(PCIDevice *pci_dev)
+{
+    KvaserPCIState *d = KVASER_PCI_DEV(pci_dev);
+    CanSJA1000State *s = &d->sja_state;
+
+    can_sja_disconnect(s);
+
+    qemu_free_irq(d->irq);
+}
+
+static const VMStateDescription vmstate_kvaser_pci = {
+    .name = "kvaser_pci",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .minimum_version_id_old = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_PCI_DEVICE(dev, KvaserPCIState),
+        VMSTATE_STRUCT(sja_state, KvaserPCIState, 0, vmstate_can_sja,
+                       CanSJA1000State),
+        VMSTATE_UINT32(s5920_intcsr, KvaserPCIState),
+        VMSTATE_UINT32(s5920_irqstate, KvaserPCIState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void kvaser_pci_instance_init(Object *obj)
+{
+    KvaserPCIState *d = KVASER_PCI_DEV(obj);
+
+    object_property_add_link(obj, "canbus", TYPE_CAN_BUS,
+                             (Object **)&d->canbus,
+                             qdev_prop_allow_set_link_before_realize,
+                             0, &error_abort);
+}
+
+static void kvaser_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->realize = kvaser_pci_realize;
+    k->exit = kvaser_pci_exit;
+    k->vendor_id = KVASER_PCI_VENDOR_ID1;
+    k->device_id = KVASER_PCI_DEVICE_ID1;
+    k->revision = 0x00;
+    k->class_id = 0x00ff00;
+    dc->desc = "Kvaser PCICANx";
+    dc->vmsd = &vmstate_kvaser_pci;
+    dc->reset = kvaser_pci_reset;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+}
+
+static const TypeInfo kvaser_pci_info = {
+    .name          = TYPE_CAN_PCI_DEV,
+    .parent        = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(KvaserPCIState),
+    .class_init    = kvaser_pci_class_init,
+    .instance_init = kvaser_pci_instance_init,
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
+};
+
+static void kvaser_pci_register_types(void)
+{
+    type_register_static(&kvaser_pci_info);
+}
+
+type_init(kvaser_pci_register_types)
-- 
1.8.3.1
