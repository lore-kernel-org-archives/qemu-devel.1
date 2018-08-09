Received: from eggs.gnu.org ([2001:4830:134:3::10]:56371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjPk-000542-I4
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjPh-0007FO-TY
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1fnjPh-0007Ej-JQ
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:33 -0400
From: Liran Alon <liran.alon@oracle.com>
Date: Thu,  9 Aug 2018 14:46:25 +0300
Message-Id: <1533815202-11967-13-git-send-email-liran.alon@oracle.com>
In-Reply-To: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
Subject: [Qemu-devel] [PATCH 12/29] vmsvga: Add definitions of FIFO
 registers and report their number
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

Import FIFO register definitions from VMware SVGA Device Developer Kit.
Report number of available registers so that guest device driver can
reserve enough space for registers before command FIFO.

Signed-off-by: Leonid Shatz <leonid.shatz@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/display/vmware_vga.c | 126 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 121 insertions(+), 5 deletions(-)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index f0e6b4bc74ba..8eeb0efc9cab 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -76,6 +76,8 @@ struct vmsvga_state_s {
         int x, y, w, h;
     } redraw_fifo[REDRAW_FIFO_LEN];
     int redraw_fifo_first, redraw_fifo_last;
+
+    uint32_t num_fifo_regs;
 };
 
 #define TYPE_VMWARE_SVGA "vmware-svga"
