Received: from eggs.gnu.org ([209.51.188.92]:34199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1h3Qaf-000408-Iy
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:28:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1h3QVp-0005Hw-MC
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:23:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45207)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1h3QVp-0005HD-9I
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:23:01 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1957981F31
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 19:23:00 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Mon, 11 Mar 2019 13:22:57 -0600
Message-ID: <155233217766.8141.3600946038669106048.stgit@gimli.home>
In-Reply-To: <155233206671.8141.2579745444621332750.stgit@gimli.home>
References: <155233206671.8141.2579745444621332750.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 1/3] vfio/display: add edid support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Gerd Hoffmann <kraxel@redhat.com>

This patch adds EDID support to the vfio display (aka vgpu) code.
When supported by the mdev driver qemu will generate a EDID blob
and pass it on using the new vfio edid region.  The EDID blob will
be updated on UI changes (i.e. window resize), so the guest can
adapt.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
[remove control flow via macro, use unsigned format specifier]
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/display.c             |  141 +++++++++++++++++++++++++++++++++++++++++
 hw/vfio/trace-events          |    7 ++
 include/hw/vfio/vfio-common.h |    3 +
 3 files changed, 151 insertions(+)

diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index dead30e626cb..276fba090d8b 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -15,15 +15,153 @@
 #include <sys/ioctl.h>
 
 #include "sysemu/sysemu.h"
+#include "hw/display/edid.h"
 #include "ui/console.h"
 #include "qapi/error.h"
 #include "pci.h"
+#include "trace.h"
 
 #ifndef DRM_PLANE_TYPE_PRIMARY
 # define DRM_PLANE_TYPE_PRIMARY 1
 # define DRM_PLANE_TYPE_CURSOR  2
 #endif
 
