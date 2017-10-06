Received: from eggs.gnu.org ([2001:4830:134:3::10]:41818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cQ8-00007g-LD
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:52:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cQ7-00065m-Al
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:52:44 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:33 -0300
Message-Id: <20171006235023.11952-39-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 38/88] VFIO: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: more changes in each file, added pci-quirks.c]
---
 hw/vfio/common.c     | 12 ++++++------
 hw/vfio/pci-quirks.c | 18 +++++++++---------
 hw/vfio/pci.c        |  7 +++----
 hw/vfio/platform.c   |  6 +++---
 4 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7b2924c0ef..bde4fdba66 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -272,7 +272,7 @@ static void vfio_host_win_add(VFIOContainer *container,
         }
     }
 
-    hostwin = g_malloc0(sizeof(*hostwin));
+    hostwin = g_new0(VFIOHostDMAWindow, 1);
 
     hostwin->min_iova = min_iova;
     hostwin->max_iova = max_iova;
@@ -488,7 +488,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
          * would be the right place to wire that up (tell the KVM
          * device emulation the VFIO iommu handles to use).
          */
-        giommu = g_malloc0(sizeof(*giommu));
+        giommu = g_new0(VFIOGuestIOMMU, 1);
         giommu->iommu = iommu_mr;
         giommu->iommu_offset = section->offset_within_address_space -
                                section->offset_within_region;
@@ -688,7 +688,7 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
     }
 
     region->nr_mmaps = j;
-    region->mmaps = g_realloc(region->mmaps, j * sizeof(VFIOMmap));
+    region->mmaps = g_renew(VFIOMmap, region->mmaps, j);
 
     return 0;
 }
@@ -938,7 +938,7 @@ static VFIOAddressSpace *vfio_get_address_space(AddressSpace *as)
     }
 
     /* No suitable VFIOAddressSpace, create a new one */
-    space = g_malloc0(sizeof(*space));
+    space = g_new0(VFIOAddressSpace, 1);
     space->as = as;
     QLIST_INIT(&space->containers);
 
@@ -987,7 +987,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
         goto close_fd_exit;
     }
 
-    container = g_malloc0(sizeof(*container));
+    container = g_new0(VFIOContainer, 1);
     container->space = space;
     container->fd = fd;
     if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1_IOMMU) ||
@@ -1202,7 +1202,7 @@ VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
         }
     }
 
-    group = g_malloc0(sizeof(*group));
+    group = g_new0(VFIOGroup, 1);
 
     snprintf(path, sizeof(path), "/dev/vfio/%d", groupid);
     group->fd = qemu_open(path, O_RDWR);
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 14291c2a16..b51ee60368 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -288,7 +288,7 @@ static void vfio_vga_probe_ati_3c3_quirk(VFIOPCIDevice *vdev)
         return;
     }
 
-    quirk = g_malloc0(sizeof(*quirk));
+    quirk = g_new0(VFIOQuirk, 1);
     quirk->mem = g_new0(MemoryRegion, 1);
     quirk->nr_mem = 1;
 
@@ -323,7 +323,7 @@ static void vfio_probe_ati_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         return;
     }
 
-    quirk = g_malloc0(sizeof(*quirk));
+    quirk = g_new0(VFIOQuirk, 1);
     quirk->mem = g_new0(MemoryRegion, 2);
     quirk->nr_mem = 2;
     window = quirk->data = g_malloc0(sizeof(*window) +
@@ -371,7 +371,7 @@ static void vfio_probe_ati_bar2_quirk(VFIOPCIDevice *vdev, int nr)
         return;
     }
 
-    quirk = g_malloc0(sizeof(*quirk));
+    quirk = g_new0(VFIOQuirk, 1);
     mirror = quirk->data = g_malloc0(sizeof(*mirror));
     mirror->mem = quirk->mem = g_new0(MemoryRegion, 1);
     quirk->nr_mem = 1;
@@ -547,7 +547,7 @@ static void vfio_vga_probe_nvidia_3d0_quirk(VFIOPCIDevice *vdev)
         return;
     }
 
-    quirk = g_malloc0(sizeof(*quirk));
+    quirk = g_new0(VFIOQuirk, 1);
     quirk->data = data = g_malloc0(sizeof(*data));
     quirk->mem = g_new0(MemoryRegion, 2);
     quirk->nr_mem = 2;
@@ -665,7 +665,7 @@ static void vfio_probe_nvidia_bar5_quirk(VFIOPCIDevice *vdev, int nr)
         return;
     }
 
-    quirk = g_malloc0(sizeof(*quirk));
+    quirk = g_new0(VFIOQuirk, 1);
     quirk->mem = g_new0(MemoryRegion, 4);
     quirk->nr_mem = 4;
     bar5 = quirk->data = g_malloc0(sizeof(*bar5) +
@@ -759,7 +759,7 @@ static void vfio_probe_nvidia_bar0_quirk(VFIOPCIDevice *vdev, int nr)
         return;
     }
 
