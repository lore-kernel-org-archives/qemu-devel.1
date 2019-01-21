Received: from eggs.gnu.org ([209.51.188.92]:49978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1glZqt-0001IB-Hi
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:43:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1glZqs-0006vG-Qv
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:42:59 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 21 Jan 2019 14:42:49 +0100
Message-Id: <20190121134249.16615-3-david@redhat.com>
In-Reply-To: <20190121134249.16615-1-david@redhat.com>
References: <20190121134249.16615-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/2] s390x/pci: Unplug remaining devices on
 pcihost reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>

When resetting the guest we should unplug and remove all devices that
are still pending. Otherwise the fresh guest will see devices that will
suddenly vanish.

Can be triggered e.g. via
(hmp) device_add virtio-mouse-pci,id=test
(hmp) stop
(hmp) device_del test
(hmp) system_reset
(hmp) c

The device will vanish after roughly 5 minutes. With this patch, the
device will vanish on reboot (S390_RESET_EXTERNAL and S390_RESET_REIPL,
which reset the pcihost bridge via qemu_devices_reset()). If we want
these devices to vanish directly on any reset (S390_RESET_MODIFIED_CLEAR
and S390_RESET_LOAD_NORMAL), we have to modify s390_machine_reset(). But
I have the feeling that this should not be done for all reset types.

This approach is similar to what's done for acpi PCI hotplug in
acpi_pcihp_reset() -> acpi_pcihp_update() ->
acpi_pcihp_update_hotplug_bus() -> acpi_pcihp_eject_slot().

s390_pci_generate_plug_event()'s will still be generated, I guess this
is not an issue (same thing could happen right now if the timer expires
just after reset).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index bc17a8cf65..b70ae25533 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1102,6 +1102,14 @@ static void s390_pcihost_reset(DeviceState *dev)
 {
     S390pciState *s = S390_PCI_HOST_BRIDGE(dev);
     PCIBus *bus = s->parent_obj.bus;
+    S390PCIBusDevice *pbdev, *next;
+
+    /* Unplug all pending devices that were requested to be released */
+    QTAILQ_FOREACH_SAFE(pbdev, &s->zpci_devs, link, next) {
+        if (pbdev->release_timer) {
+            s390_pcihost_timer_cb(pbdev);
+        }
+    }
 
     s->bus_no = 0;
     pci_for_each_device(bus, pci_bus_num(bus), s390_pci_enumerate_bridge, s);
-- 
2.17.2
