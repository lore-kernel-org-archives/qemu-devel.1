Received: from eggs.gnu.org ([2001:4830:134:3::10]:57727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eLoOD-0006Wh-H9
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 05:54:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eLoO8-0007Ba-Fk
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 05:54:21 -0500
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:43368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eLoO8-00078V-5S
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 05:54:16 -0500
Received: from player718.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 8700FD4A66
	for <qemu-devel@nongnu.org>; Mon,  4 Dec 2017 11:54:07 +0100 (CET)
Date: Mon, 4 Dec 2017 11:53:52 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171204115352.76b44f56@bahia.lan>
In-Reply-To: <20171202233735.GD2130@umbus.fritz.box>
References: <151224301160.13812.16487624528793386353.stgit@bahia.lan>
	<20171202233735.GD2130@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/96CQn2kozeWHSFsw0uZwriy";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] spapr: fix LSI interrupt specifiers in the
 device tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>

--Sig_/96CQn2kozeWHSFsw0uZwriy
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 3 Dec 2017 10:37:35 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Sat, Dec 02, 2017 at 08:30:11PM +0100, Greg Kurz wrote:
> > PAPR 2.7 C.6.9.1.2 describes the "#interrupt-cells" property of the
> > PowerPC External Interrupt Source Controller node as follows:
> >=20
> > =E2=80=9C#interrupt-cells=E2=80=9D
> >=20
> >   Standard property name to define the number of cells in an interrupt-
> >   specifier within an interrupt domain.
> >=20
> >   prop-encoded-array: An integer, encoded as with encode-int, that deno=
tes
> >   the number of cells required to represent an interrupt specifier in i=
ts
> >   child nodes.
> >=20
> >   The value of this property for the PowerPC External Interrupt option =
shall
> >   be 2. Thus all interrupt specifiers (as used in the standard =E2=80=
=9Cinterrupts=E2=80=9D
> >   property) shall consist of two cells, each containing an integer enco=
ded
> >   as with encode-int. The first integer represents the interrupt number=
 the
> >   second integer is the trigger code: 0 for edge triggered, 1 for level
> >   triggered.
> >=20
> > This patch adds a second cell to the interrupt specifier stored in the
> > "interrupts" property of PCI device nodes. This property only exists if
> > the Interrupt Pin register is set, ie, the interrupt is level, the extra
> > cell is hence set to 1. =20
>=20
> Nack.  This format of interrupt specifier is only needed for things
> wired directly to the xics.  The PCI INTx interrupts aren't - they go
> through the interrupt nexus in the PHB.  The interrupt-map is intended
> to remap the simple 1,2,3,4 for INTA..INTD to xics interrupt specifiers.
>=20

Indeed you're right... and the =E2=80=9C#interrupt-cells=E2=80=9D property =
of the PHB
is set to 1, ie, the interrupt specifier format in the child PCI isn't
expected to have an extra cell... This should have rung a bell :)

> > This also fixes the interrupt specifiers in the "interrupt-map" property
> > of the PHB node, that were setting the second cell to 8 (confusion with
> > IRQ_TYPE_LEVEL_LOW ?) instead of 1. =20
>=20
> Fixing that is correct, though I think.  As might be the changes in
> other places I'll have to check.
>=20
> > While here, let's introduce defines for the interrupt specifier trigger
> > code, and patch other users in spapr.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org> =20
>=20
>=20
> > ---
> >=20
> > This fixes /proc/interrupts in linux guests where LSIs appear as
> > Edge instead of Level.
> > ---
> >  hw/ppc/spapr_events.c  |    2 +-
> >  hw/ppc/spapr_pci.c     |    4 +++-
> >  hw/ppc/spapr_vio.c     |    3 ++-
> >  include/hw/ppc/spapr.h |    3 +++
> >  4 files changed, 9 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> > index e377fc7ddea2..4bcb98f948ea 100644
> > --- a/hw/ppc/spapr_events.c
> > +++ b/hw/ppc/spapr_events.c
> > @@ -283,7 +283,7 @@ void spapr_dt_events(sPAPRMachineState *spapr, void=
 *fdt)
