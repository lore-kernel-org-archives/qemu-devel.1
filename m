Received: from eggs.gnu.org ([209.51.188.92]:46521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gnZIp-0005aC-Sb
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 20:32:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gnZIo-0001zj-LC
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 20:32:03 -0500
Date: Sat, 26 Jan 2019 14:42:24 +1300
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190126014223.GA22942@umbus>
References: <20190123082425.10643-1-david@redhat.com>
	<11e508cf-bff8-71e0-8d25-b54250d3d201@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <11e508cf-bff8-71e0-8d25-b54250d3d201@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH v1] spapr/pci: Fix primary bus number for
 PCI bridges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 24, 2019 at 01:48:36PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 23/01/2019 19:24, David Hildenbrand wrote:
> > While looking at the s390x implementation, looks like spapr has a
> > similar BUG when building the topology.
> >=20
> > The primary bus number corresponds always to the bus number of the
> > bus the bridge is attached to.
> >=20
> > Right now, if we have two bridges attached to the same bus (e.g. root
> > bus) this is however not the case. The first bridge will have primary
> > bus 0, the second bridge primary bus 1, which is wrong. Fix the assignm=
ent.
> >=20
> > While at it, drop setting the PCI_SUBORDINATE_BUS temporarily to 0xff.
> > Setting it temporarily to that value (as discussed e.g. in [1]), is
> > only relevant for a running system that probes the buses. The value is
> > effectively unused for us just doing a DFS.
>=20
> What is DFS?
>=20
> >=20
> > [1] http://www.science.unitn.it/~fiorella/guidelinux/tlk/node76.html
> >=20
> > Note: Is hotplug of bridges supported? I can't find where the topology
> > is fixed up when hotplugging a PCI bridge. (e.g. bus numbers assigned
> > and PCI_SUBORDINATE_BUS of path to the root updated). But maybe we are
> > excluding bridges or this is not necessary for some reason.
> >=20
> > Signed-off-by: David Hildenbrand <david@redhat.com>
>=20
>=20
> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied, thanks.

>=20
>=20
> > ---
> >  hw/ppc/spapr_pci.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index b74f2632ec..5cdc98513d 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -2030,8 +2030,6 @@ static void spapr_phb_pci_enumerate_bridge(PCIBus=
 *bus, PCIDevice *pdev,
> >                                             void *opaque)
> >  {
> >      unsigned int *bus_no =3D opaque;
> > -    unsigned int primary =3D *bus_no;
> > -    unsigned int subordinate =3D 0xff;
> >      PCIBus *sec_bus =3D NULL;
> > =20
> >      if ((pci_default_read_config(pdev, PCI_HEADER_TYPE, 1) !=3D
> > @@ -2040,7 +2038,7 @@ static void spapr_phb_pci_enumerate_bridge(PCIBus=
 *bus, PCIDevice *pdev,
> >      }
> > =20
> >      (*bus_no)++;
> > -    pci_default_write_config(pdev, PCI_PRIMARY_BUS, primary, 1);
> > +    pci_default_write_config(pdev, PCI_PRIMARY_BUS, pci_dev_bus_num(pd=
ev), 1);
> >      pci_default_write_config(pdev, PCI_SECONDARY_BUS, *bus_no, 1);
> >      pci_default_write_config(pdev, PCI_SUBORDINATE_BUS, *bus_no, 1);
> > =20
> > @@ -2049,7 +2047,6 @@ static void spapr_phb_pci_enumerate_bridge(PCIBus=
 *bus, PCIDevice *pdev,
> >          return;
> >      }
> > =20
> > -    pci_default_write_config(pdev, PCI_SUBORDINATE_BUS, subordinate, 1=
);
> >      pci_for_each_device(sec_bus, pci_bus_num(sec_bus),
> >                          spapr_phb_pci_enumerate_bridge, bus_no);
> >      pci_default_write_config(pdev, PCI_SUBORDINATE_BUS, *bus_no, 1);
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxLuv0ACgkQbDjKyiDZ
s5LcUxAAmyRC5wFOf+EMqFPJK7wxdIF+x/MyRpSfbdcdWh2S7xcA2UvNCUi7pBl9
cd6M/tqAte3jhI2RUSq3o4QgpAMaPfdC+HPPfzYD4XcKPKRltyX8jFl0ZLWd4w2y
7/fyc42weEmlpc1X576yMQ6/2WMGsxO6s1vSyPKEebQmTTEV+FscWQfeAU8PMQTz
I3LM9MpHDTDbVSWxDPW/b011ibXI2tSC0SlWDtic45ldt6rg8F+dlNTVheolmHTa
/jo/3Hkq7M8uO1iNtd1UhbnToC0Aw7KJjlLm93dTkOda5DYDqVLTAqY619UzLQ5e
mXQb6XgYEfimqEC/HCosWQKaIhJq4n7nOyxn3S3lY8MkPvUfDOByUmhriPbnMHkJ
aRKBCZPbbFbSDEdrh0D6J3B+T53cINol9dkbEZDpdTiD95KH7usU6/pQcCVqt14M
iIqAqQ4WyCn2IZ83NlAPc8t70AcON6ltrLxaID0ApYc63J44F27BfcvMnz1nM69F
thrqyaVbpKUHo/ZgGG+0oUtMHe/I5JT+WFZYgTyRjUPQvvAEsDOfuMeBMmbOpslU
Uk6Ogo7F/I6Tz2OjBK6WQhBGCi1fvkoM/LSrkAQSKTNOYqH+9Wr5ldQFmQ6U/gqL
QVX6/Jp0m/dSrc/KgxsmoQiqb0+RZEMJpGIkh00xWIp/YL+7hJI=
=+oW8
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
