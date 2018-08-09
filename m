Received: from eggs.gnu.org ([2001:4830:134:3::10]:56546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjQG-0005QR-H1
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:48:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjQE-0007ZP-E3
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:48:08 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1fnjQE-0007Z3-2t
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:48:06 -0400
From: Liran Alon <liran.alon@oracle.com>
Date: Thu,  9 Aug 2018 14:46:36 +0300
Message-Id: <1533815202-11967-24-git-send-email-liran.alon@oracle.com>
In-Reply-To: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
Subject: [Qemu-devel] [PATCH 23/29] vmsvga: Implement initial support for
 rgb-alpha cursors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net, habkost@redhat.com, kraxel@redhat.com, Leonid Shatz <leonid.shatz@oracle.com>, Liran Alon <liran.alon@oracle.com>

From: Leonid Shatz <leonid.shatz@oracle.com>

This adds missing implementation of cursors having rgb and alpha-blending component.
Although more work is required in QEMU framework to fully support alpha-blending
functionality for cursors, the suggested fix shows well defined cursor shape instead
of crashing video device or no hint of visible mouse cursor.

Signed-off-by: Leonid Shatz <leonid.shatz@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/display/vmware_vga.c | 85 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 72 insertions(+), 13 deletions(-)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 46f03fe90ac0..49b46938207e 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -668,6 +668,38 @@ static inline void vmsvga_cursor_define(struct vmsvga_state_s *s,
     dpy_cursor_define(s->vga.con, qc);
     cursor_put(qc);
 }
+
+static inline void vmsvga_rgba_cursor_define(struct vmsvga_state_s *s,
+                struct vmsvga_cursor_definition_s *c)
+{
+    QEMUCursor *qc;
+    int i, pixels = c->width * c->height;
+
+    qc = cursor_alloc(c->width, c->height);
+    qc->hot_x = c->hot_x;
+    qc->hot_y = c->hot_y;
+
+    /* fill alpha channel and rgb values */
+    for (i = 0; i < pixels; i++) {
+        qc->data[i] = c->xor_mask[i];
+        /*
+         * Turn semi-transparent pixels to fully opaque
+         * (opaque pixels stay opaque), due to lack of
+         * alpha-blending support in QEMU framework.
+         * This is a trade-off between cursor completely
+         * missing and cursors with some minor artifacts
+         * (such as Windows Aero style cursors).
+         */
+        if (c->and_mask[i]) {
+            qc->data[i] |= 0xff000000;
+        }
+    }
+#ifdef DEBUG
+    cursor_print_ascii_art(qc, "rgba");
+#endif
+    dpy_cursor_define(s->vga.con, qc);
+    cursor_put(qc);
+}
 #endif
 
 static inline int vmsvga_fifo_length(struct vmsvga_state_s *s)
@@ -728,7 +760,7 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
 {
     uint32_t cmd, colour;
     int args, len, maxloop = 1024;
-    int x, y, dx, dy, width, height;
+    int i, x, y, dx, dy, width, height;
     struct vmsvga_cursor_definition_s cursor;
     uint32_t cmd_start;
     uint32_t fence_arg;
@@ -830,6 +862,44 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
             goto badcmd;
 #endif
 
+        case SVGA_CMD_DEFINE_ALPHA_CURSOR:
+            len -= 6;
+            if (len < 0) {
+                goto rewind;
+            }
+
+            cursor.id = vmsvga_fifo_read(s);
+            cursor.hot_x = vmsvga_fifo_read(s);
+            cursor.hot_y = vmsvga_fifo_read(s);
+            cursor.width  = x = vmsvga_fifo_read(s);
+            cursor.height = y = vmsvga_fifo_read(s);
+            cursor.and_mask_bpp = 32;
+            cursor.xor_mask_bpp = 32;
+            args = x * y;
+            if ((SVGA_PIXMAP_SIZE(x, y, 32) > ARRAY_SIZE(cursor.and_mask))
+               || (SVGA_PIXMAP_SIZE(x, y, 32) > ARRAY_SIZE(cursor.xor_mask))) {
+                    goto badcmd;
+            }
+
+            len -= args;
+            if (len < 0) {
+                goto rewind;
+            }
+
+            for (i = 0; i < args; i++) {
+                uint32_t rgba = vmsvga_fifo_read_raw(s);
+                cursor.xor_mask[i] = rgba & 0x00ffffff;
+                cursor.and_mask[i] = rgba & 0xff000000;
+            }
+
+#ifdef HW_MOUSE_ACCEL
+            vmsvga_rgba_cursor_define(s, &cursor);
+            break;
+#else
+            args = 0;
+            goto badcmd;
+#endif
+
         case SVGA_CMD_FRONT_ROP_FILL:
             len -= 1;
             if (len < 0) {
@@ -903,18 +973,6 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
             }
             args = 7;
             goto badcmd;
-        case SVGA_CMD_DEFINE_ALPHA_CURSOR:
-            len -= 6;
-            if (len < 0) {
-                goto rewind;
-            }
-            vmsvga_fifo_read(s);
-            vmsvga_fifo_read(s);
-            vmsvga_fifo_read(s);
-            x = vmsvga_fifo_read(s);
-            y = vmsvga_fifo_read(s);
-            args = x * y;
-            goto badcmd;
         case SVGA_CMD_DRAW_GLYPH_CLIPPED: /* deprecated */
             len -= 4;
             if (len < 0) {
@@ -1085,6 +1143,7 @@ static uint32_t vmsvga_value_read(void *opaque, uint32_t address)
 #endif
 #ifdef HW_MOUSE_ACCEL
         if (dpy_cursor_define_supported(s->vga.con)) {
+            caps |= SVGA_CAP_ALPHA_CURSOR;
             caps |= SVGA_CAP_CURSOR | SVGA_CAP_CURSOR_BYPASS_2 |
                     SVGA_CAP_CURSOR_BYPASS;
         }
-- 
1.9.1
