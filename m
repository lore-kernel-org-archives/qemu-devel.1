Received: from eggs.gnu.org ([2001:4830:134:3::10]:33864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNiLJ-00027A-SD
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:19:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNiLF-0001w2-AJ
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:18:57 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNiLF-0001vp-2V
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:18:53 -0400
Received: by mail-qt0-x243.google.com with SMTP id x58so27992379qtc.2
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 09:18:53 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170620205121.26515-1-laurent@vivier.eu>
	<20170620205121.26515-4-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b05fb631-4ccb-39fa-adc3-6949a514b9d2@amsat.org>
Date: Wed, 21 Jun 2017 13:18:47 -0300
MIME-Version: 1.0
In-Reply-To: <20170620205121.26515-4-laurent@vivier.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 3/6] target-m68k: use floatx80 internally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Thomas Huth <huth@tuxfamily.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

Hi Laurent,

On 06/20/2017 05:51 PM, Laurent Vivier wrote:
> Coldfire uses float64, but 680x0 use floatx80.
> This patch introduces the use of floatx80 internally
> and enables 680x0 80bits FPU.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/cpu.c        |   4 +-
>  target/m68k/cpu.h        |  15 +-
>  target/m68k/fpu_helper.c |  85 ++++---
>  target/m68k/helper.c     |  12 +-
>  target/m68k/helper.h     |  37 +--
>  target/m68k/qregs.def    |   1 -
>  target/m68k/translate.c  | 646 ++++++++++++++++++++++++++++++-----------------
>  7 files changed, 509 insertions(+), 291 deletions(-)
>
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index f2e031f..435456f 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -49,7 +49,7 @@ static void m68k_cpu_reset(CPUState *s)
>      M68kCPU *cpu = M68K_CPU(s);
>      M68kCPUClass *mcc = M68K_CPU_GET_CLASS(cpu);
>      CPUM68KState *env = &cpu->env;
> -    float64 nan = float64_default_nan(NULL);
> +    floatx80 nan = floatx80_default_nan(NULL);
>      int i;
>
>      mcc->parent_reset(s);
> @@ -60,7 +60,7 @@ static void m68k_cpu_reset(CPUState *s)
>  #endif
>      m68k_switch_sp(env);
>      for (i = 0; i < 8; i++) {
> -        env->fregs[i] = nan;
> +        env->fregs[i].d = nan;
>      }
>      env->fpcr = 0;
>      env->fpsr = 0;
> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> index 384ec5d..beb8ebc 100644
> --- a/target/m68k/cpu.h
> +++ b/target/m68k/cpu.h
> @@ -55,8 +55,15 @@
>  #define EXCP_UNINITIALIZED  15
>  #define EXCP_TRAP0          32   /* User trap #0.  */
>  #define EXCP_TRAP15         47   /* User trap #15.  */
> +#define EXCP_FP_BSUN        48 /* Branch Set on Unordered */
> +#define EXCP_FP_INEX        49 /* Inexact result */
> +#define EXCP_FP_DZ          50 /* Divide by Zero */
> +#define EXCP_FP_UNFL        51 /* Underflow */
> +#define EXCP_FP_OPERR       52 /* Operand Error */
> +#define EXCP_FP_OVFL        53 /* Overflow */
> +#define EXCP_FP_SNAN        54 /* Signaling Not-A-Number */
> +#define EXCP_FP_UNIMP       55 /* Unimplemented Data type */
>  #define EXCP_UNSUPPORTED    61
> -#define EXCP_ICE            13
>
>  #define EXCP_RTE            0x100
>  #define EXCP_HALT_INSN      0x101
> @@ -64,6 +71,8 @@
>  #define NB_MMU_MODES 2
>  #define TARGET_INSN_START_EXTRA_WORDS 1
>
> +typedef CPU_LDoubleU FPReg;

What an awful name... Anyway checking on "qemu/bswap.h" it seems there 
is some endianess issue with it if your host is little-endian.

Do you have a way to run Berkeley TestFloat? I think due to license 
restrictions we may still be able to add release 2a in the qtest suite.
(see the thread "Future of SoftFloat use in QEMU​" at 
https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg01730.html)

We could then run some float80 unit-test either endians.

