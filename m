Received: from eggs.gnu.org ([2001:4830:134:3::10]:39791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gVIfz-00026k-BU
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:08:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gVIfx-0001v9-GB
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:08:27 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri,  7 Dec 2018 16:08:06 +0000
Message-Id: <20181207160806.13569-4-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20181207160806.13569-1-mark.cave-ayland@ilande.co.uk>
References: <20181207160806.13569-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 3/3] mac_oldworld: enable access to EDID data
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
 hw/ppc/mac_oldworld.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 9891c325a9..1000570ffd 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -271,7 +271,10 @@ static void ppc_heathrow_init(MachineState *machine)
 
     pci_bus = PCI_HOST_BRIDGE(dev)->bus;
 
-    pci_vga_init(pci_bus);
+    dev = qdev_create(BUS(pci_bus), "VGA");
+    qdev_prop_set_int32(dev, "addr", -1);
+    qdev_prop_set_bit(dev, "edid", true);
+    qdev_init_nofail(dev);
 
     for (i = 0; i < nb_nics; i++) {
         pci_nic_init_nofail(&nd_table[i], pci_bus, "ne2k_pci", NULL);
-- 
2.11.0
