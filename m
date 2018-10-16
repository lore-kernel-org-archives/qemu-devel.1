Received: from eggs.gnu.org ([2001:4830:134:3::10]:53634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCXsC-0001Vm-PS
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 18:31:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCXsA-0005VG-EO
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 18:31:32 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:43107)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gCXs8-0005LU-DV
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 18:31:29 -0400
Received: by mail-pf1-x444.google.com with SMTP id p24-v6so12138889pff.10
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 15:31:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 16 Oct 2018 15:31:12 -0700
Message-Id: <20181016223115.24100-6-richard.henderson@linaro.org>
In-Reply-To: <20181016223115.24100-1-richard.henderson@linaro.org>
References: <20181016223115.24100-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 5/8] target/arm: Convert jazelle from
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
 target/arm/cpu.c       | 17 ++++++++++++++---
 target/arm/translate.c |  2 +-
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a757aecd57..4fdace5de1 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1586,7 +1586,6 @@ enum arm_features {
     ARM_FEATURE_PMU, /* has PMU support */
     ARM_FEATURE_VBAR, /* has cp15 VBAR */
     ARM_FEATURE_M_SECURITY, /* M profile Security Extension */
-    ARM_FEATURE_JAZELLE, /* has (trivial) Jazelle implementation */
     ARM_FEATURE_SVE, /* has Scalable Vector Extension */
     ARM_FEATURE_V8_FP16, /* implements v8.2 half-precision float */
     ARM_FEATURE_M_MAIN, /* M profile Main Extension */
@@ -3153,6 +3152,11 @@ static inline bool isar_feature_arm_div(const ARMISARegisters *id)
     return FIELD_EX32(id->id_isar0, ID_ISAR0, DIVIDE) > 1;
 }
 
+static inline bool isar_feature_jazelle(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_isar1, ID_ISAR1, JAZELLE) != 0;
+}
+
 static inline bool isar_feature_aa32_aes(const ARMISARegisters *id)
 {
     return FIELD_EX32(id->id_isar5, ID_ISAR5, AES) != 0;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 9319f92f1f..8f16e96b6c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -854,8 +854,8 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
     if (arm_feature(env, ARM_FEATURE_V6)) {
         set_feature(env, ARM_FEATURE_V5);
-        set_feature(env, ARM_FEATURE_JAZELLE);
         if (!arm_feature(env, ARM_FEATURE_M)) {
+            assert(cpu_isar_feature(jazelle, cpu));
             set_feature(env, ARM_FEATURE_AUXCR);
         }
     }
@@ -1082,11 +1082,16 @@ static void arm926_initfn(Object *obj)
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
+    cpu->isar.id_isar1 = FIELD_DP32(cpu->isar.id_isar1, ID_ISAR1, JAZELLE, 1);
 }
 
 static void arm946_initfn(Object *obj)
@@ -1112,12 +1117,18 @@ static void arm1026_initfn(Object *obj)
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
+    cpu->isar.id_isar1 = FIELD_DP32(cpu->isar.id_isar1, ID_ISAR1, JAZELLE, 1);
+
     {
         /* The 1026 had an IFAR at c6,c0,0,1 rather than the ARMv6 c6,c0,0,2 */
         ARMCPRegInfo ifar = {
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 8b2be71439..e56b5cdff7 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -42,7 +42,7 @@
 #define ENABLE_ARCH_5     arm_dc_feature(s, ARM_FEATURE_V5)
 /* currently all emulated v5 cores are also v5TE, so don't bother */
 #define ENABLE_ARCH_5TE   arm_dc_feature(s, ARM_FEATURE_V5)
-#define ENABLE_ARCH_5J    arm_dc_feature(s, ARM_FEATURE_JAZELLE)
+#define ENABLE_ARCH_5J    dc_isar_feature(jazelle, s)
 #define ENABLE_ARCH_6     arm_dc_feature(s, ARM_FEATURE_V6)
 #define ENABLE_ARCH_6K    arm_dc_feature(s, ARM_FEATURE_V6K)
 #define ENABLE_ARCH_6T2   arm_dc_feature(s, ARM_FEATURE_THUMB2)
-- 
2.17.2
