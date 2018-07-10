Received: from eggs.gnu.org ([2001:4830:134:3::10]:60779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fcrtZ-0004cb-9j
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 08:37:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fcrtV-00022Z-Uj
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 08:37:29 -0400
Received: from mail-eopbgr730093.outbound.protection.outlook.com
	([40.107.73.93]:28427
	helo=NAM05-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fcrtV-00021c-Hf
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 08:37:25 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 10 Jul 2018 12:37:21 +0000
Message-ID: <BN7PR08MB4868D2C292BDD44B45EEF488C65B0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1531169431-10772-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1531169431-10772-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1531169431-10772-2-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 01/33] target/mips: Add nanoMIPS OPCODE
 table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "f4bug@amsat.org" <f4bug@amsat.org>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> Subject: [PATCH v2 01/33] target/mips: Add nanoMIPS OPCODE table
>
> From: Yongbok Kim <yongbok.kim@mips.com>
>
> nanoMIPS opcodes are organized by so-called instruction pools.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/mips-defs.h |   4 +
>  target/mips/translate.c | 674 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 678 insertions(+)
>

I think changes in target/mips/mips-defs.h shoudl be in a separate patch.

For opcodes, a comment explaining instruction pool organization would be he=
lpful.

Also, there is no distinction between opcode constants for instruction and =
instuction pools: they all begin NM_ plus instruction/pool mnemonic. If the=
re is enough time, that should be corrected so that trere are NM_IN_XXX and=
 NM_PL_YYY opcodes, let's say.

> diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
> index d239069..eadc1d8 100644
> --- a/target/mips/mips-defs.h
> +++ b/target/mips/mips-defs.h
> @@ -39,6 +39,7 @@
>  #define   ISA_MIPS64R5  0x00001000
>  #define   ISA_MIPS32R6  0x00002000
>  #define   ISA_MIPS64R6  0x00004000
> +#define   ISA_NANOMIPS32  0x00008000
>
>  /* MIPS ASEs. */
>  #define   ASE_MIPS16    0x00010000
> @@ -87,6 +88,9 @@
>  #define CPU_MIPS32R6 (CPU_MIPS32R5 | ISA_MIPS32R6)
>  #define CPU_MIPS64R6 (CPU_MIPS64R5 | CPU_MIPS32R6 | ISA_MIPS64R6)
>
> +/* MIPS Technologies "nanoMIPS" */
> +#define CPU_NANOMIPS32 (CPU_MIPS32R6 | ISA_NANOMIPS32)
> +
>  /* Strictly follow the architecture standard:
>     - Disallow "special" instruction handling for PMON/SPIM.
>     Note that we still maintain Count/Compare to match the host clock. */
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index de0d55b..3ccf6fc 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -15644,6 +15644,680 @@ static int decode_micromips_opc (CPUMIPSState *=
env, DisasContext > *ctx)
>      return 2;
>  }
>
> +/*
> + *
> + * nanoMIPS opcodes
> + *
> + */
> +
> +/* MAJOR, P16, and P32 pools opcodes */
> +enum {
> +    NM_P_ADDIU      =3D 0x00,
> +    NM_ADDIUPC      =3D 0x01,
> +    NM_MOVE_BALC    =3D 0x02,
