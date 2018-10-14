Received: from eggs.gnu.org ([2001:4830:134:3::10]:49906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gBjSe-0007NJ-D9
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 12:41:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gBjSb-0000K5-8N
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 12:41:48 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:56669)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gBjSb-0000Iz-11
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 12:41:45 -0400
Date: Sun, 14 Oct 2018 18:41:40 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20181014164140.GB2319@sx9>
References: <20181014142928.2784-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181014142928.2784-1-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH] target/mips: Support Toshiba specific
 three-operand MADD and MADDU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: "Maciej W . Rozycki" <macro@linux-mips.org>, Richard Henderson <richard.henderson@linaro.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>

Hi Philippe,

> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -3843,6 +3843,46 @@ static void gen_mul_txx9(DisasContext *ctx, uint32_t opc,

What about documenting MADD and MADDU along with MULT and MULTU in the
note above?

> +    case OPC_MADD:

This case is unreachable, because gen_mul_txx9 will never be called for
OPC_MADD.

> +            TCGv_i64 t2 = tcg_temp_new_i64();
> +            TCGv_i64 t3 = tcg_temp_new_i64();

The MADD (and MADDU) instructions are defined to multiply 32-bit integers
in the C790 manual. Are 64-bit integers required to perform this with QEMU?

> +            gen_move_low32(cpu_LO[acc], t2);
> +            gen_move_high32(cpu_HI[acc], t2);
> +            if (rd) {
> +                gen_move_low32(cpu_gpr[rd], t2);

Are LO, HI and GPR[rd] sign-extended to 64 bits when required?

> +    case OPC_MADDU:

As above, this case is unreachable, because gen_mul_txx9 will never be
called for OPC_MADDU.

> +            gen_move_low32(cpu_LO[acc], t2);
> +            gen_move_high32(cpu_HI[acc], t2);
> +            if (rd) {
> +                gen_move_low32(cpu_gpr[rd], t2);

As above, are LO, HI and GPR[rd] sign-extended to 64 bits when required?

Fredrik
