Received: from eggs.gnu.org ([209.51.188.92]:43264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gn9zA-0003qd-TA
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:30:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gn9z9-0007Q9-Px
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:30:04 -0500
References: <20190123092538.8004-1-kbastian@mail.uni-paderborn.de>
	<20190123092538.8004-31-kbastian@mail.uni-paderborn.de>
From: Alistair <alistair23@gmail.com>
Message-ID: <14f6462f-ea46-7e1a-d03a-bed324f9d88b@gmail.com>
Date: Fri, 25 Jan 2019 14:29:30 -0800
MIME-Version: 1.0
In-Reply-To: <20190123092538.8004-31-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 30/35] target/riscv: Remove
 decode_RV32_64G()
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
> decodetree handles all instructions now so the fallback is not necessary
> anymore.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   target/riscv/translate.c | 23 +----------------------
>   1 file changed, 1 insertion(+), 22 deletions(-)
> 
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 0e37beb68e..b0251b3518 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -600,26 +600,6 @@ bool decode_insn16(DisasContext *ctx, uint16_t insn);
>   #include "decode_insn16.inc.c"
>   #include "insn_trans/trans_rvc.inc.c"
>   
> -static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
> -{
> -    uint32_t op;
> -
> -    /* We do not do misaligned address check here: the address should never be
> -     * misaligned at this point. Instructions that set PC must do the check,
> -     * since epc must be the address of the instruction that caused us to
> -     * perform the misaligned instruction fetch */
> -
> -    op = MASK_OP_MAJOR(ctx->opcode);
> -
> -    switch (op) {
> -    case OPC_RISC_SYSTEM:
> -        break;
> -    default:
> -        gen_exception_illegal(ctx);
> -        break;
> -    }
> -}
> -
>   static void decode_opc(DisasContext *ctx)
>   {
>       /* check for compressed insn */
> @@ -636,8 +616,7 @@ static void decode_opc(DisasContext *ctx)
>       } else {
>           ctx->pc_succ_insn = ctx->base.pc_next + 4;
>           if (!decode_insn32(ctx, ctx->opcode)) {
> -            /* fallback to old decoder */
> -            decode_RV32_64G(ctx->env, ctx);
> +            gen_exception_illegal(ctx);
>           }
>       }
>   }
> 