> >          }
> > =20
> >          interrupts[0] =3D cpu_to_be32(source->irq);
> > -        interrupts[1] =3D 0;
> > +        interrupts[1] =3D SPAPR_DT_INTERRUPT_IDENTIFIER_EDGE;
> > =20
> >          _FDT(node_offset =3D fdt_add_subnode(fdt, event_sources, sourc=
e_name));
> >          _FDT(fdt_setprop(fdt, node_offset, "interrupts", interrupts,
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index 5a3122a9f9f9..91fedbf0929c 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -1231,6 +1231,8 @@ static void spapr_populate_pci_child_dt(PCIDevice=
 *dev, void *fdt, int offset,
> >      if (pci_default_read_config(dev, PCI_INTERRUPT_PIN, 1)) {
> >          _FDT(fdt_setprop_cell(fdt, offset, "interrupts",
> >                   pci_default_read_config(dev, PCI_INTERRUPT_PIN, 1)));
> > +        _FDT(fdt_appendprop_cell(fdt, offset, "interrupts",
> > +                                 SPAPR_DT_INTERRUPT_IDENTIFIER_LEVEL));
> >      }
> > =20
> >      if (!is_bridge) {
> > @@ -2122,7 +2124,7 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
> >              irqmap[3] =3D cpu_to_be32(j+1);
> >              irqmap[4] =3D cpu_to_be32(xics_phandle);
> >              irqmap[5] =3D cpu_to_be32(phb->lsi_table[lsi_num].irq);
> > -            irqmap[6] =3D cpu_to_be32(0x8);
> > +            irqmap[6] =3D cpu_to_be32(SPAPR_DT_INTERRUPT_IDENTIFIER_LE=
VEL);
> >          }
> >      }
> >      /* Write interrupt map */
> > diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
> > index ea3bc8bd9e21..29a17651a17c 100644
> > --- a/hw/ppc/spapr_vio.c
> > +++ b/hw/ppc/spapr_vio.c
> > @@ -126,7 +126,8 @@ static int vio_make_devnode(VIOsPAPRDevice *dev,
> >      }
> > =20
> >      if (dev->irq) {
> > -        uint32_t ints_prop[] =3D {cpu_to_be32(dev->irq), 0};
> > +        uint32_t ints_prop[] =3D { cpu_to_be32(dev->irq),
> > +                                 SPAPR_DT_INTERRUPT_IDENTIFIER_EDGE };
> > =20
> >          ret =3D fdt_setprop(fdt, node_off, "interrupts", ints_prop,
> >                            sizeof(ints_prop));
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index 9d21ca9bde3a..8f6298bde59b 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -590,6 +590,9 @@ void spapr_load_rtas(sPAPRMachineState *spapr, void=
 *fdt, hwaddr addr);
> > =20
> >  #define RTAS_EVENT_SCAN_RATE    1
> > =20
> > +#define SPAPR_DT_INTERRUPT_IDENTIFIER_EDGE  0
> > +#define SPAPR_DT_INTERRUPT_IDENTIFIER_LEVEL 1
> > +
> >  typedef struct sPAPRTCETable sPAPRTCETable;
> > =20
> >  #define TYPE_SPAPR_TCE_TABLE "spapr-tce-table"
> >  =20
>=20


--Sig_/96CQn2kozeWHSFsw0uZwriy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlolKUAACgkQcdTV5YIv
c9b00A/7BACCg/5G3Rsrm/rPRxDohpGNL/6eJG4kzNCUozZZ3cyXrF+8gHGixsyN
zyYjdQSjt1XBYUhYVHET2OxoIurj7n8ZF/juOmKXf0AxfnkLHthG5s9OAULbXeSG
feaDz07c4K+rstJuoRQY/8GTghInfer8En7eQGczx2y/8LI35nK6O+dFAlUaxg/a
L1bEhswK7sbOe075rYC/1Wb2Ou4hngiynXYU6VhbJisl2aL42EQXfBxtpeKn2GNd
7OxGtM7fMTDJVLmF+bk/gS7HsE36sFyYt6O/20seCmdLMLo38ACgkYrYkc0laEA8
BD1M6Ubw9AC0rO/6Bzb88abaZmX6AvFlc0WI9EZRxVGSPhgeshFqGPtVMTdc5Y9/
ng9Y7k02U81DorL+O+jTMtB6+nsZ2LZKUUUfc4Ma1IB6DDohK9BiIqanQouoo4Xu
sg2eA/v6e4KZOjZNC1Ae1NQ4kvhYT6JJtc2Z+f/1NH8vFbMrcoqbaHHP6oSjfh7W
oJt1qFAjMIk9nziIidh6RUWktjz+uVuim1ud0rNQgsNRaEm9iBt2Vwgc+1q9+2YD
3Q24pfZIJd/mX9aG9wCpxmW75wFhv5nxnINTfFIVNnUYerWebEjvM2rEug3w7mba
9gbserrBFqq0KbtRdBUCYNUMp0LmgSOKJM2uRi1F9+G4Q3ig2R8=
=9WRK
-----END PGP SIGNATURE-----

--Sig_/96CQn2kozeWHSFsw0uZwriy--
