Received: from eggs.gnu.org ([209.51.188.92]:60968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1glsZ2-0001M7-7p
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:41:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1glsZ1-0003cH-GS
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:41:48 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 22 Jan 2019 10:41:43 +0100
Message-Id: <20190122094143.8857-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1] s390x/pci: Warn when adding PCI devices
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
Cc: qemu-s390x@nongnu.org, Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>

We decided to always create the PCI host bridge, even if 'zpci' is not
enabled (due to migration compatibility). This however right now allows
to add zPCI/PCI devices to a VM although the guest will never actually see
them, confusing people that are using a simple CPU model that has no
'zpci' enabled - "Why isn't this working" (David Hildenbrand)

Let's check for 'zpci' and at least print a warning that this will not
work as expected. We could also bail out, however that might break
existing QEMU commandlines.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index b86a8bdcd4..e7d4f49611 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -863,6 +863,11 @@ static void s390_pcihost_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 {
     S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
 
+    if (!s390_has_feat(S390_FEAT_ZPCI)) {
+        warn_report("Adding PCI or zPCI devices without the 'zpci' CPU feature."
+                    " The guest will not be able to see/use these devices.");
+    }
+
     if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
         PCIDevice *pdev = PCI_DEVICE(dev);
 
-- 
2.17.2