@@ -194,14 +196,124 @@ enum {
     SVGA_FIFO_NEXT,
     SVGA_FIFO_STOP,
 
-    /*
-     * Additional offsets added as of SVGA_CAP_EXTENDED_FIFO
-     */
+   /*
+    * Block 2 (extended registers): Mandatory registers for the extended
+    * FIFO.  These exist if the SVGA caps register includes
+    * SVGA_CAP_EXTENDED_FIFO; some of them are valid only if their
+    * associated capability bit is enabled.
+    *
+    * Note that when originally defined, SVGA_CAP_EXTENDED_FIFO implied
+    * support only for (FIFO registers) CAPABILITIES, FLAGS, and FENCE.
+    * This means that the guest has to test individually (in most cases
+    * using FIFO caps) for the presence of registers after this; the VMX
+    * can define "extended FIFO" to mean whatever it wants, and currently
+    * won't enable it unless there's room for that set and much more.
+    */
+
     SVGA_FIFO_CAPABILITIES = 4,
     SVGA_FIFO_FLAGS,
     SVGA_FIFO_FENCE,
-    SVGA_FIFO_3D_HWVERSION,
-    SVGA_FIFO_PITCHLOCK,
+
+   /*
+    * Block 3a (optional extended registers): Additional registers for the
+    * extended FIFO, whose presence isn't actually implied by
+    * SVGA_CAP_EXTENDED_FIFO; these exist if SVGA_FIFO_MIN is high enough to
+    * leave room for them.
+    *
+    * These in block 3a, the VMX currently considers mandatory for the
+    * extended FIFO.
+    */
+
+   /* Valid if exists (i.e. if extended FIFO enabled): */
+   SVGA_FIFO_3D_HWVERSION,       /* See SVGA3dHardwareVersion in svga3d_reg.h */
+   /* Valid with SVGA_FIFO_CAP_PITCHLOCK: */
+   SVGA_FIFO_PITCHLOCK,
+
+   /* Valid with SVGA_FIFO_CAP_CURSOR_BYPASS_3: */
+   SVGA_FIFO_CURSOR_ON,          /* Cursor bypass 3 show/hide register */
+   SVGA_FIFO_CURSOR_X,           /* Cursor bypass 3 x register */
+   SVGA_FIFO_CURSOR_Y,           /* Cursor bypass 3 y register */
+   SVGA_FIFO_CURSOR_COUNT,       /* Incremented when any of the other 3 change */
+   SVGA_FIFO_CURSOR_LAST_UPDATED,/* Last time the host updated the cursor */
+
+   /* Valid with SVGA_FIFO_CAP_RESERVE: */
+   SVGA_FIFO_RESERVED,           /* Bytes past NEXT_CMD with real contents */
+
+   /*
+    * Valid with SVGA_FIFO_CAP_SCREEN_OBJECT or SVGA_FIFO_CAP_SCREEN_OBJECT_2:
+    *
+    * By default this is SVGA_ID_INVALID, to indicate that the cursor
+    * coordinates are specified relative to the virtual root. If this
+    * is set to a specific screen ID, cursor position is reinterpreted
+    * as a signed offset relative to that screen's origin.
+    */
+   SVGA_FIFO_CURSOR_SCREEN_ID,
+
+   /*
+    * Valid with SVGA_FIFO_CAP_DEAD
+    *
+    * An arbitrary value written by the host, drivers should not use it.
+    */
+   SVGA_FIFO_DEAD,
+
+   /*
+    * Valid with SVGA_FIFO_CAP_3D_HWVERSION_REVISED:
+    *
+    * Contains 3D HWVERSION (see SVGA3dHardwareVersion in svga3d_reg.h)
+    * on platforms that can enforce graphics resource limits.
+    */
+   SVGA_FIFO_3D_HWVERSION_REVISED,
+
+   /*
+    * XXX: The gap here, up until SVGA_FIFO_3D_CAPS, can be used for new
+    * registers, but this must be done carefully and with judicious use of
+    * capability bits, since comparisons based on SVGA_FIFO_MIN aren't
+    * enough to tell you whether the register exists: we've shipped drivers
+    * and products that used SVGA_FIFO_3D_CAPS but didn't know about some of
+    * the earlier ones.  The actual order of introduction was:
+    * - PITCHLOCK
+    * - 3D_CAPS
+    * - CURSOR_* (cursor bypass 3)
+    * - RESERVED
+    * So, code that wants to know whether it can use any of the
+    * aforementioned registers, or anything else added after PITCHLOCK and
+    * before 3D_CAPS, needs to reason about something other than
+    * SVGA_FIFO_MIN.
+    */
+
+   /*
+    * 3D caps block space; valid with 3D hardware version >=
+    * SVGA3D_HWVERSION_WS6_B1.
+    */
+   SVGA_FIFO_3D_CAPS      = 32,
+   SVGA_FIFO_3D_CAPS_LAST = 32 + 255,
+
+   /*
+    * End of VMX's current definition of "extended-FIFO registers".
+    * Registers before here are always enabled/disabled as a block; either
+    * the extended FIFO is enabled and includes all preceding registers, or
+    * it's disabled entirely.
+    *
+    * Block 3b (truly optional extended registers): Additional registers for
+    * the extended FIFO, which the VMX already knows how to enable and
+    * disable with correct granularity.
+    *
+    * Registers after here exist if and only if the guest SVGA driver
+    * sets SVGA_FIFO_MIN high enough to leave room for them.
+    */
+
+   /* Valid if register exists: */
+   SVGA_FIFO_GUEST_3D_HWVERSION, /* Guest driver's 3D version */
+   SVGA_FIFO_FENCE_GOAL,         /* Matching target for SVGA_IRQFLAG_FENCE_GOAL */
+   SVGA_FIFO_BUSY,               /* See "FIFO Synchronization Registers" */
+
+   /*
+    * Always keep this last.  This defines the maximum number of
+    * registers we know about.  At power-on, this value is placed in
+    * the SVGA_REG_MEM_REGS register, and we expect the guest driver
+    * to allocate this much space in FIFO memory for registers.
+    */
+    SVGA_FIFO_NUM_REGS
 };
 
 #define SVGA_FIFO_CAP_NONE              0
@@ -969,6 +1081,9 @@ static uint32_t vmsvga_value_read(void *opaque, uint32_t address)
         break;
 
     case SVGA_REG_MEM_REGS:
+        ret = s->num_fifo_regs;
+        break;
+
     case SVGA_REG_NUM_DISPLAYS:
     case SVGA_REG_PITCHLOCK:
     case SVGA_PALETTE_BASE ... SVGA_PALETTE_END:
@@ -1268,6 +1383,7 @@ static void vmsvga_init(DeviceState *dev, struct vmsvga_state_s *s,
     memory_region_init_ram(&s->fifo_ram, NULL, "vmsvga.fifo", s->fifo_size,
                            &error_fatal);
     s->fifo = (uint32_t *)memory_region_get_ram_ptr(&s->fifo_ram);
+    s->num_fifo_regs = SVGA_FIFO_NUM_REGS;
 
     vga_common_init(&s->vga, OBJECT(dev));
     vga_init(&s->vga, OBJECT(dev), address_space, io, true);
-- 
1.9.1
