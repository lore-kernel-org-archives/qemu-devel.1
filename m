Received: from eggs.gnu.org ([2001:4830:134:3::10]:53705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCXsG-0001aY-FI
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 18:31:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCXsD-0005bF-3W
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 18:31:36 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gCXsC-0005ZD-Pj
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 18:31:33 -0400
Received: by mail-pf1-x443.google.com with SMTP id j23-v6so12146039pfi.4
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 15:31:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 16 Oct 2018 15:31:15 -0700
Message-Id: <20181016223115.24100-9-richard.henderson@linaro.org>
In-Reply-To: <20181016223115.24100-1-richard.henderson@linaro.org>
References: <20181016223115.24100-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 8/8] target/arm: Convert v8.2-fp16 from
 feature bit to aa64pfr0 test
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           | 17 +++++++++++++++-
 linux-user/elfload.c       |  6 +-----
 target/arm/cpu64.c         | 16 ++++++++-------
 target/arm/helper.c        |  2 +-
 target/arm/translate-a64.c | 40 +++++++++++++++++++-------------------
 target/arm/translate.c     |  6 +++---
 6 files changed, 50 insertions(+), 37 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 3ebf79745b..b342203d0e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1595,7 +1595,6 @@ enum arm_features {
     ARM_FEATURE_PMU, /* has PMU support */
     ARM_FEATURE_VBAR, /* has cp15 VBAR */
     ARM_FEATURE_M_SECURITY, /* M profile Security Extension */
-    ARM_FEATURE_V8_FP16, /* implements v8.2 half-precision float */
     ARM_FEATURE_M_MAIN, /* M profile Main Extension */
 };
 
@@ -3210,6 +3209,16 @@ static inline bool isar_feature_aa32_dp(const ARMISARegisters *id)
     return FIELD_EX32(id->id_isar6, ID_ISAR6, DP) != 0;
 }
 
+static inline bool isar_feature_aa32_fp16_arith(const ARMISARegisters *id)
+{
+    /*
+     * This is a placeholder for use by VCMA until the rest of
+     * the ARMv8.2-FP16 extension is implemented for aa32 mode.
+     * At which point we can properly set and check MVFR1.FPHP.
+     */
+    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, FP) == 1;
+}
+
 /*
  * 64-bit feature tests via id registers.
  */
@@ -3278,6 +3287,12 @@ static inline bool isar_feature_aa64_fcma(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, FCMA) != 0;
 }
 
+static inline bool isar_feature_aa64_fp16(const ARMISARegisters *id)
+{
+    /* We always set the AdvSIMD and FP fields identically wrt FP16.  */
+    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, FP) == 1;
+}
+
 static inline bool isar_feature_aa64_sve(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, SVE) != 0;
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 64e41fb235..45d6836bb9 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -573,8 +573,6 @@ static uint32_t get_elf_hwcap(void)
     hwcaps |= ARM_HWCAP_A64_ASIMD;
 
     /* probe for the extra features */
-#define GET_FEATURE(feat, hwcap) \
-    do { if (arm_feature(&cpu->env, feat)) { hwcaps |= hwcap; } } while (0)
 #define GET_FEATURE_ID(feat, hwcap) \
     do { if (cpu_isar_feature(feat, cpu)) { hwcaps |= hwcap; } } while (0)
 
@@ -587,15 +585,13 @@ static uint32_t get_elf_hwcap(void)
     GET_FEATURE_ID(aa64_sha3, ARM_HWCAP_A64_SHA3);
     GET_FEATURE_ID(aa64_sm3, ARM_HWCAP_A64_SM3);
     GET_FEATURE_ID(aa64_sm4, ARM_HWCAP_A64_SM4);
-    GET_FEATURE(ARM_FEATURE_V8_FP16,
-                ARM_HWCAP_A64_FPHP | ARM_HWCAP_A64_ASIMDHP);
+    GET_FEATURE_ID(aa64_fp16, ARM_HWCAP_A64_FPHP | ARM_HWCAP_A64_ASIMDHP);
     GET_FEATURE_ID(aa64_atomics, ARM_HWCAP_A64_ATOMICS);
     GET_FEATURE_ID(aa64_rdm, ARM_HWCAP_A64_ASIMDRDM);
     GET_FEATURE_ID(aa64_dp, ARM_HWCAP_A64_ASIMDDP);
     GET_FEATURE_ID(aa64_fcma, ARM_HWCAP_A64_FCMA);
     GET_FEATURE_ID(aa64_sve, ARM_HWCAP_A64_SVE);
 
-#undef GET_FEATURE
 #undef GET_FEATURE_ID
 
     return hwcaps;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 0520a42196..873f059bf2 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -320,6 +320,8 @@ static void aarch64_max_initfn(Object *obj)
 
         t = cpu->isar.id_aa64pfr0;
         t = FIELD_DP64(t, ID_AA64PFR0, SVE, 1);
+        t = FIELD_DP64(t, ID_AA64PFR0, FP, 1);
+        t = FIELD_DP64(t, ID_AA64PFR0, ADVSIMD, 1);
         cpu->isar.id_aa64pfr0 = t;
 
         /* Replicate the same data to the 32-bit id registers.  */
