Received: from eggs.gnu.org ([2001:4830:134:3::10]:45630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cdO90-00059F-LE
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cdO8y-0001eO-KL
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:46 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cdO8y-0001e7-Ew
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:44 -0500
Received: by mail-qk0-x243.google.com with SMTP id p22so8994315qka.3
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 13:26:44 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 14 Feb 2017 08:25:32 +1100
Message-Id: <20170213212536.31871-21-rth@twiddle.net>
In-Reply-To: <20170213212536.31871-1-rth@twiddle.net>
References: <20170213212536.31871-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 20/24] target/openrisc: Fix madd
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

Note that the specification for lf.madd.s is confused.  It's
the only mention of supposed FPMADDHI/FPMADDLO special registers.
On the other hand, or1ksim implements a somewhat normal non-fused
multiply and add.  Mirror that.

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/openrisc/cpu.h        |  3 --
 target/openrisc/fpu_helper.c | 68 ++++++++++++++++----------------------------
 target/openrisc/helper.h     |  7 ++---
 target/openrisc/translate.c  | 13 +++------
 4 files changed, 30 insertions(+), 61 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 9528277..0694038 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -279,9 +279,6 @@ typedef struct CPUOpenRISCState {
 
     uint64_t mac;             /* Multiply registers MACHI:MACLO */
 
-    target_ulong fpmaddhi;    /* Multiply and add float register FPMADDHI */
-    target_ulong fpmaddlo;    /* Multiply and add float register FPMADDLO */
-
     target_ulong epcr;        /* Exception PC register */
     target_ulong eear;        /* Exception EA register */
 
diff --git a/target/openrisc/fpu_helper.c b/target/openrisc/fpu_helper.c
index c54404b..1375cea 100644
--- a/target/openrisc/fpu_helper.c
+++ b/target/openrisc/fpu_helper.c
@@ -146,52 +146,32 @@ FLOAT_CALC(div)
 FLOAT_CALC(rem)
 #undef FLOAT_CALC
 
-#define FLOAT_TERNOP(name1, name2)                                        \
-uint64_t helper_float_ ## name1 ## name2 ## _d(CPUOpenRISCState *env,     \
-                                               uint64_t fdt0,             \
-                                               uint64_t fdt1)             \
-{                                                                         \
-    uint64_t result, temp, hi, lo;                                        \
-    uint32_t val1, val2;                                                  \
-    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);                         \
-    hi = env->fpmaddhi;                                                   \
-    lo = env->fpmaddlo;                                                   \
-    set_float_exception_flags(0, &cpu->env.fp_status);                    \
-    result = float64_ ## name1(fdt0, fdt1, &cpu->env.fp_status);          \
-    lo &= 0xffffffff;                                                     \
-    hi &= 0xffffffff;                                                     \
-    temp = (hi << 32) | lo;                                               \
-    result = float64_ ## name2(result, temp, &cpu->env.fp_status);        \
-    val1 = result >> 32;                                                  \
-    val2 = (uint32_t) (result & 0xffffffff);                              \
-    update_fpcsr(cpu);                                                    \
-    cpu->env.fpmaddlo = val2;                                             \
-    cpu->env.fpmaddhi = val1;                                             \
-    return 0;                                                             \
-}                                                                         \
-                                                                          \
-uint32_t helper_float_ ## name1 ## name2 ## _s(CPUOpenRISCState *env,     \
-                                            uint32_t fdt0, uint32_t fdt1) \
-{                                                                         \
-    uint64_t result, temp, hi, lo;                                        \
-    uint32_t val1, val2;                                                  \
-    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);                         \
-    hi = cpu->env.fpmaddhi;                                               \
-    lo = cpu->env.fpmaddlo;                                               \
-    set_float_exception_flags(0, &cpu->env.fp_status);                    \
-    result = float64_ ## name1(fdt0, fdt1, &cpu->env.fp_status);          \
-    temp = (hi << 32) | lo;                                               \
-    result = float64_ ## name2(result, temp, &cpu->env.fp_status);        \
-    val1 = result >> 32;                                                  \
-    val2 = (uint32_t) (result & 0xffffffff);                              \
-    update_fpcsr(cpu);                                                    \
-    cpu->env.fpmaddlo = val2;                                             \
-    cpu->env.fpmaddhi = val1;                                             \
-    return 0;                                                             \
+
+uint64_t helper_float_madd_d(CPUOpenRISCState *env, uint64_t a,
+                             uint64_t b, uint64_t c)
+{
+    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
+    uint64_t result;
+    set_float_exception_flags(0, &cpu->env.fp_status);
+    /* Note that or1ksim doesn't use merged operation.  */
+    result = float64_mul(b, c, &cpu->env.fp_status);
+    result = float64_add(result, a, &cpu->env.fp_status);
+    update_fpcsr(cpu);
+    return result;
 }
 
