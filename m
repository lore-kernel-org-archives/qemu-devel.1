Received: from eggs.gnu.org ([2001:4830:134:3::10]:56579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjQM-0005WQ-ID
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:48:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjQJ-0007eC-US
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:48:14 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:48576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1fnjQJ-0007dq-L6
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:48:11 -0400
From: Liran Alon <liran.alon@oracle.com>
Date: Thu,  9 Aug 2018 14:46:38 +0300
Message-Id: <1533815202-11967-26-git-send-email-liran.alon@oracle.com>
In-Reply-To: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
Subject: [Qemu-devel] [PATCH 25/29] vmsvga: Add basic support for GMR
 registers and FIFO commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net, habkost@redhat.com, kraxel@redhat.com, Liran Alon <liran.alon@oracle.com>

We don't support GMR regions while reporting caps, but some guests may try
to send us some GMR queries and we do our best to ignore them while avoiding
FIFO command crash.

Reported-by: Leonid Shatz <leonid.shatz@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/display/vmware_vga.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 1db8f92f053b..b2f3456357bd 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -164,6 +164,12 @@ enum {
     SVGA_REG_PITCHLOCK = 32,            /* Fixed pitch for all modes */
     SVGA_REG_IRQMASK = 33,              /* Interrupt mask */
 
+    /* Guest memory regions */
+    SVGA_REG_GMR_ID = 41,
+    SVGA_REG_GMR_DESCRIPTOR = 42,
+    SVGA_REG_GMR_MAX_IDS = 43,
+    SVGA_REG_GMR_MAX_DESCRIPTOR_LENGTH = 44,
+
     SVGA_PALETTE_BASE = 1024,           /* Base of SVGA color map */
     SVGA_PALETTE_END  = SVGA_PALETTE_BASE + 767,
     SVGA_SCRATCH_BASE = SVGA_PALETTE_BASE + 768,
@@ -409,6 +415,8 @@ enum {
     SVGA_CMD_SURFACE_ALPHA_BLEND = 28,    /* deprecated */
     SVGA_CMD_FRONT_ROP_FILL = 29,
     SVGA_CMD_FENCE = 30,
+    SVGA_CMD_DEFINE_GMR2 = 41,
+    SVGA_CMD_REMAP_GMR2 = 42,
 };
 
 /* Legal values for the SVGA_REG_CURSOR_ON register in cursor bypass mode */
@@ -419,6 +427,13 @@ enum {
     SVGA_CURSOR_ON_RESTORE_TO_FB = 3,
 };
 
+enum {
+   SVGA_REMAP_GMR2_PPN32         = 0,
+   SVGA_REMAP_GMR2_VIA_GMR       = (1 << 0),
+   SVGA_REMAP_GMR2_PPN64         = (1 << 1),
+   SVGA_REMAP_GMR2_SINGLE_PPN    = (1 << 2),
+};
+
 /* Update cursor position from SVGA_FIFO_CURSOR registers */
 static void cursor_update_from_fifo(struct vmsvga_state_s *s)
 {
@@ -795,6 +810,7 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
     struct vmsvga_cursor_definition_s cursor;
     uint32_t cmd_start;
     uint32_t fence_arg;
+    uint32_t flags, num_pages;
     bool cmd_ignored;
     bool irq_pending = false;
     bool fifo_progress = false;
@@ -961,6 +977,36 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
 
             break;
 
+        case SVGA_CMD_DEFINE_GMR2:
+            len -= 1;
+            if (len < 0) {
+                goto rewind;
+            }
+            args = 2;
+            goto badcmd;
+
+        case SVGA_CMD_REMAP_GMR2:
+            len -= 5;
+            if (len < 0) {
+                goto rewind;
+            }
+
+            vmsvga_fifo_read(s);            /* gmrId */
+            flags = vmsvga_fifo_read(s);
+            vmsvga_fifo_read(s);            /* offsetPages */
+            num_pages = vmsvga_fifo_read(s);
+
+            if (flags & SVGA_REMAP_GMR2_VIA_GMR) {
+                /* Read single struct SVGAGuestPtr */
+                args = 2;
+            } else {
+                args = (flags & SVGA_REMAP_GMR2_SINGLE_PPN) ? 1 : num_pages;
+                if (flags & SVGA_REMAP_GMR2_PPN64)
+                    args *= 2;
+            }
+
+            goto badcmd;
+
         /*
          * Deprecated commands are neither documented in VMware SVGA development kit
          * nor in Linux kernel vmware-svga driver source code.
@@ -1242,6 +1288,15 @@ static uint32_t vmsvga_value_read(void *opaque, uint32_t address)
         ret = s->irq_mask;
         break;
 
+    /* Guest memory regions */
+    case SVGA_REG_GMR_ID:
+    case SVGA_REG_GMR_DESCRIPTOR:
+    case SVGA_REG_GMR_MAX_IDS:
+    case SVGA_REG_GMR_MAX_DESCRIPTOR_LENGTH:
+        /* We don't support GMRs */
+        ret = 0;
+        break;
+
     default:
         if (s->index >= SVGA_SCRATCH_BASE &&
             s->index < SVGA_SCRATCH_BASE + s->scratch_size) {
-- 
1.9.1
