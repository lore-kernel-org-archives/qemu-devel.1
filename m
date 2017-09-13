Received: from eggs.gnu.org ([2001:4830:134:3::10]:49256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ds41v-00068F-6K
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:32:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ds41s-0004L4-6h
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:32:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ds41r-0004Jz-VU
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:32:20 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 13 Sep 2017 11:32:12 +0200
Message-Id: <20170913093215.10043-2-kraxel@redhat.com>
In-Reply-To: <20170913093215.10043-1-kraxel@redhat.com>
References: <20170913093215.10043-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/4] xhci: Avoid DMA when ERSTBA is set to zero
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

From: Alexey Kardashevskiy <aik@ozlabs.ru>

The existing XHCI code reads the Event Ring Segment Table Base Address
Register (ERSTBA) every time when it is changed. However zero is its
default state so one would think that zero there means it is not in use.

This adds a check for ERSTBA in addition to the existing check for
the Event Ring Segment Table Size Register (ERSTSZ).

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-id: 20170911065606.40600-1-aik@ozlabs.ru
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
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
2.9.3
