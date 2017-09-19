Received: from eggs.gnu.org ([2001:4830:134:3::10]:42184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1duEK9-0001so-8e
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 04:56:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1duEK5-0008HC-C7
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 04:56:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1duEK5-0008GL-3v
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 04:56:05 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 19 Sep 2017 10:55:53 +0200
Message-Id: <1505811353-29151-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [RFC PATCH] qdev: Mark devices as non-hotpluggable by
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Xiao Guangrong <guangrong.xiao@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>

Historically we've marked all devices as hotpluggable by default. However,
most devices are not hotpluggable, and you also need a HotplugHandler to
support these devices. So if the user tries to "device_add" or "device_del"
such a non-hotpluggable device during runtime, either nothing really usable
happens, or QEMU even crashes/aborts unexpectedly (see for example commit
84ebd3e8c7d4fe955b - "Mark diag288 watchdog as non-hotpluggable").
So let's change this dangerous default behaviour and mark the devices as
non-hotpluggable by default. Certain parent devices classes which are known
as hotpluggable (e.g. PCI, USB, etc.) are marked with "hotpluggable = true",
so that devices that are derived from these classes continue to work as
expected.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Note: I've marked the patch as RFC since I'm not 100% sure whether I've
 correctly identified all devices that should still be marked as hot-
 pluggable. Feedback is welcome!

 hw/core/qdev.c        | 10 ++++------
 hw/cpu/core.c         |  1 +
 hw/mem/nvdimm.c       |  3 +++
 hw/mem/pc-dimm.c      |  1 +
 hw/pci/pci.c          |  1 +
 hw/s390x/ccw-device.c |  1 +
 hw/scsi/scsi-bus.c    |  1 +
 hw/usb/bus.c          |  1 +
 8 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 606ab53..c4f1902 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -1120,13 +1120,11 @@ static void device_class_init(ObjectClass *class, void *data)
     dc->realize = device_realize;
     dc->unrealize = device_unrealize;
 
-    /* by default all devices were considered as hotpluggable,
-     * so with intent to check it in generic qdev_unplug() /
-     * device_set_realized() functions make every device
-     * hotpluggable. Devices that shouldn't be hotpluggable,
-     * should override it in their class_init()
+    /*
+     * All devices are considered as cold-pluggable by default. The devices
+     * that are hotpluggable should override it in their class_init().
      */
-    dc->hotpluggable = true;
+    dc->hotpluggable = false;
     dc->user_creatable = true;
 }
 
diff --git a/hw/cpu/core.c b/hw/cpu/core.c
index bd578ab..01660aa 100644
--- a/hw/cpu/core.c
+++ b/hw/cpu/core.c
@@ -82,6 +82,7 @@ static void cpu_core_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     set_bit(DEVICE_CATEGORY_CPU, dc->categories);
+    dc->hotpluggable = true;
 }
 
 static const TypeInfo cpu_core_type_info = {
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 952fce5..02be9f3 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -148,9 +148,12 @@ static MemoryRegion *nvdimm_get_vmstate_memory_region(PCDIMMDevice *dimm)
 
 static void nvdimm_class_init(ObjectClass *oc, void *data)
 {
+    DeviceClass *dc = DEVICE_CLASS(oc);
     PCDIMMDeviceClass *ddc = PC_DIMM_CLASS(oc);
     NVDIMMClass *nvc = NVDIMM_CLASS(oc);
 
+    dc->hotpluggable = true;
+
     ddc->realize = nvdimm_realize;
     ddc->get_memory_region = nvdimm_get_memory_region;
     ddc->get_vmstate_memory_region = nvdimm_get_vmstate_memory_region;
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 66eace5..1f78567 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -443,6 +443,7 @@ static void pc_dimm_class_init(ObjectClass *oc, void *data)
     dc->unrealize = pc_dimm_unrealize;
     dc->props = pc_dimm_properties;
     dc->desc = "DIMM memory module";
+    dc->hotpluggable = true;
 
     ddc->get_memory_region = pc_dimm_get_memory_region;
     ddc->get_vmstate_memory_region = pc_dimm_get_vmstate_memory_region;
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 1e6fb88..8db380d 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2534,6 +2534,7 @@ static void pci_device_class_init(ObjectClass *klass, void *data)
     k->unrealize = pci_qdev_unrealize;
     k->bus_type = TYPE_PCI_BUS;
     k->props = pci_props;
+    k->hotpluggable = true;
     pc->realize = pci_default_realize;
 }
 
diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
index f9bfa15..d1b6e6f 100644
--- a/hw/s390x/ccw-device.c
+++ b/hw/s390x/ccw-device.c
@@ -48,6 +48,7 @@ static void ccw_device_class_init(ObjectClass *klass, void *data)
     k->realize = ccw_device_realize;
     k->refill_ids = ccw_device_refill_ids;
     dc->props = ccw_device_properties;
+    dc->hotpluggable = true;
 }
 
 const VMStateDescription vmstate_ccw_dev = {
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index e364410..338180d 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -2123,6 +2123,7 @@ static void scsi_device_class_init(ObjectClass *klass, void *data)
     k->realize   = scsi_qdev_realize;
     k->unrealize = scsi_qdev_unrealize;
     k->props     = scsi_props;
+    k->hotpluggable = true;
 }
 
 static void scsi_dev_instance_init(Object *obj)
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index d910f84..16701aa 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -793,6 +793,7 @@ static void usb_device_class_init(ObjectClass *klass, void *data)
     k->realize  = usb_qdev_realize;
     k->unrealize = usb_qdev_unrealize;
     k->props    = usb_props;
+    k->hotpluggable = true;
 }
 
 static const TypeInfo usb_device_type_info = {
-- 
1.8.3.1
