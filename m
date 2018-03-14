Received: from eggs.gnu.org ([2001:4830:134:3::10]:44315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1evyka-0006g0-VK
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 01:14:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1evykX-0002Fp-QX
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 01:14:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1evykX-0002E1-IE
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 01:14:53 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2E5EiaQ139726
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 01:14:51 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gpw4d0j0n-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 01:14:50 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Wed, 14 Mar 2018 01:14:49 -0400
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Wed, 14 Mar 2018 13:14:40 +0800
Message-Id: <20180314051440.9538-1-zyimin@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] s390x/pci: forbid multifunction pci device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, cohuck@redhat.com, alex.williamson@redhat.com, marcel@redhat.com, zyimin@linux.vnet.ibm.com

Currently we don't support pci multifunction. If a pci with
multifucntion is plugged, the guest will spin forever. This patch fixes
this.

Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 hw/s390x/s390-pci-bus.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 77a50cab36..10da87458e 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -816,6 +816,11 @@ static void s390_pcihost_hot_plug(HotplugHandler *hotplug_dev,
         PCIBridge *pb = PCI_BRIDGE(dev);
         PCIDevice *pdev = PCI_DEVICE(dev);
 
+        if (pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
+            error_setg(errp, "multifunction not supported in s390");
+            return;
+        }
+
         pci_bridge_map_irq(pb, dev->id, s390_pci_map_irq);
         pci_setup_iommu(&pb->sec_bus, s390_pci_dma_iommu, s);
 
@@ -835,6 +840,11 @@ static void s390_pcihost_hot_plug(HotplugHandler *hotplug_dev,
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
         pdev = PCI_DEVICE(dev);
 
+        if (pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
+            error_setg(errp, "multifunction not supported in s390");
+            return;
+        }
+
         if (!dev->id) {
             /* In the case the PCI device does not define an id */
             /* we generate one based on the PCI address         */
-- 
2.14.3 (Apple Git-98)
