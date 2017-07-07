Received: from eggs.gnu.org ([2001:4830:134:3::10]:54452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dTUTR-0005qK-9d
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:43:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dTUTQ-00043k-Cg
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:43:13 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dTUTQ-00040L-4z
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:43:12 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  7 Jul 2017 15:42:56 +0100
Message-Id: <1499438577-7674-11-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1499438577-7674-1-git-send-email-peter.maydell@linaro.org>
References: <1499438577-7674-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 10/11] hw/display/qxl.c Use
 memory_region_init_ram()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Switch to memory_region_init_ram(), since we pass the same DeviceState
to both memory_region_init_ram_nomigrate() and vmstate_register_ram().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/display/qxl.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 40e9372..7f8c73b 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -2089,16 +2089,14 @@ static void qxl_realize_common(PCIQXLDevice *qxl, Error **errp)
     pci_set_byte(&config[PCI_INTERRUPT_PIN], 1);
 
     qxl->rom_size = qxl_rom_size();
-    memory_region_init_ram_nomigrate(&qxl->rom_bar, OBJECT(qxl), "qxl.vrom",
+    memory_region_init_ram(&qxl->rom_bar, OBJECT(qxl), "qxl.vrom",
                            qxl->rom_size, &error_fatal);
-    vmstate_register_ram(&qxl->rom_bar, &qxl->pci.qdev);
     init_qxl_rom(qxl);
     init_qxl_ram(qxl);
 
     qxl->guest_surfaces.cmds = g_new0(QXLPHYSICAL, qxl->ssd.num_surfaces);
-    memory_region_init_ram_nomigrate(&qxl->vram_bar, OBJECT(qxl), "qxl.vram",
+    memory_region_init_ram(&qxl->vram_bar, OBJECT(qxl), "qxl.vram",
                            qxl->vram_size, &error_fatal);
-    vmstate_register_ram(&qxl->vram_bar, &qxl->pci.qdev);
     memory_region_init_alias(&qxl->vram32_bar, OBJECT(qxl), "qxl.vram32",
                              &qxl->vram_bar, 0, qxl->vram32_size);
 
@@ -2198,9 +2196,8 @@ static void qxl_realize_secondary(PCIDevice *dev, Error **errp)
 
     qxl->id = device_id++;
     qxl_init_ramsize(qxl);
-    memory_region_init_ram_nomigrate(&qxl->vga.vram, OBJECT(dev), "qxl.vgavram",
+    memory_region_init_ram(&qxl->vga.vram, OBJECT(dev), "qxl.vgavram",
                            qxl->vga.vram_size, &error_fatal);
-    vmstate_register_ram(&qxl->vga.vram, &qxl->pci.qdev);
     qxl->vga.vram_ptr = memory_region_get_ram_ptr(&qxl->vga.vram);
     qxl->vga.con = graphic_console_init(DEVICE(dev), 0, &qxl_ops, qxl);
 
-- 
2.7.4
