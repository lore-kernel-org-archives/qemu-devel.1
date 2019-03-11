Received: from eggs.gnu.org ([209.51.188.92]:34252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1h3Qaf-00042z-14
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:28:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1h3QVx-0005Oc-Kn
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:23:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1h3QVx-0005Nj-9D
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:23:09 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7095F6696F
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 19:23:08 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Mon, 11 Mar 2019 13:23:05 -0600
Message-ID: <155233218516.8141.11063684664443124069.stgit@gimli.home>
In-Reply-To: <155233206671.8141.2579745444621332750.stgit@gimli.home>
References: <155233206671.8141.2579745444621332750.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 2/3] vfio/display: add xres + yres properties
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

This allows configure the display resolution which the vgpu should use.
The information will be passed to the guest using EDID, so the mdev
driver must support the vfio edid region for this to work.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/display.c |   12 ++++++++++--
 hw/vfio/pci.c     |   12 ++++++++++++
 hw/vfio/pci.h     |    2 ++
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index 276fba090d8b..212ad1674ec1 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -45,8 +45,8 @@ static void vfio_display_edid_update(VFIOPCIDevice *vdev, bool enabled,
     qemu_edid_info edid = {
         .maxx  = dpy->edid_regs->max_xres,
         .maxy  = dpy->edid_regs->max_yres,
-        .prefx = prefx,
-        .prefy = prefy,
+        .prefx = prefx ?: vdev->display_xres,
+        .prefy = prefy ?: vdev->display_yres,
     };
 
     dpy->edid_regs->link_state = VFIO_DEVICE_GFX_LINK_STATE_DOWN;
@@ -142,6 +142,14 @@ static void vfio_display_edid_init(VFIOPCIDevice *vdev)
 
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
index dd12f363915d..504019c4582b 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3068,6 +3068,16 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         error_setg(errp, "ramfb=on requires display=on");
         goto out_teardown;
     }
+    if (vdev->display_xres || vdev->display_yres) {
+        if (vdev->dpy == NULL) {
+            error_setg(errp, "xres and yres properties require display=on");
+            goto out_teardown;
+        }
+        if (vdev->dpy->edid_regs == NULL) {
+            error_setg(errp, "xres and yres properties need edid support");
+            goto out_teardown;
+        }
+    }
 
     vfio_register_err_notifier(vdev);
     vfio_register_req_notifier(vdev);
@@ -3182,6 +3192,8 @@ static Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_STRING("sysfsdev", VFIOPCIDevice, vbasedev.sysfsdev),
     DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
                             display, ON_OFF_AUTO_OFF),
+    DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0),
+    DEFINE_PROP_UINT32("yres", VFIOPCIDevice, display_yres, 0),
     DEFINE_PROP_UINT32("x-intx-mmap-timeout-ms", VFIOPCIDevice,
                        intx.mmap_timeout, 1100),
     DEFINE_PROP_BIT("x-vga", VFIOPCIDevice, features,
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index b1ae4c07549a..c11c3f167070 100644
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
