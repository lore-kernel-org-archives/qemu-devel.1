Received: from eggs.gnu.org ([209.51.188.92]:36427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzJYu-0001MV-BR
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:09:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzJYt-0003pt-6R
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:09:12 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:39108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzJYs-0003nk-VN
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:09:11 -0500
Received: by mail-wm1-x32b.google.com with SMTP id z84so8494676wmg.4
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 03:09:10 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	c17sm13153241wrs.17.2019.02.28.03.09.07 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 Feb 2019 03:09:08 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Feb 2019 11:08:28 +0000
Message-Id: <20190228110835.16159-10-peter.maydell@linaro.org>
In-Reply-To: <20190228110835.16159-1-peter.maydell@linaro.org>
References: <20190228110835.16159-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/16] target/arm: Use MVFR1 feature bits to
 gate A32/T32 FP16 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Instead of gating the A32/T32 FP16 conversion instructions on
the ARM_FEATURE_VFP_FP16 flag, switch to our new approach of
looking at ID register bits. In this case MVFR1 fields FPHP
and SIMDHP indicate the presence of these insns.

This change doesn't alter behaviour for any of our CPUs.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190222170936.13268-2-peter.maydell@linaro.org
---
 target/arm/cpu.h       | 37 ++++++++++++++++++++++++++++++++++++-
 target/arm/cpu.c       |  2 --
 target/arm/kvm32.c     |  3 ---
 target/arm/translate.c | 26 ++++++++++++++++++--------
 4 files changed, 54 insertions(+), 14 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1eea1a408b8..36ea3b58567 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1730,6 +1730,27 @@ FIELD(ID_DFR0, MPROFDBG, 20, 4)
 FIELD(ID_DFR0, PERFMON, 24, 4)
 FIELD(ID_DFR0, TRACEFILT, 28, 4)
 
+FIELD(MVFR0, SIMDREG, 0, 4)
+FIELD(MVFR0, FPSP, 4, 4)
+FIELD(MVFR0, FPDP, 8, 4)
+FIELD(MVFR0, FPTRAP, 12, 4)
+FIELD(MVFR0, FPDIVIDE, 16, 4)
+FIELD(MVFR0, FPSQRT, 20, 4)
+FIELD(MVFR0, FPSHVEC, 24, 4)
+FIELD(MVFR0, FPROUND, 28, 4)
+
+FIELD(MVFR1, FPFTZ, 0, 4)
+FIELD(MVFR1, FPDNAN, 4, 4)
+FIELD(MVFR1, SIMDLS, 8, 4)
+FIELD(MVFR1, SIMDINT, 12, 4)
+FIELD(MVFR1, SIMDSP, 16, 4)
+FIELD(MVFR1, SIMDHP, 20, 4)
+FIELD(MVFR1, FPHP, 24, 4)
+FIELD(MVFR1, SIMDFMAC, 28, 4)
+
+FIELD(MVFR2, SIMDMISC, 0, 4)
+FIELD(MVFR2, FPMISC, 4, 4)
+
 QEMU_BUILD_BUG_ON(ARRAY_SIZE(((ARMCPU *)0)->ccsidr) <= R_V7M_CSSELR_INDEX_MASK);
 
 /* If adding a feature bit which corresponds to a Linux ELF
@@ -1747,7 +1768,6 @@ enum arm_features {
     ARM_FEATURE_THUMB2,
     ARM_FEATURE_PMSA,   /* no MMU; may have Memory Protection Unit */
     ARM_FEATURE_VFP3,
-    ARM_FEATURE_VFP_FP16,
     ARM_FEATURE_NEON,
     ARM_FEATURE_M, /* Microcontroller profile.  */
     ARM_FEATURE_OMAPCP, /* OMAP specific CP15 ops handling.  */
@@ -3293,6 +3313,21 @@ static inline bool isar_feature_aa32_fp16_arith(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, FP) == 1;
 }
 
