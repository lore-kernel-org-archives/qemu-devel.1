Received: from eggs.gnu.org ([2001:4830:134:3::10]:52545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fMMYN-0006Pq-R5
	for qemu-devel@nongnu.org; Fri, 25 May 2018 19:55:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fMMYL-00082g-K9
	for qemu-devel@nongnu.org; Fri, 25 May 2018 19:55:23 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 25 May 2018 19:55:07 -0400
Message-Id: <20180525235509.11282-15-jsnow@redhat.com>
In-Reply-To: <20180525235509.11282-1-jsnow@redhat.com>
References: <20180525235509.11282-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 14/16] ahci: adjust ahci_mem_write to work on
 registers
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

Actually, this function looks pretty broken, but for now, let's finish
up what this series of commits came here to do.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 9225c4559f..cd834c563e 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -464,11 +464,14 @@ static void ahci_mem_write(void *opaque, hwaddr addr,
     }
 
     if (addr < AHCI_GENERIC_HOST_CONTROL_REGS_MAX_ADDR) {
-        switch (addr) {
-        case HOST_CAP: /* R/WO, RO */
+        enum AHCIHostReg regnum = addr / 4;
+        assert(regnum < AHCI_HOST_REG__COUNT);
+
+        switch (regnum) {
+        case AHCI_HOST_REG_CAP: /* R/WO, RO */
             /* FIXME handle R/WO */
             break;
-        case HOST_CTL: /* R/W */
+        case AHCI_HOST_REG_CTL: /* R/W */
             if (val & HOST_CTL_RESET) {
                 ahci_reset(s);
             } else {
@@ -476,14 +479,14 @@ static void ahci_mem_write(void *opaque, hwaddr addr,
                 ahci_check_irq(s);
             }
             break;
-        case HOST_IRQ_STAT: /* R/WC, RO */
+        case AHCI_HOST_REG_IRQ_STAT: /* R/WC, RO */
             s->control_regs.irqstatus &= ~val;
             ahci_check_irq(s);
             break;
-        case HOST_PORTS_IMPL: /* R/WO, RO */
+        case AHCI_HOST_REG_PORTS_IMPL: /* R/WO, RO */
             /* FIXME handle R/WO */
             break;
-        case HOST_VERSION: /* RO */
+        case AHCI_HOST_REG_VERSION: /* RO */
             /* FIXME report write? */
             break;
         default:
-- 
2.14.3