-FLOAT_TERNOP(mul, add)
-#undef FLOAT_TERNOP
+uint32_t helper_float_madd_s(CPUOpenRISCState *env, uint32_t a,
+                             uint32_t b, uint32_t c)
+{
+    OpenRISCCPU *cpu = openrisc_env_get_cpu(env);
+    uint32_t result;
+    set_float_exception_flags(0, &cpu->env.fp_status);
+    /* Note that or1ksim doesn't use merged operation.  */
+    result = float32_mul(b, c, &cpu->env.fp_status);
+    result = float32_add(result, a, &cpu->env.fp_status);
+    update_fpcsr(cpu);
+    return result;
+}
 
 
 #define FLOAT_CMP(name)                                                   \
diff --git a/target/openrisc/helper.h b/target/openrisc/helper.h
index 78a123d..4fd1a6b 100644
--- a/target/openrisc/helper.h
+++ b/target/openrisc/helper.h
@@ -29,11 +29,8 @@ DEF_HELPER_FLAGS_2(itofs, TCG_CALL_NO_WG, i32, env, i32)
 DEF_HELPER_FLAGS_2(ftoid, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_2(ftois, TCG_CALL_NO_WG, i32, env, i32)
 
-#define FOP_MADD(op)                                             \
-DEF_HELPER_FLAGS_3(float_ ## op ## _s, TCG_CALL_NO_WG, i32, env, i32, i32) \
-DEF_HELPER_FLAGS_3(float_ ## op ## _d, TCG_CALL_NO_WG, i64, env, i64, i64)
-FOP_MADD(muladd)
-#undef FOP_MADD
+DEF_HELPER_FLAGS_4(float_madd_s, TCG_CALL_NO_WG, i32, env, i32, i32, i32)
+DEF_HELPER_FLAGS_4(float_madd_d, TCG_CALL_NO_WG, i64, env, i64, i64, i64)
 
 #define FOP_CALC(op)                                            \
 DEF_HELPER_FLAGS_3(float_ ## op ## _s, TCG_CALL_NO_WG, i32, env, i32, i32) \
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index ce9672e..66064e1 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -61,7 +61,6 @@ static TCGv cpu_lock_addr;
 static TCGv cpu_lock_value;
 static TCGv_i32 fpcsr;
 static TCGv_i64 cpu_mac;        /* MACHI:MACLO */
-static TCGv fpmaddhi, fpmaddlo;
 static TCGv_i32 env_flags;
 #include "exec/gen-icount.h"
 
@@ -108,12 +107,6 @@ void openrisc_translate_init(void)
     cpu_mac = tcg_global_mem_new_i64(cpu_env,
                                      offsetof(CPUOpenRISCState, mac),
                                      "mac");
-    fpmaddhi = tcg_global_mem_new(cpu_env,
-                                  offsetof(CPUOpenRISCState, fpmaddhi),
-                                  "fpmaddhi");
-    fpmaddlo = tcg_global_mem_new(cpu_env,
-                                  offsetof(CPUOpenRISCState, fpmaddlo),
-                                  "fpmaddlo");
     for (i = 0; i < 32; i++) {
         cpu_R[i] = tcg_global_mem_new(cpu_env,
                                       offsetof(CPUOpenRISCState, gpr[i]),
@@ -1324,7 +1317,8 @@ static void dec_float(DisasContext *dc, uint32_t insn)
 
     case 0x07:    /* lf.madd.s */
         LOG_DIS("lf.madd.s r%d, r%d, r%d\n", rd, ra, rb);
-        gen_helper_float_muladd_s(cpu_R[rd], cpu_env, cpu_R[ra], cpu_R[rb]);
+        gen_helper_float_madd_s(cpu_R[rd], cpu_env, cpu_R[rd],
+                                cpu_R[ra], cpu_R[rb]);
         break;
 
     case 0x08:    /* lf.sfeq.s */
@@ -1409,7 +1403,8 @@ static void dec_float(DisasContext *dc, uint32_t insn)
     case 0x17:     lf.madd.d
         LOG_DIS("lf.madd.d r%d, r%d, r%d\n", rd, ra, rb);
         check_of64s(dc);
-        gen_helper_float_muladd_d(cpu_R[rd], cpu_env, cpu_R[ra], cpu_R[rb]);
+        gen_helper_float_madd_d(cpu_R[rd], cpu_env, cpu_R[rd],
+                                cpu_R[ra], cpu_R[rb]);
         break;
 
     case 0x18:     lf.sfeq.d
-- 
2.9.3
