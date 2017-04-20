Received: from eggs.gnu.org ([2001:4830:134:3::10]:43764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F93-0008Qi-L8
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F91-00088B-FA
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:25 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:36885)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1d1F91-0007wI-6p
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:23 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F90-000709-0W
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 17:41:22 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Apr 2017 17:41:08 +0100
Message-Id: <1492706470-10921-23-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1492706470-10921-1-git-send-email-peter.maydell@linaro.org>
References: <1492706470-10921-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 22/24] arm: Track M profile handler mode state
 in TB flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

For M profile exception-return handling we'd like to generate different
code for some instructions depending on whether we are in Handler
mode or Thread mode. This isn't the same as "are we privileged
or user", so we need an extra bit in the TB flags to distinguish.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 1491844419-12485-8-git-send-email-peter.maydell@linaro.org
---
 target/arm/cpu.h       | 9 +++++++++
 target/arm/translate.h | 1 +
 target/arm/translate.c | 1 +
 3 files changed, 11 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ab86943..1055bfe 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2291,6 +2291,9 @@ static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
 #define ARM_TBFLAG_NS_MASK          (1 << ARM_TBFLAG_NS_SHIFT)
 #define ARM_TBFLAG_BE_DATA_SHIFT    20
 #define ARM_TBFLAG_BE_DATA_MASK     (1 << ARM_TBFLAG_BE_DATA_SHIFT)
+/* For M profile only, Handler (ie not Thread) mode */
+#define ARM_TBFLAG_HANDLER_SHIFT    21
+#define ARM_TBFLAG_HANDLER_MASK     (1 << ARM_TBFLAG_HANDLER_SHIFT)
 
 /* Bit usage when in AArch64 state */
 #define ARM_TBFLAG_TBI0_SHIFT 0        /* TBI0 for EL0/1 or TBI for EL2/3 */
@@ -2327,6 +2330,8 @@ static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
     (((F) & ARM_TBFLAG_NS_MASK) >> ARM_TBFLAG_NS_SHIFT)
 #define ARM_TBFLAG_BE_DATA(F) \
     (((F) & ARM_TBFLAG_BE_DATA_MASK) >> ARM_TBFLAG_BE_DATA_SHIFT)
+#define ARM_TBFLAG_HANDLER(F) \
+    (((F) & ARM_TBFLAG_HANDLER_MASK) >> ARM_TBFLAG_HANDLER_SHIFT)
 #define ARM_TBFLAG_TBI0(F) \
     (((F) & ARM_TBFLAG_TBI0_MASK) >> ARM_TBFLAG_TBI0_SHIFT)
 #define ARM_TBFLAG_TBI1(F) \
@@ -2517,6 +2522,10 @@ static inline void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
     }
     *flags |= fp_exception_el(env) << ARM_TBFLAG_FPEXC_EL_SHIFT;
 
+    if (env->v7m.exception != 0) {
+        *flags |= ARM_TBFLAG_HANDLER_MASK;
+    }
+
     *cs_base = 0;
 }
 
diff --git a/target/arm/translate.h b/target/arm/translate.h
index abb0760..3d0e8a6 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -31,6 +31,7 @@ typedef struct DisasContext {
     bool vfp_enabled; /* FP enabled via FPSCR.EN */
     int vec_len;
     int vec_stride;
+    bool v7m_handler_mode;
     /* Immediate value in AArch32 SVC insn; must be set if is_jmp == DISAS_SWI
      * so that top level loop can generate correct syndrome information.
      */
diff --git a/target/arm/translate.c b/target/arm/translate.c
index f28c4ca..4fe7692 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11780,6 +11780,7 @@ void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
     dc->vec_len = ARM_TBFLAG_VECLEN(tb->flags);
     dc->vec_stride = ARM_TBFLAG_VECSTRIDE(tb->flags);
     dc->c15_cpar = ARM_TBFLAG_XSCALE_CPAR(tb->flags);
+    dc->v7m_handler_mode = ARM_TBFLAG_HANDLER(tb->flags);
     dc->cp_regs = cpu->cp_regs;
     dc->features = env->features;
 
-- 
2.7.4
