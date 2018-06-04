Received: from eggs.gnu.org ([2001:4830:134:3::10]:34373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fPilY-000272-44
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 02:14:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fPilV-0006Wu-5L
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 02:14:52 -0400
Date: Mon, 4 Jun 2018 12:42:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180604024204.GJ4251@umbus>
References: <152700944859.346734.1389264286134807488.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LG0Ll82vYr46+VA1"
Content-Disposition: inline
In-Reply-To: <152700944859.346734.1389264286134807488.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH for-2.11.2] spapr: make pseries-2.11 the
 default machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-stable@nongnu.org, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>


--LG0Ll82vYr46+VA1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 22, 2018 at 07:17:28PM +0200, Greg Kurz wrote:
> The spapr capability framework was introduced in QEMU 2.12. It allows
> to have an explicit control on how host features are exposed to the
> guest. This is especially needed to handle migration between hetero-
> geneous hosts (eg, POWER8 to POWER9). It is also used to expose fixes/
> workarounds against speculative execution vulnerabilities to guests.
> The framework was hence backported to QEMU 2.11.1, especially these
> commits:
>=20
> 0fac4aa93074 spapr: Add pseries-2.12 machine type
> 9070f408f491 spapr: Treat Hardware Transactional Memory (HTM) as an
>  optional capability
>=20
> 0fac4aa93074 has the confusing effect of making pseries-2.12 the default
> machine type for QEMU 2.11.1, instead of the expected pseries-2.11. This
> patch changes the default machine back to pseries-2.11.
>=20
> Unfortunately, 9070f408f491 enforces the HTM capability for pseries-2.11.
> This isn't supported by TCG and breaks 'make check'. So this patch also
> adds a hack to turn HTM off when using TCG.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr.c      |    4 ++--
>  hw/ppc/spapr_caps.c |    5 +++++
>  2 files changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 1a2dd1f597d9..6499a867520f 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3820,7 +3820,7 @@ static void spapr_machine_2_12_class_options(Machin=
eClass *mc)
>      /* Defaults for the latest behaviour inherited from the base class */
>  }
> =20
> -DEFINE_SPAPR_MACHINE(2_12, "2.12", true);
> +DEFINE_SPAPR_MACHINE(2_12, "2.12", false);
> =20
>  /*
>   * pseries-2.11
> @@ -3842,7 +3842,7 @@ static void spapr_machine_2_11_class_options(Machin=
eClass *mc)
>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_11);
>  }
> =20
> -DEFINE_SPAPR_MACHINE(2_11, "2.11", false);
> +DEFINE_SPAPR_MACHINE(2_11, "2.11", true);
> =20
>  /*
>   * pseries-2.10
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 7b229517be38..82043e60e78b 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -285,6 +285,11 @@ static sPAPRCapabilities default_caps_with_cpu(sPAPR=
MachineState *spapr,
> =20
>      caps =3D smc->default_caps;
> =20
> +    /* HACK for 2.11.2: fix make check */
> +    if (tcg_enabled()) {
> +        caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
> +    }
> +
>      if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_07,
>                            0, spapr->max_compat_pvr)) {
>          caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LG0Ll82vYr46+VA1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsUpvoACgkQbDjKyiDZ
s5JIEQ//Rse10NIGVbrMtwM/z9aEX+Ht20mHFvATQ7VjqujeLYHIOY4ogpCprDDa
oXCQoj7MjeR1F/GLMFDBIjh7HcnJ8JFpKBfsJTO6pJ86y43MhmhBA4HO5ICUwAHV
xNX06ELjR133WEt2G82H5Tet/sxFdr4blcUgineQidus4ewTbHBrYaGE8DJEFGoh
XXtiD0JewKtTzOyA5TGIb6yNOTsqixrlBypVfMCRI6/Z7qNAv3i4aLLfnvxGwTjF
etZlc6uFbjVjn1iD2/zlW5pB+/va8ma6GjX6wdsPT6Cs6dtSWwG3YV3bXwsevNUP
WyPaB/56pP7S0vV1NmosfrdOGywC9QOxacnuFQLpMwCYb/kXT7UwhuVIYdaUsvd2
J31N+W9cQDH2wi/+ibQoZvxLOQTcG3RLdK0IcDL9iDY9EzhNxZ0OVvbh6AKmWB7v
rxibyiWI8df5BqINXHeobjEdVwRq3wYYrKd7PoMCNnBR8RTabH9oe4df3cc25Dk0
QJCqPrbqA4dNMbLHD9v2naF8oLBggAQHUg9LE4pVQZIlQtzcfsBg17GTBv1uorm0
BtGD70cC3i5+8H8pGQjKTma4P9fYW0oZQQLKLFwTVvedv0ZP5qByARGbTzL4adS/
WKlw1a28Z84YECGdRoyXLvK/FE7BqQSStRdBKJ1AH4kpKAKhz1A=
=I2o2
-----END PGP SIGNATURE-----

--LG0Ll82vYr46+VA1--
