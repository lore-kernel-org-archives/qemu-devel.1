Received: from eggs.gnu.org ([2001:4830:134:3::10]:49139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tina.zhang@intel.com>) id 1fAWhv-00077T-FD
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 04:20:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tina.zhang@intel.com>) id 1fAWhp-0001UR-Pl
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 04:20:19 -0400
Received: from mga17.intel.com ([192.55.52.151]:24988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tina.zhang@intel.com>)
	id 1fAWhp-0001SM-DZ
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 04:20:13 -0400
From: Tina Zhang <tina.zhang@intel.com>
Date: Mon, 23 Apr 2018 16:14:38 +0800
Message-Id: <1524471278-22546-3-git-send-email-tina.zhang@intel.com>
In-Reply-To: <1524471278-22546-1-git-send-email-tina.zhang@intel.com>
References: <1524471278-22546-1-git-send-email-tina.zhang@intel.com>
Subject: [Qemu-devel] [PATCH 2/2] ui: introduce vfio_display_reset
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

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 hw/vfio/display.c | 20 ++++++++++++++++++++
 hw/vfio/pci.c     |  4 ++++
 hw/vfio/pci.h     |  1 +
 3 files changed, 25 insertions(+)

diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index 7d727ce..65185c7 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -198,6 +198,26 @@ static void vfio_display_dmabuf_exit(VFIODisplay *dpy)
 }
 
 /* ---------------------------------------------------------------------- */
+void vfio_display_reset(VFIOPCIDevice *vdev)
+{
+    DisplaySurface *surface;
+
+    if (!vdev || !vdev->dpy || !vdev->dpy->con) {
+        return;
+    }
+
+    surface = qemu_console_surface(vdev->dpy->con);
+    if (!surface) {
+        return;
+    }
+
+    /* During reset, disable scanout mode and */
+    /* use QemuConsole DisplaySurface */
+    dpy_gl_scanout_disable(vdev->dpy->con);
+    dpy_gfx_switch_surface(vdev->dpy->con, surface);
+
+    vfio_display_dmabuf_exit(vdev->dpy);
+}
 
 static void vfio_display_region_update(void *opaque)
 {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index b9bc6cd..4947fe3 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3103,6 +3103,10 @@ static void vfio_pci_reset(DeviceState *dev)
 
     vfio_pci_pre_reset(vdev);
 
+    if (vdev->display != ON_OFF_AUTO_OFF) {
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
