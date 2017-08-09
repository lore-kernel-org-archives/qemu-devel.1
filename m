Received: from eggs.gnu.org ([2001:4830:134:3::10]:60861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dfIDc-0008WK-7L
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 00:03:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dfIDa-0001VP-LX
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 00:03:40 -0400
Date: Wed, 9 Aug 2017 13:33:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170809033321.GB13670@umbus.fritz.box>
References: <150212666472.12227.5292551535430570753.stgit@bahia>
	<150212670348.12227.5534815630591997333.stgit@bahia>
	<20170808061636.GB25081@umbus.fritz.box>
	<20170808111835.33bb0879@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
In-Reply-To: <20170808111835.33bb0879@bahia.lan>
Subject: Re: [Qemu-devel] [for-2.10 PATCH 3/3] spapr: error out if PHB fails
 to setup PCI DRCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2017 at 11:18:35AM +0200, Greg Kurz wrote:
> On Tue, 8 Aug 2017 16:16:36 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Mon, Aug 07, 2017 at 07:25:03PM +0200, Greg Kurz wrote:
> > > It is currently possible to start QEMU with two PHBs without using the
> > > index property:
> > >=20
> > > -device spapr-pci-host-bridge,id=3Dpci1,\
> > >                               buid=3D0x800000020000001,\
> > >                               liobn=3D0x80000100,\
> > >                               liobn64=3D0x80000101,\
> > >                               mem_win_addr=3D0x200100000000,\
> > >                               mem64_win_addr=3D0x220000000000,\
> > >                               io_win_addr=3D0x200000010000 \
> > > -device spapr-pci-host-bridge,id=3Dpci2,\
> > >                               buid=3D0x800000020000002,\
> > >                               liobn=3D0x80000200,\
> > >                               liobn64=3D0x80000201,\
> > >                               mem_win_addr=3D0x200180000000,\
> > >                               mem64_win_addr=3D0x230000000000,\
> > >                               io_win_addr=3D0x200000020000 \
> > >=20
> > > Each PHB has its index property equal to -1. As a consequence, each P=
HB
> > > will want to create PCI DRCs with the same ids:
> > >=20
> > >     /* allocate connectors for child PCI devices */
> > >     if (sphb->dr_enabled) {
> > >         for (i =3D 0; i < PCI_SLOT_MAX * 8; i++) {
> > >             spapr_dr_connector_new(OBJECT(phb), TYPE_SPAPR_DRC_PCI,
> > >                                    (sphb->index << 16) | i);
> > >         }
> > >     }
> > >=20
> > > When DRC objects are added to the composition tree, an alias using the
> > > DRC id is created in the "/dr-connector" path. But DRC ids are suppos=
ed
> > > to be globally unique and the alias creation fails, leaving the DRC
> > > object unrealized, which isn't expected by the rest of the DR logic.
> > >=20
> > > This has the effect of silently turning-off PCI hotplug support (ie, =
PCI
> > > hotplug no longer works on any PHB and no error message is printed).
> > >=20
> > > This bug always existed and would even cause a non-fatal error to be
> > > reported on the console (until recent commit bf26ae32a92a). This patch
> > > causes the error message to be printed again and QEMU to exit.
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org> =20
> >=20
> > Given that the bug isn't a regression, I'm a bit disinclined to merge
>=20
> FWIW, 2.9 would at least print an error message, but 2.10 doesn't because
> of commit bf26ae32a92a.

Ah, yeah that is a bit nasty.  Still, I'm not comfortable with the
complexity of patch required to fix it this late in 2.10.

>=20
> > patches 2&3 this late in 2.10.
> >=20
> > It just seems bogus to have all this code to (supposedly) allow
> > bridges without an index, but then have it error out if there's more
> > than one of them.
> >=20
>=20
> I agree this is weird.
>=20
> > I think skip straight to the real fix of making index madatory in 2.11.
> >=20
>=20
> Ok.
>=20
> > > ---
> > >  hw/ppc/spapr_pci.c |    9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > > index 4b7882e3613d..4a1e6c5f697c 100644
> > > --- a/hw/ppc/spapr_pci.c
> > > +++ b/hw/ppc/spapr_pci.c
> > > @@ -1731,9 +1731,16 @@ static void spapr_phb_realize(DeviceState *dev=
, Error **errp)
> > > =20
> > >      /* allocate connectors for child PCI devices */
> > >      if (sphb->dr_enabled) {
> > > +        Error *local_err =3D NULL;
> > > +
> > >          for (i =3D 0; i < PCI_SLOT_MAX * 8; i++) {
> > >              spapr_dr_connector_new(OBJECT(phb), TYPE_SPAPR_DRC_PCI,
> > > -                                   (sphb->index << 16) | i, NULL);
> > > +                                   (sphb->index << 16) | i, &local_e=
rr);
> > > +            if (local_err) {
> > > +                error_propagate(errp, local_err);
> > > +                error_prepend(errp, "Failed to create DRC: ");
> > > +                return;
> > > +            }
> > >          }
> > >      }
> > > =20
> > >  =20
> >=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmKgn8ACgkQbDjKyiDZ
s5KPHBAAsPwzWWTU71B4osFPKFoxN/o9WHk06imZ5ngQhGkFwtsLvImtJ+6+sick
Hmdn5btgBff6gx/vB394t+Ap6IRlyyMoSSIEISZkie3ZPzUxru8ZtM78bZRj1zBs
mjRgBGdj4zlo1c4Hefpvn6gWUtdzNGBmNN/wzSWY2445bj8NlWNEZN6KIYjO+2Mo
J5VhBJTa3JbuZj2gPbeLwO7aAAeUkJqMHQPQGtNqESs2xB1dWf8K1yuWSu2Ve2ba
l0PiALkEOQgGMMtn4aC+5B9xDRiwZM/hyi7F8/pXjci/xHy+6K412H5LcbGeHxuf
RXv/uXqk41f8/f5T1NaPYyPsdKSSuLmIM8esLt1zp+qSP2udzXaRDxK5UiwRYQ1i
3J3FKNXQ0ldBSGw41NJRs/HEO/aHtm2Bc3+hy+O2thKcUxGvIszRH93/5iAMElje
AWaBsMKC0z06gG2Wc7EzGVBUFChgBQBPwOIrybd54IpR9L6O/ttkN4aTqJvDA3Lz
I5Q2XB1O9/XDHaoH3nkjd34hDef22kNZSRlRtw4suseP33j32s94FDHkjJcOCkO1
1TKB2GIAyiQHloT2zCjeIPVJsFC1oPQgWr/Ieu4T0ztMxh6zFIiimwaN1PTzJfz5
BHYZ1UzUbSF8xRKLBIAEjXsgBE1Uip9lMeqJsrnBO2/1lt7JNjw=
=rhsT
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
