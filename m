Received: from eggs.gnu.org ([2001:4830:134:3::10]:60244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY29K-00048P-Th
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:33:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY29G-0000EJ-RU
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:33:46 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:38912)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fY29G-0000Co-Gj
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:33:42 -0400
Received: by mail-pf0-x242.google.com with SMTP id s21-v6so384551pfm.6
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 21:33:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 26 Jun 2018 21:33:00 -0700
Message-Id: <20180627043328.11531-8-richard.henderson@linaro.org>
In-Reply-To: <20180627043328.11531-1-richard.henderson@linaro.org>
References: <20180627043328.11531-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 07/35] target/arm: Implement SVE FP
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
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

---
v6: Add some decode commentary.
---
 target/arm/helper-sve.h    |  16 ++++
 target/arm/sve_helper.c    | 158 +++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c |  49 ++++++++++++
 target/arm/sve.decode      |  18 +++++
 4 files changed, 241 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 4097b55f0e..eb0645dd43 100644
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
index 3401662397..2f416e5e28 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -2938,6 +2938,164 @@ DO_ZPZ_FP(sve_ucvt_dd, uint64_t,     , uint64_to_float64)
 
 #undef DO_ZPZ_FP
 
+/* 4-operand predicated multiply-add.  This requires 7 operands to pass
+ * "properly", so we need to encode some of the registers into DESC.
+ */
+QEMU_BUILD_BUG_ON(SIMD_DATA_SHIFT + 20 > 32);
+
+static void do_fmla_zpzzz_h(CPUARMState *env, void *vg, uint32_t desc,
+                            uint16_t neg1, uint16_t neg3)
+{
+    intptr_t i = simd_oprsz(desc);
+    unsigned rd = extract32(desc, SIMD_DATA_SHIFT, 5);
+    unsigned rn = extract32(desc, SIMD_DATA_SHIFT + 5, 5);
+    unsigned rm = extract32(desc, SIMD_DATA_SHIFT + 10, 5);
+    unsigned ra = extract32(desc, SIMD_DATA_SHIFT + 15, 5);
+    void *vd = &env->vfp.zregs[rd];
+    void *vn = &env->vfp.zregs[rn];
+    void *vm = &env->vfp.zregs[rm];
+    void *va = &env->vfp.zregs[ra];
+    uint64_t *g = vg;
+
+    do {
+        uint64_t pg = g[(i - 1) >> 6];
+        do {
+            i -= 2;
+            if (likely((pg >> (i & 63)) & 1)) {
+                float16 e1, e2, e3, r;
+
+                e1 = *(uint16_t *)(vn + H1_2(i)) ^ neg1;
+                e2 = *(uint16_t *)(vm + H1_2(i));
+                e3 = *(uint16_t *)(va + H1_2(i)) ^ neg3;
+                r = float16_muladd(e1, e2, e3, 0, &env->vfp.fp_status);
+                *(uint16_t *)(vd + H1_2(i)) = r;
+            }
+        } while (i & 63);
+    } while (i != 0);
+}
+
+void HELPER(sve_fmla_zpzzz_h)(CPUARMState *env, void *vg, uint32_t desc)
+{
+    do_fmla_zpzzz_h(env, vg, desc, 0, 0);
+}
+
+void HELPER(sve_fmls_zpzzz_h)(CPUARMState *env, void *vg, uint32_t desc)
+{
+    do_fmla_zpzzz_h(env, vg, desc, 0x8000, 0);
+}
+
+void HELPER(sve_fnmla_zpzzz_h)(CPUARMState *env, void *vg, uint32_t desc)
+{
+    do_fmla_zpzzz_h(env, vg, desc, 0x8000, 0x8000);
+}
+
+void HELPER(sve_fnmls_zpzzz_h)(CPUARMState *env, void *vg, uint32_t desc)
+{
+    do_fmla_zpzzz_h(env, vg, desc, 0, 0x8000);
+}
+
+static void do_fmla_zpzzz_s(CPUARMState *env, void *vg, uint32_t desc,
+                            uint32_t neg1, uint32_t neg3)
+{
+    intptr_t i = simd_oprsz(desc);
+    unsigned rd = extract32(desc, SIMD_DATA_SHIFT, 5);
+    unsigned rn = extract32(desc, SIMD_DATA_SHIFT + 5, 5);
+    unsigned rm = extract32(desc, SIMD_DATA_SHIFT + 10, 5);
+    unsigned ra = extract32(desc, SIMD_DATA_SHIFT + 15, 5);
+    void *vd = &env->vfp.zregs[rd];
+    void *vn = &env->vfp.zregs[rn];
+    void *vm = &env->vfp.zregs[rm];
+    void *va = &env->vfp.zregs[ra];
+    uint64_t *g = vg;
+
+    do {
+        uint64_t pg = g[(i - 1) >> 6];
+        do {
+            i -= 4;
+            if (likely((pg >> (i & 63)) & 1)) {
+                float32 e1, e2, e3, r;
+
+                e1 = *(uint32_t *)(vn + H1_4(i)) ^ neg1;
+                e2 = *(uint32_t *)(vm + H1_4(i));
+                e3 = *(uint32_t *)(va + H1_4(i)) ^ neg3;
+                r = float32_muladd(e1, e2, e3, 0, &env->vfp.fp_status);
+                *(uint32_t *)(vd + H1_4(i)) = r;
+            }
+        } while (i & 63);
+    } while (i != 0);
+}
+
+void HELPER(sve_fmla_zpzzz_s)(CPUARMState *env, void *vg, uint32_t desc)
+{
+    do_fmla_zpzzz_s(env, vg, desc, 0, 0);
+}
+
+void HELPER(sve_fmls_zpzzz_s)(CPUARMState *env, void *vg, uint32_t desc)
+{
+    do_fmla_zpzzz_s(env, vg, desc, 0x80000000, 0);
+}
+
+void HELPER(sve_fnmla_zpzzz_s)(CPUARMState *env, void *vg, uint32_t desc)
+{
+    do_fmla_zpzzz_s(env, vg, desc, 0x80000000, 0x80000000);
+}
+
+void HELPER(sve_fnmls_zpzzz_s)(CPUARMState *env, void *vg, uint32_t desc)
+{
+    do_fmla_zpzzz_s(env, vg, desc, 0, 0x80000000);
+}
+
+static void do_fmla_zpzzz_d(CPUARMState *env, void *vg, uint32_t desc,
+                            uint64_t neg1, uint64_t neg3)
+{
+    intptr_t i = simd_oprsz(desc);
+    unsigned rd = extract32(desc, SIMD_DATA_SHIFT, 5);
+    unsigned rn = extract32(desc, SIMD_DATA_SHIFT + 5, 5);
+    unsigned rm = extract32(desc, SIMD_DATA_SHIFT + 10, 5);
+    unsigned ra = extract32(desc, SIMD_DATA_SHIFT + 15, 5);
+    void *vd = &env->vfp.zregs[rd];
+    void *vn = &env->vfp.zregs[rn];
+    void *vm = &env->vfp.zregs[rm];
+    void *va = &env->vfp.zregs[ra];
+    uint64_t *g = vg;
+
+    do {
+        uint64_t pg = g[(i - 1) >> 6];
+        do {
+            i -= 8;
+            if (likely((pg >> (i & 63)) & 1)) {
+                float64 e1, e2, e3, r;
+
+                e1 = *(uint64_t *)(vn + i) ^ neg1;
+                e2 = *(uint64_t *)(vm + i);
+                e3 = *(uint64_t *)(va + i) ^ neg3;
+                r = float64_muladd(e1, e2, e3, 0, &env->vfp.fp_status);
+                *(uint64_t *)(vd + i) = r;
+            }
+        } while (i & 63);
+    } while (i != 0);
+}
+
+void HELPER(sve_fmla_zpzzz_d)(CPUARMState *env, void *vg, uint32_t desc)
+{
+    do_fmla_zpzzz_d(env, vg, desc, 0, 0);
+}
+
+void HELPER(sve_fmls_zpzzz_d)(CPUARMState *env, void *vg, uint32_t desc)
+{
+    do_fmla_zpzzz_d(env, vg, desc, INT64_MIN, 0);
+}
+
+void HELPER(sve_fnmla_zpzzz_d)(CPUARMState *env, void *vg, uint32_t desc)
+{
+    do_fmla_zpzzz_d(env, vg, desc, INT64_MIN, INT64_MIN);
+}
+
+void HELPER(sve_fnmls_zpzzz_d)(CPUARMState *env, void *vg, uint32_t desc)
+{
+    do_fmla_zpzzz_d(env, vg, desc, 0, INT64_MIN);
+}
+
 /*
  * Load contiguous data, protected by a governing predicate.
  */
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 4df5360da9..acad6374ef 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3472,6 +3472,55 @@ DO_FP3(FMULX, fmulx)
 
 #undef DO_FP3
 
