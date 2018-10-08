Received: from eggs.gnu.org ([2001:4830:134:3::10]:58225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9d4S-000559-Ht
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 17:28:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9cyr-0008AQ-1j
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 17:22:24 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:42529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g9cyq-00089L-Pd
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 17:22:20 -0400
Received: by mail-pf1-x434.google.com with SMTP id f26-v6so8787748pfn.9
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 14:22:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  8 Oct 2018 14:22:02 -0700
Message-Id: <20181008212205.17752-8-richard.henderson@linaro.org>
In-Reply-To: <20181008212205.17752-1-richard.henderson@linaro.org>
References: <20181008212205.17752-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 07/10] target/arm: Convert jazelle from
 feature bit to isar1 test
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

Having V6 alone imply jazelle was wrong for cortex-m0.
Change to an assertion for V6 & !M.

This was harmless, because the only place we tested ARM_FEATURE_JAZELLE
was for 'bxj' in disas_arm(), which is unreachable for M-profile cores.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h       |  6 +++++-
 target/arm/translate.h |  1 +
 target/arm/cpu.c       | 17 ++++++++++++++---
 target/arm/translate.c |  2 +-
 4 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 2af971e823..557ef8daf9 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1580,7 +1580,6 @@ enum arm_features {
     ARM_FEATURE_PMU, /* has PMU support */
     ARM_FEATURE_VBAR, /* has cp15 VBAR */
     ARM_FEATURE_M_SECURITY, /* M profile Security Extension */
-    ARM_FEATURE_JAZELLE, /* has (trivial) Jazelle implementation */
     ARM_FEATURE_SVE, /* has Scalable Vector Extension */
     ARM_FEATURE_V8_FP16, /* implements v8.2 half-precision float */
     ARM_FEATURE_M_MAIN, /* M profile Main Extension */
@@ -3147,6 +3146,11 @@ static inline bool aa32_feature_arm_div(ARMCPU *cpu)
     return FIELD_EX32(cpu->id_isar0, ID_ISAR0, DIVIDE) > 1;
 }
 
+static inline bool aa32_feature_jazelle(ARMCPU *cpu)
+{
+    return FIELD_EX32(cpu->id_isar1, ID_ISAR1, JAZELLE) != 0;
+}
+
 static inline bool aa32_feature_aes(ARMCPU *cpu)
 {
     return FIELD_EX32(cpu->id_isar5, ID_ISAR5, AES) != 0;
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 8279465d1d..bd394bdf69 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -197,6 +197,7 @@ static inline TCGv_i32 get_ahp_flag(void)
 
 FORWARD_FEATURE(thumb_div)
 FORWARD_FEATURE(arm_div)
+FORWARD_FEATURE(jazelle)
 FORWARD_FEATURE(aes)
 FORWARD_FEATURE(pmull)
 FORWARD_FEATURE(sha1)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f068b4c476..4e2609aa7e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -850,8 +850,8 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
     if (arm_feature(env, ARM_FEATURE_V6)) {
         set_feature(env, ARM_FEATURE_V5);
-        set_feature(env, ARM_FEATURE_JAZELLE);
         if (!arm_feature(env, ARM_FEATURE_M)) {
+            assert(aa32_feature_jazelle(cpu));
             set_feature(env, ARM_FEATURE_AUXCR);
         }
     }
@@ -1078,11 +1078,16 @@ static void arm926_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_VFP);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_CACHE_TEST_CLEAN);
-    set_feature(&cpu->env, ARM_FEATURE_JAZELLE);
     cpu->midr = 0x41069265;
     cpu->reset_fpsid = 0x41011090;
     cpu->ctr = 0x1dd20d2;
     cpu->reset_sctlr = 0x00090078;
+
+    /*
+     * ARMv5 does not have the ID_ISAR registers, but we can still
+     * set the field to indicate Jazelle support within QEMU.
+     */
+    cpu->id_isar1 = FIELD_DP32(cpu->id_isar1, ID_ISAR1, JAZELLE, 1);
 }
 
 static void arm946_initfn(Object *obj)
@@ -1108,12 +1113,18 @@ static void arm1026_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_AUXCR);
     set_feature(&cpu->env, ARM_FEATURE_DUMMY_C15_REGS);
     set_feature(&cpu->env, ARM_FEATURE_CACHE_TEST_CLEAN);
-    set_feature(&cpu->env, ARM_FEATURE_JAZELLE);
     cpu->midr = 0x4106a262;
     cpu->reset_fpsid = 0x410110a0;
     cpu->ctr = 0x1dd20d2;
     cpu->reset_sctlr = 0x00090078;
     cpu->reset_auxcr = 1;
+
+    /*
+     * ARMv5 does not have the ID_ISAR registers, but we can still
+     * set the field to indicate Jazelle support within QEMU.
+     */
+    cpu->id_isar1 = FIELD_DP32(cpu->id_isar1, ID_ISAR1, JAZELLE, 1);
+
     {
         /* The 1026 had an IFAR at c6,c0,0,1 rather than the ARMv6 c6,c0,0,2 */
         ARMCPRegInfo ifar = {
diff --git a/target/arm/translate.c b/target/arm/translate.c
index b1ee6533cc..54ecf369cb 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -42,7 +42,7 @@
 #define ENABLE_ARCH_5     arm_dc_feature(s, ARM_FEATURE_V5)
 /* currently all emulated v5 cores are also v5TE, so don't bother */
 #define ENABLE_ARCH_5TE   arm_dc_feature(s, ARM_FEATURE_V5)
-#define ENABLE_ARCH_5J    arm_dc_feature(s, ARM_FEATURE_JAZELLE)
+#define ENABLE_ARCH_5J    aa32_dc_feature_jazelle(s)
 #define ENABLE_ARCH_6     arm_dc_feature(s, ARM_FEATURE_V6)
 #define ENABLE_ARCH_6K    arm_dc_feature(s, ARM_FEATURE_V6K)
 #define ENABLE_ARCH_6T2   arm_dc_feature(s, ARM_FEATURE_THUMB2)
-- 
2.17.1
