Received: from eggs.gnu.org ([2001:4830:134:3::10]:44593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1evSIG-0007zz-Mh
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:35:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1evSIF-0005Gy-IR
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:35:32 -0400
Received: from mail-pl0-x231.google.com ([2607:f8b0:400e:c01::231]:46576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <x1917x@gmail.com>) id 1evSIF-0005GQ-AV
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:35:31 -0400
Received: by mail-pl0-x231.google.com with SMTP id f5-v6so2245861plj.13
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 11:35:31 -0700 (PDT)
From: Alexey Gerasimenko <x1917x@gmail.com>
Date: Tue, 13 Mar 2018 04:34:00 +1000
Message-Id: <7379b9a20e56554ec683261d0bdcd8d706d2232a.1520867956.git.x1917x@gmail.com>
In-Reply-To: <cover.1520867740.git.x1917x@gmail.com>
References: <cover.1520867740.git.x1917x@gmail.com>
In-Reply-To: <cover.1520867740.git.x1917x@gmail.com>
References: <cover.1520867740.git.x1917x@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 15/30] q35/acpi/xen: Provide ACPI PCI
 hotplug interface for Xen on Q35
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xen-devel@lists.xenproject.org
Cc: Alexey Gerasimenko <x1917x@gmail.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

This patch allows to use ACPI PCI hotplug functionality for Xen on Q35.
All added code depends on xen_enabled(), so no functionality change for
non-Xen usage.

We need to call the acpi_set_pci_info function from ich9_pm_init as well,
so it was made globally visible again (as it was before).

Signed-off-by: Alexey Gerasimenko <x1917x@gmail.com>
---
 hw/acpi/ich9.c          | 24 ++++++++++++++++++++++++
 hw/acpi/pcihp.c         |  2 +-
 include/hw/acpi/ich9.h  |  2 ++
 include/hw/acpi/pcihp.h |  2 ++
 4 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index c5d8646abc..62e2582e1a 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -37,6 +37,7 @@
 
 #include "hw/i386/ich9.h"
 #include "hw/mem/pc-dimm.h"
+#include "hw/xen/xen.h"
 
 //#define DEBUG
 
@@ -258,6 +259,10 @@ static void pm_reset(void *opaque)
     pm->smi_en_wmask = ~0;
 
     acpi_update_sci(&pm->acpi_regs, pm->irq);
+
+    if (xen_enabled()) {
+        acpi_pcihp_reset(&pm->acpi_pci_hotplug);
+    }
 }
 
 static void pm_powerdown_req(Notifier *n, void *opaque)
@@ -300,6 +305,17 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm,
     pm->powerdown_notifier.notify = pm_powerdown_req;
     qemu_register_powerdown_notifier(&pm->powerdown_notifier);
 
+    if (xen_enabled()) {
+        PCIBus *bus = pci_get_bus(lpc_pci);
+
+        qbus_set_hotplug_handler(BUS(bus), DEVICE(lpc_pci), &error_abort);
+
+        acpi_pcihp_init(OBJECT(lpc_pci), &pm->acpi_pci_hotplug, bus,
+                        pci_address_space_io(lpc_pci), false);
+
+        acpi_set_pci_info();
+    }
+
     legacy_acpi_cpu_hotplug_init(pci_address_space_io(lpc_pci),
         OBJECT(lpc_pci), &pm->gpe_cpu, ICH9_CPU_HOTPLUG_IO_BASE);
 
@@ -496,6 +512,10 @@ void ich9_pm_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
             acpi_memory_plug_cb(hotplug_dev, &lpc->pm.acpi_memory_hotplug,
                                 dev, errp);
         }
+    } else if (xen_enabled() &&
+               object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
+        acpi_pcihp_device_plug_cb(hotplug_dev, &lpc->pm.acpi_pci_hotplug,
+                                  dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         if (lpc->pm.cpu_hotplug_legacy) {
             legacy_acpi_cpu_plug_cb(hotplug_dev, &lpc->pm.gpe_cpu, dev, errp);
@@ -522,6 +542,10 @@ void ich9_pm_device_unplug_request_cb(HotplugHandler *hotplug_dev,
                !lpc->pm.cpu_hotplug_legacy) {
         acpi_cpu_unplug_request_cb(hotplug_dev, &lpc->pm.cpuhp_state,
                                    dev, errp);
+    } else if (xen_enabled() &&
+               object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
+        acpi_pcihp_device_unplug_cb(hotplug_dev, &lpc->pm.acpi_pci_hotplug,
+                                    dev, errp);
     } else {
         error_setg(errp, "acpi: device unplug request for not supported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index f70d8620d7..d822f93293 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -94,7 +94,7 @@ static void *acpi_set_bsel(PCIBus *bus, void *opaque)
     return bsel_alloc;
 }
 
-static void acpi_set_pci_info(void)
+void acpi_set_pci_info(void)
 {
     static bool bsel_is_set;
     PCIBus *bus;
diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
index 59aeb06393..4a47d93745 100644
--- a/include/hw/acpi/ich9.h
+++ b/include/hw/acpi/ich9.h
@@ -26,6 +26,7 @@
 #include "hw/acpi/cpu.h"
 #include "hw/acpi/memory_hotplug.h"
 #include "hw/acpi/acpi_dev_interface.h"
+#include "hw/acpi/pcihp.h"
 #include "hw/acpi/tco.h"
 
 typedef struct ICH9LPCPMRegs {
@@ -52,6 +53,7 @@ typedef struct ICH9LPCPMRegs {
     bool cpu_hotplug_legacy;
     AcpiCpuHotplug gpe_cpu;
     CPUHotplugState cpuhp_state;
+    AcpiPciHpState acpi_pci_hotplug;
 
     MemHotplugState acpi_memory_hotplug;
 
diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
index 8a65f99fc8..0a685dd228 100644
--- a/include/hw/acpi/pcihp.h
+++ b/include/hw/acpi/pcihp.h
@@ -64,6 +64,8 @@ void acpi_pcihp_device_unplug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
 /* Called on reset */
 void acpi_pcihp_reset(AcpiPciHpState *s);
 
+void acpi_set_pci_info(void);
+
 extern const VMStateDescription vmstate_acpi_pcihp_pci_status;
 
 #define VMSTATE_PCI_HOTPLUG(pcihp, state, test_pcihp) \
-- 
2.11.0
