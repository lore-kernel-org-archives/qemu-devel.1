Received: from eggs.gnu.org ([2001:4830:134:3::10]:42725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dLQaJ-0007UH-T3
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 04:57:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dLQaF-00052J-U2
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 04:56:59 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:33780)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dLQaF-00052C-MT
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 04:56:55 -0400
Received: by mail-wr0-x232.google.com with SMTP id r103so12262537wrb.0
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 01:56:55 -0700 (PDT)
References: <20170614194821.8754-1-rth@twiddle.net>
	<20170614194821.8754-4-rth@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170614194821.8754-4-rth@twiddle.net>
Date: Thu, 15 Jun 2017 09:57:29 +0100
Message-ID: <87tw3hmxvq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 3/5] target/mips: Exit after enabling
 interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, cota@braap.org, pbonzini@redhat.com, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>


Richard Henderson <rth@twiddle.net> writes:

> From: Paolo Bonzini <pbonzini@redhat.com>
>
> Exit to cpu loop so we reevaluate cpu_mips_hw_interrupts.
>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Yongbok Kim <yongbok.kim@imgtec.com>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/mips/translate.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 559f8fe..891f14b 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -13403,9 +13403,11 @@ static void gen_pool32axf (CPUMIPSState *env, DisasContext *ctx, int rt, int rs)
>                  save_cpu_state(ctx, 1);
>                  gen_helper_ei(t0, cpu_env);
>                  gen_store_gpr(t0, rs);
> -                /* Stop translation as we may have switched the execution mode */
> -                ctx->bstate = BS_STOP;
>                  tcg_temp_free(t0);
> +                /* BS_STOP isn't good enough here;
> +                   reevaluate cpu_mips_hw_interrupts_enabled.  */

nit: technically we want to ensure mips_cpu_exec_interrupt is run (which
calls cpu_mips_hw_interrupts_enabled)

> +                gen_save_pc(ctx->pc + 4);
> +                ctx->bstate = BS_EXCP;
>              }
>              break;
>          default:

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

--
Alex Bennée
