Received: from eggs.gnu.org ([2001:4830:134:3::10]:36188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHysV-0007TN-Hh
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:22:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHysQ-0002nM-DN
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:22:19 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:39763)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gHysP-0002mY-4k
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 18:22:14 -0400
Received: by mail-ed1-x543.google.com with SMTP id e5-v6so14994749eds.6
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 15:22:12 -0700 (PDT)
References: <20181031132029.4887-1-kbastian@mail.uni-paderborn.de>
	<20181031132029.4887-25-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <16797a6b-1b0b-1f83-1aef-5cc5a8ff90e6@linaro.org>
Date: Wed, 31 Oct 2018 22:18:44 +0000
MIME-Version: 1.0
In-Reply-To: <20181031132029.4887-25-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 24/35] target/riscv: Move
 gen_arith_imm() decoding into trans_* functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, mjc@sifive.com, sagark@eecs.berkeley.edu, palmer@sifive.com, Alistair.Francis@wdc.com
Cc: peer.adelt@hni.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org

On 10/31/18 1:20 PM, Bastian Koppelmann wrote:
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
> +        tcg_gen_shli_tl(t, t, a->shamt);
> +
> +        gen_set_gpr(a->rd, t);
> +        tcg_temp_free(t);
> +    } /* NOP otherwise */
>      return true;
>  }
>  
>  static bool trans_srli(DisasContext *ctx, arg_srli *a)
>  {
> -    gen_arith_imm(ctx, OPC_RISC_SHIFT_RIGHT_I, a->rd, a->rs1, a->shamt);
> +    if (a->rd != 0) {
> +        TCGv t = tcg_temp_new();
> +        gen_get_gpr(t, a->rs1);
> +        tcg_gen_shri_tl(t, t, a->shamt);
> +        gen_set_gpr(a->rd, t);
> +        tcg_temp_free(t);
> +    } /* NOP otherwise */
>      return true;
>  }
>  
>  static bool trans_srai(DisasContext *ctx, arg_srai *a)
>  {
> -    gen_arith_imm(ctx, OPC_RISC_SHIFT_RIGHT_I, a->rd, a->rs1, a->shamt | 0x400);
> +    if (a->rd != 0) {
> +        TCGv t = tcg_temp_new();
> +        gen_get_gpr(t, a->rs1);
> +        tcg_gen_sari_tl(t, t, a->shamt);
> +        gen_set_gpr(a->rd, t);
> +        tcg_temp_free(t);
> +    } /* NOP otherwise */
>      return true;
>  }

Surely the shri and sari functions need the same shamt >= TARGET_LONG_BITS
check as slli.  Otherwise RV32 shri should definitely produce an assert in
tcg_gen_shri_tl.

I did wonder about changing the decode of the shift functions such that only
the top two bits of the imm are reserved for secondary parsing of the shift
type, and the other 10 bits are passed down into trans_foo.  At which point the
TARGET_LONG_BITS check takes care of other illegalities.

Which means that the parsing for slli and slliw are identical, and also that
for the far future when RV128 is a thing, we don't have to change the parsing.


r~