-    quirk = g_malloc0(sizeof(*quirk));
+    quirk = g_new0(VFIOQuirk, 1);
     mirror = quirk->data = g_malloc0(sizeof(*mirror));
     mirror->mem = quirk->mem = g_new0(MemoryRegion, 1);
     quirk->nr_mem = 1;
@@ -942,7 +942,7 @@ static void vfio_probe_rtl8168_bar2_quirk(VFIOPCIDevice *vdev, int nr)
         return;
     }
 
-    quirk = g_malloc0(sizeof(*quirk));
+    quirk = g_new0(VFIOQuirk, 1);
     quirk->mem = g_new0(MemoryRegion, 2);
     quirk->nr_mem = 2;
     quirk->data = rtl = g_malloc0(sizeof(*rtl));
@@ -1500,7 +1500,7 @@ static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     }
 
     /* Setup our quirk to munge GTT addresses to the VM allocated buffer */
-    quirk = g_malloc0(sizeof(*quirk));
+    quirk = g_new0(VFIOQuirk, 1);
     quirk->mem = g_new0(MemoryRegion, 2);
     quirk->nr_mem = 2;
     igd = quirk->data = g_malloc0(sizeof(*igd));
@@ -1553,7 +1553,7 @@ static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
      * memory region must be written to the device BDSM regsiter at PCI
      * config offset 0x5C.
      */
-    bdsm_size = g_malloc(sizeof(*bdsm_size));
+    bdsm_size = g_new(uint64_t, 1);
     *bdsm_size = cpu_to_le64((ggms_mb + gms_mb) * 1024 * 1024);
     fw_cfg_add_file(fw_cfg_find(), "etc/igd-bdsm-size",
                     bdsm_size, sizeof(*bdsm_size));
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 9e86db7c3b..15b82b2942 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1395,7 +1395,7 @@ static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
     table = le32_to_cpu(table);
     pba = le32_to_cpu(pba);
 
-    msix = g_malloc0(sizeof(*msix));
+    msix = g_new0(VFIOMSIXInfo, 1);
     msix->table_bar = table & PCI_MSIX_FLAGS_BIRMASK;
     msix->table_offset = table & ~PCI_MSIX_FLAGS_BIRMASK;
     msix->pba_bar = pba & PCI_MSIX_FLAGS_BIRMASK;
@@ -1437,8 +1437,7 @@ static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
     int ret;
     Error *err = NULL;
 
-    vdev->msix->pending = g_malloc0(BITS_TO_LONGS(vdev->msix->entries) *
-                                    sizeof(unsigned long));
+    vdev->msix->pending = g_new0(unsigned long, BITS_TO_LONGS(vdev->msix->entries));
     ret = msix_init(&vdev->pdev, vdev->msix->entries,
                     vdev->bars[vdev->msix->table_bar].region.mem,
                     vdev->msix->table_bar, vdev->msix->table_offset,
@@ -2076,7 +2075,7 @@ static int vfio_pci_hot_reset(VFIOPCIDevice *vdev, bool single)
     }
     vdev->vbasedev.needs_reset = false;
 
-    info = g_malloc0(sizeof(*info));
+    info = g_new0(struct vfio_pci_hot_reset_info, 1);
     info->argsz = sizeof(*info);
 
     ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_PCI_HOT_RESET_INFO, info);
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index da84abf4fc..547225037f 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -55,7 +55,7 @@ static VFIOINTp *vfio_init_intp(VFIODevice *vbasedev,
     SysBusDevice *sbdev = SYS_BUS_DEVICE(vdev);
     VFIOINTp *intp;
 
-    intp = g_malloc0(sizeof(*intp));
+    intp = g_new0(VFIOINTp, 1);
     intp->vdev = vdev;
     intp->pin = info.index;
     intp->flags = info.flags;
@@ -65,7 +65,7 @@ static VFIOINTp *vfio_init_intp(VFIODevice *vbasedev,
     sysbus_init_irq(sbdev, &intp->qemuirq);
 
     /* Get an eventfd for trigger */
-    intp->interrupt = g_malloc0(sizeof(EventNotifier));
+    intp->interrupt = g_new0(EventNotifier, 1);
     ret = event_notifier_init(intp->interrupt, 0);
     if (ret) {
         g_free(intp->interrupt);
@@ -76,7 +76,7 @@ static VFIOINTp *vfio_init_intp(VFIODevice *vbasedev,
     }
     if (vfio_irq_is_automasked(intp)) {
         /* Get an eventfd for resample/unmask */
-        intp->unmask = g_malloc0(sizeof(EventNotifier));
+        intp->unmask = g_new0(EventNotifier, 1);
         ret = event_notifier_init(intp->unmask, 0);
         if (ret) {
             g_free(intp->interrupt);
-- 
2.14.2
