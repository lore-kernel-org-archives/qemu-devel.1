Received: from eggs.gnu.org ([2001:4830:134:3::10]:56118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjPH-0004ex-AL
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjPE-00072E-MX
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1fnjPE-000720-CB
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:04 -0400
From: Liran Alon <liran.alon@oracle.com>
Date: Thu,  9 Aug 2018 14:46:15 +0300
Message-Id: <1533815202-11967-3-git-send-email-liran.alon@oracle.com>
In-Reply-To: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
Subject: [Qemu-devel] [PATCH 02/29] vmsvga: Group together commands by their
 handling
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

Should not change semantics.

Signed-off-by: Leonid Shatz <leonid.shatz@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/display/vmware_vga.c | 60 ++++++++++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 60a672530840..f8c5b64cfd7c 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -607,6 +607,8 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
         cmd_start = s->fifo_stop;
 
         switch (cmd = vmsvga_fifo_read(s)) {
+
+        /* Implemented commands */
         case SVGA_CMD_UPDATE:
         case SVGA_CMD_UPDATE_VERBOSE:
             len -= 5;
@@ -621,25 +623,6 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
             vmsvga_update_rect_delayed(s, x, y, width, height);
             break;
 
-        case SVGA_CMD_RECT_FILL:
-            len -= 6;
-            if (len < 0) {
-                goto rewind;
-            }
-
-            colour = vmsvga_fifo_read(s);
-            x = vmsvga_fifo_read(s);
-            y = vmsvga_fifo_read(s);
-            width = vmsvga_fifo_read(s);
-            height = vmsvga_fifo_read(s);
-#ifdef HW_FILL_ACCEL
-            if (vmsvga_fill_rect(s, colour, x, y, width, height) == 0) {
-                break;
-            }
-#endif
-            args = 0;
-            goto badcmd;
-
         case SVGA_CMD_RECT_COPY:
             len -= 7;
             if (len < 0) {
@@ -704,27 +687,52 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
 #endif
 
         /*
-         * Other commands that we at least know the number of arguments
-         * for so we can avoid FIFO desync if driver uses them illegally.
+         * Deprecated commands are neither documented in VMware SVGA development kit
+         * nor in Linux kernel vmware-svga driver source code.
+         * If they are not encountered in real world scenarious, they should be
+         * completely removed.
          */
-        case SVGA_CMD_DEFINE_ALPHA_CURSOR:
+        case SVGA_CMD_RECT_FILL:
             len -= 6;
             if (len < 0) {
                 goto rewind;
             }
-            vmsvga_fifo_read(s);
-            vmsvga_fifo_read(s);
-            vmsvga_fifo_read(s);
+
+            colour = vmsvga_fifo_read(s);
             x = vmsvga_fifo_read(s);
             y = vmsvga_fifo_read(s);
-            args = x * y;
+            width = vmsvga_fifo_read(s);
+            height = vmsvga_fifo_read(s);
+#ifdef HW_FILL_ACCEL
+            if (vmsvga_fill_rect(s, colour, x, y, width, height) == 0) {
+                break;
+            }
+#endif
+            args = 0;
             goto badcmd;
+
+        /*
+         * Unimplemented commands that we gracefully skip their
+         * arguments so we can avoid FIFO desync
+         */
         case SVGA_CMD_RECT_ROP_FILL:
             args = 6;
             goto badcmd;
         case SVGA_CMD_RECT_ROP_COPY:
             args = 7;
             goto badcmd;
+        case SVGA_CMD_DEFINE_ALPHA_CURSOR:
+            len -= 6;
+            if (len < 0) {
+                goto rewind;
+            }
+            vmsvga_fifo_read(s);
+            vmsvga_fifo_read(s);
+            vmsvga_fifo_read(s);
+            x = vmsvga_fifo_read(s);
+            y = vmsvga_fifo_read(s);
+            args = x * y;
+            goto badcmd;
         case SVGA_CMD_DRAW_GLYPH_CLIPPED:
             len -= 4;
             if (len < 0) {
-- 
1.9.1
