Received: from eggs.gnu.org ([209.51.188.92]:42531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsJUD-00074z-3E
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 22:39:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsJU7-0000at-3l
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 22:39:23 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:45148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gsJU4-0000X3-VR
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 22:39:17 -0500
Received: by mail-pl1-x641.google.com with SMTP id a14so2588494plm.12
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 19:39:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  8 Feb 2019 19:38:46 -0800
Message-Id: <20190209033847.9014-12-richard.henderson@linaro.org>
In-Reply-To: <20190209033847.9014-1-richard.henderson@linaro.org>
References: <20190209033847.9014-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 11/12] target/arm: Use vector operations for
 saturation
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

For same-sign saturation, we have tcg vector operations.  We can
compute the QC bit by comparing the saturated value against the
unsaturated value.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        |  33 +++++++
 target/arm/translate.h     |   4 +
 target/arm/translate-a64.c |  36 ++++----
 target/arm/translate.c     | 172 +++++++++++++++++++++++++++++++------
 target/arm/vec_helper.c    | 130 ++++++++++++++++++++++++++++
 5 files changed, 331 insertions(+), 44 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 9874c35ea9..923e8e1525 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -641,6 +641,39 @@ DEF_HELPER_FLAGS_6(gvec_fmla_idx_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_6(gvec_fmla_idx_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(gvec_uqadd_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_uqadd_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_uqadd_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_uqadd_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_sqadd_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_sqadd_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_sqadd_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_sqadd_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_uqsub_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_uqsub_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_uqsub_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_uqsub_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_sqsub_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_sqsub_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_sqsub_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_sqsub_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
 #ifdef TARGET_AARCH64
 #include "helper-a64.h"
 #include "helper-sve.h"
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 17748ddfb9..f25fe75685 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -214,6 +214,10 @@ extern const GVecGen2i ssra_op[4];
 extern const GVecGen2i usra_op[4];
 extern const GVecGen2i sri_op[4];
 extern const GVecGen2i sli_op[4];
+extern const GVecGen4 uqadd_op[4];
+extern const GVecGen4 sqadd_op[4];
+extern const GVecGen4 uqsub_op[4];
+extern const GVecGen4 sqsub_op[4];
 void gen_cmtst_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
 
 /*
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index fd5ceb6613..af8e4fd4be 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10948,6 +10948,22 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
+    case 0x01: /* SQADD, UQADD */
+        tcg_gen_gvec_4(vec_full_reg_offset(s, rd),
+                       offsetof(CPUARMState, vfp.qc),
+                       vec_full_reg_offset(s, rn),
+                       vec_full_reg_offset(s, rm),
+                       is_q ? 16 : 8, vec_full_reg_size(s),
+                       (u ? uqadd_op : sqadd_op) + size);
+        return;
+    case 0x05: /* SQSUB, UQSUB */
+        tcg_gen_gvec_4(vec_full_reg_offset(s, rd),
+                       offsetof(CPUARMState, vfp.qc),
+                       vec_full_reg_offset(s, rn),
+                       vec_full_reg_offset(s, rm),
+                       is_q ? 16 : 8, vec_full_reg_size(s),
+                       (u ? uqsub_op : sqsub_op) + size);
+        return;
     case 0x0c: /* SMAX, UMAX */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_umax, size);
@@ -11043,16 +11059,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                 genfn = fns[size][u];
                 break;
             }
-            case 0x1: /* SQADD, UQADD */
-            {
-                static NeonGenTwoOpEnvFn * const fns[3][2] = {
-                    { gen_helper_neon_qadd_s8, gen_helper_neon_qadd_u8 },
-                    { gen_helper_neon_qadd_s16, gen_helper_neon_qadd_u16 },
-                    { gen_helper_neon_qadd_s32, gen_helper_neon_qadd_u32 },
-                };
-                genenvfn = fns[size][u];
-                break;
-            }
             case 0x2: /* SRHADD, URHADD */
             {
                 static NeonGenTwoOpFn * const fns[3][2] = {
@@ -11073,16 +11079,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                 genfn = fns[size][u];
                 break;
             }
-            case 0x5: /* SQSUB, UQSUB */
-            {
-                static NeonGenTwoOpEnvFn * const fns[3][2] = {
-                    { gen_helper_neon_qsub_s8, gen_helper_neon_qsub_u8 },
-                    { gen_helper_neon_qsub_s16, gen_helper_neon_qsub_u16 },
-                    { gen_helper_neon_qsub_s32, gen_helper_neon_qsub_u32 },
-                };
-                genenvfn = fns[size][u];
-                break;
-            }
             case 0x8: /* SSHL, USHL */
             {
                 static NeonGenTwoOpFn * const fns[3][2] = {
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 9b426f4271..dac737f6ca 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -6148,6 +6148,142 @@ const GVecGen3 cmtst_op[4] = {
       .vece = MO_64 },
 };
 
+static void gen_uqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
+                          TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec x = tcg_temp_new_vec_matching(t);
+    tcg_gen_add_vec(vece, x, a, b);
+    tcg_gen_usadd_vec(vece, t, a, b);
+    tcg_gen_cmp_vec(TCG_COND_NE, vece, x, x, t);
+    tcg_gen_or_vec(vece, sat, sat, x);
+    tcg_temp_free_vec(x);
+}
+
+const GVecGen4 uqadd_op[4] = {
+    { .fniv = gen_uqadd_vec,
+      .fno = gen_helper_gvec_uqadd_b,
+      .opc = INDEX_op_usadd_vec,
+      .write_aofs = true,
+      .vece = MO_8 },
+    { .fniv = gen_uqadd_vec,
+      .fno = gen_helper_gvec_uqadd_h,
+      .opc = INDEX_op_usadd_vec,
+      .write_aofs = true,
+      .vece = MO_16 },
+    { .fniv = gen_uqadd_vec,
+      .fno = gen_helper_gvec_uqadd_s,
+      .opc = INDEX_op_usadd_vec,
+      .write_aofs = true,
+      .vece = MO_32 },
+    { .fniv = gen_uqadd_vec,
+      .fno = gen_helper_gvec_uqadd_d,
+      .opc = INDEX_op_usadd_vec,
+      .write_aofs = true,
+      .vece = MO_64 },
+};
+
+static void gen_sqadd_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
+                          TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec x = tcg_temp_new_vec_matching(t);
+    tcg_gen_add_vec(vece, x, a, b);
+    tcg_gen_ssadd_vec(vece, t, a, b);
+    tcg_gen_cmp_vec(TCG_COND_NE, vece, x, x, t);
+    tcg_gen_or_vec(vece, sat, sat, x);
+    tcg_temp_free_vec(x);
+}
+
+const GVecGen4 sqadd_op[4] = {
+    { .fniv = gen_sqadd_vec,
+      .fno = gen_helper_gvec_sqadd_b,
+      .opc = INDEX_op_ssadd_vec,
+      .write_aofs = true,
+      .vece = MO_8 },
+    { .fniv = gen_sqadd_vec,
+      .fno = gen_helper_gvec_sqadd_h,
+      .opc = INDEX_op_ssadd_vec,
+      .write_aofs = true,
+      .vece = MO_16 },
+    { .fniv = gen_sqadd_vec,
+      .fno = gen_helper_gvec_sqadd_s,
+      .opc = INDEX_op_ssadd_vec,
+      .write_aofs = true,
+      .vece = MO_32 },
+    { .fniv = gen_sqadd_vec,
+      .fno = gen_helper_gvec_sqadd_d,
+      .opc = INDEX_op_ssadd_vec,
+      .write_aofs = true,
+      .vece = MO_64 },
+};
+
+static void gen_uqsub_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
+                          TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec x = tcg_temp_new_vec_matching(t);
+    tcg_gen_sub_vec(vece, x, a, b);
+    tcg_gen_ussub_vec(vece, t, a, b);
+    tcg_gen_cmp_vec(TCG_COND_NE, vece, x, x, t);
+    tcg_gen_or_vec(vece, sat, sat, x);
+    tcg_temp_free_vec(x);
+}
+
+const GVecGen4 uqsub_op[4] = {
+    { .fniv = gen_uqsub_vec,
+      .fno = gen_helper_gvec_uqsub_b,
+      .opc = INDEX_op_ussub_vec,
+      .write_aofs = true,
+      .vece = MO_8 },
+    { .fniv = gen_uqsub_vec,
+      .fno = gen_helper_gvec_uqsub_h,
+      .opc = INDEX_op_ussub_vec,
+      .write_aofs = true,
+      .vece = MO_16 },
+    { .fniv = gen_uqsub_vec,
+      .fno = gen_helper_gvec_uqsub_s,
+      .opc = INDEX_op_ussub_vec,
+      .write_aofs = true,
+      .vece = MO_32 },
+    { .fniv = gen_uqsub_vec,
+      .fno = gen_helper_gvec_uqsub_d,
+      .opc = INDEX_op_ussub_vec,
+      .write_aofs = true,
+      .vece = MO_64 },
+};
+
+static void gen_sqsub_vec(unsigned vece, TCGv_vec t, TCGv_vec sat,
+                          TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec x = tcg_temp_new_vec_matching(t);
+    tcg_gen_sub_vec(vece, x, a, b);
+    tcg_gen_sssub_vec(vece, t, a, b);
+    tcg_gen_cmp_vec(TCG_COND_NE, vece, x, x, t);
+    tcg_gen_or_vec(vece, sat, sat, x);
+    tcg_temp_free_vec(x);
+}
+
+const GVecGen4 sqsub_op[4] = {
+    { .fniv = gen_sqsub_vec,
+      .fno = gen_helper_gvec_sqsub_b,
+      .opc = INDEX_op_sssub_vec,
+      .write_aofs = true,
+      .vece = MO_8 },
+    { .fniv = gen_sqsub_vec,
+      .fno = gen_helper_gvec_sqsub_h,
+      .opc = INDEX_op_sssub_vec,
+      .write_aofs = true,
+      .vece = MO_16 },
+    { .fniv = gen_sqsub_vec,
+      .fno = gen_helper_gvec_sqsub_s,
+      .opc = INDEX_op_sssub_vec,
+      .write_aofs = true,
+      .vece = MO_32 },
+    { .fniv = gen_sqsub_vec,
+      .fno = gen_helper_gvec_sqsub_d,
+      .opc = INDEX_op_sssub_vec,
+      .write_aofs = true,
+      .vece = MO_64 },
+};
+
 /* Translate a NEON data processing instruction.  Return nonzero if the
    instruction is invalid.
    We process data in a mixture of 32-bit and 64-bit chunks.
@@ -6331,6 +6467,18 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             }
             return 0;
 
+        case NEON_3R_VQADD:
+            tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
+                           rn_ofs, rm_ofs, vec_size, vec_size,
+                           (u ? uqadd_op : sqadd_op) + size);
+            break;
+
+        case NEON_3R_VQSUB:
+            tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
+                           rn_ofs, rm_ofs, vec_size, vec_size,
+                           (u ? uqsub_op : sqsub_op) + size);
+            break;
+
         case NEON_3R_VMUL: /* VMUL */
             if (u) {
                 /* Polynomial case allows only P8 and is handled below.  */
@@ -6395,24 +6543,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 neon_load_reg64(cpu_V0, rn + pass);
                 neon_load_reg64(cpu_V1, rm + pass);
                 switch (op) {
-                case NEON_3R_VQADD:
-                    if (u) {
-                        gen_helper_neon_qadd_u64(cpu_V0, cpu_env,
-                                                 cpu_V0, cpu_V1);
-                    } else {
-                        gen_helper_neon_qadd_s64(cpu_V0, cpu_env,
-                                                 cpu_V0, cpu_V1);
-                    }
-                    break;
-                case NEON_3R_VQSUB:
-                    if (u) {
-                        gen_helper_neon_qsub_u64(cpu_V0, cpu_env,
-                                                 cpu_V0, cpu_V1);
-                    } else {
-                        gen_helper_neon_qsub_s64(cpu_V0, cpu_env,
-                                                 cpu_V0, cpu_V1);
-                    }
-                    break;
                 case NEON_3R_VSHL:
                     if (u) {
                         gen_helper_neon_shl_u64(cpu_V0, cpu_V1, cpu_V0);
@@ -6528,18 +6658,12 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_VHADD:
             GEN_NEON_INTEGER_OP(hadd);
             break;
-        case NEON_3R_VQADD:
-            GEN_NEON_INTEGER_OP_ENV(qadd);
-            break;
         case NEON_3R_VRHADD:
             GEN_NEON_INTEGER_OP(rhadd);
             break;
         case NEON_3R_VHSUB:
             GEN_NEON_INTEGER_OP(hsub);
             break;
-        case NEON_3R_VQSUB:
-            GEN_NEON_INTEGER_OP_ENV(qsub);
-            break;
         case NEON_3R_VSHL:
             GEN_NEON_INTEGER_OP(shl);
             break;
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 65a18af4e0..10f17e4b5c 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -766,3 +766,133 @@ DO_FMLA_IDX(gvec_fmla_idx_s, float32, H4)
 DO_FMLA_IDX(gvec_fmla_idx_d, float64, )
 
 #undef DO_FMLA_IDX
+
+#define DO_SAT(NAME, WTYPE, TYPEN, TYPEM, OP, MIN, MAX) \
+void HELPER(NAME)(void *vd, void *vq, void *vn, void *vm, uint32_t desc)   \
+{                                                                          \
+    intptr_t i, oprsz = simd_oprsz(desc);                                  \
+    TYPEN *d = vd, *n = vn; TYPEM *m = vm;                                 \
+    bool q = false;                                                        \
+    for (i = 0; i < oprsz / sizeof(TYPEN); i++) {                          \
+        WTYPE dd = (WTYPE)n[i] OP m[i];                                    \
+        if (dd < MIN) {                                                    \
+            dd = MIN;                                                      \
+            q = true;                                                      \
+        } else if (dd > MAX) {                                             \
+            dd = MAX;                                                      \
+            q = true;                                                      \
+        }                                                                  \
+        d[i] = dd;                                                         \
+    }                                                                      \
+    if (q) {                                                               \
+        uint32_t *qc = vq;                                                 \
+        qc[0] = 1;                                                         \
+    }                                                                      \
+    clear_tail(d, oprsz, simd_maxsz(desc));                                \
+}
+
+DO_SAT(gvec_uqadd_b, int, uint8_t, uint8_t, +, 0, UINT8_MAX)
+DO_SAT(gvec_uqadd_h, int, uint16_t, uint16_t, +, 0, UINT16_MAX)
+DO_SAT(gvec_uqadd_s, int64_t, uint32_t, uint32_t, +, 0, UINT32_MAX)
+
+DO_SAT(gvec_sqadd_b, int, int8_t, int8_t, +, INT8_MIN, INT8_MAX)
+DO_SAT(gvec_sqadd_h, int, int16_t, int16_t, +, INT16_MIN, INT16_MAX)
+DO_SAT(gvec_sqadd_s, int64_t, int32_t, int32_t, +, INT32_MIN, INT32_MAX)
+
+DO_SAT(gvec_uqsub_b, int, uint8_t, uint8_t, -, 0, UINT8_MAX)
+DO_SAT(gvec_uqsub_h, int, uint16_t, uint16_t, -, 0, UINT16_MAX)
+DO_SAT(gvec_uqsub_s, int64_t, uint32_t, uint32_t, -, 0, UINT32_MAX)
+
+DO_SAT(gvec_sqsub_b, int, int8_t, int8_t, -, INT8_MIN, INT8_MAX)
+DO_SAT(gvec_sqsub_h, int, int16_t, int16_t, -, INT16_MIN, INT16_MAX)
+DO_SAT(gvec_sqsub_s, int64_t, int32_t, int32_t, -, INT32_MIN, INT32_MAX)
+
+#undef DO_SAT
+
+void HELPER(gvec_uqadd_d)(void *vd, void *vq, void *vn,
+                          void *vm, uint32_t desc)
+{
+    intptr_t i, oprsz = simd_oprsz(desc);
+    uint64_t *d = vd, *n = vn, *m = vm;
+    bool q = false;
+
+    for (i = 0; i < oprsz / 8; i++) {
+        uint64_t nn = n[i], mm = m[i], dd = nn + mm;
+        if (dd < nn) {
+            dd = UINT64_MAX;
+            q = true;
+        }
+        d[i] = dd;
+    }
+    if (q) {
+        uint32_t *qc = vq;
+        qc[0] = 1;
+    }
+    clear_tail(d, oprsz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_uqsub_d)(void *vd, void *vq, void *vn,
+                          void *vm, uint32_t desc)
+{
+    intptr_t i, oprsz = simd_oprsz(desc);
+    uint64_t *d = vd, *n = vn, *m = vm;
+    bool q = false;
+
+    for (i = 0; i < oprsz / 8; i++) {
+        uint64_t nn = n[i], mm = m[i], dd = nn - mm;
+        if (nn < mm) {
+            dd = 0;
+            q = true;
+        }
+        d[i] = dd;
+    }
+    if (q) {
+        uint32_t *qc = vq;
+        qc[0] = 1;
+    }
+    clear_tail(d, oprsz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_sqadd_d)(void *vd, void *vq, void *vn,
+                          void *vm, uint32_t desc)
+{
+    intptr_t i, oprsz = simd_oprsz(desc);
+    int64_t *d = vd, *n = vn, *m = vm;
+    bool q = false;
+
+    for (i = 0; i < oprsz / 8; i++) {
+        int64_t nn = n[i], mm = m[i], dd = nn + mm;
+        if (((dd ^ nn) & ~(nn ^ mm)) & INT64_MIN) {
+            dd = (nn >> 63) ^ ~INT64_MIN;
+            q = true;
+        }
+        d[i] = dd;
+    }
+    if (q) {
+        uint32_t *qc = vq;
+        qc[0] = 1;
+    }
+    clear_tail(d, oprsz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_sqsub_d)(void *vd, void *vq, void *vn,
+                          void *vm, uint32_t desc)
+{
+    intptr_t i, oprsz = simd_oprsz(desc);
+    int64_t *d = vd, *n = vn, *m = vm;
+    bool q = false;
+
+    for (i = 0; i < oprsz / 8; i++) {
+        int64_t nn = n[i], mm = m[i], dd = nn - mm;
+        if (((dd ^ nn) & (nn ^ mm)) & INT64_MIN) {
+            dd = (nn >> 63) ^ ~INT64_MIN;
+            q = true;
+        }
+        d[i] = dd;
+    }
+    if (q) {
+        uint32_t *qc = vq;
+        qc[0] = 1;
+    }
+    clear_tail(d, oprsz, simd_maxsz(desc));
+}
-- 
2.17.2
