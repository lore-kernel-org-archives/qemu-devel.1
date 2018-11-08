Received: from eggs.gnu.org ([2001:4830:134:3::10]:39715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gKhRU-0004Tw-Qe
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:21:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gKhNJ-00087h-GT
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:17:27 -0500
Received: from mail-cys01nam02on0138.outbound.protection.outlook.com
	([104.47.37.138]:2704
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gKhNJ-00086d-7v
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:17:21 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 8 Nov 2018 10:17:16 +0000
Message-ID: <BN6PR2201MB1251FFDEF482BBFBCC9FF1D5C6C50@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <cover.1541616663.git.noring@nocrew.org>,
	<b7502a7707b8b75d500c96e81a76b03fdd67865c.1541616663.git.noring@nocrew.org>
In-Reply-To: <b7502a7707b8b75d500c96e81a76b03fdd67865c.1541616663.git.noring@nocrew.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 3/6] target/mips: Fix HI[ac] and LO[ac]
 32-bit truncation with MIPS64 DSP ASE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>, Aurelien Jarno <aurelien@aurel32.net>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: =?iso-8859-1?Q?J=FCrgen_Urban?= <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, Jia Liu <proljc@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> From: Fredrik Noring <noring@nocrew.org>
> Sent: Wednesday, November 7, 2018 8:18 PM
> To: Aleksandar Markovic; Aurelien Jarno; Philippe Mathieu-Daud=E9; Richar=
d Henderson
> Cc: J=FCrgen Urban; Maciej W. Rozycki; Jia Liu; qemu-devel@nongnu.org
> Subject: [PATCH v2 3/6] target/mips: Fix HI[ac] and LO[ac] 32-bit truncat=
ion with > MIPS64 DSP ASE
>=20
> This change removes the 32-bit truncation of the HI[ac] and LO[ac]
> special purpose registers when ac range from 1 to 3 for the instructions
> MFHI, MFLO, MTHI and MTLO. The "MIPS Architecture for Programmers Volume
> IV-e: MIPS DSP Module for MIPS64 Architecture" manual specifies that all
> 64 bits are copied in all cases:
>=20
>    MFHI: GPR[rd]63..0 <- HI[ac]63..0
>    MFLO: GPR[rd]63..0 <- LO[ac]63..0
>    MTHI: HI[ac]63..0 <- GPR[rs]63..0
>    MTLO: LO[ac]63..0 <- GPR[rs]63..0
>=20
> Fixes: 4133498f8e53 ("Use correct acc value to index cpu_HI/cpu_LO rather=
 than using > a fix number")
> Cc: Jia Liu <proljc@gmail.com>
> Reported-by: Maciej W. Rozycki <macro@linux-mips.org>
> Signed-off-by: Fredrik Noring <noring@nocrew.org>
> ---
>  target/mips/translate.c | 36 ++++--------------------------------
>  1 file changed, 4 insertions(+), 32 deletions(-)
>=20

Hi, Fredrik.

Thanks for this follow-up patch. I will consider it, even if I perhaps don'=
t include it for 3.1. Let's see if Jia has some comments.

Aleksandar

> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 3ddd70043a..19ae7d2f1c 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -4409,49 +4409,21 @@ static void gen_HILO(DisasContext *ctx, uint32_t =
opc, int > acc, int reg)
>=20
>      switch (opc) {
>      case OPC_MFHI:
> -#if defined(TARGET_MIPS64)
> -        if (acc !=3D 0) {
> -            tcg_gen_ext32s_tl(cpu_gpr[reg], cpu_HI[acc]);
> -        } else
> -#endif
> -        {
> -            tcg_gen_mov_tl(cpu_gpr[reg], cpu_HI[acc]);
> -        }
> +        tcg_gen_mov_tl(cpu_gpr[reg], cpu_HI[acc]);
>          break;
>      case OPC_MFLO:
> -#if defined(TARGET_MIPS64)
> -        if (acc !=3D 0) {
> -            tcg_gen_ext32s_tl(cpu_gpr[reg], cpu_LO[acc]);
> -        } else
> -#endif
> -        {
> -            tcg_gen_mov_tl(cpu_gpr[reg], cpu_LO[acc]);
> -        }
> +        tcg_gen_mov_tl(cpu_gpr[reg], cpu_LO[acc]);
>          break;
>      case OPC_MTHI:
>          if (reg !=3D 0) {
> -#if defined(TARGET_MIPS64)
> -            if (acc !=3D 0) {
> -                tcg_gen_ext32s_tl(cpu_HI[acc], cpu_gpr[reg]);
> -            } else
> -#endif
> -            {
> -                tcg_gen_mov_tl(cpu_HI[acc], cpu_gpr[reg]);
> -            }
> +            tcg_gen_mov_tl(cpu_HI[acc], cpu_gpr[reg]);
>          } else {
>              tcg_gen_movi_tl(cpu_HI[acc], 0);
>          }
>          break;
>      case OPC_MTLO:
>          if (reg !=3D 0) {
> -#if defined(TARGET_MIPS64)
> -            if (acc !=3D 0) {
> -                tcg_gen_ext32s_tl(cpu_LO[acc], cpu_gpr[reg]);
> -            } else
> -#endif
> -            {
> -                tcg_gen_mov_tl(cpu_LO[acc], cpu_gpr[reg]);
> -            }
> +            tcg_gen_mov_tl(cpu_LO[acc], cpu_gpr[reg]);
>          } else {
>              tcg_gen_movi_tl(cpu_LO[acc], 0);
>          }
> --
> 2.18.1
>=20
> =
