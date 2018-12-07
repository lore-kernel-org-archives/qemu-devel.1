Received: from eggs.gnu.org ([2001:4830:134:3::10]:39789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gVIfz-00026d-Al
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:08:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gVIfx-0001tk-2g
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:08:27 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri,  7 Dec 2018 16:08:05 +0000
Message-Id: <20181207160806.13569-3-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20181207160806.13569-1-mark.cave-ayland@ilande.co.uk>
References: <20181207160806.13569-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 2/3] mac_newworld: enable access to EDID data
 for the VGA device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

This is in preparation for some upcoming QEMU NDRV driver changes that pass
display information from the host to the guest.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ppc/mac_newworld.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 14273a123e..df0a2f03ff 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -430,7 +430,10 @@ static void ppc_core99_init(MachineState *machine)
         }
     }
 
-    pci_vga_init(pci_bus);
+    dev = qdev_create(BUS(pci_bus), "VGA");
+    qdev_prop_set_int32(dev, "addr", -1);
+    qdev_prop_set_bit(dev, "edid", true);
+    qdev_init_nofail(dev);
 
     if (graphic_depth != 15 && graphic_depth != 32 && graphic_depth != 8) {
         graphic_depth = 15;
-- 
2.11.0
