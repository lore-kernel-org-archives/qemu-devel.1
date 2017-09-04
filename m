Received: from eggs.gnu.org ([2001:4830:134:3::10]:52318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSE-0004qu-4N
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqS4-0004dQ-4m
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:14 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1doqS3-0004cC-Sv
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:04 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1doqS2-0005SG-S3
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:26:02 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Sep 2017 13:25:39 +0100
Message-Id: <1504527967-29248-9-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
References: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 08/36] target/arm: Define and use XPSR bit masks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The M profile XPSR is almost the same format as the A profile CPSR,
but not quite. Define some XPSR_* macros and use them where we
definitely dealing with an XPSR rather than reusing the CPSR ones.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1501692241-23310-9-git-send-email-peter.maydell@linaro.org
---
 target/arm/cpu.h    | 38 ++++++++++++++++++++++++++++----------
 target/arm/helper.c | 15 ++++++++-------
 2 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 2f2aa87..0b9f937 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -882,6 +882,22 @@ void pmccntr_sync(CPUARMState *env);
 /* Mask of bits which may be set by exception return copying them from SPSR */
 #define CPSR_ERET_MASK (~CPSR_RESERVED)
 
+/* Bit definitions for M profile XPSR. Most are the same as CPSR. */
+#define XPSR_EXCP 0x1ffU
+#define XPSR_SPREALIGN (1U << 9) /* Only set in exception stack frames */
+#define XPSR_IT_2_7 CPSR_IT_2_7
+#define XPSR_GE CPSR_GE
+#define XPSR_SFPA (1U << 20) /* Only set in exception stack frames */
+#define XPSR_T (1U << 24) /* Not the same as CPSR_T ! */
+#define XPSR_IT_0_1 CPSR_IT_0_1
+#define XPSR_Q CPSR_Q
+#define XPSR_V CPSR_V
+#define XPSR_C CPSR_C
+#define XPSR_Z CPSR_Z
+#define XPSR_N CPSR_N
+#define XPSR_NZCV CPSR_NZCV
+#define XPSR_IT CPSR_IT
+
 #define TTBCR_N      (7U << 0) /* TTBCR.EAE==0 */
 #define TTBCR_T0SZ   (7U << 0) /* TTBCR.EAE==1 */
 #define TTBCR_PD0    (1U << 4)
@@ -986,26 +1002,28 @@ static inline uint32_t xpsr_read(CPUARMState *env)
 /* Set the xPSR.  Note that some bits of mask must be all-set or all-clear.  */
 static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 {
-    if (mask & CPSR_NZCV) {
-        env->ZF = (~val) & CPSR_Z;
+    if (mask & XPSR_NZCV) {
+        env->ZF = (~val) & XPSR_Z;
         env->NF = val;
         env->CF = (val >> 29) & 1;
         env->VF = (val << 3) & 0x80000000;
     }
-    if (mask & CPSR_Q)
-        env->QF = ((val & CPSR_Q) != 0);
-    if (mask & (1 << 24))
-        env->thumb = ((val & (1 << 24)) != 0);
-    if (mask & CPSR_IT_0_1) {
+    if (mask & XPSR_Q) {
+        env->QF = ((val & XPSR_Q) != 0);
+    }
+    if (mask & XPSR_T) {
+        env->thumb = ((val & XPSR_T) != 0);
+    }
+    if (mask & XPSR_IT_0_1) {
         env->condexec_bits &= ~3;
         env->condexec_bits |= (val >> 25) & 3;
     }
-    if (mask & CPSR_IT_2_7) {
+    if (mask & XPSR_IT_2_7) {
         env->condexec_bits &= 3;
         env->condexec_bits |= (val >> 8) & 0xfc;
     }
-    if (mask & 0x1ff) {
-        env->v7m.exception = val & 0x1ff;
+    if (mask & XPSR_EXCP) {
+        env->v7m.exception = val & XPSR_EXCP;
     }
 }
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2fb0202..439ad86 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6114,7 +6114,7 @@ static void v7m_push_stack(ARMCPU *cpu)
     /* Align stack pointer if the guest wants that */
     if ((env->regs[13] & 4) && (env->v7m.ccr & R_V7M_CCR_STKALIGN_MASK)) {
         env->regs[13] -= 4;
-        xpsr |= 0x200;
+        xpsr |= XPSR_SPREALIGN;
     }
     /* Switch to the handler mode.  */
     v7m_push(env, xpsr);
@@ -6239,10 +6239,11 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
         env->regs[15] &= ~1U;
     }
     xpsr = v7m_pop(env);
-    xpsr_write(env, xpsr, 0xfffffdff);
+    xpsr_write(env, xpsr, ~XPSR_SPREALIGN);
     /* Undo stack alignment.  */
-    if (xpsr & 0x200)
+    if (xpsr & XPSR_SPREALIGN) {
         env->regs[13] |= 4;
+    }
 
     /* The restored xPSR exception field will be zero if we're
      * resuming in Thread mode. If that doesn't match what the
@@ -8688,10 +8689,10 @@ uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
     case 0 ... 7: /* xPSR sub-fields */
         mask = 0;
         if ((reg & 1) && el) {
-            mask |= 0x000001ff; /* IPSR (unpriv. reads as zero) */
+            mask |= XPSR_EXCP; /* IPSR (unpriv. reads as zero) */
         }
         if (!(reg & 4)) {
-            mask |= 0xf8000000; /* APSR */
+            mask |= XPSR_NZCV | XPSR_Q; /* APSR */
         }
         /* EPSR reads as zero */
         return xpsr_read(env) & mask;
@@ -8749,10 +8750,10 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
             uint32_t apsrmask = 0;
 
             if (mask & 8) {
-                apsrmask |= 0xf8000000; /* APSR NZCVQ */
+                apsrmask |= XPSR_NZCV | XPSR_Q;
             }
             if ((mask & 4) && arm_feature(env, ARM_FEATURE_THUMB_DSP)) {
-                apsrmask |= 0x000f0000; /* APSR GE[3:0] */
+                apsrmask |= XPSR_GE;
             }
             xpsr_write(env, val, apsrmask);
         }
-- 
2.7.4
