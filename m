Received: from eggs.gnu.org ([2001:4830:134:3::10]:58029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiong.y.zhang@intel.com>) id 1cgTXy-0001HZ-CF
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:49:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiong.y.zhang@intel.com>) id 1cgTXv-0003nA-7a
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:49:18 -0500
Received: from mga14.intel.com ([192.55.52.115]:53191)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xiong.y.zhang@intel.com>)
	id 1cgTXu-0003mV-Sh
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:49:15 -0500
From: Xiong Zhang <xiong.y.zhang@intel.com>
Date: Thu, 23 Feb 2017 01:47:37 +0800
Message-Id: <20170222174737.2639-1-xiong.y.zhang@intel.com>
In-Reply-To: <20170220114254.12265-1-xiong.y.zhang@intel.com>
References: <20170220114254.12265-1-xiong.y.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v2] vfio/pci-quirks.c: Disable stolen memory
 for igd VFIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.williamson@redhat.com
Cc: qemu-devel@nongnu.org, jike.song@intel.com, zhiyuan.lv@intel.com, zhi.a.wang@intel.com, XiongZhang <xiong.y.zhang@intel.com>

From: XiongZhang <xiong.y.zhang@intel.com>

Regardless of running in UPT or legacy mode, the guest igd
drivers may attempt to use stolen memory,however only legacy
mode has BIOS support for reserving stolen memmory in the
guest VM. We zero out the stolen memory size in all cases,
then guest igd driver won't use stolen memory.
In legacy mode, user could use x-igd-gms option to specify the
amount of stolen memory which will be pre-allocated and reserved
by bios for igd use.

Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=99028
          https://bugs.freedesktop.org/show_bug.cgi?id=99025

Signed-off-by: Xiong Zhang <xiong.y.zhang@intel.com>
Tested-by: Terrence Xu <terrence.xu@intel.com>
---
 hw/vfio/pci-quirks.c | 65 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 27 deletions(-)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 1e97bc4..870e408 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1364,14 +1364,45 @@ static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     uint32_t gmch;
     uint16_t cmd_orig, cmd;
 
+    /* This must be an Intel VGA device. */
+    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
+        !vfio_is_vga(vdev) || nr != 4) {
+        return;
+    }
+
     /*
-     * This must be an Intel VGA device at address 00:02.0 for us to even
-     * consider enabling legacy mode.  The vBIOS has dependencies on the
-     * PCI bus address.
+     * IGD is not a standard, they like to change their specs often.  We
+     * only attempt to support back to SandBridge and we hope that newer
+     * devices maintain compatibility with generation 8.
      */
-    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
-        !vfio_is_vga(vdev) || nr != 4 ||
-        &vdev->pdev != pci_find_device(pci_device_root_bus(&vdev->pdev),
+    gen = igd_gen(vdev);
+    if (gen != 6 && gen != 8) {
+        error_report("IGD device %s is unsupported by IGD quirks, "
+                     "try SandyBridge or newer", vdev->vbasedev.name);
+        return;
+    }
+
+    /*
+     * Regardless of running in UPT or legacy mode, the guest graphics
+     * driver may attempt to use stolen memory,however only legacy mode
+     * has BIOS support for reserving stolen memory in the guest VM.
+     * Emulate the GMCH register in all cases and zero out the stolen
+     * memory size here. Legacy mode may request allocation and re-write
+     * this below.
+     */
+    gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, 4);
+    gmch &= ~((gen < 8 ? 0x1f : 0xff) << (gen < 8 ? 3 : 8));
+
+    /* GMCH is read-only, emulated */
+    pci_set_long(vdev->pdev.config + IGD_GMCH, gmch);
+    pci_set_long(vdev->pdev.wmask + IGD_GMCH, 0);
+    pci_set_long(vdev->emulated_config_bits + IGD_GMCH, ~0);
+
+    /*
+     * This must be at address 00:02.0 for us to even onsider enabling
+     * legacy mode.  The vBIOS has dependencies on the PCI bus address.
+     */
+    if (&vdev->pdev != pci_find_device(pci_device_root_bus(&vdev->pdev),
                                        0, PCI_DEVFN(0x2, 0))) {
         return;
     }
@@ -1391,18 +1422,6 @@ static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     }
 
     /*
-     * IGD is not a standard, they like to change their specs often.  We
-     * only attempt to support back to SandBridge and we hope that newer
-     * devices maintain compatibility with generation 8.
-     */
-    gen = igd_gen(vdev);
-    if (gen != 6 && gen != 8) {
-        error_report("IGD device %s is unsupported in legacy mode, "
-                     "try SandyBridge or newer", vdev->vbasedev.name);
-        return;
-    }
-
-    /*
      * Most of what we're doing here is to enable the ROM to run, so if
      * there's no ROM, there's no point in setting up this quirk.
      * NB. We only seem to get BIOS ROMs, so a UEFI VM would need CSM support.
@@ -1457,8 +1476,6 @@ static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         goto out;
     }
 
-    gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, 4);
-
     /*
      * If IGD VGA Disable is clear (expected) and VGA is not already enabled,
      * try to enable it.  Probably shouldn't be using legacy mode without VGA,
@@ -1526,12 +1543,11 @@ static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
      * when IVD (IGD VGA Disable) is clear, but the claim is that it's unused,
      * so let's not waste VM memory for it.
      */
-    gmch &= ~((gen < 8 ? 0x1f : 0xff) << (gen < 8 ? 3 : 8));
-
     if (vdev->igd_gms) {
         if (vdev->igd_gms <= 0x10) {
             gms_mb = vdev->igd_gms * 32;
             gmch |= vdev->igd_gms << (gen < 8 ? 3 : 8);
+            pci_set_long(vdev->pdev.config + IGD_GMCH, gmch);
         } else {
             error_report("Unsupported IGD GMS value 0x%x", vdev->igd_gms);
             vdev->igd_gms = 0;
@@ -1551,11 +1567,6 @@ static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     fw_cfg_add_file(fw_cfg_find(), "etc/igd-bdsm-size",
                     bdsm_size, sizeof(*bdsm_size));
 
-    /* GMCH is read-only, emulated */
-    pci_set_long(vdev->pdev.config + IGD_GMCH, gmch);
-    pci_set_long(vdev->pdev.wmask + IGD_GMCH, 0);
-    pci_set_long(vdev->emulated_config_bits + IGD_GMCH, ~0);
-
     /* BDSM is read-write, emulated.  The BIOS needs to be able to write it */
     pci_set_long(vdev->pdev.config + IGD_BDSM, 0);
     pci_set_long(vdev->pdev.wmask + IGD_BDSM, ~0);
-- 
2.9.3
