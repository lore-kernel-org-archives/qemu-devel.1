Received: from eggs.gnu.org ([2001:4830:134:3::10]:35540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eilxP-0001Ve-Vc
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 13:57:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eilxM-0004AI-Rl
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 13:57:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1eilxM-00049S-Ik
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 13:57:32 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BBC6D19CF7A
	for <qemu-devel@nongnu.org>; Mon,  5 Feb 2018 18:57:31 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Mon, 05 Feb 2018 11:57:26 -0700
Message-ID: <20180205185726.14391.25219.stgit@gimli.home>
In-Reply-To: <20180205185416.14391.5739.stgit@gimli.home>
References: <20180205185416.14391.5739.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 05/11] vfio/pci: Add base BAR MemoryRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Add one more layer to our stack of MemoryRegions, this base region
allows us to register BARs independently of the vfio region or to
extend the size of BARs which do map to a region.  This will be
useful when we want hypervisor defined BARs or sections of BARs,
for purposes such as relocating MSI-X emulation.  We therefore call
msix_init() based on this new base MemoryRegion, while the quirks,
which only modify regions still operate on those sub-MemoryRegions.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci.c |   94 ++++++++++++++++++++++++++++++++++++++++++---------------
 hw/vfio/pci.h |    3 ++
 2 files changed, 72 insertions(+), 25 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 2c7129512563..908b8dffca2b 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1087,7 +1087,7 @@ static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
 {
     VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
     VFIORegion *region = &vdev->bars[bar].region;
-    MemoryRegion *mmap_mr, *mr;
+    MemoryRegion *mmap_mr, *region_mr, *base_mr;
     PCIIORegion *r;
     pcibus_t bar_addr;
     uint64_t size = region->size;
@@ -1100,7 +1100,8 @@ static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
 
     r = &pdev->io_regions[bar];
     bar_addr = r->addr;
-    mr = region->mem;
+    base_mr = vdev->bars[bar].mr;
+    region_mr = region->mem;
     mmap_mr = &region->mmaps[0].mem;
 
     /* If BAR is mapped and page aligned, update to fill PAGE_SIZE */
@@ -1111,12 +1112,15 @@ static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
 
     memory_region_transaction_begin();
 
-    memory_region_set_size(mr, size);
+    if (vdev->bars[bar].size < size) {
+        memory_region_set_size(base_mr, size);
+    }
+    memory_region_set_size(region_mr, size);
     memory_region_set_size(mmap_mr, size);
-    if (size != region->size && memory_region_is_mapped(mr)) {
-        memory_region_del_subregion(r->address_space, mr);
+    if (size != vdev->bars[bar].size && memory_region_is_mapped(base_mr)) {
+        memory_region_del_subregion(r->address_space, base_mr);
         memory_region_add_subregion_overlap(r->address_space,
-                                            bar_addr, mr, 0);
+                                            bar_addr, base_mr, 0);
     }
 
     memory_region_transaction_commit();
@@ -1218,8 +1222,8 @@ void vfio_pci_write_config(PCIDevice *pdev,
 
         for (bar = 0; bar < PCI_ROM_SLOT; bar++) {
             if (old_addr[bar] != pdev->io_regions[bar].addr &&
-                pdev->io_regions[bar].size > 0 &&
-                pdev->io_regions[bar].size < qemu_real_host_page_size) {
+                vdev->bars[bar].region.size > 0 &&
+                vdev->bars[bar].region.size < qemu_real_host_page_size) {
                 vfio_sub_page_bar_update_mapping(pdev, bar);
             }
         }
@@ -1440,9 +1444,9 @@ static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
     vdev->msix->pending = g_malloc0(BITS_TO_LONGS(vdev->msix->entries) *
                                     sizeof(unsigned long));
     ret = msix_init(&vdev->pdev, vdev->msix->entries,
-                    vdev->bars[vdev->msix->table_bar].region.mem,
+                    vdev->bars[vdev->msix->table_bar].mr,
                     vdev->msix->table_bar, vdev->msix->table_offset,
-                    vdev->bars[vdev->msix->pba_bar].region.mem,
+                    vdev->bars[vdev->msix->pba_bar].mr,
                     vdev->msix->pba_bar, vdev->msix->pba_offset, pos,
                     &err);
     if (ret < 0) {
@@ -1482,8 +1486,8 @@ static void vfio_teardown_msi(VFIOPCIDevice *vdev)
 
     if (vdev->msix) {
         msix_uninit(&vdev->pdev,
-                    vdev->bars[vdev->msix->table_bar].region.mem,
-                    vdev->bars[vdev->msix->pba_bar].region.mem);
+                    vdev->bars[vdev->msix->table_bar].mr,
+                    vdev->bars[vdev->msix->pba_bar].mr);
         g_free(vdev->msix->pending);
     }
 }
@@ -1500,12 +1504,11 @@ static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled)
     }
 }
 
