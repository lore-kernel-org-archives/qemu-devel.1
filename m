Received: from eggs.gnu.org ([2001:4830:134:3::10]:38238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d49PB-0004Vn-7i
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 13:10:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d49P6-0005fv-EM
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 13:10:05 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:38234)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d49P6-0005fi-3y
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 13:10:00 -0400
Received: by mail-wm0-x22f.google.com with SMTP id r190so52875094wme.1
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 10:10:00 -0700 (PDT)
References: <20170427120006.20564-1-rth@twiddle.net>
	<20170427120006.20564-15-rth@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170427120006.20564-15-rth@twiddle.net>
Date: Fri, 28 Apr 2017 18:10:30 +0100
Message-ID: <87mvb07915.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 14/19] target/alpha: Use tcg_gen_goto_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, cota@braap.org


Richard Henderson <rth@twiddle.net> writes:

> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/alpha/translate.c | 49 +++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 36 insertions(+), 13 deletions(-)
>
> diff --git a/target/alpha/translate.c b/target/alpha/translate.c
> index df5d695..c1a5fbf 100644
> --- a/target/alpha/translate.c
> +++ b/target/alpha/translate.c
> @@ -89,6 +89,10 @@ typedef enum {
>         updated the PC for the next instruction to be executed.  */
>      EXIT_PC_STALE,
>
> +    /* Similarly, but force TB exit without chaining.  */
> +    EXIT_PC_UPDATED_FORCE,
> +    EXIT_PC_STALE_FORCE,
> +
>      /* We are ending the TB with a noreturn function call, e.g. longjmp.
>         No following code will be executed.  */
>      EXIT_NORETURN,
> @@ -455,11 +459,16 @@ static bool in_superpage(DisasContext *ctx, int64_t addr)
>  #endif
>  }
>
> +static bool use_exit_tb(DisasContext *ctx)
> +{
> +    /* Suppress any optimization in the case of single-steping and IO.  */
> +    return ((ctx->tb->cflags & CF_LAST_IO)
> +            || ctx->singlestep_enabled || singlestep);
> +}
> +
>  static bool use_goto_tb(DisasContext *ctx, uint64_t dest)
>  {
> -    /* Suppress goto_tb in the case of single-steping and IO.  */
> -    if ((ctx->tb->cflags & CF_LAST_IO)
> -        || ctx->singlestep_enabled || singlestep) {
> +    if (use_exit_tb(ctx)) {
>          return false;
>      }
>  #ifndef CONFIG_USER_ONLY
> @@ -1257,14 +1266,14 @@ static ExitStatus gen_call_pal(DisasContext *ctx, int palcode)
>             need the page permissions check.  We'll see the existence of
>             the page when we create the TB, and we'll flush all TBs if
>             we change the PAL base register.  */
> -        if (!ctx->singlestep_enabled && !(ctx->tb->cflags & CF_LAST_IO)) {
> +        if (use_exit_tb(ctx)) {
> +            tcg_gen_movi_i64(cpu_pc, entry);
> +            return EXIT_PC_UPDATED;
> +        } else {
>              tcg_gen_goto_tb(0);
>              tcg_gen_movi_i64(cpu_pc, entry);
>              tcg_gen_exit_tb((uintptr_t)ctx->tb);
>              return EXIT_GOTO_TB;
> -        } else {
> -            tcg_gen_movi_i64(cpu_pc, entry);
> -            return EXIT_PC_UPDATED;
>          }
>      }
>  #endif
> @@ -1323,7 +1332,7 @@ static ExitStatus gen_mfpr(DisasContext *ctx, TCGv va, int regno)
>              gen_io_start();
>              helper(va);
>              gen_io_end();
> -            return EXIT_PC_STALE;
> +            return EXIT_PC_STALE_FORCE;
>          } else {
>              helper(va);
>          }
> @@ -1374,7 +1383,7 @@ static ExitStatus gen_mtpr(DisasContext *ctx, TCGv vb, int regno)
>      case 252:
>          /* HALT */
>          gen_helper_halt(vb);
> -        return EXIT_PC_STALE;
> +        return EXIT_PC_STALE_FORCE;
>
>      case 251:
>          /* ALARM */
> @@ -1388,7 +1397,7 @@ static ExitStatus gen_mtpr(DisasContext *ctx, TCGv vb, int regno)
>             that ended with a CALL_PAL.  Since the base register usually only
>             changes during boot, flushing everything works well.  */
>          gen_helper_tb_flush(cpu_env);
> -        return EXIT_PC_STALE;
> +        return EXIT_PC_STALE_FORCE;
>
>      case 32 ... 39:
>          /* Accessing the "non-shadow" general registers.  */
> @@ -2373,7 +2382,7 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
>                  gen_io_start();
>                  gen_helper_load_pcc(va, cpu_env);
>                  gen_io_end();
> -                ret = EXIT_PC_STALE;
> +                ret = EXIT_PC_STALE_FORCE;
>              } else {
>                  gen_helper_load_pcc(va, cpu_env);
>              }
> @@ -2990,18 +2999,32 @@ void gen_intermediate_code(CPUAlphaState *env, struct TranslationBlock *tb)
>      case EXIT_GOTO_TB:
>      case EXIT_NORETURN:
>          break;
> +
>      case EXIT_PC_STALE:
>          tcg_gen_movi_i64(cpu_pc, ctx.pc);
> -        /* FALLTHRU */
> +        goto do_exit_pc_updated;
> +    case EXIT_PC_STALE_FORCE:
> +        tcg_gen_movi_i64(cpu_pc, ctx.pc);
> +        goto do_exit_pc_updated_force;
> +
>      case EXIT_PC_UPDATED:
> +    do_exit_pc_updated:
> +        if (!use_exit_tb(&ctx)) {
> +            tcg_gen_lookup_and_goto_ptr(cpu_pc);
> +            break;
> +        }
> +        /* FALLTHRU */
> +    case EXIT_PC_UPDATED_FORCE:
> +    do_exit_pc_updated_force:
>          if (ctx.singlestep_enabled) {
>              gen_excp_1(EXCP_DEBUG, 0);
>          } else {
>              tcg_gen_exit_tb(0);
>          }
>          break;

