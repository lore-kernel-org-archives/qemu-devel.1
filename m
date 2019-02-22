Received: from eggs.gnu.org ([209.51.188.92]:56988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gx3iu-0005OV-9d
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 00:50:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gx3iq-0007rw-G7
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 00:50:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gx3io-0007fR-Cz
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 00:50:06 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 22 Feb 2019 06:49:39 +0100
Message-Id: <20190222054939.19739-4-kraxel@redhat.com>
In-Reply-To: <20190222054939.19739-1-kraxel@redhat.com>
References: <20190222054939.19739-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v3 3/3] vfio/display: delay link up event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, intel-gvt-dev@lists.freedesktop.org, Gerd Hoffmann <kraxel@redhat.com>

Kick the display link up event with a 0.1 sec delay,
so the guest has a chance to notice the link down first.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/vfio/vfio-common.h |  1 +
 hw/vfio/display.c             | 26 +++++++++++++++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 5f7f709b95f1..b65a2f051886 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -151,6 +151,7 @@ typedef struct VFIODisplay {
     struct vfio_region_info *edid_info;
     struct vfio_region_gfx_edid *edid_regs;
     uint8_t *edid_blob;
+    QEMUTimer *edid_link_timer;
     struct {
         VFIORegion buffer;
         DisplaySurface *surface;
diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index 8bf7c890be96..971e801dc05c 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -38,6 +38,21 @@
         goto err;
 
 
+static void vfio_display_edid_link_up(void *opaque)
+{
+    VFIOPCIDevice *vdev = opaque;
+    VFIODisplay *dpy = vdev->dpy;
+    int fd = vdev->vbasedev.fd;
+
+    dpy->edid_regs->link_state = VFIO_DEVICE_GFX_LINK_STATE_UP;
+    pwrite_field(fd, dpy->edid_info, dpy->edid_regs, link_state);
+    trace_vfio_display_edid_link_up();
+    return;
+
+err:
+    trace_vfio_display_edid_write_error();
+}
+
 static void vfio_display_edid_update(VFIOPCIDevice *vdev, bool enabled,
                                      int prefx, int prefy)
 {
@@ -50,6 +65,7 @@ static void vfio_display_edid_update(VFIOPCIDevice *vdev, bool enabled,
         .prefy = prefy ?: vdev->display_yres,
     };
 
+    timer_del(dpy->edid_link_timer);
     dpy->edid_regs->link_state = VFIO_DEVICE_GFX_LINK_STATE_DOWN;
     pwrite_field(fd, dpy->edid_info, dpy->edid_regs, link_state);
     trace_vfio_display_edid_link_down();
@@ -77,9 +93,8 @@ static void vfio_display_edid_update(VFIOPCIDevice *vdev, bool enabled,
         goto err;
     }
 
-    dpy->edid_regs->link_state = VFIO_DEVICE_GFX_LINK_STATE_UP;
-    pwrite_field(fd, dpy->edid_info, dpy->edid_regs, link_state);
-    trace_vfio_display_edid_link_up();
+    timer_mod(dpy->edid_link_timer,
+              qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + 100);
     return;
 
 err:
@@ -136,6 +151,9 @@ static void vfio_display_edid_init(VFIOPCIDevice *vdev)
         vdev->display_yres = dpy->edid_regs->max_yres;
     }
 
+    dpy->edid_link_timer = timer_new_ms(QEMU_CLOCK_REALTIME,
+                                        vfio_display_edid_link_up, vdev);
+
     vfio_display_edid_update(vdev, true, 0, 0);
     return;
 
@@ -154,6 +172,8 @@ static void vfio_display_edid_exit(VFIODisplay *dpy)
 
     g_free(dpy->edid_regs);
     g_free(dpy->edid_blob);
+    timer_del(dpy->edid_link_timer);
+    timer_free(dpy->edid_link_timer);
 }
 
 static void vfio_display_update_cursor(VFIODMABuf *dmabuf,
-- 
2.9.3
