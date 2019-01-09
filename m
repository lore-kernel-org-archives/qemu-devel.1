Received: from eggs.gnu.org ([209.51.188.92]:51891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ghH7Y-0003Fv-L7
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:54:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ghH7O-0005IS-VQ
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:54:21 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed,  9 Jan 2019 17:53:49 +0100
Message-Id: <20190109165349.23631-7-david@redhat.com>
In-Reply-To: <20190109165349.23631-1-david@redhat.com>
References: <20190109165349.23631-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 6/6] s390x/pci: unplug remaining devices on
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
and S390_RESET_LOAD_NORMAL), we have to modify s390_machine_reset().

s390_pci_generate_plug_event()'s will still be generated, but that is
similar to hotplugging a PCI device before the guest has been started, so
I guess it is not problematic. (we could inject such events when
hotplugging based on "dev->hotplugged" property, when unplugging we would
have to rely on the runstate)

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index bcd8565a14..0212e83069 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1099,6 +1099,14 @@ static void s390_pcihost_reset(DeviceState *dev)
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
