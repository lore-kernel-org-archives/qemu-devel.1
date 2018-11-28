Received: from eggs.gnu.org ([2001:4830:134:3::10]:59699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gS5oz-00086d-Te
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 14:48:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gS5ou-00046O-VO
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 14:48:29 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:34127)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gS5ou-00045S-Ii
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 14:48:24 -0500
Received: by mail-pf1-x42b.google.com with SMTP id h3so10690759pfg.1
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 11:48:24 -0800 (PST)
References: <cover.1543352682.git.alistair.francis@wdc.com>
	<51221791beb40b25309805b1c76db0004f26f64e.1543352682.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <111ab594-64d4-efbd-2ce9-cda600a47abc@linaro.org>
Date: Wed, 28 Nov 2018 11:48:19 -0800
MIME-Version: 1.0
In-Reply-To: <51221791beb40b25309805b1c76db0004f26f64e.1543352682.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 11/24] riscv: tcg-target: Add the mov and
 movi instruction
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

On 11/27/18 1:08 PM, Alistair Francis wrote:
> +static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
> +                         tcg_target_long val)
> +{
> +#if TCG_TARGET_REG_BITS == 64
> +    tcg_target_long lo = sextract64(val, 0, 12);
> +#else
> +    tcg_target_long lo = sextract32(val, 0, 12);
> +#endif

I really think this ifdef should be moved into a helper function.  There are
quite a number of copies of it throughout.

> +    tcg_target_long hi = val - lo;
> +    int shift;
> +    tcg_target_long tmp;
> +
> +    RISCVInsn add32_op = TCG_TARGET_REG_BITS == 64 ? OPC_ADDIW : OPC_ADDI;
> +
> +#if TCG_TARGET_REG_BITS == 64
> +    ptrdiff_t offset = tcg_pcrel_diff(s, (void *)val);
> +#endif
> +
> +    if (TCG_TARGET_REG_BITS == 32 || val == (int32_t)val) {
> +        tcg_out_opc_upper(s, OPC_LUI, rd, hi);
> +        if (lo != 0) {
> +            tcg_out_opc_imm(s, add32_op, rd, rd, lo);
> +        }
> +
> +        return;
> +    }

Your reorg has failed to keep the single insn ADDI(W) case.

> +    /* We can only be here if TCG_TARGET_REG_BITS != 32 */
> +    if (offset == sextract64(offset, 1, 31) << 1) {

The ifdef above won't compile for rv32, because offset is used unconditionally
here.  Remove the ifdef and allow that to be removed as dead code by the compiler.

> +        tcg_out_opc_upper(s, OPC_AUIPC, rd, 0);
> +        tcg_out_opc_imm(s, OPC_ADDI, rd, rd, 0);
> +        reloc_call(s->code_ptr - 2, (tcg_insn_unit *)val);
> +        return;
> +    }
> +
> +    shift = ctz64(val);
> +    tmp = val >> shift;
> +
> +    if (tmp == sextract64(tmp, 0, 12)) {
> +        tcg_out_opc_imm(s, OPC_ADDI, rd, TCG_REG_ZERO, 1);

s/1/tmp/

> +        tcg_out_opc_imm(s, OPC_SLLI, rd, rd, ctz64(val));
> +    } else if (!(val >> 31 == 0 || val >> 31 == -1)) {
> +        shift = ctz64(hi);
> +        hi >>= shift;
> +        tcg_out_movi(s, type, rd, hi);
> +        tcg_out_opc_imm(s, OPC_SLLI, rd, rd, shift);
> +        if (lo != 0) {
> +            tcg_out_opc_imm(s, OPC_ADDI, rd, rd, lo);
> +        }
> +    } else {
> +        if (hi != 0) {
> +            tcg_out_opc_upper(s, OPC_LUI, rd, hi);
> +        }
> +        if (lo != 0) {
> +            tcg_out_opc_imm(s, add32_op, rd, hi == 0 ? TCG_REG_ZERO : rd, lo);
> +        }
> +    }

The final else case is identical with the first if.


r~
