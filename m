Received: from eggs.gnu.org ([209.51.188.92]:58620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1grUmy-0002oD-W3
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 16:31:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1grUmw-00049L-Vz
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 16:31:24 -0500
Received: from chuckie.co.uk ([82.165.15.123]:41958
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1grUmt-00040z-5w
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 16:31:20 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed,  6 Feb 2019 21:30:40 +0000
Message-Id: <20190206213042.12537-2-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190206213042.12537-1-mark.cave-ayland@ilande.co.uk>
References: <20190206213042.12537-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PULL 1/3] hw/sparc64: Create VGA device only if it
 has really been requested
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org

From: Thomas Huth <huth@tuxfamily.org>

The sun4u/sun4v machine currently always creates a VGA device, even if
the user started QEMU with "-nodefaults" or "-vga none". That's likely
not what the users expect in this case, so add a check whether the VGA
adapter has really been requested.

Signed-off-by: Thomas Huth <huth@tuxfamily.org>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/sparc64/sun4u.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index f76b19e4e9..37ecc14c6d 100644
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
+        abort();   /* Should not happen - types are checked in vl.c already */
+    }
 
     memset(&macaddr, 0, sizeof(MACAddr));
     onboard_nic = false;
-- 
2.11.0
