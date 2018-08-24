Received: from eggs.gnu.org ([2001:4830:134:3::10]:47832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ftEn6-0007CY-If
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 12:18:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ftEn5-00069d-AK
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 12:18:28 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 17:18:19 +0100
Message-Id: <20180824161819.11085-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] hw/intc/arm_gic: Drop GIC_BASE_IRQ macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

The GIC_BASE_IRQ macro is a leftover from when we shared code
between the GICv2 and the v7M NVIC. Since the NVIC is now
split off, GIC_BASE_IRQ is always 0, and we can just delete it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/gic_internal.h   |  2 --
 hw/intc/arm_gic.c        | 31 ++++++++++++++-----------------
 hw/intc/arm_gic_common.c |  1 -
 3 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/hw/intc/gic_internal.h b/hw/intc/gic_internal.h
index 45c2af0bf59..8d29b40ca10 100644
--- a/hw/intc/gic_internal.h
+++ b/hw/intc/gic_internal.h
@@ -26,8 +26,6 @@
 
 #define ALL_CPU_MASK ((unsigned)(((1 << GIC_NCPU) - 1)))
 
-#define GIC_BASE_IRQ 0
-
 #define GIC_DIST_SET_ENABLED(irq, cm) (s->irq_state[irq].enabled |= (cm))
 #define GIC_DIST_CLEAR_ENABLED(irq, cm) (s->irq_state[irq].enabled &= ~(cm))
 #define GIC_DIST_TEST_ENABLED(irq, cm) ((s->irq_state[irq].enabled & (cm)) != 0)
diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 542b4b93eab..b3ac2d11fc5 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -955,7 +955,7 @@ static uint32_t gic_dist_readb(void *opaque, hwaddr offset, MemTxAttrs attrs)
             res = 0;
             if (!(s->security_extn && !attrs.secure) && gic_has_groups(s)) {
                 /* Every byte offset holds 8 group status bits */
-                irq = (offset - 0x080) * 8 + GIC_BASE_IRQ;
+                irq = (offset - 0x080) * 8;
                 if (irq >= s->num_irq) {
                     goto bad_reg;
                 }
@@ -974,7 +974,6 @@ static uint32_t gic_dist_readb(void *opaque, hwaddr offset, MemTxAttrs attrs)
             irq = (offset - 0x100) * 8;
         else
             irq = (offset - 0x180) * 8;
-        irq += GIC_BASE_IRQ;
         if (irq >= s->num_irq)
             goto bad_reg;
         res = 0;
@@ -994,7 +993,6 @@ static uint32_t gic_dist_readb(void *opaque, hwaddr offset, MemTxAttrs attrs)
             irq = (offset - 0x200) * 8;
         else
             irq = (offset - 0x280) * 8;
-        irq += GIC_BASE_IRQ;
         if (irq >= s->num_irq)
             goto bad_reg;
         res = 0;
@@ -1019,7 +1017,6 @@ static uint32_t gic_dist_readb(void *opaque, hwaddr offset, MemTxAttrs attrs)
             goto bad_reg;
         }
 
-        irq += GIC_BASE_IRQ;
         if (irq >= s->num_irq)
             goto bad_reg;
         res = 0;
