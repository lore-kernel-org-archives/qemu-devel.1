Received: from eggs.gnu.org ([208.118.235.92]:56627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8921f0682=jancraig@amazon.com>)
	id 1gcZGS-00052f-SG
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 12:16:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8921f0682=jancraig@amazon.com>)
	id 1gcZGP-0007RP-LF
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 12:16:08 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:22522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=8921f0682=jancraig@amazon.com>)
	id 1gcZGO-0007MH-Kz
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 12:16:05 -0500
From: "Janeczek, Craig" <jancraig@amazon.com>
Date: Thu, 27 Dec 2018 17:15:57 +0000
Message-ID: <32edc91d04374cfd8fb50bc26c9bd320@EX13D12UEA003.ant.amazon.com>
References: <20181217200444.14812-1-aleksandar.markovic@rt-rk.com>
	<20181217200444.14812-2-aleksandar.markovic@rt-rk.com>
	<48756599-1566-8b46-b742-40cea97bce15@wavecomp.com>
In-Reply-To: <48756599-1566-8b46-b742-40cea97bce15@wavecomp.com>
Content-Language: en-US
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/6] target/mips: MXU: Add missing
 opcodes/decoding for LX* instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>

On 17.12.18. 21:04, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Add missing opcodes and decoding engine for LXB, LXH, LXW, LXBU, and=20
> LXHU instructions. They were for some reason forgotten in previous=20
> commits. The MXU opcode list and decoding engine should be now=20
> complete.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>   target/mips/translate.c | 140 +++++++++++++++++++++++++++++-----------
>   1 file changed, 102 insertions(+), 38 deletions(-)


Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>


