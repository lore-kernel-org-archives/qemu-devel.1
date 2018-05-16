Received: from eggs.gnu.org ([2001:4830:134:3::10]:41450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJ4wX-0007wB-5J
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:30:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJ4wU-0007j8-OH
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:30:45 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:45740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fJ4wU-0007iP-FV
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:30:42 -0400
Received: by mail-pg0-x243.google.com with SMTP id w3-v6so886312pgv.12
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 15:30:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 16 May 2018 15:30:02 -0700
Message-Id: <20180516223007.10256-23-richard.henderson@linaro.org>
In-Reply-To: <20180516223007.10256-1-richard.henderson@linaro.org>
References: <20180516223007.10256-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3-a 22/27] target/arm: Implement SVE Element
 Count Group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    |  11 ++
 target/arm/sve_helper.c    | 136 ++++++++++++++++++
 target/arm/translate-sve.c | 288 +++++++++++++++++++++++++++++++++++++
 target/arm/sve.decode      |  31 +++-
 4 files changed, 465 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 4f1bd5a62f..2831e1643b 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -393,6 +393,17 @@ DEF_HELPER_FLAGS_4(sve_ftssel_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_ftssel_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_ftssel_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve_sqaddi_b, TCG_CALL_NO_RWG, void, ptr, ptr, s32, i32)
