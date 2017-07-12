Received: from eggs.gnu.org ([2001:4830:134:3::10]:40813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVE0f-0002SC-CE
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:32:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVE0c-0006eQ-0Y
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:32:41 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:33444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dVE0b-0006bg-QV
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:32:37 -0400
Received: by mail-wr0-x22e.google.com with SMTP id r103so25527748wrb.0
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 02:32:37 -0700 (PDT)
References: <149942760788.8972.474351671751194003.stgit@frigg.lan>
	<149943180765.8972.18399158340352150851.stgit@frigg.lan>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <149943180765.8972.18399158340352150851.stgit@frigg.lan>
Date: Wed, 12 Jul 2017 10:32:35 +0100
Message-ID: <87y3ru80gc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v12 17/27] target/arm: [tcg] Port to
 insn_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>


Lluís Vilanova <vilanova@ac.upc.edu> writes:

> Incrementally paves the way towards using the generic instruction translation
> loop.
>
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>


> ---
>  target/arm/translate.c |   36 +++++++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 15 deletions(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 22af4e372a..7a1935d4d7 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -11896,6 +11896,26 @@ static void arm_tr_tb_start(DisasContextBase *dcbase, CPUState *cpu)
>      }
>  }
>
> +static void arm_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
> +{
> +    DisasContext *dc = container_of(dcbase, DisasContext, base);
> +
> +    dc->insn_start_idx = tcg_op_buf_count();
> +    tcg_gen_insn_start(dc->pc,
> +                       (dc->condexec_cond << 4) | (dc->condexec_mask >> 1),
> +                       0);
> +
> +#ifdef CONFIG_USER_ONLY
> +    /* Intercept jump to the magic kernel page.  */
> +    if (dc->pc >= 0xffff0000) {
> +        /* We always get here via a jump, so know we are not in a
> +           conditional execution block.  */
> +        gen_exception_internal(EXCP_KERNEL_TRAP);
> +        dc->base.is_jmp = DISAS_EXC;
> +    }
> +#endif
> +}
> +
>  /* generate intermediate code for basic block 'tb'.  */
>  void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
>  {
> @@ -11939,21 +11959,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
>
>      do {
>          dc->base.num_insns++;
> -        dc->insn_start_idx = tcg_op_buf_count();
> -        tcg_gen_insn_start(dc->pc,
> -                           (dc->condexec_cond << 4) | (dc->condexec_mask >> 1),
> -                           0);
> -
> -#ifdef CONFIG_USER_ONLY
> -        /* Intercept jump to the magic kernel page.  */
> -        if (dc->pc >= 0xffff0000) {
> -            /* We always get here via a jump, so know we are not in a
> -               conditional execution block.  */
> -            gen_exception_internal(EXCP_KERNEL_TRAP);
> -            dc->base.is_jmp = DISAS_EXC;
> -            break;
> -        }
> -#endif
> +        arm_tr_insn_start(&dc->base, cs);
>
>          if (unlikely(!QTAILQ_EMPTY(&cs->breakpoints))) {
>              CPUBreakpoint *bp;


--
Alex Bennée
