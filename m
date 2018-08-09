Received: from eggs.gnu.org ([2001:4830:134:3::10]:56475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjQ1-0005It-Qs
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjPz-0007Vs-7p
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:53 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1fnjPy-0007Vb-RQ
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:51 -0400
From: Liran Alon <liran.alon@oracle.com>
Date: Thu,  9 Aug 2018 14:46:31 +0300
Message-Id: <1533815202-11967-19-git-send-email-liran.alon@oracle.com>
In-Reply-To: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
Subject: [Qemu-devel] [PATCH 18/29] vmsvga: Add support for
 SVGA_IRQFLAG_FIFO_PROGRESS
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

If vmsvga supports interrupts (SVGA_CAP_IRQMASK), some guests wait for
FIFO to become not full by sleeping until FIFO_PROGRESS interrupt occurs.
This is the most efficient thing to do when the FIFO fills up.

To support these guests, add support for SVGA_IRQFLAG_FIFO_PROGRESS.

See usage example by guest in VMware SVGA development kit
SVGAFIFOFull().

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/display/vmware_vga.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 597051ec5c92..dc5f4681f0d3 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -731,6 +731,7 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
     uint32_t cmd_start;
     bool cmd_ignored;
     bool irq_pending = false;
+    bool fifo_progress = false;
 
     len = vmsvga_fifo_length(s);
     while (len > 0 && --maxloop > 0) {
@@ -930,6 +931,15 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
             s->fifo[SVGA_FIFO_STOP] = cpu_to_le32(s->fifo_stop);
             break;
         }
+
+        if (s->fifo_stop != cmd_start)
+            fifo_progress = true;
+    }
+
+    if ((s->irq_mask & SVGA_IRQFLAG_FIFO_PROGRESS) &&
+        fifo_progress) {
+        s->irq_status |= SVGA_IRQFLAG_FIFO_PROGRESS;
+        irq_pending = true;
     }
 
     s->syncing = 0;
-- 
1.9.1
