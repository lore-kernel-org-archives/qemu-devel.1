Received: from eggs.gnu.org ([2001:4830:134:3::10]:46168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gRqWb-0002px-Im
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 22:28:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gRqWa-00036j-L3
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 22:28:29 -0500
Date: Wed, 28 Nov 2018 13:59:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181128025923.GX2251@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-14-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mlvFMpb4NrD3AMcD"
Content-Disposition: inline
In-Reply-To: <20181116105729.23240-14-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v5 13/36] spapr: introduce a
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


--mlvFMpb4NrD3AMcD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 16, 2018 at 11:57:06AM +0100, C=E9dric Le Goater wrote:
> Initialize the MSI bitmap from it as this will be necessary for the
> sPAPR IRQ backend for XIVE.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

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

--mlvFMpb4NrD3AMcD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv+BIsACgkQbDjKyiDZ
s5JI0Q/7BUz0fNgeJe1KWwpv1qokBM98mN5CsgJCu5jT5tFe5VYf+S0aa9AGL8Zr
Y7yE+shahb1R6hbzBluOdG/RvhRh3ecDIkAD/WaKdj5q34AAyuvMdoAipbHDct4A
hBVJrmeT2hPJ1LKO4Xr27XizwloEoCSjddFXmbZKMDD62w1WV/7FKiln2Oumlr6d
bmo2tAHASvAvyTxw5/ckXzDdZubLaYU8uof3kz2z9u+TIzX/PQtYsiKoemxMMgZL
0StutCKB+Vo5j5gWGFWbhA8xz2XNu49qUzH7T3UNTkY9jlyR76lh5PRaCYpRlaHd
0ggz6OVWDXG17vUidi/AVVOqMmO1vGhQ1svxebMEwtu26A6l3KifPh2t9XW5bz/4
tBUYA/eskdWhcSpp/xUsJHM26GdcaXpwUOhEjVDzMHLpV+ZzOCFnDecL/2q1CQF3
7q8RDkFR8eRZgi7eb60vrcPj73VHgcoCt2r2wVswuYqXMnkOyLOlTqhxofSPOqsh
pmih4swiEUCANLeUbXQ8ymW1ytLoPmkjJuzUAFMpcq9WUlmwAzeQWyYJZSMfqYH4
8jjYw/nes8FO9QVyyGeQ/BOsR5W3ab9zAeciJ6r1bXBfCCVFQG8Kn6w7vQR5myAp
ZUW8BSf5T1GcTJDUpIBRZq0FNI3g1IiWce01zYGOpE2d2yzCf0s=
=6sRT
-----END PGP SIGNATURE-----

--mlvFMpb4NrD3AMcD--
