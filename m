Received: from eggs.gnu.org ([2001:4830:134:3::10]:37091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d1UgF-0001wZ-Pl
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:16:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d1UgD-0001FM-92
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:16:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d1UgD-0001EZ-37
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:16:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 217367575C
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 09:16:40 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 21 Apr 2017 11:16:31 +0200
Message-Id: <20170421091632.30900-9-kraxel@redhat.com>
In-Reply-To: <20170421091632.30900-1-kraxel@redhat.com>
References: <20170421091632.30900-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 8/9] vmsvga: fix vmsvga_update_display
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Fix standard vga mode check:  Both s->config and s->enabled must be set
to enable vmware command fifo processing.

Drop dirty tracking code from the fifo rendering code path, it isn't
used anyway because vmsvga turns off dirty tracking when leaving
standard vga mode.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/vmware_vga.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 6599cf078d..ec5f27d67e 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1118,9 +1118,9 @@ static void vmsvga_update_display(void *opaque)
 {
     struct vmsvga_state_s *s = opaque;
     DisplaySurface *surface;
-    bool dirty = false;
 
-    if (!s->enable) {
+    if (!s->enable || !s->config) {
+        /* in standard vga mode */
         s->vga.hw_ops->gfx_update(&s->vga);
         return;
     }
@@ -1131,26 +1131,11 @@ static void vmsvga_update_display(void *opaque)
     vmsvga_fifo_run(s);
     vmsvga_update_rect_flush(s);
 
-    /*
-     * Is it more efficient to look at vram VGA-dirty bits or wait
-     * for the driver to issue SVGA_CMD_UPDATE?
-     */
-    if (memory_region_is_logging(&s->vga.vram, DIRTY_MEMORY_VGA)) {
-        vga_sync_dirty_bitmap(&s->vga);
-        dirty = memory_region_get_dirty(&s->vga.vram, 0,
-            surface_stride(surface) * surface_height(surface),
-            DIRTY_MEMORY_VGA);
-    }
-    if (s->invalidated || dirty) {
+    if (s->invalidated) {
         s->invalidated = 0;
         dpy_gfx_update(s->vga.con, 0, 0,
                    surface_width(surface), surface_height(surface));
     }
-    if (dirty) {
-        memory_region_reset_dirty(&s->vga.vram, 0,
-            surface_stride(surface) * surface_height(surface),
-            DIRTY_MEMORY_VGA);
-    }
 }
 
 static void vmsvga_reset(DeviceState *dev)
-- 
2.9.3
