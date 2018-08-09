Received: from eggs.gnu.org ([2001:4830:134:3::10]:56321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjPb-0004tm-Uj
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjPZ-0007Cj-B0
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1fnjPZ-0007CN-0I
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:25 -0400
From: Liran Alon <liran.alon@oracle.com>
Date: Thu,  9 Aug 2018 14:46:22 +0300
Message-Id: <1533815202-11967-10-git-send-email-liran.alon@oracle.com>
In-Reply-To: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
Subject: [Qemu-devel] [PATCH 09/29] vmsvga: Account for length of command
 word when parsing commands
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

While we continue to ignore SVGA_CMD_RECT_ROP_FILL, SVGA_CMD_RECT_ROP_COPY
and SVGA_CMD_FENCE commands, we should account for command length, not only
arguments following command code.

Signed-off-by: Leonid Shatz <leonid.shatz@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/display/vmware_vga.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 675c8755ab48..b32a625ae9c2 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -731,9 +731,17 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
          * arguments so we can avoid FIFO desync
          */
         case SVGA_CMD_RECT_ROP_FILL: /* deprecated */
+            len -= 1;
+            if (len < 0) {
+                goto rewind;
+            }
             args = 6;
             goto badcmd;
         case SVGA_CMD_RECT_ROP_COPY: /* deprecated */
+            len -= 1;
+            if (len < 0) {
+                goto rewind;
+            }
             args = 7;
             goto badcmd;
         case SVGA_CMD_DEFINE_ALPHA_CURSOR:
@@ -761,6 +769,10 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
             args = 12;
             goto badcmd;
         case SVGA_CMD_FENCE:
+            len -= 1;
+            if (len < 0) {
+                goto rewind;
+            }
             args = 1;
             goto badcmd;
 
-- 
1.9.1
