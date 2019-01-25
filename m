Received: from eggs.gnu.org ([209.51.188.92]:39842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gn9tG-0008Ed-HR
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:23:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gn9tD-0002Wl-Rq
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:23:56 -0500
References: <20190123092538.8004-1-kbastian@mail.uni-paderborn.de>
	<20190123092538.8004-23-kbastian@mail.uni-paderborn.de>
From: Alistair <alistair23@gmail.com>
Message-ID: <33d744d4-ae25-4f9c-f6d4-71352667191b@gmail.com>
Date: Fri, 25 Jan 2019 14:23:50 -0800
MIME-Version: 1.0
In-Reply-To: <20190123092538.8004-23-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 22/35] target/riscv: Remove manual
 decoding from gen_load()
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
> With decodetree we don't need to convert RISC-V opcodes into to MemOps
> as the old gen_load() did.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   target/riscv/insn_trans/trans_rvi.inc.c | 35 +++++++++++++++----------
>   target/riscv/translate.c                |  6 +++--
>   2 files changed, 25 insertions(+), 16 deletions(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
> index 0db1f79d20..1ad00bd776 100644
> --- a/target/riscv/insn_trans/trans_rvi.inc.c
> +++ b/target/riscv/insn_trans/trans_rvi.inc.c
> @@ -129,34 +129,43 @@ static bool trans_bgeu(DisasContext *ctx, arg_bgeu *a)
>       return gen_branch(ctx, a, TCG_COND_GEU);
>   }
>   
> -static bool trans_lb(DisasContext *ctx, arg_lb *a)
> +static bool gen_load(DisasContext *ctx, arg_lb *a, TCGMemOp memop)
>   {
> -    gen_load(ctx, OPC_RISC_LB, a->rd, a->rs1, a->imm);
> +    TCGv t0 = tcg_temp_new();
> +    TCGv t1 = tcg_temp_new();
> +    gen_get_gpr(t0, a->rs1);
> +    tcg_gen_addi_tl(t0, t0, a->imm);
> +
> +    tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, memop);
> +    gen_set_gpr(a->rd, t1);
> +    tcg_temp_free(t0);
> +    tcg_temp_free(t1);
>       return true;
>   }
>   
> +static bool trans_lb(DisasContext *ctx, arg_lb *a)
> +{
> +    return gen_load(ctx, a, MO_SB);
> +}
> +
>   static bool trans_lh(DisasContext *ctx, arg_lh *a)
>   {
> -    gen_load(ctx, OPC_RISC_LH, a->rd, a->rs1, a->imm);
> -    return true;
> +    return gen_load(ctx, a, MO_TESW);
>   }
>   
>   static bool trans_lw(DisasContext *ctx, arg_lw *a)
>   {
> -    gen_load(ctx, OPC_RISC_LW, a->rd, a->rs1, a->imm);
> -    return true;
> +    return gen_load(ctx, a, MO_TESL);
>   }
>   
>   static bool trans_lbu(DisasContext *ctx, arg_lbu *a)
>   {
> -    gen_load(ctx, OPC_RISC_LBU, a->rd, a->rs1, a->imm);
> -    return true;
> +    return gen_load(ctx, a, MO_UB);
>   }
>   
>   static bool trans_lhu(DisasContext *ctx, arg_lhu *a)
>   {
> -    gen_load(ctx, OPC_RISC_LHU, a->rd, a->rs1, a->imm);
> -    return true;
> +    return gen_load(ctx, a, MO_TEUW);
>   }
>   
>   static bool trans_sb(DisasContext *ctx, arg_sb *a)
> @@ -180,14 +189,12 @@ static bool trans_sw(DisasContext *ctx, arg_sw *a)
>   #ifdef TARGET_RISCV64
>   static bool trans_lwu(DisasContext *ctx, arg_lwu *a)
>   {
> -    gen_load(ctx, OPC_RISC_LWU, a->rd, a->rs1, a->imm);
> -    return true;
> +    return gen_load(ctx, a, MO_TEUL);
>   }
>   
>   static bool trans_ld(DisasContext *ctx, arg_ld *a)
>   {
> -    gen_load(ctx, OPC_RISC_LD, a->rd, a->rs1, a->imm);
> -    return true;
> +    return gen_load(ctx, a, MO_TEQ);
>   }
>   
>   static bool trans_sd(DisasContext *ctx, arg_sd *a)
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index a0e96b94a9..d0fefa8fb9 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -489,7 +489,8 @@ static void gen_jal(CPURISCVState *env, DisasContext *ctx, int rd,
>       ctx->base.is_jmp = DISAS_NORETURN;
>   }
>   
> -static void gen_load(DisasContext *ctx, uint32_t opc, int rd, int rs1,
> +#ifdef TARGET_RISCV64
> +static void gen_load_c(DisasContext *ctx, uint32_t opc, int rd, int rs1,
>           target_long imm)
>   {
>       TCGv t0 = tcg_temp_new();
> @@ -508,6 +509,7 @@ static void gen_load(DisasContext *ctx, uint32_t opc, int rd, int rs1,
>       tcg_temp_free(t0);
>       tcg_temp_free(t1);
>   }
> +#endif
>   
>   static void gen_store(DisasContext *ctx, uint32_t opc, int rs1, int rs2,
>           target_long imm)
> @@ -640,7 +642,7 @@ static void decode_RV32_64C0(DisasContext *ctx)
>       case 3:
>   #if defined(TARGET_RISCV64)
>           /* C.LD(RV64/128) -> ld rd', offset[7:3](rs1')*/
> -        gen_load(ctx, OPC_RISC_LD, rd_rs2, rs1s,
> +        gen_load_c(ctx, OPC_RISC_LD, rd_rs2, rs1s,
>                    GET_C_LD_IMM(ctx->opcode));
>   #else
>           /* C.FLW (RV32) -> flw rd', offset[6:2](rs1')*/
> 
