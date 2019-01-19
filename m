Received: from eggs.gnu.org ([209.51.188.92]:39486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkyWV-0008CU-Ie
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 16:51:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkyWU-0007Yh-MZ
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 16:51:27 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:40908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkyWU-0007QN-HC
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 16:51:26 -0500
Received: by mail-pg1-x542.google.com with SMTP id z10so7713227pgp.7
	for <qemu-devel@nongnu.org>; Sat, 19 Jan 2019 13:51:12 -0800 (PST)
References: <20190118131456.32451-1-kbastian@mail.uni-paderborn.de>
	<20190118131456.32451-13-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8eb4c646-4580-c2f0-653c-55a2350a6309@linaro.org>
Date: Sun, 20 Jan 2019 08:51:04 +1100
MIME-Version: 1.0
In-Reply-To: <20190118131456.32451-13-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 12/35] target/riscv: Convert RV32F insns
 to decodetree
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
> +static bool trans_fsgnjn_s(DisasContext *ctx, arg_fsgnjn_s *a)
> +{
> +    REQUIRE_FPU;
> +    if (a->rs1 == a->rs2) { /* FNEG */
> +        tcg_gen_xori_i64(cpu_fpr[a->rd], cpu_fpr[a->rs1], INT32_MIN);
> +    } else {
> +        TCGv_i64 t0 = tcg_temp_new_i64();
> +        tcg_gen_not_i64(t0, cpu_fpr[a->rs2]);
> +        tcg_gen_deposit_i64(cpu_fpr[a->rd], t0, cpu_fpr[a->rs1], 0, 31);
> +        tcg_temp_free_i64(t0);
> +    }
> +    return true;
> +}
> +
> +static bool trans_fsgnjx_s(DisasContext *ctx, arg_fsgnjx_s *a)
> +{
> +    REQUIRE_FPU;
> +    if (a->rs1 == a->rs2) { /* FABS */
> +        tcg_gen_andi_i64(cpu_fpr[a->rd], cpu_fpr[a->rs1], ~INT32_MIN);

Not an issue with this patch set, since you are just moving existing code.

However, while I'm thinking about it:

It just occured to me that these uses of INT32_MIN are not ideal, in that they
are (signed) -0x80000000 and not 0x0000000080000000ull.

In particular, FNEG will remove the NaN-box of the 32-bit value.

Similarly with the construction of fsgnjn_s wrt not + deposit.  It might be
better to simply xor the sign bit rather than not the whole 64-bit value.

Have you tried using RISU to compare these sorts of results vs real hardware,
or spike?


r~