Hmm this is ugly. You can make it a bit cleaner I think:

    case EXIT_PC_STALE:
        tcg_gen_movi_i64(cpu_pc, ctx.pc);
        /* FALLTHRU */
    case EXIT_PC_UPDATED:
        if (!use_exit_tb(&ctx)) {
            tcg_gen_lookup_and_goto_ptr(cpu_pc);
            break;
        }
        goto do_exit_pc_updated_force;

    case EXIT_PC_STALE_FORCE:
        tcg_gen_movi_i64(cpu_pc, ctx.pc);
        /* FALLTHRU */

    case EXIT_PC_UPDATED_FORCE:
    do_exit_pc_updated_force:
        if (ctx.singlestep_enabled) {
            gen_excp_1(EXCP_DEBUG, 0);
        } else {
            tcg_gen_exit_tb(0);
        }
        break;

But personally I'd be tempted to inline the force function and have:

static inline gen_exit_or_excp(void)
{
    if (ctx.singlestep_enabled) {
        gen_excp_1(EXCP_DEBUG, 0);
    } else {
        tcg_gen_exit_tb(0);
    }
}

and:

    case EXIT_PC_STALE:
        tcg_gen_movi_i64(cpu_pc, ctx.pc);
        /* FALLTHRU */
    case EXIT_PC_UPDATED:
        if (!use_exit_tb(&ctx)) {
            tcg_gen_lookup_and_goto_ptr(cpu_pc);
            break;
        }
        gen_exit_or_excp();
        break;

    case EXIT_PC_STALE_FORCE:
        tcg_gen_movi_i64(cpu_pc, ctx.pc);
        /* FALLTHRU */

    case EXIT_PC_UPDATED_FORCE:
        gen_exit_or_excp();
        break;

    default:
        g_assert_not_reached();
    }



> +
>      default:
> -        abort();
> +        g_assert_not_reached();
>      }
>
>      gen_tb_end(tb, num_insns);


--
Alex Bennée
