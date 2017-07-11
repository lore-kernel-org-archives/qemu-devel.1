Received: from eggs.gnu.org ([2001:4830:134:3::10]:56371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dV36M-0001Kk-7y
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:53:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dV36L-0005Or-IM
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:53:50 -0400
Received: from chuckie.co.uk ([82.165.15.123]:35135
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dV36L-0005OG-BG
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:53:49 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue, 11 Jul 2017 22:53:26 +0100
Message-Id: <1499810007-28613-8-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1499810007-28613-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1499810007-28613-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 7/8] sun4u: create single default onboard
 ne2k_pci NIC for machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

As we move towards a real Ultra 5 machine, allow only a single NIC
to be instantiated with the legacy net options. More devices can
be added with the new -netdev and -device options if required.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/sparc64/sun4u.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 5ddd30f..3bb3bf2 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -427,7 +427,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     unsigned int i;
     uint64_t initrd_addr, initrd_size, kernel_addr, kernel_size, kernel_entry;
     PCIBus *pci_bus, *pci_busA, *pci_busB;
-    PCIDevice *ebus;
+    PCIDevice *ebus, *pci_dev;
     ISABus *isa_bus;
     SysBusDevice *s;
     qemu_irq *ivec_irqs, *pbm_irqs;
@@ -464,8 +464,10 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     serial_hds_isa_init(isa_bus, i, MAX_SERIAL_PORTS);
     parallel_hds_isa_init(isa_bus, MAX_PARALLEL_PORTS);
 
-    for(i = 0; i < nb_nics; i++)
-        pci_nic_init_nofail(&nd_table[i], pci_bus, "ne2k_pci", NULL);
+    pci_dev = pci_create(pci_bus, -1, "ne2k_pci");
+    dev = &pci_dev->qdev;
+    qdev_set_nic_properties(dev, &nd_table[0]);
+    qdev_init_nofail(dev);
 
     ide_drive_get(hd, ARRAY_SIZE(hd));
 
-- 
1.7.10.4
