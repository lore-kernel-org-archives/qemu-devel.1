Received: from eggs.gnu.org ([2001:4830:134:3::10]:40675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVDzp-0001s3-R7
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:31:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVDzm-0006Ab-Nj
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:31:49 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:32938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dVDzm-0006AP-FJ
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:31:46 -0400
Received: by mail-wr0-x22e.google.com with SMTP id r103so25496758wrb.0
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 02:31:46 -0700 (PDT)
References: <149942760788.8972.474351671751194003.stgit@frigg.lan>
	<149943155988.8972.13072889393603458854.stgit@frigg.lan>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <149943155988.8972.13072889393603458854.stgit@frigg.lan>
Date: Wed, 12 Jul 2017 10:31:43 +0100
Message-ID: <87zica80hs.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v12 16/27] target/arm: [tcg] Port to
 tb_start
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
>  target/arm/translate.c |   82 ++++++++++++++++++++++++++----------------------
>  1 file changed, 44 insertions(+), 38 deletions(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 0179b1ce79..22af4e372a 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -11853,6 +11853,49 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase,
>      cpu_M0 = tcg_temp_new_i64();
>  }
>
> +static void arm_tr_tb_start(DisasContextBase *dcbase, CPUState *cpu)
> +{
> +    DisasContext *dc = container_of(dcbase, DisasContext, base);
> +
> +    /* A note on handling of the condexec (IT) bits:
> +     *
> +     * We want to avoid the overhead of having to write the updated condexec
> +     * bits back to the CPUARMState for every instruction in an IT block. So:
> +     * (1) if the condexec bits are not already zero then we write
> +     * zero back into the CPUARMState now. This avoids complications trying
> +     * to do it at the end of the block. (For example if we don't do this
> +     * it's hard to identify whether we can safely skip writing condexec
> +     * at the end of the TB, which we definitely want to do for the case
> +     * where a TB doesn't do anything with the IT state at all.)
> +     * (2) if we are going to leave the TB then we call gen_set_condexec()
> +     * which will write the correct value into CPUARMState if zero is wrong.
> +     * This is done both for leaving the TB at the end, and for leaving
> +     * it because of an exception we know will happen, which is done in
> +     * gen_exception_insn(). The latter is necessary because we need to
> +     * leave the TB with the PC/IT state just prior to execution of the
> +     * instruction which caused the exception.
> +     * (3) if we leave the TB unexpectedly (eg a data abort on a load)
> +     * then the CPUARMState will be wrong and we need to reset it.
> +     * This is handled in the same way as restoration of the
> +     * PC in these situations; we save the value of the condexec bits
> +     * for each PC via tcg_gen_insn_start(), and restore_state_to_opc()
> +     * then uses this to restore them after an exception.
> +     *
> +     * Note that there are no instructions which can read the condexec
> +     * bits, and none which can write non-static values to them, so
> +     * we don't need to care about whether CPUARMState is correct in the
> +     * middle of a TB.
> +     */
> +
> +    /* Reset the conditional execution bits immediately. This avoids
> +       complications trying to do it at the end of the block.  */
> +    if (dc->condexec_mask || dc->condexec_cond) {
> +        TCGv_i32 tmp = tcg_temp_new_i32();
> +        tcg_gen_movi_i32(tmp, 0);
> +        store_cpu_field(tmp, condexec_bits);
> +    }
> +}
> +
>  /* generate intermediate code for basic block 'tb'.  */
>  void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
>  {
> @@ -11892,45 +11935,8 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
>      gen_tb_start(tb);
>
>      tcg_clear_temp_count();
> +    arm_tr_tb_start(&dc->base, cs);
>
> -    /* A note on handling of the condexec (IT) bits:
> -     *
> -     * We want to avoid the overhead of having to write the updated condexec
> -     * bits back to the CPUARMState for every instruction in an IT block. So:
> -     * (1) if the condexec bits are not already zero then we write
> -     * zero back into the CPUARMState now. This avoids complications trying
> -     * to do it at the end of the block. (For example if we don't do this
> -     * it's hard to identify whether we can safely skip writing condexec
> -     * at the end of the TB, which we definitely want to do for the case
> -     * where a TB doesn't do anything with the IT state at all.)
> -     * (2) if we are going to leave the TB then we call gen_set_condexec()
> -     * which will write the correct value into CPUARMState if zero is wrong.
> -     * This is done both for leaving the TB at the end, and for leaving
> -     * it because of an exception we know will happen, which is done in
> -     * gen_exception_insn(). The latter is necessary because we need to
> -     * leave the TB with the PC/IT state just prior to execution of the
> -     * instruction which caused the exception.
> -     * (3) if we leave the TB unexpectedly (eg a data abort on a load)
> -     * then the CPUARMState will be wrong and we need to reset it.
> -     * This is handled in the same way as restoration of the
> -     * PC in these situations; we save the value of the condexec bits
> -     * for each PC via tcg_gen_insn_start(), and restore_state_to_opc()
> -     * then uses this to restore them after an exception.
> -     *
> -     * Note that there are no instructions which can read the condexec
> -     * bits, and none which can write non-static values to them, so
> -     * we don't need to care about whether CPUARMState is correct in the
> -     * middle of a TB.
> -     */
> -
> -    /* Reset the conditional execution bits immediately. This avoids
> -       complications trying to do it at the end of the block.  */
> -    if (dc->condexec_mask || dc->condexec_cond)
> -      {
> -        TCGv_i32 tmp = tcg_temp_new_i32();
> -        tcg_gen_movi_i32(tmp, 0);
> -        store_cpu_field(tmp, condexec_bits);
> -      }
>      do {
>          dc->base.num_insns++;
>          dc->insn_start_idx = tcg_op_buf_count();


--
Alex Bennée