@@ -336,14 +338,14 @@ static void aarch64_max_initfn(Object *obj)
         u = FIELD_DP32(u, ID_ISAR6, DP, 1);
         cpu->isar.id_isar6 = u;
 
-#ifdef CONFIG_USER_ONLY
-        /* We don't set these in system emulation mode for the moment,
-         * since we don't correctly set the ID registers to advertise them,
-         * and in some cases they're only available in AArch64 and not AArch32,
-         * whereas the architecture requires them to be present in both if
-         * present in either.
+        /*
+         * FIXME: We do not yet support ARMv8.2-fp16 for AArch32 yet,
+         * so do not set MVFR1.FPHP.  Strictly speaking this is not legal,
+         * but it is also not legal to enable SVE without support for FP16,
+         * and enabling SVE in system mode is more useful in the short term.
          */
-        set_feature(&cpu->env, ARM_FEATURE_V8_FP16);
+
+#ifdef CONFIG_USER_ONLY
         /* For usermode -cpu max we can use a larger and more efficient DCZ
          * blocksize since we don't have to follow what the hardware does.
          */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0685c9bc93..9a0e92f286 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11612,7 +11612,7 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
     uint32_t changed;
 
     /* When ARMv8.2-FP16 is not supported, FZ16 is RES0.  */
