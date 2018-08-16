Received: from eggs.gnu.org ([2001:4830:134:3::10]:56452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fqEAP-00056L-43
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:02:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fqEAM-0002QD-PQ
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:02:04 -0400
References: <20180814124254.5229-1-peter.maydell@linaro.org>
	<20180814124254.5229-7-peter.maydell@linaro.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <9eda9e5e-c01f-cd4d-2680-a74648d0c094@greensocs.com>
Date: Thu, 16 Aug 2018 11:01:47 +0200
MIME-Version: 1.0
In-Reply-To: <20180814124254.5229-7-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eXwLfzYnKyUkURC7RnZ97II4EqaAP9iuQ"
Subject: Re: [Qemu-devel] [PATCH 06/10] target/arm: Implement AArch32 Hyp
 FARs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, edgari@xilinx.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eXwLfzYnKyUkURC7RnZ97II4EqaAP9iuQ
From: Luc Michel <luc.michel@greensocs.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: patches@linaro.org, edgari@xilinx.com
Message-ID: <9eda9e5e-c01f-cd4d-2680-a74648d0c094@greensocs.com>
Subject: Re: [PATCH 06/10] target/arm: Implement AArch32 Hyp FARs
References: <20180814124254.5229-1-peter.maydell@linaro.org>
 <20180814124254.5229-7-peter.maydell@linaro.org>
In-Reply-To: <20180814124254.5229-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 8/14/18 2:42 PM, Peter Maydell wrote:
> The AArch32 virtualization extensions support these fault address
> registers:
>  * HDFAR: aliased with AArch64 FAR_EL2[31:0] and AArch32 DFAR(S)
>  * HIFAR: aliased with AArch64 FAR_EL2[63:32] and AArch32 IFAR(S)
>=20
> Implement the accessors for these. This fixes in passing a bug
> where we weren't implementing the "RES0 from EL3 if EL2 not
> implemented" behaviour for AArch64 FAR_EL2.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-By: Luc Michel <luc.michel@greensocs.com>

> ---
>  target/arm/helper.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 9701e413859..d6e98e9d606 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3847,6 +3847,13 @@ static const ARMCPRegInfo el3_no_el2_cp_reginfo[=
] =3D {
>      { .name =3D "HSTR_EL2", .state =3D ARM_CP_STATE_BOTH,
>        .opc0 =3D 3, .opc1 =3D 4, .crn =3D 1, .crm =3D 1, .opc2 =3D 3,
>        .access =3D PL2_RW, .type =3D ARM_CP_CONST, .resetvalue =3D 0 },=

> +    { .name =3D "FAR_EL2", .state =3D ARM_CP_STATE_BOTH,
> +      .opc0 =3D 3, .opc1 =3D 4, .crn =3D 6, .crm =3D 0, .opc2 =3D 0,
> +      .access =3D PL2_RW, .type =3D ARM_CP_CONST, .resetvalue =3D 0 },=

> +    { .name =3D "HIFAR", .state =3D ARM_CP_STATE_AA32,
> +      .type =3D ARM_CP_CONST,
> +      .cp =3D 15, .opc1 =3D 4, .crn =3D 6, .crm =3D 0, .opc2 =3D 2,
> +      .access =3D PL2_RW, .resetvalue =3D 0 },
>      REGINFO_SENTINEL
>  };
> =20
> @@ -3922,9 +3929,14 @@ static const ARMCPRegInfo el2_cp_reginfo[] =3D {=

>      { .name =3D "ESR_EL2", .state =3D ARM_CP_STATE_AA64,
>        .opc0 =3D 3, .opc1 =3D 4, .crn =3D 5, .crm =3D 2, .opc2 =3D 0,
>        .access =3D PL2_RW, .fieldoffset =3D offsetof(CPUARMState, cp15.=
esr_el[2]) },
> -    { .name =3D "FAR_EL2", .state =3D ARM_CP_STATE_AA64,
> +    { .name =3D "FAR_EL2", .state =3D ARM_CP_STATE_BOTH,
>        .opc0 =3D 3, .opc1 =3D 4, .crn =3D 6, .crm =3D 0, .opc2 =3D 0,
>        .access =3D PL2_RW, .fieldoffset =3D offsetof(CPUARMState, cp15.=
far_el[2]) },
> +    { .name =3D "HIFAR", .state =3D ARM_CP_STATE_AA32,
> +      .type =3D ARM_CP_ALIAS,
> +      .cp =3D 15, .opc1 =3D 4, .crn =3D 6, .crm =3D 0, .opc2 =3D 2,
> +      .access =3D PL2_RW,
> +      .fieldoffset =3D offsetofhigh32(CPUARMState, cp15.far_el[2]) },
>      { .name =3D "SPSR_EL2", .state =3D ARM_CP_STATE_AA64,
>        .type =3D ARM_CP_ALIAS,
>        .opc0 =3D 3, .opc1 =3D 4, .crn =3D 4, .crm =3D 0, .opc2 =3D 0,
>=20


--eXwLfzYnKyUkURC7RnZ97II4EqaAP9iuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAlt1PXsACgkQd8knW3Qn
Tr4ZNQ/+INvL1wYD9s4zTP/NSWtD+MEjhaNM+r75wfP9NGZk/2znda8Q/6DP76H/
FPae/XlW6F1VvfW2FCv+sER45wUeG0Cyf0sKOkGDjSWjAFa6gOiR8ryeku4Lu06J
ErPFvxpiV1W2BFvOBq/jMpj0WieVnYMDS+4yI/GTMG2tgHSCFoeb/CBvasVSBOFn
5SeF8E+9x8Ztnp+erP6TVxjGvvx/nzupfhORNLzy8sVSM4QCkhAM9i+sya6hH39w
G/HpqTr53hgACF0Q/y1rB0sYSH75kL9oOZ4hBjzevDNmwr2x80O/NaELbrn1CrwO
h6Px6MoFpPnqfd95BapQwqdz4gBWCunfo0waZfFpyt0j9laFFGcWqWOGCzLOAIlI
PixbI8tSKHJ9gQRJhuexkCz/UAChtumYEZUHH1EbXsIN7Z94qSJhupaxAsjp2WFf
NXRKp7Lo1ZSH98MNE5K/N5Xng1ZQlFo+zolM6p4MF1wkbaJkEc7HcmvZjCflQ8LR
Jh1ZiwQCCwSw8v/AkHYOSrUhkdddLeI9xdfjjbc7qiy07X2ig0NhjDFTK2r4ML+Z
+X15ophDquXXKQSCu59cRd+T8cFLCzNN/Cf3trLKZ/dlSgIzQ5SMWenpaRpEJwcy
QN+WQnzt7ZME/NA12DJWFH80wB9FUsjGwEPElr7Lfvs2SmZvieo=
=4img
-----END PGP SIGNATURE-----

--eXwLfzYnKyUkURC7RnZ97II4EqaAP9iuQ--
