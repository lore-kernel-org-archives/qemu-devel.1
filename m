Received: from eggs.gnu.org ([2001:4830:134:3::10]:43292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBN7N-0005H3-8W
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 12:50:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBN7K-00048Y-2O
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 12:50:21 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:44077)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gBN7I-00044j-C5
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 12:50:17 -0400
Received: by mail-pg1-x530.google.com with SMTP id g2-v6so7224065pgu.11
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 09:50:14 -0700 (PDT)
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
	<20181012173047.25420-9-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ced866db-2eeb-cf2c-11e9-510b1c0501d9@linaro.org>
Date: Sat, 13 Oct 2018 09:50:10 -0700
MIME-Version: 1.0
In-Reply-To: <20181012173047.25420-9-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/28] target/riscv: Convert RV32A insns to
 decodetree
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
>  @fence   .... .... .... .....  ... ..... ....... %pred %succ
>  @csr     ............   .....  ... ..... .......               %csr     %rs1 %rd
>  
> +@atom_ld ..... aq:1 rl:1 ..... ........ ..... ....... &atomic rs2=00000 %rs1 %rd
rs2=0.  This value is always parsed as decimal, not binary.


> +    switch (opc) {
> +    case OPC_RISC_AMOSWAP:
> +        /* Note that the TCG atomic primitives are SC,
> +           so we can ignore AQ/RL along this path.  */
> +        tcg_gen_atomic_xchg_tl(src2, src1, src2, ctx->mem_idx, mop);
> +        break;
> +    case OPC_RISC_AMOADD:
> +        tcg_gen_atomic_fetch_add_tl(src2, src1, src2, ctx->mem_idx, mop);
> +        break;
> +    case OPC_RISC_AMOXOR:
> +        tcg_gen_atomic_fetch_xor_tl(src2, src1, src2, ctx->mem_idx, mop);
> +        break;
> +    case OPC_RISC_AMOAND:
> +        tcg_gen_atomic_fetch_and_tl(src2, src1, src2, ctx->mem_idx, mop);
> +        break;
> +    case OPC_RISC_AMOOR:
> +        tcg_gen_atomic_fetch_or_tl(src2, src1, src2, ctx->mem_idx, mop);
> +        break;
> +    case OPC_RISC_AMOMIN:
> +        tcg_gen_atomic_fetch_smin_tl(src2, src1, src2, ctx->mem_idx, mop);
> +        break;
> +    case OPC_RISC_AMOMAX:
> +        tcg_gen_atomic_fetch_smax_tl(src2, src1, src2, ctx->mem_idx, mop);
> +        break;
> +    case OPC_RISC_AMOMINU:
> +        tcg_gen_atomic_fetch_umin_tl(src2, src1, src2, ctx->mem_idx, mop);
> +        break;
> +    case OPC_RISC_AMOMAXU:
> +        tcg_gen_atomic_fetch_umax_tl(src2, src1, src2, ctx->mem_idx, mop);
> +        break;
> +    default:
> +        return false;

Given how these switch elements are passed in, this should use
g_assert_not_reached().

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
