Received: from eggs.gnu.org ([2001:4830:134:3::10]:46289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gS6Un-0006Ww-1W
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:31:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gS6TI-0003Zi-GX
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:30:11 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:36169)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gS6TH-0003Yq-RP
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:30:08 -0500
Received: by mail-pf1-x444.google.com with SMTP id b85so10737318pfc.3
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 12:30:07 -0800 (PST)
References: <cover.1543352682.git.alistair.francis@wdc.com>
	<46fe7e6cef5c03c2165feaf400cca797ee1b10f9.1543352682.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b79b17aa-4c5e-e081-2b1f-0f7649b810c4@linaro.org>
Date: Wed, 28 Nov 2018 12:30:03 -0800
MIME-Version: 1.0
In-Reply-To: <46fe7e6cef5c03c2165feaf400cca797ee1b10f9.1543352682.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 23/24] WIP: Add missing instructions
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

On 11/27/18 1:10 PM, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  tcg/riscv/tcg-target.inc.c | 77 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
> index 13756f6d0d..b8e9c0e126 100644
> --- a/tcg/riscv/tcg-target.inc.c
> +++ b/tcg/riscv/tcg-target.inc.c
> @@ -606,6 +606,57 @@ static bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
>      return false;
>  }
>  
> +static void tcg_out_addsub2(TCGContext *s,
> +                            TCGReg rl, TCGReg rh,
> +                            TCGReg al, TCGReg ah,
> +                            TCGReg bl, TCGReg bh,
> +                            bool cbl, bool cbh, bool is_sub)
> +{
> +    /* FIXME: This is just copied from MIPS */
> +    TCGReg th = TCG_REG_TMP1;
> +
> +    /* If we have a negative constant such that negating it would
> +       make the high part zero, we can (usually) eliminate one insn.  */
> +    if (cbl && cbh && bh == -1 && bl != 0) {
> +        bl = -bl;
> +        bh = 0;
> +        is_sub = !is_sub;
> +    }
> +
> +    /* By operating on the high part first, we get to use the final
> +       carry operation to move back from the temporary.  */
> +    if (!cbh) {
> +        tcg_out_opc_reg(s, (is_sub ? OPC_SUB : OPC_ADDI), th, ah, bh);
> +    } else if (bh != 0 || ah == rl) {
> +        tcg_out_opc_imm(s, OPC_ADDI, th, ah, (is_sub ? -bh : bh));
> +    } else {
> +        th = ah;
> +    }
> +
> +    if (is_sub) {
> +        if (cbl) {
> +            tcg_out_opc_imm(s, OPC_SLLI, TCG_REG_TMP0, al, bl);

s/SLLI/SLTIU/

> +            tcg_out_opc_imm(s, OPC_ADDI, rl, al, -bl);
> +        } else {
> +            tcg_out_opc_reg(s, OPC_SLLI, TCG_REG_TMP0, al, bl);

s/SLLI/SLTU/

> +            tcg_out_opc_reg(s, OPC_SUB, rl, al, bl);
> +        }
> +        tcg_out_opc_reg(s, OPC_SUB, rh, th, TCG_REG_TMP0);
> +    } else {
> +        if (cbl) {
> +            tcg_out_opc_imm(s, OPC_ADDI, rl, al, bl);
> +            tcg_out_opc_imm(s, OPC_SLLI, TCG_REG_TMP0, rl, bl);

SLTIU

> +        } else if (rl == al && rl == bl) {
> +            tcg_out_opc_imm(s, OPC_SRLI, TCG_REG_TMP0, al, 31);

s/31/TCG_TARGET_REG_BITS - 1/
or somesuch.  I think that's an existing mips bug too...

> +            tcg_out_opc_reg(s, OPC_ADDI, rl, al, bl);

ADD, not ADDI.

> +        } else {
> +            tcg_out_opc_reg(s, OPC_ADDI, rl, al, bl);
> +            tcg_out_opc_reg(s, OPC_SLLI, TCG_REG_TMP0, rl, (rl == bl ? al : bl));

Similarly.

> +        }
> +        tcg_out_opc_reg(s, OPC_ADDI, rh, th, TCG_REG_TMP0);

ADD.

> @@ -1537,6 +1604,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
>      case INDEX_op_ext16s_i32:
>      case INDEX_op_ext16s_i64:
>      case INDEX_op_ext32s_i64:
> +    case INDEX_op_extrl_i64_i32:
> +    case INDEX_op_extrh_i64_i32:

This belongs in a previous patch.


> +    case INDEX_op_add2_i32:
> +    case INDEX_op_add2_i64:
> +        return &rZ_rZ_rZ_rZ_rZ_rZ;
> +
> +    case INDEX_op_sub2_i32:
> +    case INDEX_op_sub2_i64:
> +        return &rZ_rZ_rZ_rZ_rZ_rZ;

Adding 0 with TCG_REG_ZERO is sorta pointless.  You want the I and N
constraints.  Note that MIPS uses a modified symmetric N that can always be
negated [-32767, 32767] instead of [-32767, 32768].  Otherwise that first if
statement doesn't work.


r~
