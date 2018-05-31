Received: from eggs.gnu.org ([2001:4830:134:3::10]:34378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOW3r-0000lR-Gp
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:28:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOW3p-00046S-VP
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:28:47 -0400
From: John Snow <jsnow@redhat.com>
Date: Thu, 31 May 2018 18:28:23 -0400
Message-Id: <20180531222835.16558-5-jsnow@redhat.com>
In-Reply-To: <20180531222835.16558-1-jsnow@redhat.com>
References: <20180531222835.16558-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 04/16] ahci: fix spacing damage on
 ahci_port_write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: f4bug@amsat.org, John Snow <jsnow@redhat.com>

Churn.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c | 142 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 71 insertions(+), 71 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 5b5ab823f4..92780990a3 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -279,85 +279,85 @@ static int ahci_cond_start_engines(AHCIDevice *ad)
     return 0;
 }
 
-static void  ahci_port_write(AHCIState *s, int port, int offset, uint32_t val)
+static void ahci_port_write(AHCIState *s, int port, int offset, uint32_t val)
 {
     AHCIPortRegs *pr = &s->dev[port].port_regs;
 
     trace_ahci_port_write(s, port, offset, val);
     switch (offset) {
-        case PORT_LST_ADDR:
-            pr->lst_addr = val;
-            break;
-        case PORT_LST_ADDR_HI:
-            pr->lst_addr_hi = val;
-            break;
-        case PORT_FIS_ADDR:
-            pr->fis_addr = val;
-            break;
-        case PORT_FIS_ADDR_HI:
-            pr->fis_addr_hi = val;
-            break;
-        case PORT_IRQ_STAT:
-            pr->irq_stat &= ~val;
-            ahci_check_irq(s);
-            break;
-        case PORT_IRQ_MASK:
-            pr->irq_mask = val & 0xfdc000ff;
-            ahci_check_irq(s);
-            break;
-        case PORT_CMD:
-            /* Block any Read-only fields from being set;
-             * including LIST_ON and FIS_ON.
-             * The spec requires to set ICC bits to zero after the ICC change
-             * is done. We don't support ICC state changes, therefore always
-             * force the ICC bits to zero.
-             */
-            pr->cmd = (pr->cmd & PORT_CMD_RO_MASK) |
-                      (val & ~(PORT_CMD_RO_MASK|PORT_CMD_ICC_MASK));
+    case PORT_LST_ADDR:
+        pr->lst_addr = val;
+        break;
+    case PORT_LST_ADDR_HI:
+        pr->lst_addr_hi = val;
+        break;
+    case PORT_FIS_ADDR:
+        pr->fis_addr = val;
+        break;
+    case PORT_FIS_ADDR_HI:
+        pr->fis_addr_hi = val;
+        break;
+    case PORT_IRQ_STAT:
+        pr->irq_stat &= ~val;
+        ahci_check_irq(s);
+        break;
+    case PORT_IRQ_MASK:
+        pr->irq_mask = val & 0xfdc000ff;
+        ahci_check_irq(s);
+        break;
+    case PORT_CMD:
+        /* Block any Read-only fields from being set;
+         * including LIST_ON and FIS_ON.
+         * The spec requires to set ICC bits to zero after the ICC change
+         * is done. We don't support ICC state changes, therefore always
+         * force the ICC bits to zero.
+         */
+        pr->cmd = (pr->cmd & PORT_CMD_RO_MASK) |
+            (val & ~(PORT_CMD_RO_MASK|PORT_CMD_ICC_MASK));
 
-            /* Check FIS RX and CLB engines */
-            ahci_cond_start_engines(&s->dev[port]);
+        /* Check FIS RX and CLB engines */
+        ahci_cond_start_engines(&s->dev[port]);
 
-            /* XXX usually the FIS would be pending on the bus here and
-                   issuing deferred until the OS enables FIS receival.
-                   Instead, we only submit it once - which works in most
-                   cases, but is a hack. */
-            if ((pr->cmd & PORT_CMD_FIS_ON) &&
-                !s->dev[port].init_d2h_sent) {
-                ahci_init_d2h(&s->dev[port]);
-            }
+        /* XXX usually the FIS would be pending on the bus here and
+           issuing deferred until the OS enables FIS receival.
+           Instead, we only submit it once - which works in most
+           cases, but is a hack. */
+        if ((pr->cmd & PORT_CMD_FIS_ON) &&
+            !s->dev[port].init_d2h_sent) {
+            ahci_init_d2h(&s->dev[port]);
+        }
 
-            check_cmd(s, port);
-            break;
-        case PORT_TFDATA:
-            /* Read Only. */
-            break;
-        case PORT_SIG:
-            /* Read Only */
-            break;
-        case PORT_SCR_STAT:
-            /* Read Only */
-            break;
-        case PORT_SCR_CTL:
-            if (((pr->scr_ctl & AHCI_SCR_SCTL_DET) == 1) &&
-                ((val & AHCI_SCR_SCTL_DET) == 0)) {
-                ahci_reset_port(s, port);
-            }
-            pr->scr_ctl = val;
-            break;
-        case PORT_SCR_ERR:
-            pr->scr_err &= ~val;
-            break;
-        case PORT_SCR_ACT:
-            /* RW1 */
-            pr->scr_act |= val;
-            break;
-        case PORT_CMD_ISSUE:
-            pr->cmd_issue |= val;
-            check_cmd(s, port);
-            break;
-        default:
-            break;
+        check_cmd(s, port);
+        break;
+    case PORT_TFDATA:
+        /* Read Only. */
+        break;
+    case PORT_SIG:
+        /* Read Only */
+        break;
+    case PORT_SCR_STAT:
+        /* Read Only */
+        break;
+    case PORT_SCR_CTL:
+        if (((pr->scr_ctl & AHCI_SCR_SCTL_DET) == 1) &&
+            ((val & AHCI_SCR_SCTL_DET) == 0)) {
+            ahci_reset_port(s, port);
+        }
+        pr->scr_ctl = val;
+        break;
+    case PORT_SCR_ERR:
+        pr->scr_err &= ~val;
+        break;
+    case PORT_SCR_ACT:
+        /* RW1 */
+        pr->scr_act |= val;
+        break;
+    case PORT_CMD_ISSUE:
+        pr->cmd_issue |= val;
+        check_cmd(s, port);
+        break;
+    default:
+        break;
     }
 }
 
-- 
2.14.3
