Received: from eggs.gnu.org ([2001:4830:134:3::10]:52458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fMMYL-0006Mm-Rp
	for qemu-devel@nongnu.org; Fri, 25 May 2018 19:55:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fMMYJ-0007zM-UJ
	for qemu-devel@nongnu.org; Fri, 25 May 2018 19:55:21 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 25 May 2018 19:54:55 -0400
Message-Id: <20180525235509.11282-3-jsnow@redhat.com>
In-Reply-To: <20180525235509.11282-1-jsnow@redhat.com>
References: <20180525235509.11282-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 02/16] ahci: modify ahci_port_read to use
 register numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 48130c6439..5187bf34ad 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -93,41 +93,42 @@ static const char *AHCIPortIRQ_lookup[AHCI_PORT_IRQ__COUNT] = {
     [AHCI_PORT_IRQ_BIT_CPDS] = "CPDS"
 };
 
-static uint32_t  ahci_port_read(AHCIState *s, int port, int offset)
+static uint32_t ahci_port_read(AHCIState *s, int port, int offset)
 {
     uint32_t val;
-    AHCIPortRegs *pr;
-    pr = &s->dev[port].port_regs;
+    AHCIPortRegs *pr = &s->dev[port].port_regs;
+    enum AHCIPortReg regnum = offset / sizeof(uint32_t);
+    assert(regnum < (AHCI_PORT_ADDR_OFFSET_LEN / sizeof(uint32_t)));
 
-    switch (offset) {
-    case PORT_LST_ADDR:
+    switch (regnum) {
+    case AHCI_PORT_REG_LST_ADDR:
         val = pr->lst_addr;
         break;
-    case PORT_LST_ADDR_HI:
+    case AHCI_PORT_REG_LST_ADDR_HI:
         val = pr->lst_addr_hi;
         break;
-    case PORT_FIS_ADDR:
+    case AHCI_PORT_REG_FIS_ADDR:
         val = pr->fis_addr;
         break;
-    case PORT_FIS_ADDR_HI:
+    case AHCI_PORT_REG_FIS_ADDR_HI:
         val = pr->fis_addr_hi;
         break;
-    case PORT_IRQ_STAT:
+    case AHCI_PORT_REG_IRQ_STAT:
         val = pr->irq_stat;
         break;
-    case PORT_IRQ_MASK:
+    case AHCI_PORT_REG_IRQ_MASK:
         val = pr->irq_mask;
         break;
-    case PORT_CMD:
+    case AHCI_PORT_REG_CMD:
         val = pr->cmd;
         break;
-    case PORT_TFDATA:
+    case AHCI_PORT_REG_TFDATA:
         val = pr->tfdata;
         break;
-    case PORT_SIG:
+    case AHCI_PORT_REG_SIG:
         val = pr->sig;
         break;
-    case PORT_SCR_STAT:
+    case AHCI_PORT_REG_SCR_STAT:
         if (s->dev[port].port.ifs[0].blk) {
             val = SATA_SCR_SSTATUS_DET_DEV_PRESENT_PHY_UP |
                   SATA_SCR_SSTATUS_SPD_GEN1 | SATA_SCR_SSTATUS_IPM_ACTIVE;
@@ -135,19 +136,18 @@ static uint32_t  ahci_port_read(AHCIState *s, int port, int offset)
             val = SATA_SCR_SSTATUS_DET_NODEV;
         }
         break;
-    case PORT_SCR_CTL:
+    case AHCI_PORT_REG_SCR_CTL:
         val = pr->scr_ctl;
         break;
-    case PORT_SCR_ERR:
+    case AHCI_PORT_REG_SCR_ERR:
         val = pr->scr_err;
         break;
-    case PORT_SCR_ACT:
+    case AHCI_PORT_REG_SCR_ACT:
         val = pr->scr_act;
         break;
-    case PORT_CMD_ISSUE:
+    case AHCI_PORT_REG_CMD_ISSUE:
         val = pr->cmd_issue;
         break;
-    case PORT_RESERVED:
     default:
         val = 0;
     }
-- 
2.14.3
