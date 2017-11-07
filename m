Received: from eggs.gnu.org ([2001:4830:134:3::10]:55244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eC53j-0004bc-Or
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 09:41:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eC53i-00042S-Pz
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 09:40:59 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171103202624.5956-1-laurent@vivier.eu>
	<20171103202624.5956-4-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ec77ff1c-91ae-e79a-86fb-69cc9f55c20b@amsat.org>
Date: Tue, 7 Nov 2017 11:40:49 -0300
MIME-Version: 1.0
In-Reply-To: <20171103202624.5956-4-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 3/4] tricore: use make_float32()
 and float32_val()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-arm@nongnu.org, Stafford Horne <shorne@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>

On 11/03/2017 05:26 PM, Laurent Vivier wrote:
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Acked-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/tricore/fpu_helper.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/target/tricore/fpu_helper.c b/target/tricore/fpu_helper.c
> index 7979bb6692..d233d010c5 100644
> --- a/target/tricore/fpu_helper.c
> +++ b/target/tricore/fpu_helper.c
> @@ -21,10 +21,10 @@
>  #include "cpu.h"
>  #include "exec/helper-proto.h"
>  
> -#define QUIET_NAN 0x7fc00000
> -#define ADD_NAN   0x7fc00001
> -#define DIV_NAN   0x7fc00008
> -#define MUL_NAN   0x7fc00002
> +#define QUIET_NAN make_float32(0x7fc00000)
> +#define ADD_NAN   make_float32(0x7fc00001)
> +#define DIV_NAN   make_float32(0x7fc00008)
> +#define MUL_NAN   make_float32(0x7fc00002)
>  #define FPU_FS PSW_USB_C
>  #define FPU_FI PSW_USB_V
>  #define FPU_FV PSW_USB_SV
> @@ -63,13 +63,13 @@ static inline float32 f_maddsub_nan_result(float32 arg1, float32 arg2,
>      } else if (float32_is_zero(arg1) && float32_is_infinity(arg2)) {
>          return MUL_NAN;
>      } else {
> -        aSign = arg1 >> 31;
> -        bSign = arg2 >> 31;
> -        cSign = arg3 >> 31;
> +        aSign = float32_val(arg1) >> 31;
> +        bSign = float32_val(arg2) >> 31;
> +        cSign = float32_val(arg3) >> 31;
>  
> -        aExp = (arg1 >> 23) & 0xff;
> -        bExp = (arg2 >> 23) & 0xff;
> -        cExp = (arg3 >> 23) & 0xff;
> +        aExp = (float32_val(arg1) >> 23) & 0xff;
> +        bExp = (float32_val(arg2) >> 23) & 0xff;
> +        cExp = (float32_val(arg3) >> 23) & 0xff;
>  
>          if (muladd_negate_c) {
>              cSign ^= 1;
> @@ -139,7 +139,7 @@ uint32_t helper_f##op(CPUTriCoreState *env, uint32_t r1, uint32_t r2)          \
>      } else {                                                                   \
>          env->FPU_FS = 0;                                                       \
>      }                                                                          \
> -    return (uint32_t)f_result;                                                 \
> +    return float32_val(f_result);                                              \
>  }
>  FADD_SUB(add)
>  FADD_SUB(sub)
> @@ -166,7 +166,7 @@ uint32_t helper_fmul(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
>      } else {
>          env->FPU_FS = 0;
>      }
> -    return (uint32_t)f_result;
> +    return float32_val(f_result);
>  
>  }
>  
> @@ -193,7 +193,7 @@ uint32_t helper_fdiv(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
>          env->FPU_FS = 0;
>      }
>  
> -    return (uint32_t)f_result;
> +    return float32_val(f_result);
>  }
>  
>  uint32_t helper_fmadd(CPUTriCoreState *env, uint32_t r1,
> @@ -219,7 +219,7 @@ uint32_t helper_fmadd(CPUTriCoreState *env, uint32_t r1,
>      } else {
>          env->FPU_FS = 0;
>      }
> -    return (uint32_t)f_result;
> +    return float32_val(f_result);
>  }
>  
>  uint32_t helper_fmsub(CPUTriCoreState *env, uint32_t r1,
> @@ -247,7 +247,7 @@ uint32_t helper_fmsub(CPUTriCoreState *env, uint32_t r1,
>      } else {
>          env->FPU_FS = 0;
>      }
> -    return (uint32_t)f_result;
> +    return float32_val(f_result);
>  }
>  
>  uint32_t helper_fcmp(CPUTriCoreState *env, uint32_t r1, uint32_t r2)
> @@ -304,7 +304,7 @@ uint32_t helper_itof(CPUTriCoreState *env, uint32_t arg)
>      } else {
>          env->FPU_FS = 0;
>      }
> -    return (uint32_t)f_result;
> +    return float32_val(f_result);
>  }
>  
>  uint32_t helper_ftouz(CPUTriCoreState *env, uint32_t arg)
> @@ -321,7 +321,7 @@ uint32_t helper_ftouz(CPUTriCoreState *env, uint32_t arg)
>          if (float32_is_any_nan(f_arg)) {
>              result = 0;
>          }
> -    } else if (float32_lt_quiet(f_arg, 0, &env->fp_status)) {
> +    } else if (float32_lt_quiet(f_arg, float32_zero, &env->fp_status)) {
>          flags = float_flag_invalid;
>          result = 0;
>      }
> 
