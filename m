Received: from eggs.gnu.org ([2001:4830:134:3::10]:58732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fanvH-0004op-GP
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 15:58:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fanvG-0001in-Es
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 15:58:43 -0400
Received: from smtp37.i.mail.ru ([94.100.177.97]:45132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1fanvG-0001iB-16
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 15:58:42 -0400
From: Julia Suvorova <jusual@mail.ru>
Date: Wed,  4 Jul 2018 22:58:11 +0300
Message-Id: <20180704195812.28798-2-jusual@mail.ru>
In-Reply-To: <20180704195812.28798-1-jusual@mail.ru>
References: <20180704195812.28798-1-jusual@mail.ru>
Subject: [Qemu-devel] [PATCH 1/2] nvic: Handle ARMv6-M SCS reserved registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <mail@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>

Handle SCS reserved registers listed in ARMv6-M ARM D3.6.1.
All reserved registers are RAZ/WI.

Signed-off-by: Julia Suvorova <jusual@mail.ru>
---
 hw/intc/armv7m_nvic.c | 69 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 57 insertions(+), 12 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index aba4510c70..fb61a1d08d 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -865,6 +865,9 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
         }
         return val;
     case 0xd10: /* System Control.  */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_V7)) {
+            return 0;
+        }
         return cpu->env.v7m.scr[attrs.secure];
     case 0xd14: /* Configuration Control.  */
         /* The BFHFNMIGN bit is the only non-banked bit; we
@@ -986,12 +989,21 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
         }
         return val;
     case 0xd2c: /* Hard Fault Status.  */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_V7)) {
+            return 0;
+        }
         return cpu->env.v7m.hfsr;
     case 0xd30: /* Debug Fault Status.  */
         return cpu->env.v7m.dfsr;
     case 0xd34: /* MMFAR MemManage Fault Address */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_V7)) {
+            return 0;
+        }
         return cpu->env.v7m.mmfar[attrs.secure];
     case 0xd38: /* Bus Fault Address.  */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_V7)) {
+            return 0;
+        }
         return cpu->env.v7m.bfar;
     case 0xd3c: /* Aux Fault Status.  */
         /* TODO: Implement fault status registers.  */
@@ -1292,8 +1304,10 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
          * QEMU's implementation ignores SEVONPEND and SLEEPONEXIT, which
          * is architecturally permitted.
          */
-        value &= ~(R_V7M_SCR_SLEEPDEEP_MASK | R_V7M_SCR_SLEEPDEEPS_MASK);
-        cpu->env.v7m.scr[attrs.secure] = value;
+        if (arm_feature(&cpu->env, ARM_FEATURE_V7)) {
+            value &= ~(R_V7M_SCR_SLEEPDEEP_MASK | R_V7M_SCR_SLEEPDEEPS_MASK);
+            cpu->env.v7m.scr[attrs.secure] = value;
+        }
         break;
     case 0xd14: /* Configuration Control.  */
         /* Enforce RAZ/WI on reserved and must-RAZ/WI bits */
@@ -1388,16 +1402,22 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         nvic_irq_update(s);
         break;
     case 0xd2c: /* Hard Fault Status.  */
-        cpu->env.v7m.hfsr &= ~value; /* W1C */
+        if (arm_feature(&cpu->env, ARM_FEATURE_V7)) {
+            cpu->env.v7m.hfsr &= ~value; /* W1C */
+        }
         break;
     case 0xd30: /* Debug Fault Status.  */
         cpu->env.v7m.dfsr &= ~value; /* W1C */
         break;
     case 0xd34: /* Mem Manage Address.  */
-        cpu->env.v7m.mmfar[attrs.secure] = value;
+        if (arm_feature(&cpu->env, ARM_FEATURE_V7)) {
+            cpu->env.v7m.mmfar[attrs.secure] = value;
+        }
         return;
     case 0xd38: /* Bus Fault Address.  */
