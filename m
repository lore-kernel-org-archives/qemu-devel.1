Received: from eggs.gnu.org ([2001:4830:134:3::10]:44262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gFmMG-0001PK-CD
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 16:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gFmBa-00053c-8F
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 16:24:57 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:42689)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gFmBZ-00052j-PZ
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 16:24:54 -0400
Received: by mail-pl1-x643.google.com with SMTP id t6-v6so4355435plo.9
	for <qemu-devel@nongnu.org>; Thu, 25 Oct 2018 13:24:53 -0700 (PDT)
Date: Thu, 25 Oct 2018 13:24:50 -0700 (PDT)
In-Reply-To: <20181020071451.27808-4-kbastian@mail.uni-paderborn.de>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-6cc0799c-e64e-4f81-9c34-aeef61dd695b@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 03/29] target/riscv: Convert RVXI branch
 insns to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Michael Clark <mjc@sifive.com>, sagark@eecs.berkeley.edu, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, peer.adelt@hni.uni-paderborn.de, Alistair Francis <Alistair.Francis@wdc.com>, richard.henderson@linaro.org, qemu-devel@nongnu.org

On Sat, 20 Oct 2018 00:14:25 PDT (-0700), Bastian Koppelmann wrote:
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
> ---
> v1 -> v2:
>     - use ctx->env instead of current_cpu->env_ptr
>
>  target/riscv/insn32.decode              | 19 ++++++++++
>  target/riscv/insn_trans/trans_rvi.inc.c | 49 +++++++++++++++++++++++++
>  target/riscv/translate.c                | 19 +---------
>  3 files changed, 69 insertions(+), 18 deletions(-)
>
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 44d4e922b6..b49913416d 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -17,14 +17,33 @@
>  # this program.  If not, see <http://www.gnu.org/licenses/>.
>
>  # Fields:
> +%rs2       20:5
> +%rs1       15:5
>  %rd        7:5
>
>  # immediates:
> +%imm_i    20:s12
> +%imm_b    31:s1 7:1 25:6 8:4     !function=ex_shift_1
> +%imm_j    31:s1 12:8 20:1 21:10  !function=ex_shift_1
>  %imm_u    12:s20                 !function=ex_shift_12
>
> +# Argument sets:
> +&branch    imm rs2 rs1
> +
>  # Formats 32:
> +@i       ............    ..... ... ..... .......         imm=%imm_i     %rs1 %rd
> +@b       .......   ..... ..... ... ..... ....... &branch imm=%imm_b %rs2 %rs1
>  @u       ....................      ..... .......         imm=%imm_u          %rd
> +@j       ....................      ..... .......         imm=%imm_j          %rd
>
>  # *** RV32I Base Instruction Set ***
>  lui      ....................       ..... 0110111 @u
>  auipc    ....................       ..... 0010111 @u
> +jal      ....................       ..... 1101111 @j
> +jalr     ............     ..... 000 ..... 1100111 @i
> +beq      ....... .....    ..... 000 ..... 1100011 @b
> +bne      ....... .....    ..... 001 ..... 1100011 @b
> +blt      ....... .....    ..... 100 ..... 1100011 @b
> +bge      ....... .....    ..... 101 ..... 1100011 @b
> +bltu     ....... .....    ..... 110 ..... 1100011 @b
> +bgeu     ....... .....    ..... 111 ..... 1100011 @b
> diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
> index aee0d1637d..3935a80ba5 100644
> --- a/target/riscv/insn_trans/trans_rvi.inc.c
> +++ b/target/riscv/insn_trans/trans_rvi.inc.c
> @@ -33,3 +33,52 @@ static bool trans_auipc(DisasContext *ctx, arg_auipc *a, uint32_t insn)
>      }
>      return true;
>  }
> +
> +static bool trans_jal(DisasContext *ctx, arg_jal *a, uint32_t insn)
> +{
> +    gen_jal(ctx->env, ctx, a->rd, a->imm);
> +    return true;
> +}
> +
> +static bool trans_jalr(DisasContext *ctx, arg_jalr *a, uint32_t insn)
> +{
> +    gen_jalr(ctx->env, ctx, OPC_RISC_JALR, a->rd, a->rs1, a->imm);
> +    return true;
> +}
> +
> +static bool trans_beq(DisasContext *ctx, arg_beq *a, uint32_t insn)
> +{
> +    gen_branch(ctx->env, ctx, OPC_RISC_BEQ, a->rs1, a->rs2, a->imm);
> +    return true;
> +}
> +
> +static bool trans_bne(DisasContext *ctx, arg_bne *a, uint32_t insn)
> +{
> +    gen_branch(ctx->env, ctx, OPC_RISC_BNE, a->rs1, a->rs2, a->imm);
> +    return true;
> +}
> +
> +static bool trans_blt(DisasContext *ctx, arg_blt *a, uint32_t insn)
> +{
> +    gen_branch(ctx->env, ctx, OPC_RISC_BLT, a->rs1, a->rs2, a->imm);
> +    return true;
> +}
> +
> +static bool trans_bge(DisasContext *ctx, arg_bge *a, uint32_t insn)
> +{
> +    gen_branch(ctx->env, ctx, OPC_RISC_BGE, a->rs1, a->rs2, a->imm);
> +    return true;
> +}
> +
> +static bool trans_bltu(DisasContext *ctx, arg_bltu *a, uint32_t insn)
> +{
> +    gen_branch(ctx->env, ctx, OPC_RISC_BLTU, a->rs1, a->rs2, a->imm);
> +    return true;
> +}
> +
> +static bool trans_bgeu(DisasContext *ctx, arg_bgeu *a, uint32_t insn)
> +{
> +
> +    gen_branch(ctx->env, ctx, OPC_RISC_BGEU, a->rs1, a->rs2, a->imm);
> +    return true;
> +}
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 65a323a201..9b6848e666 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1672,6 +1672,7 @@ static void decode_RV32_64C(CPURISCVState *env, DisasContext *ctx)
>      {                                         \
>          return imm << amount;                 \
>      }
> +EX_SH(1)
>  EX_SH(12)
>
>  bool decode_insn32(DisasContext *ctx, uint32_t insn);
> @@ -1700,24 +1701,6 @@ static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
>      imm = GET_IMM(ctx->opcode);
>
>      switch (op) {
> -    case OPC_RISC_AUIPC:
> -        if (rd == 0) {
> -            break; /* NOP */
> -        }
> -        tcg_gen_movi_tl(cpu_gpr[rd], (sextract64(ctx->opcode, 12, 20) << 12) +
> -               ctx->base.pc_next);
> -        break;

This should go with the previous patch.  I can move it if you want me to start 
merging this patch set.

> -    case OPC_RISC_JAL:
> -        imm = GET_JAL_IMM(ctx->opcode);
> -        gen_jal(env, ctx, rd, imm);
> -        break;
> -    case OPC_RISC_JALR:
> -        gen_jalr(env, ctx, MASK_OP_JALR(ctx->opcode), rd, rs1, imm);
> -        break;
> -    case OPC_RISC_BRANCH:
> -        gen_branch(env, ctx, MASK_OP_BRANCH(ctx->opcode), rs1, rs2,
> -                   GET_B_IMM(ctx->opcode));
> -        break;
>      case OPC_RISC_LOAD:
>          gen_load(ctx, MASK_OP_LOAD(ctx->opcode), rd, rs1, imm);
>          break;

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
