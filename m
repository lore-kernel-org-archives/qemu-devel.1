Received: from eggs.gnu.org ([2001:4830:134:3::10]:46349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eK2My-0002TF-Kr
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 08:25:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eK2Mv-0003iX-Gd
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 08:25:44 -0500
Received: from ozlabs.org ([103.22.144.67]:48817)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1eK2Mu-0003fc-R0
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 08:25:41 -0500
Date: Thu, 30 Nov 2017 00:12:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171129131244.GM3023@umbus.fritz.box>
References: <20171129084628.12336-1-david@gibson.dropbear.id.au>
	<20171129084628.12336-5-david@gibson.dropbear.id.au>
	<58542052-e433-9105-20ac-734ad4b718e2@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zROEGoKAXsG5UqGB"
Content-Disposition: inline
In-Reply-To: <58542052-e433-9105-20ac-734ad4b718e2@redhat.com>
Subject: Re: [Qemu-devel] [for-2.12 4/7] pci: Simplify pci_bus_is_root()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org


--zROEGoKAXsG5UqGB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2017 at 12:45:28PM +0200, Marcel Apfelbaum wrote:
> On 29/11/2017 10:46, David Gibson wrote:
> > pci_bus_is_root() currently relies on a method in the PCIBusClass.
> > But it's always known if a PCI bus is a root bus when we create it, so
> > using a dynamic method is overkill.
> >=20
> > This replaces it with an IS_ROOT bit in a new flags field, which is set=
 on
> > root buses and otherwise clear.  As a bonus this removes the special
> > is_root logic from pci_expander_bridge, since it already creates its bus
> > as a root bus.
> >=20
>=20
> I agree it makes the code simpler, I am not sure about
> the enum. Why not make it a boolean field and when will need
> more flags just convert it to an enum (or not)?

Well, I have some patches I'm working on (rather slowly) which add a
second flag.

>=20
> Thanks,
> Marcel
>=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >   hw/pci-bridge/pci_expander_bridge.c |  6 ------
> >   hw/pci/pci.c                        | 14 ++------------
> >   include/hw/pci/pci.h                | 12 +++++++++++-
> >   3 files changed, 13 insertions(+), 19 deletions(-)
> >=20
> > diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_ex=
pander_bridge.c
> > index 5652cf06e9..11dfa9258e 100644
> > --- a/hw/pci-bridge/pci_expander_bridge.c
> > +++ b/hw/pci-bridge/pci_expander_bridge.c
> > @@ -65,11 +65,6 @@ static int pxb_bus_num(PCIBus *bus)
> >       return pxb->bus_nr;
> >   }
> > -static bool pxb_is_root(PCIBus *bus)
> > -{
> > -    return true; /* by definition */
> > -}
> > -
> >   static uint16_t pxb_bus_numa_node(PCIBus *bus)
> >   {
> >       PXBDev *pxb =3D convert_to_pxb(bus->parent_dev);
> > @@ -82,7 +77,6 @@ static void pxb_bus_class_init(ObjectClass *class, vo=
id *data)
> >       PCIBusClass *pbc =3D PCI_BUS_CLASS(class);
> >       pbc->bus_num =3D pxb_bus_num;
> > -    pbc->is_root =3D pxb_is_root;
> >       pbc->numa_node =3D pxb_bus_numa_node;
> >   }
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index 6e11dc2fec..5fab7f23b3 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -126,14 +126,9 @@ static void pci_bus_unrealize(BusState *qbus, Erro=
r **errp)
> >       vmstate_unregister(NULL, &vmstate_pcibus, bus);
> >   }
> > -static bool pcibus_is_root(PCIBus *bus)
> > -{
> > -    return !bus->parent_dev;
> > -}
> > -
> >   static int pcibus_num(PCIBus *bus)
> >   {
> > -    if (pcibus_is_root(bus)) {
> > +    if (pci_bus_is_root(bus)) {
> >           return 0; /* pci host bridge */
> >       }
> >       return bus->parent_dev->config[PCI_SECONDARY_BUS];
> > @@ -156,7 +151,6 @@ static void pci_bus_class_init(ObjectClass *klass, =
void *data)
> >       k->unrealize =3D pci_bus_unrealize;
> >       k->reset =3D pcibus_reset;
> > -    pbc->is_root =3D pcibus_is_root;
> >       pbc->bus_num =3D pcibus_num;
> >       pbc->numa_node =3D pcibus_numa_node;
> >   }
> > @@ -385,6 +379,7 @@ static void pci_root_bus_init(PCIBus *bus, DeviceSt=
ate *parent,
> >       bus->slot_reserved_mask =3D 0x0;
> >       bus->address_space_mem =3D address_space_mem;
> >       bus->address_space_io =3D address_space_io;
> > +    bus->flags |=3D PCI_BUS_IS_ROOT;
> >       /* host bridge */
> >       QLIST_INIT(&bus->child);
> > @@ -397,11 +392,6 @@ bool pci_bus_is_express(PCIBus *bus)
> >       return object_dynamic_cast(OBJECT(bus), TYPE_PCIE_BUS);
> >   }
> > -bool pci_bus_is_root(PCIBus *bus)
> > -{
> > -    return PCI_BUS_GET_CLASS(bus)->is_root(bus);
> > -}
> > -
> >   void pci_root_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceSta=
te *parent,
> >                                 const char *name,
> >                                 MemoryRegion *address_space_mem,
> > diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> > index 77d92a3dc4..cbb3386207 100644
> > --- a/include/hw/pci/pci.h
> > +++ b/include/hw/pci/pci.h
> > @@ -404,6 +404,11 @@ typedef AddressSpace *(*PCIIOMMUFunc)(PCIBus *, vo=
id *, int);
> >   #define PCI_BUS_GET_CLASS(obj) OBJECT_GET_CLASS(PCIBusClass, (obj), T=
YPE_PCI_BUS)
> >   #define TYPE_PCIE_BUS "PCIE"
> > +enum PCIBusFlags {
> > +    /* This bus is the root of a PCI domain */
> > +    PCI_BUS_IS_ROOT                                         =3D 0x0001,
> > +};
> > +
> >   typedef struct PCIBusClass {
> >       /*< private >*/
> >       BusClass parent_class;
> > @@ -416,6 +421,7 @@ typedef struct PCIBusClass {
> >   struct PCIBus {
> >       BusState qbus;
> > +    enum PCIBusFlags flags;
> >       PCIIOMMUFunc iommu_fn;
> >       void *iommu_opaque;
> >       uint8_t devfn_min;
> > @@ -440,8 +446,12 @@ struct PCIBus {
> >       Notifier machine_done;
> >   };
> > +static inline bool pci_bus_is_root(PCIBus *bus)
> > +{
> > +    return !!(bus->flags & PCI_BUS_IS_ROOT);
> > +}
> > +
> >   bool pci_bus_is_express(PCIBus *bus);
> > -bool pci_bus_is_root(PCIBus *bus);
> >   void pci_root_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceSta=
te *parent,
> >                                 const char *name,
> >                                 MemoryRegion *address_space_mem,
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zROEGoKAXsG5UqGB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloeskYACgkQbDjKyiDZ
s5IdQRAA137TU1rEEuToHYPyDCNKZmxEERdIfBXeHgddu9doBbBHmHhcJH5vPbXT
G/Hgt3ebSg+9TF6I01TZnkCTbVQn8fYKrF8J9Yqv0PoSv+qIfk66IFnikelPfm3n
RrrIsvna6qQ+XfBpxFivyIGdseHahyQAS34Qo2ENR/6Yskgm5G6pksLqCZRTfLrX
1namYDnpDht0ysLlebFh6e6nOB3kOozFJsTxn1MlYGf8auA+yJnTDCj/HNXziP3w
Rn1rGTHGp0lezAD0D/RbnzRGbV/fv8N14nkbdyi1a/ULjYQ7czqFE9PMXjcyslwT
M2cZNKg4v2eUK2/fbwGkv2zYtzYU3CmW1hARai0eoZKzkxepCGkoljpRapbk//YX
w1No4vbrx+AKVZKpgux/Y++VdynYFE1JqayBsv9cBq9TjXmq15IEqX86q7FPswTi
R9ve/7pptF0QSkbjf+l2+xMnRzeah14c7HpvG6y5PvvUz1pTitQONvpNlqczx/yF
63cIKZp3gDQK4wAboCAE6saEnp8OKFInGZBpYWiT3hvysE2LEUWc44LmHlTYT5nj
zkB39Xtdzy2VedICCBOEMLt6jSCzonasNkiawbEN5NPoihDkkO9cIbw5uz80V9wP
KmGD6HS1LeyUeZ35NHO5qngOj/j6IG3dQoNBvoGjzDxsyxju7jE=
=0Hdy
-----END PGP SIGNATURE-----

--zROEGoKAXsG5UqGB--
