Received: from eggs.gnu.org ([2001:4830:134:3::10]:60292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ga3Es-0005Or-6w
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:40:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ga3Er-0001Ri-DO
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:40:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ga3Er-0001PT-0C
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:40:05 -0500
Date: Thu, 20 Dec 2018 13:40:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181220183059.20726-37-mst@redhat.com>
References: <20181220183059.20726-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220183059.20726-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v3 36/44] pci/pcihp: perform unplug via the
 hotplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

From: David Hildenbrand <david@redhat.com>

Introduce and use the "unplug" callback.

This is a preparation for multi-stage hotplug handlers, whereby the bus
hotplug handler is overwritten by the machine hotplug handler. This handler
will then pass control to the bus hotplug handler. So to get this running
cleanly, we also have to make sure to go via the hotplug handler chain when
actually unplugging a device after an unplug request. Lookup the hotplug
handler and call "unplug".

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/pcihp.h |  3 +++
 hw/acpi/pcihp.c         | 11 ++++++++++-
 hw/acpi/piix4.c         |  7 +++++--
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
index ce31625850..8bc4a4c01d 100644
--- a/include/hw/acpi/pcihp.h
+++ b/include/hw/acpi/pcihp.h
@@ -62,6 +62,9 @@ void acpi_pcihp_device_plug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
                                DeviceState *dev, Error **errp);
 void acpi_pcihp_device_unplug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
                                  DeviceState *dev, Error **errp);
+void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
+                                         AcpiPciHpState *s, DeviceState *dev,
+                                         Error **errp);
 
 /* Called on reset */
 void acpi_pcihp_reset(AcpiPciHpState *s);
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 05e3f8d11e..7bc7a72340 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -154,6 +154,7 @@ static bool acpi_pcihp_pc_no_hotplug(AcpiPciHpState *s, PCIDevice *dev)
 
 static void acpi_pcihp_eject_slot(AcpiPciHpState *s, unsigned bsel, unsigned slots)
 {
+    HotplugHandler *hotplug_ctrl;
     BusChild *kid, *next;
     int slot = ctz32(slots);
     PCIBus *bus = acpi_pcihp_find_hotplug_bus(s, bsel);
@@ -171,7 +172,8 @@ static void acpi_pcihp_eject_slot(AcpiPciHpState *s, unsigned bsel, unsigned slo
         PCIDevice *dev = PCI_DEVICE(qdev);
         if (PCI_SLOT(dev->devfn) == slot) {
             if (!acpi_pcihp_pc_no_hotplug(s, dev)) {
-                object_unparent(OBJECT(qdev));
+                hotplug_ctrl = qdev_get_hotplug_handler(qdev);
+                hotplug_handler_unplug(hotplug_ctrl, qdev, &error_abort);
             }
         }
     }
@@ -266,6 +268,13 @@ void acpi_pcihp_device_plug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
 
 void acpi_pcihp_device_unplug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
                                  DeviceState *dev, Error **errp)
+{
+    object_unparent(OBJECT(dev));
+}
+
+void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
+                                         AcpiPciHpState *s, DeviceState *dev,
+                                         Error **errp)
 {
     PCIDevice *pdev = PCI_DEVICE(dev);
     int slot = PCI_SLOT(pdev->devfn);
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 07dfeb0e3d..88f9a9ec09 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -419,8 +419,8 @@ static void piix4_device_unplug_request_cb(HotplugHandler *hotplug_dev,
         acpi_memory_unplug_request_cb(hotplug_dev, &s->acpi_memory_hotplug,
                                       dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
-        acpi_pcihp_device_unplug_cb(hotplug_dev, &s->acpi_pci_hotplug, dev,
-                                    errp);
+        acpi_pcihp_device_unplug_request_cb(hotplug_dev, &s->acpi_pci_hotplug,
+                                            dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) &&
                !s->cpu_hotplug_legacy) {
         acpi_cpu_unplug_request_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
@@ -438,6 +438,9 @@ static void piix4_device_unplug_cb(HotplugHandler *hotplug_dev,
     if (s->acpi_memory_hotplug.is_enabled &&
         object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         acpi_memory_unplug_cb(&s->acpi_memory_hotplug, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
+        acpi_pcihp_device_unplug_cb(hotplug_dev, &s->acpi_pci_hotplug, dev,
+                                    errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) &&
                !s->cpu_hotplug_legacy) {
         acpi_cpu_unplug_cb(&s->cpuhp_state, dev, errp);
-- 
MST
