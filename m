Received: from eggs.gnu.org ([2001:4830:134:3::10]:37898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fzfkW-0000tL-8h
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 06:18:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fzfkT-0002lk-2z
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 06:18:24 -0400
Received: from mail-eopbgr680106.outbound.protection.outlook.com
	([40.107.68.106]:40480
	helo=NAM04-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fzfkR-0002jU-UN
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 06:18:20 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 11 Sep 2018 10:18:15 +0000
Message-ID: <BN7PR08MB48680659BC5FC0C4DB998F7CC6040@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <20180909013444.18936-1-f4bug@amsat.org>,
	<20180909013444.18936-3-f4bug@amsat.org>
In-Reply-To: <20180909013444.18936-3-f4bug@amsat.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 2/2] target/mips: Add entries for the
 Toshiba's R3900 and R5900 cores
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, Fredrik Noring <noring@nocrew.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>

> From: Philippe Mathieu-Daud=E9 <philippe.mathieu.daude@gmail.com> on beha=
lf of Philippe > Mathieu-Daud=E9 <f4bug@amsat.org>
> Sent: Sunday, September 9, 2018 3:34 AM
> To: Fredrik Noring; Aleksandar Markovic
> Cc: Philippe Mathieu-Daud=E9; qemu-devel@nongnu.org; Richard Henderson; A=
urelien Jarno
> Subject: [PATCH 2/2] target/mips: Add entries for the Toshiba's R3900 and=
 R5900 cores
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  target/mips/mips-defs.h | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
> index c8e99791ad..9875bdac82 100644
> --- a/target/mips/mips-defs.h
> +++ b/target/mips/mips-defs.h
> @@ -56,6 +56,8 @@
>  #define                INSN_LOONGSON2E  0x20000000
>  #define                INSN_LOONGSON2F  0x40000000
>  #define                INSN_VR54XX     0x80000000
> +#define     INSN_R3900       0x100000000ULL
> +#define     INSN_R5900       0x200000000ULL
>=20
>  /* MIPS CPU defines. */
>  #define                CPU_MIPS1       (ISA_MIPS1)

I don't think we should add flags for not yet supported CPUs ot ASEs. (Corr=
esponding ELF flags in other headers are OK, since they originate from exte=
rnal headers - however, "insn_flags" is a purely internal QEMU construct.)

Instead, I would reorganize existing flags (as you, as well, indicated in a=
 previous message).

Let's say, something like this:


/*
 * insn_flags
 */

/*
 * bits 0-31 MIPS base instruction sets
 */=20
#define ISA_MIPS1         0x0000000000000001
#define ISA_MIPS2         0x0000000000000002
#define ISA_MIPS3         0x0000000000000004
#define ISA_MIPS4         0x0000000000000008
#define ISA_MIPS5         0x0000000000000010
#define ISA_MIPS32        0x0000000000000020
#define ISA_MIPS32R2      0x0000000000000040
#define ISA_MIPS64        0x0000000000000080
#define ISA_MIPS64R2      0x0000000000000100
#define ISA_MIPS32R3      0x0000000000000200
#define ISA_MIPS64R3      0x0000000000000400
#define ISA_MIPS32R5      0x0000000000000800
#define ISA_MIPS64R5      0x0000000000001000
#define ISA_MIPS32R6      0x0000000000002000
#define ISA_MIPS64R6      0x0000000000004000
#define ISA_NANOMIPS32    0x0000000000008000

/*
 * bits 32-47 MIPS ASEs
 */=20
#define ASE_MIPS16        0x0000000100000000
#define ASE_MIPS3D        0x0000000200000000
#define ASE_MDMX          0x0000000400000000
#define ASE_DSP           0x0000000800000000
#define ASE_DSPR2         0x0000001000000000
#define ASE_DSPR3         0x0000002000000000
#define ASE_MT            0x0000004000000000
#define ASE_SMARTMIPS     0x0000008000000000
#define ASE_MICROMIPS     0x0000010000000000
#define ASE_MSA           0x0000020000000000

/*
 * bits 48-55 vendor-specific base instruction sets
 */=20
#define	INSN_LOONGSON2E   0x0001000000000000
#define	INSN_LOONGSON2F   0x0002000000000000
#define	INSN_VR54XX	  0x0004000000000000

/*
 * bits 56-63 vendor-specific ASEs
 */=20

Notice that I inserted ASE_DSPR3, that was missing (there is an instruction=
 from DSP R3 already implemented, and needing this flag for correct availab=
ility control.).

INSN_R5900 would belong to the third category. ASE_MXU and ASE MXU2 (not ye=
t implemented in QEMU) from Igenic would be examples for the fourth categor=
y. The fourth category would be empty for now.

Thanks,
Aleksandar
