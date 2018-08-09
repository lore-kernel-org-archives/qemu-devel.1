Received: from eggs.gnu.org ([2001:4830:134:3::10]:56444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjPw-0005FG-Ew
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1fnjPt-0007U6-R4
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:48 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:48316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1fnjPt-0007SX-Gv
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:47:45 -0400
From: Liran Alon <liran.alon@oracle.com>
Date: Thu,  9 Aug 2018 14:46:29 +0300
Message-Id: <1533815202-11967-17-git-send-email-liran.alon@oracle.com>
In-Reply-To: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
References: <1533815202-11967-1-git-send-email-liran.alon@oracle.com>
Subject: [Qemu-devel] [PATCH 16/29] vmsvga: Add framework code for SVGA
 command to raise interrupt
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

Should not change semantics.
This is done as a preparation for future patches.

Signed-off-by: Leonid Shatz <leonid.shatz@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/display/vmware_vga.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 4e4f6f8eec42..ce5b8814ac91 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -718,6 +718,7 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
     struct vmsvga_cursor_definition_s cursor;
     uint32_t cmd_start;
     bool cmd_ignored;
+    bool irq_pending = false;
 
     len = vmsvga_fifo_length(s);
     while (len > 0 && --maxloop > 0) {
@@ -920,6 +921,13 @@ static void vmsvga_fifo_run(struct vmsvga_state_s *s)
     }
 
     s->syncing = 0;
+
+    /* Need to raise irq ? */
+    if (irq_pending && (s->irq_status & s->irq_mask)) {
+        struct pci_vmsvga_state_s *pci_vmsvga
+            = container_of(s, struct pci_vmsvga_state_s, chip);
+        pci_set_irq(PCI_DEVICE(pci_vmsvga), 1);
+    }
 }
 
 static uint32_t vmsvga_index_read(void *opaque, uint32_t address)
-- 
1.9.1
