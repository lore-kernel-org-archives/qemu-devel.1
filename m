Received: from eggs.gnu.org ([209.51.188.92]:53338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwNY1-00060G-Md
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 03:48:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwNXv-0008N1-Q5
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 03:48:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gwNXv-0008Lb-EB
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 03:48:03 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 20 Feb 2019 09:47:52 +0100
Message-Id: <20190220084753.9130-3-kraxel@redhat.com>
In-Reply-To: <20190220084753.9130-1-kraxel@redhat.com>
References: <20190220084753.9130-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/3] vfio/display: add xres + yres properties
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

This allows configure the display resolution which the vgpu should use.
The information will be passed to the guest using EDID, so the mdev
driver must support the vfio edid region for this to work.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/vfio/pci.h     |  2 ++
 hw/vfio/display.c | 16 ++++++++++++++--
 hw/vfio/pci.c     |  2 ++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index b1ae4c0754..c11c3f1670 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -149,6 +149,8 @@ typedef struct VFIOPCIDevice {
 #define VFIO_FEATURE_ENABLE_IGD_OPREGION \
                                 (1 << VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT)
     OnOffAuto display;
+    uint32_t display_xres;
+    uint32_t display_yres;
     int32_t bootindex;
     uint32_t igd_gms;
     OffAutoPCIBAR msix_relo;
diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index ed2eb19ea3..7b9b604a64 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -46,8 +46,8 @@ static void vfio_display_edid_update(VFIOPCIDevice *vdev, bool enabled,
     qemu_edid_info edid = {
         .maxx  = dpy->edid_regs->max_xres,
         .maxy  = dpy->edid_regs->max_yres,
-        .prefx = prefx,
-        .prefy = prefy,
+        .prefx = prefx ?: vdev->display_xres,
+        .prefy = prefy ?: vdev->display_yres,
     };
 
     dpy->edid_regs->link_state = VFIO_DEVICE_GFX_LINK_STATE_DOWN;
@@ -117,6 +117,10 @@ static void vfio_display_edid_init(VFIOPCIDevice *vdev)
                                    VFIO_REGION_SUBTYPE_GFX_EDID,
                                    &dpy->edid_info);
     if (ret) {
+        if (vdev->display_xres || vdev->display_yres) {
+            warn_report("vfio: no edid support available, "
+                        "xres and yres properties have no effect.");
+        }
         return;
     }
 
@@ -128,6 +132,14 @@ static void vfio_display_edid_init(VFIOPCIDevice *vdev)
     pread_field(fd, dpy->edid_info, dpy->edid_regs, max_yres);
     dpy->edid_blob = g_malloc0(dpy->edid_regs->edid_max_size);
 
+    /* if xres + yres properties are unset use the maximum resolution */
+    if (!vdev->display_xres) {
+        vdev->display_xres = dpy->edid_regs->max_xres;
+    }
+    if (!vdev->display_yres) {
+        vdev->display_yres = dpy->edid_regs->max_yres;
+    }
+
     vfio_display_edid_update(vdev, true, 0, 0);
     return;
 
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index dd12f36391..edb8394038 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3182,6 +3182,8 @@ static Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_STRING("sysfsdev", VFIOPCIDevice, vbasedev.sysfsdev),
     DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
                             display, ON_OFF_AUTO_OFF),
+    DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0),
+    DEFINE_PROP_UINT32("yres", VFIOPCIDevice, display_yres, 0),
     DEFINE_PROP_UINT32("x-intx-mmap-timeout-ms", VFIOPCIDevice,
                        intx.mmap_timeout, 1100),
     DEFINE_PROP_BIT("x-vga", VFIOPCIDevice, features,
-- 
2.9.3
