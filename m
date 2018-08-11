Received: from eggs.gnu.org ([2001:4830:134:3::10]:36863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1foWfQ-00070S-WB
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 12:23:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1foWfQ-0008MP-33
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 12:23:04 -0400
MIME-Version: 1.0
In-Reply-To: <20180810193129.1556-3-richard.henderson@linaro.org>
References: <20180810193129.1556-1-richard.henderson@linaro.org>
	<20180810193129.1556-3-richard.henderson@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Sat, 11 Aug 2018 18:23:02 +0200
Message-ID: <CABoDooOC24DN7M3idLJRa7mRAP+0UBe0Oitx-+aV_x3iFZBAXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/6] target/arm: Ignore
 float_flag_input_denormal from fp_status_f16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-stable@nongnu.org

On Fri, Aug 10, 2018 at 9:31 PM, Richard Henderson
<richard.henderson@linaro.org> wrote:
> When FZ is set, input_denormal exceptions are recognized, but this does
> not happen with FZ16.  The softfloat code has no way to distinguish
> these bits and will raise such exceptions into fp_status_f16.flags,
> so ignore them when computing the accumulated flags.
>
> Cc: qemu-stable@nongnu.org (3.0.1)
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>

Laurent

> ---
>  target/arm/helper.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 452d5e182a..61454a77ec 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11314,9 +11314,13 @@ uint32_t HELPER(vfp_get_fpscr)(CPUARMState *env)
>      fpscr = (env->vfp.xregs[ARM_VFP_FPSCR] & 0xffc8ffff)
>              | (env->vfp.vec_len << 16)
>              | (env->vfp.vec_stride << 20);
> +
>      i = get_float_exception_flags(&env->vfp.fp_status);
>      i |= get_float_exception_flags(&env->vfp.standard_fp_status);
> -    i |= get_float_exception_flags(&env->vfp.fp_status_f16);
> +    /* FZ16 does not generate an input denormal exception.  */
> +    i |= (get_float_exception_flags(&env->vfp.fp_status_f16)
> +          & ~float_flag_input_denormal);
> +
>      fpscr |= vfp_exceptbits_from_host(i);
>      return fpscr;
>  }
> --
> 2.17.1
>
