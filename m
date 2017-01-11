Received: from eggs.gnu.org ([2001:4830:134:3::10]:56986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1cRJEF-0008N5-AZ
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 08:46:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1cRJEA-0005Zz-Oj
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 08:46:15 -0500
Received: from mail.uni-paderborn.de ([131.234.142.9]:48235)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1cRJEA-0005Xa-Df
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 08:46:10 -0500
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Wed, 11 Jan 2017 14:45:46 +0100
Message-Id: <20170111134549.32669-3-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20170111134549.32669-1-kbastian@mail.uni-paderborn.de>
References: <20170111134549.32669-1-kbastian@mail.uni-paderborn.de>
Subject: [Qemu-devel] [PULL 2/5] target-tricore: Added MADD.F and MSUB.F
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Multiplies D[a] and D[b] and adds/subtracts the result to/from D[d].
The result is put in D[c]. All operands are floating-point numbers.

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 target/tricore/fpu_helper.c | 93 ++++++++++++++++++++++++++++++++++++++++++++-
 target/tricore/helper.h     |  2 +
 target/tricore/translate.c  |  8 ++++
 3 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/target/tricore/fpu_helper.c b/target/tricore/fpu_helper.c
index 215c3970b1..9bfed28b45 100644
--- a/target/tricore/fpu_helper.c
+++ b/target/tricore/fpu_helper.c
@@ -21,7 +21,8 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 
-#define ADD_NAN   0x7cf00001
+#define QUIET_NAN 0x7fc00000
+#define ADD_NAN   0x7fc00001
 #define DIV_NAN   0x7fc00008
 #define MUL_NAN   0x7fc00002
 #define FPU_FS PSW_USB_C
@@ -47,6 +48,42 @@ static inline bool f_is_denormal(float32 arg)
     return float32_is_zero_or_denormal(arg) && !float32_is_zero(arg);
 }
 
+static inline float32 f_maddsub_nan_result(float32 arg1, float32 arg2,
+                                           float32 arg3, float32 result,
+                                           uint32_t muladd_negate_c)
+{
+    uint32_t aSign, bSign, cSign;
+    uint32_t aExp, bExp, cExp;
+
+    if (float32_is_any_nan(arg1) || float32_is_any_nan(arg2) ||
+        float32_is_any_nan(arg3)) {
+        return QUIET_NAN;
+    } else if (float32_is_infinity(arg1) && float32_is_zero(arg2)) {
+        return MUL_NAN;
+    } else if (float32_is_zero(arg1) && float32_is_infinity(arg2)) {
+        return MUL_NAN;
+    } else {
+        aSign = arg1 >> 31;
+        bSign = arg2 >> 31;
+        cSign = arg3 >> 31;
+
+        aExp = (arg1 >> 23) & 0xff;
+        bExp = (arg2 >> 23) & 0xff;
+        cExp = (arg3 >> 23) & 0xff;
+
+        if (muladd_negate_c) {
+            cSign ^= 1;
+        }
+        if (((aExp == 0xff) || (bExp == 0xff)) && (cExp == 0xff)) {
+            if (aSign ^ bSign ^ cSign) {
+                return ADD_NAN;
+            }
+        }
+    }
+
+    return result;
+}
+
 static void f_update_psw_flags(CPUTriCoreState *env, uint8_t flags)
 {
     uint8_t some_excp = 0;
@@ -159,6 +196,60 @@ uint32_t helper_fdiv(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
     return (uint32_t)f_result;
 }
 
+uint32_t helper_fmadd(CPUTriCoreState *env, uint32_t r1,
+                      uint32_t r2, uint32_t r3)
+{
+    uint32_t flags;
+    float32 arg1 = make_float32(r1);
+    float32 arg2 = make_float32(r2);
+    float32 arg3 = make_float32(r3);
+    float32 f_result;
+
+    f_result = float32_muladd(arg1, arg2, arg3, 0, &env->fp_status);
+
+    flags = f_get_excp_flags(env);
+    if (flags) {
+        if (flags & float_flag_invalid) {
+            arg1 = float32_squash_input_denormal(arg1, &env->fp_status);
+            arg2 = float32_squash_input_denormal(arg2, &env->fp_status);
+            arg3 = float32_squash_input_denormal(arg3, &env->fp_status);
+            f_result = f_maddsub_nan_result(arg1, arg2, arg3, f_result, 0);
+        }
+        f_update_psw_flags(env, flags);
+    } else {
+        env->FPU_FS = 0;
+    }
+    return (uint32_t)f_result;
+}
+
+uint32_t helper_fmsub(CPUTriCoreState *env, uint32_t r1,
+                      uint32_t r2, uint32_t r3)
+{
+    uint32_t flags;
+    float32 arg1 = make_float32(r1);
+    float32 arg2 = make_float32(r2);
+    float32 arg3 = make_float32(r3);
+    float32 f_result;
+
+    f_result = float32_muladd(arg1, arg2, arg3, float_muladd_negate_product,
+                              &env->fp_status);
+
+    flags = f_get_excp_flags(env);
+    if (flags) {
+        if (flags & float_flag_invalid) {
+            arg1 = float32_squash_input_denormal(arg1, &env->fp_status);
+            arg2 = float32_squash_input_denormal(arg2, &env->fp_status);
+            arg3 = float32_squash_input_denormal(arg3, &env->fp_status);
+
+            f_result = f_maddsub_nan_result(arg1, arg2, arg3, f_result, 1);
+        }
+        f_update_psw_flags(env, flags);
+    } else {
+        env->FPU_FS = 0;
+    }
+    return (uint32_t)f_result;
+}
+
 uint32_t helper_fcmp(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
 {
     uint32_t result, flags;
diff --git a/target/tricore/helper.h b/target/tricore/helper.h
index 467c88013a..c897a44eb3 100644
--- a/target/tricore/helper.h
+++ b/target/tricore/helper.h
@@ -109,6 +109,8 @@ DEF_HELPER_3(fadd, i32, env, i32, i32)
 DEF_HELPER_3(fsub, i32, env, i32, i32)
 DEF_HELPER_3(fmul, i32, env, i32, i32)
 DEF_HELPER_3(fdiv, i32, env, i32, i32)
+DEF_HELPER_4(fmadd, i32, env, i32, i32, i32)
+DEF_HELPER_4(fmsub, i32, env, i32, i32, i32)
 DEF_HELPER_3(fcmp, i32, env, i32, i32)
 DEF_HELPER_2(ftoi, i32, env, i32)
 DEF_HELPER_2(itof, i32, env, i32)
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index eb6fdc3ca4..a8234dba83 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -7096,6 +7096,14 @@ static void decode_rrr_divide(CPUTriCoreState *env, DisasContext *ctx)
     case OPC2_32_RRR_SUB_F:
         gen_helper_fsub(cpu_gpr_d[r4], cpu_env, cpu_gpr_d[r1], cpu_gpr_d[r3]);
         break;
+    case OPC2_32_RRR_MADD_F:
+        gen_helper_fmadd(cpu_gpr_d[r4], cpu_env, cpu_gpr_d[r1],
+                         cpu_gpr_d[r2], cpu_gpr_d[r3]);
+        break;
+    case OPC2_32_RRR_MSUB_F:
+        gen_helper_fmsub(cpu_gpr_d[r4], cpu_env, cpu_gpr_d[r1],
+                         cpu_gpr_d[r2], cpu_gpr_d[r3]);
+        break;
     default:
         generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
     }
-- 
2.11.0
