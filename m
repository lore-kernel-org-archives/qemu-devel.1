Received: from eggs.gnu.org ([2001:4830:134:3::10]:55202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jthumshirn@suse.de>) id 1fnjLq-00013e-Pn
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:43:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jthumshirn@suse.de>) id 1fnjLo-0005T3-8Q
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:43:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:42794 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jthumshirn@suse.de>) id 1fnjLn-0005Rc-Ta
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:43:32 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id B983DAED0
	for <qemu-devel@nongnu.org>; Thu,  9 Aug 2018 11:43:30 +0000 (UTC)
From: Johannes Thumshirn <jthumshirn@suse.de>
Date: Thu,  9 Aug 2018 13:40:16 +0200
Message-Id: <20180809114017.16643-4-jthumshirn@suse.de>
In-Reply-To: <20180809114017.16643-1-jthumshirn@suse.de>
References: <20180809114017.16643-1-jthumshirn@suse.de>
Subject: [Qemu-devel] [PATCH v2 3/4] serial-mcb: Add serial via MEN
 chameleon bus
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

Add MEN z125 UART over MEN Chameleon Bus emulation.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 hw/char/Makefile.objs |   1 +
 hw/char/serial-mcb.c  | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100644 hw/char/serial-mcb.c

diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
index b57053129107..063f1720974d 100644
--- a/hw/char/Makefile.objs
+++ b/hw/char/Makefile.objs
@@ -6,6 +6,7 @@ common-obj-$(CONFIG_PL011) += pl011.o
 common-obj-$(CONFIG_SERIAL) += serial.o
 common-obj-$(CONFIG_SERIAL_ISA) += serial-isa.o
 common-obj-$(CONFIG_SERIAL_PCI) += serial-pci.o
+common-obj-$(CONFIG_MCB) += serial-mcb.o
 common-obj-$(CONFIG_VIRTIO_SERIAL) += virtio-console.o
 common-obj-$(CONFIG_XILINX) += xilinx_uartlite.o
 common-obj-$(CONFIG_XEN) += xen_console.o
diff --git a/hw/char/serial-mcb.c b/hw/char/serial-mcb.c
new file mode 100644
index 000000000000..5e1ef27815c6
--- /dev/null
+++ b/hw/char/serial-mcb.c
@@ -0,0 +1,100 @@
+/*
+ * QEMU MEN 16z125 UART over MCB emulation
+ *
+ * Copyright (C) 2016 - 2018 Johannes Thumshirn <jth@kernel.org>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/char/serial.h"
+#include "hw/mcb/mcb.h"
+
+typedef struct {
+    /*< private >*/
+    MCBDevice dev;
+    /*< public >*/
+
+    SerialState state;
+} MCBSerialState;
+
+static void serial_mcb_realize(DeviceState *dev, Error **errp)
+{
+    MCBDevice *mdev = MCB_DEVICE(dev);
+    MCBSerialState *mss = DO_UPCAST(MCBSerialState, dev, mdev);
+    MCBus *bus = MCB_BUS(qdev_get_parent_bus(DEVICE(dev)));
+    SerialState *s = &mss->state;
+    Error *err = 0;
+
+    mdev->gdd = mcb_new_chameleon_descriptor(bus, 125, mdev->rev,
+                                             mdev->var, 0x10);
+    if (!mdev->gdd) {
+        return;
+    }
+
+    s->baudbase = 115200;
+    serial_realize_core(s, &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    s->irq = mcb_allocate_irq(&mss->dev);
+    memory_region_init_io(&s->io, OBJECT(mss), &serial_io_ops, s, "serial", 8);
+    memory_region_add_subregion(&bus->mmio_region, mdev->gdd->offset, &s->io);
+}
+
+static void serial_mcb_unrealize(DeviceState *dev, Error **errp)
+{
+    MCBDevice *mdev = MCB_DEVICE(dev);
+
+    g_free(&mdev->gdd);
+}
+
+static const VMStateDescription vmstate_mcb_serial = {
+    .name = "mcb-serial",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_MCB_DEVICE(dev, MCBSerialState),
+        VMSTATE_STRUCT(state, MCBSerialState, 0, vmstate_serial, SerialState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property serial_mcb_properties[] = {
+    DEFINE_PROP_CHR("chardev", MCBSerialState, state.chr),
+    DEFINE_PROP_UINT8("rev", MCBSerialState, dev.rev, 0),
+    DEFINE_PROP_UINT8("var", MCBSerialState, dev.var, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void serial_mcb_class_initfn(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    MCBDeviceClass *mc = MCB_DEVICE_CLASS(klass);
+
+    mc->realize = serial_mcb_realize;
+    mc->unrealize = serial_mcb_unrealize;
+
+    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
+    dc->desc = "MEN 16z125 UART over MCB";
+    dc->vmsd = &vmstate_mcb_serial;
+    dc->props = serial_mcb_properties;
+}
+
+static const TypeInfo serial_mcb_info = {
+    .name = "mcb-serial",
+    .parent = TYPE_MCB_DEVICE,
+    .instance_size = sizeof(MCBSerialState),
+    .class_init = serial_mcb_class_initfn,
+};
+
+static void serial_mcb_register_types(void)
+{
+    type_register_static(&serial_mcb_info);
+}
+
+type_init(serial_mcb_register_types);
-- 
2.16.4
