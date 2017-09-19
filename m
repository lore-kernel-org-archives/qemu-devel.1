Received: from eggs.gnu.org ([2001:4830:134:3::10]:40119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1duJ90-0002KL-Fn
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:05:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1duJ8v-0007cm-Tz
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:04:58 -0400
Received: from 16.mo1.mail-out.ovh.net ([178.33.104.224]:41815)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1duJ8v-0007bj-Jq
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:04:53 -0400
Received: from player691.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 9225295A50
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 16:04:51 +0200 (CEST)
Date: Tue, 19 Sep 2017 16:03:57 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170919160357.082b991f@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20170918230358.GG27153@umbus>
References: <150539846159.21523.16161730500010192093.stgit@bahia>
	<150539848430.21523.2732328570419779115.stgit@bahia>
	<20170918230358.GG27153@umbus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/7EXtrxp/VpmTwXqaD8rMlwt";
	protocol="application/pgp-signature"
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>

--Sig_/7EXtrxp/VpmTwXqaD8rMlwt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 19 Sep 2017 09:03:58 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Sep 14, 2017 at 04:14:44PM +0200, Greg Kurz wrote:
> > Creating several PHBs without index property confuses the DRC code
> > and causes issues:
> > - only the first index-less PHB is functional, the other ones will
> >   silently ignore hotplugging of PCI devices
> > - QEMU will even terminate if these PHBs have cold-plugged devices =20
>=20
> So, this is true, but it's kind of missing the point; we could fix
> those things if we wanted.  The real point here is that the non-index
> option is more trouble than it's worth: it's difficult to use, keeps
> requiring (potentially incompatible) changes when some new parameter
> needs adding, and is awkward to check for collisions.
>=20

Ok, I'll rewrite the changelog accordingly in the next spin.

> > qemu-system-ppc64: -device virtio-net,bus=3Dpci2.0: an attached device
> >  is still awaiting release
> >=20
> > This happens because DR connectors for child PCI devices are created
> > with a DRC index that is derived from the PHB's index property. If the
> > PHBs are created without index, then the same value of -1 is used to
> > compute the DRC indexes for both PHBs, hence causing the collision.
> >=20
> > Also, the index property is used to compute the placement of the PHB's
> > memory regions. It is limited to 31 or 255, depending on the machine
> > type version. This fits well with the requirements of DRC indexes, which
> > need the PHB index to be a 16-bit value.
> >=20
> > This patch hence makes the index property mandatory. As a consequence,
> > the PHB's memory regions and BUID are now always configured according
> > to the index, and it is no longer possible to set them from the command
> > line. We have to introduce a PHB instance init function to initialize
> > the 64-bit window address to -1 because pseries-2.7 and older machines
> > don't set it.
> >=20
> > This DOES BREAK backwards compat, but we don't think the non-index
> > PHB feature was used in practice (at least libvirt doesn't) and the
> > simplification is worth it.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> > v1->v2: - error out if mem64_win_pciaddr is set but mem64_win_size
> >           isn't
> >         - set mem64_win_addr to -1 for old configuration with 32-bit
> >           window below 2G in spapr_phb_realize()
> >         - drop instance init function
> >=20
> > RFC->v1: - as suggested dy David, updated the changelog to explicitely
> >            mention that we intentionally break backwards compat.
> > ---
> >  hw/ppc/spapr_pci.c |   53 +++++++++++---------------------------------=
--------
> >  1 file changed, 11 insertions(+), 42 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index cf54160526fa..024638e18b53 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -1523,16 +1523,6 @@ static void spapr_phb_realize(DeviceState *dev, =
Error **errp)
> >          sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> >          Error *local_err =3D NULL;
> > =20
> > -        if ((sphb->buid !=3D (uint64_t)-1) || (sphb->dma_liobn[0] !=3D=
 (uint32_t)-1)
> > -            || (sphb->dma_liobn[1] !=3D (uint32_t)-1 && windows_suppor=
ted =3D=3D 2)
> > -            || (sphb->mem_win_addr !=3D (hwaddr)-1)
> > -            || (sphb->mem64_win_addr !=3D (hwaddr)-1)
> > -            || (sphb->io_win_addr !=3D (hwaddr)-1)) {
> > -            error_setg(errp, "Either \"index\" or other parameters mus=
t"
> > -                       " be specified for PAPR PHB, not both");
> > -            return;
> > -        }
> > -
> >          smc->phb_placement(spapr, sphb->index,
> >                             &sphb->buid, &sphb->io_win_addr,
> >                             &sphb->mem_win_addr, &sphb->mem64_win_addr,
> > @@ -1541,36 +1531,12 @@ static void spapr_phb_realize(DeviceState *dev,=
 Error **errp)
> >              error_propagate(errp, local_err);
> >              return;
> >          }
> > -    }
> > -
> > -    if (sphb->buid =3D=3D (uint64_t)-1) {
> > -        error_setg(errp, "BUID not specified for PHB");
> > -        return;
> > -    }
> > -
> > -    if ((sphb->dma_liobn[0] =3D=3D (uint32_t)-1) ||
> > -        ((sphb->dma_liobn[1] =3D=3D (uint32_t)-1) && (windows_supporte=
d > 1))) {
> > -        error_setg(errp, "LIOBN(s) not specified for PHB");
> > -        return;
> > -    }
> > -
> > -    if (sphb->mem_win_addr =3D=3D (hwaddr)-1) {
> > -        error_setg(errp, "Memory window address not specified for PHB"=
);
> > -        return;
> > -    }
> > -
> > -    if (sphb->io_win_addr =3D=3D (hwaddr)-1) {
> > -        error_setg(errp, "IO window address not specified for PHB");
> > +    } else {
> > +        error_setg(errp, "\"index\" for PAPR PHB is mandatory");
> >          return;
> >      }
> > =20
> >      if (sphb->mem64_win_size !=3D 0) {
> > -        if (sphb->mem64_win_addr =3D=3D (hwaddr)-1) {
> > -            error_setg(errp,
> > -                       "64-bit memory window address not specified for=
 PHB");
> > -            return;
> > -        }
> > -
> >          if (sphb->mem_win_size > SPAPR_PCI_MEM32_WIN_SIZE) {
> >              error_setg(errp, "32-bit memory window of size 0x%"HWADDR_=
PRIx
> >                         " (max 2 GiB)", sphb->mem_win_size); =20
>=20
> Some of these checks could probably just become assert()s now, where
> they're things determined by the placement code and no longer have
> parameters, a problem indicates a bug in the machine rather than a
> user error.
>=20

All the *_size properties are still user settable, as before... should we
make them internal and have the placement hook initialize them instead ?

> > @@ -1581,6 +1547,9 @@ static void spapr_phb_realize(DeviceState *dev, E=
rror **errp)
> >              /* 64-bit window defaults to identity mapping */
> >              sphb->mem64_win_pciaddr =3D sphb->mem64_win_addr;
> >          }
> > +    } else if (sphb->mem64_win_pciaddr !=3D (hwaddr) -1) {
> > +        error_setg(errp, "64-bit memory window requires \"mem64_win_si=
ze\"");
> > +        return; =20
>=20
> Likewise this new one.
>=20

mem64_win_pciaddr is still user settable as well...

> >      } else if (sphb->mem_win_size > SPAPR_PCI_MEM32_WIN_SIZE) {
> >          /*
> >           * For compatibility with old configuration, if no 64-bit MMIO
> > @@ -1594,6 +1563,12 @@ static void spapr_phb_realize(DeviceState *dev, =
Error **errp)
> >          sphb->mem64_win_pciaddr =3D
> >              SPAPR_PCI_MEM_WIN_BUS_OFFSET + SPAPR_PCI_MEM32_WIN_SIZE;
> >          sphb->mem_win_size =3D SPAPR_PCI_MEM32_WIN_SIZE;
> > +    } else {
> > +        /* Old configuration with the 32-bit MMIO window <=3D 2GiB don=
't need a
> > +         * 64-bit MMIO window.
> > +         */ =20
>=20
> Wouldn't it be easier to just change the test below to check for size
> !=3D 0 instead of checking for addr !=3D -1 as it does now.
>=20

Yeah indeed.

> > +        sphb->mem64_win_addr =3D (hwaddr) -1;
> > +        sphb->mem64_win_pciaddr =3D (hwaddr) -1;
> >      }
> > =20
> >      if (spapr_pci_find_phb(spapr, sphb->buid)) {
> > @@ -1789,18 +1764,12 @@ static void spapr_phb_reset(DeviceState *qdev)
> > =20
> >  static Property spapr_phb_properties[] =3D {
> >      DEFINE_PROP_UINT32("index", sPAPRPHBState, index, -1),
> > -    DEFINE_PROP_UINT64("buid", sPAPRPHBState, buid, -1),
> > -    DEFINE_PROP_UINT32("liobn", sPAPRPHBState, dma_liobn[0], -1),
> > -    DEFINE_PROP_UINT32("liobn64", sPAPRPHBState, dma_liobn[1], -1),
> > -    DEFINE_PROP_UINT64("mem_win_addr", sPAPRPHBState, mem_win_addr, -1=
),
> >      DEFINE_PROP_UINT64("mem_win_size", sPAPRPHBState, mem_win_size,
> >                         SPAPR_PCI_MEM32_WIN_SIZE),
> > -    DEFINE_PROP_UINT64("mem64_win_addr", sPAPRPHBState, mem64_win_addr=
, -1),
> >      DEFINE_PROP_UINT64("mem64_win_size", sPAPRPHBState, mem64_win_size,
> >                         SPAPR_PCI_MEM64_WIN_SIZE),
> >      DEFINE_PROP_UINT64("mem64_win_pciaddr", sPAPRPHBState, mem64_win_p=
ciaddr,
> >                         -1),
> > -    DEFINE_PROP_UINT64("io_win_addr", sPAPRPHBState, io_win_addr, -1),
> >      DEFINE_PROP_UINT64("io_win_size", sPAPRPHBState, io_win_size,
> >                         SPAPR_PCI_IO_WIN_SIZE),
> >      DEFINE_PROP_BOOL("dynamic-reconfiguration", sPAPRPHBState, dr_enab=
led,
> >  =20
>=20



--=20
Gregory Kurz                                     kurzgreg@fr.ibm.com
                                                 gkurz@linux.vnet.ibm.com
Software Engineer @ IBM/LTC                      http://www.ibm.com
Tel 33-5-6218-1607

"Anarchy is about taking complete responsibility for yourself."
        Alan Moore.

--Sig_/7EXtrxp/VpmTwXqaD8rMlwt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWcEjzQAKCRAC/DrrAQHb
wiTgAKCKdztbsOV2NFoCfvC0R3YX6MudKQCgkhgmbuATfRV1Wjr7GisilIS5h/Q=
=jBOv
-----END PGP SIGNATURE-----

--Sig_/7EXtrxp/VpmTwXqaD8rMlwt--
