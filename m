Received: from eggs.gnu.org ([2001:4830:134:3::10]:58261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fizSi-0003ke-8p
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 05:55:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fizSf-0006JN-Mi
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 05:55:04 -0400
From: Luc Michel <luc.michel@greensocs.com>
Date: Fri, 27 Jul 2018 11:54:03 +0200
Message-Id: <20180727095421.386-3-luc.michel@greensocs.com>
In-Reply-To: <20180727095421.386-1-luc.michel@greensocs.com>
References: <20180727095421.386-1-luc.michel@greensocs.com>
Subject: [Qemu-devel] [PATCH v5 02/20] intc/arm_gic: Implement
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

Implement GICD_ISACTIVERn and GICD_ICACTIVERn registers in the GICv2.
Those registers allow to set or clear the active state of an IRQ in the
distributor.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gic.c | 61 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 9286236d86..53b749d216 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -723,12 +723,20 @@ static uint32_t gic_dist_readb(void *opaque, hwaddr offset, MemTxAttrs attrs)
             if (gic_test_pending(s, irq + i, mask)) {
                 res |= (1 << i);
             }
         }
     } else if (offset < 0x400) {
-        /* Interrupt Active.  */
-        irq = (offset - 0x300) * 8 + GIC_BASE_IRQ;
+        /* Interrupt Set/Clear Active.  */
+        if (offset < 0x380) {
+            irq = (offset - 0x300) * 8;
+        } else if (s->revision == 2) {
+            irq = (offset - 0x380) * 8;
+        } else {
+            goto bad_reg;
+        }
+
+        irq += GIC_BASE_IRQ;
         if (irq >= s->num_irq)
             goto bad_reg;
         res = 0;
         mask = (irq < GIC_INTERNAL) ?  cm : ALL_CPU_MASK;
         for (i = 0; i < 8; i++) {
@@ -1005,13 +1013,58 @@ static void gic_dist_writeb(void *opaque, hwaddr offset,
                corect behavior.  */
             if (value & (1 << i)) {
                 GIC_DIST_CLEAR_PENDING(irq + i, ALL_CPU_MASK);
             }
         }
+    } else if (offset < 0x380) {
+        /* Interrupt Set Active.  */
+        if (s->revision != 2) {
+            goto bad_reg;
+        }
+
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
+        if (s->revision != 2) {
+            goto bad_reg;
+        }
+
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
         if (irq >= s->num_irq)
             goto bad_reg;
-- 
2.18.0
