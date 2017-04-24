Received: from eggs.gnu.org ([2001:4830:134:3::10]:42107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d2cvj-0006aX-Q9
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:17:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d2cvf-0007NL-1s
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:17:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d2cve-0007MC-Rk
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:17:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 60986C059743
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 12:17:16 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 24 Apr 2017 14:17:06 +0200
Message-Id: <20170424121708.31953-12-kraxel@redhat.com>
In-Reply-To: <20170424121708.31953-1-kraxel@redhat.com>
References: <20170424121708.31953-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 11/13] vmsvga: fix vmsvga_update_display
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
Message-id: 20170421091632.30900-9-kraxel@redhat.com
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
