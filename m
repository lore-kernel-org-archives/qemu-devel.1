Received: from eggs.gnu.org ([2001:4830:134:3::10]:57060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhi.a.wang@intel.com>) id 1dFG78-0005lF-5Z
	for qemu-devel@nongnu.org; Mon, 29 May 2017 04:33:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhi.a.wang@intel.com>) id 1dFG76-0004yH-IQ
	for qemu-devel@nongnu.org; Mon, 29 May 2017 04:33:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:12385)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zhi.a.wang@intel.com>)
	id 1dFG76-0004sQ-6b
	for qemu-devel@nongnu.org; Mon, 29 May 2017 04:33:20 -0400
From: Zhi Wang <zhi.a.wang@intel.com>
Date: Tue, 30 May 2017 01:30:35 +0800
Message-Id: <1496079043-26694-6-git-send-email-zhi.a.wang@intel.com>
In-Reply-To: <1496079043-26694-1-git-send-email-zhi.a.wang@intel.com>
References: <1496079043-26694-1-git-send-email-zhi.a.wang@intel.com>
Subject: [Qemu-devel] [RFC 5/6] vfio: Remove extra quirks and old definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: chuanxiao.dong@intel.com, daniel.vetter@ffwll.ch, xiong.y.zhang@intel.com, joonas.lahtinen@linux.intel.com, zhiyuan.lv@intel.com, zhenyuw@linux.intel.com, kevin.tian@intel.com, Zhi Wang <zhi.a.wang@intel.com>

Remove extra quirks, old definitions and functions. Once the new Intel
platform definition is introduced, and the PA of guest stolen memory
equals to the PA of host stolen memory, they are not necessary anymore.

Suggested-by: Xiong Zhang <xiong.y.zhang@intel.com>
Signed-off-by: Zhi Wang <zhi.a.wang@intel.com>
---
 hw/vfio/pci-quirks.c | 209 ++-------------------------------------------------
 1 file changed, 7 insertions(+), 202 deletions(-)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 618c43c..abfcec6 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -997,55 +997,6 @@ static void vfio_probe_rtl8168_bar2_quirk(VFIOPCIDevice *vdev, int nr)
  * headless setup is desired, the OpRegion gets in the way of that.
  */
 
-/*
- * This presumes the device is already known to be an Intel VGA device, so we
- * take liberties in which device ID bits match which generation.  This should
- * not be taken as an indication that all the devices are supported, or even
- * supportable, some of them don't even support VT-d.
- * See linux:include/drm/i915_pciids.h for IDs.
- */
-static int igd_gen(VFIOPCIDevice *vdev)
-{
-    if ((vdev->device_id & 0xfff) == 0xa84) {
-        return 8; /* Broxton */
-    }
-
-    switch (vdev->device_id & 0xff00) {
-    /* Old, untested, unavailable, unknown */
-    case 0x0000:
-    case 0x2500:
-    case 0x2700:
-    case 0x2900:
-    case 0x2a00:
-    case 0x2e00:
-    case 0x3500:
-    case 0xa000:
-        return -1;
-    /* SandyBridge, IvyBridge, ValleyView, Haswell */
-    case 0x0100:
-    case 0x0400:
-    case 0x0a00:
-    case 0x0c00:
-    case 0x0d00:
-    case 0x0f00:
-        return 6;
-    /* BroadWell, CherryView, SkyLake, KabyLake */
-    case 0x1600:
-    case 0x1900:
-    case 0x2200:
-    case 0x5900:
-        return 8;
-    }
-
-    return 8; /* Assume newer is compatible */
-}
-
-typedef struct VFIOIGDQuirk {
-    struct VFIOPCIDevice *vdev;
-    uint32_t index;
-    uint32_t bdsm;
-} VFIOIGDQuirk;
-
 #define IGD_GMCH 0x50 /* Graphics Control Register */
 #define IGD_BDSM 0x5c /* Base Data of Stolen Memory */
 #define IGD_ASLS 0xfc /* ASL Storage Register */
@@ -1230,144 +1181,17 @@ static int vfio_pci_igd_lpc_init(VFIOPCIDevice *vdev,
     return ret;
 }
 
