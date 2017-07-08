Received: from eggs.gnu.org ([2001:4830:134:3::10]:54396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dTsdK-0002rc-3t
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 12:31:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dTsdF-0008Dq-6j
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 12:31:02 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dTsdF-0008DK-1i
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 12:30:57 -0400
Received: by mail-qt0-f195.google.com with SMTP id w12so7843381qta.2
	for <qemu-devel@nongnu.org>; Sat, 08 Jul 2017 09:30:56 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170707022111.21836-1-rth@twiddle.net>
	<20170707022111.21836-4-rth@twiddle.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b46112ee-b82d-3e93-91aa-40d361a7dc3b@amsat.org>
Date: Sat, 8 Jul 2017 13:29:52 -0300
MIME-Version: 1.0
In-Reply-To: <20170707022111.21836-4-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 03/27] target/sh4: Introduce
 TB_FLAG_ENVFLAGS_MASK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: bruno@clisp.org, laurent@vivier.eu, aurelien@aurel32.net, glaubitz@debian.org

On 07/06/2017 11:20 PM, Richard Henderson wrote:
> We'll be putting more things into this bitmask soon.
> Let's have a name that covers all possible uses.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   target/sh4/cpu.h       | 4 +++-
>   target/sh4/translate.c | 4 ++--
>   2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
> index b15116e..240ed36 100644
> --- a/target/sh4/cpu.h
> +++ b/target/sh4/cpu.h
> @@ -96,6 +96,8 @@
>   #define DELAY_SLOT_CONDITIONAL (1 << 1)
>   #define DELAY_SLOT_RTE         (1 << 2)
>   
> +#define TB_FLAG_ENVFLAGS_MASK  DELAY_SLOT_MASK
> +
>   typedef struct tlb_t {
>       uint32_t vpn;		/* virtual page number */
>       uint32_t ppn;		/* physical page number */
> @@ -389,7 +391,7 @@ static inline void cpu_get_tb_cpu_state(CPUSH4State *env, target_ulong *pc,
>   {
>       *pc = env->pc;
>       *cs_base = 0;
> -    *flags = (env->flags & DELAY_SLOT_MASK)                    /* Bits  0- 2 */
> +    *flags = (env->flags & TB_FLAG_ENVFLAGS_MASK) /* Bits  0-2 */
>               | (env->fpscr & (FPSCR_FR | FPSCR_SZ | FPSCR_PR))  /* Bits 19-21 */
>               | (env->sr & ((1u << SR_MD) | (1u << SR_RB)))      /* Bits 29-30 */
>               | (env->sr & (1u << SR_FD))                        /* Bit 15 */
> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> index 663b5c0..cf53cd6 100644
> --- a/target/sh4/translate.c
> +++ b/target/sh4/translate.c
> @@ -225,7 +225,7 @@ static inline void gen_save_cpu_state(DisasContext *ctx, bool save_pc)
>       if (ctx->delayed_pc != (uint32_t) -1) {
>           tcg_gen_movi_i32(cpu_delayed_pc, ctx->delayed_pc);
>       }
> -    if ((ctx->tbflags & DELAY_SLOT_MASK) != ctx->envflags) {
> +    if ((ctx->tbflags & TB_FLAG_ENVFLAGS_MASK) != ctx->envflags) {
>           tcg_gen_movi_i32(cpu_flags, ctx->envflags);
>       }
>   }
> @@ -1837,7 +1837,7 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
>       pc_start = tb->pc;
>       ctx.pc = pc_start;
>       ctx.tbflags = (uint32_t)tb->flags;
> -    ctx.envflags = tb->flags & DELAY_SLOT_MASK;
> +    ctx.envflags = tb->flags & TB_FLAG_ENVFLAGS_MASK;
>       ctx.bstate = BS_NONE;
>       ctx.memidx = (ctx.tbflags & (1u << SR_MD)) == 0 ? 1 : 0;
>       /* We don't know if the delayed pc came from a dynamic or static branch,
> 
