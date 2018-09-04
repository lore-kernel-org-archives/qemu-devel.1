Received: from eggs.gnu.org ([2001:4830:134:3::10]:60292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=778a5ce15=jancraig@amazon.com>)
	id 1fxCZX-0001Dj-Ev
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 10:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=778a5ce15=jancraig@amazon.com>)
	id 1fxCZU-0003UD-0u
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 10:44:51 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:49147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=778a5ce15=jancraig@amazon.com>)
	id 1fxCZT-0003TY-RW
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 10:44:47 -0400
From: "Janeczek, Craig" <jancraig@amazon.com>
Date: Tue, 4 Sep 2018 14:44:31 +0000
Message-ID: <1a16b26ca5234092b9a5d60082881a15@EX13D12UEA003.ant.amazon.com>
References: <20180830193019.20104-1-jancraig@amazon.com>,
	<20180830193019.20104-4-jancraig@amazon.com>
	<BN7PR08MB4868D242CAD42AB129B61EB5C60F0@BN7PR08MB4868.namprd08.prod.outlook.com>
In-Reply-To: <BN7PR08MB4868D242CAD42AB129B61EB5C60F0@BN7PR08MB4868.namprd08.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 3/9] target/mips: Split mips instruction
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, Richard Henderson <richard.henderson@linaro.org>

To clarify the OPC_MUL here is not an MXU instruction, this is the original=
 OPC_MUL that was in the special2 instruction set. The inclusion of this in=
struction in this switch statement is due to the suggested method of splitt=
ing up the mxu commands instruction handling switch statement from the orig=
inal special2 commands. Since there is no MXU command with the opcode suffi=
x of 0x02 there was not an instruction collision. Your other example is not=
 correct as there is an MXU instruction sharing the opcode suffix 0x00 (OPC=
_MXU_S32MADD) therefore the original OPC_MUL would not be used.

Remember that I did not arbitrarily make this instruction mapping, I just i=
mplemented the list of MXU opcodes. The confusion stems from the fact that =
these opcodes overlap with pre-existing instructions and do not consistentl=
y map original instruction to MXU instruction.=20

I have not been able to find a document to back this up. The only evidence =
I have is the existence of the OPC_MUL instruction in an MXU compiled binar=
y.

-----Original Message-----
From: Aleksandar Markovic <amarkovic@wavecomp.com>=20
Sent: Friday, August 31, 2018 2:40 PM
To: Janeczek, Craig <jancraig@amazon.com>; qemu-devel@nongnu.org
Cc: aurelien@aurel32.net; Petar Jovanovic <pjovanovic@wavecomp.com>; Richar=
d Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 3/9] target/mips: Split mips instruction handling

Hi, Craig,

> From: Craig Janeczek <jancraig@amazon.com>
> Sent: Thursday, August 30, 2018 9:30 PM
> To: qemu-devel@nongnu.org
> Cc: Aleksandar Markovic; aurelien@aurel32.net; Craig Janeczek
> Subject: [PATCH v4 3/9] target/mips: Split mips instruction handling
>=20
> Splits the instruction handling switch statement from the original=20
> legacy code.
>=20
> Signed-off-by: Craig Janeczek <jancraig@amazon.com>
> ---
>  v1
>     - NA
>  v2
>     - NA
>  v3
>     - NA
>  v4
>     - Initial patch
>=20
>  target/mips/mips-defs.h |  1 +
>  target/mips/translate.c | 28 +++++++++++++++++++++++++++-
>  2 files changed, 28 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h index=20
> d239069975..5a409757f0 100644
> --- a/target/mips/mips-defs.h
> +++ b/target/mips/mips-defs.h
> @@ -50,6 +50,7 @@
>  #define   ASE_SMARTMIPS 0x00400000
>  #define   ASE_MICROMIPS 0x00800000
>  #define   ASE_MSA       0x01000000
> +#define   ASE_MXU       0x02000000
>=20
>  /* Chip specific instructions. */
>  #define                INSN_LOONGSON2E  0x20000000
> diff --git a/target/mips/translate.c b/target/mips/translate.c index=20
> a598f45558..53d896ebf9 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -17855,6 +17855,28 @@ static void decode_opc_special(CPUMIPSState *env=
, DisasContext *ctx)
>      }
>  }
>=20
> +static void decode_opc_special2_mxu(CPUMIPSState *env, DisasContext=20
> +*ctx) {
> +    int rs, rt, rd;
> +    uint32_t op1;
> +
> +    rs =3D (ctx->opcode >> 21) & 0x1f;
> +    rt =3D (ctx->opcode >> 16) & 0x1f;
> +    rd =3D (ctx->opcode >> 11) & 0x1f;
> +
> +    op1 =3D MASK_SPECIAL2(ctx->opcode);
> +
> +    switch (op1) {
> +    case OPC_MUL:
> +        gen_arith(ctx, op1, rd, rs, rt);
> +        break;
> +    default:            /* Invalid */
> +        MIPS_INVAL("special2_mxu");
> +        generate_exception_end(ctx, EXCP_RI);
> +        break;
> +    }
> +}
> +

This (case OPC_MUL) just looks very odd to me. Why would OPC_MUL somehow be=
 supposed to be included here? Is there any documentation to support this? =
For example of other kind: OPC_MADD is not included in this switch, but the=
re is an OPC_MADD equivalent in MXU. At the same time, there is an OPC_MUL =
equivalent in MXU too.

This looks to me as a very unclear opcode organization. Too bad the MXU doc=
umentation that you linked to doesn't have opcode specifications. Xburst ba=
se set documentation would be very helpful, but there is no such doc to my =
knowledge.

Sincerely,
Aleksandar

>  static void decode_opc_special2_legacy(CPUMIPSState *env,=20
> DisasContext *ctx)  {
>      int rs, rt, rd;
> @@ -19836,7 +19858,11 @@ static void decode_opc(CPUMIPSState *env, DisasC=
ontext *ctx)
>          decode_opc_special(env, ctx);
>          break;
>      case OPC_SPECIAL2:
> -        decode_opc_special2_legacy(env, ctx);
> +        if (ctx->insn_flags & ASE_MXU) {
> +            decode_opc_special2_mxu(env, ctx);
> +        } else {
> +            decode_opc_special2_legacy(env, ctx);
> +        }
>          break;
>      case OPC_SPECIAL3:
>          decode_opc_special3(env, ctx);
> --
> 2.18.0
>=20
