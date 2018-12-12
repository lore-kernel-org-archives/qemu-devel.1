Received: from eggs.gnu.org ([2001:4830:134:3::10]:59502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gX0dh-0002Hz-3U
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:17:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gX0df-0005V7-Pu
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:17:08 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 12 Dec 2018 10:16:18 +0100
Message-Id: <20181212091623.16950-7-david@redhat.com>
In-Reply-To: <20181212091623.16950-1-david@redhat.com>
References: <20181212091623.16950-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v4 06/11] pci/pcihp: overwrite hotplug handler
 recursively from the start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>

For now, the hotplug handler is not called for devices that are
being cold plugged. The hotplug handler is setup when the machine
initialization is fully done. Only bridges that were cold plugged are
considered.

Set the hotplug handler for the root piix bus directly when realizing.
Overwrite the hotplug handler of bridges when coldplugging them.

This will now make sure that the ACPI PCI hotplug handler is also called
for cold plugged devices (also on bridges) but not for bridges that were
hotplugged (keeping the current behavior).

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/acpi/pcihp.c | 15 +++++++++++++++
 hw/acpi/piix4.c | 16 +---------------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 5e7cef173c..05e3f8d11e 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -30,6 +30,7 @@
 #include "hw/hw.h"
 #include "hw/i386/pc.h"
 #include "hw/pci/pci.h"
+#include "hw/pci/pci_bridge.h"
 #include "hw/acpi/acpi.h"
 #include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
@@ -240,6 +241,20 @@ void acpi_pcihp_device_plug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
      * it is present on boot, no hotplug event is necessary. We do send an
      * event when the device is disabled later. */
     if (!dev->hotplugged) {
+        /*
+         * Overwrite the default hotplug handler with the ACPI PCI one
+         * for cold plugged bridges only.
+         */
+        if (!s->legacy_piix &&
+            object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
+            PCIBus *sec = pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
+
+            qbus_set_hotplug_handler(BUS(sec), DEVICE(hotplug_dev),
+                                     &error_abort);
+            /* We don't have to overwrite any other hotplug handler yet */
+            assert(QLIST_EMPTY(&sec->child));
+        }
+
         return;
     }
 
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index e586cfdc53..160f727a5e 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -446,15 +446,6 @@ static void piix4_device_unplug_cb(HotplugHandler *hotplug_dev,
     }
 }
 
-static void piix4_update_bus_hotplug(PCIBus *pci_bus, void *opaque)
-{
-    PIIX4PMState *s = opaque;
-
-    /* pci_bus cannot outlive PIIX4PMState, because /machine keeps it alive
-     * and it's not hot-unpluggable */
-    qbus_set_hotplug_handler(BUS(pci_bus), DEVICE(s), &error_abort);
-}
-
 static void piix4_pm_machine_ready(Notifier *n, void *opaque)
 {
     PIIX4PMState *s = container_of(n, PIIX4PMState, machine_ready);
@@ -468,12 +459,6 @@ static void piix4_pm_machine_ready(Notifier *n, void *opaque)
     pci_conf[0x63] = 0x60;
     pci_conf[0x67] = (memory_region_present(io_as, 0x3f8) ? 0x08 : 0) |
         (memory_region_present(io_as, 0x2f8) ? 0x90 : 0);
-
-    if (s->use_acpi_pci_hotplug) {
-        pci_for_each_bus(pci_get_bus(d), piix4_update_bus_hotplug, s);
-    } else {
-        piix4_update_bus_hotplug(pci_get_bus(d), s);
-    }
 }
 
 static void piix4_pm_add_propeties(PIIX4PMState *s)
@@ -547,6 +532,7 @@ static void piix4_pm_realize(PCIDevice *dev, Error **errp)
 
     piix4_acpi_system_hot_add_init(pci_address_space_io(dev),
                                    pci_get_bus(dev), s);
+    qbus_set_hotplug_handler(BUS(pci_get_bus(dev)), DEVICE(s), &error_abort);
 
     piix4_pm_add_propeties(s);
 }
-- 
2.17.2
