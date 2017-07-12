Received: from eggs.gnu.org ([2001:4830:134:3::10]:38457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVDqL-0003su-J8
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:22:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVDqI-0002Xj-ET
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:22:01 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:33414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dVDqI-0002Xb-59
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:21:58 -0400
Received: by mail-wr0-f171.google.com with SMTP id r103so25135771wrb.0
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 02:21:58 -0700 (PDT)
References: <149942760788.8972.474351671751194003.stgit@frigg.lan>
	<149942909046.8972.7267856934982201630.stgit@frigg.lan>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <149942909046.8972.7267856934982201630.stgit@frigg.lan>
Date: Wed, 12 Jul 2017 10:20:54 +0100
Message-ID: <877eze9fk9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v12 06/27] target/i386: [tcg] Port to
 init_disas_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>


Lluís Vilanova <vilanova@ac.upc.edu> writes:

> Incrementally paves the way towards using the generic instruction translation
> loop.
>
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> Reviewed-by: Richard Henderson <rth@twiddle.net>

Hah, I see now ;-)

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  target/i386/translate.c |   41 +++++++++++++++++++++++------------------
>  1 file changed, 23 insertions(+), 18 deletions(-)
>
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index f61f5c7227..7819545e37 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -8379,20 +8379,12 @@ void tcg_x86_init(void)
>      }
>  }
>
> -/* generate intermediate code for basic block 'tb'.  */
> -void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
> +static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
>  {
> -    CPUX86State *env = cs->env_ptr;
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
> +    DisasContext *dc = container_of(dcbase, DisasContext, base);
> +    CPUX86State *env = cpu->env_ptr;
> +    uint32_t flags = dc->base.tb->flags;
> +    target_ulong cs_base = dc->base.tb->cs_base;
>
>      dc->pe = (flags >> HF_PE_SHIFT) & 1;
>      dc->code32 = (flags >> HF_CS32_SHIFT) & 1;
> @@ -8403,11 +8395,9 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
>      dc->cpl = (flags >> HF_CPL_SHIFT) & 3;
>      dc->iopl = (flags >> IOPL_SHIFT) & 3;
>      dc->tf = (flags >> TF_SHIFT) & 1;
> -    dc->base.singlestep_enabled = cs->singlestep_enabled;
>      dc->cc_op = CC_OP_DYNAMIC;
>      dc->cc_op_dirty = false;
>      dc->cs_base = cs_base;
> -    dc->base.tb = tb;
>      dc->popl_esp_hack = 0;
>      /* select memory access functions */
>      dc->mem_index = 0;
> @@ -8425,7 +8415,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
>      dc->code64 = (flags >> HF_CS64_SHIFT) & 1;
>  #endif
>      dc->flags = flags;
> -    dc->jmp_opt = !(dc->tf || cs->singlestep_enabled ||
> +    dc->jmp_opt = !(dc->tf || dc->base.singlestep_enabled ||
>                      (flags & HF_INHIBIT_IRQ_MASK));
>      /* Do not optimize repz jumps at all in icount mode, because
>         rep movsS instructions are execured with different paths
> @@ -8437,7 +8427,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
>         record/replay modes and there will always be an
>         additional step for ecx=0 when icount is enabled.
>       */
> -    dc->repz_opt = !dc->jmp_opt && !(tb->cflags & CF_USE_ICOUNT);
> +    dc->repz_opt = !dc->jmp_opt && !(dc->base.tb->cflags & CF_USE_ICOUNT);
>  #if 0
>      /* check addseg logic */
>      if (!dc->addseg && (dc->vm86 || !dc->pe || !dc->code32))
> @@ -8456,9 +8446,24 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
>      cpu_ptr0 = tcg_temp_new_ptr();
>      cpu_ptr1 = tcg_temp_new_ptr();
>      cpu_cc_srcT = tcg_temp_local_new();
> +}
>
> +/* generate intermediate code for basic block 'tb'.  */
> +void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
> +{
> +    CPUX86State *env = cs->env_ptr;
> +    DisasContext dc1, *dc = &dc1;
> +    int num_insns;
> +    int max_insns;
> +
> +    /* generate intermediate code */
> +    dc->base.singlestep_enabled = cs->singlestep_enabled;
> +    dc->base.tb = tb;
>      dc->base.is_jmp = DISAS_NEXT;
> +    dc->base.pc_first = tb->pc;
>      dc->base.pc_next = dc->base.pc_first;
> +    i386_tr_init_disas_context(&dc->base, cs);
> +
>      num_insns = 0;
>      max_insns = tb->cflags & CF_COUNT_MASK;
>      if (max_insns == 0) {
> @@ -8500,7 +8505,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
>             the flag and abort the translation to give the irqs a
>             change to be happen */
>          if (dc->tf || dc->base.singlestep_enabled ||
> -            (flags & HF_INHIBIT_IRQ_MASK)) {
> +            (dc->base.tb->flags & HF_INHIBIT_IRQ_MASK)) {
>              gen_jmp_im(dc->base.pc_next - dc->cs_base);
>              gen_eob(dc);
>              break;


--
Alex Bennée
