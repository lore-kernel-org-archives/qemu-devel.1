Received: from eggs.gnu.org ([2001:4830:134:3::10]:34833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWpNQ-0003Rf-L0
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 15:11:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWpNN-00050a-Ff
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 15:11:04 -0500
Received: from mail-pg0-x22b.google.com ([2607:f8b0:400e:c05::22b]:34327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eWpNN-000501-7G
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 15:11:01 -0500
Received: by mail-pg0-x22b.google.com with SMTP id j4so1098250pgp.1
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 12:11:01 -0800 (PST)
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-7-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f15753f1-7446-26f1-9937-f3b67d15c0a6@linaro.org>
Date: Wed, 3 Jan 2018 12:10:56 -0800
MIME-Version: 1.0
In-Reply-To: <1514940265-18093-7-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 06/21] RISC-V FPU Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On 01/02/2018 04:44 PM, Michael Clark wrote:
> +/* convert RISC-V rounding mode to IEEE library numbers */
> +unsigned int ieee_rm[] = {

static const.

> +/* obtain rm value to use in computation
> + * as the last step, convert rm codes to what the softfloat library expects
> + * Adapted from Spike's decode.h:RM
> + */
> +#define RM ({                                             \
> +if (rm == 7) {                                            \
> +    rm = env->frm;                               \
> +}                                                         \
> +if (rm > 4) {                                             \
> +    helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST); \
> +}                                                         \
> +ieee_rm[rm]; })

Please use inline functions and not these macros.

Probably this applies to some of the helpers that I've already reviewed, but
you're going to need to use an exception raising function that also performs an
unwind (usually via cpu_loop_exit_restore).  The GETPC() that feeds the unwind
must be placed in the outer-most helper (including inlines).

> +#ifndef CONFIG_USER_ONLY
> +#define require_fp if (!(env->mstatus & MSTATUS_FS)) { \
> +    helper_raise_exception(env, RISCV_EXCP_ILLEGAL_INST); \
> +}

If you included MSTATUS_FS in cpu_get_tb_cpu_state flags, then you could be
checking for this at translation time instead of at run time.

> +/* convert softfloat library flag numbers to RISC-V */
> +unsigned int softfloat_flags_to_riscv(unsigned int flags)
> +{
> +    int rv_flags = 0;
> +    rv_flags |= (flags & float_flag_inexact) ? 1 : 0;
> +    rv_flags |= (flags & float_flag_underflow) ? 2 : 0;
> +    rv_flags |= (flags & float_flag_overflow) ? 4 : 0;
> +    rv_flags |= (flags & float_flag_divbyzero) ? 8 : 0;
> +    rv_flags |= (flags & float_flag_invalid) ? 16 : 0;

FPEXC_NX et al.

> +/* adapted from Spike's decode.h:set_fp_exceptions */
> +#define set_fp_exceptions() do { \
> +    env->fflags |= softfloat_flags_to_riscv(get_float_exception_flags(\
> +                            &env->fp_status)); \
> +    set_float_exception_flags(0, &env->fp_status); \
> +} while (0)

inline function.  Usually written as

  int flags = get_float_exception_flags(&env->fp_status);
  if (flags) {
    set_float_exception_flags(0, &env->fp_status);
    env->fflags |= softfloat_flags_to_riscv(flags);
  }

since we really do expect exceptions to be exceptional.

