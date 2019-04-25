Received: from eggs.gnu.org ([209.51.188.92]:44542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hJgrQ-0000rd-JF
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:04:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hJgrK-0002CI-So
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:04:30 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:38897)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hJgrI-00027g-Sp
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:04:26 -0400
Received: by mail-pf1-x441.google.com with SMTP id 10so135896pfo.5
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 09:04:24 -0700 (PDT)
Date: Thu, 25 Apr 2019 09:04:22 -0700 (PDT)
In-Reply-To: <20190401031155.21293-8-richard.henderson@linaro.org>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-70de221d-edd7-4a93-8ab5-e5715e97a049@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.1 7/8] target/riscv: Split
 gen_arith_imm into functional and temp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org

On Sun, 31 Mar 2019 20:11:54 PDT (-0700), richard.henderson@linaro.org wrote:
> The tcg_gen_fooi_tl functions have some immediate constant
> folding built in, which match up with some of the riscv asm
> builtin macros, like mv and not.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/riscv/insn_trans/trans_rvi.inc.c | 14 +++++++-------
>  target/riscv/translate.c                | 19 +++++++++++++++++--
>  2 files changed, 24 insertions(+), 9 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
> index caf91f9a05..620df5f323 100644
> --- a/target/riscv/insn_trans/trans_rvi.inc.c
> +++ b/target/riscv/insn_trans/trans_rvi.inc.c
> @@ -223,7 +223,7 @@ static bool trans_sd(DisasContext *ctx, arg_sd *a)
>
>  static bool trans_addi(DisasContext *ctx, arg_addi *a)
>  {
> -    return gen_arith_imm(ctx, a, &tcg_gen_add_tl);
> +    return gen_arith_imm_fn(ctx, a, &tcg_gen_addi_tl);
>  }
>
>  static void gen_slt(TCGv ret, TCGv s1, TCGv s2)
> @@ -239,25 +239,25 @@ static void gen_sltu(TCGv ret, TCGv s1, TCGv s2)
>
>  static bool trans_slti(DisasContext *ctx, arg_slti *a)
>  {
> -    return gen_arith_imm(ctx, a, &gen_slt);
> +    return gen_arith_imm_tl(ctx, a, &gen_slt);
>  }
>
>  static bool trans_sltiu(DisasContext *ctx, arg_sltiu *a)
>  {
> -    return gen_arith_imm(ctx, a, &gen_sltu);
> +    return gen_arith_imm_tl(ctx, a, &gen_sltu);
>  }
>
>  static bool trans_xori(DisasContext *ctx, arg_xori *a)
>  {
> -    return gen_arith_imm(ctx, a, &tcg_gen_xor_tl);
> +    return gen_arith_imm_fn(ctx, a, &tcg_gen_xori_tl);
>  }
>  static bool trans_ori(DisasContext *ctx, arg_ori *a)
>  {
> -    return gen_arith_imm(ctx, a, &tcg_gen_or_tl);
> +    return gen_arith_imm_fn(ctx, a, &tcg_gen_ori_tl);
>  }
>  static bool trans_andi(DisasContext *ctx, arg_andi *a)
>  {
> -    return gen_arith_imm(ctx, a, &tcg_gen_and_tl);
> +    return gen_arith_imm_fn(ctx, a, &tcg_gen_andi_tl);
>  }
>  static bool trans_slli(DisasContext *ctx, arg_slli *a)
>  {
> @@ -364,7 +364,7 @@ static bool trans_and(DisasContext *ctx, arg_and *a)
>  #ifdef TARGET_RISCV64
>  static bool trans_addiw(DisasContext *ctx, arg_addiw *a)
>  {
> -    return gen_arith_imm(ctx, a, &gen_addw);
> +    return gen_arith_imm_tl(ctx, a, &gen_addw);
>  }
>
>  static bool trans_slliw(DisasContext *ctx, arg_slliw *a)
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 50d8f58e4b..fb66e886bf 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -547,8 +547,23 @@ static int ex_rvc_shifti(int imm)
>  /* Include the auto-generated decoder for 32 bit insn */
>  #include "decode_insn32.inc.c"
>
> -static bool gen_arith_imm(DisasContext *ctx, arg_i *a,
> -                          void(*func)(TCGv, TCGv, TCGv))
> +static bool gen_arith_imm_fn(DisasContext *ctx, arg_i *a,
> +                             void (*func)(TCGv, TCGv, target_long))
> +{
> +    TCGv source1;
> +    source1 = tcg_temp_new();
> +
> +    gen_get_gpr(source1, a->rs1);
> +
> +    (*func)(source1, source1, a->imm);
> +
> +    gen_set_gpr(a->rd, source1);
> +    tcg_temp_free(source1);
> +    return true;
> +}
> +
> +static bool gen_arith_imm_tl(DisasContext *ctx, arg_i *a,
> +                             void (*func)(TCGv, TCGv, TCGv))
>  {
>      TCGv source1, source2;
>      source1 = tcg_temp_new();

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