+DEF_HELPER_FLAGS_4(sve_sqaddi_h, TCG_CALL_NO_RWG, void, ptr, ptr, s32, i32)
+DEF_HELPER_FLAGS_4(sve_sqaddi_s, TCG_CALL_NO_RWG, void, ptr, ptr, s64, i32)
+DEF_HELPER_FLAGS_4(sve_sqaddi_d, TCG_CALL_NO_RWG, void, ptr, ptr, s64, i32)
+
+DEF_HELPER_FLAGS_4(sve_uqaddi_b, TCG_CALL_NO_RWG, void, ptr, ptr, s32, i32)
+DEF_HELPER_FLAGS_4(sve_uqaddi_h, TCG_CALL_NO_RWG, void, ptr, ptr, s32, i32)
+DEF_HELPER_FLAGS_4(sve_uqaddi_s, TCG_CALL_NO_RWG, void, ptr, ptr, s64, i32)
+DEF_HELPER_FLAGS_4(sve_uqaddi_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(sve_uqsubi_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
 DEF_HELPER_FLAGS_5(sve_and_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_bic_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_eor_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 85a0639e3a..979aa5c409 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1235,3 +1235,139 @@ void HELPER(sve_ftssel_d)(void *vd, void *vn, void *vm, uint32_t desc)
         d[i] = nn ^ (mm & 2) << 62;
     }
 }
+
+/*
+ * Signed saturating addition with scalar operand.
+ */
+
+void HELPER(sve_sqaddi_b)(void *d, void *a, int32_t b, uint32_t desc)
+{
+    intptr_t i, oprsz = simd_oprsz(desc);
+
+    for (i = 0; i < oprsz; i += sizeof(int8_t)) {
+        int r = *(int8_t *)(a + i) + b;
+        if (r > INT8_MAX) {
+            r = INT8_MAX;
+        } else if (r < INT8_MIN) {
+            r = INT8_MIN;
+        }
+        *(int8_t *)(d + i) = r;
+    }
+}
+
+void HELPER(sve_sqaddi_h)(void *d, void *a, int32_t b, uint32_t desc)
+{
+    intptr_t i, oprsz = simd_oprsz(desc);
+
+    for (i = 0; i < oprsz; i += sizeof(int16_t)) {
+        int r = *(int16_t *)(a + i) + b;
+        if (r > INT16_MAX) {
+            r = INT16_MAX;
+        } else if (r < INT16_MIN) {
+            r = INT16_MIN;
+        }
+        *(int16_t *)(d + i) = r;
+    }
+}
+
+void HELPER(sve_sqaddi_s)(void *d, void *a, int64_t b, uint32_t desc)
+{
+    intptr_t i, oprsz = simd_oprsz(desc);
+
+    for (i = 0; i < oprsz; i += sizeof(int32_t)) {
+        int64_t r = *(int32_t *)(a + i) + b;
+        if (r > INT32_MAX) {
+            r = INT32_MAX;
+        } else if (r < INT32_MIN) {
+            r = INT32_MIN;
+        }
+        *(int32_t *)(d + i) = r;
+    }
+}
+
+void HELPER(sve_sqaddi_d)(void *d, void *a, int64_t b, uint32_t desc)
+{
+    intptr_t i, oprsz = simd_oprsz(desc);
+
+    for (i = 0; i < oprsz; i += sizeof(int64_t)) {
+        int64_t ai = *(int64_t *)(a + i);
+        int64_t r = ai + b;
+        if (((r ^ ai) & ~(ai ^ b)) < 0) {
+            /* Signed overflow.  */
+            r = (r < 0 ? INT64_MAX : INT64_MIN);
+        }
+        *(int64_t *)(d + i) = r;
+    }
+}
+
+/*
+ * Unsigned saturating addition with scalar operand.
+ */
+
+void HELPER(sve_uqaddi_b)(void *d, void *a, int32_t b, uint32_t desc)
+{
+    intptr_t i, oprsz = simd_oprsz(desc);
+
+    for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
+        int r = *(uint8_t *)(a + i) + b;
+        if (r > UINT8_MAX) {
+            r = UINT8_MAX;
+        } else if (r < 0) {
+            r = 0;
+        }
+        *(uint8_t *)(d + i) = r;
+    }
+}
+
+void HELPER(sve_uqaddi_h)(void *d, void *a, int32_t b, uint32_t desc)
+{
+    intptr_t i, oprsz = simd_oprsz(desc);
+
+    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
+        int r = *(uint16_t *)(a + i) + b;
+        if (r > UINT16_MAX) {
+            r = UINT16_MAX;
+        } else if (r < 0) {
+            r = 0;
+        }
+        *(uint16_t *)(d + i) = r;
+    }
+}
+
+void HELPER(sve_uqaddi_s)(void *d, void *a, int64_t b, uint32_t desc)
+{
+    intptr_t i, oprsz = simd_oprsz(desc);
+
+    for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
+        int64_t r = *(uint32_t *)(a + i) + b;
+        if (r > UINT32_MAX) {
+            r = UINT32_MAX;
+        } else if (r < 0) {
+            r = 0;
+        }
+        *(uint32_t *)(d + i) = r;
+    }
+}
+
+void HELPER(sve_uqaddi_d)(void *d, void *a, uint64_t b, uint32_t desc)
+{
+    intptr_t i, oprsz = simd_oprsz(desc);
+
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        uint64_t r = *(uint64_t *)(a + i) + b;
+        if (r < b) {
+            r = UINT64_MAX;
+        }
+        *(uint64_t *)(d + i) = r;
+    }
+}
+
+void HELPER(sve_uqsubi_d)(void *d, void *a, uint64_t b, uint32_t desc)
+{
+    intptr_t i, oprsz = simd_oprsz(desc);
+
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        uint64_t ai = *(uint64_t *)(a + i);
+        *(uint64_t *)(d + i) = (ai < b ? 0 : ai - b);
+    }
+}
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index ea8d2c4112..2a0bf6b47c 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -57,6 +57,11 @@ static int tszimm_shl(int x)
     return x - (8 << tszimm_esz(x));
 }
 
+static inline int plus1(int x)
+{
+    return x + 1;
+}
+
 /*
  * Include the generated decoder.
  */
@@ -1497,6 +1502,289 @@ static bool trans_PNEXT(DisasContext *s, arg_rr_esz *a, uint32_t insn)
     return do_pfirst_pnext(s, a, gen_helper_sve_pnext);
 }
 
