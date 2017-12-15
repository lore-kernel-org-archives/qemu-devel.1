Received: from eggs.gnu.org ([2001:4830:134:3::10]:53207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePixM-0003dc-Pb
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 00:54:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePixL-0004fV-Da
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 00:54:48 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 15 Dec 2017 16:54:20 +1100
Message-Id: <20171215055435.24204-10-david@gibson.dropbear.id.au>
In-Reply-To: <20171215055435.24204-1-david@gibson.dropbear.id.au>
References: <20171215055435.24204-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 09/24] e500: fix pci host bridge class/type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, mdroth@linux.vnet.ibm.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Michael Davidsaver <mdavidsaver@gmail.com>

Correct some confusion wrt. the PCI facing
side of the PCI host bridge (not PCIe root complex).
The ref. manual for the mpc8533 (as well as
mpc8540 and mpc8540) give the class code as
PCI_CLASS_PROCESSOR_POWERPC.
While the PCI_HEADER_TYPE field is oddly omitted,
the tables in the "PCI Configuration Header"
section shows a type 0 layout using all 6 BAR
registers (as 2x 32, and 2x 64 bit regions)

So 997505065dc92e533debf5cb23012ba4e673d387
seems to be in error.  Although there was
perhaps some confusion as the mpc8533
has a separate PCIe root complex.
With PCIe, a root complex has PCI_HEADER_TYPE=1.

Neither the PCI host bridge, nor the PCIe
root complex advertise class PCI_CLASS_BRIDGE_PCI.

This was confusing Linux guests, which try
to interpret the host bridge as a pci-pci
bridge, but get confused and re-enumerate
the bus when the primary/secondary/subordinate
bus registers don't have valid values.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/pci-host/ppce500.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index 39cd24464d..279badc894 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -423,11 +423,6 @@ static void e500_pcihost_bridge_realize(PCIDevice *d, Error **errp)
     PPCE500CCSRState *ccsr = CCSR(container_get(qdev_get_machine(),
                                   "/e500-ccsr"));
 
-    pci_config_set_class(d->config, PCI_CLASS_BRIDGE_PCI);
-    d->config[PCI_HEADER_TYPE] =
-        (d->config[PCI_HEADER_TYPE] & PCI_HEADER_TYPE_MULTI_FUNCTION) |
-        PCI_HEADER_TYPE_BRIDGE;
-
     memory_region_init_alias(&b->bar0, OBJECT(ccsr), "e500-pci-bar0", &ccsr->ccsr_space,
                              0, int128_get64(ccsr->ccsr_space.size));
     pci_register_bar(d, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &b->bar0);
-- 
2.14.3
