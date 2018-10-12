Received: from eggs.gnu.org ([2001:4830:134:3::10]:59179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gB2SK-0006UM-2o
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:46:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gB2SE-0004St-Pi
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:46:35 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:42659)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gB2SD-0004Qc-Us
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:46:30 -0400
Received: by mail-pl1-x633.google.com with SMTP id c8-v6so6318443plo.9
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 11:46:27 -0700 (PDT)
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
	<20181012173047.25420-5-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7cd20102-7198-2755-3ef5-eca7716ac61e@linaro.org>
Date: Fri, 12 Oct 2018 11:46:22 -0700
MIME-Version: 1.0
In-Reply-To: <20181012173047.25420-5-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/28] target/riscv: Convert RVXI
 arithmetic insns to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, mjc@sifive.com, palmer@sifive.com, sagark@eecs.berkeley.edu
Cc: peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, qemu-devel@nongnu.org

On 10/12/18 10:30 AM, Bastian Koppelmann wrote:
> +static bool trans_andi(DisasContext *ctx, arg_andi *a, uint32_t insn)
> +{
> +    gen_arith_imm(ctx, OPC_RISC_ANDI, a->rd, a->rs1, a->imm);
> +    return true;
> +}
> +static bool trans_slli(DisasContext *ctx, arg_slli *a, uint32_t insn)
> +{
> +    if (a->rd != 0) {
> +        TCGv t = tcg_temp_new();
> +        gen_get_gpr(t, a->rs1);
> +
> +        if (a->shamt >= TARGET_LONG_BITS) {
> +            gen_exception_illegal(ctx);
> +            return true;
> +        }
> +        tcg_gen_shli_tl(t, t, a->shamt);
> +
> +        gen_set_gpr(a->rd, t);
> +        tcg_temp_free(t);
> +    } /* NOP otherwise */
> +    return true;
> +}

Spacing.  Any reason why trans_slli (and the other shifts) aren't using
gen_arith_imm as well?

> +static bool trans_addw(DisasContext *ctx, arg_addw *a, uint32_t insn)
> +{
> +#if !defined(TARGET_RISCV64)
> +    gen_exception_illegal(ctx);
> +    return true;
> +#endif
> +    gen_arith(ctx, OPC_RISC_ADDW, a->rd, a->rs1, a->rs2);
> +    return true;
> +}

return false, like you did for trans_ld?


r~
