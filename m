Received: from eggs.gnu.org ([209.51.188.92]:46953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gosFP-00079D-0a
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:57:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gosFO-00009q-5b
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:57:54 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 30 Jan 2019 16:57:33 +0100
Message-Id: <20190130155733.32742-7-david@redhat.com>
In-Reply-To: <20190130155733.32742-1-david@redhat.com>
References: <20190130155733.32742-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 6/6] s390x/pci: Unplug remaining requested
 devices on pcihost reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Pierre Morel <pmorel@linux.ibm.com>, David Hildenbrand <david@redhat.com>

When resetting the guest we should unplug and remove all devices that
are still pending.

With this patch, the requested device will be unpluged on reboot
(S390_RESET_EXTERNAL and S390_RESET_REIPL, which reset the pcihost bridge
via qemu_devices_reset()).

This approach is similar to what's done for acpi PCI hotplug in
acpi_pcihp_reset() -> acpi_pcihp_update() ->
acpi_pcihp_update_hotplug_bus() -> acpi_pcihp_eject_slot().

s390_pci_generate_plug_event()'s will still be generated, I guess this
is not an issue. The same thing would happen right now when unplugging
a device just before starting the guest.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 867801ccf9..b9b0f44087 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1092,6 +1092,21 @@ static void s390_pcihost_reset(DeviceState *dev)
 {
     S390pciState *s = S390_PCI_HOST_BRIDGE(dev);
     PCIBus *bus = s->parent_obj.bus;
+    S390PCIBusDevice *pbdev, *next;
+
+    /* Process all pending unplug requests */
+    QTAILQ_FOREACH_SAFE(pbdev, &s->zpci_devs, link, next) {
+        if (pbdev->unplug_requested) {
+            if (pbdev->summary_ind) {
+                pci_dereg_irqs(pbdev);
+            }
+            if (pbdev->iommu->enabled) {
+                pci_dereg_ioat(pbdev->iommu);
+            }
+            pbdev->state = ZPCI_FS_STANDBY;
+            s390_pci_perform_unplug(pbdev);
+        }
+    }
 
     /*
      * When resetting a PCI bridge, the assigned numbers are set to 0. So
-- 
2.17.2
