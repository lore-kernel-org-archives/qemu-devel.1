Received: from eggs.gnu.org ([2001:4830:134:3::10]:56635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjQU-0005cN-In
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:48:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjQR-0007hj-R2
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:48:22 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:48654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1fnjQR-0007gx-Fu
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:48:19 -0400
From: Liran Alon <liran.alon@oracle.com>
Date: Thu,  9 Aug 2018 14:46:41 +0300
Message-Id: <1533815202-11967-29-git-send-email-liran.alon@oracle.com>
In-Reply-To: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
Subject: [Qemu-devel] [PATCH 28/29] vmsvga: Introduce new function for
 reporting device capabilities
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

This in only code refactoring without change in semantics.

Signed-off-by: Leonid Shatz <leonid.shatz@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/display/vmware_vga.c | 45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index bd7202833081..389248b4badf 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -479,6 +479,30 @@ static void cursor_update_from_fifo(struct vmsvga_state_s *s)
 #endif
 }
 
+/* Report device capabilities */
+static uint32_t vmsvga_device_caps(struct vmsvga_state_s *s)
+{
+    uint32_t caps = SVGA_CAP_NONE;
+#ifdef HW_RECT_ACCEL
+    caps |= SVGA_CAP_RECT_COPY;
+#endif
+#ifdef HW_FILL_ACCEL
+    caps |= SVGA_CAP_RECT_FILL;
+#endif
+#ifdef HW_MOUSE_ACCEL
+    if (dpy_cursor_define_supported(s->vga.con)) {
+        caps |= SVGA_CAP_ALPHA_CURSOR;
+        caps |= SVGA_CAP_CURSOR | SVGA_CAP_CURSOR_BYPASS_2 |
+                SVGA_CAP_CURSOR_BYPASS;
+    }
+#endif
+    caps |= SVGA_CAP_IRQMASK;
+    caps |= SVGA_CAP_EXTENDED_FIFO;
+    caps |= SVGA_CAP_DISPLAY_TOPOLOGY;
+    caps |= SVGA_CAP_PITCHLOCK;
+    return caps;
+}
+
 static inline bool vmsvga_verify_rect(DisplaySurface *surface,
                                       const char *name,
                                       int x, int y, int w, int h)
@@ -1140,7 +1164,6 @@ static void vmsvga_index_write(void *opaque, uint32_t address, uint32_t index)
 
 static uint32_t vmsvga_value_read(void *opaque, uint32_t address)
 {
-    uint32_t caps;
     struct vmsvga_state_s *s = opaque;
     DisplaySurface *surface = qemu_console_surface(s->vga.con);
     PixelFormat pf;
@@ -1228,25 +1251,7 @@ static uint32_t vmsvga_value_read(void *opaque, uint32_t address)
         break;
 
     case SVGA_REG_CAPABILITIES:
-        caps = SVGA_CAP_NONE;
-#ifdef HW_RECT_ACCEL
-        caps |= SVGA_CAP_RECT_COPY;
-#endif
-#ifdef HW_FILL_ACCEL
-        caps |= SVGA_CAP_RECT_FILL;
-#endif
-#ifdef HW_MOUSE_ACCEL
-        if (dpy_cursor_define_supported(s->vga.con)) {
-            caps |= SVGA_CAP_ALPHA_CURSOR;
-            caps |= SVGA_CAP_CURSOR | SVGA_CAP_CURSOR_BYPASS_2 |
-                    SVGA_CAP_CURSOR_BYPASS;
-        }
-#endif
-        caps |= SVGA_CAP_EXTENDED_FIFO;
-        caps |= SVGA_CAP_IRQMASK;
-        caps |= SVGA_CAP_DISPLAY_TOPOLOGY;
-        caps |= SVGA_CAP_PITCHLOCK;
-        ret = caps;
+        ret = vmsvga_device_caps(s);
         break;
 
     case SVGA_REG_MEM_START: {
-- 
1.9.1