+typedef void gen_helper_sve_fmla(TCGv_env, TCGv_ptr, TCGv_i32);
+
+static bool do_fmla(DisasContext *s, arg_rprrr_esz *a, gen_helper_sve_fmla *fn)
+{
+    if (fn == NULL) {
+        return false;
+    }
+    if (!sve_access_check(s)) {
+        return true;
+    }
+
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
+    return true;
+}
+
+#define DO_FMLA(NAME, name) \
+static bool trans_##NAME(DisasContext *s, arg_rprrr_esz *a, uint32_t insn) \
+{                                                                    \
+    static gen_helper_sve_fmla * const fns[4] = {                    \
+        NULL, gen_helper_sve_##name##_h,                             \
+        gen_helper_sve_##name##_s, gen_helper_sve_##name##_d         \
+    };                                                               \
+    return do_fmla(s, a, fns[a->esz]);                               \
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
index 636212a638..e8531e28cd 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -128,6 +128,8 @@
                 &rprrr_esz ra=%reg_movprfx
 @rdn_pg_ra_rm   ........ esz:2 . rm:5  ... pg:3 ra:5 rd:5 \
                 &rprrr_esz rn=%reg_movprfx
+@rdn_pg_rm_ra   ........ esz:2 . ra:5  ... pg:3 rm:5 rd:5 \
+                &rprrr_esz rn=%reg_movprfx
 
 # One register operand, with governing predicate, vector element size
 @rd_pg_rn       ........ esz:2 ... ... ... pg:3 rn:5 rd:5       &rpr_esz
@@ -701,6 +703,22 @@ FMULX           01100101 .. 00 1010 100 ... ..... .....    @rdn_pg_rm
 FDIV            01100101 .. 00 1100 100 ... ..... .....    @rdm_pg_rn # FDIVR
 FDIV            01100101 .. 00 1101 100 ... ..... .....    @rdn_pg_rm
 
+### SVE FP Multiply-Add Group
+
+# SVE floating-point multiply-accumulate writing addend
+FMLA_zpzzz      01100101 .. 1 ..... 000 ... ..... .....         @rda_pg_rn_rm
+FMLS_zpzzz      01100101 .. 1 ..... 001 ... ..... .....         @rda_pg_rn_rm
+FNMLA_zpzzz     01100101 .. 1 ..... 010 ... ..... .....         @rda_pg_rn_rm
+FNMLS_zpzzz     01100101 .. 1 ..... 011 ... ..... .....         @rda_pg_rn_rm
+
+# SVE floating-point multiply-accumulate writing multiplicand
+# Alter the operand extraction order and reuse the helpers from above.
+# FMAD, FMSB, FNMAD, FNMS
+FMLA_zpzzz      01100101 .. 1 ..... 100 ... ..... .....         @rdn_pg_rm_ra
+FMLS_zpzzz      01100101 .. 1 ..... 101 ... ..... .....         @rdn_pg_rm_ra
+FNMLA_zpzzz     01100101 .. 1 ..... 110 ... ..... .....         @rdn_pg_rm_ra
+FNMLS_zpzzz     01100101 .. 1 ..... 111 ... ..... .....         @rdn_pg_rm_ra
+
 ### SVE FP Unary Operations Predicated Group
 
 # SVE integer convert to floating-point
-- 
2.17.1
