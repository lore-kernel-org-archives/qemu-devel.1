Received: from eggs.gnu.org ([2001:4830:134:3::10]:47572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiong.y.zhang@intel.com>) id 1f68Fq-0005sL-QJ
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 01:25:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiong.y.zhang@intel.com>) id 1f68Fn-0002d1-Jq
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 01:25:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:17456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xiong.y.zhang@intel.com>)
	id 1f68Fn-0002ae-7D
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 01:25:07 -0400
From: Xiong Zhang <xiong.y.zhang@intel.com>
Date: Wed, 11 Apr 2018 13:24:10 +0800
Message-Id: <1523424250-3835-1-git-send-email-xiong.y.zhang@intel.com>
Subject: [Qemu-devel] [PATCH] vfio/pci-quirks.c: Make stolen memory size
 adjustable for igd VFIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, Xiong Zhang <xiong.y.zhang@intel.com>

Currenly linux guest with kernel above 3.19 couldn't boot up on igd
passthrough env. The root case is i915 driver use stolen memory, but
qemu vfio doesn't support it.

This patch set stolen memory size to zero default, so guest i915 won't
use it. But this breaks old windows igd driver which will be unloaded
once it see zero stolen memory size. Then this patch also use x-igd-gms
option to adjust stolen memory size. New windows igd driver fixes this and
could work with zero stolen memory size.

Finally with this patch, Linux guest and windows guest with igd driver
above 15.45.4860 could work successfully, windows guest with igd driver
below 15.45.4860 should add x-igd-gms=* option.

Signed-off-by: Xiong Zhang <xiong.y.zhang@intel.com>
---
 hw/vfio/pci-quirks.c | 95 ++++++++++++++++++++++++++++------------------------
 1 file changed, 52 insertions(+), 43 deletions(-)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 60ad5fb..6e9ed7f 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1372,14 +1372,60 @@ static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     uint16_t cmd_orig, cmd;
     Error *err = NULL;
 
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
+     * driver may attempt to use stolen memory, however only legacy mode
+     * has BIOS support for reserving stolen memory in the guest VM.
+     * Emulate the GMCH register in all cases and zero out the stolen
+     * memory size here.
+     */
+    gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, 4);
+    gmch &= ~((gen < 8 ? 0x1f : 0xff) << (gen < 8 ? 3 : 8));
+
+    /*
+     * Assume we have no GMS memory, but allow it to be overrided by device
+     * option (experimental). Old windows igd driver must see non-zero stolen
+     * memory size, otherwise it will be unloaded. New igd windows driver fix
+     * this issue and could load with zero stolen memory size.
+     */
+    if (vdev->igd_gms) {
+        if (vdev->igd_gms <= 0x10) {
+            gms_mb = vdev->igd_gms * 32;
+            gmch |= vdev->igd_gms << (gen < 8 ? 3 : 8);
+        } else {
+            error_report("Unsupported IGD GMS value 0x%x", vdev->igd_gms);
+            vdev->igd_gms = 0;
+        }
+    }
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
@@ -1399,18 +1445,6 @@ static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
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
@@ -1465,8 +1499,6 @@ static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         goto out;
     }
 
-    gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, 4);
-
     /*
      * If IGD VGA Disable is clear (expected) and VGA is not already enabled,
      * try to enable it.  Probably shouldn't be using legacy mode without VGA,
@@ -1532,24 +1564,6 @@ static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     }
 
     /*
-     * Assume we have no GMS memory, but allow it to be overrided by device
-     * option (experimental).  The spec doesn't actually allow zero GMS when
-     * when IVD (IGD VGA Disable) is clear, but the claim is that it's unused,
-     * so let's not waste VM memory for it.
-     */
-    gmch &= ~((gen < 8 ? 0x1f : 0xff) << (gen < 8 ? 3 : 8));
-
-    if (vdev->igd_gms) {
-        if (vdev->igd_gms <= 0x10) {
-            gms_mb = vdev->igd_gms * 32;
-            gmch |= vdev->igd_gms << (gen < 8 ? 3 : 8);
-        } else {
-            error_report("Unsupported IGD GMS value 0x%x", vdev->igd_gms);
-            vdev->igd_gms = 0;
-        }
-    }
-
-    /*
      * Request reserved memory for stolen memory via fw_cfg.  VM firmware
      * must allocate a 1MB aligned reserved memory region below 4GB with
      * the requested size (in bytes) for use by the Intel PCI class VGA
@@ -1562,11 +1576,6 @@ static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
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
2.7.4
