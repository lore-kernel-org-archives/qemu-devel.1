Received: from eggs.gnu.org ([2001:4830:134:3::10]:48986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cTPZj-0002K6-Vv
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:57:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cTPZg-00088n-Si
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:57:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36752
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cTPZg-00088S-Md
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:57:04 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0H8rUEe105966
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 03:57:04 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2812q5avuu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 03:57:03 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 17 Jan 2017 08:57:00 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Tue, 17 Jan 2017 09:56:41 +0100
In-Reply-To: <20170117085645.4267-1-cornelia.huck@de.ibm.com>
References: <20170117085645.4267-1-cornelia.huck@de.ibm.com>
Message-Id: <20170117085645.4267-9-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 08/12] s390x/pci: PCI multibus bridge handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, jfrei@linux.vnet.ibm.com, qemu-devel@nongnu.org, Pierre Morel <pmorel@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Pierre Morel <pmorel@linux.vnet.ibm.com>

When the hotplug handler detects a PCI bridge, the secondary bus has
been initialized by the core PCI code. We give the secondary bus the
bridge name and associate to it the IOMMU handling and
hotplug/hotunplug callbacks.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/s390-pci-bus.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index e1b7649b0c..9ca67b2755 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -19,6 +19,7 @@
 #include "s390-pci-bus.h"
 #include "s390-pci-inst.h"
 #include "hw/pci/pci_bus.h"
+#include "hw/pci/pci_bridge.h"
 #include "hw/pci/msi.h"
 #include "qemu/error-report.h"
 
@@ -677,7 +678,16 @@ static void s390_pcihost_hot_plug(HotplugHandler *hotplug_dev,
     S390PCIBusDevice *pbdev = NULL;
     S390pciState *s = s390_get_phb();
 
-    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
+        BusState *bus;
+        PCIBridge *pb = PCI_BRIDGE(dev);
+
+        pci_bridge_map_irq(pb, dev->id, s390_pci_map_irq);
+        pci_setup_iommu(&pb->sec_bus, s390_pci_dma_iommu, s);
+
+        bus = BUS(&pb->sec_bus);
+        qbus_set_hotplug_handler(bus, DEVICE(s), errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
         pdev = PCI_DEVICE(dev);
 
         if (!dev->id) {
@@ -754,7 +764,10 @@ static void s390_pcihost_hot_unplug(HotplugHandler *hotplug_dev,
     S390PCIBusDevice *pbdev = NULL;
     S390pciState *s = s390_get_phb();
 
-    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
+        error_setg(errp, "PCI bridge hot unplug currently not supported");
+        return;
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
         pci_dev = PCI_DEVICE(dev);
 
         QTAILQ_FOREACH(pbdev, &s->zpci_devs, link) {
-- 
2.11.0
