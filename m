Received: from eggs.gnu.org ([2001:4830:134:3::10]:39153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cnb8t-00015o-Nw
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 21:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cnb8s-0001OE-OH
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 21:20:51 -0400
Date: Tue, 14 Mar 2017 12:20:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170314012039.GD12564@umbus.fritz.box>
References: <20170303032507.16142-1-david@gibson.dropbear.id.au>
	<20170303032507.16142-16-david@gibson.dropbear.id.au>
	<1489159521.3805.43.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rqzD5py0kzyFAOWN"
Content-Disposition: inline
In-Reply-To: <1489159521.3805.43.camel@redhat.com>
Subject: Re: [Qemu-devel] [PULL 15/17] spapr_pci: Advertise access to PCIe
 extended config space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: peter.maydell@linaro.org, lvivier@redhat.com, thuth@redhat.com, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sjitindarsingh@gmail.com, sam.bobroff@au1.ibm.com


--rqzD5py0kzyFAOWN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 10, 2017 at 04:25:21PM +0100, Andrea Bolognani wrote:
> On Fri, 2017-03-03 at 14:25 +1100, David Gibson wrote:
> > The (paravirtual) PCI host bridge on the 'pseries' machine in most
> > regards acts like a regular PCI bus, rather than a PCIe bus.=A0=A0Despi=
te
> > this, though, it does allow access to the PCIe extended config space.
> >=A0
> > We already implemented the RTAS methods to allow this access.. but
> > forgot to put the markers into the device tree so that guest's know it
> > is there.=A0=A0This adds them in.
> >=A0
> > With this, a pseries guest is able to view extended config space on
> > (for example an e1000e device.=A0=A0This should be enough to allow gues=
ts
> > to use at least some PCIe devices.
> >=A0
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >=A0=A0hw/ppc/spapr_pci.c | 4 ++++
> >=A0=A01 file changed, 4 insertions(+)
> >=A0
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index 2a3499e..919d3c2 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -1321,6 +1321,10 @@ static int spapr_populate_pci_child_dt(PCIDevice=
 *dev, void *fdt, int offset,
> >=A0=A0=A0=A0=A0=A0_FDT(fdt_setprop(fdt, offset, "assigned-addresses",
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0(ui=
nt8_t *)rp.assigned, rp.assigned_len));
> >=A0=A0
> > +=A0=A0=A0=A0if (pci_is_express(dev)) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0_FDT(fdt_setprop_cell(fdt, offset, "ibm,pci-co=
nfig-space-type", 0x1));
> > +=A0=A0=A0=A0}
> > +
> >=A0=A0=A0=A0=A0=A0return 0;
> >=A0=A0}
>=20
> I've just realized that this is not tied to the pseries-2.9
> machine type, which means existing guests will suddenly get
> access to the Extended Config Space after upgrading QEMU.
>=20
> I'm not sure this will cause any issue in practice, but it
> seems like it would be safer to enable the Extended Config
> Space only for pseries-2.9 and newer machine types.

That's a good point.  I've put a fix into ppc-for-2.9, will send a
pull request shortly.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rqzD5py0kzyFAOWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYx0VkAAoJEGw4ysog2bOSDhoQANFk6r/n13X+KNNSqTAJBtcw
M2evIsTLGfYaJj/qwLVZsbJ4vUn3zqVVUUhXl1jcV8fsYWh/Y00aRM06Vzdbzg7v
bzqfBu316IcpvN5qnUes7iApnWmKuswOWHSIQIomto36dbJiQx63zjlQkzQrcmFp
+ofDbhyKMz9FuNT8AYLJkAiKx2OFlRjU82+J/Xw/teNZe2pQIHRa6omteX2JdDY0
4eYnoy9VRSzjgBR8dB4NpO6RbvF2eB6p9lQB4awpxiwXiU77t4KbHNwE67JZ11bH
kR53Kuqk2YINY8nCNoi3xrOrv650NslNXlKiDQVpw2Xh4v30lHP3INh+KPZILftY
BcGqwXDkV9q+eZRJCi3kHAM97b/ofFO6/bj+PewriDFAVbjFdwB6eLdH5ffVu3GL
PaHXHqvwpIEy8IDTSBtLCxTgDH0WayjoQxIjkik0fdeJ40Sd472KArKlMaK3uYjK
JVQJuD3IzTORJNNGpBtOAwkoo7RNwmE82Eu7lk6bw3Eh56b3uxgJz1IA3yZE4++H
Z3u9AehurKMs4Ij4x99CVe7FAf8rqOEwhTRS2S7w1EDQPPdxrVJH6a4ZYlHb9Jpu
ZqSkIWdF5KxKbFYcAuu0DLsNGSX6nlmJQatBhoplES2v8DyGXvpV1xVU8XJ6Ce6T
bXFLFSF2jiLxaCLR+tMQ
=flyg
-----END PGP SIGNATURE-----

--rqzD5py0kzyFAOWN--