+/*
+ *** SVE Element Count Group
+ */
+
+/* Perform an inline saturating addition of a 32-bit value within
+ * a 64-bit register.  The second operand is known to be positive,
+ * which halves the comparisions we must perform to bound the result.
+ */
+static void do_sat_addsub_32(TCGv_i64 reg, TCGv_i64 val, bool u, bool d)
+{
+    int64_t ibound;
+    TCGv_i64 bound;
+    TCGCond cond;
+
+    /* Use normal 64-bit arithmetic to detect 32-bit overflow.  */
+    if (u) {
+        tcg_gen_ext32u_i64(reg, reg);
+    } else {
+        tcg_gen_ext32s_i64(reg, reg);
+    }
+    if (d) {
+        tcg_gen_sub_i64(reg, reg, val);
+        ibound = (u ? 0 : INT32_MIN);
+        cond = TCG_COND_LT;
+    } else {
+        tcg_gen_add_i64(reg, reg, val);
+        ibound = (u ? UINT32_MAX : INT32_MAX);
+        cond = TCG_COND_GT;
+    }
+    bound = tcg_const_i64(ibound);
+    tcg_gen_movcond_i64(cond, reg, reg, bound, bound, reg);
+    tcg_temp_free_i64(bound);
+}
+
+/* Similarly with 64-bit values.  */
+static void do_sat_addsub_64(TCGv_i64 reg, TCGv_i64 val, bool u, bool d)
+{
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i64 t2;
+
+    if (u) {
+        if (d) {
+            tcg_gen_sub_i64(t0, reg, val);
+            tcg_gen_movi_i64(t1, 0);
+            tcg_gen_movcond_i64(TCG_COND_LTU, reg, reg, val, t1, t0);
+        } else {
+            tcg_gen_add_i64(t0, reg, val);
+            tcg_gen_movi_i64(t1, -1);
+            tcg_gen_movcond_i64(TCG_COND_LTU, reg, t0, reg, t1, t0);
+        }
+    } else {
+        if (d) {
+            /* Detect signed overflow for subtraction.  */
+            tcg_gen_xor_i64(t0, reg, val);
+            tcg_gen_sub_i64(t1, reg, val);
+            tcg_gen_xor_i64(reg, reg, t0);
+            tcg_gen_and_i64(t0, t0, reg);
+
+            /* Bound the result.  */
+            tcg_gen_movi_i64(reg, INT64_MIN);
+            t2 = tcg_const_i64(0);
+            tcg_gen_movcond_i64(TCG_COND_LT, reg, t0, t2, reg, t1);
+        } else {
+            /* Detect signed overflow for addition.  */
+            tcg_gen_xor_i64(t0, reg, val);
+            tcg_gen_add_i64(reg, reg, val);
+            tcg_gen_xor_i64(t1, reg, val);
+            tcg_gen_andc_i64(t0, t1, t0);
+
+            /* Bound the result.  */
+            tcg_gen_movi_i64(t1, INT64_MAX);
+            t2 = tcg_const_i64(0);
+            tcg_gen_movcond_i64(TCG_COND_LT, reg, t0, t2, t1, reg);
+        }
+        tcg_temp_free_i64(t2);
+    }
+    tcg_temp_free_i64(t0);
+    tcg_temp_free_i64(t1);
+}
+
+/* Similarly with a vector and a scalar operand.  */
+static void do_sat_addsub_vec(DisasContext *s, int esz, int rd, int rn,
+                              TCGv_i64 val, bool u, bool d)
+{
+    unsigned vsz = vec_full_reg_size(s);
+    TCGv_ptr dptr, nptr;
+    TCGv_i32 t32, desc;
+    TCGv_i64 t64;
+
+    dptr = tcg_temp_new_ptr();
+    nptr = tcg_temp_new_ptr();
+    tcg_gen_addi_ptr(dptr, cpu_env, vec_full_reg_offset(s, rd));
+    tcg_gen_addi_ptr(nptr, cpu_env, vec_full_reg_offset(s, rn));
+    desc = tcg_const_i32(simd_desc(vsz, vsz, 0));
+
+    switch (esz) {
+    case MO_8:
+        t32 = tcg_temp_new_i32();
+        tcg_gen_extrl_i64_i32(t32, val);
+        if (d) {
+            tcg_gen_neg_i32(t32, t32);
+        }
+        if (u) {
+            gen_helper_sve_uqaddi_b(dptr, nptr, t32, desc);
+        } else {
+            gen_helper_sve_sqaddi_b(dptr, nptr, t32, desc);
+        }
+        tcg_temp_free_i32(t32);
+        break;
+
+    case MO_16:
+        t32 = tcg_temp_new_i32();
+        tcg_gen_extrl_i64_i32(t32, val);
+        if (d) {
+            tcg_gen_neg_i32(t32, t32);
+        }
+        if (u) {
+            gen_helper_sve_uqaddi_h(dptr, nptr, t32, desc);
+        } else {
+            gen_helper_sve_sqaddi_h(dptr, nptr, t32, desc);
+        }
+        tcg_temp_free_i32(t32);
+        break;
+
+    case MO_32:
+        t64 = tcg_temp_new_i64();
+        if (d) {
+            tcg_gen_neg_i64(t64, val);
+        } else {
+            tcg_gen_mov_i64(t64, val);
+        }
+        if (u) {
+            gen_helper_sve_uqaddi_s(dptr, nptr, t64, desc);
+        } else {
+            gen_helper_sve_sqaddi_s(dptr, nptr, t64, desc);
+        }
+        tcg_temp_free_i64(t64);
+        break;
+
+    case MO_64:
+        if (u) {
+            if (d) {
+                gen_helper_sve_uqsubi_d(dptr, nptr, val, desc);
+            } else {
+                gen_helper_sve_uqaddi_d(dptr, nptr, val, desc);
+            }
+        } else if (d) {
+            t64 = tcg_temp_new_i64();
+            tcg_gen_neg_i64(t64, val);
+            gen_helper_sve_sqaddi_d(dptr, nptr, t64, desc);
+            tcg_temp_free_i64(t64);
+        } else {
+            gen_helper_sve_sqaddi_d(dptr, nptr, val, desc);
+        }
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+
+    tcg_temp_free_ptr(dptr);
+    tcg_temp_free_ptr(nptr);
+    tcg_temp_free_i32(desc);
+}
+
+static bool trans_CNT_r(DisasContext *s, arg_CNT_r *a, uint32_t insn)
+{
+    if (sve_access_check(s)) {
+        unsigned fullsz = vec_full_reg_size(s);
+        unsigned numelem = decode_pred_count(fullsz, a->pat, a->esz);
+        tcg_gen_movi_i64(cpu_reg(s, a->rd), numelem * a->imm);
+    }
+    return true;
+}
+
+static bool trans_INCDEC_r(DisasContext *s, arg_incdec_cnt *a, uint32_t insn)
+{
+    if (sve_access_check(s)) {
+        unsigned fullsz = vec_full_reg_size(s);
+        unsigned numelem = decode_pred_count(fullsz, a->pat, a->esz);
+        int inc = numelem * a->imm * (a->d ? -1 : 1);
+        TCGv_i64 reg = cpu_reg(s, a->rd);
+
+        tcg_gen_addi_i64(reg, reg, inc);
+    }
+    return true;
+}
+
+static bool trans_SINCDEC_r_32(DisasContext *s, arg_incdec_cnt *a,
+                               uint32_t insn)
+{
+    if (!sve_access_check(s)) {
+        return true;
+    }
+
+    unsigned fullsz = vec_full_reg_size(s);
+    unsigned numelem = decode_pred_count(fullsz, a->pat, a->esz);
+    int inc = numelem * a->imm;
+    TCGv_i64 reg = cpu_reg(s, a->rd);
+
+    /* Use normal 64-bit arithmetic to detect 32-bit overflow.  */
+    if (inc == 0) {
+        if (a->u) {
+            tcg_gen_ext32u_i64(reg, reg);
+        } else {
+            tcg_gen_ext32s_i64(reg, reg);
+        }
+    } else {
+        TCGv_i64 t = tcg_const_i64(inc);
+        do_sat_addsub_32(reg, t, a->u, a->d);
+        tcg_temp_free_i64(t);
+    }
+    return true;
+}
+
+static bool trans_SINCDEC_r_64(DisasContext *s, arg_incdec_cnt *a,
+                               uint32_t insn)
+{
+    if (!sve_access_check(s)) {
+        return true;
+    }
+
+    unsigned fullsz = vec_full_reg_size(s);
+    unsigned numelem = decode_pred_count(fullsz, a->pat, a->esz);
+    int inc = numelem * a->imm;
+    TCGv_i64 reg = cpu_reg(s, a->rd);
+
+    if (inc != 0) {
+        TCGv_i64 t = tcg_const_i64(inc);
+        do_sat_addsub_64(reg, t, a->u, a->d);
+        tcg_temp_free_i64(t);
+    }
+    return true;
+}
+
+static bool trans_INCDEC_v(DisasContext *s, arg_incdec2_cnt *a, uint32_t insn)
+{
+    if (a->esz == 0) {
+        return false;
+    }
+
+    unsigned fullsz = vec_full_reg_size(s);
+    unsigned numelem = decode_pred_count(fullsz, a->pat, a->esz);
+    int inc = numelem * a->imm;
+
+    if (inc != 0) {
+        if (sve_access_check(s)) {
+            TCGv_i64 t = tcg_const_i64(a->d ? -inc : inc);
+            tcg_gen_gvec_adds(a->esz, vec_full_reg_offset(s, a->rd),
+                              vec_full_reg_offset(s, a->rn),
+                              t, fullsz, fullsz);
+            tcg_temp_free_i64(t);
+        }
+    } else {
+        do_mov_z(s, a->rd, a->rn);
+    }
+    return true;
+}
+
+static bool trans_SINCDEC_v(DisasContext *s, arg_incdec2_cnt *a,
+                            uint32_t insn)
+{
+    if (a->esz == 0) {
+        return false;
+    }
+
+    unsigned fullsz = vec_full_reg_size(s);
+    unsigned numelem = decode_pred_count(fullsz, a->pat, a->esz);
+    int inc = numelem * a->imm;
+
+    if (inc != 0) {
+        if (sve_access_check(s)) {
+            TCGv_i64 t = tcg_const_i64(inc);
+            do_sat_addsub_vec(s, a->esz, a->rd, a->rn, t, a->u, a->d);
+            tcg_temp_free_i64(t);
+        }
+    } else {
+        do_mov_z(s, a->rd, a->rn);
+    }
+    return true;
+}
+
 /*
  *** SVE Memory - 32-bit Gather and Unsized Contiguous Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 224dfdd1e9..b6890d0410 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -22,6 +22,7 @@
 ###########################################################################
 # Named fields.  These are primarily for disjoint fields.
 
+%imm4_16_p1             16:4 !function=plus1
 %imm6_22_5      22:1 5:5
 %imm9_16_10     16:s6 10:3
 
@@ -56,6 +57,9 @@
 &rprr_esz       rd pg rn rm esz
 &rprrr_esz      rd pg rn rm ra esz
 &rpri_esz       rd pg rn imm esz
+&ptrue          rd esz pat s
+&incdec_cnt     rd pat esz imm d u
+&incdec2_cnt    rd rn pat esz imm d u
 
 ###########################################################################
 # Named instruction formats.  These are generally used to
@@ -113,6 +117,13 @@
 @rd_rn_i9       ........ ........ ...... rn:5 rd:5      \
                 &rri imm=%imm9_16_10
 
+# One register, pattern, and uint4+1.
+# User must fill in U and D.
+@incdec_cnt     ........ esz:2 .. .... ...... pat:5 rd:5 \
+                &incdec_cnt imm=%imm4_16_p1
+@incdec2_cnt    ........ esz:2 .. .... ...... pat:5 rd:5 \
+                &incdec2_cnt imm=%imm4_16_p1 rn=%reg_movprfx
+
 ###########################################################################
 # Instruction patterns.  Grouped according to the SVE encodingindex.xhtml.
 
@@ -299,7 +310,25 @@ FEXPA           00000100 .. 1 00000 101110 ..... .....          @rd_rn
 # Note esz != 0
 FTSSEL          00000100 .. 1 ..... 101100 ..... .....          @rd_rn_rm
 
-### SVE Predicate Logical Operations Group
+### SVE Element Count Group
+
+# SVE element count
+CNT_r           00000100 .. 10 .... 1110 0 0 ..... .....    @incdec_cnt d=0 u=1
+
+# SVE inc/dec register by element count
+INCDEC_r        00000100 .. 11 .... 1110 0 d:1 ..... .....      @incdec_cnt u=1
+
+# SVE saturating inc/dec register by element count
+SINCDEC_r_32    00000100 .. 10 .... 1111 d:1 u:1 ..... .....    @incdec_cnt
+SINCDEC_r_64    00000100 .. 11 .... 1111 d:1 u:1 ..... .....    @incdec_cnt
+
+# SVE inc/dec vector by element count
+# Note this requires esz != 0.
+INCDEC_v        00000100 .. 1 1 .... 1100 0 d:1 ..... .....    @incdec2_cnt u=1
+
+# SVE saturating inc/dec vector by element count
+# Note these require esz != 0.
+SINCDEC_v       00000100 .. 1 0 .... 1100 d:1 u:1 ..... .....   @incdec2_cnt
 
 # SVE predicate logical operations
 AND_pppp        00100101 0. 00 .... 01 .... 0 .... 0 ....       @pd_pg_pn_pm_s
-- 
2.17.0
