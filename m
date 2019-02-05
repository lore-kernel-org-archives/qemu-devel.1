Received: from eggs.gnu.org ([209.51.188.92]:54924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gr3nU-0001f7-6i
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:42:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gr3nS-0008BE-5f
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:42:08 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue,  5 Feb 2019 17:41:09 +0100
Message-Id: <20190205164109.25413-11-cohuck@redhat.com>
In-Reply-To: <20190205164109.25413-1-cohuck@redhat.com>
References: <20190205164109.25413-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 10/10] s390x/pci: Unplug remaining requested
 devices on pcihost reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

When resetting the guest we should unplug and remove all devices that
are still pending.

With this patch, the requested device will be unplugged on reboot
(S390_RESET_EXTERNAL and S390_RESET_REIPL, which reset the pcihost bridge
via qemu_devices_reset()).

This approach is similar to what's done for acpi PCI hotplug in
acpi_pcihp_reset() -> acpi_pcihp_update() ->
acpi_pcihp_update_hotplug_bus() -> acpi_pcihp_eject_slot().

s390_pci_generate_plug_event()'s will still be generated, I guess this
is not an issue. The same thing would happen right now when unplugging
a device just before starting the guest.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190130155733.32742-7-david@redhat.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 3816fb1f11..80ff1ce33f 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1093,6 +1093,21 @@ static void s390_pcihost_reset(DeviceState *dev)
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
