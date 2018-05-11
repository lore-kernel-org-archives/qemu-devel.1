Received: from eggs.gnu.org ([2001:4830:134:3::10]:55566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGzae-0000Wz-Sg
	for qemu-devel@nongnu.org; Fri, 11 May 2018 00:23:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGzac-00085H-61
	for qemu-devel@nongnu.org; Fri, 11 May 2018 00:23:32 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:33239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGzab-00085D-SJ
	for qemu-devel@nongnu.org; Fri, 11 May 2018 00:23:30 -0400
Received: by mail-pf0-x244.google.com with SMTP id f20-v6so2101705pfn.0
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 21:23:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 10 May 2018 21:23:12 -0700
Message-Id: <20180511042324.5070-2-richard.henderson@linaro.org>
In-Reply-To: <20180511042324.5070-1-richard.henderson@linaro.org>
References: <20180511042324.5070-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 01/13] target-openrisc: Write back result before
 FPE exception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

The architecture manual is unclear about this, but the or1ksim
does writeback before the exception.  This requires splitting
the helpers in half, with the exception raised by the second.

Acked-by: Stafford Horne <shorne@gmail.com>
Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/openrisc/helper.h     |  25 ++--
 target/openrisc/fpu_helper.c | 250 +++++++----------------------------
 target/openrisc/translate.c  | 101 +++++++++-----
 3 files changed, 125 insertions(+), 251 deletions(-)

diff --git a/target/openrisc/helper.h b/target/openrisc/helper.h
index 4fd1a6bb8e..e37dabc77a 100644
--- a/target/openrisc/helper.h
+++ b/target/openrisc/helper.h
@@ -24,17 +24,19 @@ DEF_HELPER_FLAGS_1(ove_ov, TCG_CALL_NO_WG, void, env)
 DEF_HELPER_FLAGS_1(ove_cyov, TCG_CALL_NO_WG, void, env)
 
 /* float */
-DEF_HELPER_FLAGS_2(itofd, TCG_CALL_NO_WG, i64, env, i64)
-DEF_HELPER_FLAGS_2(itofs, TCG_CALL_NO_WG, i32, env, i32)
-DEF_HELPER_FLAGS_2(ftoid, TCG_CALL_NO_WG, i64, env, i64)
-DEF_HELPER_FLAGS_2(ftois, TCG_CALL_NO_WG, i32, env, i32)
+DEF_HELPER_FLAGS_1(update_fpcsr, TCG_CALL_NO_WG, void, env)
 
-DEF_HELPER_FLAGS_4(float_madd_s, TCG_CALL_NO_WG, i32, env, i32, i32, i32)
-DEF_HELPER_FLAGS_4(float_madd_d, TCG_CALL_NO_WG, i64, env, i64, i64, i64)
+DEF_HELPER_FLAGS_2(itofd, TCG_CALL_NO_RWG, i64, env, i64)
+DEF_HELPER_FLAGS_2(itofs, TCG_CALL_NO_RWG, i32, env, i32)
+DEF_HELPER_FLAGS_2(ftoid, TCG_CALL_NO_RWG, i64, env, i64)
+DEF_HELPER_FLAGS_2(ftois, TCG_CALL_NO_RWG, i32, env, i32)
+
+DEF_HELPER_FLAGS_4(float_madd_s, TCG_CALL_NO_RWG, i32, env, i32, i32, i32)
+DEF_HELPER_FLAGS_4(float_madd_d, TCG_CALL_NO_RWG, i64, env, i64, i64, i64)
 
 #define FOP_CALC(op)                                            \
