Received: from eggs.gnu.org ([2001:4830:134:3::10]:40942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz9W-0005sk-Tc
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:24:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz9V-000869-EU
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:24:34 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:38645)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQz9V-00084h-6T
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:24:33 -0500
Received: by mail-pg0-x244.google.com with SMTP id f12so9409693pgo.5
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:24:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:24:17 -0800
Message-Id: <20171218172425.18200-4-richard.henderson@linaro.org>
In-Reply-To: <20171218172425.18200-1-richard.henderson@linaro.org>
References: <20171218172425.18200-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 03/11] target/arm: Decode aa64 armv8.1 three
 same extra
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h         |  9 +++++
 target/arm/advsimd_helper.c | 74 ++++++++++++++++++++++++++++++++++++++++
 target/arm/translate-a64.c  | 83 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 166 insertions(+)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index d103f3d8bf..06ca458614 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -558,6 +558,15 @@ DEF_HELPER_2(dc_zva, void, env, i64)
 DEF_HELPER_FLAGS_2(neon_pmull_64_lo, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(neon_pmull_64_hi, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 
+DEF_HELPER_FLAGS_5(gvec_qrdmlah_s16, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_qrdmlsh_s16, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_qrdmlah_s32, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_qrdmlsh_s32, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
 #ifdef TARGET_AARCH64
 #include "helper-a64.h"
 #endif
diff --git a/target/arm/advsimd_helper.c b/target/arm/advsimd_helper.c
index b91d181741..d5185165a5 100644
--- a/target/arm/advsimd_helper.c
+++ b/target/arm/advsimd_helper.c
@@ -26,6 +26,16 @@
 
 #define SET_QC() env->vfp.xregs[ARM_VFP_FPSCR] |= CPSR_Q
 
+static void clear_tail(void *vd, uintptr_t opr_sz, uintptr_t max_sz)
+{
+    uint64_t *d = vd + opr_sz;
+    uintptr_t i;
+
+    for (i = opr_sz; i < max_sz; i += 8) {
+        *d++ = 0;
+    }
+}
+
 /* Signed saturating rounding doubling multiply-accumulate high half, 16-bit */
 static uint16_t inl_qrdmlah_s16(CPUARMState *env, int16_t src1,
                                 int16_t src2, int16_t src3)
@@ -52,6 +62,22 @@ uint32_t HELPER(neon_qrdmlah_s16)(CPUARMState *env, uint32_t src1,
     return deposit32(e1, 16, 16, e2);
 }
 
+void HELPER(gvec_qrdmlah_s16)(void *vd, void *vn, void *vm,
+                              void *ve, uint32_t desc)
+{
+    uintptr_t opr_sz = simd_oprsz(desc);
+    int16_t *d = vd;
+    int16_t *n = vn;
+    int16_t *m = vm;
+    CPUARMState *env = ve;
+    uintptr_t i;
+
+    for (i = 0; i < opr_sz / 2; ++i) {
+        d[i] = inl_qrdmlah_s16(env, n[i], m[i], d[i]);
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
 /* Signed saturating rounding doubling multiply-subtract high half, 16-bit */
 static uint16_t inl_qrdmlsh_s16(CPUARMState *env, int16_t src1,
                                 int16_t src2, int16_t src3)
@@ -78,6 +104,22 @@ uint32_t HELPER(neon_qrdmlsh_s16)(CPUARMState *env, uint32_t src1,
     return deposit32(e1, 16, 16, e2);
 }
 
+void HELPER(gvec_qrdmlsh_s16)(void *vd, void *vn, void *vm,
+                              void *ve, uint32_t desc)
+{
+    uintptr_t opr_sz = simd_oprsz(desc);
+    int16_t *d = vd;
+    int16_t *n = vn;
+    int16_t *m = vm;
+    CPUARMState *env = ve;
+    uintptr_t i;
+
+    for (i = 0; i < opr_sz / 2; ++i) {
+        d[i] = inl_qrdmlsh_s16(env, n[i], m[i], d[i]);
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
 /* Signed saturating rounding doubling multiply-accumulate high half, 32-bit */
 uint32_t HELPER(neon_qrdmlah_s32)(CPUARMState *env, int32_t src1,
                                   int32_t src2, int32_t src3)
@@ -93,6 +135,22 @@ uint32_t HELPER(neon_qrdmlah_s32)(CPUARMState *env, int32_t src1,
     return ret;
 }
 
+void HELPER(gvec_qrdmlah_s32)(void *vd, void *vn, void *vm,
+                              void *ve, uint32_t desc)
+{
+    uintptr_t opr_sz = simd_oprsz(desc);
+    int32_t *d = vd;
+    int32_t *n = vn;
+    int32_t *m = vm;
+    CPUARMState *env = ve;
+    uintptr_t i;
+
+    for (i = 0; i < opr_sz / 4; ++i) {
+        d[i] = helper_neon_qrdmlah_s32(env, n[i], m[i], d[i]);
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
 /* Signed saturating rounding doubling multiply-subtract high half, 32-bit */
 uint32_t HELPER(neon_qrdmlsh_s32)(CPUARMState *env, int32_t src1,
                                   int32_t src2, int32_t src3)
@@ -107,3 +165,19 @@ uint32_t HELPER(neon_qrdmlsh_s32)(CPUARMState *env, int32_t src1,
     }
     return ret;
 }
+
+void HELPER(gvec_qrdmlsh_s32)(void *vd, void *vn, void *vm,
+                              void *ve, uint32_t desc)
+{
+    uintptr_t opr_sz = simd_oprsz(desc);
+    int32_t *d = vd;
+    int32_t *n = vn;
+    int32_t *m = vm;
+    CPUARMState *env = ve;
+    uintptr_t i;
+
+    for (i = 0; i < opr_sz / 4; ++i) {
+        d[i] = helper_neon_qrdmlsh_s32(env, n[i], m[i], d[i]);
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 0b090fe086..3836e94135 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10678,7 +10678,89 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
         /* non-quad vector op */
         clear_vec_high(s, rd);
     }
+}
+
+/* AdvSIMD three same extra
+ *  31   30  29 28       24 23  22  21 20  16  15 14    11  10 9  5 4  0
+ * +---+---+---+-----------+------+---+------+---+--------+---+----+----+
+ * | 0 | Q | U | 0 1 1 1 0 | size | 0 |  Rm  | 1 | opcode | 1 | Rn | Rd |
+ * +---+---+---+-----------+------+---+------+---+--------+---+----+----+
+ */
+static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
+{
+    void (*fn_gvec_ptr)(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_i32);
+    int rd = extract32(insn, 0, 5);
+    int rn = extract32(insn, 5, 5);
+    int opcode = extract32(insn, 11, 4);
+    int rm = extract32(insn, 16, 5);
+    int size = extract32(insn, 22, 2);
+    bool u = extract32(insn, 29, 1);
+    bool is_q = extract32(insn, 30, 1);
+    int feature;
+
+    if (!u) {
+        unallocated_encoding(s);
+        return;
+    }
+
+    switch (opcode) {
+    case 0x0: /* SQRDMLAH (vector) */
+    case 0x1: /* SQRDMLSH (vector) */
+        if (size != 1 && size != 2) {
+            unallocated_encoding(s);
+            return;
+        }
+        feature = ARM_FEATURE_V8_1_SIMD;
+        break;
+    default:
+        unallocated_encoding(s);
+        return;
+    }
+
+    if (!arm_dc_feature(s, feature)) {
+        unallocated_encoding(s);
+        return;
+    }
+    if (!fp_access_check(s)) {
+        return;
+    }
+
+    switch (opcode) {
+    case 0x0: /* SQRDMLAH (vector) */
+        switch (size) {
+        case 1:
+            fn_gvec_ptr = gen_helper_gvec_qrdmlah_s16;
+            break;
+        case 2:
+            fn_gvec_ptr = gen_helper_gvec_qrdmlah_s32;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        goto do_env;
+
+    case 0x1: /* SQRDMLSH (vector) */
+        switch (size) {
+        case 1:
+            fn_gvec_ptr = gen_helper_gvec_qrdmlsh_s16;
+            break;
+        case 2:
+            fn_gvec_ptr = gen_helper_gvec_qrdmlsh_s32;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    do_env:
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
+                           vec_full_reg_offset(s, rn),
+                           vec_full_reg_offset(s, rm), cpu_env,
+                           is_q ? 16 : 8, vec_full_reg_size(s),
+                           0, fn_gvec_ptr);
+        break;
 
+    default:
+        g_assert_not_reached();
+    }
 }
 
 static void handle_2misc_widening(DisasContext *s, int opcode, bool is_q,
@@ -12421,6 +12503,7 @@ static void disas_crypto_two_reg_sha(DisasContext *s, uint32_t insn)
 static const AArch64DecodeTable data_proc_simd[] = {
     /* pattern  ,  mask     ,  fn                        */
     { 0x0e200400, 0x9f200400, disas_simd_three_reg_same },
+    { 0x0e008400, 0x9f208400, disas_simd_three_reg_same_extra },
     { 0x0e200000, 0x9f200c00, disas_simd_three_reg_diff },
     { 0x0e200800, 0x9f3e0c00, disas_simd_two_reg_misc },
     { 0x0e300800, 0x9f3e0c00, disas_simd_across_lanes },
-- 
2.14.3
