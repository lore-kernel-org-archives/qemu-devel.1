Received: from eggs.gnu.org ([2001:4830:134:3::10]:38015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jthumshirn@suse.de>) id 1fnPIr-0003J4-L9
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 10:19:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jthumshirn@suse.de>) id 1fnPIn-0001hN-HQ
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 10:19:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:56864 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jthumshirn@suse.de>) id 1fnPIn-0001ep-67
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 10:19:05 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id 19FE4AE8E
	for <qemu-devel@nongnu.org>; Wed,  8 Aug 2018 14:19:03 +0000 (UTC)
From: Johannes Thumshirn <jthumshirn@suse.de>
Date: Wed,  8 Aug 2018 16:16:57 +0200
Message-Id: <20180808141700.21333-2-jthumshirn@suse.de>
In-Reply-To: <20180808141700.21333-1-jthumshirn@suse.de>
References: <20180808141700.21333-1-jthumshirn@suse.de>
Subject: [Qemu-devel] [PATCH 1/4] Add MEN Chameleon Bus emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Johannes Thumshirn <jthumshirn@suse.de>

The MEN Chameleon Bus (MCB) is an on-chip bus system exposing IP Cores of an
FPGA to a outside bus system like PCIe.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 default-configs/pci.mak |   1 +
 hw/Makefile.objs        |   1 +
 hw/mcb/Makefile.objs    |   1 +
 hw/mcb/mcb.c            | 180 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/mcb/mcb.h    | 104 ++++++++++++++++++++++++++++
 5 files changed, 287 insertions(+)
 create mode 100644 hw/mcb/Makefile.objs
 create mode 100644 hw/mcb/mcb.c
 create mode 100644 include/hw/mcb/mcb.h

diff --git a/default-configs/pci.mak b/default-configs/pci.mak
index de53d20ac62c..341498615d6e 100644
--- a/default-configs/pci.mak
+++ b/default-configs/pci.mak
@@ -46,3 +46,4 @@ CONFIG_VGA=y
 CONFIG_VGA_PCI=y
 CONFIG_IVSHMEM_DEVICE=$(CONFIG_IVSHMEM)
 CONFIG_ROCKER=y
+CONFIG_MCB=y
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index a19c1417ed3e..96ab195a24b9 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -17,6 +17,7 @@ devices-dirs-$(CONFIG_IPACK) += ipack/
 devices-dirs-$(CONFIG_IPMI) += ipmi/
 devices-dirs-$(CONFIG_SOFTMMU) += isa/
 devices-dirs-$(CONFIG_SOFTMMU) += misc/
+devices-dirs-$(CONFIG_MCB) += mcb/
 devices-dirs-$(CONFIG_SOFTMMU) += net/
 devices-dirs-$(CONFIG_SOFTMMU) += rdma/
 devices-dirs-$(CONFIG_SOFTMMU) += nvram/
