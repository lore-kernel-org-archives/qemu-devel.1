Received: from eggs.gnu.org ([209.51.188.92]:51833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gpN8g-0007pV-I6
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 19:57:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gpN8f-0006uK-3u
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 19:57:02 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Fri,  1 Feb 2019 11:56:22 +1100
Message-Id: <20190201005622.14716-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu] spapr_pci: Fix endianness in
 assigned-addresses property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Michael Roth <mdroth@linux.ibm.com>

reg->phys_hi and assigned->phys_hi are big endian but we do an extra
byteswap anyway when copying reg->phys_hi to assigned->phys_hi.
To make things slightly more messy, we also add a relocatable bit (b_n())
although in the right endianness.

This fixes endianness of assigned->phys_hi.

This is unlikely to produce any visible difference though as we should end up
there only in the case of PCI hotplug and even then I am not sure if
(d->io_regions[i].addr == PCI_BAR_UNMAPPED) == true.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 hw/ppc/spapr_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index b74f263..a174952 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -964,7 +964,7 @@ static void populate_resource_props(PCIDevice *d, ResourceProps *rp)
         }
 
         assigned = &rp->assigned[assigned_idx++];
-        assigned->phys_hi = cpu_to_be32(reg->phys_hi | b_n(1));
+        assigned->phys_hi = cpu_to_be32(be32_to_cpu(reg->phys_hi) | b_n(1));
         assigned->phys_mid = cpu_to_be32(d->io_regions[i].addr >> 32);
         assigned->phys_lo = cpu_to_be32(d->io_regions[i].addr);
         assigned->size_hi = reg->size_hi;
-- 
2.17.1
