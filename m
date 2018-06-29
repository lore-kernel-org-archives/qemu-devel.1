Received: from eggs.gnu.org ([2001:4830:134:3::10]:38088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fYtUG-0007gf-2d
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:30:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fYtUA-0007CO-Fs
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:30:56 -0400
From: Luc Michel <luc.michel@greensocs.com>
Date: Fri, 29 Jun 2018 15:29:35 +0200
Message-Id: <20180629132954.24269-2-luc.michel@greensocs.com>
In-Reply-To: <20180629132954.24269-1-luc.michel@greensocs.com>
References: <20180629132954.24269-1-luc.michel@greensocs.com>
Subject: [Qemu-devel] [PATCH v3 01/20] intc/arm_gic: Implement write to
 GICD_ISACTIVERn and GICD_ICACTIVERn registers
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

Implement write access to GICD_ISACTIVERn and GICD_ICACTIVERn registers
in the GICv2. Those registers allow to set or clear the active state of
an IRQ in the distributor.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
---
 hw/intc/arm_gic.c | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index ea0323f969..5755a4fb2c 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -982,9 +982,46 @@ static void gic_dist_writeb(void *opaque, hwaddr offset,
                 GIC_CLEAR_PENDING(irq + i, ALL_CPU_MASK);
             }
         }
+    } else if (offset < 0x380) {
+        /* Interrupt Set Active.  */
+        irq = (offset - 0x300) * 8 + GIC_BASE_IRQ;
+        if (irq >= s->num_irq) {
+            goto bad_reg;
+        }
+
+        /* This register is banked per-cpu for PPIs */
+        int cm = irq < GIC_INTERNAL ? (1 << cpu) : ALL_CPU_MASK;
+
+        for (i = 0; i < 8; i++) {
+            if (s->security_extn && !attrs.secure &&
+                !GIC_DIST_TEST_GROUP(irq + i, 1 << cpu)) {
+                continue; /* Ignore Non-secure access of Group0 IRQ */
+            }
+
+            if (value & (1 << i)) {
+                GIC_DIST_SET_ACTIVE(irq + i, cm);
+            }
+        }
     } else if (offset < 0x400) {
-        /* Interrupt Active.  */
-        goto bad_reg;
+        /* Interrupt Clear Active.  */
+        irq = (offset - 0x380) * 8 + GIC_BASE_IRQ;
+        if (irq >= s->num_irq) {
+            goto bad_reg;
+        }
+
+        /* This register is banked per-cpu for PPIs */
+        int cm = irq < GIC_INTERNAL ? (1 << cpu) : ALL_CPU_MASK;
+
+        for (i = 0; i < 8; i++) {
+            if (s->security_extn && !attrs.secure &&
+                !GIC_DIST_TEST_GROUP(irq + i, 1 << cpu)) {
+                continue; /* Ignore Non-secure access of Group0 IRQ */
+            }
+
+            if (value & (1 << i)) {
+                GIC_DIST_CLEAR_ACTIVE(irq + i, cm);
+            }
+        }
     } else if (offset < 0x800) {
         /* Interrupt Priority.  */
         irq = (offset - 0x400) + GIC_BASE_IRQ;
-- 
2.17.1
