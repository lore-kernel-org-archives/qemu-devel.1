Received: from eggs.gnu.org ([2001:4830:134:3::10]:56204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjPN-0004ko-LG
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjPL-00075j-2U
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:13 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36706)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1fnjPK-00075Q-Oz
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:10 -0400
From: Liran Alon <liran.alon@oracle.com>
Date: Thu,  9 Aug 2018 14:46:17 +0300
Message-Id: <1533815202-11967-5-git-send-email-liran.alon@oracle.com>
In-Reply-To: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
Subject: [Qemu-devel] [PATCH 04/29] vmsvga: Do not print error message for
 ignored commands
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

Future patches will add handling of commands that are parsed but
deliberately ignored. This change adds required framework for
avoiding printing parsing error messages for these commands,
when we encounter them in the FIFO.

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/display/vmware_vga.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index a244f43a866f..2e6ac5dfad8a 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -600,11 +600,13 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
     int x, y, dx, dy, width, height;
     struct vmsvga_cursor_definition_s cursor;
     uint32_t cmd_start;
+    bool cmd_ignored;
 
     len = vmsvga_fifo_length(s);
     while (len > 0 && --maxloop > 0) {
         /* May need to go back to the start of the command if incomplete */
         cmd_start = s->fifo_stop;
+        cmd_ignored = false;
 
         switch (cmd = vmsvga_fifo_read(s)) {
 
@@ -759,6 +761,9 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
 
         default:
             args = 0;
+            goto badcmd;
+        ignoredcmd:
+            cmd_ignored = true;
         badcmd:
             len -= args;
             if (len < 0) {
@@ -767,8 +772,10 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
             while (args--) {
                 vmsvga_fifo_read(s);
             }
-            printf("%s: Unknown command 0x%02x in SVGA command FIFO\n",
-                   __func__, cmd);
+            if (!cmd_ignored) {
+                printf("%s: Unknown command 0x%02x in SVGA command FIFO\n",
+                       __func__, cmd);
+            }
             break;
 
         rewind:
-- 
1.9.1
