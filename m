Received: from eggs.gnu.org ([2001:4830:134:3::10]:60103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g1DGW-0004UV-77
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g1DGS-0003rf-Bb
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:47 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34607)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g1DGS-0003qF-2S
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 12:17:44 -0400
Received: by mail-pg1-x541.google.com with SMTP id d19-v6so5764633pgv.1
	for <qemu-devel@nongnu.org>; Sat, 15 Sep 2018 09:17:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 15 Sep 2018 09:17:26 -0700
Message-Id: <20180915161738.25257-2-richard.henderson@linaro.org>
In-Reply-To: <20180915161738.25257-1-richard.henderson@linaro.org>
References: <20180915161738.25257-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 01/13] target/arm: Add ARM_FEATURE_SWP
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

These insns have been removed from the ISA, but are also not
present on some cpus with V7VE.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h       |  1 +
 linux-user/elfload.c   |  3 ++-
 target/arm/cpu.c       | 10 ++++++++++
 target/arm/translate.c |  4 ++++
 4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 65c0fa0a65..acfb2f9104 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1495,6 +1495,7 @@ enum arm_features {
     ARM_FEATURE_V8_FP16, /* implements v8.2 half-precision float */
     ARM_FEATURE_V8_FCMA, /* has complex number part of v8.3 extensions.  */
     ARM_FEATURE_M_MAIN, /* M profile Main Extension */
+    ARM_FEATURE_SWP,  /* implements swp/swpb */
 };
 
 static inline int arm_feature(CPUARMState *env, int feature)
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 8638612aec..fcac2563f1 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -450,7 +450,6 @@ static uint32_t get_elf_hwcap(void)
     ARMCPU *cpu = ARM_CPU(thread_cpu);
     uint32_t hwcaps = 0;
 
-    hwcaps |= ARM_HWCAP_ARM_SWP;
     hwcaps |= ARM_HWCAP_ARM_HALF;
     hwcaps |= ARM_HWCAP_ARM_THUMB;
     hwcaps |= ARM_HWCAP_ARM_FAST_MULT;
@@ -458,7 +457,9 @@ static uint32_t get_elf_hwcap(void)
     /* probe for the extra features */
 #define GET_FEATURE(feat, hwcap) \
     do { if (arm_feature(&cpu->env, feat)) { hwcaps |= hwcap; } } while (0)
+
     /* EDSP is in v5TE and above, but all our v5 CPUs are v5TE */
+    GET_FEATURE(ARM_FEATURE_SWP, ARM_HWCAP_ARM_SWP);
     GET_FEATURE(ARM_FEATURE_V5, ARM_HWCAP_ARM_EDSP);
     GET_FEATURE(ARM_FEATURE_VFP, ARM_HWCAP_ARM_VFP);
     GET_FEATURE(ARM_FEATURE_IWMMXT, ARM_HWCAP_ARM_IWMMXT);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 258ba6dcaa..3bc7a16327 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1075,6 +1075,7 @@ static void arm926_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_CACHE_TEST_CLEAN);
     set_feature(&cpu->env, ARM_FEATURE_JAZELLE);
+    set_feature(&cpu->env, ARM_FEATURE_SWP);
     cpu->midr = 0x41069265;
     cpu->reset_fpsid = 0x41011090;
     cpu->ctr = 0x1dd20d2;
@@ -1089,6 +1090,7 @@ static void arm946_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_V5);
     set_feature(&cpu->env, ARM_FEATURE_PMSA);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
+    set_feature(&cpu->env, ARM_FEATURE_SWP);
     cpu->midr = 0x41059461;
     cpu->ctr = 0x0f004006;
     cpu->reset_sctlr = 0x00000078;
@@ -1105,6 +1107,7 @@ static void arm1026_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_CACHE_TEST_CLEAN);
     set_feature(&cpu->env, ARM_FEATURE_JAZELLE);
+    set_feature(&cpu->env, ARM_FEATURE_SWP);
     cpu->midr = 0x4106a262;
     cpu->reset_fpsid = 0x410110a0;
     cpu->ctr = 0x1dd20d2;
@@ -1139,6 +1142,7 @@ static void arm1136_r2_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_CACHE_DIRTY_REG);
     set_feature(&cpu->env, ARM_FEATURE_CACHE_BLOCK_OPS);
+    set_feature(&cpu->env, ARM_FEATURE_SWP);
     cpu->midr = 0x4107b362;
     cpu->reset_fpsid = 0x410120b4;
     cpu->mvfr0 = 0x11111111;
@@ -1171,6 +1175,7 @@ static void arm1136_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_CACHE_DIRTY_REG);
     set_feature(&cpu->env, ARM_FEATURE_CACHE_BLOCK_OPS);
+    set_feature(&cpu->env, ARM_FEATURE_SWP);
     cpu->midr = 0x4117b363;
     cpu->reset_fpsid = 0x410120b4;
     cpu->mvfr0 = 0x11111111;
@@ -1204,6 +1209,7 @@ static void arm1176_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_CACHE_DIRTY_REG);
     set_feature(&cpu->env, ARM_FEATURE_CACHE_BLOCK_OPS);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
+    set_feature(&cpu->env, ARM_FEATURE_SWP);
     cpu->midr = 0x410fb767;
     cpu->reset_fpsid = 0x410120b5;
     cpu->mvfr0 = 0x11111111;
@@ -1235,6 +1241,7 @@ static void arm11mpcore_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_VAPA);
     set_feature(&cpu->env, ARM_FEATURE_MPIDR);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
+    set_feature(&cpu->env, ARM_FEATURE_SWP);
     cpu->midr = 0x410fb022;
     cpu->reset_fpsid = 0x410120b4;
     cpu->mvfr0 = 0x11111111;
@@ -1378,6 +1385,7 @@ static void cortex_r5_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_ARM_DIV);
     set_feature(&cpu->env, ARM_FEATURE_V7MP);
     set_feature(&cpu->env, ARM_FEATURE_PMSA);
+    set_feature(&cpu->env, ARM_FEATURE_SWP);
     cpu->midr = 0x411fc153; /* r1p3 */
     cpu->id_pfr0 = 0x0131;
     cpu->id_pfr1 = 0x001;
@@ -1426,6 +1434,7 @@ static void cortex_a8_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
+    set_feature(&cpu->env, ARM_FEATURE_SWP);
     cpu->midr = 0x410fc080;
     cpu->reset_fpsid = 0x410330c0;
     cpu->mvfr0 = 0x11110222;
@@ -1500,6 +1509,7 @@ static void cortex_a9_initfn(Object *obj)
      */
     set_feature(&cpu->env, ARM_FEATURE_V7MP);
     set_feature(&cpu->env, ARM_FEATURE_CBAR);
+    set_feature(&cpu->env, ARM_FEATURE_SWP);
     cpu->midr = 0x410fc090;
     cpu->reset_fpsid = 0x41033090;
     cpu->mvfr0 = 0x11110222;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index c6a5d2ac44..2688380ae6 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9390,6 +9390,10 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                         TCGv taddr;
                         TCGMemOp opc = s->be_data;
 
+                        if (!arm_dc_feature(s, ARM_FEATURE_SWP)) {
+                            goto illegal_op;
+                        }
+
                         rm = (insn) & 0xf;
 
                         if (insn & (1 << 22)) {
-- 
2.17.1
