Received: from eggs.gnu.org ([2001:4830:134:3::10]:60628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1drIeE-0006Vv-0n
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 02:56:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1drIeA-0007Ds-1o
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 02:56:46 -0400
Received: from ozlabs.ru ([107.173.13.209]:46606)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1drIe9-0007Dg-Rr
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 02:56:41 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Mon, 11 Sep 2017 16:56:06 +1000
Message-Id: <20170911065606.40600-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu] xhci: Avoid DMA when ERSTBA is set to zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Gerd Hoffmann <kraxel@redhat.com>

The existing XHCI code reads the Event Ring Segment Table Base Address
Register (ERSTBA) every time when it is changed. However zero is its
default state so one would think that zero there means it is not in use.

This adds a check for ERSTBA in addition to the existing check for
the Event Ring Segment Table Size Register (ERSTSZ).

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

On pseries, the SLOF firmware initializes XHCI and sets non-zero value
to ERSTBA. Then, it jumps to the guest and the guest requests the SLOF
to quiesce devices, that includes XHCI. SLOF removes DMA mappings and
writes 0 to ERSTBA, writing to its high part triggers xhci_er_reset()
in QEMU which calls pci_dma_read(PCI_DEVICE(xhci), erstba,...) which
ends up in unassigned_mem_accepts as IOMMU translation entry for 0 is
missing (and it is missing always on pseries, at least in practice).

However the very same SLOF driver does not cause EEH (that would be
hardware reaction on missing IOMMU translation entry) on the real POWER8
system with "Texas Instruments TUSB73x0 SuperSpeed USB 3.0 xHCI
Host Controller" passed via VFIO which made me think that this patch is
a useful thing to have anyway as this is what the hardware does,
i.e. tolerates some misconfiguration.

And yes, we will fix SLOF to reset ERSTSZ in addition to ERSTBA anyway.

The XHCI spec, just in case:
https://www.intel.com.au/content/dam/www/public/us/en/documents/technical-specifications/extensible-host-controler-interface-usb-xhci.pdf
---
 hw/usb/hcd-xhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 204ea69d3f..d75c085d94 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -811,8 +811,9 @@ static void xhci_er_reset(XHCIState *xhci, int v)
 {
     XHCIInterrupter *intr = &xhci->intr[v];
     XHCIEvRingSeg seg;
+    dma_addr_t erstba = xhci_addr64(intr->erstba_low, intr->erstba_high);
 
-    if (intr->erstsz == 0) {
+    if (intr->erstsz == 0 || erstba == 0) {
         /* disabled */
         intr->er_start = 0;
         intr->er_size = 0;
@@ -824,7 +825,6 @@ static void xhci_er_reset(XHCIState *xhci, int v)
         xhci_die(xhci);
         return;
     }
-    dma_addr_t erstba = xhci_addr64(intr->erstba_low, intr->erstba_high);
     pci_dma_read(PCI_DEVICE(xhci), erstba, &seg, sizeof(seg));
     le32_to_cpus(&seg.addr_low);
     le32_to_cpus(&seg.addr_high);
-- 
2.11.0
