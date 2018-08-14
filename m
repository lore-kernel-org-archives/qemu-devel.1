Received: from eggs.gnu.org ([2001:4830:134:3::10]:52552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdvG-0004iy-US
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:21:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdtv-0006eZ-T6
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:20:02 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fpdtv-0006ag-7g
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:18:39 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdtp-0007Cl-6O
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 19:18:33 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 19:17:43 +0100
Message-Id: <20180814181815.23348-14-peter.maydell@linaro.org>
In-Reply-To: <20180814181815.23348-1-peter.maydell@linaro.org>
References: <20180814181815.23348-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 13/45] intc/arm_gic: Implement GICD_ISACTIVERn
 and GICD_ICACTIVERn registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Luc Michel <luc.michel@greensocs.com>

Implement GICD_ISACTIVERn and GICD_ICACTIVERn registers in the GICv2.
Those registers allow to set or clear the active state of an IRQ in the
distributor.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180727095421.386-3-luc.michel@greensocs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gic.c | 61 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 9286236d86b..53b749d2167 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -725,8 +725,16 @@ static uint32_t gic_dist_readb(void *opaque, hwaddr offset, MemTxAttrs attrs)
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
@@ -1007,9 +1015,54 @@ static void gic_dist_writeb(void *opaque, hwaddr offset,
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
-- 
2.18.0
