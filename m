Received: from eggs.gnu.org ([2001:4830:134:3::10]:54159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLED8-0006vR-22
	for qemu-devel@nongnu.org; Tue, 22 May 2018 16:48:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLED4-0007of-S7
	for qemu-devel@nongnu.org; Tue, 22 May 2018 16:48:46 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:38415)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLED4-0007oL-N8
	for qemu-devel@nongnu.org; Tue, 22 May 2018 16:48:42 -0400
Received: by mail-qk0-x241.google.com with SMTP id c23-v6so737439qkb.5
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 13:48:42 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180522175629.24932-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3c430dea-2484-8ffd-90b0-cea56c7b618e@amsat.org>
Date: Tue, 22 May 2018 17:48:37 -0300
MIME-Version: 1.0
In-Reply-To: <20180522175629.24932-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] tcg: Fix helper function vs
 host abi for float16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, peter.maydell@linaro.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

On 05/22/2018 02:56 PM, Richard Henderson wrote:
> Depending on the host abi, float16, aka uint16_t, values are
> passed and returned either zero-extended in the host register
> or with garbage at the top of the host register.
> 
> The tcg code generator has so far been assuming garbage, as that
> matches the x86 abi, but this is incorrect for other host abis.
> Further, target/arm has so far been assuming zero-extended results,
> so that it may store the 16-bit value into a 32-bit slot with the
> high 16-bits already clear.

This looks an easy test candidate for Alex cross-compiler series!

> Rectify both problems by mapping "f16" in the helper definition
> to uint32_t instead of (a typedef for) uint16_t.  This forces
> the host compiler to assume garbage in the upper 16 bits on input
> and to zero-extend the result on output.

