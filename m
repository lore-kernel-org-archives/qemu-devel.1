Received: from eggs.gnu.org ([2001:4830:134:3::10]:47132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cOZKh-0001wJ-VH
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 19:21:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cOZKg-00069K-Qd
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 19:21:35 -0500
Date: Wed, 4 Jan 2017 11:05:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170104000528.GV12761@umbus.fritz.box>
References: <1483049536-21548-1-git-send-email-hpoussin@reactos.org>
	<1483049536-21548-3-git-send-email-hpoussin@reactos.org>
	<20170102230212.GF12761@umbus.fritz.box>
	<38325f34-9511-bb4e-2224-097bd9a88d7e@reactos.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="D/26AIznG/rf8cgR"
Content-Disposition: inline
In-Reply-To: <38325f34-9511-bb4e-2224-097bd9a88d7e@reactos.org>
Subject: Re: [Qemu-devel] [PATCH 2/6] vga: increase priority of 0xa0000
 memory region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, Giancarlo Teodori <gteodori@gmail.com>


--D/26AIznG/rf8cgR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 03, 2017 at 11:37:20PM +0100, Herv=E9 Poussineau wrote:
> Le 03/01/2017 =E0 00:02, David Gibson a =E9crit :
> > On Thu, Dec 29, 2016 at 11:12:12PM +0100, Herv=E9 Poussineau wrote:
> > > VGA device registers vram as BAR 0. If this BAR is activated as a ver=
y low address which
> > > crosses 0xa0000-0xbffff, low memory region is not accessible anymore.
> > >=20
> > > This fixes display on PReP machine if we enable PCI mapping at
> > > address 0.
> >=20
> > This commit message needs more information.  What exactly is the VGA
> > BAR colliding with?  Why does the other thing have higher priority?
> > Why is it safe for the VGA BAR to override the other thing?  Why is
> > this safe on all platforms?
>=20
> VGA has (basically) two memory regions:
> - the legacy one, from 0xa0000 to 0xbffff
> - a memory region describing the whole VRAM, configurable with PCI BAR 0.

Yes, that I know.  Note that both the fixed 0xa0000 and the BAR value
are offsets with *PCI* memory space, which may not be the same as
addresses in system memory space.  PCI memory space is identity mapped
into system address space on x86, IIRC, but it's not on spapr.  AFAICT
it's not identity mapped on PReP either (see raven_pcihost_initfn()).
So the VGA legacy window will actually be at 0xc00a0000 and BAR0 at
(0xc0000000 + BAR value) in the _system_ address space if I'm reading
the PReP PCI bridge code correctly.

> In QEMU, mapping PCI at address 0 is not permitted (MachineClass->pci_all=
ow_0_address is false by default),

I believe this is because of the identity map of PCI memory space on
x86 (well, PC, strictly speaking).  Because that's not the case on
PReP, it should probably set allow_0_address =3D true.

> except on arm/virt and ppc/spapr. So, this is usually not a problem as al=
l PCI BARs (including video PCI BAR 0) are not mapped at
> address 0, and so both memory regions can't collide.
>=20
> When trying Linux on ppc/40p (introduced later in this patchset), I saw t=
hat Linux assigns
> PCI BAR addresses in the order of PCI devices detection, and VGA PCI BAR =
0 ends up at address 0.

Hmm.  You're saying that Linux is assigning BAR 0 so that it collides
with the legacy memory region?  That sounds like a Linux bug.
Or.. does Linux always assign BARs on PReP, or only if the firmware
doesn't?  Maybe the guest firmware needs to assign the BARs properly
to avoid this collision.

> However, Linux assumes that 0xa0000-0xbffff is still available to drive t=
he VGA card in text mode.
> Without changing the region priority, VGA output is garbled (as writes di=
rectly go to VGA memory).
> When increasing the region priority, VGA output is restored (as writes go=
 to legacy address space).

Right.  But by increasing the priority, you're effectively making a
hole in BAR0.  That sounds like it will cause chaos if after boot you
load a "real" VGA driver which tries to use the full video RAM through
BAR0 instead of via the legacy area.

> arm/virt by default doesn't have a PCI VGA card.
> ppc/spapr may probably have the same problem as ppc/40p. However, as VGA =
PCI BAR 0 and VGA legacy space
> both have a priority of 1, it may probably have a problem. I only need to=
 convince Linux to use address 0 for VGA PCI BAR.
>=20
> Herv=E9
>=20
> >=20
> > > Signed-off-by: Herv=E9 Poussineau <hpoussin@reactos.org>
> > > ---
> > >  hw/display/vga.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/hw/display/vga.c b/hw/display/vga.c
> > > index 2a88b3c..c573f35 100644
> > > --- a/hw/display/vga.c
> > > +++ b/hw/display/vga.c
> > > @@ -2265,7 +2265,7 @@ void vga_init(VGACommonState *s, Object *obj, M=
emoryRegion *address_space,
> > >      memory_region_add_subregion_overlap(address_space,
> > >                                          0x000a0000,
> > >                                          vga_io_memory,
> > > -                                        1);
> > > +                                        2);
> > >      memory_region_set_coalescing(vga_io_memory);
> > >      if (init_vga_ports) {
> > >          portio_list_init(&s->vga_port_list, obj, vga_ports, s, "vga"=
);
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--D/26AIznG/rf8cgR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYbDxGAAoJEGw4ysog2bOSENgP/RLJJLh8Cp1m0gy9X2E2dy6I
LWZpl53LmNdGT4CVBy6Q5rvkul9Ca5DdjCzs2vd99kVjAuE0G8GAdttAttUl4APt
yejSY3WxeYuYnViiqQIeTvLJoK9w39sGa0FXPTqnSyGZgwq4glbURkBY4o5Iom+R
+hUjnRVMvsR6Qa3WtyOeCs2WBLPWfR6QMCnMJwOWYX3rUaukohVKuPjWIf4Y+Qpp
6u572yKs17Xzk3PdzjyWFZ4X3agkC9dv7kvxgdi4EXDhXU0ynuOrhS7u6t+BpzBv
n2JE6av3rOBcMnOzZJ1TMjQxggsY9x9L8NQWmGCFrjsi6TyV2je8wT1mgGI+vJj5
cGZglcNsVJ7MC1b18FJczTF5Slaq7YLX2Rw0U/QMTisx+Un2I6i3jCd4WD+E32Wd
6n+EyT5RTBWKxppXl0C9YQixxJjLl2kdmtPZMh//Tt0Eie2rk99BAkDm2OZJ4MUE
pdHsPjQHdaBknMVGeIS6FHGqboLQkuYV6Ug2CGVuj9cRSfNjy4jPj41m8S59Xz86
3eTwzRNMlVeWmFhwPaAkIV1IHvm+McpT0/nPxBgTtAlQJ3OxGqTIqWJ/i5GzcUmu
lZ9rmWl8DPgChpnuosJIQRXIEzUhJiV9vRq265Kk6oZ+01byjv5MJp/kQYxuLmub
ghPqhjYCySEClGCrIhEg
=h5vN
-----END PGP SIGNATURE-----

--D/26AIznG/rf8cgR--
