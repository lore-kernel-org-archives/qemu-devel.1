Received: from eggs.gnu.org ([2001:4830:134:3::10]:41162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ezImj-0001f0-Mg
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 05:14:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ezImg-0001KA-Dw
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 05:14:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36738
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ezImg-0001JW-7j
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 05:14:50 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2N9AVQn137772
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 05:14:49 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gvx609km8-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 05:14:49 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 23 Mar 2018 09:14:47 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 23 Mar 2018 09:14:40 +0000
In-Reply-To: <20180323091441.116971-1-borntraeger@de.ibm.com>
References: <20180323091441.116971-1-borntraeger@de.ibm.com>
Message-Id: <20180323091441.116971-2-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 1/2] s390x/pci: forbid multifunction pci device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>

Currently we don't support pci multifunction. If a pci with
multifucntion is plugged, the guest will spin forever. This patch fixes
this.

Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
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
2.14.3
