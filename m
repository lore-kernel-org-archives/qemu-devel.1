Received: from eggs.gnu.org ([2001:4830:134:3::10]:43124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fivNf-00053P-Hm
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 01:33:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fivNb-0003No-99
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 01:33:35 -0400
Date: Fri, 27 Jul 2018 15:32:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180727053247.GK3694@umbus.fritz.box>
References: <20180628083633.12413-1-clg@kaod.org>
	<20180628083633.12413-2-clg@kaod.org>
	<20180718061230.GE2102@umbus.fritz.box>
	<f6500bf1-792b-aba5-9deb-adc3303eeee7@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C7Ke/meiCZutM6I/"
Content-Disposition: inline
In-Reply-To: <f6500bf1-792b-aba5-9deb-adc3303eeee7@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] ppc/pnv: Add model for Power8 PHB3
 PCIe Host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Andrea Bolognani <abologna@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>


--C7Ke/meiCZutM6I/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 24, 2018 at 02:18:30PM +0200, C=E9dric Le Goater wrote:
> Hello,
>=20
> >From the discussion on the XICS MSI object, I gather that exporting
> icp_irq is fine.=20
>=20
> Some more comments below, I have tried to answer the parts that were=20
> not addressed yet.

[snip]
> > Could you use memory_region_set_enabled() rather than having to add
> > and delete the subregion and keep track of it in this separate
> > variable?
>=20
> pnv_phb3_check_m32/m64 remap the regions.

Ah, ok.

[snip]
> > That said... shouldn't you filter our invalid or read-only regs before
> > updating the cache?
>=20
> hmm, the current model relies on the fact that some registers have
> their value implicitly updated. But I guess, we can dump which are
> accessed and implement a default behavior for these. I will take a
> look.

I don't really follow what you're saying here, but I guess I'll see
what it looks like in te next spin.

>=20
> [ ... ]
>=20
> >> +static const MemoryRegionOps pnv_phb3_msi_ops =3D {
> >> +    /* There is no .read as the read result is undefined by PCI spec =
*/
> >=20
> > What will qemu do if it hits a NULL read here?  The behaviour may be
> > undefind, but we'd prefer it didn't crash qemu..
>=20
> I will add one with a standard error message. It is better to have
> some output anyway.
>=20
> [ ... ]
>=20
> >> +static void pnv_phb3_pci_create(PnvPHB3 *phb, Error **errp)
> >> +{
> >> +    PCIHostState *pcih =3D PCI_HOST_BRIDGE(phb);
> >> +    PCIDevice *brdev;
> >> +    PCIDevice *pdev;
> >> +    PCIBus *parent;
> >> +    uint8_t chassis =3D phb->chip_id * 4 + phb->phb_id;
> >> +    uint8_t chassis_nr =3D 128;
> >> +
> >> +    /* Add root complex */
> >> +    pdev =3D pci_create(pcih->bus, 0, TYPE_PNV_PHB3_RC);
> >> +    object_property_add_child(OBJECT(phb), "phb3-rc", OBJECT(pdev), N=
ULL);
> >> +    qdev_prop_set_uint8(DEVICE(pdev), "chassis", chassis);
> >> +    qdev_prop_set_uint16(DEVICE(pdev), "slot", 1);
> >> +    qdev_init_nofail(DEVICE(pdev));
> >> +
> >> +    /* Setup bus for that chip */
> >> +    parent =3D pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
> >> +
> >> +    brdev =3D pci_create(parent, 0, "pci-bridge");
> >=20
> > What is this pci bridge representing?  I know PCI-e PHBs typically
> > have a pseudo P2P bridge right under them, but isn't that represnted
> > by the root complex above?
>=20
> This is the legacy pci bridge under the pcie bus.

Ah, ok.  Didn't realise there was a vanilla PCI bridge built in.

> Here is is the qdev hierarchy :
>=20
>   dev: pnv-phb3, id ""
>     index =3D 0 (0x0)
>     chip-id =3D 0 (0x0)
>     bus: phb3-root-bus
>       type pnv-phb3-root-bus
>       dev: pnv-phb3-rc, id ""
>         power_controller_present =3D true
>         chassis =3D 0 (0x0)
>         slot =3D 1 (0x1)
>         port =3D 0 (0x0)
>         aer_log_max =3D 8 (0x8)
>         addr =3D 00.0
>         romfile =3D ""
>         rombar =3D 1 (0x1)
>         multifunction =3D false
>         command_serr_enable =3D true
>         x-pcie-lnksta-dllla =3D true
>         x-pcie-extcap-init =3D true
>         class PCI bridge, addr 00:00.0, pci id 1014:03dc (sub 0000:0000)
>         bus: pcie.0
>           type PCIE
>           dev: pci-bridge, id ""
>             chassis_nr =3D 128 (0x80)
>             msi =3D "off"
>             shpc =3D false
>             addr =3D 00.0
>             romfile =3D ""
>             rombar =3D 1 (0x1)
>             multifunction =3D false
>             command_serr_enable =3D true
>             x-pcie-lnksta-dllla =3D true
>             x-pcie-extcap-init =3D true
>             class PCI bridge, addr 00:00.0, pci id 1b36:0001 (sub 0000:00=
00)
>             bus: pci.0
>               type PCI
>=20
> [ ... ]
>=20
> >> +static const PropertyInfo pnv_phb3_phb_id_propinfo =3D {
> >> +    .name =3D "irq",
> >> +    .get =3D pnv_phb3_get_phb_id,
> >> +    .set =3D pnv_phb3_set_phb_id,
> >> +};
> >=20
> > Can't you use a static DeviceProps style property for this, which is a
> > bit simpler?
>=20
> OK. We will address user creatable PHBs in some other way. Most
> certainly in the realize routine like you suggested.
>=20
> Thanks,
>=20
> C.=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--C7Ke/meiCZutM6I/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltarn8ACgkQbDjKyiDZ
s5L0aQ/9HstbQ0qWZyqRS9pO88YoZ/K+IKDCNNslG1pcGUTJxTpNzzX3VORmYKgR
S+2rC5Hh3Zqf61MseWDm23YPS1g4loiyPHT+xi8JgKqtz++g03lJm+4d4EA02EGo
Nl9mKpw9GCbHLngP+43fX1VRxz/eAKOBP1oyz5dioWdVGmwIu/GCX0UiPiFRKPIh
LVAOG7wIhsQodGIiq+lVFLM3+QuJLcH5EE+B+Y492vowwZiccXzuiKtxqBNtL3YH
HdEaskM5UTnlFOqvK9CNTMFx7k5jRo1busx/VhrFcbdB5P7KcTsdnAsLan0e5Ttn
xqJxQneXJVeLLvPokmbEIECz7ifzSkL1LB+D7X3gbNbYTnCCvazpdzvYTVvAj5eZ
4rJ8+BI5f4y6vs5koXTWFo9VEXGWQGuUUbJI/miyKcOLhSE2afKocPi/B78dx9Xs
ukgShYiHAzRN1N22imJ+rE8FvY6BMdwr+nl7oV/0+hhdMbab1+qvj5VeMH8Bm9B/
Fu97cNodlEW+a/t7rZmUHNzubkEDpEzaKXypW3Aeek0y+fi/wApZa2KpbVSFsfFn
3BjyqEblZXsoo7zx9JxZ5JVmWNbz5za/UlSMObFrU5LnPmWu9PWyyFZnBS/W1L/B
pqzZAwLaEUvDwDxdoPbA7gKgSjfwNaPs7ThOgjWdK8URCNxo5no=
=QxqZ
-----END PGP SIGNATURE-----

--C7Ke/meiCZutM6I/--
