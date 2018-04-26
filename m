Received: from eggs.gnu.org ([2001:4830:134:3::10]:36873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tina.zhang@intel.com>) id 1fBcEb-0003td-Pr
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 04:26:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tina.zhang@intel.com>) id 1fBcEa-0003Lr-Ua
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 04:26:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:55657)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tina.zhang@intel.com>)
	id 1fBcEa-0003LZ-M5
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 04:26:32 -0400
From: Tina Zhang <tina.zhang@intel.com>
Date: Thu, 26 Apr 2018 16:21:20 +0800
Message-Id: <1524730880-7154-3-git-send-email-tina.zhang@intel.com>
In-Reply-To: <1524730880-7154-1-git-send-email-tina.zhang@intel.com>
References: <1524730880-7154-1-git-send-email-tina.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v3 2/2] ui: introduce vfio_display_reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.williamson@redhat.com, kraxel@redhat.com, zhenyuw@linux.intel.com, hang.yuan@intel.com
Cc: Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org, qemu-devel@nongnu.org

During guest OS reboot, guest framebuffer is invalid. It will cause
bugs, if the invalid guest framebuffer is still used by host.

This patch is to introduce vfio_display_reset which is invoked
during vfio display reset. This vfio_display_reset function is used
to release the invalid display resource, disable scanout mode and
replace the invalid surface with QemuConsole's DisplaySurafce.

This patch can fix the GPU hang issue caused by gd_egl_draw during
guest OS reboot.

Changes v2->v3:
 - Limit vfio_display_reset to dma-buf based vfio display. (Gerd)

Changes v1->v2:
 - Use dpy_gfx_update_full() update screen after reset. (Gerd)
 - Remove dpy_gfx_switch_surface(). (Gerd)

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 hw/vfio/display.c | 10 ++++++++++
 hw/vfio/pci.c     |  7 +++++++
 hw/vfio/pci.h     |  1 +
 3 files changed, 18 insertions(+)

diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index 7d727ce..dc4b1e9 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -198,6 +198,16 @@ static void vfio_display_dmabuf_exit(VFIODisplay *dpy)
 }
 
 /* ---------------------------------------------------------------------- */
+void vfio_display_reset(VFIOPCIDevice *vdev)
+{
+    if (!vdev || !vdev->dpy || !vdev->dpy->con) {
+        return;
+    }
+
+    dpy_gl_scanout_disable(vdev->dpy->con);
+    vfio_display_dmabuf_exit(vdev->dpy);
+    dpy_gfx_update_full(vdev->dpy->con);
+}
 
 static void vfio_display_region_update(void *opaque)
 {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index b9bc6cd..648b29d 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3098,11 +3098,18 @@ static void vfio_pci_reset(DeviceState *dev)
 {
     PCIDevice *pdev = DO_UPCAST(PCIDevice, qdev, dev);
     VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
+    VFIODisplay *dpy = vdev->dpy;
 
     trace_vfio_pci_reset(vdev->vbasedev.name);
 
     vfio_pci_pre_reset(vdev);
 
+    /* vfio_display_reset is needed by dma-buf based vfio display */
+    if (vdev->display != ON_OFF_AUTO_OFF && dpy &&
+        dpy->dmabuf.primary) {
+        vfio_display_reset(vdev);
+    }
+
     if (vdev->resetfn && !vdev->resetfn(vdev)) {
         goto post_reset;
     }
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 629c875..59ab775 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -176,6 +176,7 @@ int vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
                                struct vfio_region_info *info,
                                Error **errp);
 
+void vfio_display_reset(VFIOPCIDevice *vdev);
 int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
 void vfio_display_finalize(VFIOPCIDevice *vdev);
 
-- 
2.7.4
