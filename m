Received: from eggs.gnu.org ([2001:4830:134:3::10]:56276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjPW-0004s0-8n
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjPT-00079m-KS
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:22 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1fnjPT-00078q-AX
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:19 -0400
From: Liran Alon <liran.alon@oracle.com>
Date: Thu,  9 Aug 2018 14:46:20 +0300
Message-Id: <1533815202-11967-8-git-send-email-liran.alon@oracle.com>
In-Reply-To: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
Subject: [Qemu-devel] [PATCH 07/29] vmsvga: Handle SVGA_CMD_FRONT_ROP_FILL
 command
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

We parse the command structure, but ignore the hint given by command.
Without doing so, command FIFO could get out of sync and cause
vmware-svga device to hang.

>From Linux kernel drivers/gpu/drm/vmwgfx/device_include/svga_reg.h:

    /*
     * SVGA_CMD_FRONT_ROP_FILL --
     *
     *    This is a hint which tells the SVGA device that the driver has
     *    just filled a rectangular region of the GFB with a solid
     *    color. Instead of reading these pixels from the GFB, the device
     *    can assume that they all equal 'color'. This is primarily used
     *    for remote desktop protocols.
     *
     * Availability:
     *    SVGA_FIFO_CAP_ACCELFRONT
     */

    typedef
    struct {
       uint32 color;     /* In the same format as the GFB */
       uint32 x;
       uint32 y;
       uint32 width;
       uint32 height;
       uint32 rop;       /* Must be SVGA_ROP_COPY */
    }
    SVGAFifoCmdFrontRopFill;

Signed-off-by: Leonid Shatz <leonid.shatz@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/display/vmware_vga.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index d3a78809673d..fab6443a87e2 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -693,6 +693,14 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
             goto badcmd;
 #endif
 
+        case SVGA_CMD_FRONT_ROP_FILL:
+            len -= 1;
+            if (len < 0) {
+                goto rewind;
+            }
+            args = 6;
+            goto ignoredcmd;
+
         /*
          * Deprecated commands are neither documented in VMware SVGA development kit
          * nor in Linux kernel vmware-svga driver source code.
@@ -759,7 +767,6 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
          */
         case SVGA_CMD_SURFACE_FILL:
         case SVGA_CMD_SURFACE_COPY:
-        case SVGA_CMD_FRONT_ROP_FILL:
         case SVGA_CMD_FENCE:
         case SVGA_CMD_INVALID_CMD:
             break; /* Nop */
-- 
1.9.1
