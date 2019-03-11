Received: from eggs.gnu.org ([209.51.188.92]:34252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1h3Qae-00042z-4x
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:28:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1h3QW5-0005Tr-9u
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:23:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1h3QW4-0005TR-Tt
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:23:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 35D92155AC
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 19:23:16 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Mon, 11 Mar 2019 13:23:13 -0600
Message-ID: <155233219352.8141.477971660133647548.stgit@gimli.home>
In-Reply-To: <155233206671.8141.2579745444621332750.stgit@gimli.home>
References: <155233206671.8141.2579745444621332750.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 3/3] vfio/display: delay link up event
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

Kick the display link up event with a 0.1 sec delay,
so the guest has a chance to notice the link down first.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
[update for redefined macro]
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/display.c             |   30 +++++++++++++++++++++++++-----
 include/hw/vfio/vfio-common.h |    1 +
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index 212ad1674ec1..a3d9c8f5beac 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -37,6 +37,23 @@
             _reg->offset + offsetof(typeof(*_ptr), _fld)))
 
 
+static void vfio_display_edid_link_up(void *opaque)
+{
+    VFIOPCIDevice *vdev = opaque;
+    VFIODisplay *dpy = vdev->dpy;
+    int fd = vdev->vbasedev.fd;
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
+}
+
 static void vfio_display_edid_update(VFIOPCIDevice *vdev, bool enabled,
                                      int prefx, int prefy)
 {
@@ -49,6 +66,7 @@ static void vfio_display_edid_update(VFIOPCIDevice *vdev, bool enabled,
         .prefy = prefy ?: vdev->display_yres,
     };
 
+    timer_del(dpy->edid_link_timer);
     dpy->edid_regs->link_state = VFIO_DEVICE_GFX_LINK_STATE_DOWN;
     if (pwrite_field(fd, dpy->edid_info, dpy->edid_regs, link_state)) {
         goto err;
@@ -80,11 +98,8 @@ static void vfio_display_edid_update(VFIOPCIDevice *vdev, bool enabled,
         goto err;
     }
 
-    dpy->edid_regs->link_state = VFIO_DEVICE_GFX_LINK_STATE_UP;
-    if (pwrite_field(fd, dpy->edid_info, dpy->edid_regs, link_state)) {
-        goto err;
-    }
-    trace_vfio_display_edid_link_up();
+    timer_mod(dpy->edid_link_timer,
+              qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + 100);
     return;
 
 err:
@@ -150,6 +165,9 @@ static void vfio_display_edid_init(VFIOPCIDevice *vdev)
         vdev->display_yres = dpy->edid_regs->max_yres;
     }
 
+    dpy->edid_link_timer = timer_new_ms(QEMU_CLOCK_REALTIME,
+                                        vfio_display_edid_link_up, vdev);
+
     vfio_display_edid_update(vdev, true, 0, 0);
     return;
 
@@ -168,6 +186,8 @@ static void vfio_display_edid_exit(VFIODisplay *dpy)
 
     g_free(dpy->edid_regs);
     g_free(dpy->edid_blob);
+    timer_del(dpy->edid_link_timer);
+    timer_free(dpy->edid_link_timer);
 }
 
 static void vfio_display_update_cursor(VFIODMABuf *dmabuf,
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
