Received: from eggs.gnu.org ([2001:4830:134:3::10]:50928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNZuq-0006EM-Qr
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:55:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNZuo-0004l2-2G
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:55:52 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38187)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gNZum-0004ed-1A
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:55:49 -0500
Received: by mail-wm1-x341.google.com with SMTP id f2-v6so20275098wme.3
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 00:55:46 -0800 (PST)
References: <cover.1542321076.git.alistair.francis@wdc.com>
	<51aa21df48c5d80484bf396b82d9e3943daf1e0c.1542321076.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a9f58e8f-0cba-57fa-59ed-415b58ae2f2c@linaro.org>
Date: Fri, 16 Nov 2018 09:55:42 +0100
MIME-Version: 1.0
In-Reply-To: <51aa21df48c5d80484bf396b82d9e3943daf1e0c.1542321076.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v1 12/23] riscv: tcg-target: Add the mov and
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

On 11/15/18 11:35 PM, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  tcg/riscv/tcg-target.inc.c | 62 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
> index 475feca906..0e891e24c9 100644
> --- a/tcg/riscv/tcg-target.inc.c
> +++ b/tcg/riscv/tcg-target.inc.c
> @@ -422,6 +422,68 @@ static void patch_reloc(tcg_insn_unit *code_ptr, int type,
>      }
>  }
>  
> +/*
> + * TCG intrinsics
> + */
> +
> +static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
> +{
> +    if (ret == arg) {
> +        return;
> +    }
> +    switch (type) {
> +    case TCG_TYPE_I32:
> +    case TCG_TYPE_I64:
> +        tcg_out_opc_imm(s, OPC_ADDI, ret, arg, 0);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
> +                         tcg_target_long val)
> +{
> +    tcg_target_long lo = sextract32(val, 0, 12);

sextract64, otherwise you'll make wrong decisions for rv64.
(Although it might be worthwhile to add a local alias so that rv32 doesn't do
more work than necessary.)

> +    tcg_target_long hi = val - lo;
> +
> +    RISCVInsn add32_op = TCG_TARGET_REG_BITS == 64 ? OPC_ADDIW : OPC_ADDI;
> +
> +#if TCG_TARGET_REG_BITS == 64
> +    ptrdiff_t offset = tcg_pcrel_diff(s, (void *)val);
> +#endif
> +
> +    if (val == lo) {
> +        tcg_out_opc_imm(s, OPC_ADDI, rd, TCG_REG_ZERO, val);
           return;
       }

Should match

    if (TCG_TARGET_REG_BITS == 32 || val == (int32_t)val) {
        tcg_out_opc_upper(s, OPC_LUI, rd, hi);
        if (lo != 0) {
            tcg_out_opc_imm(s, add32_op, rd, rd, lo);
        }
        return;
    }

here.

(1) Almost all values requested are 32-bit constants, so check the most common
cases first.  (2) You know hi != 0 because you just eliminated val == lo.  (3)
This handles the cases where LUI alone can load the constant, e.g. 0x1000,
which would otherwise have been matched by your power-of-two test.


> +    } else if (val && !(val & (val - 1))) {
> +        /* power of 2 */
> +        tcg_out_opc_imm(s, OPC_ADDI, rd, TCG_REG_ZERO, 1);
> +        tcg_out_opc_imm(s, OPC_SLLI, rd, rd, ctz64(val));

There's no reason to restrict this to powers of 2 and a shift of the constant 1:

    shift = ctz64(val);
    tmp = val >> shift;
    if (tmp == sextract64(tmp, 0, 12))

> +    } else if (TCG_TARGET_REG_BITS == 64 &&
> +               !(val >> 31 == 0 || val >> 31 == -1)) {
> +        int shift = 12 + ctz64(hi >> 12);

This is just ctz64(hi), since you've already cleared the lo 12 bits.

> +        hi >>= shift;
> +        tcg_out_movi(s, type, rd, hi);
> +        tcg_out_opc_imm(s, OPC_SLLI, rd, rd, shift);
> +        if (lo != 0) {
> +            tcg_out_opc_imm(s, OPC_ADDI, rd, rd, lo);
> +        }
> +#if TCG_TARGET_REG_BITS == 64
> +    } else if (offset == sextract32(offset, 1, 31) << 1) {

sextract64.

> +        tcg_out_opc_upper(s, OPC_AUIPC, rd, 0);
> +        tcg_out_opc_imm(s, OPC_ADDI, rd, rd, 0);
> +        reloc_call(s->code_ptr - 2, (tcg_insn_unit *)val);
> +#endif

Move this pc-rel case above the fully general case and then you can make the
fully general case unconditional.  Also, that preserves an invariant of
increasing order of complexity of the cases.  No need for the ifdef, since this
code should be removed as dead for rv32 (which saw the lui+addi case as
unconditional).


r~
