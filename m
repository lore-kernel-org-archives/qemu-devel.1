Received: from eggs.gnu.org ([2001:4830:134:3::10]:49957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fZI2J-0003aH-Gj
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 11:43:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fZI2G-0005lO-D9
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 11:43:43 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:44831)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fZI2G-0005jD-68
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 11:43:40 -0400
Received: by mail-pg0-x242.google.com with SMTP id b10-v6so5256237pgq.11
	for <qemu-devel@nongnu.org>; Sat, 30 Jun 2018 08:43:39 -0700 (PDT)
References: <20180630030606.17288-1-programmingkidx@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d5eb6e1c-0790-c3a2-34fe-607be2eede4d@linaro.org>
Date: Sat, 30 Jun 2018 08:43:35 -0700
MIME-Version: 1.0
In-Reply-To: <20180630030606.17288-1-programmingkidx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] fix fdiv instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>, david@gibson.dropbear.id.au, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 06/29/2018 08:06 PM, John Arbuckle wrote:
> When the fdiv instruction divides a finite number by zero,
> the result actually depends on the FPSCR[ZE] bit. If this
> bit is set, the return value is the value originally in
> the destination register. If it is not set
> the result should be either positive or negative infinity.
> The sign of this result would depend on the sign of the
> two inputs. What currently happens is only infinity is
> returned even if the FPSCR[ZE] bit is set. This patch
> fixes this problem by actually checking the FPSCR[ZE] bit
> when deciding what the answer should be.
> 
> fdiv is suppose to only set the FPSCR's FPRF bits during a
> division by zero situation when the FPSCR[ZE] is not set.
> What currently happens is these bits are always set. This
> patch fixes this problem by checking the FPSCR[ZE] bit to
> decide if the FPRF bits should be set. 
> 
> https://www.pdfdrive.net/powerpc-microprocessor-family-the-programming-environments-for-32-e3087633.html
> This document has the information on the fdiv. Page 133 has
> the information on what action is executed when a division
> by zero situation takes place.
> 
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
> v2 changes:
> - Added comment for computing sign bit.
> - Changed return value of helper_fdiv() to return the
>   original value in the destination register when the
>   fpscr_ze if condition is encountered.
> - Patch comment adjusted to reflect returning
>   destination register's value instead of zero.
> 
>  target/ppc/fpu_helper.c            | 21 ++++++++++++++++++++-
>  target/ppc/helper.h                |  2 +-
>  target/ppc/translate/fp-impl.inc.c | 29 ++++++++++++++++++++++++++++-
>  3 files changed, 49 insertions(+), 3 deletions(-)
> 
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index 7714bfe0f9..9ccba1ec3f 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -644,7 +644,8 @@ uint64_t helper_fmul(CPUPPCState *env, uint64_t arg1, uint64_t arg2)
>  }
>  
>  /* fdiv - fdiv. */
> -uint64_t helper_fdiv(CPUPPCState *env, uint64_t arg1, uint64_t arg2)
> +uint64_t helper_fdiv(CPUPPCState *env, uint64_t arg1, uint64_t arg2, uint64_t
> +                     old_value)

You don't need to pass in the old value,

> +    } else if (arg2 == 0) {
> +        /* Division by zero */
> +        float_zero_divide_excp(env, GETPC());
> +        if (fpscr_ze) { /* if zero divide exception is enabled */
> +            /* Keep the value in the destination register the same */
> +            farg1.ll = old_value;
> +        } else {
> +            /* Compute sign bit */
> +            uint64_t sign = (farg1.ll ^ farg2.ll) >> 63;
> +            if (sign) { /* Negative sign bit */
> +                farg1.ll = 0xfff0000000000000; /* Negative Infinity */
> +            } else { /* Positive sign bit */
> +                farg1.ll = 0x7ff0000000000000; /* Positive Infinity */
> +            }
> +            helper_compute_fprf_float64(env, farg1.d);

You don't need any of this.

>          farg1.d = float64_div(farg1.d, farg2.d, &env->fp_status);
> +        helper_compute_fprf_float64(env, farg1.d);
> +        helper_float_check_status(env);

You merely need to raise the exception here, which skips
the code that assigns a new value to the register.

You do not want to do *all* of do_float_check_status here,
because overflow and underflow and inexact exceptions *do*
write a new value to the destination register (although a
weird scaled value that we don't handle so far, but still
an assignment, so the exception must be raised as a separate
step after assignment is complete.)

So, you just need to move the call to float_zero_divide_excp
out of do_float_check_status to here.  Like

    if (unlikely(get_float_exception_flags(&env->fp_status)
                 & float_flag_divbyzero)) {
        float_zero_divide_excp(env, GETPC());
    }


r~
