Received: from eggs.gnu.org ([2001:4830:134:3::10]:52331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdup-0004PG-7j
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:21:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdtg-0006VQ-PL
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:19:35 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fpdtg-0006SH-85
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:18:24 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdtd-00077y-5U
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 19:18:21 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 19:17:33 +0100
Message-Id: <20180814181815.23348-4-peter.maydell@linaro.org>
In-Reply-To: <20180814181815.23348-1-peter.maydell@linaro.org>
References: <20180814181815.23348-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 03/45] arm: Add ARMv6-M programmer's model
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Julia Suvorova <jusual@mail.ru>

Forbid stack alignment change. (CCR)
Reserve FAULTMASK, BASEPRI registers.
Report any fault as a HardFault. Disable MemManage, BusFault and
UsageFault, so they always escalated to HardFault. (SHCSR)

Signed-off-by: Julia Suvorova <jusual@mail.ru>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20180718095628.26442-1-jusual@mail.ru
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/armv7m_nvic.c | 10 ++++++++++
 target/arm/cpu.c      |  4 ++++
 target/arm/helper.c   | 13 +++++++++++--
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 33396ce2854..49e8e2b94d4 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -879,6 +879,9 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
         val |= cpu->env.v7m.ccr[M_REG_NS] & R_V7M_CCR_BFHFNMIGN_MASK;
         return val;
     case 0xd24: /* System Handler Control and State (SHCSR) */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_V7)) {
+            goto bad_offset;
+        }
         val = 0;
         if (attrs.secure) {
             if (s->sec_vectors[ARMV7M_EXCP_MEM].active) {
@@ -1312,6 +1315,10 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         cpu->env.v7m.scr[attrs.secure] = value;
         break;
     case 0xd14: /* Configuration Control.  */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
+            goto bad_offset;
+        }
+
         /* Enforce RAZ/WI on reserved and must-RAZ/WI bits */
         value &= (R_V7M_CCR_STKALIGN_MASK |
                   R_V7M_CCR_BFHFNMIGN_MASK |
@@ -1336,6 +1343,9 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         cpu->env.v7m.ccr[attrs.secure] = value;
         break;
     case 0xd24: /* System Handler Control and State (SHCSR) */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_V7)) {
+            goto bad_offset;
+        }
         if (attrs.secure) {
             s->sec_vectors[ARMV7M_EXCP_MEM].active = (value & (1 << 0)) != 0;
             /* Secure HardFault active bit cannot be written */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 64a8005a4b9..3848ef46aa9 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -231,6 +231,10 @@ static void arm_cpu_reset(CPUState *s)
             env->v7m.ccr[M_REG_NS] |= R_V7M_CCR_NONBASETHRDENA_MASK;
             env->v7m.ccr[M_REG_S] |= R_V7M_CCR_NONBASETHRDENA_MASK;
         }
+        if (!arm_feature(env, ARM_FEATURE_M_MAIN)) {
+            env->v7m.ccr[M_REG_NS] |= R_V7M_CCR_UNALIGN_TRP_MASK;
+            env->v7m.ccr[M_REG_S] |= R_V7M_CCR_UNALIGN_TRP_MASK;
+        }
 
         /* Unlike A/R profile, M profile defines the reset LR value */
         env->regs[14] = 0xffffffff;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index a6d642f4ae5..63a70065617 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10710,13 +10710,13 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
             env->v7m.primask[M_REG_NS] = val & 1;
             return;
         case 0x91: /* BASEPRI_NS */
-            if (!env->v7m.secure) {
+            if (!env->v7m.secure || !arm_feature(env, ARM_FEATURE_M_MAIN)) {
                 return;
             }
             env->v7m.basepri[M_REG_NS] = val & 0xff;
             return;
         case 0x93: /* FAULTMASK_NS */
-            if (!env->v7m.secure) {
+            if (!env->v7m.secure || !arm_feature(env, ARM_FEATURE_M_MAIN)) {
                 return;
             }
             env->v7m.faultmask[M_REG_NS] = val & 1;
@@ -10800,9 +10800,15 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
         env->v7m.primask[env->v7m.secure] = val & 1;
         break;
     case 17: /* BASEPRI */
+        if (!arm_feature(env, ARM_FEATURE_M_MAIN)) {
+            goto bad_reg;
+        }
         env->v7m.basepri[env->v7m.secure] = val & 0xff;
         break;
     case 18: /* BASEPRI_MAX */
+        if (!arm_feature(env, ARM_FEATURE_M_MAIN)) {
+            goto bad_reg;
+        }
         val &= 0xff;
         if (val != 0 && (val < env->v7m.basepri[env->v7m.secure]
                          || env->v7m.basepri[env->v7m.secure] == 0)) {
@@ -10810,6 +10816,9 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
         }
         break;
     case 19: /* FAULTMASK */
+        if (!arm_feature(env, ARM_FEATURE_M_MAIN)) {
+            goto bad_reg;
+        }
         env->v7m.faultmask[env->v7m.secure] = val & 1;
         break;
     case 20: /* CONTROL */
-- 
2.18.0
