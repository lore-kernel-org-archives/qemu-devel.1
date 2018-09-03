Received: from eggs.gnu.org ([2001:4830:134:3::10]:58516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fwioA-0001qG-Ad
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 02:58:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fwio9-0008Ib-2j
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 02:57:58 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  3 Sep 2018 08:57:43 +0200
Message-Id: <20180903065745.23055-4-kraxel@redhat.com>
In-Reply-To: <20180903065745.23055-1-kraxel@redhat.com>
References: <20180903065745.23055-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 3/5] use dpy_gfx_update_full
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alistair Francis <alistair@alistair23.me>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20180810132856.22833-1-kraxel@redhat.com
---
 hw/display/exynos4210_fimd.c | 4 +---
 hw/display/g364fb.c          | 2 +-
 hw/display/jazz_led.c        | 3 +--
 hw/display/tc6393xb.c        | 4 ++--
 hw/display/vga.c             | 3 +--
 hw/display/virtio-gpu.c      | 2 +-
 hw/display/vmware_vga.c      | 5 +----
 hw/display/xlnx_dp.c         | 3 +--
 8 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index f011ea5b00..083b3172da 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -1272,8 +1272,6 @@ static void exynos4210_fimd_update(void *opaque)
     uint8_t *host_fb_addr;
     bool is_dirty = false;
     const int global_width = (s->vidtcon[2] & FIMD_VIDTCON2_SIZE_MASK) + 1;
-    const int global_height = ((s->vidtcon[2] >> FIMD_VIDTCON2_VER_SHIFT) &
-            FIMD_VIDTCON2_SIZE_MASK) + 1;
 
     if (!s || !s->console || !s->enabled ||
         surface_bits_per_pixel(qemu_console_surface(s->console)) == 0) {
@@ -1329,7 +1327,7 @@ static void exynos4210_fimd_update(void *opaque)
             fimd_copy_line_toqemu(global_width, s->ifb + global_width * line *
                     RGBA_SIZE, d + global_width * line * bpp);
         }
-        dpy_gfx_update(s->console, 0, 0, global_width, global_height);
+        dpy_gfx_update_full(s->console);
     }
     s->invalidate = false;
     s->vidintcon[1] |= FIMD_VIDINT_INTFRMPEND;
diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
index fbc2b2422d..8ad7e5d824 100644
--- a/hw/display/g364fb.c
+++ b/hw/display/g364fb.c
@@ -229,7 +229,7 @@ static void g364fb_draw_blank(G364State *s)
         d += surface_stride(surface);
     }
 
-    dpy_gfx_update(s->con, 0, 0, s->width, s->height);
+    dpy_gfx_update_full(s->con);
     s->blanked = 1;
 }
 
diff --git a/hw/display/jazz_led.c b/hw/display/jazz_led.c
index 3c97d56434..eb7933d2a3 100644
--- a/hw/display/jazz_led.c
+++ b/hw/display/jazz_led.c
@@ -214,8 +214,7 @@ static void jazz_led_update_display(void *opaque)
     }
 
     s->state = REDRAW_NONE;
-    dpy_gfx_update(s->con, 0, 0,
-                   surface_width(surface), surface_height(surface));
+    dpy_gfx_update_full(s->con);
 }
 
 static void jazz_led_invalidate_display(void *opaque)
diff --git a/hw/display/tc6393xb.c b/hw/display/tc6393xb.c
index 8392e59493..3360be6f84 100644
--- a/hw/display/tc6393xb.c
+++ b/hw/display/tc6393xb.c
@@ -461,7 +461,7 @@ static void tc6393xb_draw_graphic(TC6393xbState *s, int full_update)
             return;
     }
 
-    dpy_gfx_update(s->con, 0, 0, s->scr_width, s->scr_height);
+    dpy_gfx_update_full(s->con);
 }
 
 static void tc6393xb_draw_blank(TC6393xbState *s, int full_update)
@@ -480,7 +480,7 @@ static void tc6393xb_draw_blank(TC6393xbState *s, int full_update)
         d += surface_stride(surface);
     }
 
-    dpy_gfx_update(s->con, 0, 0, s->scr_width, s->scr_height);
+    dpy_gfx_update_full(s->con);
 }
 
 static void tc6393xb_update_display(void *opaque)
diff --git a/hw/display/vga.c b/hw/display/vga.c
index 802cfd47db..3ba3f6853c 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1745,8 +1745,7 @@ static void vga_draw_blank(VGACommonState *s, int full_update)
         memset(d, 0, w);
         d += surface_stride(surface);
     }
-    dpy_gfx_update(s->con, 0, 0,
-                   s->last_scr_width, s->last_scr_height);
+    dpy_gfx_update_full(s->con);
 }
 
 #define GMODE_TEXT     0
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 1cc953006f..410cf0c98a 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1182,7 +1182,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
         }
 
         dpy_gfx_replace_surface(scanout->con, scanout->ds);
-        dpy_gfx_update(scanout->con, 0, 0, scanout->width, scanout->height);
+        dpy_gfx_update_full(scanout->con);
         if (scanout->cursor.resource_id) {
             update_cursor(g, &scanout->cursor);
         }
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 0bbb78b9a6..afbf1c5973 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1116,7 +1116,6 @@ static inline void vmsvga_check_size(struct vmsvga_state_s *s)
 static void vmsvga_update_display(void *opaque)
 {
     struct vmsvga_state_s *s = opaque;
-    DisplaySurface *surface;
 
     if (!s->enable || !s->config) {
         /* in standard vga mode */
@@ -1125,15 +1124,13 @@ static void vmsvga_update_display(void *opaque)
     }
 
     vmsvga_check_size(s);
-    surface = qemu_console_surface(s->vga.con);
 
     vmsvga_fifo_run(s);
     vmsvga_update_rect_flush(s);
 
     if (s->invalidated) {
         s->invalidated = 0;
-        dpy_gfx_update(s->vga.con, 0, 0,
-                   surface_width(surface), surface_height(surface));
+        dpy_gfx_update_full(s->vga.con);
     }
 }
 
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 6439bd05ef..cc0f9bc9cc 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -1186,8 +1186,7 @@ static void xlnx_dp_update_display(void *opaque)
     /*
      * XXX: We might want to update only what changed.
      */
-    dpy_gfx_update(s->console, 0, 0, surface_width(s->g_plane.surface),
-                                     surface_height(s->g_plane.surface));
+    dpy_gfx_update_full(s->console);
 }
 
 static const GraphicHwOps xlnx_dp_gfx_ops = {
-- 
2.9.3
