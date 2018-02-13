Received: from eggs.gnu.org ([2001:4830:134:3::10]:41708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHQ-00047X-Fx
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHL-0007aR-Ud
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:48 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:37356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1elZHL-0007aE-Ky
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:43 -0500
Received: by mail-wm0-x242.google.com with SMTP id v71so15609975wmv.2
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 04:01:43 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Feb 2018 13:00:13 +0100
Message-Id: <1518523252-49106-10-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
References: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 09/48] hw/net/can: MIOe-3680 PCI (dual SJA1000
 channel) emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Deniz Eren <deniz.eren@icloud.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>

From: Deniz Eren <deniz.eren@icloud.com>

Signed-off-by: Deniz Eren <deniz.eren@icloud.com>
Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/net/can/Makefile.objs      |   1 +
 hw/net/can/can_mioe3680_pci.c | 262 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 263 insertions(+)
 create mode 100644 hw/net/can/can_mioe3680_pci.c

diff --git a/hw/net/can/Makefile.objs b/hw/net/can/Makefile.objs
index 97c4295..9f0c4ee 100644
--- a/hw/net/can/Makefile.objs
+++ b/hw/net/can/Makefile.objs
@@ -1,3 +1,4 @@
 common-obj-$(CONFIG_CAN_SJA1000) += can_sja1000.o
 common-obj-$(CONFIG_CAN_PCI) += can_kvaser_pci.o
 common-obj-$(CONFIG_CAN_PCI) += can_pcm3680_pci.o
