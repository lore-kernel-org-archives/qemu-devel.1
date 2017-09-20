Received: from eggs.gnu.org ([2001:4830:134:3::10]:36189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duX1E-0007wL-IH
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 00:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duX1B-0001Jp-BD
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 00:53:52 -0400
Date: Wed, 20 Sep 2017 14:38:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170920043852.GG5520@umbus.fritz.box>
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-7-clg@kaod.org>
	<20170919024849.GL27153@umbus>
	<7e43adba-0e65-df5f-b87a-e16115fb3c95@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WkfBGePaEyrk4zXB"
Content-Disposition: inline
In-Reply-To: <7e43adba-0e65-df5f-b87a-e16115fb3c95@kaod.org>
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


--WkfBGePaEyrk4zXB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2017 at 05:08:21PM +0200, C=E9dric Le Goater wrote:
> On 09/19/2017 04:48 AM, David Gibson wrote:
> > On Mon, Sep 11, 2017 at 07:12:20PM +0200, C=E9dric Le Goater wrote:
> >> These are very similar to the XICS handlers in a simpler form. They
> >> make use of the ICSIRQState array of the XICS interrupt source to
> >> differentiate the MSI from the LSI interrupts. The spapr_xive_irq()
> >> routine in charge of triggering the CPU interrupt line will be filled
> >> later on.
> >>
> >> The next patch will introduce the MMIO handlers to interact with XIVE
> >> interrupt sources.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  hw/intc/spapr_xive.c        | 46 ++++++++++++++++++++++++++++++++++++=
+++++++++
> >>  include/hw/ppc/spapr_xive.h |  1 +
> >>  2 files changed, 47 insertions(+)
> >>
> >> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> >> index 52c32f588d6d..1ed7b6a286e9 100644
> >> --- a/hw/intc/spapr_xive.c
> >> +++ b/hw/intc/spapr_xive.c
> >> @@ -27,6 +27,50 @@
> >> =20
> >>  #include "xive-internal.h"
> >> =20
> >> +static void spapr_xive_irq(sPAPRXive *xive, int srcno)
> >> +{
> >> +
> >> +}
> >> +
> >> +/*
> >> + * XIVE Interrupt Source
> >> + */
> >> +static void spapr_xive_source_set_irq_msi(sPAPRXive *xive, int srcno,=
 int val)
> >> +{
> >> +    if (val) {
> >> +        spapr_xive_irq(xive, srcno);
> >> +    }
> >> +}
> >=20
> > So in XICS "srcno" (vs "irq") indicates an offset within a single ICS
> > object, as opposed to a global irq number.  Does that concept even
> > exist in XIVE?
>=20
> We don't really care in the internals. 'srcno' is just an index in the=20
> tables, may be I should change the name. It could be the same in XICS=20
> but the xirr is manipulated at low level and so we need to propagate=20
> the source offset in a couple of places.=20

Right.  My point is that the XICS code deliberately uses srcno vs. irq
names to identify which space we're talking about.  If we re-use the
srcno name in XIVE where it doesn't really apply that could be
misleading.

> This to say that the 'irq' number is a guest level information which
> in the patchset should only be used at the hcall level to identify=20
> a source.

Right, and if there's no need to introduce a number space other than
the guest one, we should keep using that everywhere - and give it a
consistent name to avoid confusion.

> =20
> >> +
> >> +static void spapr_xive_source_set_irq_lsi(sPAPRXive *xive, int srcno,=
 int val)
> >> +{
> >> +    ICSIRQState *irq =3D &xive->ics->irqs[srcno];
> >> +
> >> +    if (val) {
> >> +        irq->status |=3D XICS_STATUS_ASSERTED;
> >> +    } else {
> >> +        irq->status &=3D ~XICS_STATUS_ASSERTED;
> >=20
> > More mangling a XICS specific object for XIVE operations.  Please
> > stop.
>=20
> ah ! we will still need the same information and that means introducing=
=20
> a common source object. The patchset today just uses the XICS ICSIRQState=
=20
> array as a common object.

It's not really the same information though.  For XICS irq->status is
*all* the information about the line's state, for XIVE, most of that
info is in the PQ bits which are elsewhere.  That makes at least some
of the information in ICSIRQState redundant, and therefore confusing
and misleading.

> >> +    }
> >> +
> >> +    if (irq->status & XICS_STATUS_ASSERTED
> >> +        && !(irq->status & XICS_STATUS_SENT)) {
> >> +        irq->status |=3D XICS_STATUS_SENT;
> >> +        spapr_xive_irq(xive, srcno);
> >> +    }
> >> +}
> >> +
> >> +static void spapr_xive_source_set_irq(void *opaque, int srcno, int va=
l)
> >> +{
> >> +    sPAPRXive *xive =3D SPAPR_XIVE(opaque);
> >> +    ICSIRQState *irq =3D &xive->ics->irqs[srcno];
> >> +
> >> +    if (irq->flags & XICS_FLAGS_IRQ_LSI) {
> >> +        spapr_xive_source_set_irq_lsi(xive, srcno, val);
> >> +    } else {
> >> +        spapr_xive_source_set_irq_msi(xive, srcno, val);
> >> +    }
> >> +}
> >> +
> >>  /*
> >>   * Main XIVE object
> >>   */
> >> @@ -80,6 +124,8 @@ static void spapr_xive_realize(DeviceState *dev, Er=
ror **errp)
> >>      }
> >> =20
> >>      xive->ics =3D ICS_BASE(obj);
> >> +    xive->qirqs =3D qemu_allocate_irqs(spapr_xive_source_set_irq, xiv=
e,
> >> +                                     xive->nr_irqs);
> >> =20
> >>      /* Allocate the last IRQ numbers for the IPIs */
> >>      for (i =3D xive->nr_irqs - xive->nr_targets; i < xive->nr_irqs; i=
++) {
> >> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> >> index 29112589b37f..eab92c4c1bb8 100644
> >> --- a/include/hw/ppc/spapr_xive.h
> >> +++ b/include/hw/ppc/spapr_xive.h
> >> @@ -38,6 +38,7 @@ struct sPAPRXive {
> >> =20
> >>      /* IRQ */
> >>      ICSState     *ics;  /* XICS source inherited from the SPAPR machi=
ne */
> >> +    qemu_irq     *qirqs;
> >> =20
> >>      /* XIVE internal tables */
> >>      uint8_t      *sbe;
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WkfBGePaEyrk4zXB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnB8NwACgkQbDjKyiDZ
s5JxNA//VYFPTK3APyhOI4PqT/o9GySvZrazmENKAS/Xr74vRflXFOQ/tMQ5QAai
NPGQlW+8TG4Vxn3zhJrNW+33gWqWacGbrbhjKK6IZSQswJnOdbmPwHvh19UNVX0t
KpRnAnf/Caq71C7y9qQfHwlCIS58ceCtwhh1FVLbDZPycgSRH8FjfgBIhoPxzjMQ
FM2eO1KUfOeDkDFimTFv8ZwfiZXmq5NXtwhnUYq0krNsXLNY9Lklxrssf0h36ub0
vJk8Rgpr/L3vyEwo/qvXqBGx0YydD4mER5H81UPnYlRZ/a6D0D0lcSn1VJ+PkzBl
F8TTJPIvBCWUTtTNTIRgRz/O26+B/l7oDQf+TrxZz2FJYRbKhkYNcz0NFQBorb2c
/0p7AwG6GZs6rh2Q8/ikNoVR/ZEvtFvi/mKa6vzVzX6QMbzUMT77fu0B89cz182d
EuQ4L8pfbQeHgLkNDD3eW8LGRQMNvq61tVhgZyMJCqm+0G6ja2Uy1vIsvkL9rd2D
ngJ0TCCKAsCcw8WKBI35RVfKIVg5sDL6T3fCDTCTzuOFh1CdNZyxp8mX/SMDA3cd
pZ9GcnPJFuH5U2idAxTzdx2P8KhRkHXMBq+MkEeyg+T/Qaf49SSuUOrZpAhX8RKi
gagui/7TD8C8LyROmkzvTl0BriLP2BlkgYFoLo3Qjr1PQe2Hvsg=
=Ap8m
-----END PGP SIGNATURE-----

--WkfBGePaEyrk4zXB--
