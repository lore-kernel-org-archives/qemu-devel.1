Received: from eggs.gnu.org ([2001:4830:134:3::10]:56488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjQ4-0005Kh-TD
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjQ2-0007We-8l
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1fnjQ1-0007WQ-VU
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:54 -0400
From: Liran Alon <liran.alon@oracle.com>
Date: Thu,  9 Aug 2018 14:46:32 +0300
Message-Id: <1533815202-11967-20-git-send-email-liran.alon@oracle.com>
In-Reply-To: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
Subject: [Qemu-devel] [PATCH 19/29] vmsvga: Handle SVGA_CMD_FENCE command
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

According to Linux kernel
drivers/gpu/drm/vmwgfx/device_include/svga_reg.h:

/*
 * SVGA_CMD_FENCE --
 *
 *    Insert a synchronization fence.  When the SVGA device reaches
 *    this command, it will copy the 'fence' value into the
 *    SVGA_FIFO_FENCE register. It will also compare the fence against
 *    SVGA_FIFO_FENCE_GOAL. If the fence matches the goal and the
 *    SVGA_IRQFLAG_FENCE_GOAL interrupt is enabled, the device will
 *    raise this interrupt.
 *
 * Availability:
 *    SVGA_FIFO_FENCE for this command,
 *    SVGA_CAP_IRQMASK for SVGA_FIFO_FENCE_GOAL.
 */

Signed-off-by: Leonid Shatz <leonid.shatz@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/display/vmware_vga.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index dc5f4681f0d3..73e373665bdb 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -217,6 +217,7 @@ enum {
 
     SVGA_FIFO_CAPABILITIES = 4,
     SVGA_FIFO_FLAGS,
+    /* Valid with SVGA_FIFO_CAP_FENCE */
     SVGA_FIFO_FENCE,
 
    /*
@@ -729,6 +730,7 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
     int x, y, dx, dy, width, height;
     struct vmsvga_cursor_definition_s cursor;
     uint32_t cmd_start;
+    uint32_t fence_arg;
     bool cmd_ignored;
     bool irq_pending = false;
     bool fifo_progress = false;
@@ -832,6 +834,28 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
             args = 6;
             goto ignoredcmd;
 
+        case SVGA_CMD_FENCE:
+            len -= 2;
+            if (len < 0) {
+                goto rewind;
+            }
+
+            fence_arg = vmsvga_fifo_read(s);
+            s->fifo[SVGA_FIFO_FENCE] = cpu_to_le32(fence_arg);
+
+            if (s->irq_mask & SVGA_IRQFLAG_ANY_FENCE) {
+                s->irq_status |= SVGA_IRQFLAG_ANY_FENCE;
+                irq_pending = true;
+            }
+            if ((s->irq_mask & SVGA_IRQFLAG_FENCE_GOAL)
+               && (s->fifo_min > SVGA_FIFO_FENCE_GOAL)
+               && (s->fifo[SVGA_FIFO_FENCE_GOAL] == fence_arg)) {
+                s->irq_status |= SVGA_IRQFLAG_FENCE_GOAL;
+                irq_pending = true;
+            }
+
+            break;
+
         /*
          * Deprecated commands are neither documented in VMware SVGA development kit
          * nor in Linux kernel vmware-svga driver source code.
@@ -899,13 +923,6 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
         case SVGA_CMD_SURFACE_ALPHA_BLEND: /* deprecated */
             args = 12;
             goto badcmd;
-        case SVGA_CMD_FENCE:
-            len -= 1;
-            if (len < 0) {
-                goto rewind;
-            }
-            args = 1;
-            goto badcmd;
 
         default:
             args = 0;
@@ -1463,7 +1480,7 @@ static void vmsvga_init(DeviceState *dev, struct vmsvga_state_s *s,
                            &error_fatal);
     s->fifo = (uint32_t *)memory_region_get_ram_ptr(&s->fifo_ram);
     s->num_fifo_regs = SVGA_FIFO_NUM_REGS;
-    s->fifo[SVGA_FIFO_CAPABILITIES] = 0;
+    s->fifo[SVGA_FIFO_CAPABILITIES] = SVGA_FIFO_CAP_FENCE;
     s->fifo[SVGA_FIFO_FLAGS] = 0;
 
     vga_common_init(&s->vga, OBJECT(dev));
-- 
1.9.1
