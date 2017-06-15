Received: from eggs.gnu.org ([2001:4830:134:3::10]:55469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dLcAq-0001qV-9S
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 17:19:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dLcAp-0006Xi-5M
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 17:19:28 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:57524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dLcAo-0006X5-UP
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 17:19:27 -0400
Date: Thu, 15 Jun 2017 23:19:20 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170615211920.c7y2xaixy6tm2fan@aurel32.net>
References: <20170614194821.8754-1-rth@twiddle.net>
	<20170614194821.8754-4-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170614194821.8754-4-rth@twiddle.net>
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
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, cota@braap.org, pbonzini@redhat.com, Yongbok Kim <yongbok.kim@imgtec.com>

On 2017-06-14 12:48, Richard Henderson wrote:
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
> +                gen_save_pc(ctx->pc + 4);
> +                ctx->bstate = BS_EXCP;
>              }
>              break;
>          default:

While the above looks correct, it's not complete. It only fixes the
microMIPS EI instruction. The MIPS one also has to be fixed.

For what I understood, anything that can change the result of
cpu_mips_hw_interrupts_enabled has to stop the translation. In that case
I checked that ERET/ERETNC and MTC0/DMTC0 to the Status register are
already correct, that said it might be a good idea to update the
comments to mention it.

I can work on a better patch, but I doubt I'll have time before the
week-end.

Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
