Received: from eggs.gnu.org ([209.51.188.92]:38264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hEccu-00030n-7s
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:32:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hEccs-0005jk-Ns
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:32:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58024
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hEccs-0005iy-CJ
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:32:34 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3BGVGan024341
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 12:32:30 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rt964g29m-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 12:32:30 -0400
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 11 Apr 2019 17:32:28 +0100
From: Greg Kurz <groug@kaod.org>
Date: Thu, 11 Apr 2019 18:32:24 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <155500034416.646888.1307366522340665522.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: [Qemu-devel] [PATCH for-4.0] spapr_pci: Fix broken naming of PCI bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Recent commit 5cf0d326a0fe fixed a regression which was preventing the
guest to access the extended config space of a PCIe device. This was
done by introducing a new PCI bus subtype for PAPR. The original fix
was causing PCI busses to be named "spapr-pci-host-bridge-root-bus.N"
instead of "pci.N", which was making upper layers unhappy of course.
This got worked around by hardcoding the PCI bus name to "pci.0", but
this only works for the default PHB. And we're now hitting:

# qemu-system-ppc64 \
             -device spapr-pci-host-bridge,index=1 \
             -device e1000e,bus=pci.0 \
             -device e1000e,bus=pci.1
qemu-system-ppc64: -device e1000e,bus=pci.1: Bus 'pci.1' not found

David already posted some patches [1] to control PCI extended config
space accesses with a new flag in the base PCI bus class instead of
subtyping. These patches are a bit more intrusive though, and
are targetted for 4.1.

When no name is passed to pci_register_bus(), the core device code
generates a lowercase name based on the QOM typename. The typename
for the base PCI bus class is "PCI", hence the "pci.0", "pci.1"
bus names. Rename the type of the PAPR PCI bus to "pci", so that
the QOM code can generate proper names. This is a hack but it is
enough to fix the regression. And all this will be reworked properly
in 4.1.

[1] https://patchwork.ozlabs.org/project/qemu-devel/list/?series=100486

Fixes: 5cf0d326a0fe
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_pci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index f0b6b23afc9b..f62e6833b8c9 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1652,7 +1652,7 @@ static void spapr_phb_root_bus_class_init(ObjectClass *klass, void *data)
     pbc->allows_extended_config_space = spapr_phb_allows_extended_config_space;
 }
 
-#define TYPE_SPAPR_PHB_ROOT_BUS "spapr-pci-host-bridge-root-bus"
+#define TYPE_SPAPR_PHB_ROOT_BUS "pci"
 
 static const TypeInfo spapr_phb_root_bus_info = {
     .name = TYPE_SPAPR_PHB_ROOT_BUS,
@@ -1761,7 +1761,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(get_system_memory(), sphb->io_win_addr,
                                 &sphb->iowindow);
 
-    bus = pci_register_root_bus(dev, "pci.0",
+    bus = pci_register_root_bus(dev, NULL,
                                 pci_spapr_set_irq, pci_spapr_map_irq, sphb,
                                 &sphb->memspace, &sphb->iospace,
                                 PCI_DEVFN(0, 0), PCI_NUM_PINS,
