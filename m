Received: from eggs.gnu.org ([2001:4830:134:3::10]:56768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dT8Ws-00029S-Mb
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 11:17:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dT8Wr-0001Vp-Jf
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 11:17:18 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:48348)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dT8Wr-0001VB-CA
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 11:17:17 -0400
Date: Thu, 6 Jul 2017 17:17:14 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170706151714.oelapjmihuuqabhz@aurel32.net>
References: <20170706002401.10507-1-rth@twiddle.net>
	<20170706002401.10507-3-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170706002401.10507-3-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 02/11] target/sh4: Consolidate end-of-TB
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, bruno@clisp.org

On 2017-07-05 14:23, Richard Henderson wrote:
> We can fold 3 different tests within the decode loop
> into a more accurate computation of max_insns to start.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/sh4/translate.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> index 6b247fa..e1661e9 100644
> --- a/target/sh4/translate.c
> +++ b/target/sh4/translate.c
> @@ -1856,7 +1856,6 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
>      ctx.features = env->features;
>      ctx.has_movcal = (ctx.tbflags & TB_FLAG_PENDING_MOVCA);
>  
> -    num_insns = 0;
>      max_insns = tb->cflags & CF_COUNT_MASK;
>      if (max_insns == 0) {
>          max_insns = CF_COUNT_MASK;
> @@ -1864,9 +1863,23 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
>      if (max_insns > TCG_MAX_INSNS) {
>          max_insns = TCG_MAX_INSNS;
>      }
> +    /* Since the ISA is fixed-width, we can bound by the number
> +       of instructions remaining on the page.  */
> +    num_insns = (TARGET_PAGE_SIZE - (ctx.pc & (TARGET_PAGE_SIZE - 1))) / 2;

This could be written as num_insn = -(ctx.pc | TARGET_PAGE_SIZE) / 2;

> +    if (max_insns > num_insns) {
> +        max_insns = num_insns;
> +    }

You are following the existing pattern, so I can really blame you, but
maybe it's the moment to change the existing code into something like:

    max_insns = MIN(max_insn, ...)

> +    /* Single stepping means just that.  */
> +    if (ctx.singlestep_enabled || singlestep) {
> +        max_insns = 1;
> +    }
>  
>      gen_tb_start(tb);
> -    while (ctx.bstate == BS_NONE && !tcg_op_buf_full()) {
> +    num_insns = 0;
> +
> +    while (ctx.bstate == BS_NONE
> +           && num_insns < max_insns
> +           && !tcg_op_buf_full()) {
>          tcg_gen_insn_start(ctx.pc, ctx.envflags);
>          num_insns++;
>  
> @@ -1890,18 +1903,10 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
>          ctx.opcode = cpu_lduw_code(env, ctx.pc);
>  	decode_opc(&ctx);
>  	ctx.pc += 2;
> -	if ((ctx.pc & (TARGET_PAGE_SIZE - 1)) == 0)
> -	    break;
> -        if (cs->singlestep_enabled) {
> -	    break;
> -        }
> -        if (num_insns >= max_insns)
> -            break;
> -        if (singlestep)
> -            break;
>      }
> -    if (tb->cflags & CF_LAST_IO)
> +    if (tb->cflags & CF_LAST_IO) {
>          gen_io_end();
> +    }
>      if (cs->singlestep_enabled) {
>          gen_save_cpu_state(&ctx, true);
>          gen_helper_debug(cpu_env);

Besides the minor nitpicks above:

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
