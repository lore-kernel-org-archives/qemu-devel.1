Received: from eggs.gnu.org ([2001:4830:134:3::10]:52483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fMMYM-0006NQ-CN
	for qemu-devel@nongnu.org; Fri, 25 May 2018 19:55:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fMMYK-00080E-IO
	for qemu-devel@nongnu.org; Fri, 25 May 2018 19:55:22 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 25 May 2018 19:54:59 -0400
Message-Id: <20180525235509.11282-7-jsnow@redhat.com>
In-Reply-To: <20180525235509.11282-1-jsnow@redhat.com>
References: <20180525235509.11282-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 06/16] ahci: modify ahci_port_write to use
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
 hw/ide/ahci.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index e9ca820d5e..1d93cd6806 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -282,30 +282,32 @@ static int ahci_cond_start_engines(AHCIDevice *ad)
 static void ahci_port_write(AHCIState *s, int port, int offset, uint32_t val)
 {
     AHCIPortRegs *pr = &s->dev[port].port_regs;
+    enum AHCIPortReg regnum = offset / sizeof(uint32_t);
+    assert(regnum < (AHCI_PORT_ADDR_OFFSET_LEN / sizeof(uint32_t)));
 
     trace_ahci_port_write(s, port, offset, val);
-    switch (offset) {
-    case PORT_LST_ADDR:
+    switch (regnum) {
+    case AHCI_PORT_REG_LST_ADDR:
         pr->lst_addr = val;
         break;
-    case PORT_LST_ADDR_HI:
+    case AHCI_PORT_REG_LST_ADDR_HI:
         pr->lst_addr_hi = val;
         break;
-    case PORT_FIS_ADDR:
+    case AHCI_PORT_REG_FIS_ADDR:
         pr->fis_addr = val;
         break;
-    case PORT_FIS_ADDR_HI:
+    case AHCI_PORT_REG_FIS_ADDR_HI:
         pr->fis_addr_hi = val;
         break;
-    case PORT_IRQ_STAT:
+    case AHCI_PORT_REG_IRQ_STAT:
         pr->irq_stat &= ~val;
         ahci_check_irq(s);
         break;
-    case PORT_IRQ_MASK:
+    case AHCI_PORT_REG_IRQ_MASK:
         pr->irq_mask = val & 0xfdc000ff;
         ahci_check_irq(s);
         break;
-    case PORT_CMD:
+    case AHCI_PORT_REG_CMD:
         /* Block any Read-only fields from being set;
          * including LIST_ON and FIS_ON.
          * The spec requires to set ICC bits to zero after the ICC change
@@ -329,26 +331,26 @@ static void ahci_port_write(AHCIState *s, int port, int offset, uint32_t val)
 
         check_cmd(s, port);
         break;
-    case PORT_TFDATA:
-    case PORT_SIG:
-    case PORT_SCR_STAT:
+    case AHCI_PORT_REG_TFDATA:
+    case AHCI_PORT_REG_SIG:
+    case AHCI_PORT_REG_SCR_STAT:
         /* Read Only */
         break;
-    case PORT_SCR_CTL:
+    case AHCI_PORT_REG_SCR_CTL:
         if (((pr->scr_ctl & AHCI_SCR_SCTL_DET) == 1) &&
             ((val & AHCI_SCR_SCTL_DET) == 0)) {
             ahci_reset_port(s, port);
         }
         pr->scr_ctl = val;
         break;
-    case PORT_SCR_ERR:
+    case AHCI_PORT_REG_SCR_ERR:
         pr->scr_err &= ~val;
         break;
-    case PORT_SCR_ACT:
+    case AHCI_PORT_REG_SCR_ACT:
         /* RW1 */
         pr->scr_act |= val;
         break;
-    case PORT_CMD_ISSUE:
+    case AHCI_PORT_REG_CMD_ISSUE:
         pr->cmd_issue |= val;
         check_cmd(s, port);
         break;
-- 
2.14.3
