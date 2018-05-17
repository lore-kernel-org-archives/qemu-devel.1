Received: from eggs.gnu.org ([2001:4830:134:3::10]:36074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fJFA1-0006Om-JG
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:25:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fJF9x-0004Xx-Fn
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:25:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56466 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fJF9w-0004Wq-TE
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:25:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 80F5F81663C0
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 09:25:16 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 17 May 2018 11:25:12 +0200
Message-Id: <20180517092513.735-4-kraxel@redhat.com>
In-Reply-To: <20180517092513.735-1-kraxel@redhat.com>
References: <20180517092513.735-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] bochs-display: add dirty tracking support
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/bochs-display.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index beeda58475..9ea6f798f4 100644
--- a/hw/display/bochs-display.c
+++ b/hw/display/bochs-display.c
@@ -192,9 +192,13 @@ nofb:
 static void bochs_display_update(void *opaque)
 {
     BochsDisplayState *s = opaque;
+    DirtyBitmapSnapshot *snap = NULL;
+    bool full_update = false;
     BochsDisplayMode mode;
     DisplaySurface *ds;
     uint8_t *ptr;
+    bool dirty;
+    int y, ys;
 
     bochs_display_get_mode(s, &mode);
     if (!mode.size) {
@@ -212,9 +216,34 @@ static void bochs_display_update(void *opaque)
                                              mode.stride,
                                              ptr + mode.offset);
         dpy_gfx_replace_surface(s->con, ds);
+        full_update = true;
     }
 
-    dpy_gfx_update_full(s->con);
+    if (full_update) {
+        dpy_gfx_update_full(s->con);
+    } else {
+        snap = memory_region_snapshot_and_clear_dirty(&s->vram,
+                                                      mode.offset, mode.size,
+                                                      DIRTY_MEMORY_VGA);
+        ys = -1;
+        for (y = 0; y < mode.height; y++) {
+            dirty = memory_region_snapshot_get_dirty(&s->vram, snap,
+                                                     mode.offset + mode.stride * y,
+                                                     mode.stride);
+            if (dirty && ys < 0) {
+                ys = y;
+            }
+            if (!dirty && ys >= 0) {
+                dpy_gfx_update(s->con, 0, ys,
+                               mode.width, y - ys);
+                ys = -1;
+            }
+        }
+        if (ys >= 0) {
+            dpy_gfx_update(s->con, 0, ys,
+                           mode.width, y - ys);
+        }
+    }
 }
 
 static const GraphicHwOps bochs_display_gfx_ops = {
@@ -250,6 +279,8 @@ static void bochs_display_realize(PCIDevice *dev, Error **errp)
     pci_set_byte(&s->pci.config[PCI_REVISION_ID], 2);
     pci_register_bar(&s->pci, 0, PCI_BASE_ADDRESS_MEM_PREFETCH, &s->vram);
     pci_register_bar(&s->pci, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mmio);
+
+    memory_region_set_log(&s->vram, true, DIRTY_MEMORY_VGA);
 }
 
 static bool bochs_display_get_big_endian_fb(Object *obj, Error **errp)
-- 
2.9.3
