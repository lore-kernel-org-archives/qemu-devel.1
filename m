Received: from eggs.gnu.org ([2001:4830:134:3::10]:56310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dV36J-0001JQ-Dx
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dV36G-0005M8-Tp
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:53:47 -0400
Received: from chuckie.co.uk ([82.165.15.123]:35123
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dV36G-0005LT-MH
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:53:44 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue, 11 Jul 2017 22:53:22 +0100
Message-Id: <1499810007-28613-4-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1499810007-28613-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1499810007-28613-1-git-send-email-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/8] sun4u: expose fw_cfg and NVRAM on ebus PCI
 IO address space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

To allow future changes to the sun4u PCI topology.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-By: Artyom Tarasenko <atar4qemu@gmail.com>
---
 hw/sparc64/sun4u.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 8932be9..4f96d97 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -450,7 +450,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
                            &pci_bus3, &pbm_irqs);
     pci_vga_init(pci_bus);
 
-    // XXX Should be pci_bus3
+    /* XXX Should be pci_bus3 */
     ebus = pci_create_simple(pci_bus, -1, "ebus");
     isa_bus = pci_ebus_init(ebus, pbm_irqs);
 
@@ -492,7 +492,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     /* Map NVRAM into I/O (ebus) space */
     nvram = m48t59_init(NULL, 0, 0, NVRAM_SIZE, 1968, 59);
     s = SYS_BUS_DEVICE(nvram);
-    memory_region_add_subregion(get_system_io(), 0x2000,
+    memory_region_add_subregion(pci_address_space_io(ebus), 0x2000,
                                 sysbus_mmio_get_region(s, 0));
  
     initrd_size = 0;
@@ -514,10 +514,9 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
 
     dev = qdev_create(NULL, TYPE_FW_CFG_IO);
     qdev_prop_set_bit(dev, "dma_enabled", false);
-    object_property_add_child(OBJECT(qdev_get_machine()), TYPE_FW_CFG,
-                              OBJECT(dev), NULL);
+    object_property_add_child(OBJECT(ebus), TYPE_FW_CFG, OBJECT(dev), NULL);
     qdev_init_nofail(dev);
-    memory_region_add_subregion(get_system_io(), BIOS_CFG_IOPORT,
+    memory_region_add_subregion(pci_address_space_io(ebus), BIOS_CFG_IOPORT,
                                 &FW_CFG_IO(dev)->comb_iomem);
 
     fw_cfg = FW_CFG(dev);
-- 
1.7.10.4