diff --git a/hw/mcb/Makefile.objs b/hw/mcb/Makefile.objs
new file mode 100644
index 000000000000..32427c987c44
--- /dev/null
+++ b/hw/mcb/Makefile.objs
@@ -0,0 +1 @@
+common-obj-$(CONFIG_MCB) += mcb.o
diff --git a/hw/mcb/mcb.c b/hw/mcb/mcb.c
new file mode 100644
index 000000000000..36f2688b0803
--- /dev/null
+++ b/hw/mcb/mcb.c
@@ -0,0 +1,180 @@
+/*
+ * QEMU MEN Chameleon Bus emulation
+ *
+ * Copyright (C) 2016 Johannes Thumshirn <morbidrsa@gmail.com>
+ *
+ * This code is licensed under the GNU GPL v2 or (at your opinion) any
+ * later version
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/mcb/mcb.h"
+
+ChameleonDeviceDescriptor *mcb_new_chameleon_descriptor(MCBus *bus, uint8_t id,
+                                                        uint8_t rev,
+                                                        uint8_t var,
+                                                        uint32_t size)
+{
+    BusChild *kid;
+    ChameleonDeviceDescriptor *gdd;
+    uint32_t reg1 = 0;
+    uint32_t offset = 0x200;
+    uint32_t end = 0;
+
+    gdd =  g_new0(ChameleonDeviceDescriptor, 1);
+    if (!gdd) {
+        return NULL;
+    }
+
+    reg1 |= GDD_DEV(id);
+    reg1 |= GDD_DTY(CHAMELEON_DTYPE_GENERAL);
+    reg1 |= GDD_REV(rev);
+    reg1 |= GDD_VAR(var);
+    gdd->reg1 = cpu_to_le32(reg1);
+
+    QTAILQ_FOREACH(kid, &BUS(bus)->children, sibling) {
+        DeviceState *qdev = kid->child;
+        MCBDevice *mdev = MCB_DEVICE(qdev);
+
+        if (mdev->gdd) {
+            offset = mdev->gdd->offset;
+            end = offset + mdev->gdd->size;
+        }
+    }
+
+    gdd->offset = offset + end;
+    gdd->size = size;
+
+    return gdd;
+}
+
+static void mcb_irq_handler(void *opaque, int irq_num, int level)
+{
+    MCBDevice *dev = opaque;
+    MCBus *bus = MCB_BUS(qdev_get_parent_bus(DEVICE(dev)));
+
+    if (bus->set_irq) {
+        bus->set_irq(dev, irq_num, level);
+    }
+}
+
+qemu_irq mcb_allocate_irq(MCBDevice *dev)
+{
+    int irq = 0;
+    return qemu_allocate_irq(mcb_irq_handler, dev, irq);
+}
+
+MCBDevice *mcb_device_find(MCBus *bus, hwaddr addr)
+{
+    BusChild *kid;
+    uint32_t start;
+    uint32_t end;
+
+    QTAILQ_FOREACH(kid, &BUS(bus)->children, sibling) {
+        DeviceState *qdev = kid->child;
+        MCBDevice *mdev = MCB_DEVICE(qdev);
+
+        start = mdev->gdd->offset;
+        end = start + mdev->gdd->size;
+
+        if (addr >= start && addr <= end) {
+            return mdev;
+        }
+    }
+    return NULL;
+}
+
+void mcb_bus_new_inplace(MCBus *bus, size_t bus_size,
+                         DeviceState *parent,
+                         const char *name, uint8_t slots,
+                         qemu_irq_handler handler)
+{
+    qbus_create_inplace(bus, bus_size, TYPE_MCB_BUS, parent, name);
+    bus->n_slots = slots;
+    bus->set_irq = handler;
+}
+
+static void mcb_device_realize(DeviceState *dev, Error **errp)
+{
+    MCBDevice *mdev = MCB_DEVICE(dev);
+    MCBus *bus = MCB_BUS(qdev_get_parent_bus(dev));
+    MCBDeviceClass *k = MCB_DEVICE_GET_CLASS(dev);
+
+    if (mdev->slot < 0) {
+        mdev->slot = bus->free_slot;
+    }
+
+    if (mdev->slot >= bus->n_slots) {
+        error_setg(errp, "Only %" PRIu8 " slots available.", bus->n_slots);
+        return;
+    }
+    bus->free_slot = mdev->slot + 1;
+
+    mdev->irq = qemu_allocate_irqs(bus->set_irq, mdev, 1);
+
+    k->realize(dev, errp);
+}
+
+static void mcb_device_unrealize(DeviceState *dev, Error **errp)
+{
+    MCBDevice *mdev = MCB_DEVICE(dev);
+    MCBDeviceClass *k = MCB_DEVICE_GET_CLASS(dev);
+    Error *err = NULL;
+
+    if (k->unrealize) {
+        k->unrealize(dev, &err);
+        error_propagate(errp, err);
+        return;
+    }
+
+    qemu_free_irqs(mdev->irq, 1);
+}
+
+static Property mcb_device_props[] = {
+    DEFINE_PROP_INT32("slot", MCBDevice, slot, -1),
+    DEFINE_PROP_END_OF_LIST()
+};
+
+static void mcb_device_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *k = DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_INPUT, k->categories);
+    k->bus_type = TYPE_MCB_BUS;
+    k->realize = mcb_device_realize;
+    k->unrealize = mcb_device_unrealize;
+    k->props = mcb_device_props;
+}
+
+const VMStateDescription vmstate_mcb_device = {
+    .name = "mcb_device",
+    .version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_INT32(slot, MCBDevice),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const TypeInfo mcb_device_info = {
+    .name = TYPE_MCB_DEVICE,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(MCBDevice),
+    .class_size = sizeof(MCBDeviceClass),
+    .class_init = mcb_device_class_init,
+    .abstract = true,
+};
+
+static const TypeInfo mcb_bus_info = {
+    .name = TYPE_MCB_BUS,
+    .parent = TYPE_BUS,
+    .instance_size = sizeof(MCBus),
+};
+
+static void mcb_register_types(void)
+{
+    type_register_static(&mcb_device_info);
+    type_register_static(&mcb_bus_info);
+}
+
+type_init(mcb_register_types);
diff --git a/include/hw/mcb/mcb.h b/include/hw/mcb/mcb.h
new file mode 100644
index 000000000000..64a425b24f8c
--- /dev/null
+++ b/include/hw/mcb/mcb.h
@@ -0,0 +1,104 @@
+/*
+ * QEMU MEN Chameleon Bus emulation
+ *
+ * Copyright (C) 2016 Johannes Thumshirn <jthumshirn@suse.de>
+ *
+ * This code is licensed under the GNU GPL v2 or (at your opinion) any
+ * later version
+ */
+
+#ifndef QEMU_MCB_H
+#define QEMU_MCB_H
+
+#include "hw/qdev.h"
+
+#define CHAMELEON_DTYPE_GENERAL  0x0
+#define CHAMELEON_DTYPE_END 0xf
+
+typedef struct {
+    uint32_t reg1;
+    uint32_t reg2;
+    uint32_t offset;
+    uint32_t size;
+} ChameleonDeviceDescriptor;
+
+#define GDD_DEV(x) (((x) & 0x3ff) << 18)
+#define GDD_DTY(x) (((x) & 0xf) << 28)
+#define GDD_REV(x) (((x) & 0x3f) << 5)
+#define GDD_VAR(x) (((x) & 0x3f) << 11)
+
+/* GDD Register 1 fields */
+#define GDD_IRQ(x) ((x) & 0x1f)
+
+/* GDD Register 2 fields */
+#define GDD_BAR(x) ((x) & 0x7)
+#define GDD_INS(x) (((x) >> 3) & 0x3f)
+#define GDD_GRP(x) (((x) >> 9) & 0x3f)
+
+typedef struct MCBus MCBus;
+
+#define TYPE_MCB_BUS "MEN Chameleon Bus"
+#define MCB_BUS(obj) OBJECT_CHECK(MCBus, (obj), TYPE_MCB_BUS)
+
+struct MCBus {
+    /*< private >*/
+    BusState parent_obj;
+
+    uint8_t n_slots;
+    uint8_t free_slot;
+    qemu_irq_handler set_irq;
+    MemoryRegion mmio_region;
+};
+
+typedef struct MCBDevice MCBDevice;
+typedef struct MCBDeviceClass MCBDeviceClass;
+
+#define TYPE_MCB_DEVICE "mcb-device"
+#define MCB_DEVICE(obj) \
+    OBJECT_CHECK(MCBDevice, (obj), TYPE_MCB_DEVICE)
+#define MCB_DEVICE_CLASS(klass) \
+    OBJECT_CLASS_CHECK(MCBDeviceClass, (klass), TYPE_MCB_DEVICE)
+#define MCB_DEVICE_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(MCBDeviceClass, (obj), TYPE_MCB_DEVICE)
+
+struct MCBDeviceClass {
+    /*< private >*/
+    DeviceClass parent_class;
+    /*< public >*/
+
+
+    DeviceRealize realize;
+    DeviceUnrealize unrealize;
+};
+
+struct MCBDevice {
+    /*< private >*/
+    DeviceState parent_obj;
+    /*< public >*/
+
+    qemu_irq *irq;
+    ChameleonDeviceDescriptor *gdd;
+    int slot;
+
+    uint8_t rev;
+    uint8_t var;
+};
+
+extern const VMStateDescription vmstate_mcb_device;
+
+ChameleonDeviceDescriptor *mcb_new_chameleon_descriptor(MCBus *bus, uint8_t id,
+                                                        uint8_t rev,
+                                                        uint8_t var,
+                                                        uint32_t size);
+
+#define VMSTATE_MCB_DEVICE(_field, _state)      \
+    VMSTATE_STRUCT(_field, _state, 1, vmstate_mcb_device, MCBDevice)
+
+MCBDevice *mcb_device_find(MCBus *bus, hwaddr addr);
+void mcb_bus_new_inplace(MCBus *bus, size_t bus_size,
+                         DeviceState *parent,
+                         const char *name, uint8_t slots,
+                         qemu_irq_handler handler);
+
+qemu_irq mcb_allocate_irq(MCBDevice *dev);
+#endif
-- 
2.16.4
