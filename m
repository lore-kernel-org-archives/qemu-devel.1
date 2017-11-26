Received: from eggs.gnu.org ([2001:4830:134:3::10]:56846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eJ4xq-00072q-Mf
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 16:59:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eJ4xp-0002ub-RJ
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 16:59:50 -0500
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sun, 26 Nov 2017 15:59:05 -0600
Message-Id: <2e4d338f84913729f8ab51837fbcb94b0958a745.1511731946.git.mdavidsaver@gmail.com>
In-Reply-To: <cover.1511731946.git.mdavidsaver@gmail.com>
References: <cover.1511731946.git.mdavidsaver@gmail.com>
In-Reply-To: <cover.1511731946.git.mdavidsaver@gmail.com>
References: <cover.1511731946.git.mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 07/17] e500: fix pci host bridge class/type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

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
---
 hw/pci-host/ppce500.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index f2d108bc8a..8073d396ff 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -423,11 +423,6 @@ static void e500_pcihost_bridge_realize(PCIDevice *d, Error **errp)
                                                       "/e500-ccsr"));
     MemoryRegion *ccsr_mr = sysbus_mmio_get_region(ccsr, 0);
 
-    pci_config_set_class(d->config, PCI_CLASS_BRIDGE_PCI);
-    d->config[PCI_HEADER_TYPE] =
-        (d->config[PCI_HEADER_TYPE] & PCI_HEADER_TYPE_MULTI_FUNCTION) |
-        PCI_HEADER_TYPE_BRIDGE;
-
     memory_region_init_alias(&b->bar0, OBJECT(ccsr), "e500-pci-bar0", ccsr_mr,
                              0, memory_region_size(ccsr_mr));
     pci_register_bar(d, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &b->bar0);
-- 
2.11.0
