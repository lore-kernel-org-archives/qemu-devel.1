Received: from eggs.gnu.org ([209.51.188.92]:48848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyTtq-0003t1-OK
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 22:59:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyTto-0007jm-Fa
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 22:59:22 -0500
Date: Tue, 26 Feb 2019 14:59:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190226035904.GN6872@umbus.fritz.box>
References: <20190226030531.9932-1-sjitindarsingh@gmail.com>
	<20190226030531.9932-4-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1R6ZDISWaA1muLP0"
Content-Disposition: inline
In-Reply-To: <20190226030531.9932-4-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH 4/4] target/ppc/spapr: Enable
 the large decrementer by default on POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, clg@kaod.org, qemu-devel@nongnu.org


--1R6ZDISWaA1muLP0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 26, 2019 at 02:05:31PM +1100, Suraj Jitindar Singh wrote:
> Enable the large decrementer by default on POWER9 cpu models. The
> default value applied is that provided in the cpu class.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> ---
>  hw/ppc/spapr_caps.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index e07568fb94..f48aa367e3 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -566,11 +566,18 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM]=
 =3D {
>  static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
>                                                 const char *cputype)
>  {
> +    PowerPCCPUClass *pcc =3D POWERPC_CPU_CLASS(object_class_by_name(cput=
ype));
>      sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
>      sPAPRCapabilities caps;
> =20
>      caps =3D smc->default_caps;
> =20
> +    caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D pcc->hdecr_bits;

So, the rule with default_caps_with_cpu() is that it can reduce the
value from the machine-global default, but never increase it (because
that could change guest visible behaviour for existing machine
versions).

I think the line above will do that.

> +    if (!ppc_type_check_compat(cputype, CPU_POWERPC_LOGICAL_3_00,
> +                               0, spapr->max_compat_pvr)) {
> +        caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D 0;

And this part I think is redundant, because hdecr_bits won't be large
for anything pre-POWER9.

> +    }
> +
>      if (!ppc_type_check_compat(cputype, CPU_POWERPC_LOGICAL_2_07,
>                                 0, spapr->max_compat_pvr)) {
>          caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1R6ZDISWaA1muLP0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx0uYgACgkQbDjKyiDZ
s5J/7A/9EQCmTrVL4nTg2WC5RAK0LQksqTb9m2gVmhfMPTLektLPw98ZMJEphd57
XieXMftQAe3L2+ah7UI4fOKAAk5DjG1uzhngHVxD5kez5JqXDJWIgNP42IS9g6HL
0ak6XVmaRHoG6zm9sRX2qmMq6RTFcNNfQlbspBVe+TRh4TpLnJViecR9T/Q6wnqx
A9E/D/FT6XnH4tDtxQ3ia5UxKPluHUguJ1i6PhD1YCQQictIILjtBRr2bRSJKaXj
WPqGzWJeiKwzYrP9UH72/tGVUm2Jvg5mKECeKkLnBWOFvuaJ+2AUPPyeZbKQVR+4
AyR3+DNpVCCfUvzjyhqfNpiwZ+4Pr5DVUfZ9sNsGaV6Nz4HB6FAlkiDmiTiPMObC
aSPI4f0WMYApOzkVvacvfQ9U8b7pcknmrEI8LrVkmjzbRW6mr280/ED1d0RlEK0+
AxqyUGdGu457HWVOYIgegUivRJ1Qner7JgeqqVJMNaoV7behJ/RAZvhCtZL8wAd2
Z8q+7AJRLh2z9f8WDvGGbK1CJESPOuim3PjwzRsZhaoLg9EzllSpSjVEXkgGVV4K
1VuZ8XdY0NpCbDsiXI256XESogGVWb8i14hDfCUBPaIy0oB+rokRJaXeMb+8Vb2Q
1dQhc1yu2kYeDL9r1lcB8b6W9dh+SFK+LoGvDVrPsxQSB4ZO8lA=
=DBjf
-----END PGP SIGNATURE-----

--1R6ZDISWaA1muLP0--
