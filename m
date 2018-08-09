Received: from eggs.gnu.org ([2001:4830:134:3::10]:56573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjQM-0005Vy-3d
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:48:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjQJ-0007e3-FC
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:48:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:32970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1fnjQJ-0007dh-5W
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:48:11 -0400
From: Liran Alon <liran.alon@oracle.com>
Date: Thu,  9 Aug 2018 14:46:37 +0300
Message-Id: <1533815202-11967-25-git-send-email-liran.alon@oracle.com>
In-Reply-To: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
Subject: [Qemu-devel] [PATCH 24/29] vmsvga: Add support for
 SVGA_FIFO_CAP_CURSOR_BYPASS_3
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

This adds tracking of guest cursor position with the help of FIFO
registers reporting pointing device coordindates.

Signed-off-by: Leonid Shatz <leonid.shatz@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/display/vmware_vga.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 49b46938207e..1db8f92f053b 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -51,6 +51,7 @@ struct vmsvga_state_s {
         int y;
         int on;
     } cursor;
+    uint32_t last_fifo_cursor_count;
 
     int index;
     int scratch_size;
@@ -326,6 +327,7 @@ enum {
 #define SVGA_FIFO_CAP_FENCE             (1 << 0)
 #define SVGA_FIFO_CAP_ACCELFRONT        (1 << 1)
 #define SVGA_FIFO_CAP_PITCHLOCK         (1 << 2)
+#define SVGA_FIFO_CAP_CURSOR_BYPASS_3   (1 << 4)
 
 #define SVGA_FIFO_FLAG_NONE             0
 #define SVGA_FIFO_FLAG_ACCELFRONT       (1 << 0)
@@ -417,6 +419,35 @@ enum {
     SVGA_CURSOR_ON_RESTORE_TO_FB = 3,
 };
 
+/* Update cursor position from SVGA_FIFO_CURSOR registers */
+static void cursor_update_from_fifo(struct vmsvga_state_s *s)
+{
+    uint32_t fifo_cursor_count;
+    uint32_t on_off;
+
+    if (!s->config || !s->enable) {
+        return;
+    }
+
+    if (s->fifo_min <= SVGA_FIFO_CURSOR_LAST_UPDATED) {
+        return;
+    }
+
+    fifo_cursor_count = s->fifo[SVGA_FIFO_CURSOR_COUNT];
+    if (fifo_cursor_count == s->last_fifo_cursor_count)
+        return;
+
+    s->last_fifo_cursor_count = fifo_cursor_count;
+    on_off = s->fifo[SVGA_FIFO_CURSOR_ON] ? SVGA_CURSOR_ON_SHOW : SVGA_CURSOR_ON_HIDE;
+    s->cursor.on = on_off;
+    s->cursor.x = s->fifo[SVGA_FIFO_CURSOR_X];
+    s->cursor.y = s->fifo[SVGA_FIFO_CURSOR_Y];
+
+#ifdef HW_MOUSE_ACCEL
+    dpy_mouse_set(s->vga.con, s->cursor.x, s->cursor.y, s->cursor.on);
+#endif
+}
+
 static inline bool vmsvga_verify_rect(DisplaySurface *surface,
                                       const char *name,
                                       int x, int y, int w, int h)
@@ -1423,6 +1454,7 @@ static void vmsvga_update_display(void *opaque)
 
     vmsvga_fifo_run(s);
     vmsvga_update_rect_flush(s);
+    cursor_update_from_fifo(s);
 
     if (s->invalidated) {
         s->invalidated = 0;
@@ -1446,6 +1478,7 @@ static void vmsvga_reset(DeviceState *dev)
     s->syncing = 0;
     s->irq_mask = 0;
     s->irq_status = 0;
+    s->last_fifo_cursor_count = 0;
 
     vga_dirty_log_start(&s->vga);
 }
@@ -1479,6 +1512,7 @@ static int vmsvga_post_load(void *opaque, int version_id)
     if (version_id < 1) {
         s->irq_mask = 0;
         s->irq_status = 0;
+        s->last_fifo_cursor_count = 0;
     }
 
     return 0;
@@ -1508,6 +1542,7 @@ static const VMStateDescription vmstate_vmware_vga_internal = {
         VMSTATE_UNUSED(4), /* was fb_size */
         VMSTATE_UINT32_V(irq_mask, struct vmsvga_state_s, 1),
         VMSTATE_UINT32_V(irq_status, struct vmsvga_state_s, 1),
+        VMSTATE_UINT32_V(last_fifo_cursor_count, struct vmsvga_state_s, 1),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -1543,7 +1578,8 @@ static void vmsvga_init(DeviceState *dev, struct vmsvga_state_s *s,
                            &error_fatal);
     s->fifo = (uint32_t *)memory_region_get_ram_ptr(&s->fifo_ram);
     s->num_fifo_regs = SVGA_FIFO_NUM_REGS;
-    s->fifo[SVGA_FIFO_CAPABILITIES] = SVGA_FIFO_CAP_FENCE;
+    s->fifo[SVGA_FIFO_CAPABILITIES] =
+        SVGA_FIFO_CAP_FENCE | SVGA_FIFO_CAP_CURSOR_BYPASS_3;
     s->fifo[SVGA_FIFO_FLAGS] = 0;
 
     vga_common_init(&s->vga, OBJECT(dev));
-- 
1.9.1