Suggested-by: Peter Maydell <peter.maydell@linaro.org> ?

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/exec/helper-head.h |  2 +-
>  target/arm/helper-a64.c    | 35 +++++++++--------
>  target/arm/helper.c        | 80 +++++++++++++++++++-------------------
>  3 files changed, 59 insertions(+), 58 deletions(-)
> 
> diff --git a/include/exec/helper-head.h b/include/exec/helper-head.h
> index 15b6a68de3..276dd5afce 100644
> --- a/include/exec/helper-head.h
> +++ b/include/exec/helper-head.h
> @@ -39,7 +39,7 @@
>  #define dh_ctype_int int
>  #define dh_ctype_i64 uint64_t
>  #define dh_ctype_s64 int64_t
> -#define dh_ctype_f16 float16
> +#define dh_ctype_f16 uint32_t
>  #define dh_ctype_f32 float32
>  #define dh_ctype_f64 float64
>  #define dh_ctype_ptr void *
> diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
> index f92bdea732..6ee5f684cf 100644
> --- a/target/arm/helper-a64.c
> +++ b/target/arm/helper-a64.c
> @@ -85,12 +85,12 @@ static inline uint32_t float_rel_to_flags(int res)
>      return flags;
>  }
>  
> -uint64_t HELPER(vfp_cmph_a64)(float16 x, float16 y, void *fp_status)
> +uint64_t HELPER(vfp_cmph_a64)(uint32_t x, uint32_t y, void *fp_status)
>  {
>      return float_rel_to_flags(float16_compare_quiet(x, y, fp_status));
>  }
>  
> -uint64_t HELPER(vfp_cmpeh_a64)(float16 x, float16 y, void *fp_status)
> +uint64_t HELPER(vfp_cmpeh_a64)(uint32_t x, uint32_t y, void *fp_status)
>  {
>      return float_rel_to_flags(float16_compare(x, y, fp_status));
>  }
> @@ -214,7 +214,7 @@ uint64_t HELPER(neon_cgt_f64)(float64 a, float64 b, void *fpstp)
>  #define float64_three make_float64(0x4008000000000000ULL)
>  #define float64_one_point_five make_float64(0x3FF8000000000000ULL)
>  
> -float16 HELPER(recpsf_f16)(float16 a, float16 b, void *fpstp)
> +uint32_t HELPER(recpsf_f16)(uint32_t a, uint32_t b, void *fpstp)
>  {
>      float_status *fpst = fpstp;
>  
> @@ -259,7 +259,7 @@ float64 HELPER(recpsf_f64)(float64 a, float64 b, void *fpstp)
>      return float64_muladd(a, b, float64_two, 0, fpst);
>  }
>  
> -float16 HELPER(rsqrtsf_f16)(float16 a, float16 b, void *fpstp)
> +uint32_t HELPER(rsqrtsf_f16)(uint32_t a, uint32_t b, void *fpstp)
>  {
>      float_status *fpst = fpstp;
>  
> @@ -366,7 +366,7 @@ uint64_t HELPER(neon_addlp_u16)(uint64_t a)
>  }
>  
>  /* Floating-point reciprocal exponent - see FPRecpX in ARM ARM */
> -float16 HELPER(frecpx_f16)(float16 a, void *fpstp)
> +uint32_t HELPER(frecpx_f16)(uint32_t a, void *fpstp)
>  {
>      float_status *fpst = fpstp;
>      uint16_t val16, sbit;
> @@ -695,7 +695,7 @@ void HELPER(casp_be_parallel)(CPUARMState *env, uint32_t rs, uint64_t addr,
>  #define ADVSIMD_HELPER(name, suffix) HELPER(glue(glue(advsimd_, name), suffix))
>  
>  #define ADVSIMD_HALFOP(name) \
> -float16 ADVSIMD_HELPER(name, h)(float16 a, float16 b, void *fpstp) \
> +uint32_t ADVSIMD_HELPER(name, h)(uint32_t a, uint32_t b, void *fpstp) \
>  { \
>      float_status *fpst = fpstp; \
>      return float16_ ## name(a, b, fpst);    \
> @@ -755,7 +755,8 @@ ADVSIMD_HALFOP(mulx)
>  ADVSIMD_TWOHALFOP(mulx)
>  
>  /* fused multiply-accumulate */
> -float16 HELPER(advsimd_muladdh)(float16 a, float16 b, float16 c, void *fpstp)
> +uint32_t HELPER(advsimd_muladdh)(uint32_t a, uint32_t b, uint32_t c,
> +                                 void *fpstp)
>  {
>      float_status *fpst = fpstp;
>      return float16_muladd(a, b, c, 0, fpst);
> @@ -786,14 +787,14 @@ uint32_t HELPER(advsimd_muladd2h)(uint32_t two_a, uint32_t two_b,
>  
>  #define ADVSIMD_CMPRES(test) (test) ? 0xffff : 0
>  
> -uint32_t HELPER(advsimd_ceq_f16)(float16 a, float16 b, void *fpstp)
> +uint32_t HELPER(advsimd_ceq_f16)(uint32_t a, uint32_t b, void *fpstp)
>  {
>      float_status *fpst = fpstp;
>      int compare = float16_compare_quiet(a, b, fpst);
>      return ADVSIMD_CMPRES(compare == float_relation_equal);
>  }
>  
> -uint32_t HELPER(advsimd_cge_f16)(float16 a, float16 b, void *fpstp)
> +uint32_t HELPER(advsimd_cge_f16)(uint32_t a, uint32_t b, void *fpstp)
>  {
>      float_status *fpst = fpstp;
>      int compare = float16_compare(a, b, fpst);
> @@ -801,14 +802,14 @@ uint32_t HELPER(advsimd_cge_f16)(float16 a, float16 b, void *fpstp)
>                            compare == float_relation_equal);
>  }
>  
> -uint32_t HELPER(advsimd_cgt_f16)(float16 a, float16 b, void *fpstp)
> +uint32_t HELPER(advsimd_cgt_f16)(uint32_t a, uint32_t b, void *fpstp)
>  {
>      float_status *fpst = fpstp;
>      int compare = float16_compare(a, b, fpst);
>      return ADVSIMD_CMPRES(compare == float_relation_greater);
>  }
>  
> -uint32_t HELPER(advsimd_acge_f16)(float16 a, float16 b, void *fpstp)
> +uint32_t HELPER(advsimd_acge_f16)(uint32_t a, uint32_t b, void *fpstp)
>  {
>      float_status *fpst = fpstp;
>      float16 f0 = float16_abs(a);
> @@ -818,7 +819,7 @@ uint32_t HELPER(advsimd_acge_f16)(float16 a, float16 b, void *fpstp)
>                            compare == float_relation_equal);
>  }
>  
> -uint32_t HELPER(advsimd_acgt_f16)(float16 a, float16 b, void *fpstp)
> +uint32_t HELPER(advsimd_acgt_f16)(uint32_t a, uint32_t b, void *fpstp)
>  {
>      float_status *fpst = fpstp;
>      float16 f0 = float16_abs(a);
> @@ -828,12 +829,12 @@ uint32_t HELPER(advsimd_acgt_f16)(float16 a, float16 b, void *fpstp)
>  }
>  
>  /* round to integral */
> -float16 HELPER(advsimd_rinth_exact)(float16 x, void *fp_status)
> +uint32_t HELPER(advsimd_rinth_exact)(uint32_t x, void *fp_status)
>  {
>      return float16_round_to_int(x, fp_status);
>  }
>  
> -float16 HELPER(advsimd_rinth)(float16 x, void *fp_status)
> +uint32_t HELPER(advsimd_rinth)(uint32_t x, void *fp_status)
>  {
>      int old_flags = get_float_exception_flags(fp_status), new_flags;
>      float16 ret;
> @@ -857,7 +858,7 @@ float16 HELPER(advsimd_rinth)(float16 x, void *fp_status)
>   * setting the mode appropriately before calling the helper.
>   */
>  
> -uint32_t HELPER(advsimd_f16tosinth)(float16 a, void *fpstp)
> +uint32_t HELPER(advsimd_f16tosinth)(uint32_t a, void *fpstp)
>  {
>      float_status *fpst = fpstp;
>  
> @@ -869,7 +870,7 @@ uint32_t HELPER(advsimd_f16tosinth)(float16 a, void *fpstp)
>      return float16_to_int16(a, fpst);
>  }
>  
> -uint32_t HELPER(advsimd_f16touinth)(float16 a, void *fpstp)
> +uint32_t HELPER(advsimd_f16touinth)(uint32_t a, void *fpstp)
>  {
>      float_status *fpst = fpstp;
>  
> @@ -885,7 +886,7 @@ uint32_t HELPER(advsimd_f16touinth)(float16 a, void *fpstp)
>   * Square Root and Reciprocal square root
>   */
>  
> -float16 HELPER(sqrt_f16)(float16 a, void *fpstp)
> +uint32_t HELPER(sqrt_f16)(uint32_t a, void *fpstp)
>  {
>      float_status *s = fpstp;
>  
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index c0f739972e..a4bfac3932 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11344,35 +11344,35 @@ DO_VFP_cmp(d, float64)
>  
>  /* Integer to float and float to integer conversions */
>  
> -#define CONV_ITOF(name, fsz, sign) \
> -    float##fsz HELPER(name)(uint32_t x, void *fpstp) \
> -{ \
> -    float_status *fpst = fpstp; \
> -    return sign##int32_to_##float##fsz((sign##int32_t)x, fpst); \
> +#define CONV_ITOF(name, ftype, fsz, sign)                           \
> +ftype HELPER(name)(uint32_t x, void *fpstp)                         \
> +{                                                                   \
> +    float_status *fpst = fpstp;                                     \
> +    return sign##int32_to_##float##fsz((sign##int32_t)x, fpst);     \
>  }
>  
> -#define CONV_FTOI(name, fsz, sign, round) \
> -uint32_t HELPER(name)(float##fsz x, void *fpstp) \
> -{ \
> -    float_status *fpst = fpstp; \
> -    if (float##fsz##_is_any_nan(x)) { \
> -        float_raise(float_flag_invalid, fpst); \
> -        return 0; \
> -    } \
> -    return float##fsz##_to_##sign##int32##round(x, fpst); \
> +#define CONV_FTOI(name, ftype, fsz, sign, round)                \
> +uint32_t HELPER(name)(ftype x, void *fpstp)                     \
> +{                                                               \
> +    float_status *fpst = fpstp;                                 \
> +    if (float##fsz##_is_any_nan(x)) {                           \
> +        float_raise(float_flag_invalid, fpst);                  \
> +        return 0;                                               \
> +    }                                                           \
> +    return float##fsz##_to_##sign##int32##round(x, fpst);       \
>  }
>  
> -#define FLOAT_CONVS(name, p, fsz, sign) \
> -CONV_ITOF(vfp_##name##to##p, fsz, sign) \
> -CONV_FTOI(vfp_to##name##p, fsz, sign, ) \
> -CONV_FTOI(vfp_to##name##z##p, fsz, sign, _round_to_zero)
> +#define FLOAT_CONVS(name, p, ftype, fsz, sign)            \
> +    CONV_ITOF(vfp_##name##to##p, ftype, fsz, sign)        \
> +    CONV_FTOI(vfp_to##name##p, ftype, fsz, sign, )        \
> +    CONV_FTOI(vfp_to##name##z##p, ftype, fsz, sign, _round_to_zero)
>  
> -FLOAT_CONVS(si, h, 16, )
> -FLOAT_CONVS(si, s, 32, )
> -FLOAT_CONVS(si, d, 64, )
> -FLOAT_CONVS(ui, h, 16, u)
> -FLOAT_CONVS(ui, s, 32, u)
> -FLOAT_CONVS(ui, d, 64, u)
> +FLOAT_CONVS(si, h, uint32_t, 16, )
> +FLOAT_CONVS(si, s, float32, 32, )
> +FLOAT_CONVS(si, d, float64, 64, )
> +FLOAT_CONVS(ui, h, uint32_t, 16, u)
> +FLOAT_CONVS(ui, s, float32, 32, u)
> +FLOAT_CONVS(ui, d, float64, 64, u)
>  
>  #undef CONV_ITOF
>  #undef CONV_FTOI
> @@ -11465,22 +11465,22 @@ static float16 do_postscale_fp16(float64 f, int shift, float_status *fpst)
>      return float64_to_float16(float64_scalbn(f, -shift, fpst), true, fpst);
>  }
>  
> -float16 HELPER(vfp_sltoh)(uint32_t x, uint32_t shift, void *fpst)
> +uint32_t HELPER(vfp_sltoh)(uint32_t x, uint32_t shift, void *fpst)
>  {
>      return do_postscale_fp16(int32_to_float64(x, fpst), shift, fpst);
>  }
>  
> -float16 HELPER(vfp_ultoh)(uint32_t x, uint32_t shift, void *fpst)
> +uint32_t HELPER(vfp_ultoh)(uint32_t x, uint32_t shift, void *fpst)
>  {
>      return do_postscale_fp16(uint32_to_float64(x, fpst), shift, fpst);
>  }
>  
> -float16 HELPER(vfp_sqtoh)(uint64_t x, uint32_t shift, void *fpst)
> +uint32_t HELPER(vfp_sqtoh)(uint64_t x, uint32_t shift, void *fpst)
>  {
>      return do_postscale_fp16(int64_to_float64(x, fpst), shift, fpst);
>  }
>  
> -float16 HELPER(vfp_uqtoh)(uint64_t x, uint32_t shift, void *fpst)
> +uint32_t HELPER(vfp_uqtoh)(uint64_t x, uint32_t shift, void *fpst)
>  {
>      return do_postscale_fp16(uint64_to_float64(x, fpst), shift, fpst);
>  }
> @@ -11504,32 +11504,32 @@ static float64 do_prescale_fp16(float16 f, int shift, float_status *fpst)
>      }
>  }
>  
> -uint32_t HELPER(vfp_toshh)(float16 x, uint32_t shift, void *fpst)
> +uint32_t HELPER(vfp_toshh)(uint32_t x, uint32_t shift, void *fpst)
>  {
>      return float64_to_int16(do_prescale_fp16(x, shift, fpst), fpst);
>  }
>  
> -uint32_t HELPER(vfp_touhh)(float16 x, uint32_t shift, void *fpst)
> +uint32_t HELPER(vfp_touhh)(uint32_t x, uint32_t shift, void *fpst)
>  {
>      return float64_to_uint16(do_prescale_fp16(x, shift, fpst), fpst);
>  }
>  
> -uint32_t HELPER(vfp_toslh)(float16 x, uint32_t shift, void *fpst)
> +uint32_t HELPER(vfp_toslh)(uint32_t x, uint32_t shift, void *fpst)
>  {
>      return float64_to_int32(do_prescale_fp16(x, shift, fpst), fpst);
>  }
>  
> -uint32_t HELPER(vfp_toulh)(float16 x, uint32_t shift, void *fpst)
> +uint32_t HELPER(vfp_toulh)(uint32_t x, uint32_t shift, void *fpst)
>  {
>      return float64_to_uint32(do_prescale_fp16(x, shift, fpst), fpst);
>  }
>  
> -uint64_t HELPER(vfp_tosqh)(float16 x, uint32_t shift, void *fpst)
> +uint64_t HELPER(vfp_tosqh)(uint32_t x, uint32_t shift, void *fpst)
>  {
>      return float64_to_int64(do_prescale_fp16(x, shift, fpst), fpst);
>  }
>  
> -uint64_t HELPER(vfp_touqh)(float16 x, uint32_t shift, void *fpst)
> +uint64_t HELPER(vfp_touqh)(uint32_t x, uint32_t shift, void *fpst)
>  {
>      return float64_to_uint64(do_prescale_fp16(x, shift, fpst), fpst);
>  }
> @@ -11565,7 +11565,7 @@ uint32_t HELPER(set_neon_rmode)(uint32_t rmode, CPUARMState *env)
>  }
>  
>  /* Half precision conversions.  */
> -float32 HELPER(vfp_fcvt_f16_to_f32)(float16 a, void *fpstp, uint32_t ahp_mode)
> +float32 HELPER(vfp_fcvt_f16_to_f32)(uint32_t a, void *fpstp, uint32_t ahp_mode)
>  {
>      /* Squash FZ16 to 0 for the duration of conversion.  In this case,
>       * it would affect flushing input denormals.
> @@ -11578,7 +11578,7 @@ float32 HELPER(vfp_fcvt_f16_to_f32)(float16 a, void *fpstp, uint32_t ahp_mode)
>      return r;
>  }
>  
> -float16 HELPER(vfp_fcvt_f32_to_f16)(float32 a, void *fpstp, uint32_t ahp_mode)
> +uint32_t HELPER(vfp_fcvt_f32_to_f16)(float32 a, void *fpstp, uint32_t ahp_mode)
>  {
>      /* Squash FZ16 to 0 for the duration of conversion.  In this case,
>       * it would affect flushing output denormals.
> @@ -11591,7 +11591,7 @@ float16 HELPER(vfp_fcvt_f32_to_f16)(float32 a, void *fpstp, uint32_t ahp_mode)
>      return r;
>  }
>  
> -float64 HELPER(vfp_fcvt_f16_to_f64)(float16 a, void *fpstp, uint32_t ahp_mode)
> +float64 HELPER(vfp_fcvt_f16_to_f64)(uint32_t a, void *fpstp, uint32_t ahp_mode)
>  {
>      /* Squash FZ16 to 0 for the duration of conversion.  In this case,
>       * it would affect flushing input denormals.
> @@ -11604,7 +11604,7 @@ float64 HELPER(vfp_fcvt_f16_to_f64)(float16 a, void *fpstp, uint32_t ahp_mode)
>      return r;
>  }
>  
> -float16 HELPER(vfp_fcvt_f64_to_f16)(float64 a, void *fpstp, uint32_t ahp_mode)
> +uint32_t HELPER(vfp_fcvt_f64_to_f16)(float64 a, void *fpstp, uint32_t ahp_mode)
>  {
>      /* Squash FZ16 to 0 for the duration of conversion.  In this case,
>       * it would affect flushing output denormals.
> @@ -11742,7 +11742,7 @@ static bool round_to_inf(float_status *fpst, bool sign_bit)
>      g_assert_not_reached();
>  }
>  
> -float16 HELPER(recpe_f16)(float16 input, void *fpstp)
> +uint32_t HELPER(recpe_f16)(uint32_t input, void *fpstp)
>  {
>      float_status *fpst = fpstp;
>      float16 f16 = float16_squash_input_denormal(input, fpst);
> @@ -11937,7 +11937,7 @@ static uint64_t recip_sqrt_estimate(int *exp , int exp_off, uint64_t frac)
>      return extract64(estimate, 0, 8) << 44;
>  }
>  
> -float16 HELPER(rsqrte_f16)(float16 input, void *fpstp)
> +uint32_t HELPER(rsqrte_f16)(uint32_t input, void *fpstp)
>  {
>      float_status *s = fpstp;
>      float16 f16 = float16_squash_input_denormal(input, s);
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
