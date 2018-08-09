Received: from eggs.gnu.org ([2001:4830:134:3::10]:56623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjQR-0005ba-Lv
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:48:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjQP-0007fT-1s
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:48:19 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1fnjQO-0007fC-NJ
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:48:16 -0400
From: Liran Alon <liran.alon@oracle.com>
Date: Thu,  9 Aug 2018 14:46:40 +0300
Message-Id: <1533815202-11967-28-git-send-email-liran.alon@oracle.com>
In-Reply-To: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
Subject: [Qemu-devel] [PATCH 27/29] vmsvga: Add support for pitchlock
 register (a display line stride)
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

Indicate support of SVGA_REG_PITCHLOCK in device capabilities.
Value written by driver to SVGA_REG_PITCHLOCK is used to overwrite
the default line length derived from display width and bpp. Due to
lack of clear documentation, we resume using default formula for
line length when screen width is updated more than once without
update to SVGA_REG_PITCHLOCK register, which works for all tested
guests using vmsvga.

SVGA_REG_PITCHLOCK is required by Linux kernel vmsvga driver
(See Linux kernel vmw_driver_load()).

Signed-off-by: Leonid Shatz <leonid.shatz@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/display/vmware_vga.c | 43 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index edd336e65005..bd7202833081 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -82,6 +82,8 @@ struct vmsvga_state_s {
     uint32_t irq_mask;
     uint32_t irq_status;
     uint32_t display_id;
+    uint32_t pitchlock;
+    int use_pitchlock;
 };
 
 #define TYPE_VMWARE_SVGA "vmware-svga"
@@ -1198,9 +1200,10 @@ static uint32_t vmsvga_value_read(void *opaque, uint32_t address)
         break;
 
     case SVGA_REG_BYTES_PER_LINE:
-        if (s->new_width) {
-            ret = (s->new_depth * s->new_width) / 8;
-        } else {
+        ret = (s->use_pitchlock >= 0) ?
+                s->pitchlock :
+                ((s->new_depth * s->new_width) / 8);
+        if (!ret) {
             ret = surface_stride(surface);
         }
         break;
@@ -1242,6 +1245,7 @@ static uint32_t vmsvga_value_read(void *opaque, uint32_t address)
         caps |= SVGA_CAP_EXTENDED_FIFO;
         caps |= SVGA_CAP_IRQMASK;
         caps |= SVGA_CAP_DISPLAY_TOPOLOGY;
+        caps |= SVGA_CAP_PITCHLOCK;
         ret = caps;
         break;
 
@@ -1294,11 +1298,14 @@ static uint32_t vmsvga_value_read(void *opaque, uint32_t address)
         break;
 
     case SVGA_REG_NUM_DISPLAYS:
-    case SVGA_REG_PITCHLOCK:
     case SVGA_PALETTE_BASE ... SVGA_PALETTE_END:
         ret = 0;
         break;
 
+    case SVGA_REG_PITCHLOCK:
+       ret = s->pitchlock;
+       break;
+
     case SVGA_REG_IRQMASK:
         ret = s->irq_mask;
         break;
@@ -1394,6 +1401,13 @@ static void vmsvga_value_write(void *opaque, uint32_t address, uint32_t value)
         if (value <= SVGA_MAX_WIDTH) {
             s->new_width = value;
             s->invalidated = 1;
+            /* This is a hack used to drop effective pitchlock setting
+             * when guest writes screen width without prior write to
+             * the pitchlock register.
+             */
+            if (s->use_pitchlock >= 0) {
+                s->use_pitchlock--;
+            }
         } else {
             printf("%s: Bad width: %i\n", __func__, value);
         }
@@ -1464,10 +1478,15 @@ static void vmsvga_value_write(void *opaque, uint32_t address, uint32_t value)
     case SVGA_REG_DEPTH:
     case SVGA_REG_MEM_REGS:
     case SVGA_REG_NUM_DISPLAYS:
-    case SVGA_REG_PITCHLOCK:
     case SVGA_PALETTE_BASE ... SVGA_PALETTE_END:
         break;
 
+    case SVGA_REG_PITCHLOCK:
+       s->pitchlock = value;
+       s->use_pitchlock = (value > 0) ? 1 : -1;
+       s->invalidated = 1;
+       break;
+
     case SVGA_REG_IRQMASK:
         s->irq_mask = value;
         break;
@@ -1540,16 +1559,20 @@ static void vmsvga_bios_write(void *opaque, uint32_t address, uint32_t data)
 static inline void vmsvga_check_size(struct vmsvga_state_s *s)
 {
     DisplaySurface *surface = qemu_console_surface(s->vga.con);
+    uint32_t new_stride;
 
+    new_stride = (s->use_pitchlock >= 0) ?
+        s->pitchlock :
+        ((s->new_depth * s->new_width) / 8);
     if (s->new_width != surface_width(surface) ||
         s->new_height != surface_height(surface) ||
+        (new_stride != surface_stride(surface)) ||
         s->new_depth != surface_bits_per_pixel(surface)) {
-        int stride = (s->new_depth * s->new_width) / 8;
         pixman_format_code_t format =
             qemu_default_pixman_format(s->new_depth, true);
         trace_vmware_setmode(s->new_width, s->new_height, s->new_depth);
         surface = qemu_create_displaysurface_from(s->new_width, s->new_height,
-                                                  format, stride,
+                                                  format, new_stride,
                                                   s->vga.vram_ptr);
         dpy_gfx_replace_surface(s->vga.con, surface);
         s->invalidated = 1;
@@ -1598,6 +1621,8 @@ static void vmsvga_reset(DeviceState *dev)
     s->irq_status = 0;
     s->last_fifo_cursor_count = 0;
     s->display_id = SVGA_ID_INVALID;
+    s->pitchlock = 0;
+    s->use_pitchlock = -1;
 
     vga_dirty_log_start(&s->vga);
 }
@@ -1633,6 +1658,8 @@ static int vmsvga_post_load(void *opaque, int version_id)
         s->irq_status = 0;
         s->last_fifo_cursor_count = 0;
         s->display_id = SVGA_ID_INVALID;
+        s->pitchlock = 0;
+        s->use_pitchlock = -1;
     }
 
     return 0;
@@ -1664,6 +1691,8 @@ static const VMStateDescription vmstate_vmware_vga_internal = {
         VMSTATE_UINT32_V(irq_status, struct vmsvga_state_s, 1),
         VMSTATE_UINT32_V(last_fifo_cursor_count, struct vmsvga_state_s, 1),
         VMSTATE_UINT32_V(display_id, struct vmsvga_state_s, 1),
+        VMSTATE_UINT32_V(pitchlock, struct vmsvga_state_s, 1),
+        VMSTATE_INT32_V(use_pitchlock, struct vmsvga_state_s, 1),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
1.9.1
