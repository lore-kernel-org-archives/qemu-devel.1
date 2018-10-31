Received: from eggs.gnu.org ([2001:4830:134:3::10]:42703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gHxRx-0006tY-FG
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 16:50:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gHxRt-0003WF-07
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 16:50:49 -0400
References: <20181031132029.4887-1-kbastian@mail.uni-paderborn.de>
	<20181031132029.4887-21-kbastian@mail.uni-paderborn.de>
From: Alistair <alistair23@gmail.com>
Message-ID: <ad1403e7-2937-19d9-070a-ad5b3a835a01@gmail.com>
Date: Wed, 31 Oct 2018 13:50:41 -0700
MIME-Version: 1.0
In-Reply-To: <20181031132029.4887-21-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 20/35] target/riscv: Remove gen_jalr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, mjc@sifive.com, sagark@eecs.berkeley.edu, palmer@sifive.com, Alistair.Francis@wdc.com
Cc: qemu-riscv@nongnu.org, peer.adelt@hni.uni-paderborn.de, richard.henderson@linaro.org, qemu-devel@nongnu.org

On 10/31/18 6:20 AM, Bastian Koppelmann wrote:
> trans_jalr() is the only caller, so move the code into trans_jalr().
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   target/riscv/insn_trans/trans_rvi.inc.c | 28 +++++++++++++++++-
>   target/riscv/translate.c                | 38 -------------------------
>   2 files changed, 27 insertions(+), 39 deletions(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
> index 09e7a0052a..4d090d68e7 100644
> --- a/target/riscv/insn_trans/trans_rvi.inc.c
> +++ b/target/riscv/insn_trans/trans_rvi.inc.c
> @@ -42,7 +42,33 @@ static bool trans_jal(DisasContext *ctx, arg_jal *a)
>   
>   static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
>   {
> -    gen_jalr(ctx->env, ctx, OPC_RISC_JALR, a->rd, a->rs1, a->imm);
> +    /* no chaining with JALR */
> +    TCGLabel *misaligned = NULL;
> +    TCGv t0 = tcg_temp_new();
> +
> +
> +    gen_get_gpr(cpu_pc, a->rs1);
> +    tcg_gen_addi_tl(cpu_pc, cpu_pc, a->imm);
> +    tcg_gen_andi_tl(cpu_pc, cpu_pc, (target_ulong)-2);
> +
> +    if (!riscv_has_ext(ctx->env, RVC)) {
> +        misaligned = gen_new_label();
> +        tcg_gen_andi_tl(t0, cpu_pc, 0x2);
> +        tcg_gen_brcondi_tl(TCG_COND_NE, t0, 0x0, misaligned);
> +    }
> +
> +    if (a->rd != 0) {
> +        tcg_gen_movi_tl(cpu_gpr[a->rd], ctx->pc_succ_insn);
> +    }
> +    tcg_gen_lookup_and_goto_ptr();
> +
> +    if (misaligned) {
> +        gen_set_label(misaligned);
> +        gen_exception_inst_addr_mis(ctx);
> +    }
> +    ctx->base.is_jmp = DISAS_NORETURN;
> +
> +    tcg_temp_free(t0);
>       return true;
>   }
>   
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 41d66fae18..b78e423d94 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -489,44 +489,6 @@ static void gen_jal(CPURISCVState *env, DisasContext *ctx, int rd,
>       ctx->base.is_jmp = DISAS_NORETURN;
>   }
>   
> -static void gen_jalr(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
> -                     int rd, int rs1, target_long imm)
> -{
> -    /* no chaining with JALR */
> -    TCGLabel *misaligned = NULL;
> -    TCGv t0 = tcg_temp_new();
> -
> -    switch (opc) {
> -    case OPC_RISC_JALR:
> -        gen_get_gpr(cpu_pc, rs1);
> -        tcg_gen_addi_tl(cpu_pc, cpu_pc, imm);
> -        tcg_gen_andi_tl(cpu_pc, cpu_pc, (target_ulong)-2);
> -
> -        if (!riscv_has_ext(env, RVC)) {
> -            misaligned = gen_new_label();
> -            tcg_gen_andi_tl(t0, cpu_pc, 0x2);
> -            tcg_gen_brcondi_tl(TCG_COND_NE, t0, 0x0, misaligned);
> -        }
> -
> -        if (rd != 0) {
> -            tcg_gen_movi_tl(cpu_gpr[rd], ctx->pc_succ_insn);
> -        }
> -        tcg_gen_lookup_and_goto_ptr();
> -
> -        if (misaligned) {
> -            gen_set_label(misaligned);
> -            gen_exception_inst_addr_mis(ctx);
> -        }
> -        ctx->base.is_jmp = DISAS_NORETURN;
> -        break;
> -
> -    default:
> -        gen_exception_illegal(ctx);
> -        break;
> -    }
> -    tcg_temp_free(t0);
> -}
> -
>   static void gen_branch(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
>                          int rs1, int rs2, target_long bimm)
>   {
> 
