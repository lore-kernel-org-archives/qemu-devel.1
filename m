Received: from eggs.gnu.org ([209.51.188.92]:51689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ghH7A-0002tE-GS
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:54:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ghH79-0005Bm-C7
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:54:00 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed,  9 Jan 2019 17:53:44 +0100
Message-Id: <20190109165349.23631-2-david@redhat.com>
In-Reply-To: <20190109165349.23631-1-david@redhat.com>
References: <20190109165349.23631-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 1/6] s390x/pci: Use hotplug_dev instead of
 looking up the host bridge
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

We directly have it in our hands.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 15759b6514..de62fc8916 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -826,9 +826,9 @@ static bool s390_pci_alloc_idx(S390pciState *s, S390PCIBusDevice *pbdev)
 static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                               Error **errp)
 {
+    S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
     PCIDevice *pdev = NULL;
     S390PCIBusDevice *pbdev = NULL;
-    S390pciState *s = s390_get_phb();
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
         BusState *bus;
@@ -935,11 +935,11 @@ static void s390_pcihost_timer_cb(void *opaque)
 static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
                                 Error **errp)
 {
+    S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
     PCIDevice *pci_dev = NULL;
     PCIBus *bus;
     int32_t devfn;
     S390PCIBusDevice *pbdev = NULL;
-    S390pciState *s = s390_get_phb();
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
         error_setg(errp, "PCI bridge hot unplug currently not supported");
-- 
2.17.2
