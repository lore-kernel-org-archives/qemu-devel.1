Received: from eggs.gnu.org ([209.51.188.92]:42538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsJUI-00079t-B9
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 22:39:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsJUB-0000bu-A2
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 22:39:25 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:47021)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gsJU5-0000W4-Fp
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 22:39:19 -0500
Received: by mail-pl1-x641.google.com with SMTP id o6so2584385pls.13
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 19:39:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  8 Feb 2019 19:38:44 -0800
Message-Id: <20190209033847.9014-10-richard.henderson@linaro.org>
In-Reply-To: <20190209033847.9014-1-richard.henderson@linaro.org>
References: <20190209033847.9014-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 09/12] target/arm: Fix set of bits kept in
 xregs[ARM_VFP_FPSCR]
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

Given that we mask bits properly on set, there is no reason
to mask them again on get.  We failed to clear the exception
status bits, 0x9f, which means that the wrong value would be
returned on get.  Except in the (probably normal) case in which
the set clears all of the bits.

Simplify the code in set to also clear the RES0 bits.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 51be3fa16f..af22274bd9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12588,7 +12588,7 @@ uint32_t HELPER(vfp_get_fpscr)(CPUARMState *env)
     int i;
     uint32_t fpscr;
 
-    fpscr = (env->vfp.xregs[ARM_VFP_FPSCR] & 0xffc8ffff)
+    fpscr = env->vfp.xregs[ARM_VFP_FPSCR]
             | (env->vfp.vec_len << 16)
             | (env->vfp.vec_stride << 20);
 
@@ -12630,7 +12630,7 @@ static inline int vfp_exceptbits_to_host(int target_bits)
 void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
 {
     int i;
-    uint32_t changed;
+    uint32_t changed = env->vfp.xregs[ARM_VFP_FPSCR];
 
     /* When ARMv8.2-FP16 is not supported, FZ16 is RES0.  */
     if (!cpu_isar_feature(aa64_fp16, arm_env_get_cpu(env))) {
@@ -12639,12 +12639,13 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
 
     /*
      * We don't implement trapped exception handling, so the
-     * trap enable bits are all RAZ/WI (not RES0!)
+     * trap enable bits, IDE|IXE|UFE|OFE|DZE|IOE are all RAZ/WI (not RES0!)
+     *
+     * If we exclude the exception flags, IOC|DZC|OFC|UFC|IXC|IDC
+     * (which are stored in fp_status), and the other RES0 bits
+     * in between, then we clear all of the low 16 bits.
      */
-    val &= ~(FPCR_IDE | FPCR_IXE | FPCR_UFE | FPCR_OFE | FPCR_DZE | FPCR_IOE);
-
-    changed = env->vfp.xregs[ARM_VFP_FPSCR];
-    env->vfp.xregs[ARM_VFP_FPSCR] = (val & 0xffc8ffff);
+    env->vfp.xregs[ARM_VFP_FPSCR] = val & 0xffc80000;
     env->vfp.vec_len = (val >> 16) & 7;
     env->vfp.vec_stride = (val >> 20) & 3;
 
-- 
2.17.2
