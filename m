Received: from eggs.gnu.org ([2001:4830:134:3::10]:50303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQjDm-0003uF-2Y
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 19:51:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQjDi-0003ni-VO
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 19:51:38 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:57713)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dQjDi-0003nK-JA
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 19:51:34 -0400
Date: Thu, 29 Jun 2017 19:51:33 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170629235133.GE13979@flamenco>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865365245.17063.7830070270971603805.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <149865365245.17063.7830070270971603805.stgit@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v11 06/29] target/i386: [tcg] Refactor
 init_disas_context
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

On Wed, Jun 28, 2017 at 15:40:52 +0300, Lluís Vilanova wrote:
> Incrementally paves the way towards using the generic instruction translation
> loop.
> 
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> ---
>  target/i386/translate.c |   43 ++++++++++++++++++++++++-------------------
>  1 file changed, 24 insertions(+), 19 deletions(-)
> 
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index 8cf2485e2c..04453ce48a 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -8379,20 +8379,12 @@ void tcg_x86_init(void)
>      }
>  }
>  
> -/* generate intermediate code for basic block 'tb'.  */
> -void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
> +static void i386_trblock_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)

Or just i386_tr_init_(..) -- this brings the line under 80 characters.

>  {
> +    DisasContext *dc = container_of(dcbase, DisasContext, base);
>      CPUX86State *env = cpu->env_ptr;
> -    DisasContext dc1, *dc = &dc1;
> -    uint32_t flags;
> -    target_ulong cs_base;
> -    int num_insns;
> -    int max_insns;
> -
> -    /* generate intermediate code */
> -    dc->base.pc_first = tb->pc;
> -    cs_base = tb->cs_base;
> -    flags = tb->flags;
> +    uint32_t flags = dc->base.tb->flags;
> +    target_ulong cs_base = dc->base.tb->cs_base;
>  
>      dc->pe = (flags >> HF_PE_SHIFT) & 1;
>      dc->code32 = (flags >> HF_CS32_SHIFT) & 1;
> @@ -8403,11 +8395,9 @@ void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
>      dc->cpl = (flags >> HF_CPL_SHIFT) & 3;
>      dc->iopl = (flags >> IOPL_SHIFT) & 3;
>      dc->tf = (flags >> TF_SHIFT) & 1;
> -    dc->base.singlestep_enabled = cpu->singlestep_enabled;
>      dc->cc_op = CC_OP_DYNAMIC;
>      dc->cc_op_dirty = false;
>      dc->cs_base = cs_base;
> -    dc->base.tb = tb;
>      dc->popl_esp_hack = 0;
>      /* select memory access functions */
>      dc->mem_index = 0;
> @@ -8425,7 +8415,7 @@ void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
>      dc->code64 = (flags >> HF_CS64_SHIFT) & 1;
>  #endif
>      dc->flags = flags;
> -    dc->jmp_opt = !(dc->tf || cpu->singlestep_enabled ||
> +    dc->jmp_opt = !(dc->tf || dc->base.singlestep_enabled ||

Why this change and not leaving cpu->singlestep_enabled?

		E.