-/*
- * IGD Gen8 and newer support up to 8MB for the GTT and use a 64bit PTE
- * entry, older IGDs use 2MB and 32bit.  Each PTE maps a 4k page.  Therefore
- * we either have 2M/4k * 4 = 2k or 8M/4k * 8 = 16k as the maximum iobar index
- * for programming the GTT.
- *
- * See linux:include/drm/i915_drm.h for shift and mask values.
- */
-static int vfio_igd_gtt_max(VFIOPCIDevice *vdev)
-{
-    uint32_t gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, sizeof(gmch));
-    int ggms, gen = igd_gen(vdev);
-
-    gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, sizeof(gmch));
-    ggms = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
-    if (gen > 6) {
-        ggms = 1 << ggms;
-    }
-
-    ggms *= 1024 * 1024;
-
-    return (ggms / (4 * 1024)) * (gen < 8 ? 4 : 8);
-}
-
-/*
- * The IGD ROM will make use of stolen memory (GGMS) for support of VESA modes.
- * Somehow the host stolen memory range is used for this, but how the ROM gets
- * it is a mystery, perhaps it's hardcoded into the ROM.  Thankfully though, it
- * reprograms the GTT through the IOBAR where we can trap it and transpose the
- * programming to the VM allocated buffer.  That buffer gets reserved by the VM
- * firmware via the fw_cfg entry added below.  Here we're just monitoring the
- * IOBAR address and data registers to detect a write sequence targeting the
- * GTTADR.  This code is developed by observed behavior and doesn't have a
- * direct spec reference, unfortunately.
- */
-static uint64_t vfio_igd_quirk_data_read(void *opaque,
-                                         hwaddr addr, unsigned size)
-{
-    VFIOIGDQuirk *igd = opaque;
-    VFIOPCIDevice *vdev = igd->vdev;
-
-    igd->index = ~0;
-
-    return vfio_region_read(&vdev->bars[4].region, addr + 4, size);
-}
-
-static void vfio_igd_quirk_data_write(void *opaque, hwaddr addr,
-                                      uint64_t data, unsigned size)
-{
-    VFIOIGDQuirk *igd = opaque;
-    VFIOPCIDevice *vdev = igd->vdev;
-    uint64_t val = data;
-    int gen = igd_gen(vdev);
-
-    /*
-     * Programming the GGMS starts at index 0x1 and uses every 4th index (ie.
-     * 0x1, 0x5, 0x9, 0xd,...).  For pre-Gen8 each 4-byte write is a whole PTE
-     * entry, with 0th bit enable set.  For Gen8 and up, PTEs are 64bit, so
-     * entries 0x5 & 0xd are the high dword, in our case zero.  Each PTE points
-     * to a 4k page, which we translate to a page from the VM allocated region,
-     * pointed to by the BDSM register.  If this is not set, we fail.
-     *
-     * We trap writes to the full configured GTT size, but we typically only
-     * see the vBIOS writing up to (nearly) the 1MB barrier.  In fact it often
-     * seems to miss the last entry for an even 1MB GTT.  Doing a gratuitous
-     * write of that last entry does work, but is hopefully unnecessary since
-     * we clear the previous GTT on initialization.
-     */
-    if ((igd->index % 4 == 1) && igd->index < vfio_igd_gtt_max(vdev)) {
-        if (gen < 8 || (igd->index % 8 == 1)) {
-            uint32_t base;
-
-            base = pci_get_long(vdev->pdev.config + IGD_BDSM);
-            if (!base) {
-                hw_error("vfio-igd: Guest attempted to program IGD GTT before "
-                         "BIOS reserved stolen memory.  Unsupported BIOS?");
-            }
-
-            val = data - igd->bdsm + base;
-        } else {
-            val = 0; /* upper 32bits of pte, we only enable below 4G PTEs */
-        }
-
-        trace_vfio_pci_igd_bar4_write(vdev->vbasedev.name,
-                                      igd->index, data, val);
-    }
-
-    vfio_region_write(&vdev->bars[4].region, addr + 4, val, size);
-
-    igd->index = ~0;
-}
-
-static const MemoryRegionOps vfio_igd_data_quirk = {
-    .read = vfio_igd_quirk_data_read,
-    .write = vfio_igd_quirk_data_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
-static uint64_t vfio_igd_quirk_index_read(void *opaque,
-                                          hwaddr addr, unsigned size)
-{
-    VFIOIGDQuirk *igd = opaque;
-    VFIOPCIDevice *vdev = igd->vdev;
-
-    igd->index = ~0;
-
-    return vfio_region_read(&vdev->bars[4].region, addr, size);
-}
-
-static void vfio_igd_quirk_index_write(void *opaque, hwaddr addr,
-                                       uint64_t data, unsigned size)
-{
-    VFIOIGDQuirk *igd = opaque;
-    VFIOPCIDevice *vdev = igd->vdev;
-
-    igd->index = data;
-
-    vfio_region_write(&vdev->bars[4].region, addr, data, size);
-}
-
-static const MemoryRegionOps vfio_igd_index_quirk = {
-    .read = vfio_igd_quirk_index_read,
-    .write = vfio_igd_quirk_index_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
 static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 {
     struct vfio_region_info *rom = NULL, *opregion = NULL,
                             *host = NULL, *lpc = NULL;
     VFIOQuirk *quirk;
-    VFIOIGDQuirk *igd;
     const struct intel_device_info *info;
     void *stolen;
     PCIDevice *lpc_bridge;
     int i, j, ret;
     uint64_t bdsm_size;
-    uint32_t gmch;
+    uint32_t gmch, bdsm_base;
     uint16_t cmd_orig, cmd;
     Error *err = NULL;
 
@@ -1400,11 +1224,8 @@ static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     quirk->mem = g_new0(MemoryRegion, 1);
     quirk->nr_mem = 1;
 
-    igd = quirk->data = g_malloc0(sizeof(*igd));
-    igd->vdev = vdev;
-    igd->index = ~0;
-    igd->bdsm = vfio_pci_read_config(&vdev->pdev, IGD_BDSM, 4);
-    igd->bdsm &= ~((1 << 20) - 1); /* 1MB aligned */
+    bdsm_base = vfio_pci_read_config(&vdev->pdev, IGD_BDSM, 4);
+    bdsm_base &= ~((1 << 20) - 1); /* 1MB aligned */
 
     /* Setup stolen memory for IGD device. */
     gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, 4);
@@ -1415,9 +1236,11 @@ static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     memory_region_init_ram_ptr(&quirk->mem[0], OBJECT(vdev),
                                "vfio-igd-stolen", bdsm_size, stolen);
     memory_region_add_subregion_overlap(get_system_memory(),
-                                        igd->bdsm, &quirk->mem[0], 1);
+                                        bdsm_base, &quirk->mem[0], 1);
+
+    e820_add_entry(bdsm_base, bdsm_size, E820_RESERVED);
 
-    e820_add_entry(igd->bdsm, bdsm_size, E820_RESERVED);
+    QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
 
     /* GMCH is read-only, emulated */
     pci_set_long(vdev->pdev.wmask + IGD_GMCH, 0);
@@ -1532,24 +1355,6 @@ static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         goto out;
     }
 
-    quirk->mem = g_renew(MemoryRegion, quirk->mem, 2);
-
-    memory_region_init_io(&quirk->mem[quirk->nr_mem++], OBJECT(vdev),
-                          &vfio_igd_index_quirk, igd, "vfio-igd-index-quirk",
-                          4);
-
-    memory_region_add_subregion_overlap(vdev->bars[nr].region.mem,
-                                        0, &quirk->mem[0], 1);
-
-    memory_region_init_io(&quirk->mem[quirk->nr_mem++], OBJECT(vdev),
-                          &vfio_igd_data_quirk, igd, "vfio-igd-data-quirk",
-                          4);
-
-    memory_region_add_subregion_overlap(vdev->bars[nr].region.mem,
-                                        4, &quirk->mem[1], 1);
-
-    QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, quirk, next);
-
     /*
      * This IOBAR gives us access to GTTADR, which allows us to write to
      * the GTT itself.  So let's go ahead and write zero to all the GTT
-- 
2.7.4