-    if (!arm_feature(env, ARM_FEATURE_V8_FP16)) {
+    if (!cpu_isar_feature(aa64_fp16, arm_env_get_cpu(env))) {
         val &= ~FPCR_FZ16;
     }
 
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 3feb786007..09c7c4af04 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -4805,7 +4805,7 @@ static void disas_fp_compare(DisasContext *s, uint32_t insn)
         break;
     case 3:
         size = MO_16;
-        if (arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
+        if (dc_isar_feature(aa64_fp16, s)) {
             break;
         }
         /* fallthru */
@@ -4856,7 +4856,7 @@ static void disas_fp_ccomp(DisasContext *s, uint32_t insn)
         break;
     case 3:
         size = MO_16;
-        if (arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
+        if (dc_isar_feature(aa64_fp16, s)) {
             break;
         }
         /* fallthru */
@@ -4922,7 +4922,7 @@ static void disas_fp_csel(DisasContext *s, uint32_t insn)
         break;
     case 3:
         sz = MO_16;
-        if (arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
+        if (dc_isar_feature(aa64_fp16, s)) {
             break;
         }
         /* fallthru */
@@ -5255,7 +5255,7 @@ static void disas_fp_1src(DisasContext *s, uint32_t insn)
             handle_fp_1src_double(s, opcode, rd, rn);
             break;
         case 3:
-            if (!arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
+            if (!dc_isar_feature(aa64_fp16, s)) {
                 unallocated_encoding(s);
                 return;
             }
@@ -5470,7 +5470,7 @@ static void disas_fp_2src(DisasContext *s, uint32_t insn)
         handle_fp_2src_double(s, opcode, rd, rn, rm);
         break;
     case 3:
-        if (!arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
+        if (!dc_isar_feature(aa64_fp16, s)) {
             unallocated_encoding(s);
             return;
         }
@@ -5628,7 +5628,7 @@ static void disas_fp_3src(DisasContext *s, uint32_t insn)
         handle_fp_3src_double(s, o0, o1, rd, rn, rm, ra);
         break;
     case 3:
-        if (!arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
+        if (!dc_isar_feature(aa64_fp16, s)) {
             unallocated_encoding(s);
             return;
         }
@@ -5698,7 +5698,7 @@ static void disas_fp_imm(DisasContext *s, uint32_t insn)
         break;
     case 3:
         sz = MO_16;
-        if (arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
+        if (dc_isar_feature(aa64_fp16, s)) {
             break;
         }
         /* fallthru */
@@ -5923,7 +5923,7 @@ static void disas_fp_fixed_conv(DisasContext *s, uint32_t insn)
     case 1: /* float64 */
         break;
     case 3: /* float16 */
-        if (arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
+        if (dc_isar_feature(aa64_fp16, s)) {
             break;
         }
         /* fallthru */
@@ -6053,7 +6053,7 @@ static void disas_fp_int_conv(DisasContext *s, uint32_t insn)
             break;
         case 0x6: /* 16-bit float, 32-bit int */
         case 0xe: /* 16-bit float, 64-bit int */
-            if (arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
+            if (dc_isar_feature(aa64_fp16, s)) {
                 break;
             }
             /* fallthru */
@@ -6080,7 +6080,7 @@ static void disas_fp_int_conv(DisasContext *s, uint32_t insn)
         case 1: /* float64 */
             break;
         case 3: /* float16 */
-            if (arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
+            if (dc_isar_feature(aa64_fp16, s)) {
                 break;
             }
             /* fallthru */
@@ -6517,7 +6517,7 @@ static void disas_simd_across_lanes(DisasContext *s, uint32_t insn)
          */
         is_min = extract32(size, 1, 1);
         is_fp = true;
-        if (!is_u && arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
+        if (!is_u && dc_isar_feature(aa64_fp16, s)) {
             size = 1;
         } else if (!is_u || !is_q || extract32(size, 0, 1)) {
             unallocated_encoding(s);
@@ -6913,7 +6913,7 @@ static void disas_simd_mod_imm(DisasContext *s, uint32_t insn)
 
     if (o2 != 0 || ((cmode == 0xf) && is_neg && !is_q)) {
         /* Check for FMOV (vector, immediate) - half-precision */
-        if (!(arm_dc_feature(s, ARM_FEATURE_V8_FP16) && o2 && cmode == 0xf)) {
+        if (!(dc_isar_feature(aa64_fp16, s) && o2 && cmode == 0xf)) {
             unallocated_encoding(s);
             return;
         }
@@ -7080,7 +7080,7 @@ static void disas_simd_scalar_pairwise(DisasContext *s, uint32_t insn)
     case 0x2f: /* FMINP */
         /* FP op, size[0] is 32 or 64 bit*/
         if (!u) {
-            if (!arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
+            if (!dc_isar_feature(aa64_fp16, s)) {
                 unallocated_encoding(s);
                 return;
             } else {
@@ -7725,7 +7725,7 @@ static void handle_simd_shift_intfp_conv(DisasContext *s, bool is_scalar,
         size = MO_32;
     } else if (immh & 2) {
         size = MO_16;
-        if (!arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
+        if (!dc_isar_feature(aa64_fp16, s)) {
             unallocated_encoding(s);
             return;
         }
@@ -7770,7 +7770,7 @@ static void handle_simd_shift_fpint_conv(DisasContext *s, bool is_scalar,
         size = MO_32;
     } else if (immh & 0x2) {
         size = MO_16;
-        if (!arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
+        if (!dc_isar_feature(aa64_fp16, s)) {
             unallocated_encoding(s);
             return;
         }
@@ -8534,7 +8534,7 @@ static void disas_simd_scalar_three_reg_same_fp16(DisasContext *s,
         return;
     }
 
-    if (!arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
+    if (!dc_isar_feature(aa64_fp16, s)) {
         unallocated_encoding(s);
     }
 
@@ -11215,7 +11215,7 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
     TCGv_ptr fpst;
     bool pairwise = false;
 
-    if (!arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
+    if (!dc_isar_feature(aa64_fp16, s)) {
         unallocated_encoding(s);
         return;
     }
@@ -11430,7 +11430,7 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
     case 0x1c: /* FCADD, #90 */
     case 0x1e: /* FCADD, #270 */
         if (size == 0
-            || (size == 1 && !arm_dc_feature(s, ARM_FEATURE_V8_FP16))
+            || (size == 1 && !dc_isar_feature(aa64_fp16, s))
             || (size == 3 && !is_q)) {
             unallocated_encoding(s);
             return;
@@ -12310,7 +12310,7 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
     bool need_fpst = true;
     int rmode;
 
-    if (!arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
+    if (!dc_isar_feature(aa64_fp16, s)) {
         unallocated_encoding(s);
         return;
     }
@@ -12727,7 +12727,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
         }
         break;
     }
-    if (is_fp16 && !arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
+    if (is_fp16 && !dc_isar_feature(aa64_fp16, s)) {
         unallocated_encoding(s);
         return;
     }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index e56b5cdff7..42dec1f735 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7812,7 +7812,7 @@ static int disas_neon_insn_3same_ext(DisasContext *s, uint32_t insn)
         int size = extract32(insn, 20, 1);
         data = extract32(insn, 23, 2); /* rot */
         if (!dc_isar_feature(aa32_vcma, s)
-            || (!size && !arm_dc_feature(s, ARM_FEATURE_V8_FP16))) {
+            || (!size && !dc_isar_feature(aa32_fp16_arith, s))) {
             return 1;
         }
         fn_gvec_ptr = size ? gen_helper_gvec_fcmlas : gen_helper_gvec_fcmlah;
@@ -7821,7 +7821,7 @@ static int disas_neon_insn_3same_ext(DisasContext *s, uint32_t insn)
         int size = extract32(insn, 20, 1);
         data = extract32(insn, 24, 1); /* rot */
         if (!dc_isar_feature(aa32_vcma, s)
-            || (!size && !arm_dc_feature(s, ARM_FEATURE_V8_FP16))) {
+            || (!size && !dc_isar_feature(aa32_fp16_arith, s))) {
             return 1;
         }
         fn_gvec_ptr = size ? gen_helper_gvec_fcadds : gen_helper_gvec_fcaddh;
@@ -7894,7 +7894,7 @@ static int disas_neon_insn_2reg_scalar_ext(DisasContext *s, uint32_t insn)
             return 1;
         }
         if (size == 0) {
-            if (!arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
+            if (!dc_isar_feature(aa32_fp16_arith, s)) {
                 return 1;
             }
             /* For fp16, rm is just Vm, and index is M.  */
-- 
2.17.2
