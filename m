Received: from eggs.gnu.org ([2001:4830:134:3::10]:60020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNaMv-0007IT-Vs
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 04:24:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNaMs-0002qZ-Qf
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 04:24:53 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:33468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gNaMs-0002oH-FZ
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 04:24:50 -0500
Received: by mail-wr1-x430.google.com with SMTP id u9-v6so24106768wrr.0
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 01:24:49 -0800 (PST)
References: <cover.1542321076.git.alistair.francis@wdc.com>
	<bd8f5c781f7086c5b26e1bd4c8e6570b5534b22d.1542321076.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f56a1b1c-8cc8-7e85-c88b-3894e4628d6b@linaro.org>
Date: Fri, 16 Nov 2018 10:24:45 +0100
MIME-Version: 1.0
In-Reply-To: <bd8f5c781f7086c5b26e1bd4c8e6570b5534b22d.1542321076.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v1 16/23] riscv: tcg-target: Add slowpath
 load and store instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>

On 11/15/18 11:36 PM, Alistair Francis wrote:
> +static void tcg_out_mb(TCGContext *s, TCGArg a0)
> +{
> +    static const RISCVInsn fence[] = {
> +        [0 ... TCG_MO_ALL] = OPC_FENCE_RW_RW,
> +        [TCG_MO_LD_LD]     = OPC_FENCE_R_R,
> +        [TCG_MO_ST_LD]     = OPC_FENCE_W_R,
> +        [TCG_MO_LD_ST]     = OPC_FENCE_R_W,
> +        [TCG_MO_ST_ST]     = OPC_FENCE_W_W,
> +        [TCG_BAR_LDAQ]     = OPC_FENCE_R_RW,
> +        [TCG_BAR_STRL]     = OPC_FENCE_RW_W,
> +        [TCG_BAR_SC]       = OPC_FENCE_RW_RW,
> +    };
> +    tcg_out32(s, fence[a0 & TCG_MO_ALL]);
> +}
> +

TCG_MO_* and TCG_BAR_* are two different bitmasks, or'ed together.
Which you've separated by "& TCG_MO_ALL".  Thus the TCG_BAR_* constants should
not appear in this table.


> +static void * const qemu_ld_helpers[16] = {
> +    [MO_UB]   = helper_ret_ldub_mmu,
> +    [MO_SB]   = helper_ret_ldsb_mmu,
> +    [MO_LEUW] = helper_le_lduw_mmu,
> +    [MO_LESW] = helper_le_ldsw_mmu,
> +    [MO_LEUL] = helper_le_ldul_mmu,
> +    [MO_LESL] = helper_le_ldsl_mmu,
> +    [MO_LEQ]  = helper_le_ldq_mmu,
> +    [MO_BEUW] = helper_be_lduw_mmu,
> +    [MO_BESW] = helper_be_ldsw_mmu,
> +    [MO_BEUL] = helper_be_ldul_mmu,
> +    [MO_BESL] = helper_be_ldsl_mmu,
> +    [MO_BEQ]  = helper_be_ldq_mmu,
> +};

The LESL and BESL functions will not be present for rv32 -> link error.  Here
you do need an ifdef.

> +        } else {
> +            adj = cmp_off - sextract32(cmp_off, 0, 12);
> +            tcg_debug_assert(add_off - adj >= -0x1000
> +                             && add_off - adj < 0x1000);
> +
> +            tcg_out_opc_upper(s, OPC_LUI, base, adj);
> +            tcg_out_opc_reg(s, OPC_ADD, base, TCG_REG_ZERO, TCG_AREG0);

base, base, TCG_AREG0.

> +    /* Compare masked address with the TLB entry. */
> +    label_ptr[0] = s->code_ptr;
> +    tcg_out_opc_branch(s, OPC_BNE, TCG_REG_TMP0, TCG_REG_TMP1, 0);

Another case of a potential out-of-range branch.

It might be worthwhile to move all of this out-of-line from the start, where
that branch will always be short.  See

http://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg02234.html


r~
