Received: from eggs.gnu.org ([209.51.188.92]:54309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gjVtS-0002rV-Fp
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:05:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gjVtM-0001p9-FS
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:05:04 -0500
Received: from mail-eopbgr710106.outbound.protection.outlook.com
	([40.107.71.106]:36791
	helo=NAM05-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gjVtE-0000x3-4e
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:04:54 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 15 Jan 2019 21:03:45 +0000
Message-ID: <BN6PR2201MB12516C7D2E235DA81812DDF0C6810@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <cover.1547403692.git.noring@nocrew.org>,
	<781155aaf175ea20903c12e26316ea40085457bb.1547403692.git.noring@nocrew.org>
In-Reply-To: <781155aaf175ea20903c12e26316ea40085457bb.1547403692.git.noring@nocrew.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/9] target/mips: Require TARGET_MIPS64 for
 R5900 multimedia instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>, Aurelien Jarno <aurelien@aurel32.net>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: =?iso-8859-1?Q?J=FCrgen_Urban?= <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> From: Fredrik Noring <noring@nocrew.org>
> Sent: Sunday, January 13, 2019 8:02 PM
> To: Aleksandar Markovic; Aurelien Jarno; Philippe Mathieu-Daud=E9
> Cc: J=FCrgen Urban; Maciej W. Rozycki; qemu-devel@nongnu.org
> Subject: [PATCH 1/9] target/mips: Require TARGET_MIPS64 for R5900 multime=
dia instructions
>=20
> The R5900 MMIs operate on 128-bit registers that will be split into
> two halves: lower 64-bit GPRs and upper 64-bit MMRs. The MMIs will
> therefore be left unimplemented in 32-bit mode with the o32 ABI.
>=20
> Signed-off-by: Fredrik Noring <noring@nocrew.org>
> ---
>  target/mips/translate.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
>

Sorry, I have to disagree with this. Processor model must stay the same, an=
d
Linux ABI should not affect, for example, the number and size of processor
registers - just like it is the case in reality.

I recommend to you to accept the mindset that QEMU is not a part of some
toolchain in a wide sense of this word.

QEMU is an independent software tool - it is for example, a compiler-agnost=
ic
tool, and the only connection between a compiler and QEMU is the processor
documentation - and this is the reason they work together so well. They sho=
uldn't
be "tweaked" and "integrated" to work together - both QEMU and compiler sho=
uld
rely only on the processor specification, and should not know anything abou=
t the
other side.

Similar reason can be applied to ABI, QEMU Linux user mode ABI obviously
deals with specifics of ABIs, but should not touch processor model. Process=
or
model should not depend on conventions of any ABI. The fact that, for examp=
le,
some ABI "promises" that it will not use, let's say, some registers or inst=
ructions
is irrelevant to QEMU.

My advice for you is to focus on n32 at the time being.

o32 can be implemented with the same 64-bit processor model, but in a much
different way that you attempted some time ago. To avoid waste of our energ=
y
and time, I am suggesting that we finish n32, and think of o32 in future.

Thanks, and hope you understand my points, and please accept my advices.

Aleksandar
=20
>=20
>=20
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 057aaf9a44..a538351032 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -27218,6 +27218,7 @@ static void decode_opc_special3_legacy(CPUMIPSSta=
te *env, > DisasContext *ctx)
>      }
>  }
>=20
> +#if defined(TARGET_MIPS64)
>  static void decode_mmi0(CPUMIPSState *env, DisasContext *ctx)
>  {
>      uint32_t opc =3D MASK_MMI0(ctx->opcode);
> @@ -27351,6 +27352,7 @@ static void decode_mmi3(CPUMIPSState *env, DisasC=
ontext *ctx)
>          break;
>      }
>  }
> +#endif /* defined(TARGET_MIPS64) */
>=20
>  static void decode_mmi(CPUMIPSState *env, DisasContext *ctx)
>  {
> @@ -27360,18 +27362,6 @@ static void decode_mmi(CPUMIPSState *env, DisasC=
ontext *ctx)
>      int rd =3D extract32(ctx->opcode, 11, 5);
>=20
>      switch (opc) {
> -    case MMI_OPC_CLASS_MMI0:
> -        decode_mmi0(env, ctx);
> -        break;
> -    case MMI_OPC_CLASS_MMI1:
> -        decode_mmi1(env, ctx);
> -        break;
> -    case MMI_OPC_CLASS_MMI2:
> -        decode_mmi2(env, ctx);
> -        break;
> -    case MMI_OPC_CLASS_MMI3:
> -        decode_mmi3(env, ctx);
> -        break;
>      case MMI_OPC_MULT1:
>      case MMI_OPC_MULTU1:
>      case MMI_OPC_MADD:
> @@ -27392,6 +27382,7 @@ static void decode_mmi(CPUMIPSState *env, DisasCo=
ntext *ctx)
>      case MMI_OPC_MFHI1:
>          gen_HILO1_tx79(ctx, opc, rd);
>          break;
> +#if defined(TARGET_MIPS64)
>      case MMI_OPC_PLZCW:         /* TODO: MMI_OPC_PLZCW */
>      case MMI_OPC_PMFHL:         /* TODO: MMI_OPC_PMFHL */
>      case MMI_OPC_PMTHL:         /* TODO: MMI_OPC_PMTHL */
> @@ -27403,6 +27394,19 @@ static void decode_mmi(CPUMIPSState *env, DisasC=
ontext *ctx)
>      case MMI_OPC_PSRAW:         /* TODO: MMI_OPC_PSRAW */
>          generate_exception_end(ctx, EXCP_RI);    /* TODO: MMI_OPC_CLASS_=
MMI */
>          break;
> +    case MMI_OPC_CLASS_MMI0:
> +        decode_mmi0(env, ctx);
> +        break;
> +    case MMI_OPC_CLASS_MMI1:
> +        decode_mmi1(env, ctx);
> +        break;
> +    case MMI_OPC_CLASS_MMI2:
> +        decode_mmi2(env, ctx);
> +        break;
> +    case MMI_OPC_CLASS_MMI3:
> +        decode_mmi3(env, ctx);
> +        break;
> +#endif
>      default:
>          MIPS_INVAL("TX79 MMI class");
>          generate_exception_end(ctx, EXCP_RI);
> --
> 2.19.2
