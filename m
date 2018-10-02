Received: from eggs.gnu.org ([2001:4830:134:3::10]:34779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g7Nea-0006cO-So
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 12:36:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g7NeZ-00053a-Ih
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 12:36:08 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  2 Oct 2018 17:35:44 +0100
Message-Id: <20181002163556.10279-2-peter.maydell@linaro.org>
In-Reply-To: <20181002163556.10279-1-peter.maydell@linaro.org>
References: <20181002163556.10279-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 01/13] target/arm: Define new TBFLAG for v8M
 stack checking
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

The Arm v8M architecture includes hardware stack limit checking.
When certain instructions update the stack pointer, if the new
value of SP is below the limit set in the associated limit register
then an exception is taken. Add a TB flag that tracks whether
the limit-checking code needs to be emitted.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h       |  7 +++++++
 target/arm/translate.h |  1 +
 target/arm/helper.c    | 10 ++++++++++
 target/arm/translate.c |  1 +
 4 files changed, 19 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 65c0fa0a659..d2c1d005ed7 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1336,8 +1336,10 @@ FIELD(V7M_CCR, UNALIGN_TRP, 3, 1)
 FIELD(V7M_CCR, DIV_0_TRP, 4, 1)
 FIELD(V7M_CCR, BFHFNMIGN, 8, 1)
 FIELD(V7M_CCR, STKALIGN, 9, 1)
+FIELD(V7M_CCR, STKOFHFNMIGN, 10, 1)
 FIELD(V7M_CCR, DC, 16, 1)
 FIELD(V7M_CCR, IC, 17, 1)
+FIELD(V7M_CCR, BP, 18, 1)
 
 /* V7M SCR bits */
 FIELD(V7M_SCR, SLEEPONEXIT, 1, 1)
@@ -2842,6 +2844,9 @@ static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
 /* For M profile only, Handler (ie not Thread) mode */
 #define ARM_TBFLAG_HANDLER_SHIFT    21
 #define ARM_TBFLAG_HANDLER_MASK     (1 << ARM_TBFLAG_HANDLER_SHIFT)
+/* For M profile only, whether we should generate stack-limit checks */
+#define ARM_TBFLAG_STACKCHECK_SHIFT 22
+#define ARM_TBFLAG_STACKCHECK_MASK  (1 << ARM_TBFLAG_STACKCHECK_SHIFT)
 
 /* Bit usage when in AArch64 state */
 #define ARM_TBFLAG_TBI0_SHIFT 0        /* TBI0 for EL0/1 or TBI for EL2/3 */
@@ -2884,6 +2889,8 @@ static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
     (((F) & ARM_TBFLAG_BE_DATA_MASK) >> ARM_TBFLAG_BE_DATA_SHIFT)
 #define ARM_TBFLAG_HANDLER(F) \
     (((F) & ARM_TBFLAG_HANDLER_MASK) >> ARM_TBFLAG_HANDLER_SHIFT)
+#define ARM_TBFLAG_STACKCHECK(F) \
+    (((F) & ARM_TBFLAG_STACKCHECK_MASK) >> ARM_TBFLAG_STACKCHECK_SHIFT)
 #define ARM_TBFLAG_TBI0(F) \
     (((F) & ARM_TBFLAG_TBI0_MASK) >> ARM_TBFLAG_TBI0_SHIFT)
 #define ARM_TBFLAG_TBI1(F) \
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 45f04244be8..c1b65f3efb0 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -38,6 +38,7 @@ typedef struct DisasContext {
     int vec_stride;
     bool v7m_handler_mode;
     bool v8m_secure; /* true if v8M and we're in Secure mode */
+    bool v8m_stackcheck; /* true if we need to perform v8M stack limit checks */
     /* Immediate value in AArch32 SVC insn; must be set if is_jmp == DISAS_SWI
      * so that top level loop can generate correct syndrome information.
      */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5e721a65272..6ed8631dbee 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12667,6 +12667,16 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         flags |= ARM_TBFLAG_HANDLER_MASK;
     }
 
+    /* v8M always applies stack limit checks unless CCR.STKOFHFNMIGN is
+     * suppressing them because the requested execution priority is less than 0.
+     */
+    if (arm_feature(env, ARM_FEATURE_V8) &&
+        arm_feature(env, ARM_FEATURE_M) &&
+        !((mmu_idx  & ARM_MMU_IDX_M_NEGPRI) &&
+          (env->v7m.ccr[env->v7m.secure] & R_V7M_CCR_STKOFHFNMIGN_MASK))) {
+        flags |= ARM_TBFLAG_STACKCHECK_MASK;
+    }
+
     *pflags = flags;
     *cs_base = 0;
 }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index c6a5d2ac444..751d5811cee 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -12451,6 +12451,7 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     dc->v7m_handler_mode = ARM_TBFLAG_HANDLER(dc->base.tb->flags);
     dc->v8m_secure = arm_feature(env, ARM_FEATURE_M_SECURITY) &&
         regime_is_secure(env, dc->mmu_idx);
+    dc->v8m_stackcheck = ARM_TBFLAG_STACKCHECK(dc->base.tb->flags);
     dc->cp_regs = cpu->cp_regs;
     dc->features = env->features;
 
-- 
2.19.0
