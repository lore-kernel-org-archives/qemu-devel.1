Received: from eggs.gnu.org ([2001:4830:134:3::10]:41419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f1Hzh-00085j-42
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 16:48:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f1Hzf-0003XN-Ub
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 16:48:29 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:34580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1f1Hzf-0003X3-NQ
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 16:48:27 -0400
Received: by mail-ot0-x241.google.com with SMTP id m7-v6so4167022otd.1
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 13:48:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180328022233.13400-2-richard.henderson@linaro.org>
References: <20180328022233.13400-1-richard.henderson@linaro.org>
	<20180328022233.13400-2-richard.henderson@linaro.org>
From: Michael Clark <mjc@sifive.com>
Date: Wed, 28 Mar 2018 13:48:26 -0700
Message-ID: <CAHNT7NsGdfvr0JugRwx-tHi_iPOPH6GEAVPCAjqdUw7wvCGPJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/2] target/riscv: Split out mstatus_fs
 from tb_flags during translation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>, Palmer Dabbelt <palmer@sifive.com>

On Tue, Mar 27, 2018 at 7:22 PM, Richard Henderson <
richard.henderson@linaro.org> wrote:

> We will want to track changes to mstatus_fs through the TB.
> As there is nothing else in tb_flags at the moment, remove
> the variable from DisasContext.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>

Reviewed-by: Michael Clark <mjc@sifive.com>

---
>  target/riscv/cpu.h       |  6 +++---
>  target/riscv/translate.c | 10 +++++-----
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 41e06ac0f9..d201dd3e90 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -269,8 +269,8 @@ void QEMU_NORETURN do_raise_exception_err(CPURISCVState
> *env,
>  target_ulong cpu_riscv_get_fflags(CPURISCVState *env);
>  void cpu_riscv_set_fflags(CPURISCVState *env, target_ulong);
>
> -#define TB_FLAGS_MMU_MASK  3
> -#define TB_FLAGS_FP_ENABLE MSTATUS_FS
> +#define TB_FLAGS_MMU_MASK   3
> +#define TB_FLAGS_MSTATUS_FS MSTATUS_FS
>
>  static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong
> *pc,
>                                          target_ulong *cs_base, uint32_t
> *flags)
> @@ -278,7 +278,7 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState
> *env, target_ulong *pc,
>      *pc = env->pc;
>      *cs_base = 0;
>  #ifdef CONFIG_USER_ONLY
> -    *flags = TB_FLAGS_FP_ENABLE;
> +    *flags = TB_FLAGS_MSTATUS_FS;
>  #else
>      *flags = cpu_mmu_index(env, 0) | (env->mstatus & MSTATUS_FS);
>  #endif
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 808eab7f50..a30724aa90 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -43,7 +43,7 @@ typedef struct DisasContext {
>      target_ulong pc;
>      target_ulong next_pc;
>      uint32_t opcode;
> -    uint32_t flags;
> +    uint32_t mstatus_fs;
>      uint32_t mem_idx;
>      int singlestep_enabled;
>      int bstate;
> @@ -665,7 +665,7 @@ static void gen_fp_load(DisasContext *ctx, uint32_t
> opc, int rd,
>  {
>      TCGv t0;
>
> -    if (!(ctx->flags & TB_FLAGS_FP_ENABLE)) {
> +    if (ctx->mstatus_fs == 0) {
>          gen_exception_illegal(ctx);
>          return;
>      }
> @@ -695,7 +695,7 @@ static void gen_fp_store(DisasContext *ctx, uint32_t
> opc, int rs1,
>  {
>      TCGv t0;
>
> -    if (!(ctx->flags & TB_FLAGS_FP_ENABLE)) {
> +    if (ctx->mstatus_fs == 0) {
>          gen_exception_illegal(ctx);
>          return;
>      }
> @@ -986,7 +986,7 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t
> opc, int rd,
>  {
>      TCGv t0 = NULL;
>
> -    if (!(ctx->flags & TB_FLAGS_FP_ENABLE)) {
> +    if (ctx->mstatus_fs == 0) {
>          goto do_illegal;
>      }
>
> @@ -1862,8 +1862,8 @@ void gen_intermediate_code(CPUState *cs,
> TranslationBlock *tb)
>
>      ctx.tb = tb;
>      ctx.bstate = BS_NONE;
> -    ctx.flags = tb->flags;
>      ctx.mem_idx = tb->flags & TB_FLAGS_MMU_MASK;
> +    ctx.mstatus_fs = tb->flags & TB_FLAGS_MSTATUS_FS;
>      ctx.frm = -1;  /* unknown rounding mode */
>
>      num_insns = 0;
> --
> 2.14.3
>
>
