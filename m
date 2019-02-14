Received: from eggs.gnu.org ([209.51.188.92]:54084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMLL-00084I-Ie
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMLK-0004uj-C4
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:43 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:52843)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guMLJ-0004pZ-V1
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:42 -0500
Received: by mail-wm1-x331.google.com with SMTP id m1so7512930wml.2
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 11:06:34 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	n184sm7798471wmf.5.2019.02.14.11.06.32 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 14 Feb 2019 11:06:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 19:05:59 +0000
Message-Id: <20190214190603.25030-24-peter.maydell@linaro.org>
In-Reply-To: <20190214190603.25030-1-peter.maydell@linaro.org>
References: <20190214190603.25030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 23/27] target/arm: Fix set of bits kept in
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

From: Richard Henderson <richard.henderson@linaro.org>

Given that we mask bits properly on set, there is no reason
to mask them again on get.  We failed to clear the exception
status bits, 0x9f, which means that the wrong value would be
returned on get.  Except in the (probably normal) case in which
the set clears all of the bits.

Simplify the code in set to also clear the RES0 bits.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190209033847.9014-10-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 28e45f0f0ba..d4b7eca30a7 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12707,7 +12707,7 @@ uint32_t HELPER(vfp_get_fpscr)(CPUARMState *env)
     int i;
     uint32_t fpscr;
 
-    fpscr = (env->vfp.xregs[ARM_VFP_FPSCR] & 0xffc8ffff)
+    fpscr = env->vfp.xregs[ARM_VFP_FPSCR]
             | (env->vfp.vec_len << 16)
             | (env->vfp.vec_stride << 20);
 
@@ -12749,7 +12749,7 @@ static inline int vfp_exceptbits_to_host(int target_bits)
 void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
 {
     int i;
-    uint32_t changed;
+    uint32_t changed = env->vfp.xregs[ARM_VFP_FPSCR];
 
     /* When ARMv8.2-FP16 is not supported, FZ16 is RES0.  */
     if (!cpu_isar_feature(aa64_fp16, arm_env_get_cpu(env))) {
@@ -12758,12 +12758,13 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
 
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
2.20.1
