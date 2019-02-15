Received: from eggs.gnu.org ([209.51.188.92]:58907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gucOw-0005dI-2h
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:15:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gucOu-0000PI-Se
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:15:30 -0500
References: <20190213155414.22285-1-palmer@sifive.com>
	<20190213155414.22285-22-palmer@sifive.com>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <c104c6de-4594-d55e-3910-be86f4be199b@mail.uni-paderborn.de>
Date: Fri, 15 Feb 2019 13:15:25 +0100
MIME-Version: 1.0
In-Reply-To: <20190213155414.22285-22-palmer@sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [PATCH v7 21/35] target/riscv: Remove manual
 decoding from gen_branch()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org
Cc: Peer Adelt <peer.adelt@hni.uni-paderborn.de>, qemu-devel@nongnu.org


On 2/13/19 4:54 PM, Palmer Dabbelt wrote:
> From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
>
> We now utilizes argument-sets of decodetree such that no manual
> decoding is necessary.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
> ---
>   target/riscv/insn_trans/trans_rvi.inc.c | 46 +++++++++++++++++-------
>   target/riscv/translate.c                | 47 -------------------------
>   2 files changed, 33 insertions(+), 60 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
> index 39af38081ede..000cb6a37bdd 100644
> --- a/target/riscv/insn_trans/trans_rvi.inc.c
> +++ b/target/riscv/insn_trans/trans_rvi.inc.c
> @@ -72,41 +72,61 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
>       return true;
>   }
>   
> -static bool trans_beq(DisasContext *ctx, arg_beq *a)
> +static bool gen_branch(DisasContext *ctx, arg_b *a, TCGCond cond)
>   {
> -    gen_branch(ctx, OPC_RISC_BEQ, a->rs1, a->rs2, a->imm);
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


Also has_ext()

Cheers,

Bastian
