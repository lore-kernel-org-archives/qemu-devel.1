Received: from eggs.gnu.org ([2001:4830:134:3::10]:34331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g8SYM-0003ou-Vo
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:02:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g8SYF-0001im-Rq
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:02:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1g8SYA-0001dk-2K
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:02:00 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  5 Oct 2018 18:01:47 +0200
Message-Id: <20181005160147.892-3-kraxel@redhat.com>
In-Reply-To: <20181005160147.892-1-kraxel@redhat.com>
References: <20181005160147.892-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] bochs-display: wire up edid support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/bochs-display.c | 13 +++++++++++++
 hw/display/Makefile.objs   |  1 +
 2 files changed, 14 insertions(+)

diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index 09d8944a1b..3d439eb240 100644
--- a/hw/display/bochs-display.c
+++ b/hw/display/bochs-display.c
@@ -9,6 +9,7 @@
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "hw/display/bochs-vbe.h"
+#include "hw/display/edid.h"
 
 #include "qapi/error.h"
 
@@ -35,9 +36,13 @@ typedef struct BochsDisplayState {
     MemoryRegion     mmio;
     MemoryRegion     vbe;
     MemoryRegion     qext;
+    MemoryRegion     edid;
 
     /* device config */
     uint64_t         vgamem;
+    bool             enable_edid;
+    qemu_edid_info   edid_info;
+    uint8_t          edid_blob[256];
 
     /* device registers */
     uint16_t         vbe_regs[VBE_DISPI_INDEX_NB];
@@ -283,6 +288,12 @@ static void bochs_display_realize(PCIDevice *dev, Error **errp)
     pci_register_bar(&s->pci, 0, PCI_BASE_ADDRESS_MEM_PREFETCH, &s->vram);
     pci_register_bar(&s->pci, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mmio);
 
+    if (s->enable_edid) {
+        qemu_edid_generate(s->edid_blob, sizeof(s->edid_blob), &s->edid_info);
+        qemu_edid_region_io(&s->edid, obj, s->edid_blob, sizeof(s->edid_blob));
+        memory_region_add_subregion(&s->mmio, 0, &s->edid);
+    }
+
     if (pci_bus_is_express(pci_get_bus(dev))) {
         dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
         ret = pcie_endpoint_cap_init(dev, 0x80);
@@ -325,6 +336,8 @@ static void bochs_display_exit(PCIDevice *dev)
 
 static Property bochs_display_properties[] = {
     DEFINE_PROP_SIZE("vgamem", BochsDisplayState, vgamem, 16 * MiB),
+    DEFINE_PROP_BOOL("edid", BochsDisplayState, enable_edid, false),
+    DEFINE_EDID_PROPERTIES(BochsDisplayState, edid_info),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index 2a0de16a55..2e1b1bcd22 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -19,6 +19,7 @@ common-obj-$(CONFIG_VGA_ISA) += vga-isa.o
 common-obj-$(CONFIG_VGA_ISA_MM) += vga-isa-mm.o
 common-obj-$(CONFIG_VMWARE_VGA) += vmware_vga.o
 common-obj-$(CONFIG_BOCHS_DISPLAY) += bochs-display.o
+common-obj-$(CONFIG_BOCHS_DISPLAY) += edid-region.o
 
 common-obj-$(CONFIG_BLIZZARD) += blizzard.o
 common-obj-$(CONFIG_EXYNOS4) += exynos4210_fimd.o
-- 
2.9.3
