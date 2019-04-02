Received: from eggs.gnu.org ([209.51.188.92]:34633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hBM7y-0007eS-Ro
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 12:19:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hBM7x-0006Zj-SZ
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 12:19:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hBM7x-0006Z8-KD
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 12:19:09 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  2 Apr 2019 18:19:00 +0200
Message-Id: <20190402161900.7374-4-armbru@redhat.com>
In-Reply-To: <20190402161900.7374-1-armbru@redhat.com>
References: <20190402161900.7374-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] acpi/pcihp: Add a few more trace points
 related to unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, marcel.apfelbaum@gmail.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/acpi/pcihp.c      | 7 +++++++
 hw/acpi/trace-events | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 7729c5338b..613406d09b 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -152,6 +152,8 @@ static void acpi_pcihp_eject_slot(AcpiPciHpState *s, unsigned bsel, unsigned slo
     int slot = ctz32(slots);
     PCIBus *bus = acpi_pcihp_find_hotplug_bus(s, bsel);
 
+    trace_acpi_pci_eject_slot(bsel, slot);
+
     if (!bus) {
         return;
     }
@@ -263,6 +265,8 @@ void acpi_pcihp_device_plug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
 void acpi_pcihp_device_unplug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
                                  DeviceState *dev, Error **errp)
 {
+    trace_acpi_pci_unplug(PCI_SLOT(PCI_DEVICE(dev)->devfn),
+                          acpi_pcihp_get_bsel(pci_get_bus(PCI_DEVICE(dev))));
     object_property_set_bool(OBJECT(dev), false, "realized", NULL);
 }
 
@@ -273,6 +277,9 @@ void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
     PCIDevice *pdev = PCI_DEVICE(dev);
     int slot = PCI_SLOT(pdev->devfn);
     int bsel = acpi_pcihp_get_bsel(pci_get_bus(pdev));
+
+    trace_acpi_pci_unplug_request(bsel, slot);
+
     if (bsel < 0) {
         error_setg(errp, "Unsupported bus. Bus doesn't have property '"
                    ACPI_PCIHP_PROP_BSEL "' set");
diff --git a/hw/acpi/trace-events b/hw/acpi/trace-events
index 98a56baa6f..96b8273297 100644
--- a/hw/acpi/trace-events
+++ b/hw/acpi/trace-events
@@ -32,6 +32,9 @@ cpuhp_acpi_write_ost_ev(uint32_t slot, uint32_t ev) "idx[0x%"PRIx32"] OST EVENT:
 cpuhp_acpi_write_ost_status(uint32_t slot, uint32_t st) "idx[0x%"PRIx32"] OST STATUS: 0x%"PRIx32
 
 # pcihp.c
+acpi_pci_eject_slot(unsigned bsel, unsigned slot) "bsel: %u slot: %u"
+acpi_pci_unplug(int bsel, int slot) "bsel: %d slot: %d"
+acpi_pci_unplug_request(int bsel, int slot) "bsel: %d slot: %d"
 acpi_pci_up_read(uint32_t val) "%" PRIu32
 acpi_pci_down_read(uint32_t val) "%" PRIu32
 acpi_pci_features_read(uint32_t val) "%" PRIu32
-- 
2.17.2
