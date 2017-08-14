Received: from eggs.gnu.org ([2001:4830:134:3::10]:42820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dhNNS-0001ei-Fl
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dhNNP-0002M4-BC
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:58:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dhNNP-0002LT-1q
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:58:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E16C7F3FBD
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 21:58:21 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 14 Aug 2017 18:57:38 -0300
Message-Id: <20170814215748.5158-4-ehabkost@redhat.com>
In-Reply-To: <20170814215748.5158-1-ehabkost@redhat.com>
References: <20170814215748.5158-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC v4 03/13] qdev: Add BusClass::device_type field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Laine Stump <laine@redhat.com>

The field will be useful when building device slot information
for buses.

TODO: Confirm if all bus types were handled by the patch.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/qdev-core.h        |  3 +++
 hw/audio/intel-hda.c          |  7 +++++++
 hw/block/fdc.c                | 15 +++++++++++----
 hw/char/virtio-serial-bus.c   |  1 +
 hw/core/sysbus.c              |  1 +
 hw/i2c/core.c                 |  7 +++++++
 hw/ide/qdev.c                 |  1 +
 hw/input/adb.c                |  7 +++++++
 hw/ipack/ipack.c              |  7 +++++++
 hw/isa/isa-bus.c              |  1 +
 hw/misc/auxbus.c              |  1 +
 hw/pci/pci.c                  |  1 +
 hw/ppc/spapr_vio.c            |  1 +
 hw/s390x/css-bridge.c         |  2 ++
 hw/s390x/event-facility.c     |  1 +
 hw/s390x/s390-pci-bus.c       |  7 +++++++
 hw/scsi/scsi-bus.c            |  1 +
 hw/sd/core.c                  |  7 +++++++
 hw/ssi/ssi.c                  |  7 +++++++
 hw/usb/bus.c                  |  1 +
 hw/usb/dev-smartcard-reader.c |  7 +++++++
 hw/virtio/virtio-bus.c        |  1 +
 22 files changed, 83 insertions(+), 4 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 0111350..8aa1455 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -198,6 +198,9 @@ struct BusClass {
     int max_dev;
     /* number of automatically allocated bus ids (e.g. ide.0) */
     int automatic_ids;
+
+    /* Device type accepted by bus */
+    const char *device_type;
 };
 
 typedef struct BusChild {
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 06acc98..13b6904 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -36,9 +36,16 @@ static Property hda_props[] = {
     DEFINE_PROP_END_OF_LIST()
 };
 
+static void hda_codec_bus_class_init(ObjectClass *oc, void *opaque)
+{
+    BusClass *bc = BUS_CLASS(oc);
+    bc->device_type = TYPE_HDA_CODEC_DEVICE;
+}
+
 static const TypeInfo hda_codec_bus_info = {
     .name = TYPE_HDA_BUS,
     .parent = TYPE_BUS,
+    .class_init = hda_codec_bus_class_init,
     .instance_size = sizeof(HDACodecBus),
 };
 
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 4011290..976500f 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -60,6 +60,10 @@
 #define TYPE_FLOPPY_BUS "floppy-bus"
 #define FLOPPY_BUS(obj) OBJECT_CHECK(FloppyBus, (obj), TYPE_FLOPPY_BUS)
 
+#define TYPE_FLOPPY_DRIVE "floppy"
+#define FLOPPY_DRIVE(obj) \
+     OBJECT_CHECK(FloppyDrive, (obj), TYPE_FLOPPY_DRIVE)
+
 typedef struct FDCtrl FDCtrl;
 typedef struct FDrive FDrive;
 static FDrive *get_drv(FDCtrl *fdctrl, int unit);
@@ -69,9 +73,16 @@ typedef struct FloppyBus {
     FDCtrl *fdc;
 } FloppyBus;
 
+static void floppy_bus_class_init(ObjectClass *oc, void *opaque)
+{
+    BusClass *bc = BUS_CLASS(oc);
+    bc->device_type = TYPE_FLOPPY_DRIVE;
+}
+
 static const TypeInfo floppy_bus_info = {
     .name = TYPE_FLOPPY_BUS,
     .parent = TYPE_BUS,
+    .class_init = floppy_bus_class_init,
     .instance_size = sizeof(FloppyBus),
 };
 
@@ -497,10 +508,6 @@ static const BlockDevOps fd_block_ops = {
 };
 
 
-#define TYPE_FLOPPY_DRIVE "floppy"
-#define FLOPPY_DRIVE(obj) \
-     OBJECT_CHECK(FloppyDrive, (obj), TYPE_FLOPPY_DRIVE)
-
 typedef struct FloppyDrive {
     DeviceState     qdev;
     uint32_t        unit;
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index f5bc173..28342af 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -837,6 +837,7 @@ static void virtser_bus_class_init(ObjectClass *klass, void *data)
 {
     BusClass *k = BUS_CLASS(klass);
     k->print_dev = virtser_bus_dev_print;
+    k->device_type = TYPE_VIRTIO_SERIAL_PORT;
 }
 
 static const TypeInfo virtser_bus_info = {
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 5d0887f..9259931 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -76,6 +76,7 @@ static void system_bus_class_init(ObjectClass *klass, void *data)
 
     k->print_dev = sysbus_dev_print;
     k->get_fw_dev_path = sysbus_get_fw_dev_path;
+    k->device_type = TYPE_SYS_BUS_DEVICE;
 }
 
 static const TypeInfo system_bus_info = {
diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index 2c1234c..fb5aaad 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -35,9 +35,16 @@ static Property i2c_props[] = {
 #define TYPE_I2C_BUS "i2c-bus"
 #define I2C_BUS(obj) OBJECT_CHECK(I2CBus, (obj), TYPE_I2C_BUS)
 
+static void i2c_bus_class_init(ObjectClass *oc, void *opaque)
+{
+    BusClass *bc = BUS_CLASS(oc);
+    bc->device_type = TYPE_I2C_SLAVE;
+}
+
 static const TypeInfo i2c_bus_info = {
     .name = TYPE_I2C_BUS,
     .parent = TYPE_BUS,
+    .class_init = i2c_bus_class_init,
     .instance_size = sizeof(I2CBus),
 };
 
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index cc2f5bd..f17da1f 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -44,6 +44,7 @@ static void ide_bus_class_init(ObjectClass *klass, void *data)
 
     k->get_fw_dev_path = idebus_get_fw_dev_path;
     k->unrealize = idebus_unrealize;
+    k->device_type = TYPE_IDE_DEVICE;
 }
 
 static void idebus_unrealize(BusState *bus, Error **errp)
diff --git a/hw/input/adb.c b/hw/input/adb.c
index fcca3a8..2fc292c 100644
--- a/hw/input/adb.c
+++ b/hw/input/adb.c
@@ -121,9 +121,16 @@ int adb_poll(ADBBusState *s, uint8_t *obuf, uint16_t poll_mask)
     return olen;
 }
 
+static void adb_bus_class_init(ObjectClass *oc, void *opaque)
+{
+    BusClass *bc = BUS_CLASS(oc);
+    bc->device_type = TYPE_ADB_DEVICE;
+}
+
 static const TypeInfo adb_bus_type_info = {
     .name = TYPE_ADB_BUS,
     .parent = TYPE_BUS,
+    .class_init = adb_bus_class_init,
     .instance_size = sizeof(ADBBusState),
 };
 
diff --git a/hw/ipack/ipack.c b/hw/ipack/ipack.c
index 6021e6d..f22c504 100644
--- a/hw/ipack/ipack.c
+++ b/hw/ipack/ipack.c
@@ -106,9 +106,16 @@ static const TypeInfo ipack_device_info = {
     .abstract      = true,
 };
 
+static void ipack_bus_class_init(ObjectClass *oc, void *opaque)
+{
+    BusClass *bc = BUS_CLASS(oc);
+    bc->device_type = TYPE_IPACK_DEVICE;
+}
+
 static const TypeInfo ipack_bus_info = {
     .name = TYPE_IPACK_BUS,
     .parent = TYPE_BUS,
+    .class_init = ipack_bus_class_init,
     .instance_size = sizeof(IPackBus),
 };
 
diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index 348e0ea..45349c6 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -36,6 +36,7 @@ static void isa_bus_class_init(ObjectClass *klass, void *data)
 
     k->print_dev = isabus_dev_print;
     k->get_fw_dev_path = isabus_get_fw_dev_path;
+    k->device_type = TYPE_ISA_DEVICE;
 }
 
 static const TypeInfo isa_dma_info = {
diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
index 8a90ddd..7f4c87f 100644
--- a/hw/misc/auxbus.c
+++ b/hw/misc/auxbus.c
@@ -57,6 +57,7 @@ static void aux_bus_class_init(ObjectClass *klass, void *data)
      * in monitor.
      */
     k->print_dev = aux_slave_dev_print;
+    k->device_type = TYPE_AUX_SLAVE;
 }
 
 AUXBus *aux_init_bus(DeviceState *parent, const char *name)
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 258fbe5..31b4d69 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -154,6 +154,7 @@ static void pci_bus_class_init(ObjectClass *klass, void *data)
     k->realize = pci_bus_realize;
     k->unrealize = pci_bus_unrealize;
     k->reset = pcibus_reset;
+    k->device_type = TYPE_PCI_DEVICE;
 
     pbc->is_root = pcibus_is_root;
     pbc->bus_num = pcibus_num;
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index ea3bc8b..d07dcaa 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -61,6 +61,7 @@ static void spapr_vio_bus_class_init(ObjectClass *klass, void *data)
 
     k->get_dev_path = spapr_vio_get_dev_name;
     k->get_fw_dev_path = spapr_vio_get_dev_name;
+    k->device_type = TYPE_VIO_SPAPR_DEVICE;
 }
 
 static const TypeInfo spapr_vio_bus_info = {
diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index c4a9735..c442c23 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -17,6 +17,7 @@
 #include "hw/s390x/css.h"
 #include "ccw-device.h"
 #include "hw/s390x/css-bridge.h"
+#include "hw/s390x/virtio-ccw.h"
 #include "cpu.h"
 
 /*
@@ -82,6 +83,7 @@ static void virtual_css_bus_class_init(ObjectClass *klass, void *data)
 
     k->reset = virtual_css_bus_reset;
     k->get_dev_path = virtual_css_bus_get_dev_path;
+    k->device_type = TYPE_VIRTIO_CCW_DEVICE;
 }
 
 static const TypeInfo virtual_css_bus_info = {
diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 34b2faf..f2562ce 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -307,6 +307,7 @@ static void sclp_events_bus_class_init(ObjectClass *klass, void *data)
     BusClass *bc = BUS_CLASS(klass);
 
     bc->realize = sclp_events_bus_realize;
+    bc->device_type = TYPE_SCLP_EVENT;
 }
 
 static const TypeInfo sclp_events_bus_info = {
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 61cfd21..0d71d7e 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -888,10 +888,17 @@ static const TypeInfo s390_pcihost_info = {
     }
 };
 
+static void s390_pcibus_class_init(ObjectClass *oc, void *opaque)
+{
+    BusClass *bc = BUS_CLASS(oc);
+    bc->device_type = TYPE_S390_PCI_DEVICE;
+}
+
 static const TypeInfo s390_pcibus_info = {
     .name = TYPE_S390_PCI_BUS,
     .parent = TYPE_BUS,
     .instance_size = sizeof(S390PCIBus),
+    .class_init = s390_pcibus_class_init,
 };
 
 static uint16_t s390_pci_generate_uid(S390pciState *s)
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index e364410..181428f7 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -31,6 +31,7 @@ static void scsi_bus_class_init(ObjectClass *klass, void *data)
 
     k->get_dev_path = scsibus_get_dev_path;
     k->get_fw_dev_path = scsibus_get_fw_dev_path;
+    k->device_type = TYPE_SCSI_DEVICE;
     hc->unplug = qdev_simple_device_unplug_cb;
 }
 
diff --git a/hw/sd/core.c b/hw/sd/core.c
index 295dc44..5bfe404 100644
--- a/hw/sd/core.c
+++ b/hw/sd/core.c
@@ -158,11 +158,18 @@ void sdbus_reparent_card(SDBus *from, SDBus *to)
     sdbus_set_readonly(to, readonly);
 }
 
+static void sd_bus_class_init(ObjectClass *oc, void *opaque)
+{
+    BusClass *bc = BUS_CLASS(oc);
+    bc->device_type = TYPE_SD_CARD;
+}
+
 static const TypeInfo sd_bus_info = {
     .name = TYPE_SD_BUS,
     .parent = TYPE_BUS,
     .instance_size = sizeof(SDBus),
     .class_size = sizeof(SDBusClass),
+    .class_init = sd_bus_class_init,
 };
 
 static void sd_bus_register_types(void)
diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
index 7eaaf56..c48920d 100644
--- a/hw/ssi/ssi.c
+++ b/hw/ssi/ssi.c
@@ -22,10 +22,17 @@ struct SSIBus {
 #define TYPE_SSI_BUS "SSI"
 #define SSI_BUS(obj) OBJECT_CHECK(SSIBus, (obj), TYPE_SSI_BUS)
 
+static void ssi_bus_class_init(ObjectClass *oc, void *opaque)
+{
+    BusClass *bc = BUS_CLASS(oc);
+    bc->device_type = TYPE_SSI_SLAVE;
+}
+
 static const TypeInfo ssi_bus_info = {
     .name = TYPE_SSI_BUS,
     .parent = TYPE_BUS,
     .instance_size = sizeof(SSIBus),
+    .class_init = ssi_bus_class_init,
 };
 
 static void ssi_cs_default(void *opaque, int n, int level)
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index d910f84..42f85a7 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -33,6 +33,7 @@ static void usb_bus_class_init(ObjectClass *klass, void *data)
     k->print_dev = usb_bus_dev_print;
     k->get_dev_path = usb_get_dev_path;
     k->get_fw_dev_path = usb_get_fw_dev_path;
+    k->device_type = TYPE_USB_DEVICE;
     hc->unplug = qdev_simple_device_unplug_cb;
 }
 
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index bef1f03..01aa804 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1195,10 +1195,17 @@ static Property ccid_props[] = {
 #define TYPE_CCID_BUS "ccid-bus"
 #define CCID_BUS(obj) OBJECT_CHECK(CCIDBus, (obj), TYPE_CCID_BUS)
 
+static void ccid_bus_class_init(ObjectClass *oc, void *opaque)
+{
+    BusClass *bc = BUS_CLASS(oc);
+    bc->device_type = TYPE_CCID_CARD;
+}
+
 static const TypeInfo ccid_bus_info = {
     .name = TYPE_CCID_BUS,
     .parent = TYPE_BUS,
     .instance_size = sizeof(CCIDBus),
+    .class_init = ccid_bus_class_init,
 };
 
 void ccid_card_send_apdu_to_guest(CCIDCardState *card,
diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index 3042232..76ce427 100644
--- a/hw/virtio/virtio-bus.c
+++ b/hw/virtio/virtio-bus.c
@@ -316,6 +316,7 @@ static void virtio_bus_class_init(ObjectClass *klass, void *data)
     BusClass *bus_class = BUS_CLASS(klass);
     bus_class->get_dev_path = virtio_bus_get_dev_path;
     bus_class->get_fw_dev_path = virtio_bus_get_fw_dev_path;
+    bus_class->device_type = TYPE_VIRTIO_DEVICE;
 }
 
 static const TypeInfo virtio_bus_info = {
-- 
2.9.4
