Received: from eggs.gnu.org ([209.51.188.92]:34585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghtAQ-0000mo-CB
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 04:31:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghtAF-0003Uw-RC
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 04:31:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ghtAB-000383-Ec
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 04:31:41 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 11 Jan 2019 10:31:16 +0100
Message-Id: <20190111093116.17188-6-kraxel@redhat.com>
In-Reply-To: <20190111093116.17188-1-kraxel@redhat.com>
References: <20190111093116.17188-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 5/5] [debug] some logging
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

---
 hw/vfio/display.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index a3a710b3ee..96b5474243 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -42,6 +42,8 @@ static void vfio_display_edid_link_up(void *opaque)
     VFIOPCIDevice *vdev = opaque;
     VFIODisplay *dpy = vdev->dpy;
 
+    fprintf(stderr, "%s:\n", __func__);
+
     dpy->edid_regs->link_state = VFIO_DEVICE_GFX_LINK_STATE_UP;
     pwrite_field(vdev->vbasedev.fd, dpy->edid_info, dpy->edid_regs, link_state);
     return;
@@ -60,6 +62,9 @@ static void vfio_display_edid_update(VFIOPCIDevice *vdev, bool enabled, int pref
         .prefy = prefy ?: vdev->display_yres,
     };
 
+    fprintf(stderr, "%s: ui info: %dx%d, %s\n", __func__,
+            prefx, prefy, enabled ? "on" : "off");
+
     timer_del(dpy->edid_link_timer);
     dpy->edid_regs->link_state = VFIO_DEVICE_GFX_LINK_STATE_DOWN;
     pwrite_field(vdev->vbasedev.fd, dpy->edid_info, dpy->edid_regs, link_state);
@@ -74,6 +79,9 @@ static void vfio_display_edid_update(VFIOPCIDevice *vdev, bool enabled, int pref
     if (edid.maxy && edid.prefy > edid.maxy) {
         edid.prefy = edid.maxy;
     }
+    fprintf(stderr, "%s: edid: %dx%d\n", __func__,
+            edid.prefx, edid.prefy);
+
     qemu_edid_generate(dpy->edid_blob,
                        dpy->edid_regs->edid_max_size,
                        &edid);
@@ -123,6 +131,8 @@ static void vfio_display_edid_init(VFIOPCIDevice *vdev)
                                    VFIO_REGION_SUBTYPE_GFX_EDID,
                                    &dpy->edid_info);
     if (ret) {
+        fprintf(stderr, "%s: no edid region (%s)\n",
+                __func__, strerror(errno));
         return;
     }
 
@@ -132,6 +142,12 @@ static void vfio_display_edid_init(VFIOPCIDevice *vdev)
     pread_field(vdev->vbasedev.fd, dpy->edid_info, dpy->edid_regs, max_xres);
     pread_field(vdev->vbasedev.fd, dpy->edid_info, dpy->edid_regs, max_yres);
     dpy->edid_blob = g_malloc0(dpy->edid_regs->edid_max_size);
+    fprintf(stderr, "%s: edid region: offset %d, size %d, max-res %dx%d\n",
+            __func__,
+            dpy->edid_regs->edid_offset,
+            dpy->edid_regs->edid_max_size,
+            dpy->edid_regs->max_xres,
+            dpy->edid_regs->max_yres);
 
     /* if xres + yres properties are unset use the maximum resolution */
     if (!vdev->display_xres)
-- 
2.9.3
