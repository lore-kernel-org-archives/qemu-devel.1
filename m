Received: from eggs.gnu.org ([2001:4830:134:3::10]:52399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBPzr-0006Pp-SE
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 15:54:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBPzp-0006pf-5q
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 15:54:47 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b]:39315)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gBPzo-0006pB-Oz
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 15:54:45 -0400
Received: by mail-pl1-x62b.google.com with SMTP id w14-v6so7428756plp.6
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 12:54:44 -0700 (PDT)
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
	<20181012173047.25420-23-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ef00c2d5-04d3-d68f-8c36-52f48c0c10da@linaro.org>
Date: Sat, 13 Oct 2018 12:54:40 -0700
MIME-Version: 1.0
In-Reply-To: <20181012173047.25420-23-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 22/28] target/riscv: Move gen_arith_imm()
 decoding into trans_* functions
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
>  static bool trans_slliw(DisasContext *ctx, arg_slliw *a, uint32_t insn)
>  {
> -    gen_arith_imm(ctx, OPC_RISC_SLLIW, a->rd, a->rs1, a->shamt);
> +    TCGv source1;
> +    source1 = tcg_temp_new();
> +    gen_get_gpr(source1, a->rs1);
> +
> +    tcg_gen_shli_tl(source1, source1, a->shamt);
> +    tcg_gen_ext32s_tl(source1, source1);
> +    gen_set_gpr(a->rd, source1);
> +
> +    tcg_temp_free(source1);
>      return true;
>  }

Now missing the TARGET_RISCV64 check.

> +static bool trans_arith_imm(DisasContext *ctx, arg_arith_imm *a,
> +                            void(*func)(TCGv, TCGv, TCGv))

gen_arith_imm.


r~
