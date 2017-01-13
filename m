Received: from eggs.gnu.org ([2001:4830:134:3::10]:44051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1cRzdS-0001Co-Hj
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 06:03:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1cRzdO-0001S0-P5
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 06:03:06 -0500
From: Ladi Prosek <lprosek@redhat.com>
Date: Fri, 13 Jan 2017 12:02:50 +0100
Message-Id: <1484305370-6220-1-git-send-email-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH] ahci: advertise HOST_CAP_64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: jsnow@redhat.com

The AHCI emulation code supports 64-bit addressing and should advertise this
fact in the Host Capabilities register. Both Linux and Windows drivers test
this bit to decide if the upper 32 bits of various registers may be written
to, and at least some versions of Windows have a bug where DMA is attempted
with an address above 4GB but, in the absence of HOST_CAP_64, the upper 32
bits are left unititialized which leads to a memory corruption.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
---
 hw/ide/ahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 3c19bda..6a17acf 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -488,7 +488,7 @@ static void ahci_reg_init(AHCIState *s)
     s->control_regs.cap = (s->ports - 1) |
                           (AHCI_NUM_COMMAND_SLOTS << 8) |
                           (AHCI_SUPPORTED_SPEED_GEN1 << AHCI_SUPPORTED_SPEED) |
-                          HOST_CAP_NCQ | HOST_CAP_AHCI;
+                          HOST_CAP_NCQ | HOST_CAP_AHCI | HOST_CAP_64;
 
     s->control_regs.impl = (1 << s->ports) - 1;
 
-- 
2.7.4
