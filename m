Received: from eggs.gnu.org ([2001:4830:134:3::10]:56327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwqx-0000zP-Tr
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwqs-0007aK-Rx
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:19 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dpwqs-0007Xf-JK
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:14 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwqr-0001az-6v
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:28:13 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  7 Sep 2017 14:28:07 +0100
Message-Id: <1504790904-17018-15-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504790904-17018-1-git-send-email-peter.maydell@linaro.org>
References: <1504790904-17018-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 14/31] target/arm: Make PRIMASK register banked
 for v8M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Make the PRIMASK register banked if v8M security extensions are enabled.

Note that we do not yet implement the functionality of the new
AIRCR.PRIS bit (which allows the effect of the NS copy of PRIMASK to
be restricted).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1503414539-28762-8-git-send-email-peter.maydell@linaro.org
---
 target/arm/cpu.h      | 2 +-
 hw/intc/armv7m_nvic.c | 2 +-
 target/arm/helper.c   | 4 ++--
 target/arm/machine.c  | 9 +++++++--
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 273abc3..26ec744 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -431,7 +431,7 @@ typedef struct CPUARMState {
         uint32_t bfar; /* BusFault Address */
         unsigned mpu_ctrl; /* MPU_CTRL */
         int exception;
-        uint32_t primask;
+        uint32_t primask[2];
         uint32_t faultmask;
         uint32_t secure; /* Is CPU in Secure state? (not guest visible) */
     } v7m;
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 2a41e5d..a654792 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -169,7 +169,7 @@ static inline int nvic_exec_prio(NVICState *s)
 
     if (env->v7m.faultmask) {
         running = -1;
-    } else if (env->v7m.primask) {
+    } else if (env->v7m.primask[env->v7m.secure]) {
         running = 0;
     } else if (env->v7m.basepri[env->v7m.secure] > 0) {
         running = env->v7m.basepri[env->v7m.secure] & nvic_gprio_mask(s);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7007266..9a7ab96 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8830,7 +8830,7 @@ uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
         return (env->v7m.control & R_V7M_CONTROL_SPSEL_MASK) ?
             env->regs[13] : env->v7m.other_sp;
     case 16: /* PRIMASK */
-        return env->v7m.primask;
+        return env->v7m.primask[env->v7m.secure];
     case 17: /* BASEPRI */
     case 18: /* BASEPRI_MAX */
         return env->v7m.basepri[env->v7m.secure];
@@ -8890,7 +8890,7 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
         }
         break;
     case 16: /* PRIMASK */
-        env->v7m.primask = val & 1;
+        env->v7m.primask[env->v7m.secure] = val & 1;
         break;
     case 17: /* BASEPRI */
         env->v7m.basepri[env->v7m.secure] = val & 0xff;
diff --git a/target/arm/machine.c b/target/arm/machine.c
index dbb432d..3c42bf5 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -103,7 +103,7 @@ static const VMStateDescription vmstate_m_faultmask_primask = {
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(env.v7m.faultmask, ARMCPU),
-        VMSTATE_UINT32(env.v7m.primask, ARMCPU),
+        VMSTATE_UINT32(env.v7m.primask[M_REG_NS], ARMCPU),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -251,6 +251,7 @@ static const VMStateDescription vmstate_m_security = {
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(env.v7m.secure, ARMCPU),
         VMSTATE_UINT32(env.v7m.basepri[M_REG_S], ARMCPU),
+        VMSTATE_UINT32(env.v7m.primask[M_REG_S], ARMCPU),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -271,9 +272,13 @@ static int get_cpsr(QEMUFile *f, void *opaque, size_t size,
              * differences are that the T bit is not in the same place, the
              * primask/faultmask info may be in the CPSR I and F bits, and
              * we do not want the mode bits.
+             * We know that this cleanup happened before v8M, so there
+             * is no complication with banked primask/faultmask.
              */
             uint32_t newval = val;
 
+            assert(!arm_feature(env, ARM_FEATURE_M_SECURITY));
+
             newval &= (CPSR_NZCV | CPSR_Q | CPSR_IT | CPSR_GE);
             if (val & CPSR_T) {
                 newval |= XPSR_T;
@@ -287,7 +292,7 @@ static int get_cpsr(QEMUFile *f, void *opaque, size_t size,
                 env->v7m.faultmask = 1;
             }
             if (val & CPSR_I) {
-                env->v7m.primask = 1;
+                env->v7m.primask[M_REG_NS] = 1;
             }
             val = newval;
         }
-- 
2.7.4
