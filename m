Received: from eggs.gnu.org ([2001:4830:134:3::10]:54898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejt1g-0007O7-5y
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:42:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejt1d-0000fz-A3
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:42:36 -0500
Received: from mail-io0-x229.google.com ([2607:f8b0:4001:c06::229]:35026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ejt1d-0000fn-5G
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:42:33 -0500
Received: by mail-io0-x229.google.com with SMTP id m11so7216581iob.2
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 12:42:33 -0800 (PST)
References: <20180208173157.24705-1-alex.bennee@linaro.org>
	<20180208173157.24705-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <14861ad3-ae8b-662c-4d61-0b17914c9ae8@linaro.org>
Date: Thu, 8 Feb 2018 12:42:29 -0800
MIME-Version: 1.0
In-Reply-To: <20180208173157.24705-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 05/32] target/arm/cpu.h: add additional
 float_status flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On 02/08/2018 09:31 AM, Alex Bennée wrote:
> @@ -10750,15 +10751,22 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
>          }
>          set_float_rounding_mode(i, &env->vfp.fp_status);
>      }
> -    if (changed & (1 << 24)) {
> +    if (changed & (1 << 19)) { /* FPCR:FZ16 */
> +        set_flush_to_zero((val & (1 << 19)) != 0, &env->vfp.fp_status_f16);
> +        set_flush_inputs_to_zero((val & (1 << 19)) != 0,
> +                                 &env->vfp.fp_status_f16);
> +    }
> +    if (changed & (1 << 24)) { /* FPCR:FZ */
>          set_flush_to_zero((val & (1 << 24)) != 0, &env->vfp.fp_status);
>          set_flush_inputs_to_zero((val & (1 << 24)) != 0, &env->vfp.fp_status);
>      }
> -    if (changed & (1 << 25))
> +    if (changed & (1 << 25)) { /* FPCR:DN */
>          set_default_nan_mode((val & (1 << 25)) != 0, &env->vfp.fp_status);
> +    }

This misses changing rounding mode and default_nan_mode for fp_status_f16.

>      set_float_exception_flags(i, &env->vfp.fp_status);
> +    set_float_exception_flags(i, &env->vfp.fp_status_f16);
>      set_float_exception_flags(0, &env->vfp.standard_fp_status);

I think you should store 0 into fp_status_f16 here.  The exception flags are
OR'ed together when reading; there's not too much point in replicating it out.


r~
