Received: from eggs.gnu.org ([2001:4830:134:3::10]:43622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1drph7-0003Yu-Lg
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:13:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1drph6-0006Vs-Fq
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:13:57 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Sep 2017 19:14:04 +0100
Message-Id: <1505240046-11454-18-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
References: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 17/19] nvic: Make ICSR banked for v8M
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

The ICSR NVIC register is banked for v8M. This doesn't
require any new state, but it does mean that some bits
are controlled by BFHNFNMINS and some bits must work
with the correct banked exception. There is also a new
in v8M PENDNMICLR bit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/armv7m_nvic.c | 45 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 5e5aecd..21fd199 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -703,7 +703,7 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
     }
     case 0xd00: /* CPUID Base.  */
         return cpu->midr;
-    case 0xd04: /* Interrupt Control State.  */
+    case 0xd04: /* Interrupt Control State (ICSR) */
         /* VECTACTIVE */
         val = cpu->env.v7m.exception;
         /* VECTPENDING */
@@ -716,19 +716,32 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
         if (nvic_rettobase(s)) {
             val |= (1 << 11);
         }
-        /* PENDSTSET */
-        if (s->vectors[ARMV7M_EXCP_SYSTICK].pending) {
-            val |= (1 << 26);
-        }
-        /* PENDSVSET */
-        if (s->vectors[ARMV7M_EXCP_PENDSV].pending) {
-            val |= (1 << 28);
+        if (attrs.secure) {
+            /* PENDSTSET */
+            if (s->sec_vectors[ARMV7M_EXCP_SYSTICK].pending) {
+                val |= (1 << 26);
+            }
+            /* PENDSVSET */
+            if (s->sec_vectors[ARMV7M_EXCP_PENDSV].pending) {
+                val |= (1 << 28);
+            }
+        } else {
+            /* PENDSTSET */
+            if (s->vectors[ARMV7M_EXCP_SYSTICK].pending) {
+                val |= (1 << 26);
+            }
+            /* PENDSVSET */
+            if (s->vectors[ARMV7M_EXCP_PENDSV].pending) {
+                val |= (1 << 28);
+            }
         }
         /* NMIPENDSET */
-        if (s->vectors[ARMV7M_EXCP_NMI].pending) {
+        if ((cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK) &&
+            s->vectors[ARMV7M_EXCP_NMI].pending) {
             val |= (1 << 31);
         }
-        /* ISRPREEMPT not implemented */
+        /* ISRPREEMPT: RES0 when halting debug not implemented */
+        /* STTNS: RES0 for the Main Extension */
         return val;
     case 0xd08: /* Vector Table Offset.  */
         return cpu->env.v7m.vecbase[attrs.secure];
@@ -953,9 +966,15 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         nvic_irq_update(s);
         break;
     }
-    case 0xd04: /* Interrupt Control State.  */
-        if (value & (1 << 31)) {
-            armv7m_nvic_set_pending(s, ARMV7M_EXCP_NMI, false);
+    case 0xd04: /* Interrupt Control State (ICSR) */
+        if (cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK) {
+            if (value & (1 << 31)) {
+                armv7m_nvic_set_pending(s, ARMV7M_EXCP_NMI, false);
+            } else if (value & (1 << 30) &&
+                       arm_feature(&cpu->env, ARM_FEATURE_V8)) {
+                /* PENDNMICLR didn't exist in v7M */
+                armv7m_nvic_clear_pending(s, ARMV7M_EXCP_NMI, false);
+            }
         }
         if (value & (1 << 28)) {
             armv7m_nvic_set_pending(s, ARMV7M_EXCP_PENDSV, attrs.secure);
-- 
2.7.4
