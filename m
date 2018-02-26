Received: from eggs.gnu.org ([2001:4830:134:3::10]:49288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eqR7R-0006E4-FA
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 17:19:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eqR7P-0004yM-DW
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 17:19:37 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:44197)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eqR7P-0004yG-4q
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 17:19:35 -0500
Received: by mail-pl0-x243.google.com with SMTP id w21so10123934plp.11
	for <qemu-devel@nongnu.org>; Mon, 26 Feb 2018 14:19:35 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Tue, 27 Feb 2018 11:17:43 +1300
Message-Id: <1519683480-33201-7-git-send-email-mjc@sifive.com>
In-Reply-To: <1519683480-33201-1-git-send-email-mjc@sifive.com>
References: <1519683480-33201-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v7 06/23] RISC-V FPU Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches <patches@groups.riscv.org>

Helper routines for FPU instructions and NaN definitions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 fpu/softfloat-specialize.h |   7 +-
 target/riscv/fpu_helper.c  | 373 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 377 insertions(+), 3 deletions(-)
 create mode 100644 target/riscv/fpu_helper.c

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index e81ca00..e2844d0 100644
--- a/fpu/softfloat-specialize.h
+++ b/fpu/softfloat-specialize.h
@@ -114,7 +114,8 @@ float32 float32_default_nan(float_status *status)
 #if defined(TARGET_SPARC) || defined(TARGET_M68K)
     return const_float32(0x7FFFFFFF);
 #elif defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_ALPHA) || \
-      defined(TARGET_XTENSA) || defined(TARGET_S390X) || defined(TARGET_TRICORE)
+      defined(TARGET_XTENSA) || defined(TARGET_S390X) || \
+      defined(TARGET_TRICORE) || defined(TARGET_RISCV)
     return const_float32(0x7FC00000);
 #elif defined(TARGET_HPPA)
     return const_float32(0x7FA00000);
@@ -139,7 +140,7 @@ float64 float64_default_nan(float_status *status)
 #if defined(TARGET_SPARC) || defined(TARGET_M68K)
     return const_float64(LIT64(0x7FFFFFFFFFFFFFFF));
 #elif defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_ALPHA) || \
-      defined(TARGET_S390X)
+      defined(TARGET_S390X) || defined(TARGET_RISCV)
     return const_float64(LIT64(0x7FF8000000000000));
 #elif defined(TARGET_HPPA)
     return const_float64(LIT64(0x7FF4000000000000));
