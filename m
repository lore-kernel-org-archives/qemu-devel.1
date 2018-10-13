Received: from eggs.gnu.org ([2001:4830:134:3::10]:37853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBOUg-00041q-Kb
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 14:18:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBOUd-0008Ac-Gu
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 14:18:30 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:33085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gBOUZ-000813-Qx
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 14:18:25 -0400
Received: by mail-pl1-x644.google.com with SMTP id s4-v6so7404832plp.0
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 11:18:22 -0700 (PDT)
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
	<20181012173047.25420-16-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2ef3b2f4-98da-a423-6e11-6dda5779031c@linaro.org>
Date: Sat, 13 Oct 2018 11:18:18 -0700
MIME-Version: 1.0
In-Reply-To: <20181012173047.25420-16-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 15/28] target/riscv: Convert quadrant 0 of
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
> +# Argument sets:
> +&cl               rs1 rd
> +&cl_dw     uimm   rs1 rd
> +&ciw       nzuimm     rd
> +&cs               rs1 rs2
> +&cs_dw     uimm   rs1 rs2

I guess this is good enough for now.
What I'd like to see is something like

&i	imm rs1 rd	!extern

which tells decodetree that the arg_i structure has been declared elsewhere.
Then you can write

> +@cl_w      ... ... ... .. ... .. &i  imm=%uimm_cl_w  rs1=%rs1_3  rd=%rs2_3

lw	010 ... ... .. ... 00	@cl_w

and then the same trans_lw can be used.

> +c_flw_ld          011  --- ... -- ... 00 @cl    #Note: Must parse uimm manually

Why?  It looks identical to @cl_w to me.

> +static bool trans_c_addi4spn(DisasContext *ctx, arg_c_addi4spn *a,
> +        uint16_t insn)
> +{
> +    if (a->nzuimm == 0) {
> +        /* Reserved in ISA */
> +        gen_exception_illegal(ctx);
> +        return true;

This should definitely be return false, as that kind of instruction overlap is
exactly what the return value is for.  (There is no current support for
overlapping insn patterns, but it is planned.)

> +static bool trans_c_flw_ld(DisasContext *ctx, arg_c_flw_ld *a, uint16_t insn)
> +{
> +#ifdef TARGET_RISCV32
> +    /* C.FLW ( RV32FC-only ) */
> +    arg_c_lw *tmp = g_new0(arg_c_lw, 1);
> +    extract_cl_w(tmp, insn);
> +    arg_flw arg = { .rd = tmp->rd, .rs1 = tmp->rs1, .imm = tmp->uimm };
> +    return trans_flw(ctx, &arg, insn);
> +#else
> +    /* C.LD ( RV64C/RV128C-only ) */
> +    arg_c_fld *tmp = g_new0(arg_c_fld, 1);
> +    extract_cl_d(tmp, insn);
> +    arg_ld arg = { .rd = tmp->rd, .rs1 = tmp->rs1, .imm = tmp->uimm };
> +    return trans_ld(ctx, &arg, insn);
> +#endif

Oh I see what you're after wrt manual parsing above.
But why g_new0 and missing free.  Why not stack allocation?

> +static int64_t ex_rvc_register(int reg)

return type should be int.


r~
