Received: from eggs.gnu.org ([2001:4830:134:3::10]:60154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYhEG-0006AF-Fp
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 19:21:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYhEB-0007az-Sq
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 19:21:04 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38993)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dYhEB-0007at-Nr
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 19:20:59 -0400
Date: Fri, 21 Jul 2017 19:20:58 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170721232058.GQ10809@flamenco>
References: <20170715094243.28371-1-rth@twiddle.net>
	<20170715094243.28371-25-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170715094243.28371-25-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v14 24/34] target/arm: [tcg] Port to
 translate_insn
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

On Fri, Jul 14, 2017 at 23:42:33 -1000, Richard Henderson wrote:
> From: Lluís Vilanova <vilanova@ac.upc.edu>
> 
> Incrementally paves the way towards using the generic instruction translation
> loop.
> 
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> Message-Id: <150002485863.22386.13949856269576226529.stgit@frigg.lan>
> [rth: Adjust for translate_insn interface change.]
> Signed-off-by: Richard Henderson <rth@twiddle.net>
(snip)
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -11842,6 +11842,8 @@ static int arm_tr_init_disas_context(DisasContextBase *dcbase,
>      dc->is_ldex = false;
>      dc->ss_same_el = false; /* Can't be true since EL_d must be AArch64 */
>  
> +    dc->next_page_start =
> +        (dc->base.pc_first & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
>  
>      cpu_F0s = tcg_temp_new_i32();
>      cpu_F1s = tcg_temp_new_i32();
> @@ -11935,14 +11937,93 @@ static bool arm_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
>      return true;
>  }
>  
> +static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
> +{
> +    DisasContext *dc = container_of(dcbase, DisasContext, base);
> +    CPUARMState *env = cpu->env_ptr;
> +
> +#ifdef CONFIG_USER_ONLY
> +        /* Intercept jump to the magic kernel page.  */
> +        if (dc->pc >= 0xffff0000) {
> +            /* We always get here via a jump, so know we are not in a
> +               conditional execution block.  */
> +            gen_exception_internal(EXCP_KERNEL_TRAP);
> +            dc->base.is_jmp = DISAS_NORETURN;
> +            return;
> +        }
> +#endif

Nit: Indent this properly here to avoid the indent fix in patch 33.

		E.
