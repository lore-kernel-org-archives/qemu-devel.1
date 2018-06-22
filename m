Received: from eggs.gnu.org ([2001:4830:134:3::10]:50105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLdA-0003cZ-QD
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLd9-0005Ss-Ot
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:36 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fWLd9-0005Pf-HZ
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:35 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLd8-00041h-7M
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:57:34 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 13:57:13 +0100
Message-Id: <20180622125713.15303-29-peter.maydell@linaro.org>
In-Reply-To: <20180622125713.15303-1-peter.maydell@linaro.org>
References: <20180622125713.15303-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 28/28] xen: Don't use
 memory_region_init_ram_nomigrate() in pci_assign_dev_load_option_rom()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The xen pci_assign_dev_load_option_rom() currently creates a RAM
memory region with memory_region_init_ram_nomigrate(), and then
manually registers it with vmstate_register_ram(). In fact for
its only callsite, the 'owner' pointer we use for the init call
and the '&dev->qdev' pointer we use for the vmstate_register_ram()
call refer to the same object. Simplify the function to only
take a pointer to the device once instead of twice, and use
memory_region_init_ram() which automatically does the vmstate
register for us.

Acked-by: Anthony PERARD <anthony.perard@citrix.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/xen/xen_pt.h          | 2 +-
 hw/xen/xen_pt_graphics.c | 2 +-
 hw/xen/xen_pt_load_rom.c | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/xen/xen_pt.h b/hw/xen/xen_pt.h
index aa39a9aa5f3..dbee3308fdf 100644
--- a/hw/xen/xen_pt.h
+++ b/hw/xen/xen_pt.h
@@ -319,7 +319,7 @@ static inline bool xen_pt_has_msix_mapping(XenPCIPassthroughState *s, int bar)
 }
 
 extern void *pci_assign_dev_load_option_rom(PCIDevice *dev,
-                                            struct Object *owner, int *size,
+                                            int *size,
                                             unsigned int domain,
                                             unsigned int bus, unsigned int slot,
                                             unsigned int function);
diff --git a/hw/xen/xen_pt_graphics.c b/hw/xen/xen_pt_graphics.c
index 0f4c8d77e2a..135c8df1e72 100644
--- a/hw/xen/xen_pt_graphics.c
+++ b/hw/xen/xen_pt_graphics.c
@@ -132,7 +132,7 @@ int xen_pt_unregister_vga_regions(XenHostPCIDevice *dev)
 static void *get_vgabios(XenPCIPassthroughState *s, int *size,
                        XenHostPCIDevice *dev)
 {
-    return pci_assign_dev_load_option_rom(&s->dev, OBJECT(&s->dev), size,
+    return pci_assign_dev_load_option_rom(&s->dev, size,
                                           dev->domain, dev->bus,
                                           dev->dev, dev->func);
 }
diff --git a/hw/xen/xen_pt_load_rom.c b/hw/xen/xen_pt_load_rom.c
index 71063c4d792..e6a86ca8180 100644
--- a/hw/xen/xen_pt_load_rom.c
+++ b/hw/xen/xen_pt_load_rom.c
@@ -19,7 +19,7 @@
  * load the corresponding ROM data to RAM. If an error occurs while loading an
  * option ROM, we just ignore that option ROM and continue with the next one.
  */
-void *pci_assign_dev_load_option_rom(PCIDevice *dev, struct Object *owner,
+void *pci_assign_dev_load_option_rom(PCIDevice *dev,
                                      int *size, unsigned int domain,
                                      unsigned int bus, unsigned int slot,
                                      unsigned int function)
@@ -29,6 +29,7 @@ void *pci_assign_dev_load_option_rom(PCIDevice *dev, struct Object *owner,
     uint8_t val;
     struct stat st;
     void *ptr = NULL;
+    Object *owner = OBJECT(dev);
 
     /* If loading ROM from file, pci handles it */
     if (dev->romfile || !dev->rom_bar) {
@@ -59,8 +60,7 @@ void *pci_assign_dev_load_option_rom(PCIDevice *dev, struct Object *owner,
     fseek(fp, 0, SEEK_SET);
 
     snprintf(name, sizeof(name), "%s.rom", object_get_typename(owner));
-    memory_region_init_ram_nomigrate(&dev->rom, owner, name, st.st_size, &error_abort);
-    vmstate_register_ram(&dev->rom, &dev->qdev);
+    memory_region_init_ram(&dev->rom, owner, name, st.st_size, &error_abort);
     ptr = memory_region_get_ram_ptr(&dev->rom);
     memset(ptr, 0xff, st.st_size);
 
-- 
2.17.1
