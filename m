Received: from eggs.gnu.org ([2001:4830:134:3::10]:57076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhi.a.wang@intel.com>) id 1dFG7B-0005mu-Di
	for qemu-devel@nongnu.org; Mon, 29 May 2017 04:33:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhi.a.wang@intel.com>) id 1dFG78-0004zM-Hr
	for qemu-devel@nongnu.org; Mon, 29 May 2017 04:33:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:12385)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zhi.a.wang@intel.com>)
	id 1dFG78-0004sQ-9J
	for qemu-devel@nongnu.org; Mon, 29 May 2017 04:33:22 -0400
From: Zhi Wang <zhi.a.wang@intel.com>
Date: Tue, 30 May 2017 01:30:36 +0800
Message-Id: <1496079043-26694-7-git-send-email-zhi.a.wang@intel.com>
In-Reply-To: <1496079043-26694-1-git-send-email-zhi.a.wang@intel.com>
References: <1496079043-26694-1-git-send-email-zhi.a.wang@intel.com>
Subject: [Qemu-devel] [RFC 6/6] vfio: Setup IGD stolen memory under
 secondary mode
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

Also setup IGD stolen memory under secondary mode as some HW functions
might need the stolen memory anyway.

Suggested-by: Xiong Zhang <xiong.y.zhang@intel.com>
Signed-off-by: Zhi Wang <zhi.a.wang@intel.com>
---
 hw/vfio/pci-quirks.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index abfcec6..6ddb59a 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1196,16 +1196,11 @@ static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     Error *err = NULL;
 
     /*
-     * This must be an Intel VGA device at address 00:02.0 for us to even
-     * consider enabling legacy mode.  The vBIOS has dependencies on the
-     * PCI bus address.
+     * This must be an Intel VGA device.
      */
     if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
-        !vfio_is_vga(vdev) || nr != 4 ||
-        &vdev->pdev != pci_find_device(pci_device_root_bus(&vdev->pdev),
-                                       0, PCI_DEVFN(0x2, 0))) {
+        !vfio_is_vga(vdev) || nr != 4)
         return;
-    }
 
     /*
      * IGD is not a standard, they like to change their specs often.  We
@@ -1251,6 +1246,15 @@ static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     pci_set_long(vdev->emulated_config_bits + IGD_BDSM, ~0);
 
     /*
+     * This must be an Intel VGA device at address 00:02.0 for us to even
+     * consider enabling legacy mode.  The vBIOS has dependencies on the
+     * PCI bus address.
+     */
+    if (&vdev->pdev != pci_find_device(pci_device_root_bus(&vdev->pdev),
+                0, PCI_DEVFN(0x2, 0)))
+        return;
+
+    /*
      * We need to create an LPC/ISA bridge at PCI bus address 00:1f.0 that we
      * can stuff host values into, so if there's already one there and it's not
      * one we can hack on, legacy mode is no-go.  Sorry Q35.
-- 
2.7.4
