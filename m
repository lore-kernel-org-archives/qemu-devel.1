Received: from eggs.gnu.org ([209.51.188.92]:44606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gl1r4-0000tE-FY
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 20:24:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gl1r3-00048o-PH
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 20:24:54 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41725)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gl1r3-00048A-Bo
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 20:24:53 -0500
Received: by mail-pg1-x542.google.com with SMTP id m1so7837284pgq.8
	for <qemu-devel@nongnu.org>; Sat, 19 Jan 2019 17:24:53 -0800 (PST)
References: <20190118131456.32451-1-kbastian@mail.uni-paderborn.de>
	<20190118131456.32451-25-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <50d95ed2-d8a4-0a05-f67c-0c18b5e87a33@linaro.org>
Date: Sun, 20 Jan 2019 12:24:44 +1100
MIME-Version: 1.0
In-Reply-To: <20190118131456.32451-25-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 24/35] target/riscv: Move
 gen_arith_imm() decoding into trans_* functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, sagark@eecs.berkeley.edu, palmer@sifive.com, Alistair.Francis@wdc.com
Cc: qemu-riscv@nongnu.org, peer.adelt@hni.uni-paderborn.de, qemu-devel@nongnu.org

On 1/19/19 12:14 AM, Bastian Koppelmann wrote:
>  static bool trans_slli(DisasContext *ctx, arg_slli *a)
>  {
> -    gen_arith_imm(ctx, OPC_RISC_SLLI, a->rd, a->rs1, a->shamt);
> +    if (a->rd != 0) {
> +        TCGv t = tcg_temp_new();
> +        gen_get_gpr(t, a->rs1);
> +
> +        if (a->shamt >= TARGET_LONG_BITS) {
> +            return false;
> +        }

I think the shmat test should be first, so that

	slli	r0, r1, 99

produces SIGILL instead of translating to a nop.

>  static bool trans_sraiw(DisasContext *ctx, arg_sraiw *a)
>  {
> -    gen_arith_imm(ctx, OPC_RISC_SHIFT_RIGHT_IW , a->rd, a->rs1,
> -                  a->shamt | 0x400);
> +    TCGv t = tcg_temp_new();
> +    gen_get_gpr(t, a->rs1);
> +    tcg_gen_sextract_tl(t, t, a->shamt, 32 - a->shamt);
> +    /* sign-extend for W instructions */
> +    tcg_gen_ext32s_tl(t, t);

Sign extension of a sign-extracted value?


r~