> diff --git a/target/mips/translate.c b/target/mips/translate.c index=20
> e9c23a594b..e0c8d8c2f7 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -1663,12 +1663,21 @@ enum {
>    *          =81                               20..18
>    *          =86=80 100111 =80 OPC_MXU__POOL16 =80=88=80 000 =80 OPC_MXU=
_D32SARW
>    *          =81                            =86=80 001 =80 OPC_MXU_S32AL=
N
> - *          =86=80 101000 =80 OPC_MXU_LXB      =86=80 010 =80 OPC_MXU_S3=
2ALNI
> - *          =86=80 101001 =80 <not assigned>   =86=80 011 =80 OPC_MXU_S3=
2NOR
> - *          =86=80 101010 =80 OPC_MXU_S16LDD   =86=80 100 =80 OPC_MXU_S3=
2AND
> - *          =86=80 101011 =80 OPC_MXU_S16STD   =86=80 101 =80 OPC_MXU_S3=
2OR
> - *          =86=80 101100 =80 OPC_MXU_S16LDI   =86=80 110 =80 OPC_MXU_S3=
2XOR
> - *          =86=80 101101 =80 OPC_MXU_S16SDI   =84=80 111 =80 OPC_MXU_S3=
2LUI
> + *          =81                            =86=80 010 =80 OPC_MXU_S32ALN=
I
> + *          =81                            =86=80 011 =80 OPC_MXU_S32NOR
> + *          =81                            =86=80 100 =80 OPC_MXU_S32AND
> + *          =81                            =86=80 101 =80 OPC_MXU_S32OR
> + *          =81                            =86=80 110 =80 OPC_MXU_S32XOR
> + *          =81                            =84=80 111 =80 OPC_MXU_S32LUI
The opcodes for pool 16 do not look correct. I think the minor bits should =
look like the following.

=88=80 000 =80 OPC_MXU_D32SARW
=86=80 001 =80 OPC_MXU_S32ALN
=86=80 010 =80 OPC_MXU_S32ALNI
=86=80 011 =80 OPC_MXU_S32LUI
=86=80 100 =80 OPC_MXU_S32NOR
=86=80 101 =80 OPC_MXU_S32AND
=86=80 110 =80 OPC_MXU_S32OR
=84=80 111 =80 OPC_MXU_S32XOR

> + *          =81
> + *          =81                               7..5
> + *          =86=80 101000 =80 OPC_MXU__POOL17 =80=88=80 000 =80 OPC_MXU_=
LXB
> + *          =81                            =86=80 001 =80 OPC_MXU_LXH
> + *          =86=80 101001 =80 <not assigned>   =86=80 011 =80 OPC_MXU_LX=
W
> + *          =86=80 101010 =80 OPC_MXU_S16LDD   =86=80 100 =80 OPC_MXU_LX=
BU
> + *          =86=80 101011 =80 OPC_MXU_S16STD   =84=80 101 =80 OPC_MXU_LX=
HU
> + *          =86=80 101100 =80 OPC_MXU_S16LDI
> + *          =86=80 101101 =80 OPC_MXU_S16SDI
>    *          =86=80 101110 =80 OPC_MXU_S32M2I
>    *          =86=80 101111 =80 OPC_MXU_S32I2M
>    *          =86=80 110000 =80 OPC_MXU_D32SLL
> @@ -1678,15 +1687,15 @@ enum {
>    *          =86=80 110100 =80 OPC_MXU_Q16SLL   =86=80 010 =80 OPC_MXU_D=
32SARV
>    *          =86=80 110101 =80 OPC_MXU_Q16SLR   =86=80 011 =80 OPC_MXU_Q=
16SLLV
>    *          =81                            =86=80 100 =80 OPC_MXU_Q16SL=
RV
> - *          =86=80 110110 =80 OPC_MXU__POOL17 =80=89=80 101 =80 OPC_MXU_=
Q16SARV
> + *          =86=80 110110 =80 OPC_MXU__POOL18 =80=89=80 101 =80 OPC_MXU_=
Q16SARV
>    *          =81
>    *          =86=80 110111 =80 OPC_MXU_Q16SAR
>    *          =81                               23..22
> - *          =86=80 111000 =80 OPC_MXU__POOL18 =80=88=80 00 =80 OPC_MXU_Q=
8MUL
> + *          =86=80 111000 =80 OPC_MXU__POOL19 =80=88=80 00 =80 OPC_MXU_Q=
8MUL
>    *          =81                            =84=80 01 =80 OPC_MXU_Q8MULS=
U
>    *          =81
>    *          =81                               20..18
> - *          =86=80 111001 =80 OPC_MXU__POOL19 =80=88=80 000 =80 OPC_MXU_=
Q8MOVZ
> + *          =86=80 111001 =80 OPC_MXU__POOL20 =80=88=80 000 =80 OPC_MXU_=
Q8MOVZ
>    *          =81                            =86=80 001 =80 OPC_MXU_Q8MOV=
N
>    *          =81                            =86=80 010 =80 OPC_MXU_D16MO=
VZ
>    *          =81                            =86=80 011 =80 OPC_MXU_D16MO=
VN
> @@ -1694,7 +1703,7 @@ enum {
>    *          =81                            =84=80 101 =80 OPC_MXU_S32MO=
V
>    *          =81
>    *          =81                               23..22
> - *          =86=80 111010 =80 OPC_MXU__POOL20 =80=88=80 00 =80 OPC_MXU_Q=
8MAC
> + *          =86=80 111010 =80 OPC_MXU__POOL21 =80=88=80 00 =80 OPC_MXU_Q=
8MAC
>    *          =81                            =84=80 10 =80 OPC_MXU_Q8MACS=
U
>    *          =86=80 111011 =80 OPC_MXU_Q16SCOP
>    *          =86=80 111100 =80 OPC_MXU_Q8MADL
> @@ -1750,7 +1759,7 @@ enum {
>       OPC_MXU_S8SDI    =3D 0x25,
>       OPC_MXU__POOL15  =3D 0x26,
>       OPC_MXU__POOL16  =3D 0x27,
> -    OPC_MXU_LXB      =3D 0x28,
> +    OPC_MXU__POOL17  =3D 0x28,
>       /* not assigned 0x29 */
>       OPC_MXU_S16LDD   =3D 0x2A,
>       OPC_MXU_S16STD   =3D 0x2B,
> @@ -1764,11 +1773,11 @@ enum {
>       OPC_MXU_D32SAR   =3D 0x33,
>       OPC_MXU_Q16SLL   =3D 0x34,
>       OPC_MXU_Q16SLR   =3D 0x35,
> -    OPC_MXU__POOL17  =3D 0x36,
> +    OPC_MXU__POOL18  =3D 0x36,
>       OPC_MXU_Q16SAR   =3D 0x37,
> -    OPC_MXU__POOL18  =3D 0x38,
> -    OPC_MXU__POOL19  =3D 0x39,
> -    OPC_MXU__POOL20  =3D 0x3A,
> +    OPC_MXU__POOL19  =3D 0x38,
> +    OPC_MXU__POOL20  =3D 0x39,
> +    OPC_MXU__POOL21  =3D 0x3A,
>       OPC_MXU_Q16SCOP  =3D 0x3B,
>       OPC_MXU_Q8MADL   =3D 0x3C,
>       OPC_MXU_S32SFL   =3D 0x3D,
> @@ -1940,6 +1949,17 @@ enum {
>   /*
>    * MXU pool 17
>    */
> +enum {
> +    OPC_MXU_LXB      =3D 0x00,
> +    OPC_MXU_LXH      =3D 0x01,
> +    OPC_MXU_LXW      =3D 0x03,
> +    OPC_MXU_LXBU     =3D 0x04,
> +    OPC_MXU_LXHU     =3D 0x05,
> +};
> +
> +/*
> + * MXU pool 18
> + */
>   enum {
>       OPC_MXU_D32SLLV  =3D 0x00,
>       OPC_MXU_D32SLRV  =3D 0x01,
> @@ -1950,7 +1970,7 @@ enum {
>   };
>  =20
>   /*
> - * MXU pool 18
> + * MXU pool 19
>    */
>   enum {
>       OPC_MXU_Q8MUL    =3D 0x00,
> @@ -1958,7 +1978,7 @@ enum {
>   };
>  =20
>   /*
> - * MXU pool 19
> + * MXU pool 20
>    */
>   enum {
>       OPC_MXU_Q8MOVZ   =3D 0x00,
> @@ -1970,7 +1990,7 @@ enum {
>   };
>  =20
>   /*
> - * MXU pool 20
> + * MXU pool 21
>    */
>   enum {
>       OPC_MXU_Q8MAC    =3D 0x00,
> @@ -25331,12 +25351,58 @@ static void decode_opc_mxu__pool16(CPUMIPSState=
 *env, DisasContext *ctx)
>    * Decode MXU pool17
>    *
>    *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
> + *  +-----------+---------+---------+---+---------+-----+-----------+
> + *  |  SPECIAL2 |    rs   |    rt   |0 0|    rd   |x x x|MXU__POOL15|
> + *  +-----------+---------+---------+---+---------+-----+-----------+
> + *
> + */
> +static void decode_opc_mxu__pool17(CPUMIPSState *env, DisasContext=20
> +*ctx) {
> +    uint32_t opcode =3D extract32(ctx->opcode, 6, 2);
> +
> +    switch (opcode) {
> +    case OPC_MXU_LXW:
> +        /* TODO: Implement emulation of LXW instruction. */
> +        MIPS_INVAL("OPC_MXU_LXW");
> +        generate_exception_end(ctx, EXCP_RI);
> +        break;
> +    case OPC_MXU_LXH:
> +        /* TODO: Implement emulation of LXH instruction. */
> +        MIPS_INVAL("OPC_MXU_LXH");
> +        generate_exception_end(ctx, EXCP_RI);
> +        break;
> +    case OPC_MXU_LXHU:
> +        /* TODO: Implement emulation of LXHU instruction. */
> +        MIPS_INVAL("OPC_MXU_LXHU");
> +        generate_exception_end(ctx, EXCP_RI);
> +        break;
> +    case OPC_MXU_LXB:
> +        /* TODO: Implement emulation of LXB instruction. */
> +        MIPS_INVAL("OPC_MXU_LXB");
> +        generate_exception_end(ctx, EXCP_RI);
> +        break;
> +    case OPC_MXU_LXBU:
> +        /* TODO: Implement emulation of LXBU instruction. */
> +        MIPS_INVAL("OPC_MXU_LXBU");
> +        generate_exception_end(ctx, EXCP_RI);
> +        break;
> +    default:
> +        MIPS_INVAL("decode_opc_mxu");
> +        generate_exception_end(ctx, EXCP_RI);
> +        break;
> +    }
> +}
> +/*
> + *
> + * Decode MXU pool18
> + *
> + *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
>    *  +-----------+---------+-----+-------+-------+-------+-----------+
> - *  |  SPECIAL2 |    rb   |x x x|  XRd  |  XRa  |0 0 0 0|MXU__POOL17|
> + *  |  SPECIAL2 |    rb   |x x x|  XRd  |  XRa  |0 0 0 0|MXU__POOL18|
>    *  +-----------+---------+-----+-------+-------+-------+-----------+
>    *
>    */
> -static void decode_opc_mxu__pool17(CPUMIPSState *env, DisasContext=20
> *ctx)
> +static void decode_opc_mxu__pool18(CPUMIPSState *env, DisasContext=20
> +*ctx)
>   {
>       uint32_t opcode =3D extract32(ctx->opcode, 18, 3);
>  =20
> @@ -25380,15 +25446,15 @@ static void=20
> decode_opc_mxu__pool17(CPUMIPSState *env, DisasContext *ctx)
>  =20
>   /*
>    *
> - * Decode MXU pool18
> + * Decode MXU pool19
>    *
>    *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
>    * =20
> +-----------+---+---+-------+-------+-------+-------+-----------+
> - *  |  SPECIAL2 |0 0|x x|  XRd  |  XRc  |  XRb  |  XRa  |MXU__POOL18|
> + *  |  SPECIAL2 |0 0|x x|  XRd  |  XRc  |  XRb  |  XRa  |MXU__POOL19|
>    *  +-----------+---+---+-------+-------+-------+-------+-----------+
>    *
>    */
> -static void decode_opc_mxu__pool18(CPUMIPSState *env, DisasContext=20
> *ctx)
> +static void decode_opc_mxu__pool19(CPUMIPSState *env, DisasContext=20
> +*ctx)
>   {
>       uint32_t opcode =3D extract32(ctx->opcode, 22, 2);
>  =20
> @@ -25406,15 +25472,15 @@ static void=20
> decode_opc_mxu__pool18(CPUMIPSState *env, DisasContext *ctx)
>  =20
>   /*
>    *
> - * Decode MXU pool19
> + * Decode MXU pool20
>    *
>    *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
>    * =20
> +-----------+---------+-----+-------+-------+-------+-----------+
> - *  |  SPECIAL2 |0 0 0 0 0|x x x|  XRc  |  XRb  |  XRa  |MXU__POOL19|
> + *  |  SPECIAL2 |0 0 0 0 0|x x x|  XRc  |  XRb  |  XRa  |MXU__POOL20|
>    *  +-----------+---------+-----+-------+-------+-------+-----------+
>    *
>    */
> -static void decode_opc_mxu__pool19(CPUMIPSState *env, DisasContext=20
> *ctx)
> +static void decode_opc_mxu__pool20(CPUMIPSState *env, DisasContext=20
> +*ctx)
>   {
>       uint32_t opcode =3D extract32(ctx->opcode, 18, 3);
>  =20
> @@ -25458,15 +25524,15 @@ static void=20
> decode_opc_mxu__pool19(CPUMIPSState *env, DisasContext *ctx)
>  =20
>   /*
>    *
> - * Decode MXU pool20
> + * Decode MXU pool21
>    *
>    *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
>    * =20
> +-----------+---+---+-------+-------+-------+-------+-----------+
> - *  |  SPECIAL2 |an2|x x|  XRd  |  XRc  |  XRb  |  XRa  |MXU__POOL20|
> + *  |  SPECIAL2 |an2|x x|  XRd  |  XRc  |  XRb  |  XRa  |MXU__POOL21|
>    *  +-----------+---+---+-------+-------+-------+-------+-----------+
>    *
>    */
> -static void decode_opc_mxu__pool20(CPUMIPSState *env, DisasContext=20
> *ctx)
> +static void decode_opc_mxu__pool21(CPUMIPSState *env, DisasContext=20
> +*ctx)
>   {
>       uint32_t opcode =3D extract32(ctx->opcode, 22, 2);
>  =20
> @@ -25669,10 +25735,8 @@ static void decode_opc_mxu(CPUMIPSState *env, Di=
sasContext *ctx)
>           case OPC_MXU__POOL16:
>               decode_opc_mxu__pool16(env, ctx);
>               break;
> -        case OPC_MXU_LXB:
> -            /* TODO: Implement emulation of LXB instruction. */
> -            MIPS_INVAL("OPC_MXU_LXB");
> -            generate_exception_end(ctx, EXCP_RI);
> +        case OPC_MXU__POOL17:
> +            decode_opc_mxu__pool17(env, ctx);
>               break;
>           case OPC_MXU_S16LDD:
>               /* TODO: Implement emulation of S16LDD instruction. */=20
> @@ -25724,23 +25788,23 @@ static void decode_opc_mxu(CPUMIPSState *env, D=
isasContext *ctx)
>               MIPS_INVAL("OPC_MXU_Q16SLR");
>               generate_exception_end(ctx, EXCP_RI);
>               break;
> -        case OPC_MXU__POOL17:
> -            decode_opc_mxu__pool17(env, ctx);
> +        case OPC_MXU__POOL18:
> +            decode_opc_mxu__pool18(env, ctx);
>               break;
>           case OPC_MXU_Q16SAR:
>               /* TODO: Implement emulation of Q16SAR instruction. */
>               MIPS_INVAL("OPC_MXU_Q16SAR");
>               generate_exception_end(ctx, EXCP_RI);
>               break;
> -        case OPC_MXU__POOL18:
> -            decode_opc_mxu__pool18(env, ctx);
> -            break;
>           case OPC_MXU__POOL19:
>               decode_opc_mxu__pool19(env, ctx);
>               break;
>           case OPC_MXU__POOL20:
>               decode_opc_mxu__pool20(env, ctx);
>               break;
> +        case OPC_MXU__POOL21:
> +            decode_opc_mxu__pool21(env, ctx);
> +            break;
>           case OPC_MXU_Q16SCOP:
>               /* TODO: Implement emulation of Q16SCOP instruction. */
>               MIPS_INVAL("OPC_MXU_Q16SCOP");
