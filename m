Received: from eggs.gnu.org ([2001:4830:134:3::10]:54584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fqE4D-0007yI-8Z
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:55:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fqE4C-0007jQ-BK
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:55:41 -0400
References: <20180814124254.5229-1-peter.maydell@linaro.org>
	<20180814124254.5229-6-peter.maydell@linaro.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <669fdbe5-4cac-7866-e227-300e55eb1285@greensocs.com>
Date: Thu, 16 Aug 2018 10:55:09 +0200
MIME-Version: 1.0
In-Reply-To: <20180814124254.5229-6-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ofn3oOVlJJfBe9va1QXLv0blqDuwJ9CuO"
Subject: Re: [Qemu-devel] [PATCH 05/10] target/arm: Implement AArch32 HCR
 and HCR2
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
--ofn3oOVlJJfBe9va1QXLv0blqDuwJ9CuO
From: Luc Michel <luc.michel@greensocs.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: patches@linaro.org, edgari@xilinx.com
Message-ID: <669fdbe5-4cac-7866-e227-300e55eb1285@greensocs.com>
Subject: Re: [PATCH 05/10] target/arm: Implement AArch32 HCR and HCR2
References: <20180814124254.5229-1-peter.maydell@linaro.org>
 <20180814124254.5229-6-peter.maydell@linaro.org>
In-Reply-To: <20180814124254.5229-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 8/14/18 2:42 PM, Peter Maydell wrote:
> The AArch32 HCR and HCR2 registers alias HCR_EL2
> bits [31:0] and [63:32]; implement them.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 39 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 35 insertions(+), 4 deletions(-)
>=20
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index b6412fe9d1f..9701e413859 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3754,11 +3754,15 @@ static const ARMCPRegInfo el3_no_el2_cp_reginfo=
[] =3D {
>        .opc0 =3D 3, .opc1 =3D 4, .crn =3D 12, .crm =3D 0, .opc2 =3D 0,
>        .access =3D PL2_RW,
>        .readfn =3D arm_cp_read_zero, .writefn =3D arm_cp_write_ignore }=
,
> -    { .name =3D "HCR_EL2", .state =3D ARM_CP_STATE_AA64,
> +    { .name =3D "HCR_EL2", .state =3D ARM_CP_STATE_BOTH,
>        .type =3D ARM_CP_NO_RAW,
>        .opc0 =3D 3, .opc1 =3D 4, .crn =3D 1, .crm =3D 1, .opc2 =3D 0,
>        .access =3D PL2_RW,
> -      .readfn =3D arm_cp_read_zero, .writefn =3D arm_cp_write_ignore }=
,
> +      .type =3D ARM_CP_CONST, .resetvalue =3D 0 },
> +    { .name =3D "HCR2", .state =3D ARM_CP_STATE_AA32,
> +      .cp =3D 15, .opc1 =3D 4, .crn =3D 1, .crm =3D 1, .opc2 =3D 4,
> +      .access =3D PL2_RW,
> +      .type =3D ARM_CP_CONST, .resetvalue =3D 0 },
As for HACTLR2, shouldn't we avoid defining HCR2 for ARMv7?

>      { .name =3D "CPTR_EL2", .state =3D ARM_CP_STATE_BOTH,
>        .opc0 =3D 3, .opc1 =3D 4, .crn =3D 1, .crm =3D 1, .opc2 =3D 2,
>        .access =3D PL2_RW, .type =3D ARM_CP_CONST, .resetvalue =3D 0 },=

> @@ -3872,10 +3876,26 @@ static void hcr_write(CPUARMState *env, const A=
RMCPRegInfo *ri, uint64_t value)
>       * HCR_PTW forbids certain page-table setups
>       * HCR_DC Disables stage1 and enables stage2 translation
>       */
> -    if ((raw_read(env, ri) ^ value) & (HCR_VM | HCR_PTW | HCR_DC)) {
> +    if ((env->cp15.hcr_el2 ^ value) & (HCR_VM | HCR_PTW | HCR_DC)) {
>          tlb_flush(CPU(cpu));
>      }
> -    raw_write(env, ri, value);
> +    env->cp15.hcr_el2 =3D value;
> +}
> +
> +static void hcr_writehigh(CPUARMState *env, const ARMCPRegInfo *ri,
> +                          uint64_t value)
> +{
> +    /* Handle HCR2 write, i.e. write to high half of HCR_EL2 */
> +    value =3D deposit64(env->cp15.hcr_el2, 32, 32, value);
> +    hcr_write(env, NULL, value);
> +}
> +
> +static void hcr_writelow(CPUARMState *env, const ARMCPRegInfo *ri,
> +                         uint64_t value)
> +{
> +    /* Handle HCR write, i.e. write to low half of HCR_EL2 */
> +    value =3D deposit64(env->cp15.hcr_el2, 0, 32, value);
> +    hcr_write(env, NULL, value);
>  }
> =20
>  static const ARMCPRegInfo el2_cp_reginfo[] =3D {
> @@ -3883,6 +3903,17 @@ static const ARMCPRegInfo el2_cp_reginfo[] =3D {=

>        .opc0 =3D 3, .opc1 =3D 4, .crn =3D 1, .crm =3D 1, .opc2 =3D 0,
>        .access =3D PL2_RW, .fieldoffset =3D offsetof(CPUARMState, cp15.=
hcr_el2),
>        .writefn =3D hcr_write },
> +    { .name =3D "HCR", .state =3D ARM_CP_STATE_AA32,
> +      .type =3D ARM_CP_ALIAS,
> +      .cp =3D 15, .opc1 =3D 4, .crn =3D 1, .crm =3D 1, .opc2 =3D 0,
> +      .access =3D PL2_RW, .fieldoffset =3D offsetof(CPUARMState, cp15.=
hcr_el2),
> +      .writefn =3D hcr_writelow },
> +    { .name =3D "HCR2", .state =3D ARM_CP_STATE_AA32,
> +      .type =3D ARM_CP_ALIAS,
> +      .cp =3D 15, .opc1 =3D 4, .crn =3D 1, .crm =3D 1, .opc2 =3D 4,
> +      .access =3D PL2_RW,
> +      .fieldoffset =3D offsetofhigh32(CPUARMState, cp15.hcr_el2),
> +      .writefn =3D hcr_writehigh },
Also here. This one could actually be problematic as it allows ARMv7 to
write the upper 32-bits of HCR, since HCR_MASK in hcr_write() is greater
than UINT32_MAX.

--=20
Luc

>      { .name =3D "ELR_EL2", .state =3D ARM_CP_STATE_AA64,
>        .type =3D ARM_CP_ALIAS,
>        .opc0 =3D 3, .opc1 =3D 4, .crn =3D 4, .crm =3D 0, .opc2 =3D 1,
>=20


--ofn3oOVlJJfBe9va1QXLv0blqDuwJ9CuO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAlt1O+0ACgkQd8knW3Qn
Tr4tbxAAjfsVqeGjb1ZypWqD5NiKI+IEjAQDHLtwkIfEiFjPfknt5R244z81EJwk
b0IGeajLeKhVS+kL+dN6YcLFdvcusd7HMQ1daDA/W2l+QLQJRSbQ/z9xzFFk5KjN
FctY2HrMMPss9m7RFyKnBghVjPr+DHI2s+bZ9nZjUdmY2pJxGErKo7cdtG0A6naS
PKHJ9bcTYn10JYCBdapJplVRllHi21SbRbw+pn4E75m+ezpNMaGuUGa+b+MhlgQ0
gCWxLDR6EL/Nt/CMBm1DsOC/rWIoL5aYnHPzZiscORxoKoBhdEOQqHNI77di97wz
tWymHYkmyGqm5fxbP1TCb7Usx2Hpz1Ufbg62l/BH8RF29XDcJ10/4TttjkiogJ0s
mpHk2bwnyZoO9FP8L1D+vjHjxO+pCULeI6j1MuVVVlcIPk250b1OdfhHhPZ4y20r
pjCFWpMgmCBxqaz2+E+Q6g3OyhoxztCQF+AxyBlZmF3DTXxgQSvh9MKTPSb3fABv
njAmtnBMdEZBeIayueeX+UCGyMqCxK3Y/gcHnwySzsnYbhFf8juVtbwehhHrjS19
HlSomoUW0OlVgN2Ou6KNO9pMCHm0in/3RZr0s0Uo8iIsVmGEgJMe+FPSL6T/C++G
P/NUpu2+YgVHsUQ6EJU4zJAV6wPynP7SfEtI/wboF7opxnWxguM=
=US+e
-----END PGP SIGNATURE-----

--ofn3oOVlJJfBe9va1QXLv0blqDuwJ9CuO--
