Received: from eggs.gnu.org ([2001:4830:134:3::10]:57120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fNoEi-0001Ch-2u
	for qemu-devel@nongnu.org; Tue, 29 May 2018 19:41:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fNoEg-0003EZ-Vz
	for qemu-devel@nongnu.org; Tue, 29 May 2018 19:41:04 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:37228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fNoEg-0003Dg-OM
	for qemu-devel@nongnu.org; Tue, 29 May 2018 19:41:02 -0400
Received: by mail-lf0-x244.google.com with SMTP id r2-v6so1372901lff.4
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 16:41:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1527034517-7851-12-git-send-email-mjc@sifive.com>
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
	<1527034517-7851-12-git-send-email-mjc@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 29 May 2018 16:40:30 -0700
Message-ID: <CAKmqyKODtmmgnL0UrejWPFU7onvr-YU3mGagJhZfX=OMK4VwuA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 11/30] RISC-V: Split out mstatus_fs from
 tb_flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Richard Henderson <richard.henderson@linaro.org>, Alistair Francis <Alistair.Francis@wdc.com>, patches@groups.riscv.org

On Tue, May 22, 2018 at 5:14 PM, Michael Clark <mjc@sifive.com> wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> Reviewed-by: Michael Clark <mjc@sifive.com>

Shouldn't this also have Richard's SOB line?

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair


> ---
>  target/riscv/cpu.h       |  6 +++---
>  target/riscv/translate.c | 10 +++++-----
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 3a3d91447736..242a8fcbe180 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -276,8 +276,8 @@ void QEMU_NORETURN do_raise_exception_err(CPURISCVState *env,
>  target_ulong cpu_riscv_get_fflags(CPURISCVState *env);
>  void cpu_riscv_set_fflags(CPURISCVState *env, target_ulong);
>
> -#define TB_FLAGS_MMU_MASK  3
> -#define TB_FLAGS_FP_ENABLE MSTATUS_FS
> +#define TB_FLAGS_MMU_MASK   3
> +#define TB_FLAGS_MSTATUS_FS MSTATUS_FS
>
>  static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
>                                          target_ulong *cs_base, uint32_t *flags)
> @@ -285,7 +285,7 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
>      *pc = env->pc;
>      *cs_base = 0;
>  #ifdef CONFIG_USER_ONLY
> -    *flags = TB_FLAGS_FP_ENABLE;
> +    *flags = TB_FLAGS_MSTATUS_FS;
>  #else
>      *flags = cpu_mmu_index(env, 0) | (env->mstatus & MSTATUS_FS);
>  #endif
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index ee2bbc55b051..466b9551cbd9 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -44,7 +44,7 @@ typedef struct DisasContext {
>      /* pc_succ_insn points to the instruction following base.pc_next */
>      target_ulong pc_succ_insn;
>      uint32_t opcode;
> -    uint32_t flags;
> +    uint32_t mstatus_fs;
>      uint32_t mem_idx;
>      /* Remember the rounding mode encoded in the previous fp instruction,
>         which we have already installed into env->fp_status.  Or -1 for
> @@ -656,7 +656,7 @@ static void gen_fp_load(DisasContext *ctx, uint32_t opc, int rd,
>  {
>      TCGv t0;
>
> -    if (!(ctx->flags & TB_FLAGS_FP_ENABLE)) {
> +    if (ctx->mstatus_fs == 0) {
>          gen_exception_illegal(ctx);
>          return;
>      }
> @@ -686,7 +686,7 @@ static void gen_fp_store(DisasContext *ctx, uint32_t opc, int rs1,
>  {
>      TCGv t0;
>
> -    if (!(ctx->flags & TB_FLAGS_FP_ENABLE)) {
> +    if (ctx->mstatus_fs == 0) {
>          gen_exception_illegal(ctx);
>          return;
>      }
> @@ -945,7 +945,7 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
>  {
>      TCGv t0 = NULL;
>
> -    if (!(ctx->flags & TB_FLAGS_FP_ENABLE)) {
> +    if (ctx->mstatus_fs == 0) {
>          goto do_illegal;
>      }
>
> @@ -1810,8 +1810,8 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>      DisasContext *ctx = container_of(dcbase, DisasContext, base);
>
>      ctx->pc_succ_insn = ctx->base.pc_first;
> -    ctx->flags = ctx->base.tb->flags;
>      ctx->mem_idx = ctx->base.tb->flags & TB_FLAGS_MMU_MASK;
> +    ctx->mstatus_fs = ctx->base.tb->flags & TB_FLAGS_MSTATUS_FS;
>      ctx->frm = -1;  /* unknown rounding mode */
>  }
>
> --
> 2.7.0
>
>