> +uint64_t helper_fmsub_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
> +                        uint64_t frs3, uint64_t rm)
> +{
> +    require_fp;
> +    set_float_rounding_mode(RM, &env->fp_status);
> +    frs1 = float32_muladd(frs1, frs2, frs3 ^ (uint32_t)INT32_MIN, 0,
> +                          &env->fp_status);

Given that RISC-V always returns a default NaN, you obviously do not care about
the sign of a NaN result.  Therefore you should use float_muladd_negate_c as
the fourth argument here and not perform the sign flip manually.

> +uint64_t helper_fnmsub_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
> +                         uint64_t frs3, uint64_t rm)
> +{
> +    require_fp;
> +    set_float_rounding_mode(RM, &env->fp_status);
> +    frs1 = float32_muladd(frs1 ^ (uint32_t)INT32_MIN, frs2, frs3, 0,
> +                          &env->fp_status);

float_muladd_negate_product.

> +uint64_t helper_fnmadd_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2,
> +                         uint64_t frs3, uint64_t rm)
> +{
> +    require_fp;
> +    set_float_rounding_mode(RM, &env->fp_status);
> +    frs1 = float32_muladd(frs1 ^ (uint32_t)INT32_MIN, frs2,
> +                          frs3 ^ (uint32_t)INT32_MIN, 0, &env->fp_status);

float_muladd_negate_c | float_muladd_negate_product

> +uint64_t helper_fmin_s(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
> +{
> +    require_fp;
> +    frs1 = float32_minnum(frs1, frs2, &env->fp_status);

If you want minnum and not min, riscv-spec-v2.2.pdf could use some more verbage
to specify that.

> +/* adapted from spike */
> +#define isNaNF32UI(ui) (0xFF000000 < (uint32_t)((uint_fast32_t)ui << 1))

float32_is_any_nan

> +#define signF32UI(a) ((bool)((uint32_t)a >> 31))

float32_is_neg

> +#define expF32UI(a) ((int_fast16_t)(a >> 23) & 0xFF)
> +#define fracF32UI(a) (a & 0x007FFFFF)

Either float32_is_infinity or float32_is_zero_or_denormal.

> +union ui32_f32 { uint32_t ui; uint32_t f; };

This is just silly.

> +uint_fast16_t float32_classify(uint32_t a, float_status *status)

Please drop *_fast*_t for just "int".

> +    return
> +        (sign && infOrNaN && fracF32UI(uiA) == 0)           << 0 |
> +        (sign && !infOrNaN && !subnormalOrZero)             << 1 |
> +        (sign && subnormalOrZero && fracF32UI(uiA))         << 2 |
> +        (sign && subnormalOrZero && fracF32UI(uiA) == 0)    << 3 |
> +        (!sign && infOrNaN && fracF32UI(uiA) == 0)          << 7 |
> +        (!sign && !infOrNaN && !subnormalOrZero)            << 6 |
> +        (!sign && subnormalOrZero && fracF32UI(uiA))        << 5 |
> +        (!sign && subnormalOrZero && fracF32UI(uiA) == 0)   << 4 |
> +        (isNaNF32UI(uiA) &&  float32_is_signaling_nan(uiA, status)) << 8 |
> +        (isNaNF32UI(uiA) && !float32_is_signaling_nan(uiA, status)) << 9;

These conditions are all exclusive.  You do not need to compute all of them.

  if (float32_is_any_nan(f)) {
    if (float32_is_signaling_nan(f, status)) {
      return 1 << 8;
    } else {
      return 1 << 9;
    }
  }
  if (float32_is_neg(f)) {
    if (float32_is_infinity(f)) {
      return 1 << 0;
    } else if (float32_is_zero(f)) {
      return 1 << 3;
    } else if (float32_is_zero_or_denormal(f)) {
      return 1 << 2;
    } else {
      return 1 << 1;
    }
  } else {
    ...
  }

> +    frs1 = (int64_t)((int32_t)float64_to_int32(frs1, &env->fp_status));

Double cast is pointless, as are the extra parenthesis.

> +/* adapted from spike */
> +#define isNaNF64UI(ui) (UINT64_C(0xFFE0000000000000) \
> +                       < (uint64_t)((uint_fast64_t)ui << 1))
> +#define signF64UI(a) ((bool)((uint64_t) a >> 63))
> +#define expF64UI(a) ((int_fast16_t)(a >> 52) & 0x7FF)
> +#define fracF64UI(a) (a & UINT64_C(0x000FFFFFFFFFFFFF))
> +
> +union ui64_f64 { uint64_t ui; uint64_t f; };
> +
> +uint_fast16_t float64_classify(uint64_t a, float_status *status)

Likewise.


r~
