Received: from eggs.gnu.org ([2001:4830:134:3::10]:40571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en7A5-0001IC-LM
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en7A3-00021Q-VE
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:37 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:34489)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en7A3-000214-NV
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:35 -0500
Received: by mail-pg0-x243.google.com with SMTP id m19so4360482pgn.1
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 10:24:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 10:22:59 -0800
Message-Id: <20180217182323.25885-44-richard.henderson@linaro.org>
In-Reply-To: <20180217182323.25885-1-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 43/67] target/arm: Implement SVE Floating
 Point Arithmetic - Unpredicated Group
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
 target/arm/helper-sve.h    | 14 +++++++
 target/arm/helper.h        | 19 ++++++++++
 target/arm/translate-sve.c | 41 ++++++++++++++++++++
 target/arm/vec_helper.c    | 94 ++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/Makefile.objs   |  2 +-
 target/arm/sve.decode      | 10 +++++
 6 files changed, 179 insertions(+), 1 deletion(-)
 create mode 100644 target/arm/vec_helper.c

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 97bfe0f47b..2e76084992 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -705,3 +705,17 @@ DEF_HELPER_FLAGS_4(sve_umini_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(sve_umini_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(sve_umini_s, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(sve_umini_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
+DEF_HELPER_FLAGS_5(gvec_recps_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_recps_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_recps_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_rsqrts_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_rsqrts_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_rsqrts_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/helper.h b/target/arm/helper.h
index be3c2fcdc0..f3ce58e276 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -565,6 +565,25 @@ DEF_HELPER_2(dc_zva, void, env, i64)
 DEF_HELPER_FLAGS_2(neon_pmull_64_lo, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(neon_pmull_64_hi, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 
+DEF_HELPER_FLAGS_5(gvec_fadd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fadd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fadd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fsub_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fsub_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fsub_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fmul_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmul_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmul_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_ftsmul_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_ftsmul_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_ftsmul_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
 #ifdef TARGET_AARCH64
 #include "helper-a64.h"
 #include "helper-sve.h"
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 72abcb543a..f9a3ad1434 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3109,6 +3109,47 @@ DO_ZZI(UMIN, umin)
 
 #undef DO_ZZI
 
+/*
+ *** SVE Floating Point Arithmetic - Unpredicated Group
+ */
+
+static void do_zzz_fp(DisasContext *s, arg_rrr_esz *a,
+                      gen_helper_gvec_3_ptr *fn)
+{
+    unsigned vsz = vec_full_reg_size(s);
+    TCGv_ptr status;
+
+    if (fn == NULL) {
+        unallocated_encoding(s);
+        return;
+    }
+    status = get_fpstatus_ptr(a->esz == MO_16);
+    tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
+                       vec_full_reg_offset(s, a->rn),
+                       vec_full_reg_offset(s, a->rm),
+                       status, vsz, vsz, 0, fn);
+}
+
+
+#define DO_FP3(NAME, name) \
+static void trans_##NAME(DisasContext *s, arg_rrr_esz *a, uint32_t insn) \
+{                                                                   \
+    static gen_helper_gvec_3_ptr * const fns[4] = {                 \
+        NULL, gen_helper_gvec_##name##_h,                           \
+        gen_helper_gvec_##name##_s, gen_helper_gvec_##name##_d      \
+    };                                                              \
+    do_zzz_fp(s, a, fns[a->esz]);                                   \
+}
+
+DO_FP3(FADD_zzz, fadd)
+DO_FP3(FSUB_zzz, fsub)
+DO_FP3(FMUL_zzz, fmul)
+DO_FP3(FTSMUL, ftsmul)
+DO_FP3(FRECPS, recps)
+DO_FP3(FRSQRTS, rsqrts)
+
+#undef DO_FP3
+
 /*
  *** SVE Memory - 32-bit Gather and Unsized Contiguous Group
  */
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
new file mode 100644
index 0000000000..ad5c29cdd5
--- /dev/null
+++ b/target/arm/vec_helper.c
@@ -0,0 +1,94 @@
+/*
+ * ARM Shared AdvSIMD / SVE Operations
+ *
+ * Copyright (c) 2018 Linaro
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "exec/helper-proto.h"
+#include "tcg/tcg-gvec-desc.h"
+#include "fpu/softfloat.h"
+
+
+/* Floating-point trigonometric starting value.
+ * See the ARM ARM pseudocode function FPTrigSMul.
+ */
+static float16 float16_ftsmul(float16 op1, uint16_t op2, float_status *stat)
+{
+    float16 result = float16_mul(op1, op1, stat);
+    if (!float16_is_any_nan(result)) {
+        result = float16_set_sign(result, op2 & 1);
+    }
+    return result;
+}
+
+static float32 float32_ftsmul(float32 op1, uint32_t op2, float_status *stat)
+{
+    float32 result = float32_mul(op1, op1, stat);
+    if (!float32_is_any_nan(result)) {
+        result = float32_set_sign(result, op2 & 1);
+    }
+    return result;
+}
+
+static float64 float64_ftsmul(float64 op1, uint64_t op2, float_status *stat)
+{
+    float64 result = float64_mul(op1, op1, stat);
+    if (!float64_is_any_nan(result)) {
+        result = float64_set_sign(result, op2 & 1);
+    }
+    return result;
+}
+
+#define DO_3OP(NAME, FUNC, TYPE) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, void *stat, uint32_t desc) \
+{                                                                          \
+    intptr_t i, oprsz = simd_oprsz(desc);                                  \
+    TYPE *d = vd, *n = vn, *m = vm;                                        \
+    for (i = 0; i < oprsz / sizeof(TYPE); i++) {                           \
+        d[i] = FUNC(n[i], m[i], stat);                                     \
+    }                                                                      \
+}
+
+DO_3OP(gvec_fadd_h, float16_add, float16)
+DO_3OP(gvec_fadd_s, float32_add, float32)
+DO_3OP(gvec_fadd_d, float64_add, float64)
+
+DO_3OP(gvec_fsub_h, float16_sub, float16)
+DO_3OP(gvec_fsub_s, float32_sub, float32)
+DO_3OP(gvec_fsub_d, float64_sub, float64)
+
+DO_3OP(gvec_fmul_h, float16_mul, float16)
+DO_3OP(gvec_fmul_s, float32_mul, float32)
+DO_3OP(gvec_fmul_d, float64_mul, float64)
+
+DO_3OP(gvec_ftsmul_h, float16_ftsmul, float16)
+DO_3OP(gvec_ftsmul_s, float32_ftsmul, float32)
+DO_3OP(gvec_ftsmul_d, float64_ftsmul, float64)
+
+#ifdef TARGET_AARCH64
+
+DO_3OP(gvec_recps_h, helper_recpsf_f16, float16)
+DO_3OP(gvec_recps_s, helper_recpsf_f32, float32)
+DO_3OP(gvec_recps_d, helper_recpsf_f64, float64)
+
+DO_3OP(gvec_rsqrts_h, helper_rsqrtsf_f16, float16)
+DO_3OP(gvec_rsqrts_s, helper_rsqrtsf_f32, float32)
+DO_3OP(gvec_rsqrts_d, helper_rsqrtsf_f64, float64)
+
+#endif
+#undef DO_3OP
diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index 452ac6f453..50a521876d 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -8,7 +8,7 @@ obj-y += translate.o op_helper.o helper.o cpu.o
 obj-y += neon_helper.o iwmmxt_helper.o
 obj-y += gdbstub.o
 obj-$(TARGET_AARCH64) += cpu64.o translate-a64.o helper-a64.o gdbstub64.o
-obj-y += crypto_helper.o
+obj-y += crypto_helper.o vec_helper.o
 obj-$(CONFIG_SOFTMMU) += arm-powerctl.o
 
 DECODETREE = $(SRC_PATH)/scripts/decodetree.py
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 1ede152360..42d14994a1 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -656,6 +656,16 @@ UMIN_zzi	00100101 .. 101 011 110 ........ .....		@rdn_i8u
 # SVE integer multiply immediate (unpredicated)
 MUL_zzi		00100101 .. 110 000 110 ........ .....		@rdn_i8s
 
+### SVE Floating Point Arithmetic - Unpredicated Group
+
+# SVE floating-point arithmetic (unpredicated)
+FADD_zzz	01100101 .. 0 ..... 000 000 ..... .....		@rd_rn_rm
+FSUB_zzz	01100101 .. 0 ..... 000 001 ..... .....		@rd_rn_rm
+FMUL_zzz	01100101 .. 0 ..... 000 010 ..... .....		@rd_rn_rm
+FTSMUL		01100101 .. 0 ..... 000 011 ..... .....		@rd_rn_rm
+FRECPS		01100101 .. 0 ..... 000 110 ..... .....		@rd_rn_rm
+FRSQRTS		01100101 .. 0 ..... 000 111 ..... .....		@rd_rn_rm
+
 ### SVE Memory - 32-bit Gather and Unsized Contiguous Group
 
 # SVE load predicate register
-- 
2.14.3
