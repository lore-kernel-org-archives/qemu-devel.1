Received: from eggs.gnu.org ([2001:4830:134:3::10]:51615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1g7BU5-000439-OR
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 23:36:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1g7BU1-0005VJ-Mh
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 23:36:29 -0400
Date: Tue, 2 Oct 2018 11:20:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181002012025.GB1886@umbus.fritz.box>
References: <20181001150413.12955-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Content-Disposition: inline
In-Reply-To: <20181001150413.12955-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH] PPC: e500: convert SysBus init method to a
 realize method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 01, 2018 at 05:04:13PM +0200, C=E9dric Le Goater wrote:
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-3.1, thanks.

> ---
>  hw/pci-host/ppce500.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
> index eb75e080fc10..b8f8c112e662 100644
> --- a/hw/pci-host/ppce500.c
> +++ b/hw/pci-host/ppce500.c
> @@ -436,8 +436,9 @@ static AddressSpace *e500_pcihost_set_iommu(PCIBus *b=
us, void *opaque,
>      return &s->bm_as;
>  }
> =20
> -static int e500_pcihost_initfn(SysBusDevice *dev)
> +static void e500_pcihost_realize(DeviceState *dev, Error **errp)
>  {
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>      PCIHostState *h;
>      PPCE500PCIState *s;
>      PCIBus *b;
> @@ -447,7 +448,7 @@ static int e500_pcihost_initfn(SysBusDevice *dev)
>      s =3D PPC_E500_PCI_HOST_BRIDGE(dev);
> =20
>      for (i =3D 0; i < ARRAY_SIZE(s->irq); i++) {
> -        sysbus_init_irq(dev, &s->irq[i]);
> +        sysbus_init_irq(sbd, &s->irq[i]);
>      }
> =20
>      for (i =3D 0; i < PCI_NUM_PINS; i++) {
> @@ -460,7 +461,7 @@ static int e500_pcihost_initfn(SysBusDevice *dev)
>      /* PIO lives at the bottom of our bus space */
>      memory_region_add_subregion_overlap(&s->busmem, 0, &s->pio, -2);
> =20
> -    b =3D pci_register_root_bus(DEVICE(dev), NULL, mpc85xx_pci_set_irq,
> +    b =3D pci_register_root_bus(dev, NULL, mpc85xx_pci_set_irq,
>                                mpc85xx_pci_map_irq, s, &s->busmem, &s->pi=
o,
>                                PCI_DEVFN(s->first_slot, 0), 4, TYPE_PCI_B=
US);
>      h->bus =3D b;
> @@ -483,10 +484,8 @@ static int e500_pcihost_initfn(SysBusDevice *dev)
>      memory_region_add_subregion(&s->container, PCIE500_CFGADDR, &h->conf=
_mem);
>      memory_region_add_subregion(&s->container, PCIE500_CFGDATA, &h->data=
_mem);
>      memory_region_add_subregion(&s->container, PCIE500_REG_BASE, &s->iom=
em);
> -    sysbus_init_mmio(dev, &s->container);
> +    sysbus_init_mmio(sbd, &s->container);
>      pci_bus_set_route_irq_fn(b, e500_route_intx_pin_to_irq);
> -
> -    return 0;
>  }
> =20
>  static void e500_host_bridge_class_init(ObjectClass *klass, void *data)
> @@ -526,9 +525,8 @@ static Property pcihost_properties[] =3D {
>  static void e500_pcihost_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
> =20
> -    k->init =3D e500_pcihost_initfn;
> +    dc->realize =3D e500_pcihost_realize;
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>      dc->props =3D pcihost_properties;
>      dc->vmsd =3D &vmstate_ppce500_pci;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluyx9kACgkQbDjKyiDZ
s5J/3Q/8DUNGTew6VMKCMkBPdBVKznith9phpLVAM1muMy5Ffayg5rQVYjghMLJU
Tln/psFEwGPkXIiSjAm579mZlNlpSWRPgnshHTvEg4Iz72gCKUeb9hbnMmT/obk0
Y5Rx8kVaFB81br3Nuk2OnRC9eJ5WdjMJ7JInBVTtoVXJRO+9RdWgkwdGSbtjo02m
+rK/Ebi3GH+xcFRdZQJGQuNj0cNIxBzkiPy5zj9S1IBXP/EJOhgZNt7AuilDhsIQ
lBuy9hodhXN3hax2nNNJI0+ZrC1gxfn4ZzX24gPxsCvZ7lwEAYg/AS2WQk/0r1ac
Hv2Jyi1TvsCDGchcdqGHgQtb2Gn0O5+TAzEoGLfx1dY/8E80ztJ46OaOpdddXKKU
MHtid+bXbpYkOtJ6dulomv7++SexViVZ83BGx7fCyzy/rlHxjOzHJRjp6Q0Nv9fH
evvUFvPp1dmbt+M1WGDlmRTIimNvu40pynjvLfM59hNz4caUMHQ6B4MlALdq+zv5
rRAw61Bxdf4YrP4j7IwCzAPB/EvRCw6h6F8SyJbZqiT072908+Zitv4vQIPjmNEz
lcIALzhgq1HThGFF3XH+1kHO3T+chRhSdRksJcYGA3amBnQUdS47y+mZjqdoMdL7
hYtgfkFQ7qce62wKMZH3dbUgAbrOUdAXHzZqmwiwSUS0howSNNY=
=YTLz
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
