Received: from eggs.gnu.org ([2001:4830:134:3::10]:40656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHz80-0000ae-9P
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHz7t-00040E-3t
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:38:19 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gHz7s-0003zC-Hi
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:38:12 -0400
Received: by mail-wr1-x442.google.com with SMTP id i17-v6so18154720wre.7
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 15:38:11 -0700 (PDT)
References: <20181031132029.4887-1-kbastian@mail.uni-paderborn.de>
	<20181031132029.4887-27-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8818c4f3-7ff5-44c6-abbe-67489519ccde@linaro.org>
Date: Wed, 31 Oct 2018 22:38:08 +0000
MIME-Version: 1.0
In-Reply-To: <20181031132029.4887-27-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 26/35] target/riscv: Remove shift and
 slt insn manual decoding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, mjc@sifive.com, sagark@eecs.berkeley.edu, palmer@sifive.com, Alistair.Francis@wdc.com
Cc: peer.adelt@hni.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org

On 10/31/18 1:20 PM, Bastian Koppelmann wrote:
>  static bool trans_slt(DisasContext *ctx, arg_slt *a)
>  {
> -    gen_arith(ctx, OPC_RISC_SLT, a->rd, a->rs1, a->rs2);
> +    TCGv source1 = tcg_temp_new();
> +    TCGv source2 = tcg_temp_new();
> +
> +    gen_get_gpr(source1, a->rs1);
> +    gen_get_gpr(source2, a->rs2);
> +
> +    tcg_gen_setcond_tl(TCG_COND_LT, source1, source1, source2);

I do wonder about extracting this one line to gen_slt so that you can re-use
gen_arith and gen_arithi.

> +    tcg_gen_setcond_tl(TCG_COND_LTU, source1, source1, source2);

Similarly.

>  static bool trans_sllw(DisasContext *ctx, arg_sllw *a)
>  {
> -    gen_arith(ctx, OPC_RISC_SLLW, a->rd, a->rs1, a->rs2);
> +    TCGv source1 = tcg_temp_new();
> +    TCGv source2 = tcg_temp_new();
> +
> +    gen_get_gpr(source1, a->rs1);
> +    gen_get_gpr(source2, a->rs2);
> +
> +    tcg_gen_andi_tl(source2, source2, 0x1F);
> +    tcg_gen_shl_tl(source1, source1, source2);
> +
> +    gen_set_gpr(a->rd, source1);

Missing the ext32s after the shift.

>  static bool trans_srlw(DisasContext *ctx, arg_srlw *a)
>  {
> -    gen_arith(ctx, OPC_RISC_SRLW, a->rd, a->rs1, a->rs2);
> +    TCGv source1 = tcg_temp_new();
> +    TCGv source2 = tcg_temp_new();
> +
> +    gen_get_gpr(source1, a->rs1);
> +    gen_get_gpr(source2, a->rs2);
> +
> +    /* clear upper 32 */
> +    tcg_gen_ext32u_tl(source1, source1);
> +    tcg_gen_andi_tl(source2, source2, 0x1F);
> +    tcg_gen_shr_tl(source1, source1, source2);

Likewise.  (Consider source2 == 0.)

> -    case OPC_RISC_SRL:
> -        tcg_gen_andi_tl(source2, source2, TARGET_LONG_BITS - 1);
> -        tcg_gen_shr_tl(source1, source1, source2);
> -        break;
...
> -    case OPC_RISC_SRA:
> -        tcg_gen_andi_tl(source2, source2, TARGET_LONG_BITS - 1);
> -        tcg_gen_sar_tl(source1, source1, source2);
> -        break;

I see that the bugs are in the original though, so fixing them in a separate
patch is certainly ok.


r~
