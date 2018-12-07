Received: from eggs.gnu.org ([2001:4830:134:3::10]:40373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gV7S1-0002QS-Eh
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 23:09:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gV7Rw-0006lJ-CR
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 23:09:17 -0500
Date: Fri, 7 Dec 2018 15:04:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181207040408.GC10945@umbus.fritz.box>
References: <20181205232251.10446-1-clg@kaod.org>
	<20181205232251.10446-14-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Content-Disposition: inline
In-Reply-To: <20181205232251.10446-14-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v6 13/37] spapr: introduce a
 spapr_irq_init() routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 06, 2018 at 12:22:27AM +0100, C=E9dric Le Goater wrote:
> Initialize the MSI bitmap from it as this will be necessary for the
> sPAPR IRQ backend for XIVE.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

This also stands on its own, so I've applied it.

> ---
>  include/hw/ppc/spapr_irq.h |  1 +
>  hw/ppc/spapr.c             |  2 +-
>  hw/ppc/spapr_irq.c         | 16 +++++++++++-----
>  3 files changed, 13 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index a467ce696ee4..bd7301e6d9c6 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -43,6 +43,7 @@ typedef struct sPAPRIrq {
>  extern sPAPRIrq spapr_irq_xics;
>  extern sPAPRIrq spapr_irq_xics_legacy;
> =20
> +void spapr_irq_init(sPAPRMachineState *spapr, Error **errp);
>  int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Error *=
*errp);
>  void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num);
>  qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 50cb9f9f4a02..e470efe7993c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2594,7 +2594,7 @@ static void spapr_machine_init(MachineState *machin=
e)
>      spapr_set_vsmt_mode(spapr, &error_fatal);
> =20
>      /* Set up Interrupt Controller before we create the VCPUs */
> -    smc->irq->init(spapr, &error_fatal);
> +    spapr_irq_init(spapr, &error_fatal);
> =20
>      /* Set up containers for ibm,client-architecture-support negotiated =
options
>       */
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index e77b94cc685e..f8b651de0ec9 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -97,11 +97,6 @@ static void spapr_irq_init_xics(sPAPRMachineState *spa=
pr, Error **errp)
>      int nr_irqs =3D smc->irq->nr_irqs;
>      Error *local_err =3D NULL;
> =20
> -    /* Initialize the MSI IRQ allocator. */
> -    if (!SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
> -        spapr_irq_msi_init(spapr, smc->irq->nr_msis);
> -    }
> -
>      if (kvm_enabled()) {
>          if (machine_kernel_irqchip_allowed(machine) &&
>              !xics_kvm_init(spapr, &local_err)) {
> @@ -213,6 +208,17 @@ sPAPRIrq spapr_irq_xics =3D {
>  /*
>   * sPAPR IRQ frontend routines for devices
>   */
> +void spapr_irq_init(sPAPRMachineState *spapr, Error **errp)
> +{
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> +
> +    /* Initialize the MSI IRQ allocator. */
> +    if (!SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
> +        spapr_irq_msi_init(spapr, smc->irq->nr_msis);
> +    }
> +
> +    smc->irq->init(spapr, errp);
> +}
> =20
>  int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Error *=
*errp)
>  {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwJ8TgACgkQbDjKyiDZ
s5LkjRAA3aXFAgMorYBGTwUv4UvU/Msq3Vohs4MKiSzB7Og5WGVUJxL3nMpamBi8
K2zrlj8by+NNqVultHpn56xgaUUNsZHDFnwdOtHxRJ9pyHsOYCGvjbvZIxF0E01F
4bfU8Bl/XkSzeN2uo492NW15OVCHmxKJswQFQQCistLcvw1FyCCRAbQTFuBFKf9V
bHMzAq4G4yIFElOatmOFfLUg0FXaeNoRSWoFXZu/FdQ36hbKRRzAeqW+7IYKeOwJ
tluFr6UnDkCy2i/y9e1L+Z62Im6ic2DRgi3mQ930ZYINAGkXCAlUftK/MEc8ehrE
aSkmuKPi+4SXbOVtZskSIR73JwCP21UZCPl6T56E3wmQbOea9Sl4btscTXGObLYh
pVllR85rODitVRkV054aEa1ThDdSGXpMduwlqkEg09FHaY7+Vd9vdEy736skUTET
7wyuK6QIiZD8lhVzdUN7kZVxPIwg1Vhwwv3qj7C0cMJoGBLnseeGGs9i2SDF0YnE
M6YrwFK/t01I4+L//9GoXQVVBjxmyIGoh8yOboF9KyVnzA5/NkRCgIYGywO50ML1
4Ws04EA73UVwogv1vBXFwa2xItY3ayxQvdv8j71om2+uycQs57txDJzKpz0mHMkq
KMc8E7iJR6he6k21RhdVw4cR53JVdZhqr0IKO9zeiYqwbnEko8w=
=mTZw
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--
