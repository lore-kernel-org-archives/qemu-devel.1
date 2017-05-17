Received: from eggs.gnu.org ([2001:4830:134:3::10]:55144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAnOW-0006UO-Qj
	for qemu-devel@nongnu.org; Tue, 16 May 2017 21:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAnOS-0000Fm-RR
	for qemu-devel@nongnu.org; Tue, 16 May 2017 21:04:52 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAnOS-0000Fe-MW
	for qemu-devel@nongnu.org; Tue, 16 May 2017 21:04:48 -0400
Received: by mail-qt0-x244.google.com with SMTP id r58so23083698qtb.2
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 18:04:48 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170516224721.13832-1-aurelien@aurel32.net>
	<20170516224721.13832-4-aurelien@aurel32.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <dc3c40e9-c6d6-f00b-b41f-de644f879e5d@amsat.org>
Date: Tue, 16 May 2017 22:04:44 -0300
MIME-Version: 1.0
In-Reply-To: <20170516224721.13832-4-aurelien@aurel32.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/5] target/sh4: introduce DELAY_SLOT_MASK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org

On 05/16/2017 07:47 PM, Aurelien Jarno wrote:
> This will make easier the introduction of a new flag in the next
> patches.

This makes code cleaner / easier to read, no need further explanation ;)

