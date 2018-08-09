Received: from eggs.gnu.org ([2001:4830:134:3::10]:56601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjQP-0005ZB-21
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:48:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjQM-0007em-El
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:48:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1fnjQM-0007eT-4j
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:48:14 -0400
From: Liran Alon <liran.alon@oracle.com>
Date: Thu,  9 Aug 2018 14:46:39 +0300
Message-Id: <1533815202-11967-27-git-send-email-liran.alon@oracle.com>
In-Reply-To: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
Subject: [Qemu-devel] [PATCH 26/29] vmsvga: Add basic support for display
 topology
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

Report SVGA_CAP_DISPLAY_TOPOLOGY capability and support single
legacy screen at fixed offset of (0,0).

This is a pre-requesite for supporting PITCHLOCK feature which is
required by Linux kernel vmsvga driver (See Linux kernel
vmw_driver_load()).

Signed-off-by: Leonid Shatz <leonid.shatz@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/display/vmware_vga.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index b2f3456357bd..edd336e65005 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -81,6 +81,7 @@ struct vmsvga_state_s {
     uint32_t num_fifo_regs;
     uint32_t irq_mask;
     uint32_t irq_status;
+    uint32_t display_id;
 };
 
 #define TYPE_VMWARE_SVGA "vmware-svga"
@@ -103,6 +104,9 @@ struct pci_vmsvga_state_s {
 #define SVGA_ID_1               SVGA_MAKE_ID(1)
 #define SVGA_ID_2               SVGA_MAKE_ID(2)
 
+/* "Invalid" value for all SVGA IDs. (Version ID, screen object ID, surface ID...) */
+#define SVGA_ID_INVALID         0xFFFFFFFF
+
 #define SVGA_LEGACY_BASE_PORT   0x4560
 #define SVGA_INDEX_PORT         0x0
 #define SVGA_VALUE_PORT         0x1
@@ -164,6 +168,15 @@ enum {
     SVGA_REG_PITCHLOCK = 32,            /* Fixed pitch for all modes */
     SVGA_REG_IRQMASK = 33,              /* Interrupt mask */
 
+    /* Legacy multi-monitor support */
+    SVGA_REG_NUM_GUEST_DISPLAYS = 34,   /* Number of guest displays in X/Y direction */
+    SVGA_REG_DISPLAY_ID = 35,           /* Display ID for the following display attributes */
+    SVGA_REG_DISPLAY_IS_PRIMARY = 36,   /* Whether this is a primary display */
+    SVGA_REG_DISPLAY_POSITION_X = 37,   /* The display position x */
+    SVGA_REG_DISPLAY_POSITION_Y = 38,   /* The display position y */
+    SVGA_REG_DISPLAY_WIDTH = 39,        /* The display's width */
+    SVGA_REG_DISPLAY_HEIGHT = 40,       /* The display's height */
+
     /* Guest memory regions */
     SVGA_REG_GMR_ID = 41,
     SVGA_REG_GMR_DESCRIPTOR = 42,
@@ -195,6 +208,7 @@ enum {
 #define SVGA_CAP_MULTIMON               (1 << 16)
 #define SVGA_CAP_PITCHLOCK              (1 << 17)
 #define SVGA_CAP_IRQMASK                (1 << 18)
+#define SVGA_CAP_DISPLAY_TOPOLOGY       (1 << 19)   // Legacy multi-monitor support
 
 /*
  * FIFO offsets (seen as an array of 32-bit words)
@@ -1227,6 +1241,7 @@ static uint32_t vmsvga_value_read(void *opaque, uint32_t address)
 #endif
         caps |= SVGA_CAP_EXTENDED_FIFO;
         caps |= SVGA_CAP_IRQMASK;
+        caps |= SVGA_CAP_DISPLAY_TOPOLOGY;
         ret = caps;
         break;
 
@@ -1288,6 +1303,32 @@ static uint32_t vmsvga_value_read(void *opaque, uint32_t address)
         ret = s->irq_mask;
         break;
 
+    case SVGA_REG_NUM_GUEST_DISPLAYS:
+        ret = 1;
+        break;
+    case SVGA_REG_DISPLAY_ID:
+        ret = s->display_id;
+        break;
+    case SVGA_REG_DISPLAY_IS_PRIMARY:
+        ret = s->display_id == 0 ? 1 : 0;
+        break;
+    case SVGA_REG_DISPLAY_POSITION_X:
+    case SVGA_REG_DISPLAY_POSITION_Y:
+        ret = 0;
+        break;
+    case SVGA_REG_DISPLAY_WIDTH:
+        if ((s->display_id == 0) || (s->display_id == SVGA_ID_INVALID))
+            ret = s->new_width ? s->new_width : surface_width(surface);
+        else
+            ret = 0;
+        break;
+    case SVGA_REG_DISPLAY_HEIGHT:
+        if ((s->display_id == 0) || (s->display_id == SVGA_ID_INVALID))
+            ret = s->new_height ? s->new_height : surface_height(surface);
+        else
+            ret = 0;
+        break;
+
     /* Guest memory regions */
     case SVGA_REG_GMR_ID:
     case SVGA_REG_GMR_DESCRIPTOR:
@@ -1431,6 +1472,28 @@ static void vmsvga_value_write(void *opaque, uint32_t address, uint32_t value)
         s->irq_mask = value;
         break;
 
+    /* We support single legacy screen at fixed offset of (0,0) */
+    case SVGA_REG_DISPLAY_ID:
+        s->display_id = value;
+        break;
+    case SVGA_REG_NUM_GUEST_DISPLAYS:
+    case SVGA_REG_DISPLAY_IS_PRIMARY:
+    case SVGA_REG_DISPLAY_POSITION_X:
+    case SVGA_REG_DISPLAY_POSITION_Y:
+        break;
+    case SVGA_REG_DISPLAY_WIDTH:
+        if ((s->display_id == 0) && (value <= SVGA_MAX_WIDTH)) {
+            s->new_width = value;
+            s->invalidated = 1;
+        }
+        break;
+    case SVGA_REG_DISPLAY_HEIGHT:
+        if ((s->display_id == 0) && (value <= SVGA_MAX_HEIGHT)) {
+            s->new_height = value;
+            s->invalidated = 1;
+        }
+        break;
+
     default:
         if (s->index >= SVGA_SCRATCH_BASE &&
                 s->index < SVGA_SCRATCH_BASE + s->scratch_size) {
@@ -1534,6 +1597,7 @@ static void vmsvga_reset(DeviceState *dev)
     s->irq_mask = 0;
     s->irq_status = 0;
     s->last_fifo_cursor_count = 0;
+    s->display_id = SVGA_ID_INVALID;
 
     vga_dirty_log_start(&s->vga);
 }
@@ -1568,6 +1632,7 @@ static int vmsvga_post_load(void *opaque, int version_id)
         s->irq_mask = 0;
         s->irq_status = 0;
         s->last_fifo_cursor_count = 0;
+        s->display_id = SVGA_ID_INVALID;
     }
 
     return 0;
@@ -1598,6 +1663,7 @@ static const VMStateDescription vmstate_vmware_vga_internal = {
         VMSTATE_UINT32_V(irq_mask, struct vmsvga_state_s, 1),
         VMSTATE_UINT32_V(irq_status, struct vmsvga_state_s, 1),
         VMSTATE_UINT32_V(last_fifo_cursor_count, struct vmsvga_state_s, 1),
+        VMSTATE_UINT32_V(display_id, struct vmsvga_state_s, 1),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
1.9.1
