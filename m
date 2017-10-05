Received: from eggs.gnu.org ([2001:4830:134:3::10]:60180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1e05OG-0001fF-C1
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:36:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1e05OD-0001tC-7s
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:36:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56636
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1e05OD-0001s7-2J
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:36:33 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v95CZO9u049949
	for <qemu-devel@nongnu.org>; Thu, 5 Oct 2017 08:36:28 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ddmbk1y8n-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 08:36:28 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Thu, 5 Oct 2017 13:36:27 +0100
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Thu,  5 Oct 2017 14:36:23 +0200
In-Reply-To: <1507206983-16096-1-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1507206983-16096-1-git-send-email-pmorel@linux.vnet.ibm.com>
Message-Id: <1507206983-16096-2-git-send-email-pmorel@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1] pci: Set PCI-bus device entry before
 initializing bus master
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel@redhat.com, cohuck@redhat.com, zyimin@linux.vnet.ibm.com

When initializing the PCI-bus master pci_init_bus_master(PCIDevice *)
calls pci_device_iommu_address_space(PCIDevice *) which in turn calls
iommu_bus->iommu_fn(bus, opaque,devfn)

If the device entry of the PCI-bus is not initialized to point to the
PCIDevice structure, the iommu_fn() function, getting only bus and
devno, is unable to retrieve the PCIDevice.

Usually it is not a problem as the DMA address space is depending of
the BUS but in an architecture like S390, each PCI Device can have
its own DMA address space.
Being able to setup the DMA address space at the right moment will
greatly simplify the implementation.

This patch proposes to setup the bus device entry before calling
pci_init_bus_master() and reset the entry in case of error.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 hw/pci/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 1e6fb88..3e64492 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1026,6 +1026,7 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
     address_space_init(&pci_dev->bus_master_as,
                        &pci_dev->bus_master_container_region, pci_dev->name);
 
+    bus->devices[devfn] = pci_dev;
     if (qdev_hotplug) {
         pci_init_bus_master(pci_dev);
     }
@@ -1062,6 +1063,7 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
     if (local_err) {
         error_propagate(errp, local_err);
         do_pci_unregister_device(pci_dev);
+        bus->devices[devfn] = NULL;
         return NULL;
     }
 
@@ -1071,7 +1073,6 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
         config_write = pci_default_write_config;
     pci_dev->config_read = config_read;
     pci_dev->config_write = config_write;
-    bus->devices[devfn] = pci_dev;
     pci_dev->version_id = 2; /* Current pci device vmstate version */
     return pci_dev;
 }
-- 
2.7.4
