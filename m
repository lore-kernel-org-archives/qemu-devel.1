Received: from eggs.gnu.org ([2001:4830:134:3::10]:43284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dLQco-0000us-CH
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 04:59:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dLQcj-0005tz-NA
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 04:59:34 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:34130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dLQcj-0005tj-HE
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 04:59:29 -0400
Received: by mail-wr0-x22d.google.com with SMTP id 77so12277700wrb.1
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 01:59:29 -0700 (PDT)
References: <20170614194821.8754-1-rth@twiddle.net>
	<20170614194821.8754-5-rth@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170614194821.8754-5-rth@twiddle.net>
Date: Thu, 15 Jun 2017 10:00:03 +0100
Message-ID: <87shj1mxrg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 4/5] target/s390x: Exit after changing
 PSW mask
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

> Exit to cpu loop so we reevaluate cpu_s390x_hw_interrupts.
>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/alpha/translate.c |  2 +-
>  target/s390x/translate.c | 14 ++++++++++----
>  2 files changed, 11 insertions(+), 5 deletions(-)

Aside from the stray alpha bit:

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>


>
> diff --git a/target/alpha/translate.c b/target/alpha/translate.c
> index a48e451..232af9e 100644
> --- a/target/alpha/translate.c
> +++ b/target/alpha/translate.c
> @@ -1207,7 +1207,7 @@ static ExitStatus gen_call_pal(DisasContext *ctx, int palcode)
>              tcg_temp_free(tmp);
>
>              /* Allow interrupts to be recognized right away.  */
> -            tcg_gen_movi_i64(cpu_pc, ctx.pc);
> +            tcg_gen_movi_i64(cpu_pc, ctx->pc);
>              return EXIT_PC_UPDATED_NOCHAIN;
>
>          case 0x36:
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 95f91d4..c9e3b81 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -1174,6 +1174,8 @@ typedef enum {
>      /* We are exiting the TB, but have neither emitted a goto_tb, nor
>         updated the PC for the next instruction to be executed.  */
>      EXIT_PC_STALE,
> +    /* We are exiting the TB to the main loop.  */
> +    EXIT_PC_STALE_NOCHAIN,
>      /* We are ending the TB with a noreturn function call, e.g. longjmp.
>         No following code will be executed.  */
>      EXIT_NORETURN,
> @@ -3796,7 +3798,8 @@ static ExitStatus op_ssm(DisasContext *s, DisasOps *o)
>  {
>      check_privileged(s);
>      tcg_gen_deposit_i64(psw_mask, psw_mask, o->in2, 56, 8);
> -    return NO_EXIT;
> +    /* Exit to main loop to reevaluate s390_cpu_exec_interrupt.  */
> +    return EXIT_PC_STALE_NOCHAIN;
>  }
>
>  static ExitStatus op_stap(DisasContext *s, DisasOps *o)
> @@ -4044,7 +4047,9 @@ static ExitStatus op_stnosm(DisasContext *s, DisasOps *o)
>      } else {
>          tcg_gen_ori_i64(psw_mask, psw_mask, i2 << 56);
>      }
> -    return NO_EXIT;
> +
> +    /* Exit to main loop to reevaluate s390_cpu_exec_interrupt.  */
> +    return EXIT_PC_STALE_NOCHAIN;
>  }
>
>  static ExitStatus op_stura(DisasContext *s, DisasOps *o)
> @@ -5794,6 +5799,7 @@ void gen_intermediate_code(CPUS390XState *env, struct TranslationBlock *tb)
>      case EXIT_NORETURN:
>          break;
>      case EXIT_PC_STALE:
> +    case EXIT_PC_STALE_NOCHAIN:
>          update_psw_addr(&dc);
>          /* FALLTHRU */
>      case EXIT_PC_UPDATED:
> @@ -5805,14 +5811,14 @@ void gen_intermediate_code(CPUS390XState *env, struct TranslationBlock *tb)
>          /* Exit the TB, either by raising a debug exception or by return.  */
>          if (do_debug) {
>              gen_exception(EXCP_DEBUG);
> -        } else if (use_exit_tb(&dc)) {
> +        } else if (use_exit_tb(&dc) || status == EXIT_PC_STALE_NOCHAIN) {
>              tcg_gen_exit_tb(0);
>          } else {
>              tcg_gen_lookup_and_goto_ptr(psw_addr);
>          }
>          break;
>      default:
> -        abort();
> +        g_assert_not_reached();
>      }
>
>      gen_tb_end(tb, num_insns);


--
Alex Bennée
