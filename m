Received: from eggs.gnu.org ([209.51.188.92]:54905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gr3nS-0001d2-5z
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:42:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gr3nQ-0008Az-8z
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:42:06 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue,  5 Feb 2019 17:41:08 +0100
Message-Id: <20190205164109.25413-10-cohuck@redhat.com>
In-Reply-To: <20190205164109.25413-1-cohuck@redhat.com>
References: <20190205164109.25413-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 09/10] s390x/pci: Warn when adding PCI devices
 without the 'zpci' feature
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
Message-Id: <20190130155733.32742-4-david@redhat.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index d85bc34617..3816fb1f11 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -860,6 +860,12 @@ static void s390_pcihost_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 {
     S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
 
+    if (!s390_has_feat(S390_FEAT_ZPCI)) {
+        warn_report("Plugging a PCI/zPCI device without the 'zpci' CPU "
+                    "feature enabled; the guest will not be able to see/use "
+                    "this device");
+    }
+
     if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
         PCIDevice *pdev = PCI_DEVICE(dev);
 
-- 
2.17.2
