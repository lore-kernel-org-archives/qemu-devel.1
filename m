Received: from eggs.gnu.org ([2001:4830:134:3::10]:55259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fhgYs-0003xq-7i
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 15:32:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fhgYq-0001KO-59
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 15:32:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fhgYp-0001K3-Sg
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 15:32:00 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 23 Jul 2018 16:31:45 -0300
Message-Id: <20180723193145.24705-3-ehabkost@redhat.com>
In-Reply-To: <20180723193145.24705-1-ehabkost@redhat.com>
References: <20180723193145.24705-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1 2/2] acpi: Decouple ACPI hotplug
 callbacks from HotplugHandler
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

The ACPI hotplug callbacks get a HotplugHandler object as
argument.  This has two problems:

1) The functions require a TYPE_ACPI_DEVICE_IF object, but the
   function prototype doesn't indicate that.  It's possible to
   pass an object that would make the function crash.
2) The function does not require the object to implement
   TYPE_HOTPLUG_HANDLER at all, but the function prototype
   imposes that for no reason.

Change the argument type to AcpiDeviceIf instead of
HotplugHandler.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/acpi/cpu.h            |  5 ++---
 include/hw/acpi/cpu_hotplug.h    |  2 +-
 include/hw/acpi/memory_hotplug.h |  4 ++--
 include/hw/acpi/pcihp.h          |  4 ++--
 include/hw/mem/nvdimm.h          |  3 ++-
 hw/acpi/cpu.c                    |  8 ++++----
 hw/acpi/cpu_hotplug.c            |  4 ++--
 hw/acpi/ich9.c                   | 14 ++++++++------
 hw/acpi/memory_hotplug.c         |  8 ++++----
 hw/acpi/nvdimm.c                 |  4 ++--
 hw/acpi/pcihp.c                  |  8 ++++----
 hw/acpi/piix4.c                  | 18 ++++++++++--------
 12 files changed, 43 insertions(+), 39 deletions(-)

diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
index 89ce172941..3ae6504c24 100644
--- a/include/hw/acpi/cpu.h
+++ b/include/hw/acpi/cpu.h
@@ -15,7 +15,6 @@
 #include "hw/qdev-core.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
