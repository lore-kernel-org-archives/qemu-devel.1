Received: from eggs.gnu.org ([2001:4830:134:3::10]:41872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQk0G-00026j-O5
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 20:41:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQk0C-0006dd-1u
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 20:41:44 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:44119)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dQk0B-0006d3-Mm
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 20:41:39 -0400
Date: Thu, 29 Jun 2017 20:41:34 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170630004134.GJ13979@flamenco>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865462073.17063.17488435214703164893.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <149865462073.17063.17488435214703164893.stgit@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v11 10/29] target/i386: [tcg] Refactor
 translate_insn
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

On Wed, Jun 28, 2017 at 15:57:00 +0300, Lluís Vilanova wrote:
> Incrementally paves the way towards using the generic instruction translation
> loop.
> 
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> ---
>  target/i386/translate.c |   72 +++++++++++++++++++++++++++++++----------------
>  1 file changed, 48 insertions(+), 24 deletions(-)
> 
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index 3eee348de7..da4b409d97 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -4420,15 +4420,17 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
>  
>  /* convert one instruction. s->base.is_jmp is set if the translation must
>     be stopped. Return the next pc value */
> -static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
> -                               target_ulong pc_start)
> +static target_ulong disas_insn(DisasContextBase *dcbase, CPUState *cpu)
>  {
> +    DisasContext *s = container_of(dcbase, DisasContext, base);
> +    CPUX86State *env = cpu->env_ptr;

Minor nit: you can pass dc (*s) here directly, no need for container_of

(snip)
> +static target_ulong i386_trblock_translate_insn(DisasContextBase *dcbase,
> +                                                CPUState *cpu)
> +{
> +    DisasContext *dc = container_of(dcbase, DisasContext, base);
> +    target_ulong pc_next = disas_insn(&dc->base, cpu);
> +
> +    if (dc->base.is_jmp) {
> +        return pc_next;
> +    }
> +
> +    if (dc->tf || (dc->base.tb->flags & HF_INHIBIT_IRQ_MASK)) {
> +        /* if single step mode, we generate only one instruction and
> +           generate an exception */
> +        /* if irq were inhibited with HF_INHIBIT_IRQ_MASK, we clear
> +           the flag and abort the translation to give the irqs a
> +           change to be happen */

I know you just moved lines around, but while at it, s/change to be/chance to/

Other than that,

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
