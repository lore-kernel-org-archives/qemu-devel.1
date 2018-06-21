Received: from eggs.gnu.org ([2001:4830:134:3::10]:39617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fVoob-00050J-0M
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:55:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fVooZ-0003a3-LD
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:55:13 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:43026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fVooZ-0003ZL-Ft
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:55:11 -0400
Received: by mail-pl0-x243.google.com with SMTP id c41-v6so747004plj.10
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 18:55:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 20 Jun 2018 15:53:58 -1000
Message-Id: <20180621015359.12018-35-richard.henderson@linaro.org>
In-Reply-To: <20180621015359.12018-1-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v5 34/35] target/arm: Enable SVE for
 aarch64-linux-user
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

Enable ARM_FEATURE_SVE for the generic "max" cpu.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c   | 7 +++++++
 target/arm/cpu64.c | 1 +
 2 files changed, 8 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e1de45e904..8e4f4d8c21 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -164,6 +164,13 @@ static void arm_cpu_reset(CPUState *s)
         env->cp15.sctlr_el[1] |= SCTLR_UCT | SCTLR_UCI | SCTLR_DZE;
         /* and to the FP/Neon instructions */
         env->cp15.cpacr_el1 = deposit64(env->cp15.cpacr_el1, 20, 2, 3);
+        /* and to the SVE instructions */
+        env->cp15.cpacr_el1 = deposit64(env->cp15.cpacr_el1, 16, 2, 3);
+        env->cp15.cptr_el[3] |= CPTR_EZ;
+        /* with maximum vector length */
+        env->vfp.zcr_el[1] = ARM_MAX_VQ - 1;
+        env->vfp.zcr_el[2] = ARM_MAX_VQ - 1;
+        env->vfp.zcr_el[3] = ARM_MAX_VQ - 1;
 #else
         /* Reset into the highest available EL */
         if (arm_feature(env, ARM_FEATURE_EL3)) {
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index c50dcd4077..0360d7efc5 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -252,6 +252,7 @@ static void aarch64_max_initfn(Object *obj)
         set_feature(&cpu->env, ARM_FEATURE_V8_RDM);
         set_feature(&cpu->env, ARM_FEATURE_V8_FP16);
         set_feature(&cpu->env, ARM_FEATURE_V8_FCMA);
+        set_feature(&cpu->env, ARM_FEATURE_SVE);
         /* For usermode -cpu max we can use a larger and more efficient DCZ
          * blocksize since we don't have to follow what the hardware does.
          */
-- 
2.17.1