-        cpu->env.v7m.bfar = value;
+        if (arm_feature(&cpu->env, ARM_FEATURE_V7)) {
+            cpu->env.v7m.bfar = value;
+        }
         return;
     case 0xd3c: /* Aux Fault Status.  */
         qemu_log_mask(LOG_UNIMP,
@@ -1624,13 +1644,13 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         cpu->env.v7m.sfsr = value;
         break;
     case 0xf00: /* Software Triggered Interrupt Register */
-    {
-        int excnum = (value & 0x1ff) + NVIC_FIRST_IRQ;
-        if (excnum < s->num_irq) {
-            armv7m_nvic_set_pending(s, excnum, false);
+        if (arm_feature(&cpu->env, ARM_FEATURE_V7)) {
+            int excnum  = (value & 0x1ff) + NVIC_FIRST_IRQ;
+            if (excnum < s->num_irq) {
+                armv7m_nvic_set_pending(s, excnum, false);
+            }
         }
         break;
-    }
     case 0xf50: /* ICIALLU */
     case 0xf58: /* ICIMVAU */
     case 0xf5c: /* DCIMVAC */
@@ -1775,7 +1795,13 @@ static MemTxResult nvic_sysreg_read(void *opaque, hwaddr addr,
             }
         }
         break;
-    case 0xd18 ... 0xd23: /* System Handler Priority (SHPR1, SHPR2, SHPR3) */
+    case 0xd18: /* System Handler Priority (SHPR1) */
+        if (!arm_feature(&s->cpu->env, ARM_FEATURE_V7)) {
+            val = 0;
+            break;
+        }
+        /* fall through */
+    case 0xd1c ... 0xd23: /* System Handler Priority (SHPR2, SHPR3) */
         val = 0;
         for (i = 0; i < size; i++) {
             unsigned hdlidx = (offset - 0xd14) + i;
@@ -1791,10 +1817,20 @@ static MemTxResult nvic_sysreg_read(void *opaque, hwaddr addr,
         /* The BFSR bits [15:8] are shared between security states
          * and we store them in the NS copy
          */
+        if (!arm_feature(&s->cpu->env, ARM_FEATURE_V7)) {
+            val = 0;
+            break;
+        };
         val = s->cpu->env.v7m.cfsr[attrs.secure];
         val |= s->cpu->env.v7m.cfsr[M_REG_NS] & R_V7M_CFSR_BFSR_MASK;
         val = extract32(val, (offset - 0xd28) * 8, size * 8);
         break;
+    case 0xd40 ... 0xd7c: /* CPUID registers */
+        if (!arm_feature(&s->cpu->env, ARM_FEATURE_V7)) {
+            val = 0;
+            break;
+        }
+        goto proceed_to_readl;
     case 0xfe0 ... 0xfff: /* ID.  */
         if (offset & 3) {
             val = 0;
@@ -1803,6 +1839,7 @@ static MemTxResult nvic_sysreg_read(void *opaque, hwaddr addr,
         }
         break;
     default:
+    proceed_to_readl:
         if (size == 4) {
             val = nvic_readl(s, offset, attrs);
         } else {
@@ -1882,7 +1919,12 @@ static MemTxResult nvic_sysreg_write(void *opaque, hwaddr addr,
         }
         nvic_irq_update(s);
         return MEMTX_OK;
-    case 0xd18 ... 0xd23: /* System Handler Priority (SHPR1, SHPR2, SHPR3) */
+    case 0xd18: /* System Handler Priority (SHPR1) */
+        if (!arm_feature(&s->cpu->env, ARM_FEATURE_V7)) {
+            return MEMTX_OK;
+        }
+        /* fall through */
+    case 0xd1c ... 0xd23: /* System Handler Priority (SHPR2, SHPR3) */
         for (i = 0; i < size; i++) {
             unsigned hdlidx = (offset - 0xd14) + i;
             int newprio = extract32(value, i * 8, 8);
@@ -1899,6 +1941,9 @@ static MemTxResult nvic_sysreg_write(void *opaque, hwaddr addr,
         /* All bits are W1C, so construct 32 bit value with 0s in
          * the parts not written by the access size
          */
+        if (!arm_feature(&s->cpu->env, ARM_FEATURE_V7)) {
+            return MEMTX_OK;
+        }
         value <<= ((offset - 0xd28) * 8);
 
         s->cpu->env.v7m.cfsr[attrs.secure] &= ~value;
-- 
2.17.1
