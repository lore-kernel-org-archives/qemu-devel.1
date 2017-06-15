Received: from eggs.gnu.org ([2001:4830:134:3::10]:40633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dLQRq-0004LK-Ka
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 04:48:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dLQRl-0002Zi-Qp
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 04:48:14 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:36751)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dLQRl-0002ZI-Hp
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 04:48:09 -0400
Received: by mail-wr0-x22f.google.com with SMTP id 36so11785371wry.3
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 01:48:08 -0700 (PDT)
References: <20170614194821.8754-1-rth@twiddle.net>
	<20170614194821.8754-3-rth@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170614194821.8754-3-rth@twiddle.net>
Date: Thu, 15 Jun 2017 09:48:43 +0100
Message-ID: <87vanxmyac.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/5] target/alpha: Use
 tcg_gen_lookup_and_goto_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, cota@braap.org, pbonzini@redhat.com


Richard Henderson <rth@twiddle.net> writes:

> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/alpha/translate.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/target/alpha/translate.c b/target/alpha/translate.c
> index 7c45ae3..a48e451 100644
> --- a/target/alpha/translate.c
> +++ b/target/alpha/translate.c
> @@ -84,6 +84,7 @@ typedef enum {
>         the PC (for whatever reason), so there's no need to do it again on
>         exiting the TB.  */
>      EXIT_PC_UPDATED,
> +    EXIT_PC_UPDATED_NOCHAIN,
>
>      /* We are exiting the TB, but have neither emitted a goto_tb, nor
>         updated the PC for the next instruction to be executed.  */
> @@ -458,11 +459,17 @@ static bool in_superpage(DisasContext *ctx, int64_t addr)
>  #endif
>  }
>
> +static bool use_exit_tb(DisasContext *ctx)
> +{
> +    return ((ctx->tb->cflags & CF_LAST_IO)
> +            || ctx->singlestep_enabled
> +            || singlestep);
> +}

minor nit: why start testing this global? At the least we should
probably seed ctx->singlestep_enabled when we set up for translation.

> +
>  static bool use_goto_tb(DisasContext *ctx, uint64_t dest)
>  {
>      /* Suppress goto_tb in the case of single-steping and IO.  */
> -    if ((ctx->tb->cflags & CF_LAST_IO)
> -        || ctx->singlestep_enabled || singlestep) {
> +    if (unlikely(use_exit_tb(ctx))) {
>          return false;
>      }
>  #ifndef CONFIG_USER_ONLY
> @@ -1198,7 +1205,10 @@ static ExitStatus gen_call_pal(DisasContext *ctx, int palcode)
>              tcg_gen_andi_i64(tmp, ctx->ir[IR_A0], PS_INT_MASK);
>              tcg_gen_st8_i64(tmp, cpu_env, offsetof(CPUAlphaState, ps));
>              tcg_temp_free(tmp);
> -            break;
> +
> +            /* Allow interrupts to be recognized right away.  */
> +            tcg_gen_movi_i64(cpu_pc, ctx.pc);
> +            return EXIT_PC_UPDATED_NOCHAIN;
>
>          case 0x36:
>              /* RDPS */
> @@ -1266,7 +1276,7 @@ static ExitStatus gen_call_pal(DisasContext *ctx, int palcode)
>             need the page permissions check.  We'll see the existence of
>             the page when we create the TB, and we'll flush all TBs if
>             we change the PAL base register.  */
> -        if (!ctx->singlestep_enabled && !(ctx->tb->cflags & CF_LAST_IO)) {
> +        if (!use_exit_tb(ctx)) {
>              tcg_gen_goto_tb(0);
>              tcg_gen_movi_i64(cpu_pc, entry);
>              tcg_gen_exit_tb((uintptr_t)ctx->tb);
> @@ -2686,7 +2696,8 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
>          tcg_gen_andi_i64(tmp, vb, 1);
>          tcg_gen_st8_i64(tmp, cpu_env, offsetof(CPUAlphaState, pal_mode));
>          tcg_gen_andi_i64(cpu_pc, vb, ~3);
> -        ret = EXIT_PC_UPDATED;
> +        /* Allow interrupts to be recognized right away.  */
> +        ret = EXIT_PC_UPDATED_NOCHAIN;
>          break;
>  #else
>          goto invalid_opc;
> @@ -3010,6 +3021,12 @@ void gen_intermediate_code(CPUAlphaState *env, struct TranslationBlock *tb)
>          tcg_gen_movi_i64(cpu_pc, ctx.pc);
>          /* FALLTHRU */
>      case EXIT_PC_UPDATED:
> +        if (!use_exit_tb(&ctx)) {
> +            tcg_gen_lookup_and_goto_ptr(cpu_pc);
> +            break;
> +        }
> +        /* FALLTHRU */
> +    case EXIT_PC_UPDATED_NOCHAIN:
>          if (ctx.singlestep_enabled) {
>              gen_excp_1(EXCP_DEBUG, 0);
>          } else {

Aside from what Emilio already pointed at:

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

--
Alex Bennée
