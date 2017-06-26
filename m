Received: from eggs.gnu.org ([2001:4830:134:3::10]:55740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dPSE4-0001QV-Qv
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 07:30:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dPSE1-00048d-Nu
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 07:30:40 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:33556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dPSE1-00047s-HD
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 07:30:37 -0400
Received: by mail-wr0-x22b.google.com with SMTP id r103so143212825wrb.0
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 04:30:37 -0700 (PDT)
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
	<149838531005.6497.12362377034456580175.stgit@frigg.lan>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <149838531005.6497.12362377034456580175.stgit@frigg.lan>
Date: Mon, 26 Jun 2017 12:31:26 +0100
Message-ID: <87d19rx9wx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v9 21/26] target: [tcg,
 arm] Port to insn_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>


Lluís Vilanova <vilanova@ac.upc.edu> writes:

> Incrementally paves the way towards using the generic instruction translation
> loop.
>
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> ---
>  target/arm/translate-a64.c |   11 +++++++++--
>  target/arm/translate.c     |   36 +++++++++++++++++++++---------------
>  2 files changed, 30 insertions(+), 17 deletions(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 1959f27377..bfc2cdabb5 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -11259,6 +11259,14 @@ static void aarch64_trblock_init_disas_context(DisasContextBase *db,
>      init_tmp_a64_array(dc);
>  }
>
> +static void aarch64_trblock_insn_start(DisasContextBase *db, CPUState *cpu)
> +{
> +    DisasContext *dc = container_of(db, DisasContext, base);
> +
> +    dc->insn_start_idx = tcg_op_buf_count();
> +    tcg_gen_insn_start(dc->pc, 0, 0);
> +}
> +
>  void gen_intermediate_code_a64(DisasContextBase *db, ARMCPU *cpu,
>                                 TranslationBlock *tb)
>  {
> @@ -11291,8 +11299,7 @@ void gen_intermediate_code_a64(DisasContextBase *db, ARMCPU *cpu,
>
>      do {
>          db->num_insns++;
> -        dc->insn_start_idx = tcg_op_buf_count();
> -        tcg_gen_insn_start(dc->pc, 0, 0);
> +        aarch64_trblock_insn_start(db, cs);
>
>          if (unlikely(!QTAILQ_EMPTY(&cs->breakpoints))) {
>              CPUBreakpoint *bp;
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index ae3f772446..18b0e8fbb6 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -11934,6 +11934,26 @@ static void arm_trblock_tb_start(DisasContextBase *db, CPUState *cpu)
>      }
>  }
>
> +static void arm_trblock_insn_start(DisasContextBase *db, CPUState *cpu)
> +{
> +    DisasContext *dc = container_of(db, DisasContext, base);
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
> +        dc->is_jmp = DJ_EXC;

This fails to build.

> +    }
> +#endif
> +}
> +
>  /* generate intermediate code for basic block 'tb'.  */
>  void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
>  {
> @@ -11981,21 +12001,7 @@ void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb)
>
>      do {
>          db->num_insns++;
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
> -            dc->is_jmp = DJ_EXC;
> -            break;
> -        }
> -#endif
> +        arm_trblock_insn_start(db, cpu);
>
>          if (unlikely(!QTAILQ_EMPTY(&cpu->breakpoints))) {
>              CPUBreakpoint *bp;


--
Alex Bennée
