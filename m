Received: from eggs.gnu.org ([2001:4830:134:3::10]:37815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eQnZS-0000oB-4n
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 00:02:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eQnZP-0001bF-1w
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 00:02:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1eQnZO-0001a3-PG
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 00:02:30 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DD30237E72
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 05:02:29 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Sun, 17 Dec 2017 22:02:29 -0700
Message-ID: <20171218050229.13478.65667.stgit@gimli.home>
In-Reply-To: <20171218040852.13478.19208.stgit@gimli.home>
References: <20171218040852.13478.19208.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC/RFT PATCH 2/5] vfio/pci: Add base BAR MemoryRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com

Add one more layer to our stack of MemoryRegions, this base region
allows us to register BARs independently of the vfio region or to
extend the size of BARs which do map to a region.  This will be
useful when we want hypervisor defined BARs or sections of BARs,
for purposes such as relocating MSI-X emulation.  We therefore call
msix_init() based on this new base MemoryRegion, while the quirks,
which only modify regions still operate on those sub-MemoryRegions.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci.c |   74 ++++++++++++++++++++++++++++++++++++++++++++-------------
 hw/vfio/pci.h |    3 ++
 2 files changed, 60 insertions(+), 17 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c977ee327f94..8f46fdd1d391 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1440,9 +1440,9 @@ static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
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
@@ -1482,8 +1482,8 @@ static void vfio_teardown_msi(VFIOPCIDevice *vdev)
 
     if (vdev->msix) {
         msix_uninit(&vdev->pdev,
-                    vdev->bars[vdev->msix->table_bar].region.mem,
-                    vdev->bars[vdev->msix->pba_bar].region.mem);
+                    vdev->bars[vdev->msix->table_bar].mr,
+                    vdev->bars[vdev->msix->pba_bar].mr);
         g_free(vdev->msix->pending);
     }
 }
@@ -1500,12 +1500,11 @@ static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled)
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
@@ -1524,23 +1523,52 @@ static void vfio_bar_setup(VFIOPCIDevice *vdev, int nr)
     pci_bar = le32_to_cpu(pci_bar);
     bar->ioport = (pci_bar & PCI_BASE_ADDRESS_SPACE_IO);
     bar->mem64 = bar->ioport ? 0 : (pci_bar & PCI_BASE_ADDRESS_MEM_TYPE_64);
-    type = pci_bar & (bar->ioport ? ~PCI_BASE_ADDRESS_IO_MASK :
-                                    ~PCI_BASE_ADDRESS_MEM_MASK);
+    bar->type = pci_bar & (bar->ioport ? ~PCI_BASE_ADDRESS_IO_MASK :
+                                         ~PCI_BASE_ADDRESS_MEM_MASK);
+    bar->size = bar->region.size;
+}
 
-    if (vfio_region_mmap(&bar->region)) {
-        error_report("Failed to mmap %s BAR %d. Performance may be slow",
-                     vdev->vbasedev.name, nr);
+static void vfio_bars_prepare(VFIOPCIDevice *vdev)
+{
+    int i;
+
+    for (i = 0; i < PCI_ROM_SLOT; i++) {
+        vfio_bar_prepare(vdev, i);
     }
+}
 
-    pci_register_bar(&vdev->pdev, nr, type, bar->region.mem);
+static void vfio_bar_register(VFIOPCIDevice *vdev, int nr)
+{
+    VFIOBAR *bar = &vdev->bars[nr];
+    char *name;
+
+    if (!bar->size) {
+        return;
+    }
+
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
 
@@ -1549,8 +1577,13 @@ static void vfio_bars_exit(VFIOPCIDevice *vdev)
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
@@ -1564,8 +1597,14 @@ static void vfio_bars_finalize(VFIOPCIDevice *vdev)
     int i;
 
     for (i = 0; i < PCI_ROM_SLOT; i++) {
+        VFIOBAR *bar = &vdev->bars[i];
+
         vfio_bar_quirk_finalize(vdev, i);
-        vfio_region_finalize(&vdev->bars[i].region);
+        vfio_region_finalize(&bar->region);
+        if (bar->size) {
+           object_unparent(OBJECT(bar->mr));
+           g_free(bar->mr);
+        }
     }
 
     if (vdev->vga) {
@@ -2810,7 +2849,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
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