-static void vfio_bar_setup(VFIOPCIDevice *vdev, int nr)
+static void vfio_bar_prepare(VFIOPCIDevice *vdev, int nr)
 {
     VFIOBAR *bar = &vdev->bars[nr];
 
     uint32_t pci_bar;
-    uint8_t type;
     int ret;
 
     /* Skip both unimplemented BARs and the upper half of 64bit BARS. */
@@ -1524,23 +1527,52 @@ static void vfio_bar_setup(VFIOPCIDevice *vdev, int nr)
     pci_bar = le32_to_cpu(pci_bar);
     bar->ioport = (pci_bar & PCI_BASE_ADDRESS_SPACE_IO);
     bar->mem64 = bar->ioport ? 0 : (pci_bar & PCI_BASE_ADDRESS_MEM_TYPE_64);
-    type = pci_bar & (bar->ioport ? ~PCI_BASE_ADDRESS_IO_MASK :
-                                    ~PCI_BASE_ADDRESS_MEM_MASK);
+    bar->type = pci_bar & (bar->ioport ? ~PCI_BASE_ADDRESS_IO_MASK :
+                                         ~PCI_BASE_ADDRESS_MEM_MASK);
+    bar->size = bar->region.size;
+}
+
+static void vfio_bars_prepare(VFIOPCIDevice *vdev)
+{
+    int i;
+
+    for (i = 0; i < PCI_ROM_SLOT; i++) {
+        vfio_bar_prepare(vdev, i);
+    }
+}
+
+static void vfio_bar_register(VFIOPCIDevice *vdev, int nr)
+{
+    VFIOBAR *bar = &vdev->bars[nr];
+    char *name;
 
-    if (vfio_region_mmap(&bar->region)) {
-        error_report("Failed to mmap %s BAR %d. Performance may be slow",
-                     vdev->vbasedev.name, nr);
+    if (!bar->size) {
+        return;
     }
 
-    pci_register_bar(&vdev->pdev, nr, type, bar->region.mem);
+    bar->mr = g_new0(MemoryRegion, 1);
+    name = g_strdup_printf("%s base BAR %d", vdev->vbasedev.name, nr);
+    memory_region_init_io(bar->mr, OBJECT(vdev), NULL, NULL, name, bar->size);
+    g_free(name);
+
+    if (bar->region.size) {
+        memory_region_add_subregion(bar->mr, 0, bar->region.mem);
+
+        if (vfio_region_mmap(&bar->region)) {
+            error_report("Failed to mmap %s BAR %d. Performance may be slow",
+                         vdev->vbasedev.name, nr);
+        }
+    }
+
+    pci_register_bar(&vdev->pdev, nr, bar->type, bar->mr);
 }
 
-static void vfio_bars_setup(VFIOPCIDevice *vdev)
+static void vfio_bars_register(VFIOPCIDevice *vdev)
 {
     int i;
 
     for (i = 0; i < PCI_ROM_SLOT; i++) {
-        vfio_bar_setup(vdev, i);
+        vfio_bar_register(vdev, i);
     }
 }
 
@@ -1549,8 +1581,13 @@ static void vfio_bars_exit(VFIOPCIDevice *vdev)
     int i;
 
     for (i = 0; i < PCI_ROM_SLOT; i++) {
+        VFIOBAR *bar = &vdev->bars[i];
+
         vfio_bar_quirk_exit(vdev, i);
-        vfio_region_exit(&vdev->bars[i].region);
+        vfio_region_exit(&bar->region);
+        if (bar->region.size) {
+            memory_region_del_subregion(bar->mr, bar->region.mem);
+        }
     }
 
     if (vdev->vga) {
@@ -1564,8 +1601,14 @@ static void vfio_bars_finalize(VFIOPCIDevice *vdev)
     int i;
 
     for (i = 0; i < PCI_ROM_SLOT; i++) {
+        VFIOBAR *bar = &vdev->bars[i];
+
         vfio_bar_quirk_finalize(vdev, i);
-        vfio_region_finalize(&vdev->bars[i].region);
+        vfio_region_finalize(&bar->region);
+        if (bar->size) {
+            object_unparent(OBJECT(bar->mr));
+            g_free(bar->mr);
+        }
     }
 
     if (vdev->vga) {
@@ -2810,7 +2853,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         goto error;
     }
 
-    vfio_bars_setup(vdev);
+    vfio_bars_prepare(vdev);
+    vfio_bars_register(vdev);
 
     ret = vfio_add_capabilities(vdev, errp);
     if (ret) {
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 3d753222ca4c..dcdb1a806769 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -33,6 +33,9 @@ typedef struct VFIOQuirk {
 
 typedef struct VFIOBAR {
     VFIORegion region;
+    MemoryRegion *mr;
+    size_t size;
+    uint8_t type;
     bool ioport;
     bool mem64;
     QLIST_HEAD(, VFIOQuirk) quirks;
