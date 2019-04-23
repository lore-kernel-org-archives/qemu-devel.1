Received: from eggs.gnu.org ([209.51.188.92]:40368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIw2g-0006ra-Ou
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:05:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIvrj-0006Kc-HF
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:53:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hIvrj-0006Io-Ao
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 09:53:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so20321218wre.7
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 06:53:43 -0700 (PDT)
References: <1556018982-3715-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1556018982-3715-6-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <132f9a99-412b-666e-b37c-4232d8525ab1@redhat.com>
Date: Tue, 23 Apr 2019 15:53:40 +0200
MIME-Version: 1.0
In-Reply-To: <1556018982-3715-6-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/8] target/mips: Clean up dsp_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com, aurelien@aurel32.net

On 4/23/19 1:29 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Remove several minor checkpatch warnings and errors.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/dsp_helper.c | 40 +++++++++++++++++++++++++++++-----------
>  1 file changed, 29 insertions(+), 11 deletions(-)
> 
> diff --git a/target/mips/dsp_helper.c b/target/mips/dsp_helper.c
> index 739b69d..8c58eeb 100644
> --- a/target/mips/dsp_helper.c
> +++ b/target/mips/dsp_helper.c
> @@ -22,8 +22,10 @@
>  #include "exec/helper-proto.h"
>  #include "qemu/bitops.h"
>  
> -/* As the byte ordering doesn't matter, i.e. all columns are treated
> -   identically, these unions can be used directly.  */
> +/*
> + * As the byte ordering doesn't matter, i.e. all columns are treated
> + * identically, these unions can be used directly.
> + */
>  typedef union {
>      uint8_t  ub[4];
>      int8_t   sb[4];
> @@ -1445,9 +1447,15 @@ target_ulong helper_precr_ob_qh(target_ulong rs, target_ulong rt)
>      return temp;
>  }
>  
> -#define PRECR_QH_PW(name, var) \
> -target_ulong helper_precr_##name##_qh_pw(target_ulong rs, target_ulong rt, \
> -                                    uint32_t sa)                      \
> +
> +/*
> + * In case sa == 0, use rt2, rt0, rs2, rs0.
> + * In case sa != 0, use rt3, rt1, rs3, rs1.
> + */
> +#define PRECR_QH_PW(name, var)                                        \
> +target_ulong helper_precr_##name##_qh_pw(target_ulong rs,             \
> +                                         target_ulong rt,             \
> +                                         uint32_t sa)                 \
>  {                                                                     \
>      uint16_t rs3, rs2, rs1, rs0;                                      \
>      uint16_t rt3, rt2, rt1, rt0;                                      \
> @@ -1456,8 +1464,6 @@ target_ulong helper_precr_##name##_qh_pw(target_ulong rs, target_ulong rt, \
>      MIPSDSP_SPLIT64_16(rs, rs3, rs2, rs1, rs0);                       \
>      MIPSDSP_SPLIT64_16(rt, rt3, rt2, rt1, rt0);                       \
>                                                                        \
> -    /* When sa = 0, we use rt2, rt0, rs2, rs0;                        \
> -     * when sa != 0, we use rt3, rt1, rs3, rs1. */                    \
>      if (sa == 0) {                                                    \
>          tempD = rt2 << var;                                           \
>          tempC = rt0 << var;                                           \
> @@ -1965,7 +1971,8 @@ SHIFT_PH(shra_r, rnd16_rashift);
>  #undef SHIFT_PH
>  
>  /** DSP Multiply Sub-class insns **/
> -/* Return value made up by two 16bits value.
> +/*
> + * Return value made up by two 16bits value.
>   * FIXME give the macro a better name.
>   */
>  #define MUL_RETURN32_16_PH(name, func, \
> @@ -3274,11 +3281,15 @@ target_ulong helper_dextr_l(target_ulong ac, target_ulong shift,
>                              CPUMIPSState *env)
>  {
>      uint64_t temp[3];
> +    target_ulong ret;
>  
>      shift = shift & 0x3F;
>  
>      mipsdsp_rndrashift_acc(temp, ac, shift, env);
> -    return (temp[1] << 63) | (temp[0] >> 1);
> +
> +    ret = (temp[1] << 63) | (temp[0] >> 1);
> +
> +    return ret;
>  }
>  
>  target_ulong helper_dextr_r_l(target_ulong ac, target_ulong shift,
> @@ -3286,6 +3297,7 @@ target_ulong helper_dextr_r_l(target_ulong ac, target_ulong shift,
>  {
>      uint64_t temp[3];
>      uint32_t temp128;
> +    target_ulong ret;
>  
>      shift = shift & 0x3F;
>      mipsdsp_rndrashift_acc(temp, ac, shift, env);
> @@ -3305,7 +3317,9 @@ target_ulong helper_dextr_r_l(target_ulong ac, target_ulong shift,
>          set_DSPControl_overflow_flag(1, 23, env);
>      }
>  
> -    return (temp[1] << 63) | (temp[0] >> 1);
> +    ret = (temp[1] << 63) | (temp[0] >> 1);
> +
> +    return ret;
>  }
>  
>  target_ulong helper_dextr_rs_l(target_ulong ac, target_ulong shift,
> @@ -3313,6 +3327,7 @@ target_ulong helper_dextr_rs_l(target_ulong ac, target_ulong shift,
>  {
>      uint64_t temp[3];
>      uint32_t temp128;
> +    target_ulong ret;
>  
>      shift = shift & 0x3F;
>      mipsdsp_rndrashift_acc(temp, ac, shift, env);
> @@ -3338,7 +3353,10 @@ target_ulong helper_dextr_rs_l(target_ulong ac, target_ulong shift,
>          }
>          set_DSPControl_overflow_flag(1, 23, env);
>      }
> -    return (temp[1] << 63) | (temp[0] >> 1);
> +
> +    ret = (temp[1] << 63) | (temp[0] >> 1);
> +
> +    return ret;
>  }
>  #endif
>  
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
