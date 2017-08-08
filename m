Received: from eggs.gnu.org ([2001:4830:134:3::10]:51232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1df0f7-00051o-2t
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 05:18:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1df0f3-0003CK-0P
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 05:18:53 -0400
Received: from 10.mo4.mail-out.ovh.net ([188.165.33.109]:58805)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1df0f2-0003Bj-PF
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 05:18:48 -0400
Received: from player694.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id EAB5E8BB51
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 11:18:45 +0200 (CEST)
Date: Tue, 8 Aug 2017 11:18:35 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170808111835.33bb0879@bahia.lan>
In-Reply-To: <20170808061636.GB25081@umbus.fritz.box>
References: <150212666472.12227.5292551535430570753.stgit@bahia>
	<150212670348.12227.5534815630591997333.stgit@bahia>
	<20170808061636.GB25081@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/H9_rdwGFWM4MEOvEbqnNjFb";
	protocol="application/pgp-signature"
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

--Sig_/H9_rdwGFWM4MEOvEbqnNjFb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Aug 2017 16:16:36 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Mon, Aug 07, 2017 at 07:25:03PM +0200, Greg Kurz wrote:
> > It is currently possible to start QEMU with two PHBs without using the
> > index property:
> >=20
> > -device spapr-pci-host-bridge,id=3Dpci1,\
> >                               buid=3D0x800000020000001,\
> >                               liobn=3D0x80000100,\
> >                               liobn64=3D0x80000101,\
> >                               mem_win_addr=3D0x200100000000,\
> >                               mem64_win_addr=3D0x220000000000,\
> >                               io_win_addr=3D0x200000010000 \
> > -device spapr-pci-host-bridge,id=3Dpci2,\
> >                               buid=3D0x800000020000002,\
> >                               liobn=3D0x80000200,\
> >                               liobn64=3D0x80000201,\
> >                               mem_win_addr=3D0x200180000000,\
> >                               mem64_win_addr=3D0x230000000000,\
> >                               io_win_addr=3D0x200000020000 \
> >=20
> > Each PHB has its index property equal to -1. As a consequence, each PHB
> > will want to create PCI DRCs with the same ids:
> >=20
> >     /* allocate connectors for child PCI devices */
> >     if (sphb->dr_enabled) {
> >         for (i =3D 0; i < PCI_SLOT_MAX * 8; i++) {
> >             spapr_dr_connector_new(OBJECT(phb), TYPE_SPAPR_DRC_PCI,
> >                                    (sphb->index << 16) | i);
> >         }
> >     }
> >=20
> > When DRC objects are added to the composition tree, an alias using the
> > DRC id is created in the "/dr-connector" path. But DRC ids are supposed
> > to be globally unique and the alias creation fails, leaving the DRC
> > object unrealized, which isn't expected by the rest of the DR logic.
> >=20
> > This has the effect of silently turning-off PCI hotplug support (ie, PCI
> > hotplug no longer works on any PHB and no error message is printed).
> >=20
> > This bug always existed and would even cause a non-fatal error to be
> > reported on the console (until recent commit bf26ae32a92a). This patch
> > causes the error message to be printed again and QEMU to exit.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org> =20
>=20
> Given that the bug isn't a regression, I'm a bit disinclined to merge

FWIW, 2.9 would at least print an error message, but 2.10 doesn't because
of commit bf26ae32a92a.

> patches 2&3 this late in 2.10.
>=20
> It just seems bogus to have all this code to (supposedly) allow
> bridges without an index, but then have it error out if there's more
> than one of them.
>=20

I agree this is weird.

> I think skip straight to the real fix of making index madatory in 2.11.
>=20

Ok.

> > ---
> >  hw/ppc/spapr_pci.c |    9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index 4b7882e3613d..4a1e6c5f697c 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -1731,9 +1731,16 @@ static void spapr_phb_realize(DeviceState *dev, =
Error **errp)
> > =20
> >      /* allocate connectors for child PCI devices */
> >      if (sphb->dr_enabled) {
> > +        Error *local_err =3D NULL;
> > +
> >          for (i =3D 0; i < PCI_SLOT_MAX * 8; i++) {
> >              spapr_dr_connector_new(OBJECT(phb), TYPE_SPAPR_DRC_PCI,
> > -                                   (sphb->index << 16) | i, NULL);
> > +                                   (sphb->index << 16) | i, &local_err=
);
> > +            if (local_err) {
> > +                error_propagate(errp, local_err);
> > +                error_prepend(errp, "Failed to create DRC: ");
> > +                return;
> > +            }
> >          }
> >      }
> > =20
> >  =20
>=20


--Sig_/H9_rdwGFWM4MEOvEbqnNjFb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlmJgesACgkQAvw66wEB28JlkQCcCKUs35+xQSpT5EAmpxdW1jmY
hJcAn0ZQYgvpmZoGeqEUhQcesJgnjysU
=6XPH
-----END PGP SIGNATURE-----

--Sig_/H9_rdwGFWM4MEOvEbqnNjFb--
