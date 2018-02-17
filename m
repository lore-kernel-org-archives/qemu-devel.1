Received: from eggs.gnu.org ([2001:4830:134:3::10]:40710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en7AF-0001SM-Ko
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en7AD-00027L-U8
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:47 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:45436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en7AD-000276-MH
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:45 -0500
Received: by mail-pl0-x243.google.com with SMTP id p5so3428969plo.12
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 10:24:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 10:23:05 -0800
Message-Id: <20180217182323.25885-50-richard.henderson@linaro.org>
In-Reply-To: <20180217182323.25885-1-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 49/67] target/arm: Implement SVE FP
 Multiply-Add Group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    | 16 ++++++++++++++
 target/arm/sve_helper.c    | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 41 +++++++++++++++++++++++++++++++++++
 target/arm/sve.decode      | 17 +++++++++++++++
 4 files changed, 127 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 84d0a8978c..a95f077c7f 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -827,6 +827,22 @@ DEF_HELPER_FLAGS_5(sve_ucvt_ds, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(sve_ucvt_dd, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_3(sve_fmla_zpzzz_h, TCG_CALL_NO_RWG, void, env, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_fmla_zpzzz_s, TCG_CALL_NO_RWG, void, env, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_fmla_zpzzz_d, TCG_CALL_NO_RWG, void, env, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sve_fmls_zpzzz_h, TCG_CALL_NO_RWG, void, env, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_fmls_zpzzz_s, TCG_CALL_NO_RWG, void, env, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_fmls_zpzzz_d, TCG_CALL_NO_RWG, void, env, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sve_fnmla_zpzzz_h, TCG_CALL_NO_RWG, void, env, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_fnmla_zpzzz_s, TCG_CALL_NO_RWG, void, env, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_fnmla_zpzzz_d, TCG_CALL_NO_RWG, void, env, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sve_fnmls_zpzzz_h, TCG_CALL_NO_RWG, void, env, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_fnmls_zpzzz_s, TCG_CALL_NO_RWG, void, env, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_fnmls_zpzzz_d, TCG_CALL_NO_RWG, void, env, ptr, i32)
+
 DEF_HELPER_FLAGS_4(sve_ld1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld2bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld3bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index d80babfae7..6622275b44 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -2948,6 +2948,59 @@ DO_ZPZ_FP_D(sve_ucvt_dd, uint64_t, uint64_to_float64)
 #undef DO_ZPZ_FP
 #undef DO_ZPZ_FP_D
 
+/* 4-operand predicated multiply-add.  This requires 7 operands to pass
+ * "properly", so we need to encode some of the registers into DESC.
+ */
+QEMU_BUILD_BUG_ON(SIMD_DATA_SHIFT + 20 > 32);
+
+#define DO_FMLA(NAME, N, H, NEG1, NEG3)                                     \
+void HELPER(NAME)(CPUARMState *env, void *vg, uint32_t desc)                \
+{                                                                           \
+    intptr_t i = 0, opr_sz = simd_oprsz(desc);                              \
+    unsigned rd = extract32(desc, SIMD_DATA_SHIFT, 5);                      \
+    unsigned rn = extract32(desc, SIMD_DATA_SHIFT + 5, 5);                  \
+    unsigned rm = extract32(desc, SIMD_DATA_SHIFT + 10, 5);                 \
+    unsigned ra = extract32(desc, SIMD_DATA_SHIFT + 15, 5);                 \
+    void *vd = &env->vfp.zregs[rd];                                         \
+    void *vn = &env->vfp.zregs[rn];                                         \
+    void *vm = &env->vfp.zregs[rm];                                         \
+    void *va = &env->vfp.zregs[ra];                                         \
+    do {                                                                    \
+        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));                     \
+        do {                                                                \
+            if (likely(pg & 1)) {                                           \
+                float##N e1 = *(uint##N##_t *)(vn + H(i));                  \
+                float##N e2 = *(uint##N##_t *)(vm + H(i));                  \
+                float##N e3 = *(uint##N##_t *)(va + H(i));                  \
+                float##N r;                                                 \
+                if (NEG1) e1 = float##N##_chs(e1);                          \
+                if (NEG3) e3 = float##N##_chs(e3);                          \
+                r = float##N##_muladd(e1, e2, e3, 0, &env->vfp.fp_status);  \
+                *(uint##N##_t *)(vd + H(i)) = r;                            \
+            }                                                               \
+            i += sizeof(float##N), pg >>= sizeof(float##N);                 \
+        } while (i & 15);                                                   \
+    } while (i < opr_sz);                                                   \
+}
+
+DO_FMLA(sve_fmla_zpzzz_h, 16, H1_2, 0, 0)
+DO_FMLA(sve_fmla_zpzzz_s, 32, H1_4, 0, 0)
+DO_FMLA(sve_fmla_zpzzz_d, 64, , 0, 0)
+
+DO_FMLA(sve_fmls_zpzzz_h, 16, H1_2, 0, 1)
+DO_FMLA(sve_fmls_zpzzz_s, 32, H1_4, 0, 1)
+DO_FMLA(sve_fmls_zpzzz_d, 64, , 0, 1)
+
+DO_FMLA(sve_fnmla_zpzzz_h, 16, H1_2, 1, 0)
+DO_FMLA(sve_fnmla_zpzzz_s, 32, H1_4, 1, 0)
+DO_FMLA(sve_fnmla_zpzzz_d, 64, , 1, 0)
+
+DO_FMLA(sve_fnmls_zpzzz_h, 16, H1_2, 1, 1)
+DO_FMLA(sve_fnmls_zpzzz_s, 32, H1_4, 1, 1)
+DO_FMLA(sve_fnmls_zpzzz_d, 64, , 1, 1)
+
+#undef DO_FMLA
+
 /*
  * Load contiguous data, protected by a governing predicate.
  */
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 1692980d20..3124368fb5 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3208,6 +3208,47 @@ DO_FP3(FMULX, fmulx)
 
 #undef DO_FP3
 
+typedef void gen_helper_sve_fmla(TCGv_env, TCGv_ptr, TCGv_i32);
+
+static void do_fmla(DisasContext *s, arg_rprrr_esz *a, gen_helper_sve_fmla *fn)
+{
+    unsigned vsz = vec_full_reg_size(s);
+    unsigned desc;
+    TCGv_i32 t_desc;
+    TCGv_ptr pg = tcg_temp_new_ptr();
+
+    /* We would need 7 operands to pass these arguments "properly".
+     * So we encode all the register numbers into the descriptor.
+     */
+    desc = deposit32(a->rd, 5, 5, a->rn);
+    desc = deposit32(desc, 10, 5, a->rm);
+    desc = deposit32(desc, 15, 5, a->ra);
+    desc = simd_desc(vsz, vsz, desc);
+
+    t_desc = tcg_const_i32(desc);
+    tcg_gen_addi_ptr(pg, cpu_env, pred_full_reg_offset(s, a->pg));
+    fn(cpu_env, pg, t_desc);
+    tcg_temp_free_i32(t_desc);
+    tcg_temp_free_ptr(pg);
+}
+
+#define DO_FMLA(NAME, name) \
+static void trans_##NAME(DisasContext *s, arg_rprrr_esz *a, uint32_t insn) \
+{                                                                    \
+    static gen_helper_sve_fmla * const fns[4] = {                    \
+        NULL, gen_helper_sve_##name##_h,                             \
+        gen_helper_sve_##name##_s, gen_helper_sve_##name##_d         \
+    };                                                               \
+    do_fmla(s, a, fns[a->esz]);                                      \
+}
+
+DO_FMLA(FMLA_zpzzz, fmla_zpzzz)
+DO_FMLA(FMLS_zpzzz, fmls_zpzzz)
+DO_FMLA(FNMLA_zpzzz, fnmla_zpzzz)
+DO_FMLA(FNMLS_zpzzz, fnmls_zpzzz)
+
+#undef DO_FMLA
+
 /*
  *** SVE Floating Point Unary Operations Prediated Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 1a13c603ff..817833f96e 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -129,6 +129,8 @@
 		&rprrr_esz ra=%reg_movprfx
 @rdn_pg_ra_rm	........ esz:2 . rm:5  ... pg:3 ra:5 rd:5 \
 		&rprrr_esz rn=%reg_movprfx
+@rdn_pg_rm_ra	........ esz:2 . ra:5  ... pg:3 rm:5 rd:5 \
+		&rprrr_esz rn=%reg_movprfx
 
 # One register operand, with governing predicate, vector element size
 @rd_pg_rn	........ esz:2 ... ... ... pg:3 rn:5 rd:5	&rpr_esz
@@ -709,6 +711,21 @@ FMULX		01100101 .. 00 1010 100 ... ..... .....    @rdn_pg_rm
 FDIV		01100101 .. 00 1100 100 ... ..... .....    @rdm_pg_rn # FDIVR
 FDIV		01100101 .. 00 1101 100 ... ..... .....    @rdn_pg_rm
 
+### SVE FP Multiply-Add Group
+
+# SVE floating-point multiply-accumulate writing addend
+FMLA_zpzzz	01100101 .. 1 ..... 000 ... ..... .....		@rda_pg_rn_rm
+FMLS_zpzzz	01100101 .. 1 ..... 001 ... ..... .....		@rda_pg_rn_rm
+FNMLA_zpzzz	01100101 .. 1 ..... 010 ... ..... .....		@rda_pg_rn_rm
+FNMLS_zpzzz	01100101 .. 1 ..... 011 ... ..... .....		@rda_pg_rn_rm
+
+# SVE floating-point multiply-accumulate writing multiplicand
+# FMAD, FMSB, FNMAD, FNMS
+FMLA_zpzzz	01100101 .. 1 ..... 100 ... ..... .....		@rdn_pg_rm_ra
+FMLS_zpzzz	01100101 .. 1 ..... 101 ... ..... .....		@rdn_pg_rm_ra
+FNMLA_zpzzz	01100101 .. 1 ..... 110 ... ..... .....		@rdn_pg_rm_ra
+FNMLS_zpzzz	01100101 .. 1 ..... 111 ... ..... .....		@rdn_pg_rm_ra
+
 ### SVE FP Unary Operations Predicated Group
 
 # SVE integer convert to floating-point
-- 
2.14.3
