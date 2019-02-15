Received: from eggs.gnu.org ([209.51.188.92]:39962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1guRmP-0000U5-8n
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 19:55:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1guRdz-00025c-EQ
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 19:46:20 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:49727)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1guRdy-00022t-LD
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 19:46:19 -0500
Date: Fri, 15 Feb 2019 11:44:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190215004401.GC4573@umbus.fritz.box>
References: <20190214050808.16653-1-david@gibson.dropbear.id.au>
	<20190214050808.16653-3-david@gibson.dropbear.id.au>
	<a7779d7b-f83f-d681-b210-823b66e0f035@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qjNfmADvan18RZcF"
Content-Disposition: inline
In-Reply-To: <a7779d7b-f83f-d681-b210-823b66e0f035@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH 2/2] pcie: Don't allow extended config
 space access via conventional PCI bridges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: mst@redhat.com, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com


--qjNfmADvan18RZcF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 14, 2019 at 05:04:03PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 14/02/2019 16:08, David Gibson wrote:
> > In hardware it's possible, if odd, to have a configuration like:
> >=20
> > PCIe host bridge
> > \- PCIe to PCI bridge
> >    \- PCI to PCIe bridge
> >       \- PCIe device
> >=20
> > The PCIe extended configuration space on the device won't be
> > accessible to the host, because the cycles can't traverse the
> > conventional PCI bus on the way there.
> >=20
> > However, if we attempt to model that configuration under qemu,
> > extended config access on the device *will* work, because
> > pci_config_size() depends only on whether the device itself is PCIe
> > capable.
> >=20
> > This patch fixes that modelling error by adding a flag to each
> > PCI/PCIe bus instance indicating whether extended config space
> > accesses are possible on it.  It will always be false for conventional
> > PCI buses, for PCIe buses it will be true if and only if the parent
> > bus also has the flag set.
> >=20
> > AIUI earlier attempts to correct this have been rejected, because they
> > involved expensively traversing the whole bus hierarchy on each config
> > access.  This approach avoids that by computing the value as the bus
> > hierarchy is constructed, meaning we only need a single bit check when
> > we actually attempt the config access.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/pci/pci.c             | 32 ++++++++++++++++++++++++++++++++
> >  include/hw/pci/pci.h     |  4 +++-
> >  include/hw/pci/pci_bus.h |  2 ++
> >  3 files changed, 37 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index f6d8b337db..f2d9dff9ee 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -120,6 +120,25 @@ static void pci_bus_realize(BusState *qbus, Error =
**errp)
> >      vmstate_register(NULL, -1, &vmstate_pcibus, bus);
> >  }
> > =20
> > +static void pcie_bus_realize(BusState *qbus, Error **errp)
> > +{
> > +    PCIBus *bus =3D PCI_BUS(qbus);
> > +
> > +    pci_bus_realize(qbus, errp);
> > +
> > +    /* a PCI-E bus can supported extended config space if it's the
> > +     * root bus, or if the bus/bridge above it does as well */
> > +    if (pci_bus_is_root(bus)) {
> > +        bus->flags |=3D PCI_BUS_EXTENDED_CONFIG_SPACE;
> > +    } else {
> > +        PCIBus *parent_bus =3D pci_get_bus(bus->parent_dev);
> > +
> > +        if (pci_bus_extended_config_space(parent_bus)) {
> > +            bus->flags |=3D PCI_BUS_EXTENDED_CONFIG_SPACE;
> > +        }
> > +    }
> > +}
> > +
> >  static void pci_bus_unrealize(BusState *qbus, Error **errp)
> >  {
> >      PCIBus *bus =3D PCI_BUS(qbus);
> > @@ -166,6 +185,13 @@ static const TypeInfo pci_bus_info =3D {
> >      .class_init =3D pci_bus_class_init,
> >  };
> > =20
> > +static void pcie_bus_class_init(ObjectClass *klass, void *data)
> > +{
> > +    BusClass *k =3D BUS_CLASS(klass);
> > +
> > +    k->realize =3D pcie_bus_realize;
> > +}
> > +
> >  static const TypeInfo pcie_interface_info =3D {
> >      .name          =3D INTERFACE_PCIE_DEVICE,
> >      .parent        =3D TYPE_INTERFACE,
> > @@ -174,6 +200,7 @@ static const TypeInfo pcie_interface_info =3D {
> >  static const TypeInfo conventional_pci_interface_info =3D {
> >      .name          =3D INTERFACE_CONVENTIONAL_PCI_DEVICE,
> >      .parent        =3D TYPE_INTERFACE,
> > +    .class_init    =3D pcie_bus_class_init,
> >  };
> > =20
> >  static const TypeInfo pcie_bus_info =3D {
> > @@ -391,6 +418,11 @@ bool pci_bus_is_express(PCIBus *bus)
> >      return object_dynamic_cast(OBJECT(bus), TYPE_PCIE_BUS);
> >  }
> > =20
> > +bool pci_bus_extended_config_space(PCIBus *bus)
> > +{
> > +    return !!(bus->flags & PCI_BUS_EXTENDED_CONFIG_SPACE);
> > +}
> > +
> >  void pci_root_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceStat=
e *parent,
> >                                const char *name,
> >                                MemoryRegion *address_space_mem,
> > diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> > index 1273deb740..919e8a6f5f 100644
> > --- a/include/hw/pci/pci.h
> > +++ b/include/hw/pci/pci.h
> > @@ -395,6 +395,7 @@ typedef PCIINTxRoute (*pci_route_irq_fn)(void *opaq=
ue, int pin);
> >  #define TYPE_PCIE_BUS "PCIE"
> > =20
> >  bool pci_bus_is_express(PCIBus *bus);
> > +bool pci_bus_extended_config_space(PCIBus *bus);
> >  void pci_root_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceStat=
e *parent,
> >                                const char *name,
> >                                MemoryRegion *address_space_mem,
> > @@ -754,7 +755,8 @@ static inline int pci_is_express_downstream_port(co=
nst PCIDevice *d)
> > =20
> >  static inline uint32_t pci_config_size(const PCIDevice *d)
> >  {
> > -    return pci_is_express(d) ? PCIE_CONFIG_SPACE_SIZE : PCI_CONFIG_SPA=
CE_SIZE;
> > +    return (pci_is_express(d) && pci_bus_extended_config_space(pci_get=
_bus(d)))
> > +        ? PCIE_CONFIG_SPACE_SIZE : PCI_CONFIG_SPACE_SIZE;
>=20
>=20
> Since there is a selfnack anyway, I'll ask out of curiosity - can a
> device sit on PCIe bus and not be PCIe itself?

I believe so.  I think the most common case is plain-PCI integrated
devices in an otherwise PCI-E host bridge / root complex.

> The pci_is_express(d) check above just seems a little redundant,
> g_assert() could probably do just that.
>=20
>=20
>=20
>=20
> >  }
> > =20
> >  static inline uint16_t pci_get_bdf(PCIDevice *dev)
> > diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
> > index 3a4d599da3..8b1e849c34 100644
> > --- a/include/hw/pci/pci_bus.h
> > +++ b/include/hw/pci/pci_bus.h
> > @@ -23,6 +23,8 @@ typedef struct PCIBusClass {
> >  enum PCIBusFlags {
> >      /* This bus is the root of a PCI domain */
> >      PCI_BUS_IS_ROOT                                         =3D 0x0001,
> > +    /* PCIe extended configuration space is accessible on this bus */
> > +    PCI_BUS_EXTENDED_CONFIG_SPACE                           =3D 0x0002,
> >  };
> > =20
> >  struct PCIBus {
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qjNfmADvan18RZcF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxmC1EACgkQbDjKyiDZ
s5LejBAA1FyLA/SA0BuNJYW+2Mevyj014vrikETl+tbbXUmF1kATgfxZlQa36qkB
SVfWi4eaLGR9vf7yeiOOIRnktQFiMfzUFyu8VKYuqZRpfu9hec5jAhE4Ur9jsR/n
Ba4SltmQEaV3oY6Ki24yrCsZO8oNBVagRnq+e/oWKomuvucxZsqIL5MA71Vrssx6
MxNbj8UsbFzwYEse6B2S+rv8x9bqYTc8JyPB+Q8cQdY3pu7AzMo0g2czuWKlaKR2
ZbIU3mANe7eYc/tgJ7ATmz6nzxBpKTe7k7D/USFFdrSFiOW3fNCKl0q4wE7NTWwL
saono8/YjJqYQ8voq82DVbZNaJlODqwVAsaAIPXh9ICxbsoTovRLhBa7RVFLWnYd
oN8Qttho8WGk9+kH3+N5vqt+TBfAjeQh0lKD90lp/9qRNxZBw1P/zgIhpWtCQAv5
W4nZBDncWsjJLTxHL6mLT5sfbubFWHegepVqpiZ2oK8Z/npvb3G3w6Skw4bmTjxc
7VF+TY8afMYdtiXwLIKXPkR+lAJONyo6WTAMBgWf8LiD5HMWzgjsfGSDy9YxLVly
+051s5vebMHpG2w6Uu9oowN3RZNIT57ppjRjb/FVDJcBAOiKFH10qJsDb3FWDE5a
e5fYFLbJsChqo3pGScWpjle5r5/KOxxRkW1mFB/zKhFvwirMRJg=
=pSsk
-----END PGP SIGNATURE-----

--qjNfmADvan18RZcF--
