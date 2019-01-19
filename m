Received: from eggs.gnu.org ([209.51.188.92]:36293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkyBK-000333-J0
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 16:29:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkyBI-0007iE-GI
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 16:29:34 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:42719)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkyBG-0007eB-Gp
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 16:29:31 -0500
Received: by mail-pf1-x42f.google.com with SMTP id 64so8296519pfr.9
	for <qemu-devel@nongnu.org>; Sat, 19 Jan 2019 13:29:28 -0800 (PST)
References: <20190118131456.32451-1-kbastian@mail.uni-paderborn.de>
	<20190118131456.32451-8-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <74f85a7c-62d1-ca61-9820-7c4deeca4a05@linaro.org>
Date: Sun, 20 Jan 2019 08:29:21 +1100
MIME-Version: 1.0
In-Reply-To: <20190118131456.32451-8-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 07/35] target/riscv: Convert RVXI fence
 insns to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, sagark@eecs.berkeley.edu, palmer@sifive.com, Alistair.Francis@wdc.com
Cc: qemu-riscv@nongnu.org, peer.adelt@hni.uni-paderborn.de, qemu-devel@nongnu.org

On 1/19/19 12:14 AM, Bastian Koppelmann wrote:
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
> ---
>  target/riscv/insn32.decode              |  2 ++
>  target/riscv/insn_trans/trans_rvi.inc.c | 23 +++++++++++++++++++++++
>  target/riscv/translate.c                | 12 ------------
>  3 files changed, 25 insertions(+), 12 deletions(-)
> 
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 1f5bf1f6f9..804b721ca5 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -82,3 +82,5 @@ srl      0000000 .....    ..... 101 ..... 0110011 @r
>  sra      0100000 .....    ..... 101 ..... 0110011 @r
>  or       0000000 .....    ..... 110 ..... 0110011 @r
>  and      0000000 .....    ..... 111 ..... 0110011 @r
> +fence    ---- pred:4 succ:4 ----- 000 ----- 0001111
> +fence_i  ---- ----   ----   ----- 001 ----- 0001111
> diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
> index 01f751650a..138a8397d9 100644
> --- a/target/riscv/insn_trans/trans_rvi.inc.c
> +++ b/target/riscv/insn_trans/trans_rvi.inc.c
> @@ -318,3 +318,26 @@ static bool trans_sraw(DisasContext *ctx, arg_sraw *a)
>      return true;
>  }
>  #endif
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
> +    /*
> +     * FENCE_I is a no-op in QEMU,
> +     * however we need to end the translation block
> +     */
> +    tcg_gen_movi_tl(cpu_pc, ctx->pc_succ_insn);
> +    tcg_gen_exit_tb(NULL, 0);
> +    ctx->base.is_jmp = DISAS_NORETURN;
> +#endif
> +    return true;

Rebase error.  You need to remove the ifdefs that were removed...


> -    case OPC_RISC_FENCE:
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
> -        break;

... from here.


r~
