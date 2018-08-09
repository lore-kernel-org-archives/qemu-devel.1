Received: from eggs.gnu.org ([2001:4830:134:3::10]:56513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjQA-0005Ml-JS
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjQ7-0007Xp-Vr
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:48:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1fnjQ7-0007Xb-Mh
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:59 -0400
From: Liran Alon <liran.alon@oracle.com>
Date: Thu,  9 Aug 2018 14:46:34 +0300
Message-Id: <1533815202-11967-22-git-send-email-liran.alon@oracle.com>
In-Reply-To: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
Subject: [Qemu-devel] [PATCH 21/29] vmsvga: Use AND mask bpp parameter in
 SVGA_CMD_DEFINE_CURSOR
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

Prefer variable names of cursor structure from VMware SVGA DevKit.
In addition, make sure to use the AND mask bpp parameter in
SVGA_CMD_DEFINE_CURSOR.

Signed-off-by: Leonid Shatz <leonid.shatz@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/display/vmware_vga.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index d79b3400452b..ef2c8bdbf5be 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -616,9 +616,10 @@ struct vmsvga_cursor_definition_s {
     uint32_t width;
     uint32_t height;
     int id;
-    uint32_t bpp;
     int hot_x;
     int hot_y;
+    uint32_t and_mask_bpp; // Value must be 1 or equal to BITS_PER_PIXEL
+    uint32_t xor_mask_bpp; // Value must be 1 or equal to BITS_PER_PIXEL
     uint32_t and_mask[1024];
     uint32_t xor_mask[4096];
 };
@@ -636,7 +637,7 @@ static inline void vmsvga_cursor_define(struct vmsvga_state_s *s,
     qc = cursor_alloc(c->width, c->height);
     qc->hot_x = c->hot_x;
     qc->hot_y = c->hot_y;
-    switch (c->bpp) {
+    switch (c->xor_mask_bpp) {
     case 1:
         cursor_set_mono(qc, 0xffffff, 0x000000, (void *)c->xor_mask,
                         1, (void *)c->and_mask);
@@ -659,7 +660,7 @@ static inline void vmsvga_cursor_define(struct vmsvga_state_s *s,
         break;
     default:
         fprintf(stderr, "%s: unhandled bpp %d, using fallback cursor\n",
-                __func__, c->bpp);
+                __func__, c->xor_mask_bpp);
         cursor_put(qc);
         qc = cursor_builtin_left_ptr();
     }
@@ -794,15 +795,18 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
             cursor.hot_y = vmsvga_fifo_read(s);
             cursor.width = x = vmsvga_fifo_read(s);
             cursor.height = y = vmsvga_fifo_read(s);
-            vmsvga_fifo_read(s);
-            cursor.bpp = vmsvga_fifo_read(s);
+            cursor.and_mask_bpp = vmsvga_fifo_read(s);
+            cursor.xor_mask_bpp = vmsvga_fifo_read(s);
 
-            args = SVGA_BITMAP_SIZE(x, y) + SVGA_PIXMAP_SIZE(x, y, cursor.bpp);
+            args = SVGA_PIXMAP_SIZE(x, y, cursor.and_mask_bpp) +
+                SVGA_PIXMAP_SIZE(x, y, cursor.xor_mask_bpp);
             if (cursor.width > 256
                 || cursor.height > 256
-                || cursor.bpp > 32
-                || SVGA_BITMAP_SIZE(x, y) > ARRAY_SIZE(cursor.and_mask)
-                || SVGA_PIXMAP_SIZE(x, y, cursor.bpp)
+                || cursor.and_mask_bpp > 32
+                || cursor.xor_mask_bpp > 32
+                || SVGA_PIXMAP_SIZE(x, y, cursor.and_mask_bpp)
+                    > ARRAY_SIZE(cursor.and_mask)
+                || SVGA_PIXMAP_SIZE(x, y, cursor.xor_mask_bpp)
                     > ARRAY_SIZE(cursor.xor_mask)) {
                     goto badcmd;
             }
@@ -812,10 +816,10 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
                 goto rewind;
             }
 
-            for (args = 0; args < SVGA_BITMAP_SIZE(x, y); args++) {
+            for (args = 0; args < SVGA_PIXMAP_SIZE(x, y, cursor.and_mask_bpp); args++) {
                 cursor.and_mask[args] = vmsvga_fifo_read_raw(s);
             }
-            for (args = 0; args < SVGA_PIXMAP_SIZE(x, y, cursor.bpp); args++) {
+            for (args = 0; args < SVGA_PIXMAP_SIZE(x, y, cursor.xor_mask_bpp); args++) {
                 cursor.xor_mask[args] = vmsvga_fifo_read_raw(s);
             }
 #ifdef HW_MOUSE_ACCEL
-- 
1.9.1
