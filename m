Received: from eggs.gnu.org ([2001:4830:134:3::10]:58932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOoKb-00032O-Gy
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 13:59:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOoKa-0004ty-Gt
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 13:59:17 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fOoKa-0004rN-9l
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 13:59:16 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Jun 2018 18:59:10 +0100
Message-Id: <20180601175910.28146-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [RFC] xen: Don't use
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
Cc: patches@linaro.org, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org

The xen pci_assign_dev_load_option_rom() currently creates a RAM
memory region with memory_region_init_ram_nomigrate(), and then
manually registers it with vmstate_register_ram(). In fact for
its only callsite, the 'owner' pointer we use for the init call
and the '&dev->qdev' pointer we use for the vmstate_register_ram()
call refer to the same object. Simplify the function to only
take a pointer to the device once instead of twice, and use
memory_region_init_ram() which automatically does the vmstate
register for us.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This is a fairly trivial no-behaviour-change code cleanup, but
I've marked it as RFC because I don't have a setup for doing
more than just compile-testing Xen related patches.
This was found as part of a sweep through for code using
the _nomigrate versions of functions.

 hw/xen/xen_pt.h          | 2 +-
 hw/xen/xen_pt_graphics.c | 2 +-
 hw/xen/xen_pt_load_rom.c | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/xen/xen_pt.h b/hw/xen/xen_pt.h
index aa39a9aa5f..dbee3308fd 100644
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
index 0f4c8d77e2..135c8df1e7 100644
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
index 71063c4d79..e6a86ca818 100644
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
