Received: from eggs.gnu.org ([2001:4830:134:3::10]:36855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gHx80-0002fx-MA
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 16:30:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gHx7v-00029x-3t
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 16:30:12 -0400
References: <20181031132029.4887-1-kbastian@mail.uni-paderborn.de>
	<20181031132029.4887-8-kbastian@mail.uni-paderborn.de>
From: Alistair <alistair23@gmail.com>
Message-ID: <94f933ad-2cba-c18b-bac1-15349df446cd@gmail.com>
Date: Wed, 31 Oct 2018 13:30:03 -0700
MIME-Version: 1.0
In-Reply-To: <20181031132029.4887-8-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 07/35] target/riscv: Convert RVXI fence
 insns to decodetree
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
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> v2 -> v3:
>      - removed %pred/%succ
>      - dropped insn argument of trans_foo functions
> 
>   target/riscv/insn32.decode              |  2 ++
>   target/riscv/insn_trans/trans_rvi.inc.c | 21 +++++++++++++++++++++
>   target/riscv/translate.c                | 14 --------------
>   3 files changed, 23 insertions(+), 14 deletions(-)
> 
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 4fd88f48d2..6d750b4c5a 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -82,3 +82,5 @@ srl      0000000 .....    ..... 101 ..... 0110011 @r
>   sra      0100000 .....    ..... 101 ..... 0110011 @r
>   or       0000000 .....    ..... 110 ..... 0110011 @r
>   and      0000000 .....    ..... 111 ..... 0110011 @r
> +fence    ---- pred:4 succ:4 ----- 000 ----- 0001111
> +fence_i  ---- ----   ----   ----- 001 ----- 0001111
> diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
> index 01f751650a..a149e913b1 100644
> --- a/target/riscv/insn_trans/trans_rvi.inc.c
> +++ b/target/riscv/insn_trans/trans_rvi.inc.c
> @@ -318,3 +318,24 @@ static bool trans_sraw(DisasContext *ctx, arg_sraw *a)
>       return true;
>   }
>   #endif
> +
> +static bool trans_fence(DisasContext *ctx, arg_fence *a)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    /* FENCE is a full memory barrier. */
> +    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
> +#endif
> +    return true;
> +}
> +
> +static bool trans_fence_i(DisasContext *ctx, arg_fence_i *a)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    /* FENCE_I is a no-op in QEMU,
> +     * however we need to end the translation block */
> +    tcg_gen_movi_tl(cpu_pc, ctx->pc_succ_insn);
> +    tcg_gen_exit_tb(NULL, 0);
> +    ctx->base.is_jmp = DISAS_NORETURN;
> +#endif
> +    return true;
> +}
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 855c241e97..80f18fb6aa 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1740,20 +1740,6 @@ static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
>           gen_fp_arith(ctx, MASK_OP_FP_ARITH(ctx->opcode), rd, rs1, rs2,
>                        GET_RM(ctx->opcode));
>           break;
> -    case OPC_RISC_FENCE:
> -#ifndef CONFIG_USER_ONLY
> -        if (ctx->opcode & 0x1000) {
> -            /* FENCE_I is a no-op in QEMU,
> -             * however we need to end the translation block */
> -            tcg_gen_movi_tl(cpu_pc, ctx->pc_succ_insn);
> -            tcg_gen_exit_tb(NULL, 0);
> -            ctx->base.is_jmp = DISAS_NORETURN;
> -        } else {
> -            /* FENCE is a full memory barrier. */
> -            tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
> -        }
> -#endif
> -        break;
>       case OPC_RISC_SYSTEM:
>           gen_system(env, ctx, MASK_OP_SYSTEM(ctx->opcode), rd, rs1,
>                      (ctx->opcode & 0xFFF00000) >> 20);
> 
