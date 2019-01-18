Received: from eggs.gnu.org ([209.51.188.92]:52435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gkT7m-00056c-6G
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:19:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gkT7l-0001Xt-Hw
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:19:50 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 18 Jan 2019 13:19:21 +0100
Message-Id: <20190118121925.24468-8-cohuck@redhat.com>
In-Reply-To: <20190118121925.24468-1-cohuck@redhat.com>
References: <20190118121925.24468-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 07/11] s390x/pci: Use hotplug_dev instead of
 looking up the host bridge
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

We directly have it in our hands.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190114103110.10909-2-david@redhat.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 400d9e4f28..248e0eb295 100644
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
@@ -937,11 +937,11 @@ static void s390_pcihost_timer_cb(void *opaque)
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
