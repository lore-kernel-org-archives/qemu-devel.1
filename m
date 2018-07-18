Received: from eggs.gnu.org ([2001:4830:134:3::10]:53980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1ffjCS-0001YU-Pj
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 05:56:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1ffjCP-0004CY-Lh
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 05:56:48 -0400
Received: from smtp61.i.mail.ru ([217.69.128.41]:49376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1ffjCP-0004BM-7b
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 05:56:45 -0400
From: Julia Suvorova <jusual@mail.ru>
Date: Wed, 18 Jul 2018 12:56:28 +0300
Message-Id: <20180718095628.26442-1-jusual@mail.ru>
Subject: [Qemu-devel] [PATCH v2] arm: Add ARMv6-M programmer's model support
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

Forbid stack alignment change. (CCR)
Reserve FAULTMASK, BASEPRI registers.
Report any fault as a HardFault. Disable MemManage, BusFault and
UsageFault, so they always escalated to HardFault. (SHCSR)

Signed-off-by: Julia Suvorova <jusual@mail.ru>
---
v2:
    * Changed CCR reset value

 hw/intc/armv7m_nvic.c | 10 ++++++++++
 target/arm/cpu.c      |  4 ++++
 target/arm/helper.c   | 13 +++++++++++--
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index d344672059..55efae1880 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -885,6 +885,9 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
         val |= cpu->env.v7m.ccr[M_REG_NS] & R_V7M_CCR_BFHFNMIGN_MASK;
         return val;
     case 0xd24: /* System Handler Control and State (SHCSR) */
+        if (!arm_feature(&cpu->env, ARM_FEATURE_V7)) {
+            goto bad_offset;
+        }
         val = 0;
         if (attrs.secure) {
             if (s->sec_vectors[ARMV7M_EXCP_MEM].active) {
@@ -1322,6 +1325,10 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
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
@@ -1346,6 +1353,9 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
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
index a914ce4e8c..661e70c9d5 100644
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
index 2e45dda4e1..fdb481a51d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10670,13 +10670,13 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
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
@@ -10760,9 +10760,15 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
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
@@ -10770,6 +10776,9 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
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
2.17.1