>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/sh4/cpu.h       |  3 ++-
>  target/sh4/helper.c    |  4 ++--
>  target/sh4/translate.c | 17 ++++++++---------
>  3 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
> index 6c07c6b24b..7969c9af98 100644
> --- a/target/sh4/cpu.h
> +++ b/target/sh4/cpu.h
> @@ -91,6 +91,7 @@
>  #define FPSCR_RM_NEAREST       (0 << 0)
>  #define FPSCR_RM_ZERO          (1 << 0)
>
> +#define DELAY_SLOT_MASK        0x3
>  #define DELAY_SLOT             (1 << 0)
>  #define DELAY_SLOT_CONDITIONAL (1 << 1)
>
> @@ -380,7 +381,7 @@ static inline void cpu_get_tb_cpu_state(CPUSH4State *env, target_ulong *pc,
>  {
>      *pc = env->pc;
>      *cs_base = 0;
> -    *flags = (env->flags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL)) /* Bits 0-1 */
> +    *flags = (env->flags & DELAY_SLOT_MASK)                    /* Bits  0- 1 */
>              | (env->fpscr & (FPSCR_FR | FPSCR_SZ | FPSCR_PR))  /* Bits 19-21 */
>              | (env->sr & ((1u << SR_MD) | (1u << SR_RB)))      /* Bits 29-30 */
>              | (env->sr & (1u << SR_FD))                        /* Bit 15 */
> diff --git a/target/sh4/helper.c b/target/sh4/helper.c
> index 5296e7cf4e..d420931530 100644
> --- a/target/sh4/helper.c
> +++ b/target/sh4/helper.c
> @@ -172,11 +172,11 @@ void superh_cpu_do_interrupt(CPUState *cs)
>      env->sgr = env->gregs[15];
>      env->sr |= (1u << SR_BL) | (1u << SR_MD) | (1u << SR_RB);
>
> -    if (env->flags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL)) {
> +    if (env->flags & DELAY_SLOT_MASK) {
>          /* Branch instruction should be executed again before delay slot. */
>  	env->spc -= 2;
>  	/* Clear flags for exception/interrupt routine. */
> -        env->flags &= ~(DELAY_SLOT | DELAY_SLOT_CONDITIONAL);
> +        env->flags &= ~DELAY_SLOT_MASK;
>      }
>
>      if (do_exp) {
> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> index 0bc2f9ff19..aba316f593 100644
> --- a/target/sh4/translate.c
> +++ b/target/sh4/translate.c
> @@ -217,8 +217,7 @@ static inline void gen_save_cpu_state(DisasContext *ctx, bool save_pc)
>      if (ctx->delayed_pc != (uint32_t) -1) {
>          tcg_gen_movi_i32(cpu_delayed_pc, ctx->delayed_pc);
>      }
> -    if ((ctx->tbflags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL))
> -        != ctx->envflags) {
> +    if ((ctx->tbflags & DELAY_SLOT_MASK) != ctx->envflags) {
>          tcg_gen_movi_i32(cpu_flags, ctx->envflags);
>      }
>  }
> @@ -329,7 +328,7 @@ static inline void gen_store_fpr64 (TCGv_i64 t, int reg)
>  #define DREG(x) FREG(x) /* Assumes lsb of (x) is always 0 */
>
>  #define CHECK_NOT_DELAY_SLOT \
> -    if (ctx->envflags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL)) {     \
> +    if (ctx->envflags & DELAY_SLOT_MASK) {                           \
>          gen_save_cpu_state(ctx, true);                               \
>          gen_helper_raise_slot_illegal_instruction(cpu_env);          \
>          ctx->bstate = BS_EXCP;                                       \
> @@ -339,7 +338,7 @@ static inline void gen_store_fpr64 (TCGv_i64 t, int reg)
>  #define CHECK_PRIVILEGED                                             \
>      if (IS_USER(ctx)) {                                              \
>          gen_save_cpu_state(ctx, true);                               \
> -        if (ctx->envflags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL)) { \
> +        if (ctx->envflags & DELAY_SLOT_MASK) {                       \
>              gen_helper_raise_slot_illegal_instruction(cpu_env);      \
>          } else {                                                     \
>              gen_helper_raise_illegal_instruction(cpu_env);           \
> @@ -351,7 +350,7 @@ static inline void gen_store_fpr64 (TCGv_i64 t, int reg)
>  #define CHECK_FPU_ENABLED                                            \
>      if (ctx->tbflags & (1u << SR_FD)) {                              \
>          gen_save_cpu_state(ctx, true);                               \
> -        if (ctx->envflags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL)) { \
> +        if (ctx->envflags & DELAY_SLOT_MASK) {                       \
>              gen_helper_raise_slot_fpu_disable(cpu_env);              \
>          } else {                                                     \
>              gen_helper_raise_fpu_disable(cpu_env);                   \
> @@ -1784,7 +1783,7 @@ static void _decode_opc(DisasContext * ctx)
>      fflush(stderr);
>  #endif
>      gen_save_cpu_state(ctx, true);
> -    if (ctx->envflags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL)) {
> +    if (ctx->envflags & DELAY_SLOT_MASK) {
>          gen_helper_raise_slot_illegal_instruction(cpu_env);
>      } else {
>          gen_helper_raise_illegal_instruction(cpu_env);
> @@ -1798,9 +1797,9 @@ static void decode_opc(DisasContext * ctx)
>
>      _decode_opc(ctx);
>
> -    if (old_flags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL)) {
> +    if (old_flags & DELAY_SLOT_MASK) {
>          /* go out of the delay slot */
> -        ctx->envflags &= ~(DELAY_SLOT | DELAY_SLOT_CONDITIONAL);
> +        ctx->envflags &= ~DELAY_SLOT_MASK;
>          tcg_gen_movi_i32(cpu_flags, ctx->envflags);
>          ctx->bstate = BS_BRANCH;
>          if (old_flags & DELAY_SLOT_CONDITIONAL) {
> @@ -1824,7 +1823,7 @@ void gen_intermediate_code(CPUSH4State * env, struct TranslationBlock *tb)
>      pc_start = tb->pc;
>      ctx.pc = pc_start;
>      ctx.tbflags = (uint32_t)tb->flags;
> -    ctx.envflags = tb->flags & (DELAY_SLOT | DELAY_SLOT_CONDITIONAL);
> +    ctx.envflags = tb->flags & DELAY_SLOT_MASK;
>      ctx.bstate = BS_NONE;
>      ctx.memidx = (ctx.tbflags & (1u << SR_MD)) == 0 ? 1 : 0;
>      /* We don't know if the delayed pc came from a dynamic or static branch,
>
