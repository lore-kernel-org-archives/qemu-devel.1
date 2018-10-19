Received: from eggs.gnu.org ([2001:4830:134:3::10]:47490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY5r-0001Pg-1b
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:57:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY5p-0001vU-Pl
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:57:46 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gDY5p-0001uO-H1
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:57:45 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY5o-0006gt-Ks
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 17:57:44 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 17:56:57 +0100
Message-Id: <20181019165735.22511-8-peter.maydell@linaro.org>
In-Reply-To: <20181019165735.22511-1-peter.maydell@linaro.org>
References: <20181019165735.22511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/45] target/arm: Convert jazelle from feature
 bit to isar1 test
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

Having V6 alone imply jazelle was wrong for cortex-m0.
Change to an assertion for V6 & !M.

This was harmless, because the only place we tested ARM_FEATURE_JAZELLE
was for 'bxj' in disas_arm(), which is unreachable for M-profile cores.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181016223115.24100-6-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h       |  6 +++++-
 target/arm/cpu.c       | 17 ++++++++++++++---
 target/arm/translate.c |  2 +-
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index f1c2ec64616..1683ee98d60 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1593,7 +1593,6 @@ enum arm_features {
     ARM_FEATURE_PMU, /* has PMU support */
     ARM_FEATURE_VBAR, /* has cp15 VBAR */
     ARM_FEATURE_M_SECURITY, /* M profile Security Extension */
-    ARM_FEATURE_JAZELLE, /* has (trivial) Jazelle implementation */
     ARM_FEATURE_SVE, /* has Scalable Vector Extension */
     ARM_FEATURE_V8_FP16, /* implements v8.2 half-precision float */
     ARM_FEATURE_M_MAIN, /* M profile Main Extension */
@@ -3160,6 +3159,11 @@ static inline bool isar_feature_arm_div(const ARMISARegisters *id)
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
index 9319f92f1f3..8f16e96b6c8 100644
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
index 8b2be714390..e56b5cdff77 100644
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
2.19.1