@@ -1036,7 +1033,7 @@ static uint32_t gic_dist_readb(void *opaque, hwaddr offset, MemTxAttrs attrs)
         }
     } else if (offset < 0x800) {
         /* Interrupt Priority.  */
-        irq = (offset - 0x400) + GIC_BASE_IRQ;
+        irq = (offset - 0x400);
         if (irq >= s->num_irq)
             goto bad_reg;
         res = gic_dist_get_priority(s, cpu, irq, attrs);
@@ -1046,7 +1043,7 @@ static uint32_t gic_dist_readb(void *opaque, hwaddr offset, MemTxAttrs attrs)
             /* For uniprocessor GICs these RAZ/WI */
             res = 0;
         } else {
-            irq = (offset - 0x800) + GIC_BASE_IRQ;
+            irq = (offset - 0x800);
             if (irq >= s->num_irq) {
                 goto bad_reg;
             }
@@ -1060,7 +1057,7 @@ static uint32_t gic_dist_readb(void *opaque, hwaddr offset, MemTxAttrs attrs)
         }
     } else if (offset < 0xf00) {
         /* Interrupt Configuration.  */
-        irq = (offset - 0xc00) * 4 + GIC_BASE_IRQ;
+        irq = (offset - 0xc00) * 4;
         if (irq >= s->num_irq)
             goto bad_reg;
         res = 0;
@@ -1183,7 +1180,7 @@ static void gic_dist_writeb(void *opaque, hwaddr offset,
              */
             if (!(s->security_extn && !attrs.secure) && gic_has_groups(s)) {
                 /* Every byte offset holds 8 group status bits */
-                irq = (offset - 0x80) * 8 + GIC_BASE_IRQ;
+                irq = (offset - 0x80) * 8;
                 if (irq >= s->num_irq) {
                     goto bad_reg;
                 }
@@ -1204,7 +1201,7 @@ static void gic_dist_writeb(void *opaque, hwaddr offset,
         }
     } else if (offset < 0x180) {
         /* Interrupt Set Enable.  */
-        irq = (offset - 0x100) * 8 + GIC_BASE_IRQ;
+        irq = (offset - 0x100) * 8;
         if (irq >= s->num_irq)
             goto bad_reg;
         if (irq < GIC_NR_SGIS) {
@@ -1239,7 +1236,7 @@ static void gic_dist_writeb(void *opaque, hwaddr offset,
         }
     } else if (offset < 0x200) {
         /* Interrupt Clear Enable.  */
-        irq = (offset - 0x180) * 8 + GIC_BASE_IRQ;
+        irq = (offset - 0x180) * 8;
         if (irq >= s->num_irq)
             goto bad_reg;
         if (irq < GIC_NR_SGIS) {
@@ -1264,7 +1261,7 @@ static void gic_dist_writeb(void *opaque, hwaddr offset,
         }
     } else if (offset < 0x280) {
         /* Interrupt Set Pending.  */
-        irq = (offset - 0x200) * 8 + GIC_BASE_IRQ;
+        irq = (offset - 0x200) * 8;
         if (irq >= s->num_irq)
             goto bad_reg;
         if (irq < GIC_NR_SGIS) {
@@ -1283,7 +1280,7 @@ static void gic_dist_writeb(void *opaque, hwaddr offset,
         }
     } else if (offset < 0x300) {
         /* Interrupt Clear Pending.  */
-        irq = (offset - 0x280) * 8 + GIC_BASE_IRQ;
+        irq = (offset - 0x280) * 8;
         if (irq >= s->num_irq)
             goto bad_reg;
         if (irq < GIC_NR_SGIS) {
@@ -1309,7 +1306,7 @@ static void gic_dist_writeb(void *opaque, hwaddr offset,
             goto bad_reg;
         }
 
-        irq = (offset - 0x300) * 8 + GIC_BASE_IRQ;
+        irq = (offset - 0x300) * 8;
         if (irq >= s->num_irq) {
             goto bad_reg;
         }
@@ -1333,7 +1330,7 @@ static void gic_dist_writeb(void *opaque, hwaddr offset,
             goto bad_reg;
         }
 
-        irq = (offset - 0x380) * 8 + GIC_BASE_IRQ;
+        irq = (offset - 0x380) * 8;
         if (irq >= s->num_irq) {
             goto bad_reg;
         }
@@ -1353,7 +1350,7 @@ static void gic_dist_writeb(void *opaque, hwaddr offset,
         }
     } else if (offset < 0x800) {
         /* Interrupt Priority.  */
-        irq = (offset - 0x400) + GIC_BASE_IRQ;
+        irq = (offset - 0x400);
         if (irq >= s->num_irq)
             goto bad_reg;
         gic_dist_set_priority(s, cpu, irq, value, attrs);
@@ -1362,7 +1359,7 @@ static void gic_dist_writeb(void *opaque, hwaddr offset,
          * annoying exception of the 11MPCore's GIC.
          */
         if (s->num_cpu != 1 || s->revision == REV_11MPCORE) {
-            irq = (offset - 0x800) + GIC_BASE_IRQ;
+            irq = (offset - 0x800);
             if (irq >= s->num_irq) {
                 goto bad_reg;
             }
@@ -1375,7 +1372,7 @@ static void gic_dist_writeb(void *opaque, hwaddr offset,
         }
     } else if (offset < 0xf00) {
         /* Interrupt Configuration.  */
-        irq = (offset - 0xc00) * 4 + GIC_BASE_IRQ;
+        irq = (offset - 0xc00) * 4;
         if (irq >= s->num_irq)
             goto bad_reg;
         if (irq < GIC_NR_SGIS)
diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
index 547dc41185e..57569a4e590 100644
--- a/hw/intc/arm_gic_common.c
+++ b/hw/intc/arm_gic_common.c
@@ -191,7 +191,6 @@ static void arm_gic_common_realize(DeviceState *dev, Error **errp)
                    s->num_cpu, GIC_NCPU);
         return;
     }
-    s->num_irq += GIC_BASE_IRQ;
     if (s->num_irq > GIC_MAXIRQ) {
         error_setg(errp,
                    "requested %u interrupt lines exceeds GIC maximum %d",
-- 
2.18.0
