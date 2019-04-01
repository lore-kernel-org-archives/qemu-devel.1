Received: from eggs.gnu.org ([209.51.188.92]:42722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB471-0003XT-Bu
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB46z-0004sm-KJ
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48636)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB46y-0004nh-7o
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:56 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L4ie2114727
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:04:48 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rksvqh0am-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:04:46 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:22 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:18 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-45-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 44/97] target/arm: Fix cpu_get_tb_cpu_state()
 for non-SVE CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

From: Richard Henderson <richard.henderson@linaro.org>

Not only are the sve-related tb_flags fields unused when SVE is
disabled, but not all of the cpu registers are initialized properly
for computing same.  This can corrupt other fields by ORing in -1,
which might result in QEMU crashing.

This bug was not present in 3.0, but this patch is cc'd to
stable because adf92eab90e3f5f34c285 where the bug was
introduced was marked for stable.

Fixes: adf92eab90e3f5f34c285
Cc: qemu-stable@nongnu.org (3.0.1)
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit e79b445d896deb61909be52b61b87c98a9ed96f7)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/arm/helper.c | 45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 991b077e8f..7ee614c04f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12401,36 +12401,39 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
     uint32_t flags;
 
     if (is_a64(env)) {
-        int sve_el = sve_exception_el(env);
-        uint32_t zcr_len;
-
         *pc = env->pc;
         flags = ARM_TBFLAG_AARCH64_STATE_MASK;
         /* Get control bits for tagged addresses */
         flags |= (arm_regime_tbi0(env, mmu_idx) << ARM_TBFLAG_TBI0_SHIFT);
         flags |= (arm_regime_tbi1(env, mmu_idx) << ARM_TBFLAG_TBI1_SHIFT);
-        flags |= sve_el << ARM_TBFLAG_SVEEXC_EL_SHIFT;
 
-        /* If SVE is disabled, but FP is enabled,
-           then the effective len is 0.  */
-        if (sve_el != 0 && fp_el == 0) {
-            zcr_len = 0;
-        } else {
-            int current_el = arm_current_el(env);
-            ARMCPU *cpu = arm_env_get_cpu(env);
+        if (arm_feature(env, ARM_FEATURE_SVE)) {
+            int sve_el = sve_exception_el(env);
+            uint32_t zcr_len;
 
-            zcr_len = cpu->sve_max_vq - 1;
-            if (current_el <= 1) {
-                zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[1]);
-            }
-            if (current_el < 2 && arm_feature(env, ARM_FEATURE_EL2)) {
-                zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[2]);
-            }
-            if (current_el < 3 && arm_feature(env, ARM_FEATURE_EL3)) {
-                zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[3]);
+            /* If SVE is disabled, but FP is enabled,
+             * then the effective len is 0.
+             */
+            if (sve_el != 0 && fp_el == 0) {
+                zcr_len = 0;
+            } else {
+                int current_el = arm_current_el(env);
+                ARMCPU *cpu = arm_env_get_cpu(env);
+
+                zcr_len = cpu->sve_max_vq - 1;
+                if (current_el <= 1) {
+                    zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[1]);
+                }
+                if (current_el < 2 && arm_feature(env, ARM_FEATURE_EL2)) {
+                    zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[2]);
+                }
+                if (current_el < 3 && arm_feature(env, ARM_FEATURE_EL3)) {
+                    zcr_len = MIN(zcr_len, 0xf & (uint32_t)env->vfp.zcr_el[3]);
+                }
             }
+            flags |= sve_el << ARM_TBFLAG_SVEEXC_EL_SHIFT;
+            flags |= zcr_len << ARM_TBFLAG_ZCR_LEN_SHIFT;
         }
-        flags |= zcr_len << ARM_TBFLAG_ZCR_LEN_SHIFT;
     } else {
         *pc = env->regs[15];
         flags = (env->thumb << ARM_TBFLAG_THUMB_SHIFT)
-- 
2.17.1
