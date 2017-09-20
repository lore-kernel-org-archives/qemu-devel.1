Received: from eggs.gnu.org ([2001:4830:134:3::10]:36194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duX1E-0007wN-Jx
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 00:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duX1B-0001Jb-A5
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 00:53:52 -0400
Date: Wed, 20 Sep 2017 14:31:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170920043125.GD5520@umbus.fritz.box>
References: <150539846159.21523.16161730500010192093.stgit@bahia>
	<150539848430.21523.2732328570419779115.stgit@bahia>
	<20170918230358.GG27153@umbus>
	<20170919160357.082b991f@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k4f25fnPtRuIRUb3"
Content-Disposition: inline
In-Reply-To: <20170919160357.082b991f@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] spapr_pci: make index property
 mandatory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>


--k4f25fnPtRuIRUb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2017 at 04:03:57PM +0200, Greg Kurz wrote:
> On Tue, 19 Sep 2017 09:03:58 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, Sep 14, 2017 at 04:14:44PM +0200, Greg Kurz wrote:
> > > Creating several PHBs without index property confuses the DRC code
> > > and causes issues:
> > > - only the first index-less PHB is functional, the other ones will
> > >   silently ignore hotplugging of PCI devices
> > > - QEMU will even terminate if these PHBs have cold-plugged devices =
=20
> >=20
> > So, this is true, but it's kind of missing the point; we could fix
> > those things if we wanted.  The real point here is that the non-index
> > option is more trouble than it's worth: it's difficult to use, keeps
> > requiring (potentially incompatible) changes when some new parameter
> > needs adding, and is awkward to check for collisions.
> >=20
>=20
> Ok, I'll rewrite the changelog accordingly in the next spin.
>=20
> > > qemu-system-ppc64: -device virtio-net,bus=3Dpci2.0: an attached device
> > >  is still awaiting release
> > >=20
> > > This happens because DR connectors for child PCI devices are created
> > > with a DRC index that is derived from the PHB's index property. If the
> > > PHBs are created without index, then the same value of -1 is used to
> > > compute the DRC indexes for both PHBs, hence causing the collision.
> > >=20
> > > Also, the index property is used to compute the placement of the PHB's
> > > memory regions. It is limited to 31 or 255, depending on the machine
> > > type version. This fits well with the requirements of DRC indexes, wh=
ich
> > > need the PHB index to be a 16-bit value.
> > >=20
> > > This patch hence makes the index property mandatory. As a consequence,
> > > the PHB's memory regions and BUID are now always configured according
> > > to the index, and it is no longer possible to set them from the comma=
nd
> > > line. We have to introduce a PHB instance init function to initialize
> > > the 64-bit window address to -1 because pseries-2.7 and older machines
> > > don't set it.
> > >=20
> > > This DOES BREAK backwards compat, but we don't think the non-index
> > > PHB feature was used in practice (at least libvirt doesn't) and the
> > > simplification is worth it.
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > > v1->v2: - error out if mem64_win_pciaddr is set but mem64_win_size
> > >           isn't
> > >         - set mem64_win_addr to -1 for old configuration with 32-bit
> > >           window below 2G in spapr_phb_realize()
> > >         - drop instance init function
> > >=20
> > > RFC->v1: - as suggested dy David, updated the changelog to explicitely
> > >            mention that we intentionally break backwards compat.
> > > ---
> > >  hw/ppc/spapr_pci.c |   53 +++++++++++-------------------------------=
----------
> > >  1 file changed, 11 insertions(+), 42 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > > index cf54160526fa..024638e18b53 100644
> > > --- a/hw/ppc/spapr_pci.c
> > > +++ b/hw/ppc/spapr_pci.c
> > > @@ -1523,16 +1523,6 @@ static void spapr_phb_realize(DeviceState *dev=
, Error **errp)
> > >          sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> > >          Error *local_err =3D NULL;
> > > =20
> > > -        if ((sphb->buid !=3D (uint64_t)-1) || (sphb->dma_liobn[0] !=
=3D (uint32_t)-1)
> > > -            || (sphb->dma_liobn[1] !=3D (uint32_t)-1 && windows_supp=
orted =3D=3D 2)
> > > -            || (sphb->mem_win_addr !=3D (hwaddr)-1)
> > > -            || (sphb->mem64_win_addr !=3D (hwaddr)-1)
> > > -            || (sphb->io_win_addr !=3D (hwaddr)-1)) {
> > > -            error_setg(errp, "Either \"index\" or other parameters m=
ust"
> > > -                       " be specified for PAPR PHB, not both");
> > > -            return;
> > > -        }
> > > -
> > >          smc->phb_placement(spapr, sphb->index,
> > >                             &sphb->buid, &sphb->io_win_addr,
> > >                             &sphb->mem_win_addr, &sphb->mem64_win_add=
r,
> > > @@ -1541,36 +1531,12 @@ static void spapr_phb_realize(DeviceState *de=
v, Error **errp)
> > >              error_propagate(errp, local_err);
> > >              return;
> > >          }
> > > -    }
> > > -
> > > -    if (sphb->buid =3D=3D (uint64_t)-1) {
> > > -        error_setg(errp, "BUID not specified for PHB");
> > > -        return;
> > > -    }
> > > -
> > > -    if ((sphb->dma_liobn[0] =3D=3D (uint32_t)-1) ||
> > > -        ((sphb->dma_liobn[1] =3D=3D (uint32_t)-1) && (windows_suppor=
ted > 1))) {
> > > -        error_setg(errp, "LIOBN(s) not specified for PHB");
> > > -        return;
> > > -    }
> > > -
> > > -    if (sphb->mem_win_addr =3D=3D (hwaddr)-1) {
> > > -        error_setg(errp, "Memory window address not specified for PH=
B");
> > > -        return;
> > > -    }
> > > -
> > > -    if (sphb->io_win_addr =3D=3D (hwaddr)-1) {
> > > -        error_setg(errp, "IO window address not specified for PHB");
> > > +    } else {
> > > +        error_setg(errp, "\"index\" for PAPR PHB is mandatory");
> > >          return;
> > >      }
> > > =20
> > >      if (sphb->mem64_win_size !=3D 0) {
> > > -        if (sphb->mem64_win_addr =3D=3D (hwaddr)-1) {
> > > -            error_setg(errp,
> > > -                       "64-bit memory window address not specified f=
or PHB");
> > > -            return;
> > > -        }
> > > -
> > >          if (sphb->mem_win_size > SPAPR_PCI_MEM32_WIN_SIZE) {
> > >              error_setg(errp, "32-bit memory window of size 0x%"HWADD=
R_PRIx
> > >                         " (max 2 GiB)", sphb->mem_win_size); =20
> >=20
> > Some of these checks could probably just become assert()s now, where
> > they're things determined by the placement code and no longer have
> > parameters, a problem indicates a bug in the machine rather than a
> > user error.
> >=20
>=20
> All the *_size properties are still user settable, as before... should we
> make them internal and have the placement hook initialize them instead ?

Ah, good point.  I guess that still makes sense.

> > > @@ -1581,6 +1547,9 @@ static void spapr_phb_realize(DeviceState *dev,=
 Error **errp)
> > >              /* 64-bit window defaults to identity mapping */
> > >              sphb->mem64_win_pciaddr =3D sphb->mem64_win_addr;
> > >          }
> > > +    } else if (sphb->mem64_win_pciaddr !=3D (hwaddr) -1) {
> > > +        error_setg(errp, "64-bit memory window requires \"mem64_win_=
size\"");
> > > +        return; =20
> >=20
> > Likewise this new one.
> >=20
>=20
> mem64_win_pciaddr is still user settable as well...

That doesn't sound like a good idea.  If we're making index mandatory,
we might has well have it set *all* the windows.

>=20
> > >      } else if (sphb->mem_win_size > SPAPR_PCI_MEM32_WIN_SIZE) {
> > >          /*
> > >           * For compatibility with old configuration, if no 64-bit MM=
IO
> > > @@ -1594,6 +1563,12 @@ static void spapr_phb_realize(DeviceState *dev=
, Error **errp)
> > >          sphb->mem64_win_pciaddr =3D
> > >              SPAPR_PCI_MEM_WIN_BUS_OFFSET + SPAPR_PCI_MEM32_WIN_SIZE;
> > >          sphb->mem_win_size =3D SPAPR_PCI_MEM32_WIN_SIZE;
> > > +    } else {
> > > +        /* Old configuration with the 32-bit MMIO window <=3D 2GiB d=
on't need a
> > > +         * 64-bit MMIO window.
> > > +         */ =20
> >=20
> > Wouldn't it be easier to just change the test below to check for size
> > !=3D 0 instead of checking for addr !=3D -1 as it does now.
> >=20
>=20
> Yeah indeed.
>=20
> > > +        sphb->mem64_win_addr =3D (hwaddr) -1;
> > > +        sphb->mem64_win_pciaddr =3D (hwaddr) -1;
> > >      }
> > > =20
> > >      if (spapr_pci_find_phb(spapr, sphb->buid)) {
> > > @@ -1789,18 +1764,12 @@ static void spapr_phb_reset(DeviceState *qdev)
> > > =20
> > >  static Property spapr_phb_properties[] =3D {
> > >      DEFINE_PROP_UINT32("index", sPAPRPHBState, index, -1),
> > > -    DEFINE_PROP_UINT64("buid", sPAPRPHBState, buid, -1),
> > > -    DEFINE_PROP_UINT32("liobn", sPAPRPHBState, dma_liobn[0], -1),
> > > -    DEFINE_PROP_UINT32("liobn64", sPAPRPHBState, dma_liobn[1], -1),
> > > -    DEFINE_PROP_UINT64("mem_win_addr", sPAPRPHBState, mem_win_addr, =
-1),
> > >      DEFINE_PROP_UINT64("mem_win_size", sPAPRPHBState, mem_win_size,
> > >                         SPAPR_PCI_MEM32_WIN_SIZE),
> > > -    DEFINE_PROP_UINT64("mem64_win_addr", sPAPRPHBState, mem64_win_ad=
dr, -1),
> > >      DEFINE_PROP_UINT64("mem64_win_size", sPAPRPHBState, mem64_win_si=
ze,
> > >                         SPAPR_PCI_MEM64_WIN_SIZE),
> > >      DEFINE_PROP_UINT64("mem64_win_pciaddr", sPAPRPHBState, mem64_win=
_pciaddr,
> > >                         -1),
> > > -    DEFINE_PROP_UINT64("io_win_addr", sPAPRPHBState, io_win_addr, -1=
),
> > >      DEFINE_PROP_UINT64("io_win_size", sPAPRPHBState, io_win_size,
> > >                         SPAPR_PCI_IO_WIN_SIZE),
> > >      DEFINE_PROP_BOOL("dynamic-reconfiguration", sPAPRPHBState, dr_en=
abled,
> > >  =20
> >=20
>=20
>=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--k4f25fnPtRuIRUb3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnB7x0ACgkQbDjKyiDZ
s5LtQRAAjf3DvLvpVQ7kdax712R/PTp7s8UhbmM+W8V3vgRHBjp+SpSF4dUVnXM3
DaJ1cT7+mJweB76LVmicdDDNWQyzgRK60M4NJawbgiAZH4QBxBBKUMveg7Z6XH3w
N4ioF7ooHXndPW5/8S7cxrcmvM/eQPASTXFJlgYw9hpCtoDDq96rIp5snxck2FKt
ifFsqeID0z38HebQUHuDhjYF5L4PD1FpW2vUxd6eYSTVUtzSnKSiWYhmpJR7Si/p
kPSSSnNz/r/e8fPK+d0HcD8k/Gyx8wiDT4JdR2YXDIUoEYKcLqmN/gjL/0raQ/Jq
L1yMttqpVA0eBchOSL7mPXG3+kH2heoL2XnrHkK7vr8ZaD6PpP3n69VjorrFNO0H
GRLCBRG054lU0Jndubr99aVTOKLZKmCPzk1M2BqKsiuDuWOD1zJ6xb8YiKsjBLg0
MFGc9/pN/Wap2i4FF0jhc88dwkeD4i8k/TK9mD6Os+AI/V5EgejC9Px4ngjBj6HM
I+sEMPNqClAvsqbEFaDtD+wcGYZV59QcGAUEYCdivMJ/WaJQq/Z09N+AxDEzwkIO
71ns5d54/AiBslixmf/8ptmOKlh8Mg9rlvSHWCjKKntkAZH2qFeanYJAVGRGGF7J
9Ff/TAfCdvGe2O4aAw9FcJrThOz/qCflxTuwzRbZtsiik6uh7aU=
=ysEB
-----END PGP SIGNATURE-----

--k4f25fnPtRuIRUb3--
