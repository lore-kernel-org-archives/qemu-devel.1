Received: from eggs.gnu.org ([2001:4830:134:3::10]:59679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEEMo-0002Op-33
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 10:06:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEEMk-0007nm-Ix
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 10:06:06 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40571)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEEMk-0007mq-1i
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 10:06:02 -0400
Received: by mail-wr1-x442.google.com with SMTP id d2-v6so42095149wro.7
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 07:06:01 -0700 (PDT)
References: <20181020071451.27808-1-kbastian@mail.uni-paderborn.de>
	<20181020071451.27808-7-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a747e54d-b2d0-2d65-89eb-b42fd18b5c1a@linaro.org>
Date: Sun, 21 Oct 2018 15:05:57 +0100
MIME-Version: 1.0
In-Reply-To: <20181020071451.27808-7-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 06/29] target/riscv: Convert RVXI fence
 insns to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, mjc@sifive.com, sagark@eecs.berkeley.edu, palmer@sifive.com
Cc: peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, qemu-devel@nongnu.org

On 10/20/18 8:14 AM, Bastian Koppelmann wrote:
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
> ---
> v1 -> v2:
>     - simplified fence/fence_i as suggested by Richard
> 
>  target/riscv/insn32.decode              |  6 ++++++
>  target/riscv/insn_trans/trans_rvi.inc.c | 20 ++++++++++++++++++++
>  target/riscv/translate.c                | 14 --------------
>  3 files changed, 26 insertions(+), 14 deletions(-)
> 
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index cb7622e223..00e30dbc71 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -24,6 +24,9 @@
>  %sh6    20:6
>  %sh5    20:5
>  
> +%pred   24:4
> +%succ   20:4

Unused.

> +static bool trans_fence(DisasContext *ctx, arg_fence *a, uint32_t insn)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    /* FENCE is a full memory barrier. */
> +    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
> +#endif
> +    return true;
> +}
> +static bool trans_fence_i(DisasContext *ctx, arg_fence_i *a, uint32_t insn)

Spacing.

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

I will note that both of these should apply to user-only as well...

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

... even though you're simply copying the bug.

I mentioned this twice during initial review of risc-v, but it seems to have
been missed during commit.

Also note that one can do better than TCG_MO_ALL by actually using the
pred/succ bits to select TCG_MO_{LD,ST}_{LD,ST}.

That said, no new bugs with this patch, so
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
