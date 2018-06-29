Received: from eggs.gnu.org ([2001:4830:134:3::10]:38108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fYtUH-0007hZ-Bf
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:30:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fYtUC-0007H2-6E
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:30:57 -0400
From: Luc Michel <luc.michel@greensocs.com>
Date: Fri, 29 Jun 2018 15:29:46 +0200
Message-Id: <20180629132954.24269-13-luc.michel@greensocs.com>
In-Reply-To: <20180629132954.24269-1-luc.michel@greensocs.com>
References: <20180629132954.24269-1-luc.michel@greensocs.com>
Subject: [Qemu-devel] [PATCH v3 12/20] intc/arm_gic: Implement
 virtualization extensions in gic_complete_irq
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@greensocs.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, mark.burton@greensocs.com, Jan Kiszka <jan.kiszka@web.de>

Implement virtualization extensions in the gic_complete_irq() function.
When a guest tries to end an IRQ that does not exist in the LRs, the
EOICount field of the virtual interface HCR register is incremented by
one, and the request is ignored.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
---
 hw/intc/arm_gic.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index a7577ac073..434dc9c7b2 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -605,6 +605,15 @@ static void gic_complete_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
     int group;
 
     DPRINTF("EOI %d\n", irq);
+    if (gic_is_vcpu(cpu) && !gic_virq_is_valid(s, irq, cpu)) {
+        /* This vIRQ does not have a valid LR entry. Increment EOICount and
+         * ignore the write.
+         */
+        int rcpu = gic_get_vcpu_real_id(cpu);
+        s->h_hcr[rcpu] += 1 << R_GICH_HCR_EOICount_SHIFT;
+        return;
+    }
+
     if (irq >= s->num_irq) {
         /* This handles two cases:
          * 1. If software writes the ID of a spurious interrupt [ie 1023]
-- 
2.17.1
