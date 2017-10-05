Received: from eggs.gnu.org ([2001:4830:134:3::10]:60159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1e05OF-0001fC-Pc
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1e05OC-0001s0-N4
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:36:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38620
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1e05OC-0001rW-Fy
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:36:32 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v95CYT8B099985
	for <qemu-devel@nongnu.org>; Thu, 5 Oct 2017 08:36:27 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ddhdgt7he-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 08:36:27 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Thu, 5 Oct 2017 13:36:25 +0100
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Thu,  5 Oct 2017 14:36:22 +0200
Message-Id: <1507206983-16096-1-git-send-email-pmorel@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1][RFC] pci: Set PCI-bus device entry before
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
the BUS but in an architecture like S390x, each PCI Device can have
its own DMA address space.
Being able to setup the DMA address space at the right moment will
greatly simplify the hotplug implementation for these architectures.

This patch proposes to setup the bus device entry before calling
pci_init_bus_master() and reset the entry in case of error.


Pierre Morel (1):
  pci: Set PCI-bus device entry before initializing bus master

 hw/pci/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.7.4