+#define pread_field(_fd, _reg, _ptr, _fld)                              \
+    (sizeof(_ptr->_fld) !=                                              \
+     pread(_fd, &(_ptr->_fld), sizeof(_ptr->_fld),                      \
+           _reg->offset + offsetof(typeof(*_ptr), _fld)))
+
+#define pwrite_field(_fd, _reg, _ptr, _fld)                             \
+    (sizeof(_ptr->_fld) !=                                              \
+     pwrite(_fd, &(_ptr->_fld), sizeof(_ptr->_fld),                     \
+            _reg->offset + offsetof(typeof(*_ptr), _fld)))
+
+
+static void vfio_display_edid_update(VFIOPCIDevice *vdev, bool enabled,
+                                     int prefx, int prefy)
+{
+    VFIODisplay *dpy = vdev->dpy;
+    int fd = vdev->vbasedev.fd;
+    qemu_edid_info edid = {
+        .maxx  = dpy->edid_regs->max_xres,
+        .maxy  = dpy->edid_regs->max_yres,
+        .prefx = prefx,
+        .prefy = prefy,
+    };
+
+    dpy->edid_regs->link_state = VFIO_DEVICE_GFX_LINK_STATE_DOWN;
+    if (pwrite_field(fd, dpy->edid_info, dpy->edid_regs, link_state)) {
+        goto err;
+    }
+    trace_vfio_display_edid_link_down();
+
+    if (!enabled) {
+        return;
+    }
+
+    if (edid.maxx && edid.prefx > edid.maxx) {
+        edid.prefx = edid.maxx;
+    }
+    if (edid.maxy && edid.prefy > edid.maxy) {
+        edid.prefy = edid.maxy;
+    }
+    qemu_edid_generate(dpy->edid_blob,
+                       dpy->edid_regs->edid_max_size,
+                       &edid);
+    trace_vfio_display_edid_update(edid.prefx, edid.prefy);
+
+    dpy->edid_regs->edid_size = qemu_edid_size(dpy->edid_blob);
+    if (pwrite_field(fd, dpy->edid_info, dpy->edid_regs, edid_size)) {
+        goto err;
+    }
+    if (pwrite(fd, dpy->edid_blob, dpy->edid_regs->edid_size,
+               dpy->edid_info->offset + dpy->edid_regs->edid_offset)
+        != dpy->edid_regs->edid_size) {
+        goto err;
+    }
+
+    dpy->edid_regs->link_state = VFIO_DEVICE_GFX_LINK_STATE_UP;
+    if (pwrite_field(fd, dpy->edid_info, dpy->edid_regs, link_state)) {
+        goto err;
+    }
+    trace_vfio_display_edid_link_up();
+    return;
+
+err:
+    trace_vfio_display_edid_write_error();
+    return;
+}
+
+static int vfio_display_edid_ui_info(void *opaque, uint32_t idx,
+                                     QemuUIInfo *info)
+{
+    VFIOPCIDevice *vdev = opaque;
+    VFIODisplay *dpy = vdev->dpy;
+
+    if (!dpy->edid_regs) {
+        return 0;
+    }
+
+    if (info->width && info->height) {
+        vfio_display_edid_update(vdev, true, info->width, info->height);
+    } else {
+        vfio_display_edid_update(vdev, false, 0, 0);
+    }
+
+    return 0;
+}
+
+static void vfio_display_edid_init(VFIOPCIDevice *vdev)
+{
+    VFIODisplay *dpy = vdev->dpy;
+    int fd = vdev->vbasedev.fd;
+    int ret;
+
+    ret = vfio_get_dev_region_info(&vdev->vbasedev,
+                                   VFIO_REGION_TYPE_GFX,
+                                   VFIO_REGION_SUBTYPE_GFX_EDID,
+                                   &dpy->edid_info);
+    if (ret) {
+        return;
+    }
+
+    trace_vfio_display_edid_available();
+    dpy->edid_regs = g_new0(struct vfio_region_gfx_edid, 1);
+    if (pread_field(fd, dpy->edid_info, dpy->edid_regs, edid_offset)) {
+        goto err;
+    }
+    if (pread_field(fd, dpy->edid_info, dpy->edid_regs, edid_max_size)) {
+        goto err;
+    }
+    if (pread_field(fd, dpy->edid_info, dpy->edid_regs, max_xres)) {
+        goto err;
+    }
+    if (pread_field(fd, dpy->edid_info, dpy->edid_regs, max_yres)) {
+        goto err;
+    }
+
+    dpy->edid_blob = g_malloc0(dpy->edid_regs->edid_max_size);
+
+    vfio_display_edid_update(vdev, true, 0, 0);
+    return;
+
+err:
+    trace_vfio_display_edid_write_error();
+    g_free(dpy->edid_regs);
+    dpy->edid_regs = NULL;
+    return;
+}
+
+static void vfio_display_edid_exit(VFIODisplay *dpy)
+{
+    if (!dpy->edid_regs) {
+        return;
+    }
+
+    g_free(dpy->edid_regs);
+    g_free(dpy->edid_blob);
+}
+
 static void vfio_display_update_cursor(VFIODMABuf *dmabuf,
                                        struct vfio_device_gfx_plane_info *plane)
 {
@@ -171,6 +309,7 @@ static void vfio_display_dmabuf_update(void *opaque)
 
 static const GraphicHwOps vfio_display_dmabuf_ops = {
     .gfx_update = vfio_display_dmabuf_update,
+    .ui_info    = vfio_display_edid_ui_info,
 };
 
 static int vfio_display_dmabuf_init(VFIOPCIDevice *vdev, Error **errp)
@@ -187,6 +326,7 @@ static int vfio_display_dmabuf_init(VFIOPCIDevice *vdev, Error **errp)
     if (vdev->enable_ramfb) {
         vdev->dpy->ramfb = ramfb_setup(errp);
     }
+    vfio_display_edid_init(vdev);
     return 0;
 }
 
@@ -366,5 +506,6 @@ void vfio_display_finalize(VFIOPCIDevice *vdev)
     graphic_console_close(vdev->dpy->con);
     vfio_display_dmabuf_exit(vdev->dpy);
     vfio_display_region_exit(vdev->dpy);
+    vfio_display_edid_exit(vdev->dpy);
     g_free(vdev->dpy);
 }
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index ed2f333ad726..decbde495ac2 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -132,3 +132,10 @@ vfio_prereg_unregister(uint64_t va, uint64_t size, int ret) "va=0x%"PRIx64" size
 vfio_spapr_create_window(int ps, uint64_t ws, uint64_t off) "pageshift=0x%x winsize=0x%"PRIx64" offset=0x%"PRIx64
 vfio_spapr_remove_window(uint64_t off) "offset=0x%"PRIx64
 vfio_spapr_group_attach(int groupfd, int tablefd) "Attached groupfd %d to liobn fd %d"
+
+# hw/vfio/display.c
+vfio_display_edid_available(void) ""
+vfio_display_edid_link_up(void) ""
+vfio_display_edid_link_down(void) ""
+vfio_display_edid_update(uint32_t prefx, uint32_t prefy) "%ux%u"
+vfio_display_edid_write_error(void) ""
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 7624c9f511c4..5f7f709b95f1 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -148,6 +148,9 @@ typedef struct VFIODMABuf {
 typedef struct VFIODisplay {
     QemuConsole *con;
     RAMFBState *ramfb;
+    struct vfio_region_info *edid_info;
+    struct vfio_region_gfx_edid *edid_regs;
+    uint8_t *edid_blob;
     struct {
         VFIORegion buffer;
         DisplaySurface *surface;
