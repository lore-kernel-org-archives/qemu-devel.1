Received: from eggs.gnu.org ([2001:4830:134:3::10]:32979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY29v-0004lJ-1O
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:34:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY29s-0001B4-7J
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:34:23 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:41956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fY29s-0001AI-1w
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:34:20 -0400
Received: by mail-pf0-x241.google.com with SMTP id a11-v6so385133pff.8
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 21:34:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 26 Jun 2018 21:33:27 -0700
Message-Id: <20180627043328.11531-35-richard.henderson@linaro.org>
In-Reply-To: <20180627043328.11531-1-richard.henderson@linaro.org>
References: <20180627043328.11531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 34/35] target/arm: Enable SVE for
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
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org

Enable ARM_FEATURE_SVE for the generic "max" cpu.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

---
v6: Set ARM_HWCAP_A64_SVE.
---
 linux-user/elfload.c | 1 +
 target/arm/cpu.c     | 7 +++++++
 target/arm/cpu64.c   | 1 +
 3 files changed, 9 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 13bc78d0c8..d1231ad07a 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -584,6 +584,7 @@ static uint32_t get_elf_hwcap(void)
     GET_FEATURE(ARM_FEATURE_V8_ATOMICS, ARM_HWCAP_A64_ATOMICS);
     GET_FEATURE(ARM_FEATURE_V8_RDM, ARM_HWCAP_A64_ASIMDRDM);
     GET_FEATURE(ARM_FEATURE_V8_FCMA, ARM_HWCAP_A64_FCMA);
+    GET_FEATURE(ARM_FEATURE_SVE, ARM_HWCAP_A64_SVE);
 #undef GET_FEATURE
 
     return hwcaps;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 2ae4fffafb..6dcc552e14 100644
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
