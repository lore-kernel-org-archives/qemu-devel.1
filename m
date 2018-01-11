Received: from eggs.gnu.org ([2001:4830:134:3::10]:48007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eZSWe-0003Au-Aj
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 21:23:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eZSWb-0008Fc-Hy
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 21:23:28 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:33257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eZSWb-0008F7-95
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 21:23:25 -0500
Received: by mail-pg0-x241.google.com with SMTP id i196so1682324pgd.0
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 18:23:25 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 10 Jan 2018 18:21:49 -0800
Message-Id: <1515637324-96034-7-git-send-email-mjc@sifive.com>
In-Reply-To: <1515637324-96034-1-git-send-email-mjc@sifive.com>
References: <1515637324-96034-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v3 06/21] RISC-V FPU Support
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

Signed-off-by: Michael Clark <mjc@sifive.com>
---
 fpu/softfloat-specialize.h |   7 +-
 target/riscv/fpu_helper.c  | 591 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 595 insertions(+), 3 deletions(-)
 create mode 100644 target/riscv/fpu_helper.c

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index de2c5d5..49ee578 100644
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
index 0000000..ada985f
--- /dev/null
+++ b/target/riscv/fpu_helper.c
@@ -0,0 +1,591 @@
+/*
+ * RISC-V FPU Emulation Helpers for QEMU.
+ *
+ * Author: Sagar Karandikar, sagark@eecs.berkeley.edu
+ *
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
+#include <stdlib.h>
+#include "cpu.h"
+#include "qemu/host-utils.h"
+#include "exec/helper-proto.h"
+
+/* convert RISC-V rounding mode to IEEE library numbers */
+unsigned int ieee_rm[] = {
+    float_round_nearest_even,
+    float_round_to_zero,
+    float_round_down,
+    float_round_up,
+    float_round_ties_away
+};
+
+/* obtain rm value to use in computation
+ * as the last step, convert rm codes to what the softfloat library expects
+ * Adapted from Spike's decode.h:RM
+ */
+#define RM ({                                             \
+if (rm == 7) {                                            \
+    rm = env->frm;                               \
+}                                                         \
+if (rm > 4) {                                             \
+    helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST); \
+}                                                         \
+ieee_rm[rm]; })
+
+#ifndef CONFIG_USER_ONLY
+#define require_fp if (!(env->mstatus & MSTATUS_FS)) { \
+    helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST); \
+}
+#else
+#define require_fp /* nop */
+#endif
+
+/* convert softfloat library flag numbers to RISC-V */
+unsigned int softfloat_flags_to_riscv(unsigned int flags)
+{
+    int rv_flags = 0;
+    rv_flags |= (flags & float_flag_inexact) ? 1 : 0;
+    rv_flags |= (flags & float_flag_underflow) ? 2 : 0;
+    rv_flags |= (flags & float_flag_overflow) ? 4 : 0;
+    rv_flags |= (flags & float_flag_divbyzero) ? 8 : 0;
+    rv_flags |= (flags & float_flag_invalid) ? 16 : 0;
+    return rv_flags;
+}
+
+/* adapted from Spike's decode.h:set_fp_exceptions */
+#define set_fp_exceptions() do { \
+    env->fflags |= softfloat_flags_to_riscv(get_float_exception_flags(\
+                            &env->fp_status)); \
+    set_float_exception_flags(0, &env->fp_status); \
+} while (0)
+
+uint64_t helper_fmadd_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+                        uint64_t frs3, uint64_t rm)
+{
+    require_fp;
+    set_float_rounding_mode(RM, &env->fp_status);
+    frs1 = float32_muladd(frs1, frs2, frs3, 0, &env->fp_status);
+    set_fp_exceptions();
+    return frs1;
+}
+
+uint64_t helper_fmadd_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+                        uint64_t frs3, uint64_t rm)
+{
+    require_fp;
+    set_float_rounding_mode(RM, &env->fp_status);
+    frs1 = float64_muladd(frs1, frs2, frs3, 0, &env->fp_status);
+    set_fp_exceptions();
+    return frs1;
+}
+
+uint64_t helper_fmsub_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+                        uint64_t frs3, uint64_t rm)
+{
+    require_fp;
+    set_float_rounding_mode(RM, &env->fp_status);
+    frs1 = float32_muladd(frs1, frs2, frs3 ^ (uint32_t)INT32_MIN, 0,
+                          &env->fp_status);
+    set_fp_exceptions();
+    return frs1;
+}
+
+uint64_t helper_fmsub_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+                        uint64_t frs3, uint64_t rm)
+{
+    require_fp;
+    set_float_rounding_mode(RM, &env->fp_status);
+    frs1 = float64_muladd(frs1, frs2, frs3 ^ (uint64_t)INT64_MIN, 0,
+                          &env->fp_status);
+    set_fp_exceptions();
+    return frs1;
+}
+
+uint64_t helper_fnmsub_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+                         uint64_t frs3, uint64_t rm)
+{
+    require_fp;
+    set_float_rounding_mode(RM, &env->fp_status);
+    frs1 = float32_muladd(frs1 ^ (uint32_t)INT32_MIN, frs2, frs3, 0,
+                          &env->fp_status);
+    set_fp_exceptions();
+    return frs1;
+}
+
+uint64_t helper_fnmsub_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+                         uint64_t frs3, uint64_t rm)
+{
+    require_fp;
+    set_float_rounding_mode(RM, &env->fp_status);
+    frs1 = float64_muladd(frs1 ^ (uint64_t)INT64_MIN, frs2, frs3, 0,
+                          &env->fp_status);
+    set_fp_exceptions();
+    return frs1;
+}
+
+uint64_t helper_fnmadd_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+                         uint64_t frs3, uint64_t rm)
+{
+    require_fp;
+    set_float_rounding_mode(RM, &env->fp_status);
+    frs1 = float32_muladd(frs1 ^ (uint32_t)INT32_MIN, frs2,
+                          frs3 ^ (uint32_t)INT32_MIN, 0, &env->fp_status);
+    set_fp_exceptions();
+    return frs1;
+}
+
+uint64_t helper_fnmadd_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+                         uint64_t frs3, uint64_t rm)
+{
+    require_fp;
+    set_float_rounding_mode(RM, &env->fp_status);
+    frs1 = float64_muladd(frs1 ^ (uint64_t)INT64_MIN, frs2,
+                          frs3 ^ (uint64_t)INT64_MIN, 0, &env->fp_status);
+    set_fp_exceptions();
+    return frs1;
+}
+
+uint64_t helper_fadd_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+                       uint64_t rm)
+{
+    require_fp;
+    set_float_rounding_mode(RM, &env->fp_status);
+    frs1 = float32_add(frs1, frs2, &env->fp_status);
+    set_fp_exceptions();
+    return frs1;
+}
+
+uint64_t helper_fsub_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+                       uint64_t rm)
+{
+    require_fp;
+    set_float_rounding_mode(RM, &env->fp_status);
+    frs1 = float32_sub(frs1, frs2, &env->fp_status);
+    set_fp_exceptions();
+    return frs1;
+}
+
+uint64_t helper_fmul_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+                       uint64_t rm)
+{
+    require_fp;
+    set_float_rounding_mode(RM, &env->fp_status);
+    frs1 = float32_mul(frs1, frs2, &env->fp_status);
+    set_fp_exceptions();
+    return frs1;
+}
+
+uint64_t helper_fdiv_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+                       uint64_t rm)
+{
+    require_fp;
+    set_float_rounding_mode(RM, &env->fp_status);
+    frs1 = float32_div(frs1, frs2, &env->fp_status);
+    set_fp_exceptions();
+    return frs1;
+}
+
+uint64_t helper_fmin_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+{
+    require_fp;
+    frs1 = float32_minnum(frs1, frs2, &env->fp_status);
+    set_fp_exceptions();
+    return frs1;
+}
+
+uint64_t helper_fmax_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+{
+    require_fp;
+    frs1 = float32_maxnum(frs1, frs2, &env->fp_status);
+    set_fp_exceptions();
+    return frs1;
+}
+
+uint64_t helper_fsqrt_s(CPURISCVState *env, uint64_t frs1, uint64_t rm)
+{
+    require_fp;
+    set_float_rounding_mode(RM, &env->fp_status);
+    frs1 = float32_sqrt(frs1, &env->fp_status);
+    set_fp_exceptions();
+    return frs1;
+}
+
+target_ulong helper_fle_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+{
+    require_fp;
+    frs1 = float32_le(frs1, frs2, &env->fp_status);
+    set_fp_exceptions();
+    return frs1;
+}
+
+target_ulong helper_flt_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+{
+    require_fp;
+    frs1 = float32_lt(frs1, frs2, &env->fp_status);
+    set_fp_exceptions();
+    return frs1;
+}
+
+target_ulong helper_feq_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+{
+    require_fp;
+    frs1 = float32_eq_quiet(frs1, frs2, &env->fp_status);
+    set_fp_exceptions();
+    return frs1;
+}
+
+target_ulong helper_fcvt_w_s(CPURISCVState *env, uint64_t frs1, uint64_t rm)
+{
+    require_fp;
+    set_float_rounding_mode(RM, &env->fp_status);
+    frs1 = float32_to_int32(frs1, &env->fp_status);
+    set_fp_exceptions();
+    return frs1;
+}
+
+target_ulong helper_fcvt_wu_s(CPURISCVState *env, uint64_t frs1, uint64_t rm)
+{
+    require_fp;
+    set_float_rounding_mode(RM, &env->fp_status);
+    frs1 = (int32_t)float32_to_uint32(frs1, &env->fp_status);
+    set_fp_exceptions();
+    return frs1;
+}
+
+#if defined(TARGET_RISCV64)
+uint64_t helper_fcvt_l_s(CPURISCVState *env, uint64_t frs1, uint64_t rm)
+{
+    require_fp;
+    set_float_rounding_mode(RM, &env->fp_status);
+    frs1 = float32_to_int64(frs1, &env->fp_status);
+    set_fp_exceptions();
+    return frs1;
+}
+
+uint64_t helper_fcvt_lu_s(CPURISCVState *env, uint64_t frs1, uint64_t rm)
+{
+    require_fp;
+    set_float_rounding_mode(RM, &env->fp_status);
+    frs1 = float32_to_uint64(frs1, &env->fp_status);
+    set_fp_exceptions();
+    return frs1;
+}
+#endif
+
+uint64_t helper_fcvt_s_w(CPURISCVState *env, target_ulong rs1, uint64_t rm)
+{
+    require_fp;
+    set_float_rounding_mode(RM, &env->fp_status);
+    rs1 = int32_to_float32((int32_t)rs1, &env->fp_status);
+    set_fp_exceptions();
+    return rs1;
+}
+
+uint64_t helper_fcvt_s_wu(CPURISCVState *env, target_ulong rs1, uint64_t rm)
+{
+    require_fp;
+    set_float_rounding_mode(RM, &env->fp_status);
+    rs1 = uint32_to_float32((uint32_t)rs1, &env->fp_status);
+    set_fp_exceptions();
+    return rs1;
+}
+
+#if defined(TARGET_RISCV64)
+uint64_t helper_fcvt_s_l(CPURISCVState *env, uint64_t rs1, uint64_t rm)
+{
+    require_fp;
+    set_float_rounding_mode(RM, &env->fp_status);
+    rs1 = int64_to_float32(rs1, &env->fp_status);
+    set_fp_exceptions();
+    return rs1;
+}
+
+uint64_t helper_fcvt_s_lu(CPURISCVState *env, uint64_t rs1, uint64_t rm)
+{
+    require_fp;
+    set_float_rounding_mode(RM, &env->fp_status);
+    rs1 = uint64_to_float32(rs1, &env->fp_status);
+    set_fp_exceptions();
+    return rs1;
+}
+#endif
+
+/* adapted from spike */
+#define isNaNF32UI(ui) (0xFF000000 < (uint32_t)((uint_fast32_t)ui << 1))
+#define signF32UI(a) ((bool)((uint32_t)a >> 31))
+#define expF32UI(a) ((int_fast16_t)(a >> 23) & 0xFF)
+#define fracF32UI(a) (a & 0x007FFFFF)
+
+union ui32_f32 { uint32_t ui; uint32_t f; };
+
+uint_fast16_t float32_classify(uint32_t a, float_status *status)
+{
+    union ui32_f32 uA;
+    uint_fast32_t uiA;
+
+    uA.f = a;
+    uiA = uA.ui;
+
+    uint_fast16_t infOrNaN = expF32UI(uiA) == 0xFF;
+    uint_fast16_t subnormalOrZero = expF32UI(uiA) == 0;
+    bool sign = signF32UI(uiA);
+
+    return
+        (sign && infOrNaN && fracF32UI(uiA) == 0)           << 0 |
+        (sign && !infOrNaN && !subnormalOrZero)             << 1 |
+        (sign && subnormalOrZero && fracF32UI(uiA))         << 2 |
+        (sign && subnormalOrZero && fracF32UI(uiA) == 0)    << 3 |
+        (!sign && infOrNaN && fracF32UI(uiA) == 0)          << 7 |
+        (!sign && !infOrNaN && !subnormalOrZero)            << 6 |
+        (!sign && subnormalOrZero && fracF32UI(uiA))        << 5 |
+        (!sign && subnormalOrZero && fracF32UI(uiA) == 0)   << 4 |
+        (isNaNF32UI(uiA) &&  float32_is_signaling_nan(uiA, status)) << 8 |
+        (isNaNF32UI(uiA) && !float32_is_signaling_nan(uiA, status)) << 9;
+}
+
+target_ulong helper_fclass_s(CPURISCVState *env, uint64_t frs1)
+{
+    require_fp;
+    frs1 = float32_classify(frs1, &env->fp_status);
+    return frs1;
+}
+
+uint64_t helper_fadd_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+                       uint64_t rm)
+{
+    require_fp;
+    set_float_rounding_mode(RM, &env->fp_status);
+    frs1 = float64_add(frs1, frs2, &env->fp_status);
+    set_fp_exceptions();
+    return frs1;
+}
+
+uint64_t helper_fsub_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+                       uint64_t rm)
+{
+    require_fp;
+    set_float_rounding_mode(RM, &env->fp_status);
+    frs1 = float64_sub(frs1, frs2, &env->fp_status);
+    set_fp_exceptions();
+    return frs1;
+}
+
+uint64_t helper_fmul_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+                       uint64_t rm)
+{
+    require_fp;
+    set_float_rounding_mode(RM, &env->fp_status);
+    frs1 = float64_mul(frs1, frs2, &env->fp_status);
+    set_fp_exceptions();
+    return frs1;
+}
+
+uint64_t helper_fdiv_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
+                       uint64_t rm)
+{
+    require_fp;
+    set_float_rounding_mode(RM, &env->fp_status);
+    frs1 = float64_div(frs1, frs2, &env->fp_status);
+    set_fp_exceptions();
+    return frs1;
+}
+
+uint64_t helper_fmin_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+{
+    require_fp;
+    frs1 = float64_minnum(frs1, frs2, &env->fp_status);
+    set_fp_exceptions();
+    return frs1;
+}
+
+uint64_t helper_fmax_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+{
+    require_fp;
+    frs1 = float64_maxnum(frs1, frs2, &env->fp_status);
+    set_fp_exceptions();
+    return frs1;
+}
+
+uint64_t helper_fcvt_s_d(CPURISCVState *env, uint64_t rs1, uint64_t rm)
+{
+    require_fp;
+    set_float_rounding_mode(RM, &env->fp_status);
+    rs1 = float64_to_float32(rs1, &env->fp_status);
+    set_fp_exceptions();
+    return rs1;
+}
+
+uint64_t helper_fcvt_d_s(CPURISCVState *env, uint64_t rs1, uint64_t rm)
+{
+    require_fp;
+    set_float_rounding_mode(RM, &env->fp_status);
+    rs1 = float32_to_float64(rs1, &env->fp_status);
+    set_fp_exceptions();
+    return rs1;
+}
+
+uint64_t helper_fsqrt_d(CPURISCVState *env, uint64_t frs1, uint64_t rm)
+{
+    require_fp;
+    set_float_rounding_mode(RM, &env->fp_status);
+    frs1 = float64_sqrt(frs1, &env->fp_status);
+    set_fp_exceptions();
+    return frs1;
+}
+
+target_ulong helper_fle_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+{
+    require_fp;
+    frs1 = float64_le(frs1, frs2, &env->fp_status);
+    set_fp_exceptions();
+    return frs1;
+}
+
+target_ulong helper_flt_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+{
+    require_fp;
+    frs1 = float64_lt(frs1, frs2, &env->fp_status);
+    set_fp_exceptions();
+    return frs1;
+}
+
+target_ulong helper_feq_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
+{
+    require_fp;
+    frs1 = float64_eq_quiet(frs1, frs2, &env->fp_status);
+    set_fp_exceptions();
+    return frs1;
+}
+
+target_ulong helper_fcvt_w_d(CPURISCVState *env, uint64_t frs1, uint64_t rm)
+{
+    require_fp;
+    set_float_rounding_mode(RM, &env->fp_status);
+    frs1 = (int64_t)((int32_t)float64_to_int32(frs1, &env->fp_status));
+    set_fp_exceptions();
+    return frs1;
+}
+
+target_ulong helper_fcvt_wu_d(CPURISCVState *env, uint64_t frs1, uint64_t rm)
+{
+    require_fp;
+    set_float_rounding_mode(RM, &env->fp_status);
+    frs1 = (int64_t)((int32_t)float64_to_uint32(frs1, &env->fp_status));
+    set_fp_exceptions();
+    return frs1;
+}
+
+#if defined(TARGET_RISCV64)
+uint64_t helper_fcvt_l_d(CPURISCVState *env, uint64_t frs1, uint64_t rm)
+{
+    require_fp;
+    set_float_rounding_mode(RM, &env->fp_status);
+    frs1 = float64_to_int64(frs1, &env->fp_status);
+    set_fp_exceptions();
+    return frs1;
+}
+
+uint64_t helper_fcvt_lu_d(CPURISCVState *env, uint64_t frs1, uint64_t rm)
+{
+    require_fp;
+    set_float_rounding_mode(RM, &env->fp_status);
+    frs1 = float64_to_uint64(frs1, &env->fp_status);
+    set_fp_exceptions();
+    return frs1;
+}
+#endif
+
+uint64_t helper_fcvt_d_w(CPURISCVState *env, target_ulong rs1, uint64_t rm)
+{
+    require_fp;
+    uint64_t res;
+    set_float_rounding_mode(RM, &env->fp_status);
+    res = int32_to_float64((int32_t)rs1, &env->fp_status);
+    set_fp_exceptions();
+    return res;
+}
+
+uint64_t helper_fcvt_d_wu(CPURISCVState *env, target_ulong rs1, uint64_t rm)
+{
+    require_fp;
+    uint64_t res;
+    set_float_rounding_mode(RM, &env->fp_status);
+    res = uint32_to_float64((uint32_t)rs1, &env->fp_status);
+    set_fp_exceptions();
+    return res;
+}
+
+#if defined(TARGET_RISCV64)
+uint64_t helper_fcvt_d_l(CPURISCVState *env, uint64_t rs1, uint64_t rm)
+{
+    require_fp;
+    set_float_rounding_mode(RM, &env->fp_status);
+    rs1 = int64_to_float64(rs1, &env->fp_status);
+    set_fp_exceptions();
+    return rs1;
+}
+
+uint64_t helper_fcvt_d_lu(CPURISCVState *env, uint64_t rs1, uint64_t rm)
+{
+    require_fp;
+    set_float_rounding_mode(RM, &env->fp_status);
+    rs1 = uint64_to_float64(rs1, &env->fp_status);
+    set_fp_exceptions();
+    return rs1;
+}
+#endif
+
+/* adapted from spike */
+#define isNaNF64UI(ui) (UINT64_C(0xFFE0000000000000) \
+                       < (uint64_t)((uint_fast64_t)ui << 1))
+#define signF64UI(a) ((bool)((uint64_t) a >> 63))
+#define expF64UI(a) ((int_fast16_t)(a >> 52) & 0x7FF)
+#define fracF64UI(a) (a & UINT64_C(0x000FFFFFFFFFFFFF))
+
+union ui64_f64 { uint64_t ui; uint64_t f; };
+
+uint_fast16_t float64_classify(uint64_t a, float_status *status)
+{
+    union ui64_f64 uA;
+    uint_fast64_t uiA;
+
+    uA.f = a;
+    uiA = uA.ui;
+
+    uint_fast16_t infOrNaN = expF64UI(uiA) == 0x7FF;
+    uint_fast16_t subnormalOrZero = expF64UI(uiA) == 0;
+    bool sign = signF64UI(uiA);
+
+    return
+        (sign && infOrNaN && fracF64UI(uiA) == 0)        << 0 |
+        (sign && !infOrNaN && !subnormalOrZero)            << 1 |
+        (sign && subnormalOrZero && fracF64UI(uiA))        << 2 |
+        (sign && subnormalOrZero && fracF64UI(uiA) == 0)   << 3 |
+        (!sign && infOrNaN && fracF64UI(uiA) == 0)         << 7 |
+        (!sign && !infOrNaN && !subnormalOrZero)           << 6 |
+        (!sign && subnormalOrZero && fracF64UI(uiA))       << 5 |
+        (!sign && subnormalOrZero && fracF64UI(uiA) == 0)  << 4 |
+        (isNaNF64UI(uiA) &&  float64_is_signaling_nan(uiA, status)) << 8 |
+        (isNaNF64UI(uiA) && !float64_is_signaling_nan(uiA, status)) << 9;
+}
+
+target_ulong helper_fclass_d(CPURISCVState *env, uint64_t frs1)
+{
+    require_fp;
+    frs1 = float64_classify(frs1, &env->fp_status);
+    return frs1;
+}
-- 
2.7.0
