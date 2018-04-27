Received: from eggs.gnu.org ([2001:4830:134:3::10]:41130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fC05S-0007Om-M0
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:54:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fC05R-0001fB-Ns
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:54:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40854 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fC05R-0001em-JL
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:54:41 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 27 Apr 2018 11:54:34 +0200
Message-Id: <20180427095434.14013-7-kraxel@redhat.com>
In-Reply-To: <20180427095434.14013-1-kraxel@redhat.com>
References: <20180427095434.14013-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 6/6] ui: introduce vfio_display_reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Tina Zhang <tina.zhang@intel.com>

From: Tina Zhang <tina.zhang@intel.com>

During guest OS reboot, guest framebuffer is invalid. It will cause
bugs, if the invalid guest framebuffer is still used by host.

This patch is to introduce vfio_display_reset which is invoked
during vfio display reset. This vfio_display_reset function is used
to release the invalid display resource, disable scanout mode and
replace the invalid surface with QemuConsole's DisplaySurafce.

This patch can fix the GPU hang issue caused by gd_egl_draw during
guest OS reboot.

Changes v3->v4:
 - Move dma-buf based display check into the vfio_display_reset().
   (Gerd)

Changes v2->v3:
 - Limit vfio_display_reset to dma-buf based vfio display. (Gerd)

Changes v1->v2:
 - Use dpy_gfx_update_full() update screen after reset. (Gerd)
 - Remove dpy_gfx_switch_surface(). (Gerd)

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
Message-id: 1524820266-27079-3-git-send-email-tina.zhang@intel.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/vfio/pci.h     |  1 +
 hw/vfio/display.c | 11 +++++++++++
 hw/vfio/pci.c     |  4 ++++
 3 files changed, 16 insertions(+)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 629c875701..59ab7757a3 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -176,6 +176,7 @@ int vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
                                struct vfio_region_info *info,
                                Error **errp);
 
+void vfio_display_reset(VFIOPCIDevice *vdev);
 int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
 void vfio_display_finalize(VFIOPCIDevice *vdev);
 
diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index 7d727ce910..59c0e5d1d7 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -198,6 +198,17 @@ static void vfio_display_dmabuf_exit(VFIODisplay *dpy)
 }
 
 /* ---------------------------------------------------------------------- */
+void vfio_display_reset(VFIOPCIDevice *vdev)
+{
+    if (!vdev || !vdev->dpy || !vdev->dpy->con ||
+        !vdev->dpy->dmabuf.primary) {
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
index b9bc6cd310..4947fe39a2 100644
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
-- 
2.9.3
