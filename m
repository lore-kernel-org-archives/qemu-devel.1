Received: from eggs.gnu.org ([2001:4830:134:3::10]:47810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fQ2ye-00088D-3s
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 23:49:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fQ2ya-0005gl-79
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 23:49:44 -0400
Date: Tue, 5 Jun 2018 13:44:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180605034418.GV5140@umbus.fritz.box>
References: <20180518164405.11804-1-clg@kaod.org>
	<20180518164405.11804-3-clg@kaod.org>
	<20180526114023.49ee54e9@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="X6f5cqjOqKjuoPgI"
Content-Disposition: inline
In-Reply-To: <20180526114023.49ee54e9@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 2/4] sparp_pci: simplify how the PCI LSIs
 are allocated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>


--X6f5cqjOqKjuoPgI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 26, 2018 at 11:40:23AM +0200, Greg Kurz wrote:
> On Fri, 18 May 2018 18:44:03 +0200
> C=E9dric Le Goater <clg@kaod.org> wrote:
>=20
> > PCI LSIs are today allocated one by one using the IRQ alloc_block
> > routine. Change the code sequence to first allocate a PCI_NUM_PINS
> > block. It will help us providing a generic IRQ framework to the
> > machine.
> >=20
> > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > ---
> >  hw/ppc/spapr_pci.c | 21 ++++++++++-----------
> >  1 file changed, 10 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index 39a14980d397..4fd97ffe4c6e 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -1546,6 +1546,8 @@ static void spapr_phb_realize(DeviceState *dev, E=
rror **errp)
> >      sPAPRTCETable *tcet;
> >      const unsigned windows_supported =3D
> >          sphb->ddw_enabled ? SPAPR_PCI_DMA_MAX_WINDOWS : 1;
> > +    uint32_t irq;
> > +    Error *local_err =3D NULL;
> > =20
> >      if (!spapr) {
> >          error_setg(errp, TYPE_SPAPR_PCI_HOST_BRIDGE " needs a pseries =
machine");
> > @@ -1694,18 +1696,15 @@ static void spapr_phb_realize(DeviceState *dev,=
 Error **errp)
> >      QLIST_INSERT_HEAD(&spapr->phbs, sphb, list);
> > =20
> >      /* Initialize the LSI table */
> > -    for (i =3D 0; i < PCI_NUM_PINS; i++) {
> > -        uint32_t irq;
> > -        Error *local_err =3D NULL;
> > -
> > -        irq =3D spapr_irq_alloc_block(spapr, 1, true, false, &local_er=
r);
> > -        if (local_err) {
> > -            error_propagate(errp, local_err);
> > -            error_prepend(errp, "can't allocate LSIs: ");
> > -            return;
> > -        }
> > +    irq =3D spapr_irq_alloc_block(spapr, PCI_NUM_PINS, true, false, &l=
ocal_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        error_prepend(errp, "can't allocate LSIs: ");
> > +        return;
> > +    }
> > =20
>=20
> It isn't strictly equivalent. The current code would be happy with
> sparse IRQ numbers, while the proposed one wouldn't... Anyway, this
> cannot happen since we don't have PHB hotplug.

This makes me pretty nervous, because it's not obvious it will come up
with the same numbers in all circumstances, which we have to do for
existing machine types.  It's also not obvious to me why it's useful
to go via this step before going straight to static allocation of the
irq numbers.

If you can convince me this will (in practice) return the same numbers
as the existing code for all valid setups, and that it's a useful
intermediate step, then I'll apply it.

>=20
> > -        sphb->lsi_table[i].irq =3D irq;
> > +    for (i =3D 0; i < PCI_NUM_PINS; i++) {
> > +        sphb->lsi_table[i].irq =3D irq + i;
> >      }
> > =20
> >      /* allocate connectors for child PCI devices */
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--X6f5cqjOqKjuoPgI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsWBxAACgkQbDjKyiDZ
s5L/pxAAvm3HW1Dh0CAB+xigJJOZpK3UX5y/IfpWCfcz6spKKDIiJeMiJVuUnAl4
ItxcJn7PMjfoUhr9cLeOxf6MAnvreMK0cONOnC6fkS5dpDghKIbfYp/e6vdQX5Uy
TIaOP4MMt/5DZBS7aaiYRQNzEG5lOto23NTUB/QcDyfZ+SJmhdsy0/oBjPdnCFYq
cAEXMAmC75W+sISAd3QbZiUgVhKqkjKK2AN/NXMh4nIOuASF2FUKcNFvAAEDy91y
e5bl43ixVi1BySo0wBz6n40NeitCDGDEvnrVPDU1fb6ceuTJk/39Th8kPNqS9AQT
BXi5vp32dHcnv/Dynm49ynLdNB7AjjwbdC2ecr6m7/oY9v0fBf14FL74qKCUsyMo
9jLZTf9JyS146KktLxbTFG4rZ8Gn/Tb1YZpzJVD/8YFhVOIjZsfPeFqYx1tZP06R
FpO2YQuE/ahN7QeFTP0tu4/LvUfK7XpHRC2qND5njNreEmchC21uIsDXyiZueFGH
/cDW/pvK8+xGSUPp1Shf1IgFl8zwJHnQfgtKD1916mH0HsLT/H8+jMliDPYe+oPy
a6GLsVqwk+QJGcfWbPMWkVnqpDG1xhktLqvWFHBh5mo+UJUtvI/i+u73+LkjTReQ
GiOMcytmiEyh+qDIAJQE3q5cHmSt1WJJS1HX/To+TdR633BY4Vw=
=uNix
-----END PGP SIGNATURE-----

--X6f5cqjOqKjuoPgI--
