Received: from eggs.gnu.org ([209.51.188.92]:39534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gn9se-0007mt-BN
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:23:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gn9sd-0002AR-3Z
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:23:20 -0500
References: <20190123092538.8004-1-kbastian@mail.uni-paderborn.de>
	<20190123092538.8004-22-kbastian@mail.uni-paderborn.de>
From: Alistair <alistair23@gmail.com>
Message-ID: <e949c7da-043d-036c-ff44-44561c9680cb@gmail.com>
Date: Fri, 25 Jan 2019 14:23:14 -0800
MIME-Version: 1.0
In-Reply-To: <20190123092538.8004-22-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 21/35] target/riscv: Remove manual
 decoding from gen_branch()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, sagark@eecs.berkeley.edu, palmer@sifive.com
Cc: richard.henderson@linaro.org, peer.adelt@hni.uni-paderborn.de, qemu-riscv@nongnu.org, qemu-devel@nongnu.org

On 1/23/19 1:25 AM, Bastian Koppelmann wrote:
> We now utilizes argument-sets of decodetree such that no manual
> decoding is necessary.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   target/riscv/insn_trans/trans_rvi.inc.c | 46 +++++++++++++++++-------
>   target/riscv/translate.c                | 47 -------------------------
>   2 files changed, 33 insertions(+), 60 deletions(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
> index 3b3aff4803..0db1f79d20 100644
> --- a/target/riscv/insn_trans/trans_rvi.inc.c
> +++ b/target/riscv/insn_trans/trans_rvi.inc.c
> @@ -72,41 +72,61 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
>       return true;
>   }
>   
> -static bool trans_beq(DisasContext *ctx, arg_beq *a)
> +static bool gen_branch(DisasContext *ctx, arg_b *a, TCGCond cond)
>   {
> -    gen_branch(ctx->env, ctx, OPC_RISC_BEQ, a->rs1, a->rs2, a->imm);
> +    TCGLabel *l = gen_new_label();
> +    TCGv source1, source2;
> +    source1 = tcg_temp_new();
> +    source2 = tcg_temp_new();
> +    gen_get_gpr(source1, a->rs1);
> +    gen_get_gpr(source2, a->rs2);
> +
> +    tcg_gen_brcond_tl(cond, source1, source2, l);
> +    gen_goto_tb(ctx, 1, ctx->pc_succ_insn);
> +    gen_set_label(l); /* branch taken */
> +
> +    if (!riscv_has_ext(ctx->env, RVC) && ((ctx->base.pc_next + a->imm) & 0x3)) {
> +        /* misaligned */
> +        gen_exception_inst_addr_mis(ctx);
> +    } else {
> +        gen_goto_tb(ctx, 0, ctx->base.pc_next + a->imm);
> +    }
> +    ctx->base.is_jmp = DISAS_NORETURN;
> +
> +    tcg_temp_free(source1);
> +    tcg_temp_free(source2);
> +
>       return true;
>   }
>   
> +static bool trans_beq(DisasContext *ctx, arg_beq *a)
> +{
> +    return gen_branch(ctx, a, TCG_COND_EQ);
> +}
> +
>   static bool trans_bne(DisasContext *ctx, arg_bne *a)
>   {
> -    gen_branch(ctx->env, ctx, OPC_RISC_BNE, a->rs1, a->rs2, a->imm);
> -    return true;
> +    return gen_branch(ctx, a, TCG_COND_NE);
>   }
>   
>   static bool trans_blt(DisasContext *ctx, arg_blt *a)
>   {
> -    gen_branch(ctx->env, ctx, OPC_RISC_BLT, a->rs1, a->rs2, a->imm);
> -    return true;
> +    return gen_branch(ctx, a, TCG_COND_LT);
>   }
>   
>   static bool trans_bge(DisasContext *ctx, arg_bge *a)
>   {
> -    gen_branch(ctx->env, ctx, OPC_RISC_BGE, a->rs1, a->rs2, a->imm);
> -    return true;
> +    return gen_branch(ctx, a, TCG_COND_GE);
>   }
>   
>   static bool trans_bltu(DisasContext *ctx, arg_bltu *a)
>   {
> -    gen_branch(ctx->env, ctx, OPC_RISC_BLTU, a->rs1, a->rs2, a->imm);
> -    return true;
> +    return gen_branch(ctx, a, TCG_COND_LTU);
>   }
>   
>   static bool trans_bgeu(DisasContext *ctx, arg_bgeu *a)
>   {
> -
> -    gen_branch(ctx->env, ctx, OPC_RISC_BGEU, a->rs1, a->rs2, a->imm);
> -    return true;
> +    return gen_branch(ctx, a, TCG_COND_GEU);
>   }
>   
>   static bool trans_lb(DisasContext *ctx, arg_lb *a)
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 1f59b02c84..a0e96b94a9 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -489,53 +489,6 @@ static void gen_jal(CPURISCVState *env, DisasContext *ctx, int rd,
>       ctx->base.is_jmp = DISAS_NORETURN;
>   }
>   
> -static void gen_branch(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
> -                       int rs1, int rs2, target_long bimm)
> -{
> -    TCGLabel *l = gen_new_label();
> -    TCGv source1, source2;
> -    source1 = tcg_temp_new();
> -    source2 = tcg_temp_new();
> -    gen_get_gpr(source1, rs1);
> -    gen_get_gpr(source2, rs2);
> -
> -    switch (opc) {
> -    case OPC_RISC_BEQ:
> -        tcg_gen_brcond_tl(TCG_COND_EQ, source1, source2, l);
> -        break;
> -    case OPC_RISC_BNE:
> -        tcg_gen_brcond_tl(TCG_COND_NE, source1, source2, l);
> -        break;
> -    case OPC_RISC_BLT:
> -        tcg_gen_brcond_tl(TCG_COND_LT, source1, source2, l);
> -        break;
> -    case OPC_RISC_BGE:
> -        tcg_gen_brcond_tl(TCG_COND_GE, source1, source2, l);
> -        break;
> -    case OPC_RISC_BLTU:
> -        tcg_gen_brcond_tl(TCG_COND_LTU, source1, source2, l);
> -        break;
> -    case OPC_RISC_BGEU:
> -        tcg_gen_brcond_tl(TCG_COND_GEU, source1, source2, l);
> -        break;
> -    default:
> -        gen_exception_illegal(ctx);
> -        return;
> -    }
> -    tcg_temp_free(source1);
> -    tcg_temp_free(source2);
> -
> -    gen_goto_tb(ctx, 1, ctx->pc_succ_insn);
> -    gen_set_label(l); /* branch taken */
> -    if (!riscv_has_ext(env, RVC) && ((ctx->base.pc_next + bimm) & 0x3)) {
> -        /* misaligned */
> -        gen_exception_inst_addr_mis(ctx);
> -    } else {
> -        gen_goto_tb(ctx, 0, ctx->base.pc_next + bimm);
> -    }
> -    ctx->base.is_jmp = DISAS_NORETURN;
> -}
> -
>   static void gen_load(DisasContext *ctx, uint32_t opc, int rd, int rs1,
>           target_long imm)
>   {
> 