-#include "hw/hotplug.h"
 
 typedef struct AcpiCpuStatus {
     struct CPUState *cpu;
@@ -34,10 +33,10 @@ typedef struct CPUHotplugState {
     AcpiCpuStatus *devs;
 } CPUHotplugState;
 
-void acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
+void acpi_cpu_plug_cb(AcpiDeviceIf *acpi_dev,
                       CPUHotplugState *cpu_st, DeviceState *dev, Error **errp);
 
-void acpi_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
+void acpi_cpu_unplug_request_cb(AcpiDeviceIf *acpi_dev,
                                 CPUHotplugState *cpu_st,
                                 DeviceState *dev, Error **errp);
 
diff --git a/include/hw/acpi/cpu_hotplug.h b/include/hw/acpi/cpu_hotplug.h
index 3b932abbbb..8e663b0606 100644
--- a/include/hw/acpi/cpu_hotplug.h
+++ b/include/hw/acpi/cpu_hotplug.h
@@ -25,7 +25,7 @@ typedef struct AcpiCpuHotplug {
     uint8_t sts[ACPI_GPE_PROC_LEN];
 } AcpiCpuHotplug;
 
-void legacy_acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
+void legacy_acpi_cpu_plug_cb(AcpiDeviceIf *acpi_dev,
                              AcpiCpuHotplug *g, DeviceState *dev, Error **errp);
 
 void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent, Object *owner,
diff --git a/include/hw/acpi/memory_hotplug.h b/include/hw/acpi/memory_hotplug.h
index 77c65765d6..ebd97093dd 100644
--- a/include/hw/acpi/memory_hotplug.h
+++ b/include/hw/acpi/memory_hotplug.h
@@ -31,9 +31,9 @@ typedef struct MemHotplugState {
 void acpi_memory_hotplug_init(MemoryRegion *as, Object *owner,
                               MemHotplugState *state, uint16_t io_base);
 
-void acpi_memory_plug_cb(HotplugHandler *hotplug_dev, MemHotplugState *mem_st,
+void acpi_memory_plug_cb(AcpiDeviceIf *acpi_dev, MemHotplugState *mem_st,
                          DeviceState *dev, Error **errp);
-void acpi_memory_unplug_request_cb(HotplugHandler *hotplug_dev,
+void acpi_memory_unplug_request_cb(AcpiDeviceIf *acpi_dev,
                                    MemHotplugState *mem_st,
                                    DeviceState *dev, Error **errp);
 void acpi_memory_unplug_cb(MemHotplugState *mem_st,
diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
index 8a65f99fc8..bba37b81dc 100644
--- a/include/hw/acpi/pcihp.h
+++ b/include/hw/acpi/pcihp.h
@@ -56,9 +56,9 @@ typedef struct AcpiPciHpState {
 void acpi_pcihp_init(Object *owner, AcpiPciHpState *, PCIBus *root,
                      MemoryRegion *address_space_io, bool bridges_enabled);
 
-void acpi_pcihp_device_plug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
+void acpi_pcihp_device_plug_cb(AcpiDeviceIf *acpi_dev, AcpiPciHpState *s,
                                DeviceState *dev, Error **errp);
-void acpi_pcihp_device_unplug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
+void acpi_pcihp_device_unplug_cb(AcpiDeviceIf *acpi_dev, AcpiPciHpState *s,
                                  DeviceState *dev, Error **errp);
 
 /* Called on reset */
diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
index c5c9b3c7f8..0d80497efe 100644
--- a/include/hw/mem/nvdimm.h
+++ b/include/hw/mem/nvdimm.h
@@ -25,6 +25,7 @@
 
 #include "hw/mem/pc-dimm.h"
 #include "hw/acpi/bios-linker-loader.h"
+#include "hw/acpi/acpi_dev_interface.h"
 
 #define NVDIMM_DEBUG 0
 #define nvdimm_debug(fmt, ...)                                \
@@ -149,5 +150,5 @@ void nvdimm_build_acpi(GArray *table_offsets, GArray *table_data,
                        BIOSLinker *linker, AcpiNVDIMMState *state,
                        uint32_t ram_slots);
 void nvdimm_plug(AcpiNVDIMMState *state);
-void nvdimm_acpi_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev);
+void nvdimm_acpi_plug_cb(AcpiDeviceIf *acpi_dev, DeviceState *dev);
 #endif
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 2eb9b5a032..71aec1d655 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -220,7 +220,7 @@ static AcpiCpuStatus *get_cpu_status(CPUHotplugState *cpu_st, DeviceState *dev)
     return NULL;
 }
 
-void acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
+void acpi_cpu_plug_cb(AcpiDeviceIf *acpi_dev,
                       CPUHotplugState *cpu_st, DeviceState *dev, Error **errp)
 {
     AcpiCpuStatus *cdev;
@@ -233,11 +233,11 @@ void acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
     cdev->cpu = CPU(dev);
     if (dev->hotplugged) {
         cdev->is_inserting = true;
-        acpi_send_event(ACPI_DEVICE_IF(hotplug_dev), ACPI_CPU_HOTPLUG_STATUS);
+        acpi_send_event(acpi_dev, ACPI_CPU_HOTPLUG_STATUS);
     }
 }
 
-void acpi_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
+void acpi_cpu_unplug_request_cb(AcpiDeviceIf *acpi_dev,
                                 CPUHotplugState *cpu_st,
                                 DeviceState *dev, Error **errp)
 {
@@ -249,7 +249,7 @@ void acpi_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
     }
 
     cdev->is_removing = true;
-    acpi_send_event(ACPI_DEVICE_IF(hotplug_dev), ACPI_CPU_HOTPLUG_STATUS);
+    acpi_send_event(acpi_dev, ACPI_CPU_HOTPLUG_STATUS);
 }
 
 void acpi_cpu_unplug_cb(CPUHotplugState *cpu_st,
diff --git a/hw/acpi/cpu_hotplug.c b/hw/acpi/cpu_hotplug.c
index 5a1599796b..d9277e27de 100644
--- a/hw/acpi/cpu_hotplug.c
+++ b/hw/acpi/cpu_hotplug.c
@@ -72,14 +72,14 @@ static void acpi_set_cpu_present_bit(AcpiCpuHotplug *g, CPUState *cpu,
     g->sts[cpu_id / 8] |= (1 << (cpu_id % 8));
 }
 
-void legacy_acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
+void legacy_acpi_cpu_plug_cb(AcpiDeviceIf *acpi_dev,
                              AcpiCpuHotplug *g, DeviceState *dev, Error **errp)
 {
     acpi_set_cpu_present_bit(g, CPU(dev), errp);
     if (*errp != NULL) {
         return;
     }
-    acpi_send_event(ACPI_DEVICE_IF(hotplug_dev), ACPI_CPU_HOTPLUG_STATUS);
+    acpi_send_event(acpi_dev, ACPI_CPU_HOTPLUG_STATUS);
 }
 
 void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent, Object *owner,
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index c5d8646abc..c53b8bb508 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -487,20 +487,21 @@ void ich9_pm_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                             Error **errp)
 {
     ICH9LPCState *lpc = ICH9_LPC_DEVICE(hotplug_dev);
+    AcpiDeviceIf *acpi_dev = ACPI_DEVICE_IF(hotplug_dev);
 
     if (lpc->pm.acpi_memory_hotplug.is_enabled &&
         object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {
-            nvdimm_acpi_plug_cb(hotplug_dev, dev);
+            nvdimm_acpi_plug_cb(acpi_dev, dev);
         } else {
-            acpi_memory_plug_cb(hotplug_dev, &lpc->pm.acpi_memory_hotplug,
+            acpi_memory_plug_cb(acpi_dev, &lpc->pm.acpi_memory_hotplug,
                                 dev, errp);
         }
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         if (lpc->pm.cpu_hotplug_legacy) {
-            legacy_acpi_cpu_plug_cb(hotplug_dev, &lpc->pm.gpe_cpu, dev, errp);
+            legacy_acpi_cpu_plug_cb(acpi_dev, &lpc->pm.gpe_cpu, dev, errp);
         } else {
-            acpi_cpu_plug_cb(hotplug_dev, &lpc->pm.cpuhp_state, dev, errp);
+            acpi_cpu_plug_cb(acpi_dev, &lpc->pm.cpuhp_state, dev, errp);
         }
     } else {
         error_setg(errp, "acpi: device plug request for not supported device"
@@ -512,15 +513,16 @@ void ich9_pm_device_unplug_request_cb(HotplugHandler *hotplug_dev,
                                       DeviceState *dev, Error **errp)
 {
     ICH9LPCState *lpc = ICH9_LPC_DEVICE(hotplug_dev);
+    AcpiDeviceIf *acpi_dev = ACPI_DEVICE_IF(hotplug_dev);
 
     if (lpc->pm.acpi_memory_hotplug.is_enabled &&
         object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
-        acpi_memory_unplug_request_cb(hotplug_dev,
+        acpi_memory_unplug_request_cb(acpi_dev,
                                       &lpc->pm.acpi_memory_hotplug, dev,
                                       errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) &&
                !lpc->pm.cpu_hotplug_legacy) {
-        acpi_cpu_unplug_request_cb(hotplug_dev, &lpc->pm.cpuhp_state,
+        acpi_cpu_unplug_request_cb(acpi_dev, &lpc->pm.cpuhp_state,
                                    dev, errp);
     } else {
         error_setg(errp, "acpi: device unplug request for not supported device"
diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index 24b2aa0301..c0a4c39432 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -261,7 +261,7 @@ acpi_memory_slot_status(MemHotplugState *mem_st,
     return &mem_st->devs[slot];
 }
 
-void acpi_memory_plug_cb(HotplugHandler *hotplug_dev, MemHotplugState *mem_st,
+void acpi_memory_plug_cb(AcpiDeviceIf *acpi_dev, MemHotplugState *mem_st,
                          DeviceState *dev, Error **errp)
 {
     MemStatus *mdev;
@@ -280,11 +280,11 @@ void acpi_memory_plug_cb(HotplugHandler *hotplug_dev, MemHotplugState *mem_st,
     mdev->is_enabled = true;
     if (dev->hotplugged) {
         mdev->is_inserting = true;
-        acpi_send_event(ACPI_DEVICE_IF(hotplug_dev), ACPI_MEMORY_HOTPLUG_STATUS);
+        acpi_send_event(acpi_dev, ACPI_MEMORY_HOTPLUG_STATUS);
     }
 }
 
-void acpi_memory_unplug_request_cb(HotplugHandler *hotplug_dev,
+void acpi_memory_unplug_request_cb(AcpiDeviceIf *acpi_dev,
                                    MemHotplugState *mem_st,
                                    DeviceState *dev, Error **errp)
 {
@@ -296,7 +296,7 @@ void acpi_memory_unplug_request_cb(HotplugHandler *hotplug_dev,
     }
 
     mdev->is_removing = true;
-    acpi_send_event(ACPI_DEVICE_IF(hotplug_dev), ACPI_MEMORY_HOTPLUG_STATUS);
+    acpi_send_event(acpi_dev, ACPI_MEMORY_HOTPLUG_STATUS);
 }
 
 void acpi_memory_unplug_cb(MemHotplugState *mem_st,
diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index bdc373696d..b4708dc746 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -918,10 +918,10 @@ static const MemoryRegionOps nvdimm_dsm_ops = {
     },
 };
 
-void nvdimm_acpi_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev)
+void nvdimm_acpi_plug_cb(AcpiDeviceIf *acpi_dev, DeviceState *dev)
 {
     if (dev->hotplugged) {
-        acpi_send_event(ACPI_DEVICE_IF(hotplug_dev), ACPI_NVDIMM_HOTPLUG_STATUS);
+        acpi_send_event(acpi_dev, ACPI_NVDIMM_HOTPLUG_STATUS);
     }
 }
 
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index b3bb11dac5..c094d86de3 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -217,7 +217,7 @@ void acpi_pcihp_reset(AcpiPciHpState *s)
     acpi_pcihp_update(s);
 }
 
-void acpi_pcihp_device_plug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
+void acpi_pcihp_device_plug_cb(AcpiDeviceIf *acpi_dev, AcpiPciHpState *s,
                                DeviceState *dev, Error **errp)
 {
     PCIDevice *pdev = PCI_DEVICE(dev);
@@ -237,10 +237,10 @@ void acpi_pcihp_device_plug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
     }
 
     s->acpi_pcihp_pci_status[bsel].up |= (1U << slot);
-    acpi_send_event(ACPI_DEVICE_IF(hotplug_dev), ACPI_PCI_HOTPLUG_STATUS);
+    acpi_send_event(acpi_dev, ACPI_PCI_HOTPLUG_STATUS);
 }
 
-void acpi_pcihp_device_unplug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
+void acpi_pcihp_device_unplug_cb(AcpiDeviceIf *acpi_dev, AcpiPciHpState *s,
                                  DeviceState *dev, Error **errp)
 {
     PCIDevice *pdev = PCI_DEVICE(dev);
@@ -253,7 +253,7 @@ void acpi_pcihp_device_unplug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
     }
 
     s->acpi_pcihp_pci_status[bsel].down |= (1U << slot);
-    acpi_send_event(ACPI_DEVICE_IF(hotplug_dev), ACPI_PCI_HOTPLUG_STATUS);
+    acpi_send_event(acpi_dev, ACPI_PCI_HOTPLUG_STATUS);
 }
 
 static uint64_t pci_read(void *opaque, hwaddr addr, unsigned int size)
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 6404af5f33..c26c66242f 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -374,22 +374,23 @@ static void piix4_device_plug_cb(HotplugHandler *hotplug_dev,
                                  DeviceState *dev, Error **errp)
 {
     PIIX4PMState *s = PIIX4_PM(hotplug_dev);
+    AcpiDeviceIf *acpi_dev = ACPI_DEVICE_IF(hotplug_dev);
 
     if (s->acpi_memory_hotplug.is_enabled &&
         object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {
-            nvdimm_acpi_plug_cb(hotplug_dev, dev);
+            nvdimm_acpi_plug_cb(acpi_dev, dev);
         } else {
-            acpi_memory_plug_cb(hotplug_dev, &s->acpi_memory_hotplug,
+            acpi_memory_plug_cb(acpi_dev, &s->acpi_memory_hotplug,
                                 dev, errp);
         }
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
-        acpi_pcihp_device_plug_cb(hotplug_dev, &s->acpi_pci_hotplug, dev, errp);
+        acpi_pcihp_device_plug_cb(acpi_dev, &s->acpi_pci_hotplug, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         if (s->cpu_hotplug_legacy) {
-            legacy_acpi_cpu_plug_cb(hotplug_dev, &s->gpe_cpu, dev, errp);
+            legacy_acpi_cpu_plug_cb(acpi_dev, &s->gpe_cpu, dev, errp);
         } else {
-            acpi_cpu_plug_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
+            acpi_cpu_plug_cb(acpi_dev, &s->cpuhp_state, dev, errp);
         }
     } else {
         error_setg(errp, "acpi: device plug request for not supported device"
@@ -401,17 +402,18 @@ static void piix4_device_unplug_request_cb(HotplugHandler *hotplug_dev,
                                            DeviceState *dev, Error **errp)
 {
     PIIX4PMState *s = PIIX4_PM(hotplug_dev);
+    AcpiDeviceIf *acpi_dev = ACPI_DEVICE_IF(hotplug_dev);
 
     if (s->acpi_memory_hotplug.is_enabled &&
         object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
-        acpi_memory_unplug_request_cb(hotplug_dev, &s->acpi_memory_hotplug,
+        acpi_memory_unplug_request_cb(acpi_dev, &s->acpi_memory_hotplug,
                                       dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
-        acpi_pcihp_device_unplug_cb(hotplug_dev, &s->acpi_pci_hotplug, dev,
+        acpi_pcihp_device_unplug_cb(acpi_dev, &s->acpi_pci_hotplug, dev,
                                     errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) &&
                !s->cpu_hotplug_legacy) {
-        acpi_cpu_unplug_request_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
+        acpi_cpu_unplug_request_cb(acpi_dev, &s->cpuhp_state, dev, errp);
     } else {
         error_setg(errp, "acpi: device unplug request for not supported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
-- 
2.18.0.rc1.1.g3f1ff2140
