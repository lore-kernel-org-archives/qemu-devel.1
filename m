Received: from eggs.gnu.org ([2001:4830:134:3::10]:60320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XQ-00038S-0f
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XM-00032r-FI
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:20 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dv4XM-0002yR-2A
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:41:16 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dv4XK-00059b-SD
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 17:41:14 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Sep 2017 17:41:26 +0100
Message-Id: <1506012099-13605-19-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1506012099-13605-1-git-send-email-peter.maydell@linaro.org>
References: <1506012099-13605-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 18/31] nvic: Make SHCSR banked for v8M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Handle banking of SHCSR: some register bits are banked between
Secure and Non-Secure, and some are only accessible to Secure.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1505240046-11454-19-git-send-email-peter.maydell@linaro.org
---
 hw/intc/armv7m_nvic.c | 221 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 169 insertions(+), 52 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 284521f..19b0be1 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -770,50 +770,117 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
         val = cpu->env.v7m.ccr[attrs.secure];
         val |= cpu->env.v7m.ccr[M_REG_NS] & R_V7M_CCR_BFHFNMIGN_MASK;
         return val;
-    case 0xd24: /* System Handler Status.  */
+    case 0xd24: /* System Handler Control and State (SHCSR) */
         val = 0;
-        if (s->vectors[ARMV7M_EXCP_MEM].active) {
-            val |= (1 << 0);
-        }
-        if (s->vectors[ARMV7M_EXCP_BUS].active) {
-            val |= (1 << 1);
-        }
-        if (s->vectors[ARMV7M_EXCP_USAGE].active) {
-            val |= (1 << 3);
+        if (attrs.secure) {
+            if (s->sec_vectors[ARMV7M_EXCP_MEM].active) {
+                val |= (1 << 0);
+            }
+            if (s->sec_vectors[ARMV7M_EXCP_HARD].active) {
+                val |= (1 << 2);
+            }
+            if (s->sec_vectors[ARMV7M_EXCP_USAGE].active) {
+                val |= (1 << 3);
+            }
+            if (s->sec_vectors[ARMV7M_EXCP_SVC].active) {
+                val |= (1 << 7);
+            }
+            if (s->sec_vectors[ARMV7M_EXCP_PENDSV].active) {
+                val |= (1 << 10);
+            }
+            if (s->sec_vectors[ARMV7M_EXCP_SYSTICK].active) {
+                val |= (1 << 11);
+            }
+            if (s->sec_vectors[ARMV7M_EXCP_USAGE].pending) {
+                val |= (1 << 12);
+            }
+            if (s->sec_vectors[ARMV7M_EXCP_MEM].pending) {
+                val |= (1 << 13);
+            }
+            if (s->sec_vectors[ARMV7M_EXCP_SVC].pending) {
+                val |= (1 << 15);
+            }
+            if (s->sec_vectors[ARMV7M_EXCP_MEM].enabled) {
+                val |= (1 << 16);
+            }
+            if (s->sec_vectors[ARMV7M_EXCP_USAGE].enabled) {
+                val |= (1 << 18);
+            }
+            if (s->sec_vectors[ARMV7M_EXCP_HARD].pending) {
+                val |= (1 << 21);
+            }
+            /* SecureFault is not banked but is always RAZ/WI to NS */
+            if (s->vectors[ARMV7M_EXCP_SECURE].active) {
+                val |= (1 << 4);
+            }
+            if (s->vectors[ARMV7M_EXCP_SECURE].enabled) {
+                val |= (1 << 19);
+            }
+            if (s->vectors[ARMV7M_EXCP_SECURE].pending) {
+                val |= (1 << 20);
+            }
+        } else {
+            if (s->vectors[ARMV7M_EXCP_MEM].active) {
+                val |= (1 << 0);
+            }
+            if (arm_feature(&cpu->env, ARM_FEATURE_V8)) {
+                /* HARDFAULTACT, HARDFAULTPENDED not present in v7M */
+                if (s->vectors[ARMV7M_EXCP_HARD].active) {
+                    val |= (1 << 2);
+                }
+                if (s->vectors[ARMV7M_EXCP_HARD].pending) {
+                    val |= (1 << 21);
+                }
+            }
+            if (s->vectors[ARMV7M_EXCP_USAGE].active) {
+                val |= (1 << 3);
+            }
+            if (s->vectors[ARMV7M_EXCP_SVC].active) {
+                val |= (1 << 7);
+            }
+            if (s->vectors[ARMV7M_EXCP_PENDSV].active) {
+                val |= (1 << 10);
+            }
+            if (s->vectors[ARMV7M_EXCP_SYSTICK].active) {
+                val |= (1 << 11);
+            }
+            if (s->vectors[ARMV7M_EXCP_USAGE].pending) {
+                val |= (1 << 12);
+            }
+            if (s->vectors[ARMV7M_EXCP_MEM].pending) {
+                val |= (1 << 13);
+            }
+            if (s->vectors[ARMV7M_EXCP_SVC].pending) {
+                val |= (1 << 15);
+            }
+            if (s->vectors[ARMV7M_EXCP_MEM].enabled) {
+                val |= (1 << 16);
+            }
+            if (s->vectors[ARMV7M_EXCP_USAGE].enabled) {
+                val |= (1 << 18);
+            }
         }
-        if (s->vectors[ARMV7M_EXCP_SVC].active) {
-            val |= (1 << 7);
+        if (attrs.secure || (cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK)) {
+            if (s->vectors[ARMV7M_EXCP_BUS].active) {
+                val |= (1 << 1);
+            }
+            if (s->vectors[ARMV7M_EXCP_BUS].pending) {
+                val |= (1 << 14);
+            }
+            if (s->vectors[ARMV7M_EXCP_BUS].enabled) {
+                val |= (1 << 17);
+            }
+            if (arm_feature(&cpu->env, ARM_FEATURE_V8) &&
+                s->vectors[ARMV7M_EXCP_NMI].active) {
+                /* NMIACT is not present in v7M */
+                val |= (1 << 5);
+            }
         }
+
+        /* TODO: this is RAZ/WI from NS if DEMCR.SDME is set */
         if (s->vectors[ARMV7M_EXCP_DEBUG].active) {
             val |= (1 << 8);
         }
-        if (s->vectors[ARMV7M_EXCP_PENDSV].active) {
-            val |= (1 << 10);
-        }
-        if (s->vectors[ARMV7M_EXCP_SYSTICK].active) {
-            val |= (1 << 11);
-        }
-        if (s->vectors[ARMV7M_EXCP_USAGE].pending) {
-            val |= (1 << 12);
-        }
-        if (s->vectors[ARMV7M_EXCP_MEM].pending) {
-            val |= (1 << 13);
-        }
-        if (s->vectors[ARMV7M_EXCP_BUS].pending) {
-            val |= (1 << 14);
-        }
-        if (s->vectors[ARMV7M_EXCP_SVC].pending) {
-            val |= (1 << 15);
-        }
-        if (s->vectors[ARMV7M_EXCP_MEM].enabled) {
-            val |= (1 << 16);
-        }
-        if (s->vectors[ARMV7M_EXCP_BUS].enabled) {
-            val |= (1 << 17);
-        }
-        if (s->vectors[ARMV7M_EXCP_USAGE].enabled) {
-            val |= (1 << 18);
-        }
         return val;
     case 0xd28: /* Configurable Fault Status.  */
         /* The BFSR bits [15:8] are shared between security states
@@ -1061,21 +1128,71 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
 
         cpu->env.v7m.ccr[attrs.secure] = value;
         break;
-    case 0xd24: /* System Handler Control.  */
-        s->vectors[ARMV7M_EXCP_MEM].active = (value & (1 << 0)) != 0;
-        s->vectors[ARMV7M_EXCP_BUS].active = (value & (1 << 1)) != 0;
-        s->vectors[ARMV7M_EXCP_USAGE].active = (value & (1 << 3)) != 0;
-        s->vectors[ARMV7M_EXCP_SVC].active = (value & (1 << 7)) != 0;
+    case 0xd24: /* System Handler Control and State (SHCSR) */
+        if (attrs.secure) {
+            s->sec_vectors[ARMV7M_EXCP_MEM].active = (value & (1 << 0)) != 0;
+            /* Secure HardFault active bit cannot be written */
+            s->sec_vectors[ARMV7M_EXCP_USAGE].active = (value & (1 << 3)) != 0;
+            s->sec_vectors[ARMV7M_EXCP_SVC].active = (value & (1 << 7)) != 0;
+            s->sec_vectors[ARMV7M_EXCP_PENDSV].active =
+                (value & (1 << 10)) != 0;
+            s->sec_vectors[ARMV7M_EXCP_SYSTICK].active =
+                (value & (1 << 11)) != 0;
+            s->sec_vectors[ARMV7M_EXCP_USAGE].pending =
+                (value & (1 << 12)) != 0;
+            s->sec_vectors[ARMV7M_EXCP_MEM].pending = (value & (1 << 13)) != 0;
+            s->sec_vectors[ARMV7M_EXCP_SVC].pending = (value & (1 << 15)) != 0;
+            s->sec_vectors[ARMV7M_EXCP_MEM].enabled = (value & (1 << 16)) != 0;
+            s->sec_vectors[ARMV7M_EXCP_BUS].enabled = (value & (1 << 17)) != 0;
+            s->sec_vectors[ARMV7M_EXCP_USAGE].enabled =
+                (value & (1 << 18)) != 0;
+            /* SecureFault not banked, but RAZ/WI to NS */
+            s->vectors[ARMV7M_EXCP_SECURE].active = (value & (1 << 4)) != 0;
+            s->vectors[ARMV7M_EXCP_SECURE].enabled = (value & (1 << 19)) != 0;
+            s->vectors[ARMV7M_EXCP_SECURE].pending = (value & (1 << 20)) != 0;
+        } else {
+            s->vectors[ARMV7M_EXCP_MEM].active = (value & (1 << 0)) != 0;
+            if (arm_feature(&cpu->env, ARM_FEATURE_V8)) {
+                /* HARDFAULTPENDED is not present in v7M */
+                s->vectors[ARMV7M_EXCP_HARD].pending = (value & (1 << 21)) != 0;
+            }
+            s->vectors[ARMV7M_EXCP_USAGE].active = (value & (1 << 3)) != 0;
+            s->vectors[ARMV7M_EXCP_SVC].active = (value & (1 << 7)) != 0;
+            s->vectors[ARMV7M_EXCP_PENDSV].active = (value & (1 << 10)) != 0;
+            s->vectors[ARMV7M_EXCP_SYSTICK].active = (value & (1 << 11)) != 0;
+            s->vectors[ARMV7M_EXCP_USAGE].pending = (value & (1 << 12)) != 0;
+            s->vectors[ARMV7M_EXCP_MEM].pending = (value & (1 << 13)) != 0;
+            s->vectors[ARMV7M_EXCP_SVC].pending = (value & (1 << 15)) != 0;
+            s->vectors[ARMV7M_EXCP_MEM].enabled = (value & (1 << 16)) != 0;
+            s->vectors[ARMV7M_EXCP_USAGE].enabled = (value & (1 << 18)) != 0;
+        }
+        if (attrs.secure || (cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK)) {
+            s->vectors[ARMV7M_EXCP_BUS].active = (value & (1 << 1)) != 0;
+            s->vectors[ARMV7M_EXCP_BUS].pending = (value & (1 << 14)) != 0;
+            s->vectors[ARMV7M_EXCP_BUS].enabled = (value & (1 << 17)) != 0;
+        }
+        /* NMIACT can only be written if the write is of a zero, with
+         * BFHFNMINS 1, and by the CPU in secure state via the NS alias.
+         */
+        if (!attrs.secure && cpu->env.v7m.secure &&
+            (cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK) &&
+            (value & (1 << 5)) == 0) {
+            s->vectors[ARMV7M_EXCP_NMI].active = 0;
+        }
+        /* HARDFAULTACT can only be written if the write is of a zero
+         * to the non-secure HardFault state by the CPU in secure state.
+         * The only case where we can be targeting the non-secure HF state
+         * when in secure state is if this is a write via the NS alias
+         * and BFHFNMINS is 1.
+         */
+        if (!attrs.secure && cpu->env.v7m.secure &&
+            (cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK) &&
+            (value & (1 << 2)) == 0) {
+            s->vectors[ARMV7M_EXCP_HARD].active = 0;
+        }
+
+        /* TODO: this is RAZ/WI from NS if DEMCR.SDME is set */
         s->vectors[ARMV7M_EXCP_DEBUG].active = (value & (1 << 8)) != 0;
-        s->vectors[ARMV7M_EXCP_PENDSV].active = (value & (1 << 10)) != 0;
-        s->vectors[ARMV7M_EXCP_SYSTICK].active = (value & (1 << 11)) != 0;
-        s->vectors[ARMV7M_EXCP_USAGE].pending = (value & (1 << 12)) != 0;
-        s->vectors[ARMV7M_EXCP_MEM].pending = (value & (1 << 13)) != 0;
-        s->vectors[ARMV7M_EXCP_BUS].pending = (value & (1 << 14)) != 0;
-        s->vectors[ARMV7M_EXCP_SVC].pending = (value & (1 << 15)) != 0;
-        s->vectors[ARMV7M_EXCP_MEM].enabled = (value & (1 << 16)) != 0;
-        s->vectors[ARMV7M_EXCP_BUS].enabled = (value & (1 << 17)) != 0;
-        s->vectors[ARMV7M_EXCP_USAGE].enabled = (value & (1 << 18)) != 0;
         nvic_irq_update(s);
         break;
     case 0xd28: /* Configurable Fault Status.  */
-- 
2.7.4