+common-obj-$(CONFIG_CAN_PCI) += can_mioe3680_pci.o
diff --git a/hw/net/can/can_mioe3680_pci.c b/hw/net/can/can_mioe3680_pci.c
new file mode 100644
index 0000000..fd20b88
--- /dev/null
+++ b/hw/net/can/can_mioe3680_pci.c
@@ -0,0 +1,262 @@
+/*
+ * MIOe-3680 PCI CAN device (SJA1000 based) emulation
+ *
+ * Copyright (c) 2016 Deniz Eren (deniz.eren@icloud.com)
+ *
+ * Based on Kvaser PCI CAN device (SJA1000 based) emulation implemented by
+ * Jin Yang and Pavel Pisa
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
+#define TYPE_CAN_PCI_DEV "mioe3680_pci"
+
+#define MIOe3680_PCI_DEV(obj) \
+    OBJECT_CHECK(Mioe3680PCIState, (obj), TYPE_CAN_PCI_DEV)
+
+/* the PCI device and vendor IDs */
+#ifndef MIOe3680_PCI_VENDOR_ID1
+#define MIOe3680_PCI_VENDOR_ID1     0x13fe
+#endif
+
+#ifndef MIOe3680_PCI_DEVICE_ID1
+#define MIOe3680_PCI_DEVICE_ID1     0xc302
+#endif
+
+#define MIOe3680_PCI_SJA_COUNT     2
+#define MIOe3680_PCI_SJA_RANGE     0x400
+
+#define MIOe3680_PCI_BYTES_PER_SJA 0x80
+
+typedef struct Mioe3680PCIState {
+    /*< private >*/
+    PCIDevice       dev;
+    /*< public >*/
+    MemoryRegion    sja_io[MIOe3680_PCI_SJA_COUNT];
+
+    CanSJA1000State sja_state[MIOe3680_PCI_SJA_COUNT];
+    qemu_irq        irq;
+
+    char            *model; /* The model that support, only SJA1000 now. */
+    CanBusState     *canbus[MIOe3680_PCI_SJA_COUNT];
+} Mioe3680PCIState;
+
+static void mioe3680_pci_reset(DeviceState *dev)
+{
+    Mioe3680PCIState *d = MIOe3680_PCI_DEV(dev);
+    int i;
+
+    for (i = 0 ; i < MIOe3680_PCI_SJA_COUNT; i++) {
+        can_sja_hardware_reset(&d->sja_state[i]);
+    }
+}
+
+static uint64_t mioe3680_pci_sja1_io_read(void *opaque, hwaddr addr,
+                                          unsigned size)
+{
+    Mioe3680PCIState *d = opaque;
+    CanSJA1000State *s = &d->sja_state[0];
+
+    if (addr >= MIOe3680_PCI_BYTES_PER_SJA) {
+        return 0;
+    }
+
+    return can_sja_mem_read(s, addr >> 2, size);
+}
+
+static void mioe3680_pci_sja1_io_write(void *opaque, hwaddr addr, uint64_t data,
+                             unsigned size)
+{
+    Mioe3680PCIState *d = opaque;
+    CanSJA1000State *s = &d->sja_state[0];
+
+    if (addr >= MIOe3680_PCI_BYTES_PER_SJA) {
+        return;
+    }
+
+    can_sja_mem_write(s, addr >> 2, data, size);
+}
+
+static uint64_t mioe3680_pci_sja2_io_read(void *opaque, hwaddr addr,
+                                          unsigned size)
+{
+    Mioe3680PCIState *d = opaque;
+    CanSJA1000State *s = &d->sja_state[1];
+
+    if (addr >= MIOe3680_PCI_BYTES_PER_SJA) {
+        return 0;
+    }
+
+    return can_sja_mem_read(s, addr >> 2, size);
+}
+
+static void mioe3680_pci_sja2_io_write(void *opaque, hwaddr addr, uint64_t data,
+                             unsigned size)
+{
+    Mioe3680PCIState *d = opaque;
+    CanSJA1000State *s = &d->sja_state[1];
+
+    if (addr >= MIOe3680_PCI_BYTES_PER_SJA) {
+        return;
+    }
+
+    can_sja_mem_write(s, addr >> 2, data, size);
+}
+
+static const MemoryRegionOps mioe3680_pci_sja1_io_ops = {
+    .read = mioe3680_pci_sja1_io_read,
+    .write = mioe3680_pci_sja1_io_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .max_access_size = 1,
+    },
+};
+
+static const MemoryRegionOps mioe3680_pci_sja2_io_ops = {
+    .read = mioe3680_pci_sja2_io_read,
+    .write = mioe3680_pci_sja2_io_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .max_access_size = 1,
+    },
+};
+
+static void mioe3680_pci_realize(PCIDevice *pci_dev, Error **errp)
+{
+    Mioe3680PCIState *d = MIOe3680_PCI_DEV(pci_dev);
+    uint8_t *pci_conf;
+    int i;
+
+    pci_conf = pci_dev->config;
+    pci_conf[PCI_INTERRUPT_PIN] = 0x01; /* interrupt pin A */
+
+    d->irq = pci_allocate_irq(&d->dev);
+
+    for (i = 0 ; i < MIOe3680_PCI_SJA_COUNT; i++) {
+        can_sja_init(&d->sja_state[i], d->irq);
+    }
+
+    for (i = 0 ; i < MIOe3680_PCI_SJA_COUNT; i++) {
+        if (can_sja_connect_to_bus(&d->sja_state[i], d->canbus[i]) < 0) {
+            error_setg(errp, "can_sja_connect_to_bus failed");
+            return;
+        }
+    }
+
+    memory_region_init_io(&d->sja_io[0], OBJECT(d), &mioe3680_pci_sja1_io_ops,
+                          d, "mioe3680_pci-sja1", MIOe3680_PCI_SJA_RANGE);
+    memory_region_init_io(&d->sja_io[1], OBJECT(d), &mioe3680_pci_sja2_io_ops,
+                          d, "mioe3680_pci-sja2", MIOe3680_PCI_SJA_RANGE);
+
+    for (i = 0 ; i < MIOe3680_PCI_SJA_COUNT; i++) {
+        pci_register_bar(&d->dev, /*BAR*/ i, PCI_BASE_ADDRESS_SPACE_IO,
+                         &d->sja_io[i]);
+    }
+}
+
+static void mioe3680_pci_exit(PCIDevice *pci_dev)
+{
+    Mioe3680PCIState *d = MIOe3680_PCI_DEV(pci_dev);
+    int i;
+
+    for (i = 0 ; i < MIOe3680_PCI_SJA_COUNT; i++) {
+        can_sja_disconnect(&d->sja_state[i]);
+    }
+
+    qemu_free_irq(d->irq);
+}
+
+static const VMStateDescription vmstate_mioe3680_pci = {
+    .name = "mioe3680_pci",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .minimum_version_id_old = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_PCI_DEVICE(dev, Mioe3680PCIState),
+        VMSTATE_STRUCT(sja_state[0], Mioe3680PCIState, 0, vmstate_can_sja,
+                       CanSJA1000State),
+        VMSTATE_STRUCT(sja_state[1], Mioe3680PCIState, 0, vmstate_can_sja,
+                       CanSJA1000State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void mioe3680_pci_instance_init(Object *obj)
+{
+    Mioe3680PCIState *d = MIOe3680_PCI_DEV(obj);
+
+    object_property_add_link(obj, "canbus0", TYPE_CAN_BUS,
+                             (Object **)&d->canbus[0],
+                             qdev_prop_allow_set_link_before_realize,
+                             0, &error_abort);
+    object_property_add_link(obj, "canbus1", TYPE_CAN_BUS,
+                             (Object **)&d->canbus[1],
+                             qdev_prop_allow_set_link_before_realize,
+                             0, &error_abort);
+}
+
+static void mioe3680_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->realize = mioe3680_pci_realize;
+    k->exit = mioe3680_pci_exit;
+    k->vendor_id = MIOe3680_PCI_VENDOR_ID1;
+    k->device_id = MIOe3680_PCI_DEVICE_ID1;
+    k->revision = 0x00;
+    k->class_id = 0x000c09;
+    k->subsystem_vendor_id = MIOe3680_PCI_VENDOR_ID1;
+    k->subsystem_id = MIOe3680_PCI_DEVICE_ID1;
+    dc->desc = "Mioe3680 PCICANx";
+    dc->vmsd = &vmstate_mioe3680_pci;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->reset = mioe3680_pci_reset;
+}
+
+static const TypeInfo mioe3680_pci_info = {
+    .name          = TYPE_CAN_PCI_DEV,
+    .parent        = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(Mioe3680PCIState),
+    .class_init    = mioe3680_pci_class_init,
+    .instance_init = mioe3680_pci_instance_init,
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
+};
+
+static void mioe3680_pci_register_types(void)
+{
+    type_register_static(&mioe3680_pci_info);
+}
+
+type_init(mioe3680_pci_register_types)
-- 
1.8.3.1
