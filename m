Received: from eggs.gnu.org ([2001:4830:134:3::10]:56503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjQ7-0005LK-V4
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:48:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjQ5-0007XL-C1
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:48:00 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1fnjQ5-0007X3-2d
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:57 -0400
From: Liran Alon <liran.alon@oracle.com>
Date: Thu,  9 Aug 2018 14:46:33 +0300
Message-Id: <1533815202-11967-21-git-send-email-liran.alon@oracle.com>
In-Reply-To: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
Subject: [Qemu-devel] [PATCH 20/29] vmsvga: Use standard names for params
 defining hardware cursor image
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

AND/XOR mask is a standard method for defining hardware cursor images.
These are also the names suggested by VMware SVGA DevKit.

Signed-off-by: Leonid Shatz <leonid.shatz@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/display/vmware_vga.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 73e373665bdb..d79b3400452b 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -619,8 +619,8 @@ struct vmsvga_cursor_definition_s {
     uint32_t bpp;
     int hot_x;
     int hot_y;
-    uint32_t mask[1024];
-    uint32_t image[4096];
+    uint32_t and_mask[1024];
+    uint32_t xor_mask[4096];
 };
 
 #define SVGA_BITMAP_SIZE(w, h)          ((((w) + 31) >> 5) * (h))
@@ -638,20 +638,20 @@ static inline void vmsvga_cursor_define(struct vmsvga_state_s *s,
     qc->hot_y = c->hot_y;
     switch (c->bpp) {
     case 1:
-        cursor_set_mono(qc, 0xffffff, 0x000000, (void *)c->image,
-                        1, (void *)c->mask);
+        cursor_set_mono(qc, 0xffffff, 0x000000, (void *)c->xor_mask,
+                        1, (void *)c->and_mask);
 #ifdef DEBUG
         cursor_print_ascii_art(qc, "vmware/mono");
 #endif
         break;
     case 32:
         /* fill alpha channel from mask, set color to zero */
-        cursor_set_mono(qc, 0x000000, 0x000000, (void *)c->mask,
-                        1, (void *)c->mask);
+        cursor_set_mono(qc, 0x000000, 0x000000, (void *)c->and_mask,
+                        1, (void *)c->and_mask);
         /* add in rgb values */
         pixels = c->width * c->height;
         for (i = 0; i < pixels; i++) {
-            qc->data[i] |= c->image[i] & 0xffffff;
+            qc->data[i] |= c->xor_mask[i] & 0xffffff;
         }
 #ifdef DEBUG
         cursor_print_ascii_art(qc, "vmware/32bit");
@@ -801,9 +801,9 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
             if (cursor.width > 256
                 || cursor.height > 256
                 || cursor.bpp > 32
-                || SVGA_BITMAP_SIZE(x, y) > ARRAY_SIZE(cursor.mask)
+                || SVGA_BITMAP_SIZE(x, y) > ARRAY_SIZE(cursor.and_mask)
                 || SVGA_PIXMAP_SIZE(x, y, cursor.bpp)
-                    > ARRAY_SIZE(cursor.image)) {
+                    > ARRAY_SIZE(cursor.xor_mask)) {
                     goto badcmd;
             }
 
@@ -813,10 +813,10 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
             }
 
             for (args = 0; args < SVGA_BITMAP_SIZE(x, y); args++) {
-                cursor.mask[args] = vmsvga_fifo_read_raw(s);
+                cursor.and_mask[args] = vmsvga_fifo_read_raw(s);
             }
             for (args = 0; args < SVGA_PIXMAP_SIZE(x, y, cursor.bpp); args++) {
-                cursor.image[args] = vmsvga_fifo_read_raw(s);
+                cursor.xor_mask[args] = vmsvga_fifo_read_raw(s);
             }
 #ifdef HW_MOUSE_ACCEL
             vmsvga_cursor_define(s, &cursor);
-- 
1.9.1
