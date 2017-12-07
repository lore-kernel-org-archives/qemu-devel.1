Received: from eggs.gnu.org ([2001:4830:134:3::10]:51184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tina.zhang@intel.com>) id 1eMm3s-0001Am-32
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 21:37:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tina.zhang@intel.com>) id 1eMm3o-0007JU-T8
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 21:37:20 -0500
Received: from mga01.intel.com ([192.55.52.88]:61048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tina.zhang@intel.com>)
	id 1eMm3o-0007FV-JQ
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 21:37:16 -0500
From: Tina Zhang <tina.zhang@intel.com>
Date: Thu,  7 Dec 2017 10:36:22 +0800
Message-Id: <1512614182-8385-1-git-send-email-tina.zhang@intel.com>
Subject: [Qemu-devel] [PATCH] ui: Add enabled field to egl_fb struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kraxel@redhat.com
Cc: Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org

Add a switch to enable/disable a egl_fb to make sure a egl_fb can only
be flushed when it's enabled.

For example, the cursor plane might be disabled by guest Apps on purpose.
With the "enabled" field, a cursor plane can be ignored when it's disabled by
guest Apps.

Against branch: work/intel-vgpu

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/vfio/display.c        |  5 +++++
 include/ui/egl-helpers.h |  1 +
 ui/egl-headless.c        | 12 ++++++++----
 ui/gtk-egl.c             | 11 ++++++++---
 4 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index 0366c02..bf1062f 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -182,6 +182,11 @@ static void vfio_display_dmabuf_update(void *opaque)
                                cursor->hot_y,
                                cursor->pos_x,
                                cursor->pos_y);
+    } else {
+        /* Cursor plane is disabled */
+        dpy_gl_cursor_position(vdev->display_con,
+                               false, false,
+                               0, 0, 0, 0);
     }
 
     dpy_gl_update(vdev->display_con, 0, 0,
diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index 071bedc..1328489 100644
--- a/include/ui/egl-helpers.h
+++ b/include/ui/egl-helpers.h
@@ -14,6 +14,7 @@ typedef struct egl_fb {
     GLuint texture;
     GLuint framebuffer;
     bool delete_texture;
+    bool enabled;
 } egl_fb;
 
 void egl_log_error(const char *func, const char *call);
diff --git a/ui/egl-headless.c b/ui/egl-headless.c
index 299af01..2bd6e9f 100644
--- a/ui/egl-headless.c
+++ b/ui/egl-headless.c
@@ -103,9 +103,13 @@ static void egl_cursor_position(DisplayChangeListener *dcl,
                                 uint32_t pos_x, uint32_t pos_y)
 {
     egl_dpy *edpy = container_of(dcl, egl_dpy, dcl);
-
-    edpy->pos_x = pos_x;
-    edpy->pos_y = pos_y;
+    if (!have_pos) {
+        edpy->cursor_fb.enabled = false;
+    } else {
+        edpy->cursor_fb.enabled = true ;
+        edpy->pos_x = pos_x;
+        edpy->pos_y = pos_y;
+    }
 }
 
 static void egl_release_dmabuf(DisplayChangeListener *dcl,
@@ -127,7 +131,7 @@ static void egl_scanout_flush(DisplayChangeListener *dcl,
     assert(surface_height(edpy->ds) == edpy->guest_fb.height);
     assert(surface_format(edpy->ds) == PIXMAN_x8r8g8b8);
 
-    if (edpy->cursor_fb.texture) {
+    if (edpy->cursor_fb.texture && edpy->cursor_fb.enabled) {
         /* have cursor -> render using textures */
         egl_texture_blit(edpy->gls, &edpy->blit_fb, &edpy->guest_fb,
                          !edpy->y_0_top);
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index cafd95d..bddd733 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -249,8 +249,13 @@ void gd_egl_cursor_position(DisplayChangeListener *dcl,
 {
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
 
-    vc->gfx.cursor_x = pos_x;
-    vc->gfx.cursor_y = pos_y;
+    if (!have_pos) {
+        vc->gfx.cursor_fb.enabled = false;
+    } else {
+        vc->gfx.cursor_fb.enabled = true;
+        vc->gfx.cursor_x = pos_x;
+        vc->gfx.cursor_y = pos_y;
+    }
 }
 
 void gd_egl_release_dmabuf(DisplayChangeListener *dcl,
@@ -287,7 +292,7 @@ void gd_egl_scanout_flush(DisplayChangeListener *dcl,
         egl_fb_setup_default(&vc->gfx.win_fb, ww, wh);
         egl_texture_blit(vc->gfx.gls, &vc->gfx.win_fb, &vc->gfx.guest_fb,
                          vc->gfx.y0_top);
-        if (vc->gfx.cursor_fb.texture) {
+        if (vc->gfx.cursor_fb.texture && vc->gfx.cursor_fb.enabled) {
             egl_texture_blend(vc->gfx.gls, &vc->gfx.win_fb, &vc->gfx.cursor_fb,
                               vc->gfx.y0_top,
                               vc->gfx.cursor_x, vc->gfx.cursor_y);
-- 
2.7.4
