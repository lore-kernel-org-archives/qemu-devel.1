Received: from eggs.gnu.org ([2001:4830:134:3::10]:35814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQjk4-0004nk-3P
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 20:25:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQjk0-0004OU-3j
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 20:25:00 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:37911)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dQjjz-0004OE-N8
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 20:24:56 -0400
Date: Thu, 29 Jun 2017 20:24:54 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170630002454.GI13979@flamenco>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865437871.17063.9119703949695421203.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <149865437871.17063.9119703949695421203.stgit@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v11 09/29] target/i386: [tcg] Refactor
 breakpoint_check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Wed, Jun 28, 2017 at 15:52:58 +0300, Lluís Vilanova wrote:
> Incrementally paves the way towards using the generic instruction translation
> loop.
> 
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> ---
>  target/i386/translate.c |   59 ++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 48 insertions(+), 11 deletions(-)
> 
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index ad57be2928..3eee348de7 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -18,6 +18,7 @@
>   */
>  #include "qemu/osdep.h"
>  
> +#include "qemu/error-report.h"

I can't find why this one is included here.

>  #include "qemu/host-utils.h"
>  #include "cpu.h"
>  #include "disas/disas.h"
> @@ -8458,6 +8459,25 @@ static void i386_trblock_insn_start(DisasContextBase *dcbase, CPUState *cpu)
>      tcg_gen_insn_start(dc->base.pc_next, dc->cc_op);
>  }
>  
> +static BreakpointCheckType i386_trblock_breakpoint_check(
> +    DisasContextBase *dcbase, CPUState *cpu, const CPUBreakpoint *bp)
> +{
> +    DisasContext *dc = container_of(dcbase, DisasContext, base);
> +    /* If RF is set, suppress an internally generated breakpoint.  */
> +    int flags = dc->base.tb->flags & HF_RF_MASK ? BP_GDB : BP_ANY;
> +    if (bp->flags & flags) {
> +        gen_debug(dc, dc->base.pc_next - dc->cs_base);
> +        /* The address covered by the breakpoint must be included in
> +           [tb->pc, tb->pc + tb->size) in order to for it to be
> +           properly cleared -- thus we increment the PC here so that
> +           the logic setting tb->size below does the right thing.  */
> +        dc->base.pc_next += 1;
> +        return BC_HIT_TB;
> +    } else {
> +        return BC_MISS;
> +    }
> +}
> +
>  /* generate intermediate code for basic block 'tb'.  */
>  void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
>  {
> @@ -8490,18 +8510,35 @@ void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
>          i386_trblock_insn_start(&dc->base, cpu);
>          num_insns++;
>  
> -        /* If RF is set, suppress an internally generated breakpoint.  */
> -        if (unlikely(cpu_breakpoint_test(cpu, dc->base.pc_next,
> -                                         tb->flags & HF_RF_MASK
> -                                         ? BP_GDB : BP_ANY))) {
> -            gen_debug(dc, dc->base.pc_next - dc->cs_base);
> -            /* The address covered by the breakpoint must be included in
> -               [tb->pc, tb->pc + tb->size) in order to for it to be
> -               properly cleared -- thus we increment the PC here so that
> -               the logic setting tb->size below does the right thing.  */
> -            dc->base.pc_next += 1;
> -            goto done_generating;
> +        if (unlikely(!QTAILQ_EMPTY(&cpu->breakpoints))) {
> +            CPUBreakpoint *bp;
> +            QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
> +                if (bp->pc == dc->base.pc_next) {
> +                    BreakpointCheckType bp_check =
> +                        i386_trblock_breakpoint_check(&dc->base, cpu, bp);
> +                    switch (bp_check) {
> +                    case BC_MISS:
> +                        /* Target ignored this breakpoint, go to next */
> +                        break;
> +                    case BC_HIT_INSN:
> +                        /* Hit, keep translating */
> +                        /*
> +                         * TODO: if we're never going to have more than one
> +                         *       BP in a single address, we can simply use a
> +                         *       bool here.
> +                         */
> +                        goto done_breakpoints;

BC_HIT_INSN is not needed here, but I see what you're doing.

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
