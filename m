Received: from eggs.gnu.org ([208.118.235.92]:41486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gEef1-0002k8-IU
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:10:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gEeew-0006Vs-Fm
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:10:39 -0400
Received: from mail-dm3nam03on0104.outbound.protection.outlook.com
	([104.47.41.104]:6141
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gEeew-0006US-2z
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 14:10:34 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 22 Oct 2018 18:10:28 +0000
Message-ID: <BN6PR2201MB12517EFDBB682826E06B8998C6F40@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <cover.1540134918.git.noring@nocrew.org>
	<BN6PR2201MB125165723113459889A6EC59C6F40@BN6PR2201MB1251.namprd22.prod.outlook.com>,
	<20181022172343.GB2331@sx9>
In-Reply-To: <20181022172343.GB2331@sx9>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v8 00/38] target/mips: Limited support for
 the R5900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>, "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>, =?iso-8859-1?Q?J=FCrgen_Urban?= <JuergenUrban@gmx.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> From: Fredrik Noring <noring@nocrew.org>
>=20
> Subject: Re: [PATCH v8 00/38] target/mips: Limited support for the R5900
>=20
> Many thanks, Aleksandar,
>=20
> > I added ASE_MMI flag along with INSN_R5900, I think this fits better in
> > the overall MIPS for QEMU design.
>=20
> Maciej -- can we add "MMI" under "ASEs implemented" in the kernel too,
> even if it is a vendor-specific architecture extension that normally
> isn't counted as an ASE? QEMU simply calls these "vendor specific ASEs".
>=20
> Aleksandar -- please or ASE_MMI to insn_flags here:
>=20
> --- a/target/mips/translate_init.inc.c
> +++ b/target/mips/translate_init.inc.c
> @@ -466,7 +466,7 @@ const mips_def_t mips_defs[] =3D
>  #endif /* !CONFIG_USER_ONLY */
>          .SEGBITS =3D 32,
>          .PABITS =3D 32,
> -        .insn_flags =3D CPU_R5900,
> +        .insn_flags =3D CPU_R5900 | ASE_MMI,
>          .mmu_type =3D MMU_TYPE_R4000,
>      },
>      {
>=20

Hi, Fredrik.

I understood what you said about ASE_MMI and other changes you want to be i=
ncluded.

Pull request with 32 patches from this series is already sent, and I would =
like to avoid sending v2 of that request. Let's wait for some time until th=
e pull request is hopefully accepted. There will be most likely another one=
 at the beginning of the next week.

We are appoaching QEMU 3.1 soft freeze (Oct 30), and at this point we would=
 like to stabilize the code, and to integrate only crucial patches. I sugge=
st that you create a new series "target/mips: Amend R5900 support". It shou=
ld be based on the code submitted in the pull request. Place the most cruci=
al patches as the first ones, at the beginning of the series. Less importan=
t at the end. FPU changes are too risky at this stage od 3.1 development cy=
cle, and I would leave them for QEMU 3.2+.

Regards and thanks again,
Aleksandar


> Strictly speaking, MADD, MADDU, MULT, MULTU, MULT1, MULTU1, DIV1, DIVU1,
> MADD1, MADDU1, MFHI1, MFLO1, MTHI1 and MTLO1 are not part of what the
> Toshiba TX System RISC TX79 Core Architecture manual specifies as
> "Multimedia Instructions", section B.3.2, on page B-3, even though
> their opcodes are covered by TX79_CLASS_MMI and the decode_tx79_mmi
> function. Can we adjust ASE_MMI for QEMU accordingly?
>=20
> Also, doesn't it make sense to cover LQ and SQ with ASE_MMI as well, as
> those two really are MMIs?
>=20
> Finally, as far as I know, the MMIs cannot be disabled on R5900 hardware.
>=20
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -26099,7 +26099,7 @@ static void decode_opc(CPUMIPSState *env, DisasCo=
ntext *ctx)
>          }
>          break;
>      case OPC_SPECIAL3:
> -        if (ctx->insn_flags & INSN_R5900) {
> +        if ((ctx->insn_flags & INSN_R5900) && (ctx->insn_flags & ASE_MMI=
)) {
>              decode_tx79_sq(env, ctx);    /* TX79_SQ */
>          } else {
>              decode_opc_special3(env, ctx);
> @@ -26763,7 +26763,7 @@ static void decode_opc(CPUMIPSState *env, DisasCo=
ntext *ctx)
>          }
>          break;
>      case OPC_MSA: /* OPC_MDMX */
> -        if (ctx->insn_flags & INSN_R5900) {
> +        if ((ctx->insn_flags & INSN_R5900) && (ctx->insn_flags & ASE_MMI=
)) {
>              decode_tx79_lq(env, ctx);    /* TX79_LQ */
>          } else {
>              /* MDMX: Not implemented. */
>=20
> > I experienced some build errors (see the end of this mail), so I had to
> > exclude some patches, but all others are fine, and had my "Reviewed-by"=
.
> > 32 patches will be included in the next MIPS queue.
>=20
> Ah, I didn't test the 64-bit build on the MADD[U][1] instructions. I will
> look into them and post updated patches.
>=20
> Regarding the R5900 FPU: It appears reasonable to introduce an ELF ABI
> variant for the nonstandard R5900 FPU. A testsuite covering the anomalies
> seems to be needed as well. Careful verification on hardware is needed.
> I think it's probably best to keep the R5900 FPU disabled in QEMU until
> these things have been sorted out.
>=20
> I discovered that I lost the disassembly of MULT1 and MULTU1 in v8, as
> shown in the attached patch below. This small change belongs to commit
> bebf09ef3977 ("target/mips: Support R5900 three-operand MULT1 and MULTU1
> instructions") in your tags/mips-queue-oct-2018-part-2. Please apply:
>=20
> --- a/disas/mips.c
> +++ b/disas/mips.c
> @@ -2736,10 +2736,14 @@ const struct mips_opcode mips_builtin_opcodes[] =
=3D
>  {"mult",    "s,t",      0x00000018, 0xfc00ffff, RD_s|RD_t|WR_HILO|IS_M, =
0,             > I1      },
>  {"mult",    "7,s,t",   0x00000018, 0xfc00e7ff, WR_a|RD_s|RD_t,         0=
,              > D33     },
>  {"mult",    "d,s,t",    0x00000018, 0xfc0007ff, RD_s|RD_t|WR_HILO|WR_d|I=
S_M, > 0,                G1      },
> +{"mult1",   "s,t",      0x70000018, 0xfc00ffff, RD_s | RD_t | WR_HILO | =
IS_M, 0, EE },
> +{"mult1",   "d,s,t",    0x70000018, 0xfc0007ff, WR_d | RD_s | RD_t | WR_=
HILO | IS_M, 0, > EE },
>  {"multp",   "s,t",     0x00000459, 0xfc00ffff, RD_s|RD_t|MOD_HILO,     0=
,              > SMT     },
>  {"multu",   "s,t",      0x00000019, 0xfc00ffff, RD_s|RD_t|WR_HILO|IS_M, =
0,             > I1      },
>  {"multu",   "7,s,t",   0x00000019, 0xfc00e7ff, WR_a|RD_s|RD_t,         0=
,              > D33     },
>  {"multu",   "d,s,t",    0x00000019, 0xfc0007ff, RD_s|RD_t|WR_HILO|WR_d|I=
S_M, > 0,                G1      },
> +{"multu1",  "s,t",      0x70000019, 0xfc00ffff, RD_s | RD_t | WR_HILO | =
IS_M, 0, EE },
> +{"multu1",  "d,s,t",    0x70000019, 0xfc0007ff, WR_d | RD_s | RD_t | WR_=
HILO | IS_M, 0, > EE },
>  {"mulu",    "d,s,t",   0x00000059, 0xfc0007ff, RD_s|RD_t|WR_HILO|WR_d, 0=
,              > N5      },
>  {"neg",     "d,w",     0x00000022, 0xffe007ff, WR_d|RD_t,              0=
,              > I1      }, /* sub 0 */
>  {"negu",    "d,w",     0x00000023, 0xffe007ff, WR_d|RD_t,              0=
,              > I1      }, /* subu 0 */
>=20
> Fredrik
> =
