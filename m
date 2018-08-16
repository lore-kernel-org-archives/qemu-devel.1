Received: from eggs.gnu.org ([2001:4830:134:3::10]:42038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fqDBE-0004yn-Uo
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 03:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fqDBD-0004ph-Td
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 03:58:52 -0400
References: <20180814124254.5229-1-peter.maydell@linaro.org>
	<20180814124254.5229-9-peter.maydell@linaro.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <191d7d48-ed11-ae83-f776-ddf0b935646b@greensocs.com>
Date: Thu, 16 Aug 2018 09:58:29 +0200
MIME-Version: 1.0
In-Reply-To: <20180814124254.5229-9-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="irU1cVSBqZwgVQraAa9XFkoEjIuTjhgmg"
Subject: Re: [Qemu-devel] [PATCH 08/10] target/arm: Permit accesses to
 ELR_Hyp from Hyp mode via MSR/MRS (banked)
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
--irU1cVSBqZwgVQraAa9XFkoEjIuTjhgmg
From: Luc Michel <luc.michel@greensocs.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: patches@linaro.org, edgari@xilinx.com
Message-ID: <191d7d48-ed11-ae83-f776-ddf0b935646b@greensocs.com>
Subject: Re: [PATCH 08/10] target/arm: Permit accesses to ELR_Hyp from Hyp
 mode via MSR/MRS (banked)
References: <20180814124254.5229-1-peter.maydell@linaro.org>
 <20180814124254.5229-9-peter.maydell@linaro.org>
In-Reply-To: <20180814124254.5229-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 8/14/18 2:42 PM, Peter Maydell wrote:
> The MSR (banked) and MRS (banked) instructions allow accesses to ELR_Hy=
p
> from either Monitor or Hyp mode. Our translate time check
> was overly strict and only permitted access from Monitor mode.
>=20
> The runtime check wo do in msr_mrs_banked_exc_checks() had the
"we"
> correct code in it, but never got there because of the earlier
> "currmode =3D=3D tgtmode" check. Special case ELR_Hyp.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-By: Luc Michel <luc.michel@greensocs.com>

> ---
>  target/arm/op_helper.c | 22 +++++++++++-----------
>  target/arm/translate.c | 10 +++++++---
>  2 files changed, 18 insertions(+), 14 deletions(-)
>=20
> diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
> index d550978b5b9..952b8d122b7 100644
> --- a/target/arm/op_helper.c
> +++ b/target/arm/op_helper.c
> @@ -611,6 +611,14 @@ static void msr_mrs_banked_exc_checks(CPUARMState =
*env, uint32_t tgtmode,
>       */
>      int curmode =3D env->uncached_cpsr & CPSR_M;
> =20
> +    if (regno =3D=3D 17) {
> +        /* ELR_Hyp: a special case because access from tgtmode is OK *=
/
> +        if (curmode !=3D ARM_CPU_MODE_HYP && curmode !=3D ARM_CPU_MODE=
_MON) {
> +            goto undef;
> +        }
> +        return;
> +    }
> +
>      if (curmode =3D=3D tgtmode) {
>          goto undef;
>      }
> @@ -638,17 +646,9 @@ static void msr_mrs_banked_exc_checks(CPUARMState =
*env, uint32_t tgtmode,
>      }
> =20
>      if (tgtmode =3D=3D ARM_CPU_MODE_HYP) {
> -        switch (regno) {
> -        case 17: /* ELR_Hyp */
> -            if (curmode !=3D ARM_CPU_MODE_HYP && curmode !=3D ARM_CPU_=
MODE_MON) {
> -                goto undef;
> -            }
> -            break;
> -        default:
> -            if (curmode !=3D ARM_CPU_MODE_MON) {
> -                goto undef;
> -            }
> -            break;
> +        /* SPSR_Hyp, r13_hyp: accessible from Monitor mode only */
> +        if (curmode !=3D ARM_CPU_MODE_MON) {
> +            goto undef;
>          }
>      }
> =20
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index f845da7c638..3f5751d4826 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -4506,10 +4506,14 @@ static bool msr_banked_access_decode(DisasConte=
xt *s, int r, int sysm, int rn,
>          }
>          break;
>      case ARM_CPU_MODE_HYP:
> -        /* Note that we can forbid accesses from EL2 here because they=

> -         * must be from Hyp mode itself
> +        /*
> +         * SPSR_hyp and r13_hyp can only be accessed from Monitor mode=

> +         * (and so we can forbid accesses from EL2 or below). elr_hyp
> +         * can be accessed also from Hyp mode, so forbid accesses from=

> +         * EL0 or EL1.
>           */
> -        if (!arm_dc_feature(s, ARM_FEATURE_EL2) || s->current_el < 3) =
{
> +        if (!arm_dc_feature(s, ARM_FEATURE_EL2) || s->current_el < 2 |=
|
> +            (s->current_el < 3 && *regno !=3D 17)) {
>              goto undef;
>          }
>          break;
>=20


--irU1cVSBqZwgVQraAa9XFkoEjIuTjhgmg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAlt1LqUACgkQd8knW3Qn
Tr7rmQ//bFe09MUm2UXJWB5J7qRDvZoTtq7KKroHbAoeEBEIIJeVgltgd5ZZg1SW
1MGX5Edk++MDsMYQlx4MdTnPkwnP/Dec597i8KcaP4iXoiGTvaKhibvrIaghknkO
SnTF90a1uSPbcJixOyKQ8nMyn3t1YV5b25xouC/y2cbdM3tShY5o4RZKXgQIe3IL
ThxHwo07v7hfEagEMu3LkwVDm/KifHwwuzOd+ttpe9Xnu9K4BlPPOWnTZCkuazBU
eKiwIWCa6RgSSITqMC6xiGdQg1P49Ao+QXItGBM7PemSm+o9QACkI4MtQZqmLtvB
IA8T5ZU+5/CytQfGfPB9d11X1R9tv3KzQtvnxPMhw84pCUv+/jy4qyaYyFSTSIbo
4LU1K3KMlsjTEWTUv6euMo18a+yydO/3O+Fgqs/uzIAaOYmk4pIe1FoYFKaOQYOy
V85Z0qcxEWkYIWKoaBeIIxyS9eEabJ2Vk/VeVaO6hSzZ7PtQ49HcTffhGhS96l0B
YzEUkFrMHr94YLxnWuqHn78HTwD7hU6eLUShge+1r1L8jk9YQ4jLOeA2di4jihXw
wUVt6j1pUeLuA4rQdgPKy1cZPwv6WRHrxdCAAVcXM1sPoZuLkRbiqN/tmqfaizSc
ZdpRPaIs1Q5iDiaHhdOv9nNlwyXS4/R5m7P+3ZmfNoTn3Bi5mlU=
=ryVX
-----END PGP SIGNATURE-----

--irU1cVSBqZwgVQraAa9XFkoEjIuTjhgmg--
