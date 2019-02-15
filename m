Received: from eggs.gnu.org ([209.51.188.92]:58669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gucOQ-00058u-Hz
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:14:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gucOP-0008Cp-Lv
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 07:14:58 -0500
References: <20190213155414.22285-1-palmer@sifive.com>
	<20190213155414.22285-21-palmer@sifive.com>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <b587abb9-b664-6999-ef2a-df4bdee7c383@mail.uni-paderborn.de>
Date: Fri, 15 Feb 2019 13:14:45 +0100
MIME-Version: 1.0
In-Reply-To: <20190213155414.22285-21-palmer@sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [PATCH v7 20/35] target/riscv: Remove gen_jalr()
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


On 2/13/19 4:53 PM, Palmer Dabbelt wrote:
> From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
>
> trans_jalr() is the only caller, so move the code into trans_jalr().
>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
> ---
>   target/riscv/insn_trans/trans_rvi.inc.c | 28 +++++++++++++++++-
>   target/riscv/translate.c                | 38 -------------------------
>   2 files changed, 27 insertions(+), 39 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
> index 4a23372cb823..39af38081ede 100644
> --- a/target/riscv/insn_trans/trans_rvi.inc.c
> +++ b/target/riscv/insn_trans/trans_rvi.inc.c
> @@ -42,7 +42,33 @@ static bool trans_jal(DisasContext *ctx, arg_jal *a)
>   
>   static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
>   {
> -    gen_jalr(ctx, OPC_RISC_JALR, a->rd, a->rs1, a->imm);
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


Also has_ext()

Cheers,

Bastian
