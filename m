Received: from eggs.gnu.org ([2001:4830:134:3::10]:58399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fWlEe-0004Gz-7d
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 12:18:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fWlEb-0000Na-3D
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 12:18:00 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:33896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fWlEa-0000NK-RX
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 12:17:57 -0400
Received: by mail-pl0-x244.google.com with SMTP id g20-v6so4874903plq.1
	for <qemu-devel@nongnu.org>; Sat, 23 Jun 2018 09:17:56 -0700 (PDT)
References: <20180623022258.22158-1-programmingkidx@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ecf44486-09a4-9c9a-b96e-1db2d6a1bcbe@linaro.org>
Date: Sat, 23 Jun 2018 09:17:52 -0700
MIME-Version: 1.0
In-Reply-To: <20180623022258.22158-1-programmingkidx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] fix fdiv instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>, david@gibson.dropbear.id.au, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 06/22/2018 07:22 PM, John Arbuckle wrote:
> When the fdiv instruction divides a finite number by zero,
> the result actually depends on the FPSCR[ZE] bit. If this
> bit is set, the return value is zero. If it is not set
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
> This document has the information on the fdiv. Page 133 has the information on what action is executed when a division by zero situation takes place. 
> 
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
>  target/ppc/fpu_helper.c            | 16 ++++++++++++++++
>  target/ppc/translate/fp-impl.inc.c | 28 +++++++++++++++++++++++++++-
>  2 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index 7714bfe0f9..de694604fb 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -658,6 +658,20 @@ uint64_t helper_fdiv(CPUPPCState *env, uint64_t arg1, uint64_t arg2)
>      } else if (unlikely(float64_is_zero(farg1.d) && float64_is_zero(farg2.d))) {
>          /* Division of zero by zero */
>          farg1.ll = float_invalid_op_excp(env, POWERPC_EXCP_FP_VXZDZ, 1);
> +    } else if (arg2 == 0) {
> +        /* Division by zero */
> +        float_zero_divide_excp(env, GETPC());
> +        if (fpscr_ze) { /* if zero divide exception is enabled */
> +            farg1.ll = 0;
> +        } else {
> +            uint64_t sign = (farg1.ll ^ farg2.ll) >> 63;
> +            if (sign) { /* Negative sign bit */
> +                farg1.ll = 0xfff0000000000000; /* Negative Infinity */
> +            } else { /* Positive sign bit */
> +                farg1.ll = 0x7ff0000000000000; /* Positive Infinity */
> +            }
> +            helper_compute_fprf_float64(env, farg1.d);

I don't believe you.
(1) This is against IEEE spec,
(2) There is nothing about this zero result in the Power manual,
(3) I do not replicate this experimentally.

#include <signal.h>
#include <stdio.h>
#include <fenv.h>
#include <stdlib.h>

void handle(int sig, siginfo_t *info, void *x)
{
    ucontext_t *u = x;
    printf("%f\n", u->uc_mcontext.fp_regs[0]);
    exit(0);
}

int main()
{
  struct sigaction a = { .sa_sigaction = handle, .sa_flags = SA_SIGINFO };
  sigaction(SIGFPE, &a, NULL);
  feenableexcept(FE_ALL_EXCEPT);

  {
    register double f0 __asm__("32") = 2;
    register double f1 __asm__("33") = 1;
    register double f2 __asm__("34") = 0;
    __asm__ volatile ("fdiv %0,%1,%2" : "+f"(f0) : "f"(f1), "f"(f2));
  }
  return 1;
}

Produces the expected 2.0, i.e. the destination register is unmodified.
Without feenableexcept, of course, the normal infinity is produced.


r~
