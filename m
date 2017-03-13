Received: from eggs.gnu.org ([2001:4830:134:3::10]:43196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4t-0000ye-5j
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4s-0002eb-5a
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnW4r-0002eN-TO
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:22 -0400
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 05B837B025
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 19:56:22 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 13 Mar 2017 14:55:45 -0500
Message-Id: <20170313195547.21466-29-eblake@redhat.com>
In-Reply-To: <20170313195547.21466-1-eblake@redhat.com>
References: <20170313195547.21466-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 28/30] trace: Fix parameter types in hw/vfio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Alex Williamson <alex.williamson@redhat.com>

An upcoming patch will let the compiler warn us when we are silently
losing precision in traces; update the trace definitions to pass
through the full value at the callsite.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 hw/vfio/pci.c        |  3 ++-
 hw/vfio/trace-events | 14 +++++++-------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 03a3d01..6b4f588 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1313,7 +1313,8 @@ static void vfio_pci_fixup_msix_region(VFIOPCIDevice *vdev)
             g_free(region->mmaps);
             region->mmaps = NULL;
             trace_vfio_msix_fixup(vdev->vbasedev.name,
-                                  vdev->msix->table_bar, 0, 0);
+                                  vdev->msix->table_bar, (uint64_t) 0,
+                                  (uint64_t) 0);
         } else {
             region->mmaps[0].offset = end;
             region->mmaps[0].size = region->size - end;
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 2561c6d..cac65ef 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -67,7 +67,7 @@ vfio_quirk_nvidia_bar0_msi_ack(const char *name) "%s"
 vfio_quirk_nvidia_bar0_probe(const char *name) "%s"
 vfio_quirk_rtl8168_fake_latch(const char *name, uint64_t val) "%s 0x%"PRIx64
 vfio_quirk_rtl8168_msix_write(const char *name, uint16_t offset, uint64_t val) "%s MSI-X table write[0x%x]: 0x%"PRIx64
-vfio_quirk_rtl8168_msix_read(const char *name, uint16_t offset, uint64_t val) "%s MSI-X table read[0x%x]: 0x%"PRIx64
+vfio_quirk_rtl8168_msix_read(const char *name, hwaddr offset, uint64_t val) "%s MSI-X table read[0x%" HWADDR_PRIx "]: 0x%"PRIx64
 vfio_quirk_rtl8168_probe(const char *name) "%s"

 vfio_quirk_ati_bonaire_reset_skipped(const char *name) "%s"
@@ -75,7 +75,7 @@ vfio_quirk_ati_bonaire_reset_no_smc(const char *name) "%s"
 vfio_quirk_ati_bonaire_reset_timeout(const char *name) "%s"
 vfio_quirk_ati_bonaire_reset_done(const char *name) "%s"
 vfio_quirk_ati_bonaire_reset(const char *name) "%s"
-vfio_pci_igd_bar4_write(const char *name, uint32_t index, uint32_t data, uint32_t base) "%s [%03x] %08x -> %08x"
+vfio_pci_igd_bar4_write(const char *name, uint32_t index, uint64_t data, uint64_t base) "%s [%03x] %08" PRIx64 " -> %08" PRIx64
 vfio_pci_igd_bdsm_enabled(const char *name, int size) "%s %dMB"
 vfio_pci_igd_opregion_enabled(const char *name) "%s"
 vfio_pci_igd_host_bridge_enabled(const char *name) "%s"
@@ -94,14 +94,14 @@ vfio_disconnect_container(int fd) "close container->fd=%d"
 vfio_put_group(int fd) "close group->fd=%d"
 vfio_get_device(const char * name, unsigned int flags, unsigned int num_regions, unsigned int num_irqs) "Device %s flags: %u, regions: %u, irqs: %u"
 vfio_put_base_device(int fd) "close vdev->fd=%d"
-vfio_region_setup(const char *dev, int index, const char *name, unsigned long flags, unsigned long offset, unsigned long size) "Device %s, region %d \"%s\", flags: %lx, offset: %lx, size: %lx"
+vfio_region_setup(const char *dev, int index, const char *name, uint32_t flags, unsigned long offset, unsigned long size) "Device %s, region %d \"%s\", flags: %" PRIx32 ", offset: %lx, size: %lx"
 vfio_region_mmap_fault(const char *name, int index, unsigned long offset, unsigned long size, int fault) "Region %s mmaps[%d], [%lx - %lx], fault: %d"
 vfio_region_mmap(const char *name, unsigned long offset, unsigned long end) "Region %s [%lx - %lx]"
 vfio_region_exit(const char *name, int index) "Device %s, region %d"
 vfio_region_finalize(const char *name, int index) "Device %s, region %d"
 vfio_region_mmaps_set_enabled(const char *name, bool enabled) "Region %s mmaps enabled: %d"
 vfio_region_sparse_mmap_header(const char *name, int index, int nr_areas) "Device %s region %d: %d sparse mmap entries"
-vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long end) "sparse entry %d [0x%lx - 0x%lx]"
+vfio_region_sparse_mmap_entry(int i, unsigned long long start, unsigned long long end) "sparse entry %d [0x%llx - 0x%llx]"
 vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%0x8"

 # hw/vfio/platform.c
@@ -119,7 +119,7 @@ vfio_platform_start_edge_irqfd_injection(int index, int fd) "IRQ index=%d, fd =
 # hw/vfio/spapr.c
 vfio_prereg_listener_region_add_skip(uint64_t start, uint64_t end) "%"PRIx64" - %"PRIx64
 vfio_prereg_listener_region_del_skip(uint64_t start, uint64_t end) "%"PRIx64" - %"PRIx64
-vfio_prereg_register(uint64_t va, uint64_t size, int ret) "va=%"PRIx64" size=%"PRIx64" ret=%d"
-vfio_prereg_unregister(uint64_t va, uint64_t size, int ret) "va=%"PRIx64" size=%"PRIx64" ret=%d"
-vfio_spapr_create_window(int ps, uint64_t ws, uint64_t off) "pageshift=0x%x winsize=0x%"PRIx64" offset=0x%"PRIx64
+vfio_prereg_register(unsigned long long va, unsigned long long size, int ret) "va=%llx size=%llx ret=%d"
+vfio_prereg_unregister(unsigned long long va, unsigned long long size, int ret) "va=%llx size=%llx ret=%d"
+vfio_spapr_create_window(int ps, unsigned long long ws, unsigned long long off) "pageshift=0x%x winsize=0x%llx offset=0x%llx"
 vfio_spapr_remove_window(uint64_t off) "offset=%"PRIx64
-- 
2.9.3