@@ -189,7 +190,7 @@ float128 float128_default_nan(float_status *status)
         r.high = LIT64(0x7FFF7FFFFFFFFFFF);
     } else {
         r.low = LIT64(0x0000000000000000);
-#if defined(TARGET_S390X) || defined(TARGET_PPC)
+#if defined(TARGET_S390X) || defined(TARGET_PPC) || defined(TARGET_RISCV)
         r.high = LIT64(0x7FFF800000000000);
 #else
         r.high = LIT64(0xFFFF800000000000);
diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
new file mode 100644
index 0000000..abbadea
--- /dev/null
+++ b/target/riscv/fpu_helper.c
@@ -0,0 +1,373 @@
+/*
+ * RISC-V FPU Emulation Helpers for QEMU.
+ *
+ * Copyright (c) 2016-2017 Sagar Karandikar, sagark@eecs.berkeley.edu
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include <stdlib.h>
+#include "cpu.h"
+#include "qemu/host-utils.h"
+#include "exec/exec-all.h"
+#include "exec/helper-proto.h"
+
+target_ulong cpu_riscv_get_fflags(CPURISCVState *env)
+{
+    int soft = get_float_exception_flags(&env->fp_status);
+    target_ulong hard = 0;
+
+    hard |= (soft & float_flag_inexact) ? FPEXC_NX : 0;
+    hard |= (soft & float_flag_underflow) ? FPEXC_UF : 0;
+    hard |= (soft & float_flag_overflow) ? FPEXC_OF : 0;
+    hard |= (soft & float_flag_divbyzero) ? FPEXC_DZ : 0;
+    hard |= (soft & float_flag_invalid) ? FPEXC_NV : 0;
+
+    return hard;
+}
+
+void cpu_riscv_set_fflags(CPURISCVState *env, target_ulong hard)
+{
+    int soft = 0;
+
+    soft |= (hard & FPEXC_NX) ? float_flag_inexact : 0;
+    soft |= (hard & FPEXC_UF) ? float_flag_underflow : 0;
+    soft |= (hard & FPEXC_OF) ? float_flag_overflow : 0;
+    soft |= (hard & FPEXC_DZ) ? float_flag_divbyzero : 0;
+    soft |= (hard & FPEXC_NV) ? float_flag_invalid : 0;
+
+    set_float_exception_flags(soft, &env->fp_status);
+}
+
+void helper_set_rounding_mode(CPURISCVState *env, uint32_t rm)
+{
+    int softrm;
+
+    if (rm == 7) {
+        rm = env->frm;
+    }
+    switch (rm) {
+    case 0:
+        softrm = float_round_nearest_even;
+        break;
+    case 1:
+        softrm = float_round_to_zero;
+        break;
+    case 2:
+        softrm = float_round_down;
+        break;
+    case 3:
+        softrm = float_round_up;
+        break;
+    case 4:
+        softrm = float_round_ties_away;
+        break;
+    default:
+        do_raise_exception_err(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    }
+
+    set_float_rounding_mode(softrm, &env->fp_status);
+}
+
+uint64_t helper_fmadd_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+                        uint64_t frs3)
+{
+    return float32_muladd(frs1, frs2, frs3, 0, &env->fp_status);
+}
+
+uint64_t helper_fmadd_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+                        uint64_t frs3)
+{
+    return float64_muladd(frs1, frs2, frs3, 0, &env->fp_status);
+}
+
+uint64_t helper_fmsub_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+                        uint64_t frs3)
+{
+    return float32_muladd(frs1, frs2, frs3, float_muladd_negate_c,
+                          &env->fp_status);
+}
+
+uint64_t helper_fmsub_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+                        uint64_t frs3)
+{
+    return float64_muladd(frs1, frs2, frs3, float_muladd_negate_c,
+                          &env->fp_status);
+}
+
+uint64_t helper_fnmsub_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+                         uint64_t frs3)
+{
+    return float32_muladd(frs1, frs2, frs3, float_muladd_negate_product,
+                          &env->fp_status);
+}
+
+uint64_t helper_fnmsub_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+                         uint64_t frs3)
+{
+    return float64_muladd(frs1, frs2, frs3, float_muladd_negate_product,
+                          &env->fp_status);
+}
+
+uint64_t helper_fnmadd_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+                         uint64_t frs3)
+{
+    return float32_muladd(frs1, frs2, frs3, float_muladd_negate_c |
+                          float_muladd_negate_product, &env->fp_status);
+}
+
+uint64_t helper_fnmadd_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+                         uint64_t frs3)
+{
+    return float64_muladd(frs1, frs2, frs3, float_muladd_negate_c |
+                          float_muladd_negate_product, &env->fp_status);
+}
+
+uint64_t helper_fadd_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+{
+    return float32_add(frs1, frs2, &env->fp_status);
+}
+
+uint64_t helper_fsub_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+{
+    return float32_sub(frs1, frs2, &env->fp_status);
+}
+
+uint64_t helper_fmul_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+{
+    return float32_mul(frs1, frs2, &env->fp_status);
+}
+
+uint64_t helper_fdiv_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+{
+    return float32_div(frs1, frs2, &env->fp_status);
+}
+
+uint64_t helper_fmin_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+{
+    return float32_minnum(frs1, frs2, &env->fp_status);
+}
+
+uint64_t helper_fmax_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+{
+    return float32_maxnum(frs1, frs2, &env->fp_status);
+}
+
+uint64_t helper_fsqrt_s(CPURISCVState *env, uint64_t frs1)
+{
+    return float32_sqrt(frs1, &env->fp_status);
+}
+
+target_ulong helper_fle_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+{
+    return float32_le(frs1, frs2, &env->fp_status);
+}
+
+target_ulong helper_flt_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+{
+    return float32_lt(frs1, frs2, &env->fp_status);
+}
+
+target_ulong helper_feq_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+{
+    return float32_eq_quiet(frs1, frs2, &env->fp_status);
+}
+
+target_ulong helper_fcvt_w_s(CPURISCVState *env, uint64_t frs1)
+{
+    return float32_to_int32(frs1, &env->fp_status);
+}
+
+target_ulong helper_fcvt_wu_s(CPURISCVState *env, uint64_t frs1)
+{
+    return (int32_t)float32_to_uint32(frs1, &env->fp_status);
+}
+
+#if defined(TARGET_RISCV64)
+uint64_t helper_fcvt_l_s(CPURISCVState *env, uint64_t frs1)
+{
+    return float32_to_int64(frs1, &env->fp_status);
+}
+
+uint64_t helper_fcvt_lu_s(CPURISCVState *env, uint64_t frs1)
+{
+    return float32_to_uint64(frs1, &env->fp_status);
+}
+#endif
+
+uint64_t helper_fcvt_s_w(CPURISCVState *env, target_ulong rs1)
+{
+    return int32_to_float32((int32_t)rs1, &env->fp_status);
+}
+
+uint64_t helper_fcvt_s_wu(CPURISCVState *env, target_ulong rs1)
+{
+    return uint32_to_float32((uint32_t)rs1, &env->fp_status);
+}
+
+#if defined(TARGET_RISCV64)
+uint64_t helper_fcvt_s_l(CPURISCVState *env, uint64_t rs1)
+{
+    return int64_to_float32(rs1, &env->fp_status);
+}
+
+uint64_t helper_fcvt_s_lu(CPURISCVState *env, uint64_t rs1)
+{
+    return uint64_to_float32(rs1, &env->fp_status);
+}
+#endif
+
+target_ulong helper_fclass_s(uint64_t frs1)
+{
+    float32 f = frs1;
+    bool sign = float32_is_neg(f);
+
+    if (float32_is_infinity(f)) {
+        return sign ? 1 << 0 : 1 << 7;
+    } else if (float32_is_zero(f)) {
+        return sign ? 1 << 3 : 1 << 4;
+    } else if (float32_is_zero_or_denormal(f)) {
+        return sign ? 1 << 2 : 1 << 5;
+    } else if (float32_is_any_nan(f)) {
+        float_status s = { }; /* for snan_bit_is_one */
+        return float32_is_quiet_nan(f, &s) ? 1 << 9 : 1 << 8;
+    } else {
+        return sign ? 1 << 1 : 1 << 6;
+    }
+}
+
+uint64_t helper_fadd_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+{
+    return float64_add(frs1, frs2, &env->fp_status);
+}
+
+uint64_t helper_fsub_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+{
+    return float64_sub(frs1, frs2, &env->fp_status);
+}
+
+uint64_t helper_fmul_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+{
+    return float64_mul(frs1, frs2, &env->fp_status);
+}
+
+uint64_t helper_fdiv_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+{
+    return float64_div(frs1, frs2, &env->fp_status);
+}
+
+uint64_t helper_fmin_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+{
+    return float64_minnum(frs1, frs2, &env->fp_status);
+}
+
+uint64_t helper_fmax_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+{
+    return float64_maxnum(frs1, frs2, &env->fp_status);
+}
+
+uint64_t helper_fcvt_s_d(CPURISCVState *env, uint64_t rs1)
+{
+    rs1 = float64_to_float32(rs1, &env->fp_status);
+    return float32_maybe_silence_nan(rs1, &env->fp_status);
+}
+
+uint64_t helper_fcvt_d_s(CPURISCVState *env, uint64_t rs1)
+{
+    rs1 = float32_to_float64(rs1, &env->fp_status);
+    return float64_maybe_silence_nan(rs1, &env->fp_status);
+}
+
+uint64_t helper_fsqrt_d(CPURISCVState *env, uint64_t frs1)
+{
+    return float64_sqrt(frs1, &env->fp_status);
+}
+
+target_ulong helper_fle_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+{
+    return float64_le(frs1, frs2, &env->fp_status);
+}
+
+target_ulong helper_flt_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+{
+    return float64_lt(frs1, frs2, &env->fp_status);
+}
+
+target_ulong helper_feq_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+{
+    return float64_eq_quiet(frs1, frs2, &env->fp_status);
+}
+
+target_ulong helper_fcvt_w_d(CPURISCVState *env, uint64_t frs1)
+{
+    return float64_to_int32(frs1, &env->fp_status);
+}
+
+target_ulong helper_fcvt_wu_d(CPURISCVState *env, uint64_t frs1)
+{
+    return (int32_t)float64_to_uint32(frs1, &env->fp_status);
+}
+
+#if defined(TARGET_RISCV64)
+uint64_t helper_fcvt_l_d(CPURISCVState *env, uint64_t frs1)
+{
+    return float64_to_int64(frs1, &env->fp_status);
+}
+
+uint64_t helper_fcvt_lu_d(CPURISCVState *env, uint64_t frs1)
+{
+    return float64_to_uint64(frs1, &env->fp_status);
+}
+#endif
+
+uint64_t helper_fcvt_d_w(CPURISCVState *env, target_ulong rs1)
+{
+    return int32_to_float64((int32_t)rs1, &env->fp_status);
+}
+
+uint64_t helper_fcvt_d_wu(CPURISCVState *env, target_ulong rs1)
+{
+    return uint32_to_float64((uint32_t)rs1, &env->fp_status);
+}
+
+#if defined(TARGET_RISCV64)
+uint64_t helper_fcvt_d_l(CPURISCVState *env, uint64_t rs1)
+{
+    return int64_to_float64(rs1, &env->fp_status);
+}
+
+uint64_t helper_fcvt_d_lu(CPURISCVState *env, uint64_t rs1)
+{
+    return uint64_to_float64(rs1, &env->fp_status);
+}
+#endif
+
+target_ulong helper_fclass_d(uint64_t frs1)
+{
+    float64 f = frs1;
+    bool sign = float64_is_neg(f);
+
+    if (float64_is_infinity(f)) {
+        return sign ? 1 << 0 : 1 << 7;
+    } else if (float64_is_zero(f)) {
+        return sign ? 1 << 3 : 1 << 4;
+    } else if (float64_is_zero_or_denormal(f)) {
+        return sign ? 1 << 2 : 1 << 5;
+    } else if (float64_is_any_nan(f)) {
+        float_status s = { }; /* for snan_bit_is_one */
+        return float64_is_quiet_nan(f, &s) ? 1 << 9 : 1 << 8;
+    } else {
+        return sign ? 1 << 1 : 1 << 6;
+    }
+}
-- 
2.7.0