+/*
+ * We always set the FP and SIMD FP16 fields to indicate identical
+ * levels of support (assuming SIMD is implemented at all), so
+ * we only need one set of accessors.
+ */
+static inline bool isar_feature_aa32_fp16_spconv(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->mvfr1, MVFR1, FPHP) > 0;
+}
+
+static inline bool isar_feature_aa32_fp16_dpconv(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->mvfr1, MVFR1, FPHP) > 1;
+}
+
 /*
  * 64-bit feature tests via id registers.
  */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 4d7f6a3bc0c..a3baf4eeed1 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1014,7 +1014,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
     if (arm_feature(env, ARM_FEATURE_VFP4)) {
         set_feature(env, ARM_FEATURE_VFP3);
-        set_feature(env, ARM_FEATURE_VFP_FP16);
     }
     if (arm_feature(env, ARM_FEATURE_VFP3)) {
         set_feature(env, ARM_FEATURE_VFP);
@@ -1675,7 +1674,6 @@ static void cortex_a9_initfn(Object *obj)
     cpu->dtb_compatible = "arm,cortex-a9";
     set_feature(&cpu->env, ARM_FEATURE_V7);
     set_feature(&cpu->env, ARM_FEATURE_VFP3);
-    set_feature(&cpu->env, ARM_FEATURE_VFP_FP16);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index a75e04cc8f3..327375f6252 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -125,9 +125,6 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     if (extract32(id_pfr0, 12, 4) == 1) {
         set_feature(&features, ARM_FEATURE_THUMB2EE);
     }
-    if (extract32(ahcf->isar.mvfr1, 20, 4) == 1) {
-        set_feature(&features, ARM_FEATURE_VFP_FP16);
-    }
     if (extract32(ahcf->isar.mvfr1, 12, 4) == 1) {
         set_feature(&features, ARM_FEATURE_NEON);
     }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index c1175798ac9..b7702fb49f7 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3663,17 +3663,27 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                      * UNPREDICTABLE if bit 8 is set prior to ARMv8
                      * (we choose to UNDEF)
                      */
-                    if ((dp && !arm_dc_feature(s, ARM_FEATURE_V8)) ||
-                        !arm_dc_feature(s, ARM_FEATURE_VFP_FP16)) {
-                        return 1;
+                    if (dp) {
+                        if (!dc_isar_feature(aa32_fp16_dpconv, s)) {
+                            return 1;
+                        }
+                    } else {
+                        if (!dc_isar_feature(aa32_fp16_spconv, s)) {
+                            return 1;
+                        }
                     }
                     rm_is_dp = false;
                     break;
                 case 0x06: /* vcvtb.f16.f32, vcvtb.f16.f64 */
                 case 0x07: /* vcvtt.f16.f32, vcvtt.f16.f64 */
-                    if ((dp && !arm_dc_feature(s, ARM_FEATURE_V8)) ||
-                        !arm_dc_feature(s, ARM_FEATURE_VFP_FP16)) {
-                        return 1;
+                    if (dp) {
+                        if (!dc_isar_feature(aa32_fp16_dpconv, s)) {
+                            return 1;
+                        }
+                    } else {
+                        if (!dc_isar_feature(aa32_fp16_spconv, s)) {
+                            return 1;
+                        }
                     }
                     rd_is_dp = false;
                     break;
@@ -7876,7 +7886,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     TCGv_ptr fpst;
                     TCGv_i32 ahp;
 
-                    if (!arm_dc_feature(s, ARM_FEATURE_VFP_FP16) ||
+                    if (!dc_isar_feature(aa32_fp16_spconv, s) ||
                         q || (rm & 1)) {
                         return 1;
                     }
@@ -7908,7 +7918,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 {
                     TCGv_ptr fpst;
                     TCGv_i32 ahp;
-                    if (!arm_dc_feature(s, ARM_FEATURE_VFP_FP16) ||
+                    if (!dc_isar_feature(aa32_fp16_spconv, s) ||
                         q || (rd & 1)) {
                         return 1;
                     }
-- 
2.20.1
