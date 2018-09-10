Received: from eggs.gnu.org ([208.118.235.92]:49210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fzFde-0002Jz-Qt
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 02:25:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fzFR5-00026g-FY
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 02:12:36 -0400
Date: Mon, 10 Sep 2018 16:12:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180910061223.GF24181@umbus.fritz.box>
References: <20180730141134.31153-1-clg@kaod.org>
	<20180730141134.31153-5-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DEueqSqTbz/jWVG1"
Content-Disposition: inline
In-Reply-To: <20180730141134.31153-5-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v6 4/4] spapr: increase the size of the IRQ
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


--DEueqSqTbz/jWVG1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 30, 2018 at 04:11:34PM +0200, C=E9dric Le Goater wrote:
> The new layout using static IRQ number does not leave much space to
> the dynamic MSI range, only 0x100 IRQ numbers. Increase the total
> number of IRQS for newer machines and introduce a legacy XICS backend
> for pre-3.1 machines to maintain compatibility.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Sorry, I got sidetracked and forgot about reviewing this patch.


Now that the number of irqs is set in the backend, I think the
reference to XICS_IRQS_SPAPR setting ibm,pe-total-#msi in
spapr_populate_pci_dt() needs to be change to look at the backend
instead...

> ---
>  include/hw/ppc/spapr_irq.h |  1 +
>  hw/ppc/spapr.c             |  1 +
>  hw/ppc/spapr_irq.c         | 12 +++++++++++-
>  3 files changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 0e98c4474bb2..626160ba475e 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -40,6 +40,7 @@ typedef struct sPAPRIrq {
>  } sPAPRIrq;
> =20
>  extern sPAPRIrq spapr_irq_xics;
> +extern sPAPRIrq spapr_irq_xics_legacy;
> =20
>  int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Error *=
*errp);
>  void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num);
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index d9f8cca49208..5ae62b0682d2 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3947,6 +3947,7 @@ static void spapr_machine_3_0_class_options(Machine=
Class *mc)
>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_3_0);
> =20
>      smc->legacy_irq_allocation =3D true;
> +    smc->irq =3D &spapr_irq_xics_legacy;
>  }
> =20
>  DEFINE_SPAPR_MACHINE(3_0, "3.0", false);
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 0cbb5dd39368..620c49b38455 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -196,7 +196,7 @@ static void spapr_irq_print_info_xics(sPAPRMachineSta=
te *spapr, Monitor *mon)
>  }
> =20
>  sPAPRIrq spapr_irq_xics =3D {
> -    .nr_irqs     =3D XICS_IRQS_SPAPR,
> +    .nr_irqs     =3D 0x1000,
> =20
>      .init        =3D spapr_irq_init_xics,
>      .claim       =3D spapr_irq_claim_xics,
> @@ -284,3 +284,13 @@ int spapr_irq_find(sPAPRMachineState *spapr, int num=
, bool align, Error **errp)
> =20
>      return first + ics->offset;
>  }
> +
> +sPAPRIrq spapr_irq_xics_legacy =3D {
> +    .nr_irqs     =3D XICS_IRQS_SPAPR,

=2E. and with that done, I think it makes to just inline the old value
here and remove the XICS_IRQS_SPAPR #define, since its name is no
longer accurate.

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

--DEueqSqTbz/jWVG1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluWC0UACgkQbDjKyiDZ
s5JSAA//R2MJO4V8SN7V2XlreqQyHk3FftR/F3+GbmxRQKAgXYb8LV+H0g1Lgsfi
lIKTGSB0BRxJfin72xDRps6oyjbadzES58THz0awaL+id5/5UcVA7ur0ZdCCxFN7
0RTxhU+fheHdVqoNQKuMnx2n/6JefANvEQOrrsPZCPUu4qR858RMrbvwouBt5Yer
qpxbucocx1WCL1pGZHYTOpOg/cY1U5d8+JMo0oyYNDudv7Ntq5xG+ASYSlK1UCmN
/pPhCFgu6LsM7ZdDjQNPt7PBz7bodptLAXvC/oWDE8I0u+WHvoXEw3Uo68Esbxvs
ME328XK5HJB3s8nN307wBTqBeuHgDEHMkOlx5IXTPUbLRuPINFM//E5bU0shRSmp
ypicHOYWbwDWNrQr+LjgkMJiR185EfF53/1sVnEwUbVHCBzmzBv1gFAL/6R1QVr3
TjLrA1HaOJty5rgmh1Mkw8sXtW6LKaZdOgz8VgDuTnk10X+horjWQGYbzSO/Js1e
Od3/oChQ40GlaYeKALvHalwUuYj8C0CeGUMSk4kShh7MLa4gCgVEeDqAp1ETKU0c
FVr4LHA+sVVmd/SKjrkcKY1X8MdnSaW/YCOD2Y12rc+Mi8PTY4cyKm8xdAb3cfOv
ea6VIu+NTMTsKWChGTyZJFGzr+hKw4Pm3/I6x4MYoFGsMztawno=
=HbYV
-----END PGP SIGNATURE-----

--DEueqSqTbz/jWVG1--
