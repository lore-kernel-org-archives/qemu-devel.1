Received: from eggs.gnu.org ([2001:4830:134:3::10]:51332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFta-0001J4-QY
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtX-0002yR-3F
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:50 -0400
Date: Tue, 19 Sep 2017 12:48:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170919024849.GL27153@umbus>
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-7-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z9sQuz+HmDh2hVO4"
Content-Disposition: inline
In-Reply-To: <20170911171235.29331-7-clg@kaod.org>
Subject: Re: [Qemu-devel] [RFC PATCH v2 06/21] ppc/xive: introduce handlers
 for interrupt sources
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>


--z9sQuz+HmDh2hVO4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2017 at 07:12:20PM +0200, C=E9dric Le Goater wrote:
> These are very similar to the XICS handlers in a simpler form. They
> make use of the ICSIRQState array of the XICS interrupt source to
> differentiate the MSI from the LSI interrupts. The spapr_xive_irq()
> routine in charge of triggering the CPU interrupt line will be filled
> later on.
>=20
> The next patch will introduce the MMIO handlers to interact with XIVE
> interrupt sources.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/spapr_xive.c        | 46 +++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/ppc/spapr_xive.h |  1 +
>  2 files changed, 47 insertions(+)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 52c32f588d6d..1ed7b6a286e9 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -27,6 +27,50 @@
> =20
>  #include "xive-internal.h"
> =20
> +static void spapr_xive_irq(sPAPRXive *xive, int srcno)
> +{
> +
> +}
> +
> +/*
> + * XIVE Interrupt Source
> + */
> +static void spapr_xive_source_set_irq_msi(sPAPRXive *xive, int srcno, in=
t val)
> +{
> +    if (val) {
> +        spapr_xive_irq(xive, srcno);
> +    }
> +}

So in XICS "srcno" (vs "irq") indicates an offset within a single ICS
object, as opposed to a global irq number.  Does that concept even
exist in XIVE?

> +
> +static void spapr_xive_source_set_irq_lsi(sPAPRXive *xive, int srcno, in=
t val)
> +{
> +    ICSIRQState *irq =3D &xive->ics->irqs[srcno];
> +
> +    if (val) {
> +        irq->status |=3D XICS_STATUS_ASSERTED;
> +    } else {
> +        irq->status &=3D ~XICS_STATUS_ASSERTED;

More mangling a XICS specific object for XIVE operations.  Please
stop.

> +    }
> +
> +    if (irq->status & XICS_STATUS_ASSERTED
> +        && !(irq->status & XICS_STATUS_SENT)) {
> +        irq->status |=3D XICS_STATUS_SENT;
> +        spapr_xive_irq(xive, srcno);
> +    }
> +}
> +
> +static void spapr_xive_source_set_irq(void *opaque, int srcno, int val)
> +{
> +    sPAPRXive *xive =3D SPAPR_XIVE(opaque);
> +    ICSIRQState *irq =3D &xive->ics->irqs[srcno];
> +
> +    if (irq->flags & XICS_FLAGS_IRQ_LSI) {
> +        spapr_xive_source_set_irq_lsi(xive, srcno, val);
> +    } else {
> +        spapr_xive_source_set_irq_msi(xive, srcno, val);
> +    }
> +}
> +
>  /*
>   * Main XIVE object
>   */
> @@ -80,6 +124,8 @@ static void spapr_xive_realize(DeviceState *dev, Error=
 **errp)
>      }
> =20
>      xive->ics =3D ICS_BASE(obj);
> +    xive->qirqs =3D qemu_allocate_irqs(spapr_xive_source_set_irq, xive,
> +                                     xive->nr_irqs);
> =20
>      /* Allocate the last IRQ numbers for the IPIs */
>      for (i =3D xive->nr_irqs - xive->nr_targets; i < xive->nr_irqs; i++)=
 {
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index 29112589b37f..eab92c4c1bb8 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -38,6 +38,7 @@ struct sPAPRXive {
> =20
>      /* IRQ */
>      ICSState     *ics;  /* XICS source inherited from the SPAPR machine =
*/
> +    qemu_irq     *qirqs;
> =20
>      /* XIVE internal tables */
>      uint8_t      *sbe;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--z9sQuz+HmDh2hVO4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnAhZEACgkQbDjKyiDZ
s5IBZw//WnZjC4sPzHjckdWo8xHJNP/P5gcoJ16TCOW/T2ugmMhJY+WDCb3SpsTv
uDZyFgxaFaQnIUBYVxy2fLqf0z0KuT+vb2M/58PISfVZESX9o6RBtBRkVTdUSBEB
k3MKG/2407SHqjEQqFIfArxf9JIwZmdSMD61IHNIyRJoLG+pNi8vQNHwXrM+NfAz
O9pwLPOacI05hajdQKJtqLaa/l83EdY/ImTYI8+Q5wVfPlM4FS6bh6nq8t0fIrD5
UFPGgRoe1SE8kA58lOyiDc1tUBYCPBAuU2uy6ptCSjxO9hUCXhF0N9BN4zcREHTj
pMd8CwcocLDISe38jPVq7qCag/kBq89AQJhgceYLRTnRxTrYhuT2vcjPPRAOtamZ
mE8T4BVy0aJJGas5bB2G0N/HyDP4XdiIgNb5M3EriGBDFFFAsvOyZT73bv/HcLqp
iJmZHDp3/q0tnJJ7SkSlXbiS81kEGD30ty+lwVJtwHzXt+1nwMuVkWhY28FPCklI
ouVqwxmamxNuLuhwuoRB0F01GqYjollXP9A/C8IV6QF5GU3dA+97m2n1GnIiQmcG
5fHCJXsNDJpYfOkzfFJpuHqTWSrbNExMK3uk3rFMsV0QWbuq76Yc8RSVpdt1c4Qv
o6jo2teaasgkD2c+wYUhefsVnyqEsx9XtKDJ0FxtaMg8v+QXbH0=
=hiuZ
-----END PGP SIGNATURE-----

--z9sQuz+HmDh2hVO4--
