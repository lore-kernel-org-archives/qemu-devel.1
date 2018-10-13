Received: from eggs.gnu.org ([2001:4830:134:3::10]:43193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBP2z-0002FF-4H
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 14:53:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBP2v-0004Tt-Ub
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 14:53:57 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:37355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gBP2v-0004TF-Gi
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 14:53:53 -0400
Received: by mail-pg1-x531.google.com with SMTP id c10-v6so7314057pgq.4
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 11:53:53 -0700 (PDT)
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
	<20181012173047.25420-17-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ed4c028f-12b8-d940-c4ce-49b59c36a06e@linaro.org>
Date: Sat, 13 Oct 2018 11:53:48 -0700
MIME-Version: 1.0
In-Reply-To: <20181012173047.25420-17-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 16/28] target/riscv: Convert quadrant 1 of
 RVXC insns to decodetree
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
> +static bool trans_c_addi(DisasContext *ctx, arg_c_addi *a, uint16_t insn)
> +{
> +    if (a->imm == 0) {
> +        return true;
> +    }

return false, I think.

> +static bool trans_c_jal_addiw(DisasContext *ctx, arg_c_jal_addiw *a,
> +        uint16_t insn)
> +{
> +#ifdef TARGET_RISCV32
> +    /* C.JAL */
> +    arg_c_j *tmp = g_new0(arg_c_j, 1);
> +    extract_cj(tmp, insn);

Again with the g_new0 without free, which should use stack.

> +    arg_jal arg = { .rd = 1, .imm = a->imm };
> +    return trans_jal(ctx, &arg, insn);
> +#else
> +    /* C.ADDIW */
> +    arg_addiw arg = { .rd = a->rd, .rs1 = a->rd, .imm = a->imm };
> +    return trans_addiw(ctx, &arg, insn);
> +#endif
> +}
> +
> +static bool trans_c_li(DisasContext *ctx, arg_c_li *a, uint16_t insn)
> +{
> +    if (a->rd == 0) {
> +        return true;
> +    }

return false.

> +static bool trans_c_addi16sp_lui(DisasContext *ctx, arg_c_addi16sp_lui *a,
> +        uint16_t insn)
> +{
> +    if (a->rd == 2) {
> +        /* C.ADDI16SP */
> +        arg_addi arg = { .rd = 2, .rs1 = 2, .imm = a->imm_addi16sp };
> +        return trans_addi(ctx, &arg, insn);
> +    } else if (a->imm_lui != 0) {
> +        if (a->rd == 0) {
> +            return true;
> +        }

I think it should be

  } else if (a->imm_lui != 0 && a->rd != 0) {

> +        /* C.LUI */
> +        arg_lui arg = { .rd = a->rd, .imm = a->imm_lui };
> +        return trans_lui(ctx, &arg, insn);
> +    }
> +    return false;
> +}
> +
> +static bool trans_c_srli(DisasContext *ctx, arg_c_srli *a, uint16_t insn)
> +{
> +    if (a->shamt == 0) {
> +        /* Reserved in ISA */
> +        gen_exception_illegal(ctx);
> +        return true;
> +    }

Choose return false or raise exception.  Except...
I wonder if we might write this as

    int shamt = a->shamt;
    if (shamt == 0) {
        shamt = 64;
    }

> +#ifdef TARGET_RISCV32
> +    /* Ensure, that shamt[5] is zero for RV32 */
> +    if (a->shamt >= 32) {
> +        gen_exception_illegal(ctx);
> +        return true;
> +    }
> +#endif

then this is unconditional as

    if (a->shamt >= TARGET_LONG_BITS)

which makes it clear that "reserved in isa" already has a meaning.

> +
> +    arg_srli arg = { .rd = a->rd, .rs1 = a->rd, .shamt = a->shamt };
> +    return trans_srli(ctx, &arg, insn);

Although I do wonder about moving that check into trans_srli et al, rather than
bend over backward parsing 6-bit shift amount rather just using @i format.


r~
