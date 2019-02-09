Received: from eggs.gnu.org ([209.51.188.92]:42567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsJUY-0007PR-5r
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 22:39:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsJUS-0000hn-CS
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 22:39:43 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34539)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gsJUN-0000Wm-B5
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 22:39:37 -0500
Received: by mail-pg1-x541.google.com with SMTP id d9so2432743pgl.1
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 19:39:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  8 Feb 2019 19:38:45 -0800
Message-Id: <20190209033847.9014-11-richard.henderson@linaro.org>
In-Reply-To: <20190209033847.9014-1-richard.henderson@linaro.org>
References: <20190209033847.9014-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 10/12] target/arm: Split out FPSCR.QC to a
 vector field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Change the representation of this field such that it is easy
to set from vector code.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h         |  5 ++++-
 target/arm/helper.c      | 19 +++++++++++++++----
 target/arm/neon_helper.c |  2 +-
 target/arm/vec_helper.c  |  2 +-
 4 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 47238e4245..b96463e8f1 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -577,11 +577,13 @@ typedef struct CPUARMState {
         ARMPredicateReg preg_tmp;
 #endif
 
-        uint32_t xregs[16];
         /* We store these fpcsr fields separately for convenience.  */
+        uint32_t qc[4] QEMU_ALIGNED(16);
         int vec_len;
         int vec_stride;
 
+        uint32_t xregs[16];
+
         /* Scratch space for aa32 neon expansion.  */
         uint32_t scratch[8];
 
@@ -1427,6 +1429,7 @@ void vfp_set_fpscr(CPUARMState *env, uint32_t val);
 #define FPCR_FZ16   (1 << 19)   /* ARMv8.2+, FP16 flush-to-zero */
 #define FPCR_FZ     (1 << 24)   /* Flush-to-zero enable bit */
 #define FPCR_DN     (1 << 25)   /* Default NaN enable bit */
+#define FPCR_QC     (1 << 27)   /* Cumulative saturation bit */
 
 static inline uint32_t vfp_get_fpsr(CPUARMState *env)
 {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index af22274bd9..7ed9933663 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12585,8 +12585,7 @@ static inline int vfp_exceptbits_from_host(int host_bits)
 
 uint32_t HELPER(vfp_get_fpscr)(CPUARMState *env)
 {
-    int i;
-    uint32_t fpscr;
+    uint32_t i, fpscr;
 
     fpscr = env->vfp.xregs[ARM_VFP_FPSCR]
             | (env->vfp.vec_len << 16)
@@ -12597,8 +12596,11 @@ uint32_t HELPER(vfp_get_fpscr)(CPUARMState *env)
     /* FZ16 does not generate an input denormal exception.  */
     i |= (get_float_exception_flags(&env->vfp.fp_status_f16)
           & ~float_flag_input_denormal);
-
     fpscr |= vfp_exceptbits_from_host(i);
+
+    i = env->vfp.qc[0] | env->vfp.qc[1] | env->vfp.qc[2] | env->vfp.qc[3];
+    fpscr |= i ? FPCR_QC : 0;
+
     return fpscr;
 }
 
@@ -12645,10 +12647,19 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
      * (which are stored in fp_status), and the other RES0 bits
      * in between, then we clear all of the low 16 bits.
      */
-    env->vfp.xregs[ARM_VFP_FPSCR] = val & 0xffc80000;
+    env->vfp.xregs[ARM_VFP_FPSCR] = val & 0xf7c80000;
     env->vfp.vec_len = (val >> 16) & 7;
     env->vfp.vec_stride = (val >> 20) & 3;
 
+    /*
+     * The bit we set within fpscr_q is arbitrary; the register as a
+     * whole being zero/non-zero is what counts.
+     */
+    env->vfp.qc[0] = val & FPCR_QC;
+    env->vfp.qc[1] = 0;
+    env->vfp.qc[2] = 0;
+    env->vfp.qc[3] = 0;
+
     changed ^= val;
     if (changed & (3 << 22)) {
         i = (val >> 22) & 3;
diff --git a/target/arm/neon_helper.c b/target/arm/neon_helper.c
index 3249005b62..ed1c6fc41c 100644
--- a/target/arm/neon_helper.c
+++ b/target/arm/neon_helper.c
@@ -15,7 +15,7 @@
 #define SIGNBIT (uint32_t)0x80000000
 #define SIGNBIT64 ((uint64_t)1 << 63)
 
-#define SET_QC() env->vfp.xregs[ARM_VFP_FPSCR] |= CPSR_Q
+#define SET_QC() env->vfp.qc[0] = 1
 
 #define NEON_TYPE1(name, type) \
 typedef struct \
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 37f338732e..65a18af4e0 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -36,7 +36,7 @@
 #define H4(x)  (x)
 #endif
 
-#define SET_QC() env->vfp.xregs[ARM_VFP_FPSCR] |= CPSR_Q
+#define SET_QC() env->vfp.qc[0] = 1
 
 static void clear_tail(void *vd, uintptr_t opr_sz, uintptr_t max_sz)
 {
-- 
2.17.2