-DEF_HELPER_FLAGS_3(float_ ## op ## _s, TCG_CALL_NO_WG, i32, env, i32, i32) \
-DEF_HELPER_FLAGS_3(float_ ## op ## _d, TCG_CALL_NO_WG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(float_ ## op ## _s, TCG_CALL_NO_RWG, i32, env, i32, i32) \
+DEF_HELPER_FLAGS_3(float_ ## op ## _d, TCG_CALL_NO_RWG, i64, env, i64, i64)
 FOP_CALC(add)
 FOP_CALC(sub)
 FOP_CALC(mul)
@@ -43,14 +45,11 @@ FOP_CALC(rem)
 #undef FOP_CALC
 
 #define FOP_CMP(op)                                              \
-DEF_HELPER_FLAGS_3(float_ ## op ## _s, TCG_CALL_NO_WG, i32, env, i32, i32) \
-DEF_HELPER_FLAGS_3(float_ ## op ## _d, TCG_CALL_NO_WG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(float_ ## op ## _s, TCG_CALL_NO_RWG, tl, env, i32, i32) \
+DEF_HELPER_FLAGS_3(float_ ## op ## _d, TCG_CALL_NO_RWG, tl, env, i64, i64)
 FOP_CMP(eq)
 FOP_CMP(lt)
 FOP_CMP(le)
-FOP_CMP(ne)
-FOP_CMP(gt)
-FOP_CMP(ge)
 #undef FOP_CMP
 
 /* interrupt */
diff --git a/target/openrisc/fpu_helper.c b/target/openrisc/fpu_helper.c
index 977a1e8e55..265ce13337 100644
--- a/target/openrisc/fpu_helper.c
+++ b/target/openrisc/fpu_helper.c
@@ -24,121 +24,70 @@
 #include "exception.h"
 #include "fpu/softfloat.h"
 
-static inline uint32_t ieee_ex_to_openrisc(OpenRISCCPU *cpu, int fexcp)
+static int ieee_ex_to_openrisc(int fexcp)
 {
     int ret = 0;
-    if (fexcp) {
-        if (fexcp & float_flag_invalid) {
-            cpu->env.fpcsr |= FPCSR_IVF;
-            ret = 1;
-        }
-        if (fexcp & float_flag_overflow) {
-            cpu->env.fpcsr |= FPCSR_OVF;
-            ret = 1;
-        }
-        if (fexcp & float_flag_underflow) {
-            cpu->env.fpcsr |= FPCSR_UNF;
-            ret = 1;
-        }
-        if (fexcp & float_flag_divbyzero) {
-            cpu->env.fpcsr |= FPCSR_DZF;
-            ret = 1;
-        }
-        if (fexcp & float_flag_inexact) {
-            cpu->env.fpcsr |= FPCSR_IXF;
-            ret = 1;
-        }
+    if (fexcp & float_flag_invalid) {
+        ret |= FPCSR_IVF;
+    }
+    if (fexcp & float_flag_overflow) {
+        ret |= FPCSR_OVF;
+    }
+    if (fexcp & float_flag_underflow) {
+        ret |= FPCSR_UNF;
+    }
+    if (fexcp & float_flag_divbyzero) {
+        ret |= FPCSR_DZF;
+    }
+    if (fexcp & float_flag_inexact) {
+        ret |= FPCSR_IXF;
     }
-
     return ret;
 }
 
-static inline void update_fpcsr(OpenRISCCPU *cpu)
+void HELPER(update_fpcsr)(CPUOpenRISCState *env)
 {
-    int tmp = ieee_ex_to_openrisc(cpu,
-                              get_float_exception_flags(&cpu->env.fp_status));
+    int tmp = get_float_exception_flags(&env->fp_status);
 
-    SET_FP_CAUSE(cpu->env.fpcsr, tmp);
-    if ((GET_FP_ENABLE(cpu->env.fpcsr) & tmp) &&
-        (cpu->env.fpcsr & FPCSR_FPEE)) {
-        helper_exception(&cpu->env, EXCP_FPE);
-    } else {
-        UPDATE_FP_FLAGS(cpu->env.fpcsr, tmp);
+    if (tmp) {
+        set_float_exception_flags(0, &env->fp_status);
+        tmp = ieee_ex_to_openrisc(tmp);
+        if (tmp) {
+            env->fpcsr |= tmp;
+            if (env->fpcsr & FPCSR_FPEE) {
+                helper_exception(env, EXCP_FPE);
+            }
+        }
     }
 }
 
 uint64_t HELPER(itofd)(CPUOpenRISCState *env, uint64_t val)
 {
-    uint64_t itofd;
-    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
-
-    set_float_exception_flags(0, &cpu->env.fp_status);
-    itofd = int32_to_float64(val, &cpu->env.fp_status);
-    update_fpcsr(cpu);
-
-    return itofd;
+    return int32_to_float64(val, &env->fp_status);
 }
 
 uint32_t HELPER(itofs)(CPUOpenRISCState *env, uint32_t val)
 {
-    uint32_t itofs;
-    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
-
-    set_float_exception_flags(0, &cpu->env.fp_status);
-    itofs = int32_to_float32(val, &cpu->env.fp_status);
-    update_fpcsr(cpu);
-
-    return itofs;
+    return int32_to_float32(val, &env->fp_status);
 }
 
 uint64_t HELPER(ftoid)(CPUOpenRISCState *env, uint64_t val)
 {
-    uint64_t ftoid;
-    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
-
-    set_float_exception_flags(0, &cpu->env.fp_status);
-    ftoid = float32_to_int64(val, &cpu->env.fp_status);
-    update_fpcsr(cpu);
-
-    return ftoid;
+    return float32_to_int64(val, &env->fp_status);
 }
 
 uint32_t HELPER(ftois)(CPUOpenRISCState *env, uint32_t val)
 {
-    uint32_t ftois;
-    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
-
-    set_float_exception_flags(0, &cpu->env.fp_status);
-    ftois = float32_to_int32(val, &cpu->env.fp_status);
-    update_fpcsr(cpu);
-
-    return ftois;
+    return float32_to_int32(val, &env->fp_status);
 }
 
-#define FLOAT_OP(name, p) void helper_float_##_##p(void)
-
 #define FLOAT_CALC(name)                                                  \
 uint64_t helper_float_ ## name ## _d(CPUOpenRISCState *env,               \
                                      uint64_t fdt0, uint64_t fdt1)        \
-{                                                                         \
-    uint64_t result;                                                      \
-    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);                         \
-    set_float_exception_flags(0, &cpu->env.fp_status);                    \
-    result = float64_ ## name(fdt0, fdt1, &cpu->env.fp_status);           \
-    update_fpcsr(cpu);                                                    \
-    return result;                                                        \
-}                                                                         \
-                                                                          \
+{ return float64_ ## name(fdt0, fdt1, &env->fp_status); }                 \
 uint32_t helper_float_ ## name ## _s(CPUOpenRISCState *env,               \
                                      uint32_t fdt0, uint32_t fdt1)        \
-{                                                                         \
-    uint32_t result;                                                      \
-    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);                         \
-    set_float_exception_flags(0, &cpu->env.fp_status);                    \
-    result = float32_ ## name(fdt0, fdt1, &cpu->env.fp_status);           \
-    update_fpcsr(cpu);                                                    \
-    return result;                                                        \
-}                                                                         \
+{ return float32_ ## name(fdt0, fdt1, &env->fp_status); }
 
 FLOAT_CALC(add)
 FLOAT_CALC(sub)
@@ -151,132 +100,29 @@ FLOAT_CALC(rem)
 uint64_t helper_float_madd_d(CPUOpenRISCState *env, uint64_t a,
                              uint64_t b, uint64_t c)
 {
-    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
-    uint64_t result;
-    set_float_exception_flags(0, &cpu->env.fp_status);
-    /* Note that or1ksim doesn't use merged operation.  */
-    result = float64_mul(b, c, &cpu->env.fp_status);
-    result = float64_add(result, a, &cpu->env.fp_status);
-    update_fpcsr(cpu);
-    return result;
+    /* Note that or1ksim doesn't use fused operation.  */
+    b = float64_mul(b, c, &env->fp_status);
+    return float64_add(a, b, &env->fp_status);
 }
 
 uint32_t helper_float_madd_s(CPUOpenRISCState *env, uint32_t a,
                              uint32_t b, uint32_t c)
 {
-    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
-    uint32_t result;
-    set_float_exception_flags(0, &cpu->env.fp_status);
-    /* Note that or1ksim doesn't use merged operation.  */
-    result = float32_mul(b, c, &cpu->env.fp_status);
-    result = float32_add(result, a, &cpu->env.fp_status);
-    update_fpcsr(cpu);
-    return result;
+    /* Note that or1ksim doesn't use fused operation.  */
+    b = float32_mul(b, c, &env->fp_status);
+    return float32_add(a, b, &env->fp_status);
 }
 
 
-#define FLOAT_CMP(name)                                                   \
-uint64_t helper_float_ ## name ## _d(CPUOpenRISCState *env,               \
-                                     uint64_t fdt0, uint64_t fdt1)        \
-{                                                                         \
-    int res;                                                              \
-    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);                         \
-    set_float_exception_flags(0, &cpu->env.fp_status);                    \
-    res = float64_ ## name(fdt0, fdt1, &cpu->env.fp_status);              \
-    update_fpcsr(cpu);                                                    \
-    return res;                                                           \
-}                                                                         \
-                                                                          \
-uint32_t helper_float_ ## name ## _s(CPUOpenRISCState *env,               \
-                                             uint32_t fdt0, uint32_t fdt1)\
-{                                                                         \
-    int res;                                                              \
-    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);                         \
-    set_float_exception_flags(0, &cpu->env.fp_status);                    \
-    res = float32_ ## name(fdt0, fdt1, &cpu->env.fp_status);              \
-    update_fpcsr(cpu);                                                    \
-    return res;                                                           \
-}
+#define FLOAT_CMP(name, impl)                                             \
+target_ulong helper_float_ ## name ## _d(CPUOpenRISCState *env,           \
+                                         uint64_t fdt0, uint64_t fdt1)    \
+{ return float64_ ## impl(fdt0, fdt1, &env->fp_status); }                 \
+target_ulong helper_float_ ## name ## _s(CPUOpenRISCState *env,           \
+                                         uint32_t fdt0, uint32_t fdt1)    \
+{ return float32_ ## impl(fdt0, fdt1, &env->fp_status); }
 
-FLOAT_CMP(le)
-FLOAT_CMP(eq)
-FLOAT_CMP(lt)
+FLOAT_CMP(le, le)
+FLOAT_CMP(lt, lt)
+FLOAT_CMP(eq, eq_quiet)
 #undef FLOAT_CMP
-
-
-#define FLOAT_CMPNE(name)                                                 \
-uint64_t helper_float_ ## name ## _d(CPUOpenRISCState *env,               \
-                                     uint64_t fdt0, uint64_t fdt1)        \
-{                                                                         \
-    int res;                                                              \
-    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);                         \
-    set_float_exception_flags(0, &cpu->env.fp_status);                    \
-    res = !float64_eq_quiet(fdt0, fdt1, &cpu->env.fp_status);             \
-    update_fpcsr(cpu);                                                    \
-    return res;                                                           \
-}                                                                         \
-                                                                          \
-uint32_t helper_float_ ## name ## _s(CPUOpenRISCState *env,               \
-                                     uint32_t fdt0, uint32_t fdt1)        \
-{                                                                         \
-    int res;                                                              \
-    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);                         \
-    set_float_exception_flags(0, &cpu->env.fp_status);                    \
-    res = !float32_eq_quiet(fdt0, fdt1, &cpu->env.fp_status);             \
-    update_fpcsr(cpu);                                                    \
-    return res;                                                           \
-}
-
-FLOAT_CMPNE(ne)
-#undef FLOAT_CMPNE
-
-#define FLOAT_CMPGT(name)                                                 \
-uint64_t helper_float_ ## name ## _d(CPUOpenRISCState *env,               \
-                                     uint64_t fdt0, uint64_t fdt1)        \
-{                                                                         \
-    int res;                                                              \
-    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);                         \
-    set_float_exception_flags(0, &cpu->env.fp_status);                    \
-    res = !float64_le(fdt0, fdt1, &cpu->env.fp_status);                   \
-    update_fpcsr(cpu);                                                    \
-    return res;                                                           \
-}                                                                         \
-                                                                          \
-uint32_t helper_float_ ## name ## _s(CPUOpenRISCState *env,               \
-                                     uint32_t fdt0, uint32_t fdt1)        \
-{                                                                         \
-    int res;                                                              \
-    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);                         \
-    set_float_exception_flags(0, &cpu->env.fp_status);                    \
-    res = !float32_le(fdt0, fdt1, &cpu->env.fp_status);                   \
-    update_fpcsr(cpu);                                                    \
-    return res;                                                           \
-}
-FLOAT_CMPGT(gt)
-#undef FLOAT_CMPGT
-
-#define FLOAT_CMPGE(name)                                                 \
-uint64_t helper_float_ ## name ## _d(CPUOpenRISCState *env,               \
-                                     uint64_t fdt0, uint64_t fdt1)        \
-{                                                                         \
-    int res;                                                              \
-    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);                         \
-    set_float_exception_flags(0, &cpu->env.fp_status);                    \
-    res = !float64_lt(fdt0, fdt1, &cpu->env.fp_status);                   \
-    update_fpcsr(cpu);                                                    \
-    return res;                                                           \
-}                                                                         \
-                                                                          \
-uint32_t helper_float_ ## name ## _s(CPUOpenRISCState *env,               \
-                                     uint32_t fdt0, uint32_t fdt1)        \
-{                                                                         \
-    int res;                                                              \
-    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);                         \
-    set_float_exception_flags(0, &cpu->env.fp_status);                    \
-    res = !float32_lt(fdt0, fdt1, &cpu->env.fp_status);                   \
-    update_fpcsr(cpu);                                                    \
-    return res;                                                           \
-}
-
-FLOAT_CMPGE(ge)
-#undef FLOAT_CMPGE
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 2747b24cf0..6876317971 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1294,180 +1294,209 @@ static void dec_float(DisasContext *dc, uint32_t insn)
     rd = extract32(insn, 21, 5);
 
     switch (op0) {
-    case 0x00:    /* lf.add.s */
+    case 0x00: /* lf.add.s */
         LOG_DIS("lf.add.s r%d, r%d, r%d\n", rd, ra, rb);
         check_r0_write(rd);
         gen_helper_float_add_s(cpu_R[rd], cpu_env, cpu_R[ra], cpu_R[rb]);
+        gen_helper_update_fpcsr(cpu_env);
         break;
 
-    case 0x01:    /* lf.sub.s */
+    case 0x01: /* lf.sub.s */
         LOG_DIS("lf.sub.s r%d, r%d, r%d\n", rd, ra, rb);
         check_r0_write(rd);
         gen_helper_float_sub_s(cpu_R[rd], cpu_env, cpu_R[ra], cpu_R[rb]);
+        gen_helper_update_fpcsr(cpu_env);
         break;
 
     case 0x02:    /* lf.mul.s */
         LOG_DIS("lf.mul.s r%d, r%d, r%d\n", rd, ra, rb);
         check_r0_write(rd);
         gen_helper_float_mul_s(cpu_R[rd], cpu_env, cpu_R[ra], cpu_R[rb]);
+        gen_helper_update_fpcsr(cpu_env);
         break;
 
-    case 0x03:    /* lf.div.s */
+    case 0x03: /* lf.div.s */
         LOG_DIS("lf.div.s r%d, r%d, r%d\n", rd, ra, rb);
         check_r0_write(rd);
         gen_helper_float_div_s(cpu_R[rd], cpu_env, cpu_R[ra], cpu_R[rb]);
+        gen_helper_update_fpcsr(cpu_env);
         break;
 
-    case 0x04:    /* lf.itof.s */
+    case 0x04: /* lf.itof.s */
         LOG_DIS("lf.itof r%d, r%d\n", rd, ra);
         check_r0_write(rd);
         gen_helper_itofs(cpu_R[rd], cpu_env, cpu_R[ra]);
+        gen_helper_update_fpcsr(cpu_env);
         break;
 
-    case 0x05:    /* lf.ftoi.s */
+    case 0x05: /* lf.ftoi.s */
         LOG_DIS("lf.ftoi r%d, r%d\n", rd, ra);
         check_r0_write(rd);
         gen_helper_ftois(cpu_R[rd], cpu_env, cpu_R[ra]);
+        gen_helper_update_fpcsr(cpu_env);
         break;
 
-    case 0x06:    /* lf.rem.s */
+    case 0x06: /* lf.rem.s */
         LOG_DIS("lf.rem.s r%d, r%d, r%d\n", rd, ra, rb);
         check_r0_write(rd);
         gen_helper_float_rem_s(cpu_R[rd], cpu_env, cpu_R[ra], cpu_R[rb]);
+        gen_helper_update_fpcsr(cpu_env);
         break;
 
-    case 0x07:    /* lf.madd.s */
+    case 0x07: /* lf.madd.s */
         LOG_DIS("lf.madd.s r%d, r%d, r%d\n", rd, ra, rb);
         check_r0_write(rd);
         gen_helper_float_madd_s(cpu_R[rd], cpu_env, cpu_R[rd],
                                 cpu_R[ra], cpu_R[rb]);
+        gen_helper_update_fpcsr(cpu_env);
         break;
 
-    case 0x08:    /* lf.sfeq.s */
+    case 0x08: /* lf.sfeq.s */
         LOG_DIS("lf.sfeq.s r%d, r%d\n", ra, rb);
         gen_helper_float_eq_s(cpu_sr_f, cpu_env, cpu_R[ra], cpu_R[rb]);
+        gen_helper_update_fpcsr(cpu_env);
         break;
 
-    case 0x09:    /* lf.sfne.s */
+    case 0x09: /* lf.sfne.s */
         LOG_DIS("lf.sfne.s r%d, r%d\n", ra, rb);
-        gen_helper_float_ne_s(cpu_sr_f, cpu_env, cpu_R[ra], cpu_R[rb]);
+        gen_helper_float_eq_s(cpu_sr_f, cpu_env, cpu_R[ra], cpu_R[rb]);
+        tcg_gen_xori_tl(cpu_sr_f, cpu_sr_f, 1);
+        gen_helper_update_fpcsr(cpu_env);
         break;
 
-    case 0x0a:    /* lf.sfgt.s */
+    case 0x0a: /* lf.sfgt.s */
         LOG_DIS("lf.sfgt.s r%d, r%d\n", ra, rb);
-        gen_helper_float_gt_s(cpu_sr_f, cpu_env, cpu_R[ra], cpu_R[rb]);
+        gen_helper_float_lt_s(cpu_sr_f, cpu_env, cpu_R[rb], cpu_R[ra]);
+        gen_helper_update_fpcsr(cpu_env);
         break;
 
-    case 0x0b:    /* lf.sfge.s */
+    case 0x0b: /* lf.sfge.s */
         LOG_DIS("lf.sfge.s r%d, r%d\n", ra, rb);
-        gen_helper_float_ge_s(cpu_sr_f, cpu_env, cpu_R[ra], cpu_R[rb]);
+        gen_helper_float_le_s(cpu_sr_f, cpu_env, cpu_R[rb], cpu_R[ra]);
+        gen_helper_update_fpcsr(cpu_env);
         break;
 
-    case 0x0c:    /* lf.sflt.s */
+    case 0x0c: /* lf.sflt.s */
         LOG_DIS("lf.sflt.s r%d, r%d\n", ra, rb);
         gen_helper_float_lt_s(cpu_sr_f, cpu_env, cpu_R[ra], cpu_R[rb]);
+        gen_helper_update_fpcsr(cpu_env);
         break;
 
-    case 0x0d:    /* lf.sfle.s */
+    case 0x0d: /* lf.sfle.s */
         LOG_DIS("lf.sfle.s r%d, r%d\n", ra, rb);
         gen_helper_float_le_s(cpu_sr_f, cpu_env, cpu_R[ra], cpu_R[rb]);
+        gen_helper_update_fpcsr(cpu_env);
         break;
 
-/* not used yet, open it when we need or64.  */
-/*#ifdef TARGET_OPENRISC64
-    case 0x10:     lf.add.d
+#ifdef TARGET_OPENRISC64
+    case 0x10: /* lf.add.d */
         LOG_DIS("lf.add.d r%d, r%d, r%d\n", rd, ra, rb);
         check_of64s(dc);
         check_r0_write(rd);
         gen_helper_float_add_d(cpu_R[rd], cpu_env, cpu_R[ra], cpu_R[rb]);
+        gen_helper_update_fpcsr(cpu_env);
         break;
 
-    case 0x11:     lf.sub.d
+    case 0x11: /* lf.sub.d */
         LOG_DIS("lf.sub.d r%d, r%d, r%d\n", rd, ra, rb);
         check_of64s(dc);
         check_r0_write(rd);
         gen_helper_float_sub_d(cpu_R[rd], cpu_env, cpu_R[ra], cpu_R[rb]);
+        gen_helper_update_fpcsr(cpu_env);
         break;
 
-    case 0x12:     lf.mul.d
+    case 0x12: /* lf.mul.d */
         LOG_DIS("lf.mul.d r%d, r%d, r%d\n", rd, ra, rb);
         check_of64s(dc);
         check_r0_write(rd);
         gen_helper_float_mul_d(cpu_R[rd], cpu_env, cpu_R[ra], cpu_R[rb]);
+        gen_helper_update_fpcsr(cpu_env);
         break;
 
-    case 0x13:     lf.div.d
+    case 0x13: /* lf.div.d */
         LOG_DIS("lf.div.d r%d, r%d, r%d\n", rd, ra, rb);
         check_of64s(dc);
         check_r0_write(rd);
         gen_helper_float_div_d(cpu_R[rd], cpu_env, cpu_R[ra], cpu_R[rb]);
+        gen_helper_update_fpcsr(cpu_env);
         break;
 
-    case 0x14:     lf.itof.d
+    case 0x14: /* lf.itof.d */
         LOG_DIS("lf.itof r%d, r%d\n", rd, ra);
         check_of64s(dc);
         check_r0_write(rd);
         gen_helper_itofd(cpu_R[rd], cpu_env, cpu_R[ra]);
+        gen_helper_update_fpcsr(cpu_env);
         break;
 
-    case 0x15:     lf.ftoi.d
+    case 0x15: /* lf.ftoi.d */
         LOG_DIS("lf.ftoi r%d, r%d\n", rd, ra);
         check_of64s(dc);
         check_r0_write(rd);
         gen_helper_ftoid(cpu_R[rd], cpu_env, cpu_R[ra]);
+        gen_helper_update_fpcsr(cpu_env);
         break;
 
-    case 0x16:     lf.rem.d
+    case 0x16: /* lf.rem.d */
         LOG_DIS("lf.rem.d r%d, r%d, r%d\n", rd, ra, rb);
         check_of64s(dc);
         check_r0_write(rd);
         gen_helper_float_rem_d(cpu_R[rd], cpu_env, cpu_R[ra], cpu_R[rb]);
+        gen_helper_update_fpcsr(cpu_env);
         break;
 
-    case 0x17:     lf.madd.d
+    case 0x17: /* lf.madd.d */
         LOG_DIS("lf.madd.d r%d, r%d, r%d\n", rd, ra, rb);
         check_of64s(dc);
         check_r0_write(rd);
         gen_helper_float_madd_d(cpu_R[rd], cpu_env, cpu_R[rd],
                                 cpu_R[ra], cpu_R[rb]);
+        gen_helper_update_fpcsr(cpu_env);
         break;
 
-    case 0x18:     lf.sfeq.d
+    case 0x18: /* lf.sfeq.d */
         LOG_DIS("lf.sfeq.d r%d, r%d\n", ra, rb);
         check_of64s(dc);
         gen_helper_float_eq_d(cpu_sr_f, cpu_env, cpu_R[ra], cpu_R[rb]);
+        gen_helper_update_fpcsr(cpu_env);
         break;
 
-    case 0x1a:     lf.sfgt.d
+    case 0x1a: /* lf.sfgt.d */
         LOG_DIS("lf.sfgt.d r%d, r%d\n", ra, rb);
         check_of64s(dc);
-        gen_helper_float_gt_d(cpu_sr_f, cpu_env, cpu_R[ra], cpu_R[rb]);
+        gen_helper_float_lt_d(cpu_sr_f, cpu_env, cpu_R[rb], cpu_R[ra]);
+        gen_helper_update_fpcsr(cpu_env);
         break;
 
-    case 0x1b:     lf.sfge.d
+    case 0x1b: /* lf.sfge.d */
         LOG_DIS("lf.sfge.d r%d, r%d\n", ra, rb);
         check_of64s(dc);
-        gen_helper_float_ge_d(cpu_sr_f, cpu_env, cpu_R[ra], cpu_R[rb]);
+        gen_helper_float_le_d(cpu_sr_f, cpu_env, cpu_R[rb], cpu_R[ra]);
+        gen_helper_update_fpcsr(cpu_env);
         break;
 
-    case 0x19:     lf.sfne.d
+    case 0x19: /* lf.sfne.d */
         LOG_DIS("lf.sfne.d r%d, r%d\n", ra, rb);
         check_of64s(dc);
-        gen_helper_float_ne_d(cpu_sr_f, cpu_env, cpu_R[ra], cpu_R[rb]);
+        gen_helper_float_eq_d(cpu_sr_f, cpu_env, cpu_R[ra], cpu_R[rb]);
+        tcg_gen_xori_tl(cpu_sr_f, cpu_sr_f, 1);
+        gen_helper_update_fpcsr(cpu_env);
         break;
 
-    case 0x1c:     lf.sflt.d
+    case 0x1c: /* lf.sflt.d */
         LOG_DIS("lf.sflt.d r%d, r%d\n", ra, rb);
         check_of64s(dc);
         gen_helper_float_lt_d(cpu_sr_f, cpu_env, cpu_R[ra], cpu_R[rb]);
+        gen_helper_update_fpcsr(cpu_env);
         break;
 
-    case 0x1d:     lf.sfle.d
+    case 0x1d: /* lf.sfle.d */
         LOG_DIS("lf.sfle.d r%d, r%d\n", ra, rb);
         check_of64s(dc);
         gen_helper_float_le_d(cpu_sr_f, cpu_env, cpu_R[ra], cpu_R[rb]);
+        gen_helper_update_fpcsr(cpu_env);
         break;
-#endif*/
+#endif
 
     default:
         gen_illegal_exception(dc);
-- 
2.17.0
