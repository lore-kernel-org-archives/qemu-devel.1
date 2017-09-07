Received: from eggs.gnu.org ([2001:4830:134:3::10]:56595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwrB-00016c-NS
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwr0-0007g2-6s
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:33 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dpwqz-0007fH-S2
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:22 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwqy-0001gW-SN
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:28:20 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  7 Sep 2017 14:28:18 +0100
Message-Id: <1504790904-17018-26-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504790904-17018-1-git-send-email-peter.maydell@linaro.org>
References: <1504790904-17018-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 25/31] target/arm: Make CFSR register banked for
 v8M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Make the CFSR register banked if v8M security extensions are enabled.

Not all the bits in this register are banked: the BFSR
bits [15:8] are shared between S and NS, and we store them
in the NS copy of the register.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1503414539-28762-19-git-send-email-peter.maydell@linaro.org
---
 target/arm/cpu.h      |  7 ++++++-
 hw/intc/armv7m_nvic.c | 15 +++++++++++++--
 target/arm/helper.c   | 18 +++++++++---------
 target/arm/machine.c  |  3 ++-
 4 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 03a47de..41e270c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -424,7 +424,7 @@ typedef struct CPUARMState {
         uint32_t basepri[2];
         uint32_t control[2];
         uint32_t ccr[2]; /* Configuration and Control */
-        uint32_t cfsr; /* Configurable Fault Status */
+        uint32_t cfsr[2]; /* Configurable Fault Status */
         uint32_t hfsr; /* HardFault Status */
         uint32_t dfsr; /* Debug Fault Status Register */
         uint32_t mmfar[2]; /* MemManage Fault Address */
@@ -1209,6 +1209,11 @@ FIELD(V7M_CFSR, NOCP, 16 + 3, 1)
 FIELD(V7M_CFSR, UNALIGNED, 16 + 8, 1)
 FIELD(V7M_CFSR, DIVBYZERO, 16 + 9, 1)
 
+/* V7M CFSR bit masks covering all of the subregister bits */
+FIELD(V7M_CFSR, MMFSR, 0, 8)
+FIELD(V7M_CFSR, BFSR, 8, 8)
+FIELD(V7M_CFSR, UFSR, 16, 16)
+
 /* V7M HFSR bits */
 FIELD(V7M_HFSR, VECTTBL, 1, 1)
 FIELD(V7M_HFSR, FORCED, 30, 1)
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index dd0710a..1fecfd6 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -500,7 +500,12 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
         }
         return val;
     case 0xd28: /* Configurable Fault Status.  */
-        return cpu->env.v7m.cfsr;
+        /* The BFSR bits [15:8] are shared between security states
+         * and we store them in the NS copy
+         */
+        val = cpu->env.v7m.cfsr[attrs.secure];
+        val |= cpu->env.v7m.cfsr[M_REG_NS] & R_V7M_CFSR_BFSR_MASK;
+        return val;
     case 0xd2c: /* Hard Fault Status.  */
         return cpu->env.v7m.hfsr;
     case 0xd30: /* Debug Fault Status.  */
@@ -711,7 +716,13 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         nvic_irq_update(s);
         break;
     case 0xd28: /* Configurable Fault Status.  */
-        cpu->env.v7m.cfsr &= ~value; /* W1C */
+        cpu->env.v7m.cfsr[attrs.secure] &= ~value; /* W1C */
+        if (attrs.secure) {
+            /* The BFSR bits [15:8] are shared between security states
+             * and we store them in the NS copy.
+             */
+            cpu->env.v7m.cfsr[M_REG_NS] &= ~(value & R_V7M_CFSR_BFSR_MASK);
+        }
         break;
     case 0xd2c: /* Hard Fault Status.  */
         cpu->env.v7m.hfsr &= ~value; /* W1C */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index cd95474..1c47f71 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6224,7 +6224,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
         /* Bad exception return: instead of popping the exception
          * stack, directly take a usage fault on the current stack.
          */
