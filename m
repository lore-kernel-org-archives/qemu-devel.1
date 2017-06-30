Received: from eggs.gnu.org ([2001:4830:134:3::10]:54554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQkTY-0006MF-EX
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 21:12:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQkTT-0003Zl-Ll
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 21:12:00 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:56683)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dQkTT-0003ZZ-FZ
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 21:11:55 -0400
Date: Thu, 29 Jun 2017 21:11:54 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170630011154.GM13979@flamenco>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865534644.17063.5754453204442221401.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <149865534644.17063.5754453204442221401.stgit@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v11 13/29] target/i386: [tcg] Port to
 generic translation framework
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

On Wed, Jun 28, 2017 at 16:09:06 +0300, Lluís Vilanova wrote:
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> ---

Reviewed-by: Emilio G. Cota <cota@braap.org>
Tested-by: Emilio G. Cota <cota@braap.org>

BTW have you tested icount mode?

Minor nits below.

>  target/i386/translate.c |  120 +++++++----------------------------------------
>  1 file changed, 18 insertions(+), 102 deletions(-)
> 
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index 3950fe95a4..295be26a95 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
(snip)
> @@ -8544,111 +8548,23 @@ static void i386_trblock_disas_log(const DisasContextBase *dcbase,
>  
>  }
>  
> +static const TranslatorOps i386_trblock_ops = {
> +    .init_disas_context = i386_trblock_init_disas_context,
> +    .init_globals = i386_trblock_init_globals,
> +    .tb_start = i386_trblock_tb_start,
> +    .insn_start = i386_trblock_insn_start,
> +    .breakpoint_check = i386_trblock_breakpoint_check,
> +    .translate_insn = i386_trblock_translate_insn,
> +    .tb_stop = i386_trblock_tb_stop,
> +    .disas_log = i386_trblock_disas_log,
> +};

I like hard tabs here, which make things visually easier, e.g.:

> +static const TranslatorOps i386_trblock_ops = {
> +    .init_disas_context	= i386_trblock_init_disas_context,
> +    .init_globals		= i386_trblock_init_globals,

Don't know whether checkpatch likes it, but I do, and I see some
examples in the code base.

>  /* generate intermediate code for basic block 'tb'.  */
>  void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
>  {
(snip)
> +    DisasContext dc1;
>  
> -    tb->size = dc->base.pc_next - dc->base.pc_first;
> -    tb->icount = num_insns;
> +    translate_block(&i386_trblock_ops, &dc1.base, cpu, tb);
>  }

I'd just call it dc, then.

		E.
