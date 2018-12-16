Received: from eggs.gnu.org ([2001:4830:134:3::10]:44786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1gYeKr-0002wM-Mb
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 16:52:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1gYeKn-0004DH-Ky
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 16:52:29 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52769)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1gYeKn-0004D3-Ep
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 16:52:25 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so10522512wml.2
	for <qemu-devel@nongnu.org>; Sun, 16 Dec 2018 13:52:25 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
Date: Sun, 16 Dec 2018 22:52:10 +0100
Message-Id: <20181216215210.29088-1-huth@tuxfamily.org>
Subject: [Qemu-devel] [PATCH] hw/sparc64: Create VGA device only if it has
 really been requested
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org

The sun4u/sun4v machine currently always creates a VGA device, even if
the user started QEMU with "-nodefaults" or "-vga none". That's likely
not what the users expect in this case, so add a check whether the VGA
adapter has really been requested.

Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/sparc64/sun4u.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index f76b19e4e9..ce7236c322 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -596,7 +596,15 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     qdev_connect_gpio_out_named(DEVICE(ebus), "isa-irq", 4,
         qdev_get_gpio_in_named(DEVICE(sabre), "pbm-irq", OBIO_SER_IRQ));
 
-    pci_dev = pci_create_simple(pci_busA, PCI_DEVFN(2, 0), "VGA");
+    switch (vga_interface_type) {
+    case VGA_STD:
+        pci_create_simple(pci_busA, PCI_DEVFN(2, 0), "VGA");
+        break;
+    case VGA_NONE:
+        break;
+    default:
+       abort();   /* Should not happen - types are checked in vl.c already */
+    }
 
     memset(&macaddr, 0, sizeof(MACAddr));
     onboard_nic = false;
-- 
2.17.2