-        env->v7m.cfsr |= R_V7M_CFSR_INVPC_MASK;
+        env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_INVPC_MASK;
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE);
         v7m_exception_taken(cpu, type | 0xf0000000);
         qemu_log_mask(CPU_LOG_INT, "...taking UsageFault on existing "
@@ -6266,7 +6266,7 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
     if (return_to_handler != arm_v7m_is_handler_mode(env)) {
         /* Take an INVPC UsageFault by pushing the stack again. */
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE);
-        env->v7m.cfsr |= R_V7M_CFSR_INVPC_MASK;
+        env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_INVPC_MASK;
         v7m_push_stack(cpu);
         v7m_exception_taken(cpu, type | 0xf0000000);
         qemu_log_mask(CPU_LOG_INT, "...taking UsageFault on new stackframe: "
@@ -6325,15 +6325,15 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
     switch (cs->exception_index) {
     case EXCP_UDEF:
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE);
-        env->v7m.cfsr |= R_V7M_CFSR_UNDEFINSTR_MASK;
+        env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_UNDEFINSTR_MASK;
         break;
     case EXCP_NOCP:
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE);
-        env->v7m.cfsr |= R_V7M_CFSR_NOCP_MASK;
+        env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_NOCP_MASK;
         break;
     case EXCP_INVSTATE:
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE);
-        env->v7m.cfsr |= R_V7M_CFSR_INVSTATE_MASK;
+        env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_INVSTATE_MASK;
         break;
     case EXCP_SWI:
         /* The PC already points to the next instruction.  */
@@ -6349,11 +6349,11 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
         case 0x8: /* External Abort */
             switch (cs->exception_index) {
             case EXCP_PREFETCH_ABORT:
-                env->v7m.cfsr |= R_V7M_CFSR_PRECISERR_MASK;
+                env->v7m.cfsr[M_REG_NS] |= R_V7M_CFSR_PRECISERR_MASK;
                 qemu_log_mask(CPU_LOG_INT, "...with CFSR.PRECISERR\n");
                 break;
             case EXCP_DATA_ABORT:
-                env->v7m.cfsr |=
+                env->v7m.cfsr[M_REG_NS] |=
                     (R_V7M_CFSR_IBUSERR_MASK | R_V7M_CFSR_BFARVALID_MASK);
                 env->v7m.bfar = env->exception.vaddress;
                 qemu_log_mask(CPU_LOG_INT,
@@ -6369,11 +6369,11 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
              */
             switch (cs->exception_index) {
             case EXCP_PREFETCH_ABORT:
-                env->v7m.cfsr |= R_V7M_CFSR_IACCVIOL_MASK;
+                env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_IACCVIOL_MASK;
                 qemu_log_mask(CPU_LOG_INT, "...with CFSR.IACCVIOL\n");
                 break;
             case EXCP_DATA_ABORT:
-                env->v7m.cfsr |=
+                env->v7m.cfsr[env->v7m.secure] |=
                     (R_V7M_CFSR_DACCVIOL_MASK | R_V7M_CFSR_MMARVALID_MASK);
                 env->v7m.mmfar[env->v7m.secure] = env->exception.vaddress;
                 qemu_log_mask(CPU_LOG_INT,
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 7a96986..0bcaa68 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -118,7 +118,7 @@ static const VMStateDescription vmstate_m = {
         VMSTATE_UINT32(env.v7m.basepri[M_REG_NS], ARMCPU),
         VMSTATE_UINT32(env.v7m.control[M_REG_NS], ARMCPU),
         VMSTATE_UINT32(env.v7m.ccr[M_REG_NS], ARMCPU),
-        VMSTATE_UINT32(env.v7m.cfsr, ARMCPU),
+        VMSTATE_UINT32(env.v7m.cfsr[M_REG_NS], ARMCPU),
         VMSTATE_UINT32(env.v7m.hfsr, ARMCPU),
         VMSTATE_UINT32(env.v7m.dfsr, ARMCPU),
         VMSTATE_UINT32(env.v7m.mmfar[M_REG_NS], ARMCPU),
@@ -273,6 +273,7 @@ static const VMStateDescription vmstate_m_security = {
         VMSTATE_UINT32(env.v7m.mpu_ctrl[M_REG_S], ARMCPU),
         VMSTATE_UINT32(env.v7m.ccr[M_REG_S], ARMCPU),
         VMSTATE_UINT32(env.v7m.mmfar[M_REG_S], ARMCPU),
+        VMSTATE_UINT32(env.v7m.cfsr[M_REG_S], ARMCPU),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.7.4
