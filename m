Received: from eggs.gnu.org ([2001:4830:134:3::10]:36714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5Wz7-0000zw-Pt
	for qemu-devel@nongnu.org; Tue, 02 May 2017 08:32:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5Wz4-00035l-Kj
	for qemu-devel@nongnu.org; Tue, 02 May 2017 08:32:53 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33555)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5Wz4-00035I-Fh
	for qemu-devel@nongnu.org; Tue, 02 May 2017 08:32:50 -0400
Received: by mail-qt0-x243.google.com with SMTP id c45so20003926qtb.0
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 05:32:50 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170501221046.9369-1-aurelien@aurel32.net>
	<20170501221046.9369-3-aurelien@aurel32.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cd681ab5-8fde-b18d-beb8-c23993081b90@amsat.org>
Date: Tue, 2 May 2017 09:32:47 -0300
MIME-Version: 1.0
In-Reply-To: <20170501221046.9369-3-aurelien@aurel32.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 02/14] target/sh4: get rid of
 DELAY_SLOT_CLEARME
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org

On 05/01/2017 07:10 PM, Aurelien Jarno wrote:
> Now that ctx->flags has been split, it becomes clear that
> DELAY_SLOT_CLEARME has not impact on the code generation: in both case
> ctx->envflags is cleared, either by clearing all the flags, or by
> setting it to 0. This is left-over from pre-TCG era.
>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/sh4/cpu.h       |  3 +--
>  target/sh4/helper.c    |  2 --
>  target/sh4/translate.c | 17 +++++------------
>  3 files changed, 6 insertions(+), 16 deletions(-)
>
> diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
> index cad8989f7e..9445cc779f 100644
> --- a/target/sh4/cpu.h
> +++ b/target/sh4/cpu.h
> @@ -93,7 +93,6 @@
>  #define DELAY_SLOT             (1 << 0)
>  #define DELAY_SLOT_CONDITIONAL (1 << 1)
>  #define DELAY_SLOT_TRUE        (1 << 2)
> -#define DELAY_SLOT_CLEARME     (1 << 3)
>  /* The dynamic value of the DELAY_SLOT_TRUE flag determines whether the jump
>   * after the delay slot should be taken or not. It is calculated from SR_T.
>   *
> @@ -384,7 +383,7 @@ static inline void cpu_get_tb_cpu_state(CPUSH4State *env, target_ulong *pc,
>      *pc = env->pc;
>      *cs_base = 0;
>      *flags = (env->flags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL
> -                    | DELAY_SLOT_TRUE | DELAY_SLOT_CLEARME))   /* Bits  0- 3 */
> +                    | DELAY_SLOT_TRUE))                        /* Bits  0- 2 */
>              | (env->fpscr & (FPSCR_FR | FPSCR_SZ | FPSCR_PR))  /* Bits 19-21 */
>              | (env->sr & ((1u << SR_MD) | (1u << SR_RB)))      /* Bits 29-30 */
>              | (env->sr & (1u << SR_FD))                        /* Bit 15 */
> diff --git a/target/sh4/helper.c b/target/sh4/helper.c
> index 036c5ca56c..71bb49a670 100644
> --- a/target/sh4/helper.c
> +++ b/target/sh4/helper.c
> @@ -170,8 +170,6 @@ void superh_cpu_do_interrupt(CPUState *cs)
>  	/* Clear flags for exception/interrupt routine. */
>  	env->flags &= ~(DELAY_SLOT | DELAY_SLOT_CONDITIONAL | DELAY_SLOT_TRUE);
>      }
> -    if (env->flags & DELAY_SLOT_CLEARME)
> -        env->flags = 0;
>
>      if (do_exp) {
>          env->expevt = cs->exception_index;
> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> index 0b16ff33ea..d4cdf746dc 100644
> --- a/target/sh4/translate.c
> +++ b/target/sh4/translate.c
> @@ -1804,15 +1804,9 @@ static void decode_opc(DisasContext * ctx)
>      _decode_opc(ctx);
>
>      if (old_flags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL)) {
> -        if (ctx->envflags & DELAY_SLOT_CLEARME) {
> -            gen_store_flags(0);
> -        } else {
> -	    /* go out of the delay slot */
> -            uint32_t new_flags = ctx->envflags;
> -	    new_flags &= ~(DELAY_SLOT | DELAY_SLOT_CONDITIONAL);
> -	    gen_store_flags(new_flags);
> -        }
> -        ctx->envflags = 0;
> +        /* go out of the delay slot */
> +        ctx->envflags &= ~(DELAY_SLOT | DELAY_SLOT_CONDITIONAL);
> +        gen_store_flags(ctx->envflags);
>          ctx->bstate = BS_BRANCH;
>          if (old_flags & DELAY_SLOT_CONDITIONAL) {
>  	    gen_delayed_conditional_jump(ctx);
> @@ -1840,8 +1834,7 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
>      pc_start = tb->pc;
>      ctx.pc = pc_start;
>      ctx.tbflags = (uint32_t)tb->flags;
> -    ctx.envflags = tb->flags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL |
> -                                DELAY_SLOT_CLEARME);
> +    ctx.envflags = tb->flags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL);
>      ctx.bstate = BS_NONE;
>      ctx.memidx = (ctx.tbflags & (1u << SR_MD)) == 0 ? 1 : 0;
>      /* We don't know if the delayed pc came from a dynamic or static branch,
> @@ -1908,7 +1901,7 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
>              /* fall through */
>          case BS_NONE:
>              if (ctx.envflags) {
> -                gen_store_flags(ctx.envflags | DELAY_SLOT_CLEARME);
> +                gen_store_flags(ctx.envflags);
>  	    }
>              gen_goto_tb(&ctx, 0, ctx.pc);
>              break;
>
