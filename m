Received: from eggs.gnu.org ([2001:4830:134:3::10]:60646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYhI5-000728-Rh
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 19:25:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYhI1-0000lI-1g
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 19:25:01 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49889)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dYhI0-0000l7-Sz
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 19:24:56 -0400
Date: Fri, 21 Jul 2017 19:24:56 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170721232456.GR10809@flamenco>
References: <20170715094243.28371-1-rth@twiddle.net>
	<20170715094243.28371-34-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170715094243.28371-34-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v14 33/34] target/arm: Split out
 thumb_tr_translate_insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, vilanova@ac.upc.edu, alex.bennee@linaro.org, crosthwaite.peter@gmail.com, pbonzini@redhat.com

On Fri, Jul 14, 2017 at 23:42:42 -1000, Richard Henderson wrote:
> We need not check for ARM vs Thumb state in order to dispatch
> disassembly of every instruction.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/arm/translate.c | 134 +++++++++++++++++++++++++++++++------------------
>  1 file changed, 86 insertions(+), 48 deletions(-)
> 
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index ebe1c1a..d7c3c10 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -11944,20 +11944,17 @@ static bool arm_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
>      return true;
>  }
>  
> -static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
> +static bool arm_pre_translate_insn(DisasContext *dc)
>  {
> -    DisasContext *dc = container_of(dcbase, DisasContext, base);
> -    CPUARMState *env = cpu->env_ptr;
> -
>  #ifdef CONFIG_USER_ONLY
> -        /* Intercept jump to the magic kernel page.  */
> -        if (dc->pc >= 0xffff0000) {
> -            /* We always get here via a jump, so know we are not in a
> -               conditional execution block.  */
> -            gen_exception_internal(EXCP_KERNEL_TRAP);
> -            dc->base.is_jmp = DISAS_NORETURN;
> -            return;
> -        }
> +    /* Intercept jump to the magic kernel page.  */
> +    if (dc->pc >= 0xffff0000) {
> +        /* We always get here via a jump, so know we are not in a
> +           conditional execution block.  */
> +        gen_exception_internal(EXCP_KERNEL_TRAP);
> +        dc->base.is_jmp = DISAS_NORETURN;
> +        return true;
> +    }

See my comment in patch 24 about this.

Other than that, this is neat.
Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
