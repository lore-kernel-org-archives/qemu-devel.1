Received: from eggs.gnu.org ([209.51.188.92]:46804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gosFK-00074m-8J
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:57:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gosFJ-0008V5-Dc
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:57:50 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 30 Jan 2019 16:57:30 +0100
Message-Id: <20190130155733.32742-4-david@redhat.com>
In-Reply-To: <20190130155733.32742-1-david@redhat.com>
References: <20190130155733.32742-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/6] s390x/pci: Warn when adding PCI devices
 without the 'zpci' feature
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

We decided to always create the PCI host bridge, even if 'zpci' is not
enabled (due to migration compatibility). This however right now allows
to add zPCI/PCI devices to a VM although the guest will never actually see
them, confusing people that are using a simple CPU model that has no
'zpci' enabled - "Why isn't this working" (David Hildenbrand)

Let's check for 'zpci' and at least print a warning that this will not
work as expected. We could also bail out, however that might break
existing QEMU commandlines.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 9b5c5fff60..2efd9186c2 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -826,6 +826,11 @@ static void s390_pcihost_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 {
     S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
 
+    if (!s390_has_feat(S390_FEAT_ZPCI)) {
+        warn_report("PCI/zPCI device without the 'zpci' CPU feature."
+                    " The guest will not be able to see/use this device");
+    }
+
     if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
         PCIDevice *pdev = PCI_DEVICE(dev);
 
-- 
2.17.2
