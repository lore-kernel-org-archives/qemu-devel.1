Received: from eggs.gnu.org ([2001:4830:134:3::10]:56250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjPS-0004on-O1
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjPQ-00077n-5n
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1fnjPP-00077R-Sh
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:16 -0400
From: Liran Alon <liran.alon@oracle.com>
Date: Thu,  9 Aug 2018 14:46:19 +0300
Message-Id: <1533815202-11967-7-git-send-email-liran.alon@oracle.com>
In-Reply-To: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
Subject: [Qemu-devel] [PATCH 06/29] vmsvga: Fix parse of
 SVGA_CMD_UPDATE_VERBOSE to consider additional opaque cookie
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

SVGA_CMD_UPDATE_VERBOSE has one more extra argument to fetch from command fifo,
as compared to SVGA_CMD_UPDATE command. From Linux kernel
drivers/gpu/drm/vmwgfx/device_include/svga_reg.h:
"Just like SVGA_CMD_UPDATE, but also provide a per-rectangle
'reason' value, an opaque cookie which is used by internal
debugging tools. Third party drivers should not use this
command."

Signed-off-by: Leonid Shatz <leonid.shatz@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/display/vmware_vga.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 2fbb9e7f6c9f..d3a78809673d 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -611,8 +611,11 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
         switch (cmd = vmsvga_fifo_read(s)) {
 
         /* Implemented commands */
-        case SVGA_CMD_UPDATE:
         case SVGA_CMD_UPDATE_VERBOSE:
+            /* One extra word: an opaque cookie which is used for debugging */
+            len -= 1;
+            /* fall through */
+        case SVGA_CMD_UPDATE:
             len -= 5;
             if (len < 0) {
                 goto rewind;
@@ -622,6 +625,8 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
             y = vmsvga_fifo_read(s);
             width = vmsvga_fifo_read(s);
             height = vmsvga_fifo_read(s);
+            if (cmd == SVGA_CMD_UPDATE_VERBOSE)
+                vmsvga_fifo_read(s);
             vmsvga_update_rect_delayed(s, x, y, width, height);
             break;
 
-- 
1.9.1
