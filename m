Received: from eggs.gnu.org ([2001:4830:134:3::10]:54062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEsad-0001GP-E3
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 05:03:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEsaZ-0001Fb-CL
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 05:03:03 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50634)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEsaY-0001D0-67
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 05:02:59 -0400
Received: by mail-wm1-x342.google.com with SMTP id i8-v6so907164wmg.0
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 02:02:56 -0700 (PDT)
References: <20181020071451.27808-1-kbastian@mail.uni-paderborn.de>
	<20181020071451.27808-27-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <477600b9-2d63-c6c0-b28f-cd50bf8a4007@linaro.org>
Date: Tue, 23 Oct 2018 10:02:52 +0100
MIME-Version: 1.0
In-Reply-To: <20181020071451.27808-27-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 26/29] target/riscv: Remove manual
 decoding of RV32/64M insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, mjc@sifive.com, sagark@eecs.berkeley.edu, palmer@sifive.com
Cc: peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, qemu-devel@nongnu.org

On 10/20/18 8:14 AM, Bastian Koppelmann wrote:
>  static bool trans_mulh(DisasContext *ctx, arg_mulh *a, uint32_t insn)
>  {
> -    gen_arith(ctx, OPC_RISC_MULH, a->rd, a->rs1, a->rs2);
> +    TCGv source1 = tcg_temp_new();
> +    TCGv source2 = tcg_temp_new();
> +    gen_get_gpr(source1, a->rs1);
> +    gen_get_gpr(source2, a->rs2);
> +
> +    tcg_gen_muls2_tl(source2, source1, source1, source2);

If you wanted, you could probably put this line into a function to keep using
trans_arith.  But this is ok too.

>  static bool trans_mulw(DisasContext *ctx, arg_mulw *a, uint32_t insn)
>  {
> -    gen_arith(ctx, OPC_RISC_MULW, a->rd, a->rs1, a->rs2);
> -    return true;
> +#ifdef TARGET_RISCV64
> +    return trans_arith(ctx, a, &tcg_gen_mul_tl);
> +#else
> +    return false;
> +#endif

This is wrong; you need a final sign-extend.

> +#ifdef TARGET_RISCV64
> +static bool gen_arith_w(DisasContext *ctx, arg_arith *a,
> +                        void(*func)(TCGv, TCGv, TCGv))
> +{
> +    TCGv source1, source2;
> +    source1 = tcg_temp_new();
> +    source2 = tcg_temp_new();
> +
> +    gen_get_gpr(source1, a->rs1);
> +    gen_get_gpr(source2, a->rs2);
> +    tcg_gen_ext32s_tl(source1, source1);
> +    tcg_gen_ext32s_tl(source2, source2);
> +
> +    (*func)(source1, source1, source2);
> +
> +    gen_set_gpr(a->rd, source1);
> +    tcg_temp_free(source1);
> +    tcg_temp_free(source2);
> +    return true;
> +}
> +#endif

This appears to have been extracted only from, and is only applicable to, the
word division routines.  It probably should be renamed lest someone think that
it could be used for addw and mulw, which require the output be extended.


r~
