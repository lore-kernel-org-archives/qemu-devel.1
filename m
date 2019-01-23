Received: from eggs.gnu.org ([209.51.188.92]:40720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gm668-0005eU-G4
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 19:08:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gm667-0001CT-J2
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 19:08:52 -0500
MIME-Version: 1.0
References: <20190122092909.5341-1-kbastian@mail.uni-paderborn.de>
	<20190122092909.5341-14-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20190122092909.5341-14-kbastian@mail.uni-paderborn.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 22 Jan 2019 16:08:13 -0800
Message-ID: <CAKmqyKNRKAO_YSo5V0cmm=hCrKoyAaJsj2wzG3gDqJTmwfKkMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 13/35] target/riscv: Convert RV64F insns
 to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>, Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org, peer.adelt@hni.uni-paderborn.de, Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Tue, Jan 22, 2019 at 1:49 AM Bastian Koppelmann
<kbastian@mail.uni-paderborn.de> wrote:
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn32-64.decode           |  6 +++
>  target/riscv/insn_trans/trans_rvf.inc.c | 54 +++++++++++++++++++++++++
>  2 files changed, 60 insertions(+)
>
> diff --git a/target/riscv/insn32-64.decode b/target/riscv/insn32-64.decode
> index 0bee95c984..6319f872ac 100644
> --- a/target/riscv/insn32-64.decode
> +++ b/target/riscv/insn32-64.decode
> @@ -56,3 +56,9 @@ amomin_d   10000 . . ..... ..... 011 ..... 0101111 @atom_st
>  amomax_d   10100 . . ..... ..... 011 ..... 0101111 @atom_st
>  amominu_d  11000 . . ..... ..... 011 ..... 0101111 @atom_st
>  amomaxu_d  11100 . . ..... ..... 011 ..... 0101111 @atom_st
> +
> +# *** RV64F Standard Extension (in addition to RV32F) ***
> +fcvt_l_s   1100000  00010 ..... ... ..... 1010011 @r2_rm
> +fcvt_lu_s  1100000  00011 ..... ... ..... 1010011 @r2_rm
> +fcvt_s_l   1101000  00010 ..... ... ..... 1010011 @r2_rm
> +fcvt_s_lu  1101000  00011 ..... ... ..... 1010011 @r2_rm
> diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv/insn_trans/trans_rvf.inc.c
> index b101593ac4..b667c576d4 100644
> --- a/target/riscv/insn_trans/trans_rvf.inc.c
> +++ b/target/riscv/insn_trans/trans_rvf.inc.c
> @@ -332,3 +332,57 @@ static bool trans_fmv_w_x(DisasContext *ctx, arg_fmv_w_x *a)
>
>      return true;
>  }
> +
> +#ifdef TARGET_RISCV64
> +static bool trans_fcvt_l_s(DisasContext *ctx, arg_fcvt_l_s *a)
> +{
> +    REQUIRE_FPU;
> +
> +    TCGv t0 = tcg_temp_new();
> +    gen_set_rm(ctx, a->rm);
> +    gen_helper_fcvt_l_s(t0, cpu_env, cpu_fpr[a->rs1]);
> +    gen_set_gpr(a->rd, t0);
> +    tcg_temp_free(t0);
> +    return true;
> +}
> +
> +static bool trans_fcvt_lu_s(DisasContext *ctx, arg_fcvt_lu_s *a)
> +{
> +    REQUIRE_FPU;
> +
> +    TCGv t0 = tcg_temp_new();
> +    gen_set_rm(ctx, a->rm);
> +    gen_helper_fcvt_lu_s(t0, cpu_env, cpu_fpr[a->rs1]);
> +    gen_set_gpr(a->rd, t0);
> +    tcg_temp_free(t0);
> +    return true;
> +}
> +
> +static bool trans_fcvt_s_l(DisasContext *ctx, arg_fcvt_s_l *a)
> +{
> +    REQUIRE_FPU;
> +
> +    TCGv t0 = tcg_temp_new();
> +    gen_get_gpr(t0, a->rs1);
> +
> +    gen_set_rm(ctx, a->rm);
> +    gen_helper_fcvt_s_l(cpu_fpr[a->rd], cpu_env, t0);
> +
> +    tcg_temp_free(t0);
> +    return true;
> +}
> +
> +static bool trans_fcvt_s_lu(DisasContext *ctx, arg_fcvt_s_lu *a)
> +{
> +    REQUIRE_FPU;
> +
> +    TCGv t0 = tcg_temp_new();
> +    gen_get_gpr(t0, a->rs1);
> +
> +    gen_set_rm(ctx, a->rm);
> +    gen_helper_fcvt_s_lu(cpu_fpr[a->rd], cpu_env, t0);
> +
> +    tcg_temp_free(t0);
> +    return true;
> +}
> +#endif
> --
> 2.20.1
>
>
