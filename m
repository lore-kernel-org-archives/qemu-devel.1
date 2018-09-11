Received: from eggs.gnu.org ([2001:4830:134:3::10]:44200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fzY16-000287-Nr
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 22:03:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fzXrP-0007dV-3u
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 21:53:02 -0400
Date: Tue, 11 Sep 2018 11:49:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180911014938.GF7978@umbus.fritz.box>
References: <20180910110222.8162-1-clg@kaod.org>
	<20180910110222.8162-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E7i4zwmWs5DOuDSH"
Content-Disposition: inline
In-Reply-To: <20180910110222.8162-3-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 2/3] spapr: increase the size of the IRQ
 number space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>


--E7i4zwmWs5DOuDSH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 10, 2018 at 01:02:21PM +0200, C=E9dric Le Goater wrote:
> The new layout using static IRQ number does not leave much space to
> the dynamic MSI range, only 0x100 IRQ numbers. Increase the total
> number of IRQS for newer machines and introduce a legacy XICS backend
> for pre-3.1 machines to maintain compatibility.
>=20
> For the old backend, provide a 'nr_msis' value covering the full IRQ
> number space as it does not use the bitmap allocator to allocate MSI
> interrupt numbers.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/spapr_irq.h |  1 +
>  hw/ppc/spapr.c             |  1 +
>  hw/ppc/spapr_irq.c         | 15 ++++++++++++++-
>  3 files changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 650f810ad2aa..a467ce696ee4 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -41,6 +41,7 @@ typedef struct sPAPRIrq {
>  } sPAPRIrq;
> =20
>  extern sPAPRIrq spapr_irq_xics;
> +extern sPAPRIrq spapr_irq_xics_legacy;
> =20
>  int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Error *=
*errp);
>  void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num);
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 4a9dd4d9bc14..eba7d60a30a7 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3971,6 +3971,7 @@ static void spapr_machine_3_0_class_options(Machine=
Class *mc)
>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_3_0);
> =20
>      smc->legacy_irq_allocation =3D true;
> +    smc->irq =3D &spapr_irq_xics_legacy;
>  }
> =20
>  DEFINE_SPAPR_MACHINE(3_0, "3.0", false);
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index d369ac96f5cd..b14d7bce00ea 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -195,7 +195,7 @@ static void spapr_irq_print_info_xics(sPAPRMachineSta=
te *spapr, Monitor *mon)
>      ics_pic_print_info(spapr->ics, mon);
>  }
> =20
> -#define SPAPR_IRQ_XICS_NR_IRQS     XICS_IRQS_SPAPR
> +#define SPAPR_IRQ_XICS_NR_IRQS     0x1000
>  #define SPAPR_IRQ_XICS_NR_MSIS     \
>      (XICS_IRQ_BASE + SPAPR_IRQ_XICS_NR_IRQS - SPAPR_IRQ_MSI)
> =20
> @@ -289,3 +289,16 @@ int spapr_irq_find(sPAPRMachineState *spapr, int num=
, bool align, Error **errp)
> =20
>      return first + ics->offset;
>  }
> +
> +#define SPAPR_IRQ_XICS_LEGACY_NR_IRQS     XICS_IRQS_SPAPR

AFAICT this is the last user of XICS_IRQS_SPAPR, so better to put the
constant right here, rather than copying it from a define with a
misleading name.

> +
> +sPAPRIrq spapr_irq_xics_legacy =3D {
> +    .nr_irqs     =3D SPAPR_IRQ_XICS_LEGACY_NR_IRQS,
> +    .nr_msis     =3D SPAPR_IRQ_XICS_LEGACY_NR_IRQS,
> +
> +    .init        =3D spapr_irq_init_xics,
> +    .claim       =3D spapr_irq_claim_xics,
> +    .free        =3D spapr_irq_free_xics,
> +    .qirq        =3D spapr_qirq_xics,
> +    .print_info  =3D spapr_irq_print_info_xics,
> +};

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--E7i4zwmWs5DOuDSH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluXHzIACgkQbDjKyiDZ
s5IIzQ//c+3Ay30p1E8yMS6EZW83dmk7OccBXPEzURGN6u+kc5EgelC2Jte4AwW3
wsE9VH2YW/nBKr6l8xVhtsC9aXREt+sRkre2f7dkK+BRJbrsnyT/4niAuBSm1XG+
kRhxLyqExlQPKO6Kotp/zry5Trz+YgwHlv1MbwBxksSwz0Ap58XdsepPZ/895w87
cmWwfms1mpomWbryH5WskTLuCPCbW8bqSPYs8E2ooKTT8ViEtBJGAkeT2MlHb3Ww
vGmqKmU+vkyZLQvPJ1SXGxMXNgKQnblmdQ/QMLz64MJMRxqn5RwuG0r6DjX1+blF
SS/pjiqPsyBcUwWVEIWRFwID5XnvAt0LXAV0ZhS06lJthbmP7iTf3WXaV6un4qQq
nCxMXWhJjbNYWv9yZ2/FkwexLOQsNnXgwP1n6D+tard2lTwgnbCn/7Q1XhS9NuAD
IHq+j8DwZP1NeoPw2/Q2ye5P0b3X7Uud/WIGLLC346+EzynlOrqExZP/oAPioqJb
Gtc3iQoMzccy+P1NxFjJXHfn2zH7jHjmcQZM8TjYNfjhXbRSC8amxFg+wLcRjo1B
MnNsVTCfADNBmld3SsEbGuxZ4N72GmyUT41UCyuqskKb0oaa7K6L1V4gjeaMsLff
0xxhYF6IaE8RDf7VgeHmcxaQw2p/Vwi8eGLHZugBdSbt40z7ML0=
=kMyQ
-----END PGP SIGNATURE-----

--E7i4zwmWs5DOuDSH--
