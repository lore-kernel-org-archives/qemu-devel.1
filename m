Received: from eggs.gnu.org ([2001:4830:134:3::10]:55248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fhgYp-0003vk-5C
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 15:32:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fhgYn-0001JS-Us
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 15:31:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61149)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fhgYn-0001JA-Mx
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 15:31:57 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 23 Jul 2018 16:31:44 -0300
Message-Id: <20180723193145.24705-2-ehabkost@redhat.com>
In-Reply-To: <20180723193145.24705-1-ehabkost@redhat.com>
References: <20180723193145.24705-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1 1/2] acpi: Improve acpi_send_event()
 type safety
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Ben Warren <ben@skyportsystems.com>, "Michael S. Tsirkin" <mst@redhat.com>

acpi_send_event() requires an object that implements
TYPE_ACPI_DEVICE_IF.  Indicate that in the function prototype.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/acpi/acpi_dev_interface.h | 2 +-
 hw/acpi/acpi_interface.c             | 5 ++---
 hw/acpi/cpu.c                        | 4 ++--
 hw/acpi/cpu_hotplug.c                | 2 +-
 hw/acpi/memory_hotplug.c             | 4 ++--
 hw/acpi/nvdimm.c                     | 2 +-
 hw/acpi/pcihp.c                      | 4 ++--
 hw/acpi/vmgenid.c                    | 2 +-
 8 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
index dabf4c4fc9..bab71f9d60 100644
--- a/include/hw/acpi/acpi_dev_interface.h
+++ b/include/hw/acpi/acpi_dev_interface.h
@@ -31,7 +31,7 @@ typedef struct AcpiDeviceIf {
     Object Parent;
 } AcpiDeviceIf;
 
-void acpi_send_event(DeviceState *dev, AcpiEventStatusBits event);
+void acpi_send_event(AcpiDeviceIf *dev, AcpiEventStatusBits event);
 
 /**
  * AcpiDeviceIfClass:
diff --git a/hw/acpi/acpi_interface.c b/hw/acpi/acpi_interface.c
index 6583917b8e..f9b538293e 100644
--- a/hw/acpi/acpi_interface.c
+++ b/hw/acpi/acpi_interface.c
@@ -2,12 +2,11 @@
 #include "hw/acpi/acpi_dev_interface.h"
 #include "qemu/module.h"
 
-void acpi_send_event(DeviceState *dev, AcpiEventStatusBits event)
+void acpi_send_event(AcpiDeviceIf *dev, AcpiEventStatusBits event)
 {
     AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(dev);
     if (adevc->send_event) {
-        AcpiDeviceIf *adev = ACPI_DEVICE_IF(dev);
-        adevc->send_event(adev, event);
+        adevc->send_event(dev, event);
     }
 }
 
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 5ae595ecbe..2eb9b5a032 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -233,7 +233,7 @@ void acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
     cdev->cpu = CPU(dev);
     if (dev->hotplugged) {
         cdev->is_inserting = true;
-        acpi_send_event(DEVICE(hotplug_dev), ACPI_CPU_HOTPLUG_STATUS);
+        acpi_send_event(ACPI_DEVICE_IF(hotplug_dev), ACPI_CPU_HOTPLUG_STATUS);
     }
 }
 
@@ -249,7 +249,7 @@ void acpi_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
     }
 
     cdev->is_removing = true;
-    acpi_send_event(DEVICE(hotplug_dev), ACPI_CPU_HOTPLUG_STATUS);
+    acpi_send_event(ACPI_DEVICE_IF(hotplug_dev), ACPI_CPU_HOTPLUG_STATUS);
 }
 
 void acpi_cpu_unplug_cb(CPUHotplugState *cpu_st,
diff --git a/hw/acpi/cpu_hotplug.c b/hw/acpi/cpu_hotplug.c
index 5243918125..5a1599796b 100644
--- a/hw/acpi/cpu_hotplug.c
+++ b/hw/acpi/cpu_hotplug.c
@@ -79,7 +79,7 @@ void legacy_acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
     if (*errp != NULL) {
         return;
     }
-    acpi_send_event(DEVICE(hotplug_dev), ACPI_CPU_HOTPLUG_STATUS);
+    acpi_send_event(ACPI_DEVICE_IF(hotplug_dev), ACPI_CPU_HOTPLUG_STATUS);
 }
 
 void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent, Object *owner,
diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index 0ff1712c4c..24b2aa0301 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -280,7 +280,7 @@ void acpi_memory_plug_cb(HotplugHandler *hotplug_dev, MemHotplugState *mem_st,
     mdev->is_enabled = true;
     if (dev->hotplugged) {
         mdev->is_inserting = true;
-        acpi_send_event(DEVICE(hotplug_dev), ACPI_MEMORY_HOTPLUG_STATUS);
+        acpi_send_event(ACPI_DEVICE_IF(hotplug_dev), ACPI_MEMORY_HOTPLUG_STATUS);
     }
 }
 
@@ -296,7 +296,7 @@ void acpi_memory_unplug_request_cb(HotplugHandler *hotplug_dev,
     }
 
     mdev->is_removing = true;
-    acpi_send_event(DEVICE(hotplug_dev), ACPI_MEMORY_HOTPLUG_STATUS);
+    acpi_send_event(ACPI_DEVICE_IF(hotplug_dev), ACPI_MEMORY_HOTPLUG_STATUS);
 }
 
 void acpi_memory_unplug_cb(MemHotplugState *mem_st,
diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 27eeb6609f..bdc373696d 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -921,7 +921,7 @@ static const MemoryRegionOps nvdimm_dsm_ops = {
 void nvdimm_acpi_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev)
 {
     if (dev->hotplugged) {
-        acpi_send_event(DEVICE(hotplug_dev), ACPI_NVDIMM_HOTPLUG_STATUS);
+        acpi_send_event(ACPI_DEVICE_IF(hotplug_dev), ACPI_NVDIMM_HOTPLUG_STATUS);
     }
 }
 
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 80d42e12ff..b3bb11dac5 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -237,7 +237,7 @@ void acpi_pcihp_device_plug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
     }
 
     s->acpi_pcihp_pci_status[bsel].up |= (1U << slot);
-    acpi_send_event(DEVICE(hotplug_dev), ACPI_PCI_HOTPLUG_STATUS);
+    acpi_send_event(ACPI_DEVICE_IF(hotplug_dev), ACPI_PCI_HOTPLUG_STATUS);
 }
 
 void acpi_pcihp_device_unplug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
@@ -253,7 +253,7 @@ void acpi_pcihp_device_unplug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
     }
 
     s->acpi_pcihp_pci_status[bsel].down |= (1U << slot);
-    acpi_send_event(DEVICE(hotplug_dev), ACPI_PCI_HOTPLUG_STATUS);
+    acpi_send_event(ACPI_DEVICE_IF(hotplug_dev), ACPI_PCI_HOTPLUG_STATUS);
 }
 
 static uint64_t pci_read(void *opaque, hwaddr addr, unsigned int size)
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index d78b579a20..74caedde79 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -158,7 +158,7 @@ static void vmgenid_update_guest(VmGenIdState *vms)
             cpu_physical_memory_write(vmgenid_addr, guid_le.data,
                                       sizeof(guid_le.data));
             /* Send _GPE.E05 event */
-            acpi_send_event(DEVICE(obj), ACPI_VMGENID_CHANGE_STATUS);
+            acpi_send_event(ACPI_DEVICE_IF(obj), ACPI_VMGENID_CHANGE_STATUS);
         }
     }
 }
-- 
2.18.0.rc1.1.g3f1ff2140