> +
>  typedef struct CPUM68KState {
>      uint32_t dregs[8];
>      uint32_t aregs[8];
> @@ -82,8 +91,8 @@ typedef struct CPUM68KState {
>      uint32_t cc_c; /* either 0/1, unused, or computed from cc_n and cc_v */
>      uint32_t cc_z; /* == 0 or unused */
>
> -    float64 fregs[8];
> -    float64 fp_result;
> +    FPReg fregs[8];
> +    FPReg fp_result;
>      uint32_t fpcr;
>      uint32_t fpsr;
>      float_status fp_status;
> diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
> index 5bf2576..f4d3821 100644
> --- a/target/m68k/fpu_helper.c
> +++ b/target/m68k/fpu_helper.c
> @@ -21,92 +21,101 @@
>  #include "qemu/osdep.h"
>  #include "cpu.h"
>  #include "exec/helper-proto.h"
> +#include "exec/exec-all.h"
>
> -uint32_t HELPER(f64_to_i32)(CPUM68KState *env, float64 val)
> +int32_t HELPER(reds32)(CPUM68KState *env, FPReg *val)
>  {
> -    return float64_to_int32(val, &env->fp_status);
> +    return floatx80_to_int32(val->d, &env->fp_status);
>  }
>
> -float32 HELPER(f64_to_f32)(CPUM68KState *env, float64 val)
> +float32 HELPER(redf32)(CPUM68KState *env, FPReg *val)
>  {
> -    return float64_to_float32(val, &env->fp_status);
> +    return floatx80_to_float32(val->d, &env->fp_status);
>  }
>
> -float64 HELPER(i32_to_f64)(CPUM68KState *env, uint32_t val)
> +void HELPER(exts32)(CPUM68KState *env, FPReg *res, int32_t val)
>  {
> -    return int32_to_float64(val, &env->fp_status);
> +    res->d = int32_to_floatx80(val, &env->fp_status);
>  }
>
> -float64 HELPER(f32_to_f64)(CPUM68KState *env, float32 val)
> +void HELPER(extf32)(CPUM68KState *env, FPReg *res, float32 val)
>  {
> -    return float32_to_float64(val, &env->fp_status);
> +    res->d = float32_to_floatx80(val, &env->fp_status);
>  }
>
> -float64 HELPER(iround_f64)(CPUM68KState *env, float64 val)
> +void HELPER(extf64)(CPUM68KState *env, FPReg *res, float64 val)
>  {
> -    return float64_round_to_int(val, &env->fp_status);
> +    res->d = float64_to_floatx80(val, &env->fp_status);
>  }
>
> -float64 HELPER(itrunc_f64)(CPUM68KState *env, float64 val)
> +float64 HELPER(redf64)(CPUM68KState *env, FPReg *val)
>  {
> -    return float64_trunc_to_int(val, &env->fp_status);
> +    return floatx80_to_float64(val->d, &env->fp_status);
>  }
>
> -float64 HELPER(sqrt_f64)(CPUM68KState *env, float64 val)
> +void HELPER(firound)(CPUM68KState *env, FPReg *res, FPReg *val)
>  {
> -    return float64_sqrt(val, &env->fp_status);
> +    res->d = floatx80_round_to_int(val->d, &env->fp_status);
>  }
>
> -float64 HELPER(abs_f64)(float64 val)
> +void HELPER(fitrunc)(CPUM68KState *env, FPReg *res, FPReg *val)
>  {
> -    return float64_abs(val);
> +    res->d = floatx80_round_to_int(val->d, &env->fp_status);
>  }
>
> -float64 HELPER(chs_f64)(float64 val)
> +void HELPER(fsqrt)(CPUM68KState *env, FPReg *res, FPReg *val)
>  {
> -    return float64_chs(val);
> +    res->d = floatx80_sqrt(val->d, &env->fp_status);
>  }
>
> -float64 HELPER(add_f64)(CPUM68KState *env, float64 a, float64 b)
> +void HELPER(fabs)(CPUM68KState *env, FPReg *res, FPReg *val)
>  {
> -    return float64_add(a, b, &env->fp_status);
> +    res->d = floatx80_abs(val->d);
>  }
>
> -float64 HELPER(sub_f64)(CPUM68KState *env, float64 a, float64 b)
> +void HELPER(fchs)(CPUM68KState *env, FPReg *res, FPReg *val)
>  {
> -    return float64_sub(a, b, &env->fp_status);
> +    res->d = floatx80_chs(val->d);
>  }
>
> -float64 HELPER(mul_f64)(CPUM68KState *env, float64 a, float64 b)
> +void HELPER(fadd)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
>  {
> -    return float64_mul(a, b, &env->fp_status);
> +    res->d = floatx80_add(val0->d, val1->d, &env->fp_status);
>  }
>
> -float64 HELPER(div_f64)(CPUM68KState *env, float64 a, float64 b)
> +void HELPER(fsub)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
>  {
> -    return float64_div(a, b, &env->fp_status);
> +    res->d = floatx80_sub(val1->d, val0->d, &env->fp_status);
>  }
>
> -float64 HELPER(sub_cmp_f64)(CPUM68KState *env, float64 a, float64 b)
> +void HELPER(fmul)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
> +{
> +    res->d = floatx80_mul(val0->d, val1->d, &env->fp_status);
> +}
> +
> +void HELPER(fdiv)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
> +{
> +    res->d = floatx80_div(val1->d, val0->d, &env->fp_status);
> +}
> +
> +void HELPER(fsub_cmp)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
>  {
>      /* ??? This may incorrectly raise exceptions.  */
>      /* ??? Should flush denormals to zero.  */
> -    float64 res;
> -    res = float64_sub(a, b, &env->fp_status);
> -    if (float64_is_quiet_nan(res, &env->fp_status)) {
> +    res->d = floatx80_sub(val0->d, val1->d, &env->fp_status);
> +    if (floatx80_is_quiet_nan(res->d, &env->fp_status)) {
>          /* +/-inf compares equal against itself, but sub returns nan.  */
> -        if (!float64_is_quiet_nan(a, &env->fp_status)
> -            && !float64_is_quiet_nan(b, &env->fp_status)) {
> -            res = float64_zero;
> -            if (float64_lt_quiet(a, res, &env->fp_status)) {
> -                res = float64_chs(res);
> +        if (!floatx80_is_quiet_nan(val0->d, &env->fp_status)
> +            && !floatx80_is_quiet_nan(val1->d, &env->fp_status)) {
> +            res->d = floatx80_zero;
> +            if (floatx80_lt_quiet(val0->d, res->d, &env->fp_status)) {
> +                res->d = floatx80_chs(res->d);
>              }
>          }
>      }
> -    return res;
>  }
>
> -uint32_t HELPER(compare_f64)(CPUM68KState *env, float64 val)
> +uint32_t HELPER(fcompare)(CPUM68KState *env, FPReg *val)
>  {
> -    return float64_compare_quiet(val, float64_zero, &env->fp_status);
> +    return floatx80_compare_quiet(val->d, floatx80_zero, &env->fp_status);
>  }
> diff --git a/target/m68k/helper.c b/target/m68k/helper.c
> index 5ca9911..8bfc881 100644
> --- a/target/m68k/helper.c
> +++ b/target/m68k/helper.c
> @@ -73,10 +73,11 @@ void m68k_cpu_list(FILE *f, fprintf_function cpu_fprintf)
>      g_slist_free(list);
>  }
>
> -static int fpu_gdb_get_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
> +static int cf_fpu_gdb_get_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
>  {
>      if (n < 8) {
> -        stfq_p(mem_buf, env->fregs[n]);
> +        float_status s;
> +        stfq_p(mem_buf, floatx80_to_float64(env->fregs[n].d, &s));
>          return 8;
>      }
>      if (n < 11) {
> @@ -87,10 +88,11 @@ static int fpu_gdb_get_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
>      return 0;
>  }
>
> -static int fpu_gdb_set_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
> +static int cf_fpu_gdb_set_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
>  {
>      if (n < 8) {
> -        env->fregs[n] = ldfq_p(mem_buf);
> +        float_status s;
> +        env->fregs[n].d = float64_to_floatx80(ldfq_p(mem_buf), &s);
>          return 8;
>      }
>      if (n < 11) {
> @@ -126,7 +128,7 @@ void m68k_cpu_init_gdb(M68kCPU *cpu)
>      CPUM68KState *env = &cpu->env;
>
>      if (m68k_feature(env, M68K_FEATURE_CF_FPU)) {
> -        gdb_register_coprocessor(cs, fpu_gdb_get_reg, fpu_gdb_set_reg,
> +        gdb_register_coprocessor(cs, cf_fpu_gdb_get_reg, cf_fpu_gdb_set_reg,
>                                   11, "cf-fp.xml", 18);
>      }
>      /* TODO: Add [E]MAC registers.  */
> diff --git a/target/m68k/helper.h b/target/m68k/helper.h
> index d7a4bf1..d871be6 100644
> --- a/target/m68k/helper.h
> +++ b/target/m68k/helper.h
> @@ -12,21 +12,28 @@ DEF_HELPER_3(movec, void, env, i32, i32)
>  DEF_HELPER_4(cas2w, void, env, i32, i32, i32)
>  DEF_HELPER_4(cas2l, void, env, i32, i32, i32)
>
> -DEF_HELPER_2(f64_to_i32, f32, env, f64)
> -DEF_HELPER_2(f64_to_f32, f32, env, f64)
> -DEF_HELPER_2(i32_to_f64, f64, env, i32)
> -DEF_HELPER_2(f32_to_f64, f64, env, f32)
> -DEF_HELPER_2(iround_f64, f64, env, f64)
> -DEF_HELPER_2(itrunc_f64, f64, env, f64)
> -DEF_HELPER_2(sqrt_f64, f64, env, f64)
> -DEF_HELPER_1(abs_f64, f64, f64)
> -DEF_HELPER_1(chs_f64, f64, f64)
> -DEF_HELPER_3(add_f64, f64, env, f64, f64)
> -DEF_HELPER_3(sub_f64, f64, env, f64, f64)
> -DEF_HELPER_3(mul_f64, f64, env, f64, f64)
> -DEF_HELPER_3(div_f64, f64, env, f64, f64)
> -DEF_HELPER_3(sub_cmp_f64, f64, env, f64, f64)
> -DEF_HELPER_2(compare_f64, i32, env, f64)
> +#define dh_alias_fp ptr
> +#define dh_ctype_fp FPReg *
> +#define dh_is_signed_fp dh_is_signed_ptr
> +
> +DEF_HELPER_3(exts32, void, env, fp, s32)
> +DEF_HELPER_3(extf32, void, env, fp, f32)
> +DEF_HELPER_3(extf64, void, env, fp, f64)
> +DEF_HELPER_2(redf32, f32, env, fp)
> +DEF_HELPER_2(redf64, f64, env, fp)
> +DEF_HELPER_2(reds32, s32, env, fp)
> +
> +DEF_HELPER_3(firound, void, env, fp, fp)
> +DEF_HELPER_3(fitrunc, void, env, fp, fp)
> +DEF_HELPER_3(fsqrt, void, env, fp, fp)
> +DEF_HELPER_3(fabs, void, env, fp, fp)
> +DEF_HELPER_3(fchs, void, env, fp, fp)
> +DEF_HELPER_4(fadd, void, env, fp, fp, fp)
> +DEF_HELPER_4(fsub, void, env, fp, fp, fp)
> +DEF_HELPER_4(fmul, void, env, fp, fp, fp)
> +DEF_HELPER_4(fdiv, void, env, fp, fp, fp)
> +DEF_HELPER_4(fsub_cmp, void, env, fp, fp, fp)
> +DEF_HELPER_2(fcompare, i32, env, fp)
>
>  DEF_HELPER_3(mac_move, void, env, i32, i32)
>  DEF_HELPER_3(macmulf, i64, env, i32, i32)
> diff --git a/target/m68k/qregs.def b/target/m68k/qregs.def
> index 51ff43b..1aadc62 100644
> --- a/target/m68k/qregs.def
> +++ b/target/m68k/qregs.def
> @@ -1,4 +1,3 @@
> -DEFF64(FP_RESULT, fp_result)
>  DEFO32(PC, pc)
>  DEFO32(SR, sr)
>  DEFO32(CC_OP, cc_op)
> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
> index c9a5fe4..73f691f 100644
> --- a/target/m68k/translate.c
> +++ b/target/m68k/translate.c
> @@ -32,37 +32,27 @@
>  #include "trace-tcg.h"
>  #include "exec/log.h"
>
> -
>  //#define DEBUG_DISPATCH 1
>
> -/* Fake floating point.  */
> -#define tcg_gen_mov_f64 tcg_gen_mov_i64
> -#define tcg_gen_qemu_ldf64 tcg_gen_qemu_ld64
> -#define tcg_gen_qemu_stf64 tcg_gen_qemu_st64
> -
>  #define DEFO32(name, offset) static TCGv QREG_##name;
>  #define DEFO64(name, offset) static TCGv_i64 QREG_##name;
> -#define DEFF64(name, offset) static TCGv_i64 QREG_##name;
>  #include "qregs.def"
>  #undef DEFO32
>  #undef DEFO64
> -#undef DEFF64
>
>  static TCGv_i32 cpu_halted;
>  static TCGv_i32 cpu_exception_index;
>
>  static TCGv_env cpu_env;
>
> -static char cpu_reg_names[3*8*3 + 5*4];
> +static char cpu_reg_names[2 * 8 * 3 + 5 * 4];
>  static TCGv cpu_dregs[8];
>  static TCGv cpu_aregs[8];
> -static TCGv_i64 cpu_fregs[8];
>  static TCGv_i64 cpu_macc[4];
>
>  #define REG(insn, pos)  (((insn) >> (pos)) & 7)
>  #define DREG(insn, pos) cpu_dregs[REG(insn, pos)]
>  #define AREG(insn, pos) get_areg(s, REG(insn, pos))
> -#define FREG(insn, pos) cpu_fregs[REG(insn, pos)]
>  #define MACREG(acc)     cpu_macc[acc]
>  #define QREG_SP         get_areg(s, 7)
>
> @@ -87,11 +77,9 @@ void m68k_tcg_init(void)
>  #define DEFO64(name, offset) \
>      QREG_##name = tcg_global_mem_new_i64(cpu_env, \
>          offsetof(CPUM68KState, offset), #name);
> -#define DEFF64(name, offset) DEFO64(name, offset)
>  #include "qregs.def"
>  #undef DEFO32
>  #undef DEFO64
> -#undef DEFF64
>
>      cpu_halted = tcg_global_mem_new_i32(cpu_env,
>                                          -offsetof(M68kCPU, env) +
> @@ -111,10 +99,6 @@ void m68k_tcg_init(void)
>          cpu_aregs[i] = tcg_global_mem_new(cpu_env,
>                                            offsetof(CPUM68KState, aregs[i]), p);
>          p += 3;
> -        sprintf(p, "F%d", i);
> -        cpu_fregs[i] = tcg_global_mem_new_i64(cpu_env,
> -                                          offsetof(CPUM68KState, fregs[i]), p);
> -        p += 3;
>      }
>      for (i = 0; i < 4; i++) {
>          sprintf(p, "ACC%d", i);
> @@ -265,6 +249,42 @@ static void update_cc_op(DisasContext *s)
>      }
>  }
>
> +/* Generate a jump to an immediate address.  */
> +static void gen_jmp_im(DisasContext *s, uint32_t dest)
> +{
> +    update_cc_op(s);
> +    tcg_gen_movi_i32(QREG_PC, dest);
> +    s->is_jmp = DISAS_JUMP;
> +}
> +
> +/* Generate a jump to the address in qreg DEST.  */
> +static void gen_jmp(DisasContext *s, TCGv dest)
> +{
> +    update_cc_op(s);
> +    tcg_gen_mov_i32(QREG_PC, dest);
> +    s->is_jmp = DISAS_JUMP;
> +}
> +
> +static void gen_raise_exception(int nr)
> +{
> +    TCGv_i32 tmp = tcg_const_i32(nr);
> +
> +    gen_helper_raise_exception(cpu_env, tmp);
> +    tcg_temp_free_i32(tmp);
> +}
> +
> +static void gen_exception(DisasContext *s, uint32_t where, int nr)
> +{
> +    update_cc_op(s);
> +    gen_jmp_im(s, where);
> +    gen_raise_exception(nr);
> +}
> +
> +static inline void gen_addr_fault(DisasContext *s)
> +{
> +    gen_exception(s, s->insn_pc, EXCP_ADDRESS);
> +}
> +
>  /* Generate a load from the specified address.  Narrow values are
>     sign extended to full register width.  */
>  static inline TCGv gen_load(DisasContext * s, int opsize, TCGv addr, int sign)
> @@ -286,7 +306,6 @@ static inline TCGv gen_load(DisasContext * s, int opsize, TCGv addr, int sign)
>              tcg_gen_qemu_ld16u(tmp, addr, index);
>          break;
>      case OS_LONG:
> -    case OS_SINGLE:
>          tcg_gen_qemu_ld32u(tmp, addr, index);
>          break;
>      default:
> @@ -296,16 +315,6 @@ static inline TCGv gen_load(DisasContext * s, int opsize, TCGv addr, int sign)
>      return tmp;
>  }
>
> -static inline TCGv_i64 gen_load64(DisasContext * s, TCGv addr)
> -{
> -    TCGv_i64 tmp;
> -    int index = IS_USER(s);
> -    tmp = tcg_temp_new_i64();
> -    tcg_gen_qemu_ldf64(tmp, addr, index);
> -    gen_throws_exception = gen_last_qop;
> -    return tmp;
> -}
> -
>  /* Generate a store.  */
>  static inline void gen_store(DisasContext *s, int opsize, TCGv addr, TCGv val)
>  {
> @@ -318,7 +327,6 @@ static inline void gen_store(DisasContext *s, int opsize, TCGv addr, TCGv val)
>          tcg_gen_qemu_st16(val, addr, index);
>          break;
>      case OS_LONG:
> -    case OS_SINGLE:
>          tcg_gen_qemu_st32(val, addr, index);
>          break;
>      default:
> @@ -327,13 +335,6 @@ static inline void gen_store(DisasContext *s, int opsize, TCGv addr, TCGv val)
>      gen_throws_exception = gen_last_qop;
>  }
>
> -static inline void gen_store64(DisasContext *s, TCGv addr, TCGv_i64 val)
> -{
> -    int index = IS_USER(s);
> -    tcg_gen_qemu_stf64(val, addr, index);
> -    gen_throws_exception = gen_last_qop;
> -}
> -
>  typedef enum {
>      EA_STORE,
>      EA_LOADU,
> @@ -377,6 +378,15 @@ static inline uint32_t read_im32(CPUM68KState *env, DisasContext *s)
>      return im;
>  }
>
> +/* Read a 64-bit immediate constant.  */
> +static inline uint64_t read_im64(CPUM68KState *env, DisasContext *s)
> +{
> +    uint64_t im;
> +    im = (uint64_t)read_im32(env, s) << 32;
> +    im |= (uint64_t)read_im32(env, s);
> +    return im;
> +}
> +
>  /* Calculate and address index.  */
>  static TCGv gen_addr_index(DisasContext *s, uint16_t ext, TCGv tmp)
>  {
> @@ -909,6 +919,304 @@ static TCGv gen_ea(CPUM68KState *env, DisasContext *s, uint16_t insn,
>      return gen_ea_mode(env, s, mode, reg0, opsize, val, addrp, what);
>  }
>
> +static TCGv_ptr gen_fp_ptr(int freg)
> +{
> +    TCGv_ptr fp = tcg_temp_new_ptr();
> +    tcg_gen_addi_ptr(fp, cpu_env, offsetof(CPUM68KState, fregs[freg]));
> +    return fp;
> +}
> +
> +static TCGv_ptr gen_fp_result_ptr(void)
> +{
> +    TCGv_ptr fp = tcg_temp_new_ptr();
> +    tcg_gen_addi_ptr(fp, cpu_env, offsetof(CPUM68KState, fp_result));
> +    return fp;
> +}
> +
> +static void gen_fp_move(TCGv_ptr dest, TCGv_ptr src)
> +{
> +    TCGv t32;
> +    TCGv_i64 t64;
> +
> +    t32 = tcg_temp_new();
> +    tcg_gen_ld16u_i32(t32, src, offsetof(FPReg, l.upper));
> +    tcg_gen_st16_i32(t32, dest, offsetof(FPReg, l.upper));
> +    tcg_temp_free(t32);
> +
> +    t64 = tcg_temp_new_i64();
> +    tcg_gen_ld_i64(t64, src, offsetof(FPReg, l.lower));
> +    tcg_gen_st_i64(t64, dest, offsetof(FPReg, l.lower));
> +    tcg_temp_free_i64(t64);
> +}
> +
> +static void gen_load_fp(DisasContext *s, int opsize, TCGv addr, TCGv_ptr fp)
> +{
> +    TCGv tmp;
> +    TCGv_i64 t64;
> +    int index = IS_USER(s);
> +
> +    t64 = tcg_temp_new_i64();
> +    tmp = tcg_temp_new();
> +    switch (opsize) {
> +    case OS_BYTE:
> +        tcg_gen_qemu_ld8s(tmp, addr, index);
> +        gen_helper_exts32(cpu_env, fp, tmp);
> +        break;
> +    case OS_WORD:
> +        tcg_gen_qemu_ld16s(tmp, addr, index);
> +        gen_helper_exts32(cpu_env, fp, tmp);
> +        break;
> +    case OS_LONG:
> +        tcg_gen_qemu_ld32u(tmp, addr, index);
> +        gen_helper_exts32(cpu_env, fp, tmp);
> +        break;
> +    case OS_SINGLE:
> +        tcg_gen_qemu_ld32u(tmp, addr, index);
> +        gen_helper_extf32(cpu_env, fp, tmp);
> +        break;
> +    case OS_DOUBLE:
> +        tcg_gen_qemu_ld64(t64, addr, index);
> +        gen_helper_extf64(cpu_env, fp, t64);
> +        tcg_temp_free_i64(t64);
> +        break;
> +    case OS_EXTENDED:
> +        if (m68k_feature(s->env, M68K_FEATURE_CF_FPU)) {
> +            gen_exception(s, s->insn_pc, EXCP_FP_UNIMP);
> +            break;
> +        }
> +        tcg_gen_qemu_ld32u(tmp, addr, index);
> +        tcg_gen_shri_i32(tmp, tmp, 16);
> +        tcg_gen_st16_i32(tmp, fp, offsetof(FPReg, l.upper));
> +        tcg_gen_addi_i32(tmp, addr, 4);
> +        tcg_gen_qemu_ld64(t64, tmp, index);
> +        tcg_gen_st_i64(t64, fp, offsetof(FPReg, l.lower));
> +        break;
> +    case OS_PACKED:
> +        /* unimplemented data type on 68040/ColdFire
> +         * FIXME if needed for another FPU
> +         */
> +        gen_exception(s, s->insn_pc, EXCP_FP_UNIMP);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +    tcg_temp_free(tmp);
> +    tcg_temp_free_i64(t64);
> +    gen_throws_exception = gen_last_qop;
> +}
> +
> +static void gen_store_fp(DisasContext *s, int opsize, TCGv addr, TCGv_ptr fp)
> +{
> +    TCGv tmp;
> +    TCGv_i64 t64;
> +    int index = IS_USER(s);
> +
> +    t64 = tcg_temp_new_i64();
> +    tmp = tcg_temp_new();
> +    switch (opsize) {
> +    case OS_BYTE:
> +        gen_helper_reds32(tmp, cpu_env, fp);
> +        tcg_gen_qemu_st8(tmp, addr, index);
> +        break;
> +    case OS_WORD:
> +        gen_helper_reds32(tmp, cpu_env, fp);
> +        tcg_gen_qemu_st16(tmp, addr, index);
> +        break;
> +    case OS_LONG:
> +        gen_helper_reds32(tmp, cpu_env, fp);
> +        tcg_gen_qemu_st32(tmp, addr, index);
> +        break;
> +    case OS_SINGLE:
> +        gen_helper_redf32(tmp, cpu_env, fp);
> +        tcg_gen_qemu_st32(tmp, addr, index);
> +        break;
> +    case OS_DOUBLE:
> +        gen_helper_redf64(t64, cpu_env, fp);
> +        tcg_gen_qemu_st64(t64, addr, index);
> +        break;
> +    case OS_EXTENDED:
> +        if (m68k_feature(s->env, M68K_FEATURE_CF_FPU)) {
> +            gen_exception(s, s->insn_pc, EXCP_FP_UNIMP);
> +            break;
> +        }
> +        tcg_gen_ld16u_i32(tmp, fp, offsetof(FPReg, l.upper));
> +        tcg_gen_shli_i32(tmp, tmp, 16);
> +        tcg_gen_qemu_st32(tmp, addr, index);
> +        tcg_gen_addi_i32(tmp, addr, 4);
> +        tcg_gen_ld_i64(t64, fp, offsetof(FPReg, l.lower));
> +        tcg_gen_qemu_st64(t64, tmp, index);
> +        break;
> +    case OS_PACKED:
> +        /* unimplemented data type on 68040/ColdFire
> +         * FIXME if needed for another FPU
> +         */
> +        gen_exception(s, s->insn_pc, EXCP_FP_UNIMP);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +    tcg_temp_free(tmp);
> +    tcg_temp_free_i64(t64);
> +    gen_throws_exception = gen_last_qop;
> +}
> +
> +static void gen_ldst_fp(DisasContext *s, int opsize, TCGv addr,
> +                        TCGv_ptr fp, ea_what what)
> +{
> +    if (what == EA_STORE) {
> +        gen_store_fp(s, opsize, addr, fp);
> +    } else {
> +        gen_load_fp(s, opsize, addr, fp);
> +    }
> +}
> +
> +static int gen_ea_mode_fp(CPUM68KState *env, DisasContext *s, int mode,
> +                          int reg0, int opsize, TCGv_ptr fp, ea_what what)
> +{
> +    TCGv reg, addr, tmp;
> +    TCGv_i64 t64;
> +
> +    switch (mode) {
> +    case 0: /* Data register direct.  */
> +        reg = cpu_dregs[reg0];
> +        if (what == EA_STORE) {
> +            switch (opsize) {
> +            case OS_BYTE:
> +            case OS_WORD:
> +            case OS_LONG:
> +                gen_helper_reds32(reg, cpu_env, fp);
> +                break;
> +            case OS_SINGLE:
> +                gen_helper_redf32(reg, cpu_env, fp);
> +                break;
> +            default:
> +                g_assert_not_reached();
> +            }
> +        } else {
> +            tmp = tcg_temp_new();
> +            switch (opsize) {
> +            case OS_BYTE:
> +                tcg_gen_ext8s_i32(tmp, reg);
> +                gen_helper_exts32(cpu_env, fp, tmp);
> +                break;
> +            case OS_WORD:
> +                tcg_gen_ext16s_i32(tmp, reg);
> +                gen_helper_exts32(cpu_env, fp, tmp);
> +                break;
> +            case OS_LONG:
> +                gen_helper_exts32(cpu_env, fp, reg);
> +                break;
> +            case OS_SINGLE:
> +                gen_helper_extf32(cpu_env, fp, reg);
> +                break;
> +            default:
> +                g_assert_not_reached();
> +            }
> +            tcg_temp_free(tmp);
> +        }
> +        return 0;
> +    case 1: /* Address register direct.  */
> +        return -1;
> +    case 2: /* Indirect register */
> +        addr = get_areg(s, reg0);
> +        gen_ldst_fp(s, opsize, addr, fp, what);
> +        return 0;
> +    case 3: /* Indirect postincrement.  */
> +        addr = cpu_aregs[reg0];
> +        gen_ldst_fp(s, opsize, addr, fp, what);
> +        tcg_gen_addi_i32(addr, addr, opsize_bytes(opsize));
> +        return 0;
> +    case 4: /* Indirect predecrememnt.  */
> +        addr = gen_lea_mode(env, s, mode, reg0, opsize);
> +        if (IS_NULL_QREG(addr)) {
> +            return -1;
> +        }
> +        gen_ldst_fp(s, opsize, addr, fp, what);
> +        tcg_gen_mov_i32(cpu_aregs[reg0], addr);
> +        return 0;
> +    case 5: /* Indirect displacement.  */
> +    case 6: /* Indirect index + displacement.  */
> +    do_indirect:
> +        addr = gen_lea_mode(env, s, mode, reg0, opsize);
> +        if (IS_NULL_QREG(addr)) {
> +            return -1;
> +        }
> +        gen_ldst_fp(s, opsize, addr, fp, what);
> +        return 0;
> +    case 7: /* Other */
> +        switch (reg0) {
> +        case 0: /* Absolute short.  */
> +        case 1: /* Absolute long.  */
> +        case 2: /* pc displacement  */
> +        case 3: /* pc index+displacement.  */
> +            goto do_indirect;
> +        case 4: /* Immediate.  */
> +            if (what == EA_STORE) {
> +                return -1;
> +            }
> +            switch (opsize) {
> +            case OS_BYTE:
> +                tmp = tcg_const_i32((int8_t)read_im8(env, s));
> +                gen_helper_exts32(cpu_env, fp, tmp);
> +                tcg_temp_free(tmp);
> +                break;
> +            case OS_WORD:
> +                tmp = tcg_const_i32((int16_t)read_im16(env, s));
> +                gen_helper_exts32(cpu_env, fp, tmp);
> +                tcg_temp_free(tmp);
> +                break;
> +            case OS_LONG:
> +                tmp = tcg_const_i32(read_im32(env, s));
> +                gen_helper_exts32(cpu_env, fp, tmp);
> +                tcg_temp_free(tmp);
> +                break;
> +            case OS_SINGLE:
> +                tmp = tcg_const_i32(read_im32(env, s));
> +                gen_helper_extf32(cpu_env, fp, tmp);
> +                tcg_temp_free(tmp);
> +                break;
> +            case OS_DOUBLE:
> +                t64 = tcg_const_i64(read_im64(env, s));
> +                gen_helper_extf64(cpu_env, fp, t64);
> +                tcg_temp_free_i64(t64);
> +                break;
> +            case OS_EXTENDED:
> +                if (m68k_feature(s->env, M68K_FEATURE_CF_FPU)) {
> +                    gen_exception(s, s->insn_pc, EXCP_FP_UNIMP);
> +                    break;
> +                }
> +                tmp = tcg_const_i32(read_im32(env, s) >> 16);
> +                tcg_gen_st16_i32(tmp, fp, offsetof(FPReg, l.upper));
> +                tcg_temp_free(tmp);
> +                t64 = tcg_const_i64(read_im64(env, s));
> +                tcg_gen_st_i64(t64, fp, offsetof(FPReg, l.lower));
> +                tcg_temp_free_i64(t64);
> +                break;
> +            case OS_PACKED:
> +                /* unimplemented data type on 68040/ColdFire
> +                 * FIXME if needed for another FPU
> +                 */
> +                gen_exception(s, s->insn_pc, EXCP_FP_UNIMP);
> +                break;
> +            default:
> +                g_assert_not_reached();
> +            }
> +            return 0;
> +        default:
> +            return -1;
> +        }
> +    }
> +    return -1;
> +}
> +
> +static int gen_ea_fp(CPUM68KState *env, DisasContext *s, uint16_t insn,
> +                       int opsize, TCGv_ptr fp, ea_what what)
> +{
> +    int mode = extract32(insn, 3, 3);
> +    int reg0 = REG(insn, 0);
> +    return gen_ea_mode_fp(env, s, mode, reg0, opsize, fp, what);
> +}
> +
>  typedef struct {
>      TCGCond tcond;
>      bool g1;
> @@ -1124,42 +1432,6 @@ static void gen_lookup_tb(DisasContext *s)
>      s->is_jmp = DISAS_UPDATE;
>  }
>
> -/* Generate a jump to an immediate address.  */
> -static void gen_jmp_im(DisasContext *s, uint32_t dest)
> -{
> -    update_cc_op(s);
> -    tcg_gen_movi_i32(QREG_PC, dest);
> -    s->is_jmp = DISAS_JUMP;
> -}
> -
> -/* Generate a jump to the address in qreg DEST.  */
> -static void gen_jmp(DisasContext *s, TCGv dest)
> -{
> -    update_cc_op(s);
> -    tcg_gen_mov_i32(QREG_PC, dest);
> -    s->is_jmp = DISAS_JUMP;
> -}
> -
> -static void gen_raise_exception(int nr)
> -{
> -    TCGv_i32 tmp = tcg_const_i32(nr);
> -
> -    gen_helper_raise_exception(cpu_env, tmp);
> -    tcg_temp_free_i32(tmp);
> -}
> -
> -static void gen_exception(DisasContext *s, uint32_t where, int nr)
> -{
> -    update_cc_op(s);
> -    gen_jmp_im(s, where);
> -    gen_raise_exception(nr);
> -}
> -
> -static inline void gen_addr_fault(DisasContext *s)
> -{
> -    gen_exception(s, s->insn_pc, EXCP_ADDRESS);
> -}
> -
>  #define SRC_EA(env, result, opsize, op_sign, addrp) do {                \
>          result = gen_ea(env, s, insn, opsize, NULL_QREG, addrp,         \
>                          op_sign ? EA_LOADS : EA_LOADU);                 \
> @@ -4133,15 +4405,11 @@ undef:
>  DISAS_INSN(fpu)
>  {
>      uint16_t ext;
> -    int32_t offset;
>      int opmode;
> -    TCGv_i64 src;
> -    TCGv_i64 dest;
> -    TCGv_i64 res;
>      TCGv tmp32;
>      int round;
> -    int set_dest;
>      int opsize;
> +    TCGv_ptr cpu_src, cpu_dest;
>
>      ext = read_im16(env, s);
>      opmode = ext & 0x7f;
> @@ -4151,59 +4419,12 @@ DISAS_INSN(fpu)
>      case 1:
>          goto undef;
>      case 3: /* fmove out */
> -        src = FREG(ext, 7);
> -        tmp32 = tcg_temp_new_i32();
> -        /* fmove */
> -        /* ??? TODO: Proper behavior on overflow.  */
> -
> +        cpu_src = gen_fp_ptr(REG(ext, 7));
>          opsize = ext_opsize(ext, 10);
> -        switch (opsize) {
> -        case OS_LONG:
> -            gen_helper_f64_to_i32(tmp32, cpu_env, src);
> -            break;
> -        case OS_SINGLE:
> -            gen_helper_f64_to_f32(tmp32, cpu_env, src);
> -            break;
> -        case OS_WORD:
> -            gen_helper_f64_to_i32(tmp32, cpu_env, src);
> -            break;
> -        case OS_DOUBLE:
> -            tcg_gen_mov_i32(tmp32, AREG(insn, 0));
> -            switch ((insn >> 3) & 7) {
> -            case 2:
> -            case 3:
> -                break;
> -            case 4:
> -                tcg_gen_addi_i32(tmp32, tmp32, -8);
> -                break;
> -            case 5:
> -                offset = cpu_ldsw_code(env, s->pc);
> -                s->pc += 2;
> -                tcg_gen_addi_i32(tmp32, tmp32, offset);
> -                break;
> -            default:
> -                goto undef;
> -            }
> -            gen_store64(s, tmp32, src);
> -            switch ((insn >> 3) & 7) {
> -            case 3:
> -                tcg_gen_addi_i32(tmp32, tmp32, 8);
> -                tcg_gen_mov_i32(AREG(insn, 0), tmp32);
> -                break;
> -            case 4:
> -                tcg_gen_mov_i32(AREG(insn, 0), tmp32);
> -                break;
> -            }
> -            tcg_temp_free_i32(tmp32);
> -            return;
> -        case OS_BYTE:
> -            gen_helper_f64_to_i32(tmp32, cpu_env, src);
> -            break;
> -        default:
> -            goto undef;
> +        if (gen_ea_fp(env, s, insn, opsize, cpu_src, EA_STORE) == -1) {
> +            gen_addr_fault(s);
>          }
> -        DEST_EA(env, insn, opsize, tmp32, NULL);
> -        tcg_temp_free_i32(tmp32);
> +        tcg_temp_free_ptr(cpu_src);
>          return;
>      case 4: /* fmove to control register.  */
>      case 5: /* fmove from control register.  */
> @@ -4213,6 +4434,7 @@ DISAS_INSN(fpu)
>      case 7:
>          {
>              TCGv addr;
> +            TCGv_ptr fp;
>              uint16_t mask;
>              int i;
>              if ((ext & 0x1f00) != 0x1000 || (ext & 0xff) == 0)
> @@ -4225,136 +4447,86 @@ DISAS_INSN(fpu)
>              addr = tcg_temp_new_i32();
>              tcg_gen_mov_i32(addr, tmp32);
>              mask = 0x80;
> +            fp = tcg_temp_new_ptr();
>              for (i = 0; i < 8; i++) {
>                  if (ext & mask) {
> -                    dest = FREG(i, 0);
> -                    if (ext & (1 << 13)) {
> -                        /* store */
> -                        tcg_gen_qemu_stf64(dest, addr, IS_USER(s));
> -                    } else {
> -                        /* load */
> -                        tcg_gen_qemu_ldf64(dest, addr, IS_USER(s));
> -                    }
> +                    tcg_gen_addi_ptr(fp, cpu_env,
> +                                     offsetof(CPUM68KState, fregs[i]));
> +                    gen_ldst_fp(s, OS_DOUBLE, addr, fp,
> +                                (ext & (1 << 13)) ?  EA_STORE : EA_LOADS);
>                      if (ext & (mask - 1))
>                          tcg_gen_addi_i32(addr, addr, 8);
>                  }
>                  mask >>= 1;
>              }
>              tcg_temp_free_i32(addr);
> +            tcg_temp_free_ptr(fp);
>          }
>          return;
>      }
>      if (ext & (1 << 14)) {
>          /* Source effective address.  */
>          opsize = ext_opsize(ext, 10);
> -        if (opsize == OS_DOUBLE) {
> -            tmp32 = tcg_temp_new_i32();
> -            tcg_gen_mov_i32(tmp32, AREG(insn, 0));
> -            switch ((insn >> 3) & 7) {
> -            case 2:
> -            case 3:
> -                break;
> -            case 4:
> -                tcg_gen_addi_i32(tmp32, tmp32, -8);
> -                break;
> -            case 5:
> -                offset = cpu_ldsw_code(env, s->pc);
> -                s->pc += 2;
> -                tcg_gen_addi_i32(tmp32, tmp32, offset);
> -                break;
> -            case 7:
> -                offset = cpu_ldsw_code(env, s->pc);
> -                offset += s->pc - 2;
> -                s->pc += 2;
> -                tcg_gen_addi_i32(tmp32, tmp32, offset);
> -                break;
> -            default:
> -                goto undef;
> -            }
> -            src = gen_load64(s, tmp32);
> -            switch ((insn >> 3) & 7) {
> -            case 3:
> -                tcg_gen_addi_i32(tmp32, tmp32, 8);
> -                tcg_gen_mov_i32(AREG(insn, 0), tmp32);
> -                break;
> -            case 4:
> -                tcg_gen_mov_i32(AREG(insn, 0), tmp32);
> -                break;
> -            }
> -            tcg_temp_free_i32(tmp32);
> -        } else {
> -            SRC_EA(env, tmp32, opsize, 1, NULL);
> -            src = tcg_temp_new_i64();
> -            switch (opsize) {
> -            case OS_LONG:
> -            case OS_WORD:
> -            case OS_BYTE:
> -                gen_helper_i32_to_f64(src, cpu_env, tmp32);
> -                break;
> -            case OS_SINGLE:
> -                gen_helper_f32_to_f64(src, cpu_env, tmp32);
> -                break;
> -            }
> +        cpu_src = gen_fp_result_ptr();
> +        if (gen_ea_fp(env, s, insn, opsize, cpu_src, EA_LOADS) == -1) {
> +            gen_addr_fault(s);
> +            return;
>          }
>      } else {
>          /* Source register.  */
> -        src = FREG(ext, 10);
> +        opsize = OS_EXTENDED;
> +        cpu_src = gen_fp_ptr(REG(ext, 10));
>      }
> -    dest = FREG(ext, 7);
> -    res = tcg_temp_new_i64();
> -    if (opmode != 0x3a)
> -        tcg_gen_mov_f64(res, dest);
>      round = 1;
> -    set_dest = 1;
> +    cpu_dest = gen_fp_ptr(REG(ext, 7));
>      switch (opmode) {
>      case 0: case 0x40: case 0x44: /* fmove */
> -        tcg_gen_mov_f64(res, src);
> +        gen_fp_move(cpu_dest, cpu_src);
>          break;
>      case 1: /* fint */
> -        gen_helper_iround_f64(res, cpu_env, src);
> +        gen_helper_firound(cpu_env, cpu_dest, cpu_src);
>          round = 0;
>          break;
>      case 3: /* fintrz */
> -        gen_helper_itrunc_f64(res, cpu_env, src);
> +        gen_helper_fitrunc(cpu_env, cpu_dest, cpu_src);
>          round = 0;
>          break;
>      case 4: case 0x41: case 0x45: /* fsqrt */
> -        gen_helper_sqrt_f64(res, cpu_env, src);
> +        gen_helper_fsqrt(cpu_env, cpu_dest, cpu_src);
>          break;
>      case 0x18: case 0x58: case 0x5c: /* fabs */
> -        gen_helper_abs_f64(res, src);
> +        gen_helper_fabs(cpu_env, cpu_dest, cpu_src);
>          break;
>      case 0x1a: case 0x5a: case 0x5e: /* fneg */
> -        gen_helper_chs_f64(res, src);
> +        gen_helper_fchs(cpu_env, cpu_dest, cpu_src);
>          break;
>      case 0x20: case 0x60: case 0x64: /* fdiv */
> -        gen_helper_div_f64(res, cpu_env, res, src);
> +        gen_helper_fdiv(cpu_env, cpu_dest, cpu_src, cpu_dest);
>          break;
>      case 0x22: case 0x62: case 0x66: /* fadd */
> -        gen_helper_add_f64(res, cpu_env, res, src);
> +        gen_helper_fadd(cpu_env, cpu_dest, cpu_src, cpu_dest);
>          break;
>      case 0x23: case 0x63: case 0x67: /* fmul */
> -        gen_helper_mul_f64(res, cpu_env, res, src);
> +        gen_helper_fmul(cpu_env, cpu_dest, cpu_src, cpu_dest);
>          break;
>      case 0x28: case 0x68: case 0x6c: /* fsub */
> -        gen_helper_sub_f64(res, cpu_env, res, src);
> +        gen_helper_fsub(cpu_env, cpu_dest, cpu_src, cpu_dest);
>          break;
>      case 0x38: /* fcmp */
> -        gen_helper_sub_cmp_f64(res, cpu_env, res, src);
> -        set_dest = 0;
> +        tcg_temp_free_ptr(cpu_dest);
> +        cpu_dest = gen_fp_result_ptr();
> +        gen_helper_fsub_cmp(cpu_env, cpu_dest, cpu_src, cpu_dest);
>          round = 0;
>          break;
>      case 0x3a: /* ftst */
> -        tcg_gen_mov_f64(res, src);
> -        set_dest = 0;
> +        tcg_temp_free_ptr(cpu_dest);
> +        cpu_dest = gen_fp_result_ptr();
> +        gen_fp_move(cpu_dest, cpu_src);
>          round = 0;
>          break;
>      default:
>          goto undef;
>      }
> -    if (ext & (1 << 14)) {
> -        tcg_temp_free_i64(src);
> -    }
>      if (round) {
>          if (opmode & 0x40) {
>              if ((opmode & 0x4) != 0)
> @@ -4364,16 +4536,18 @@ DISAS_INSN(fpu)
>          }
>      }
>      if (round) {
> -        TCGv tmp = tcg_temp_new_i32();
> -        gen_helper_f64_to_f32(tmp, cpu_env, res);
> -        gen_helper_f32_to_f64(res, cpu_env, tmp);
> -        tcg_temp_free_i32(tmp);
> -    }
> -    tcg_gen_mov_f64(QREG_FP_RESULT, res);
> -    if (set_dest) {
> -        tcg_gen_mov_f64(dest, res);
> +        TCGv tmp = tcg_temp_new();
> +        gen_helper_redf32(tmp, cpu_env, cpu_dest);
> +        gen_helper_extf32(cpu_env, cpu_dest, tmp);
> +        tcg_temp_free(tmp);
> +    } else {
> +        TCGv_i64 t64 = tcg_temp_new_i64();
> +        gen_helper_redf64(t64, cpu_env, cpu_dest);
> +        gen_helper_extf64(cpu_env, cpu_dest, t64);
> +        tcg_temp_free_i64(t64);
>      }
> -    tcg_temp_free_i64(res);
> +    tcg_temp_free_ptr(cpu_src);
> +    tcg_temp_free_ptr(cpu_dest);
>      return;
>  undef:
>      /* FIXME: Is this right for offset addressing modes?  */
> @@ -4387,6 +4561,7 @@ DISAS_INSN(fbcc)
>      uint32_t addr;
>      TCGv flag;
>      TCGLabel *l1;
> +    TCGv_ptr fp_result;
>
>      addr = s->pc;
>      offset = cpu_ldsw_code(env, s->pc);
> @@ -4398,7 +4573,9 @@ DISAS_INSN(fbcc)
>      l1 = gen_new_label();
>      /* TODO: Raise BSUN exception.  */
>      flag = tcg_temp_new();
> -    gen_helper_compare_f64(flag, cpu_env, QREG_FP_RESULT);
> +    fp_result = gen_fp_result_ptr();
> +    gen_helper_fcompare(flag, cpu_env, fp_result);
> +    tcg_temp_free_ptr(fp_result);
>      /* Jump to l1 if condition is true.  */
>      switch (insn & 0xf) {
>      case 0: /* f */
> @@ -5028,11 +5205,15 @@ void register_m68k_insns (CPUM68KState *env)
>      INSN(bfop_reg, eec0, fff8, BITFIELD);   /* bfset */
>      INSN(bfop_mem, e8c0, ffc0, BITFIELD);   /* bftst */
>      INSN(bfop_reg, e8c0, fff8, BITFIELD);   /* bftst */
> -    INSN(undef_fpu, f000, f000, CF_ISA_A);
> +    BASE(undef_fpu, f000, f000);
>      INSN(fpu,       f200, ffc0, CF_FPU);
>      INSN(fbcc,      f280, ffc0, CF_FPU);
>      INSN(frestore,  f340, ffc0, CF_FPU);
> -    INSN(fsave,     f340, ffc0, CF_FPU);
> +    INSN(fsave,     f300, ffc0, CF_FPU);
> +    INSN(fpu,       f200, ffc0, FPU);
> +    INSN(fbcc,      f280, ff80, FPU);
> +    INSN(frestore,  f340, ffc0, FPU);
> +    INSN(fsave,     f300, ffc0, FPU);
>      INSN(intouch,   f340, ffc0, CF_ISA_A);
>      INSN(cpushl,    f428, ff38, CF_ISA_A);
>      INSN(wddata,    fb00, ff00, CF_ISA_A);
> @@ -5158,6 +5339,18 @@ void gen_intermediate_code(CPUM68KState *env, TranslationBlock *tb)
>      tb->icount = num_insns;
>  }
>
> +static double floatx80_to_double(CPUM68KState *env, uint16_t high, uint64_t low)
> +{
> +    floatx80 a = { .high = high, .low = low };
> +    union {
> +        float64 f64;
> +        double d;
> +    } u;
> +
> +    u.f64 = floatx80_to_float64(a, &env->fp_status);
> +    return u.d;
> +}
> +
>  void m68k_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
>                           int flags)
>  {
> @@ -5165,20 +5358,19 @@ void m68k_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
>      CPUM68KState *env = &cpu->env;
>      int i;
>      uint16_t sr;
> -    CPU_DoubleU u;
> -    for (i = 0; i < 8; i++)
> -      {
> -        u.d = env->fregs[i];
> -        cpu_fprintf(f, "D%d = %08x   A%d = %08x   F%d = %08x%08x (%12g)\n",
> +    for (i = 0; i < 8; i++) {
> +        cpu_fprintf(f, "D%d = %08x   A%d = %08x   "
> +                    "F%d = %04x %016"PRIx64"  (%12g)\n",
>                      i, env->dregs[i], i, env->aregs[i],
> -                    i, u.l.upper, u.l.lower, *(double *)&u.d);
> -      }
> +                    i, env->fregs[i].l.upper, env->fregs[i].l.lower,
> +                    floatx80_to_double(env, env->fregs[i].l.upper,
> +                                       env->fregs[i].l.lower));
> +    }
>      cpu_fprintf (f, "PC = %08x   ", env->pc);
>      sr = env->sr | cpu_m68k_get_ccr(env);
>      cpu_fprintf(f, "SR = %04x %c%c%c%c%c ", sr, (sr & CCF_X) ? 'X' : '-',
>                  (sr & CCF_N) ? 'N' : '-', (sr & CCF_Z) ? 'Z' : '-',
>                  (sr & CCF_V) ? 'V' : '-', (sr & CCF_C) ? 'C' : '-');
> -    cpu_fprintf (f, "FPRESULT = %12g\n", *(double *)&env->fp_result);
>  }
>
>  void restore_state_to_opc(CPUM68KState *env, TranslationBlock *tb,
>
