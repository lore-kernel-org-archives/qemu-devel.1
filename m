Received: from eggs.gnu.org ([209.51.188.92]:54983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hBUef-0003cB-N1
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 21:25:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hBUec-00086T-V1
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 21:25:29 -0400
Date: Wed, 3 Apr 2019 12:24:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190403012435.GB7904@umbus.fritz.box>
References: <20190402054028.20926-1-david@gibson.dropbear.id.au>
	<20190402054028.20926-6-david@gibson.dropbear.id.au>
	<20190402155305.4bf8e300@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Content-Disposition: inline
In-Reply-To: <20190402155305.4bf8e300@bahia.lan>
Subject: Re: [Qemu-devel] [RFC for-4.1 5/5] pcie: Simplify
 pci_adjust_config_limit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, clg@kaod.org


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2019 at 03:53:05PM +0200, Greg Kurz wrote:
> On Tue,  2 Apr 2019 16:40:28 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > Since c2077e2c "pci: Adjust PCI config limit based on bus topology",
> > pci_adjust_config_limit() has been used in the config space read and wr=
ite
> > paths to only permit access to extended config space on buses which per=
mit
> > it.  Specifically it prevents access on devices below a vanilla-PCI bus=
 via
> > some combination of bridges, even if both the host bridge and the device
> > itself are PCI-E.
> >=20
> > It accomplishes this with a somewhat complex call up the chain of bridg=
es
> > to see if any of them prohibit extended config space access.  This is
> > overly complex, since we can always know if the bus will support such
> > access at the point it is constructed.
> >=20
> > This patch simplifies the test by using a flag in the PCIBus instance
> > indicating wither extended configuration space is accessible.  It is al=
ways
> > false for vanilla PCI buses.  For PCI-E buses, it is true for root buses
> > and equal to the parent bus's's capability otherwise.
> >=20
> > This should cause no behavioural change.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
>=20
> LGTM. Some remarks below.
>=20
> >  hw/pci/pci.c             | 36 ++++++++++++++++++++++--------------
> >  hw/pci/pci_host.c        | 13 +++----------
> >  hw/ppc/spapr_pci.c       | 24 +++++++++---------------
> >  include/hw/pci/pci_bus.h |  3 ++-
> >  4 files changed, 36 insertions(+), 40 deletions(-)
> >=20
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index ea5941fb22..420496571e 100644
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
>=20
> s/supported/support

Corrected, along with the block comment formatting.

> > +     * root bus, or if the bus/bridge above it does as well */
> > +    if (pci_bus_is_root(bus)) {
> > +        bus->flags |=3D PCI_BUS_EXTENDED_CONFIG_SPACE;
> > +    } else {
> > +        PCIBus *parent_bus =3D pci_get_bus(bus->parent_dev);
> > +
> > +        if (pci_bus_allows_extended_config_space(parent_bus)) {
> > +            bus->flags |=3D PCI_BUS_EXTENDED_CONFIG_SPACE;
> > +        }
> > +    }
> > +}
> > +
> >  static void pci_bus_unrealize(BusState *qbus, Error **errp)
> >  {
> >      PCIBus *bus =3D PCI_BUS(qbus);
> > @@ -142,11 +161,6 @@ static uint16_t pcibus_numa_node(PCIBus *bus)
> >      return NUMA_NODE_UNASSIGNED;
> >  }
> > =20
> > -static bool pcibus_allows_extended_config_space(PCIBus *bus)
> > -{
> > -    return false;
> > -}
> > -
> >  static void pci_bus_class_init(ObjectClass *klass, void *data)
> >  {
> >      BusClass *k =3D BUS_CLASS(klass);
> > @@ -161,7 +175,6 @@ static void pci_bus_class_init(ObjectClass *klass, =
void *data)
> > =20
> >      pbc->bus_num =3D pcibus_num;
> >      pbc->numa_node =3D pcibus_numa_node;
> > -    pbc->allows_extended_config_space =3D pcibus_allows_extended_confi=
g_space;
> >  }
> > =20
> >  static const TypeInfo pci_bus_info =3D {
> > @@ -182,16 +195,11 @@ static const TypeInfo conventional_pci_interface_=
info =3D {
> >      .parent        =3D TYPE_INTERFACE,
> >  };
> > =20
> > -static bool pciebus_allows_extended_config_space(PCIBus *bus)
> > -{
> > -    return true;
> > -}
> > -
> >  static void pcie_bus_class_init(ObjectClass *klass, void *data)
> >  {
> > -    PCIBusClass *pbc =3D PCI_BUS_CLASS(klass);
> > +    BusClass *k =3D BUS_CLASS(klass);
> > =20
> > -    pbc->allows_extended_config_space =3D pciebus_allows_extended_conf=
ig_space;
> > +    k->realize =3D pcie_bus_realize;
> >  }
> > =20
> >  static const TypeInfo pcie_bus_info =3D {
> > @@ -412,7 +420,7 @@ bool pci_bus_is_express(PCIBus *bus)
> > =20
> >  bool pci_bus_allows_extended_config_space(PCIBus *bus)
> >  {
> > -    return PCI_BUS_GET_CLASS(bus)->allows_extended_config_space(bus);
> > +    return !!(bus->flags & PCI_BUS_EXTENDED_CONFIG_SPACE);
> >  }
> > =20
>=20
> Maybe make this a static inline in pci_bus.h like you already did with
> pci_bus_is_root() in the previous patch ?

I thought I'd tried that earlier and run into include hell because of
the target vs. non-target distinction.  But I must have been mistaken
because I tried it again and it worked fine.

> >  void pci_root_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceStat=
e *parent,
> > diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
> > index 9d64b2e12f..5f3497256c 100644
> > --- a/hw/pci/pci_host.c
> > +++ b/hw/pci/pci_host.c
> > @@ -53,16 +53,9 @@ static inline PCIDevice *pci_dev_find_by_addr(PCIBus=
 *bus, uint32_t addr)
> > =20
> >  static void pci_adjust_config_limit(PCIBus *bus, uint32_t *limit)
> >  {
> > -    if (*limit > PCI_CONFIG_SPACE_SIZE) {
> > -        if (!pci_bus_allows_extended_config_space(bus)) {
> > -            *limit =3D PCI_CONFIG_SPACE_SIZE;
> > -            return;
> > -        }
> > -
> > -        if (!pci_bus_is_root(bus)) {
> > -            PCIDevice *bridge =3D pci_bridge_get_device(bus);
> > -            pci_adjust_config_limit(pci_get_bus(bridge), limit);
> > -        }
> > +    if ((*limit > PCI_CONFIG_SPACE_SIZE) &&
>=20
> parenthesitis ? ;-)
>=20
> > +        !pci_bus_allows_extended_config_space(bus)) {
> > +        *limit =3D PCI_CONFIG_SPACE_SIZE;
> >      }
> >  }
> > =20
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index 2e76d8cbd8..23d70ca6fe 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -1638,26 +1638,11 @@ static void spapr_phb_unrealize(DeviceState *de=
v, Error **errp)
> >      memory_region_del_subregion(get_system_memory(), &sphb->mem32windo=
w);
> >  }
> > =20
> > -static bool spapr_phb_allows_extended_config_space(PCIBus *bus)
> > -{
> > -    SpaprPhbState *sphb =3D SPAPR_PCI_HOST_BRIDGE(BUS(bus)->parent);
> > -
> > -    return sphb->pcie_ecs;
> > -}
> > -
> > -static void spapr_phb_root_bus_class_init(ObjectClass *klass, void *da=
ta)
> > -{
> > -    PCIBusClass *pbc =3D PCI_BUS_CLASS(klass);
> > -
> > -    pbc->allows_extended_config_space =3D spapr_phb_allows_extended_co=
nfig_space;
> > -}
> > -
> >  #define TYPE_SPAPR_PHB_ROOT_BUS "spapr-pci-host-bridge-root-bus"
> > =20
> >  static const TypeInfo spapr_phb_root_bus_info =3D {
> >      .name =3D TYPE_SPAPR_PHB_ROOT_BUS,
> >      .parent =3D TYPE_PCI_BUS,
> > -    .class_init =3D spapr_phb_root_bus_class_init,
>=20
> The type is quite useless now, it should be dropped I guess, ie.
> git revert of "spapr_pci: Fix extended config space accesses".

Ah, good point.

> >  };
> > =20
> >  static void spapr_phb_realize(DeviceState *dev, Error **errp)
> > @@ -1766,6 +1751,15 @@ static void spapr_phb_realize(DeviceState *dev, =
Error **errp)
> >                                  &sphb->memspace, &sphb->iospace,
> >                                  PCI_DEVFN(0, 0), PCI_NUM_PINS,
> >                                  TYPE_SPAPR_PHB_ROOT_BUS);
> > +
> > +    /*
> > +     * Despite resembling a vanilla PCI bus in most ways, the PAPR
> > +     * para-virtualized PCI bus *does* permit PCI-E extended config
> > +     * space access
> > +     */
> > +    if (sphb->pcie_ecs) {
> > +        bus->flags |=3D PCI_BUS_EXTENDED_CONFIG_SPACE;
> > +    }
> >      phb->bus =3D bus;
> >      qbus_set_hotplug_handler(BUS(phb->bus), OBJECT(sphb), NULL);
> > =20
> > diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
> > index aea98d5040..3c0be4c420 100644
> > --- a/include/hw/pci/pci_bus.h
> > +++ b/include/hw/pci/pci_bus.h
> > @@ -17,12 +17,13 @@ typedef struct PCIBusClass {
> > =20
> >      int (*bus_num)(PCIBus *bus);
> >      uint16_t (*numa_node)(PCIBus *bus);
> > -    bool (*allows_extended_config_space)(PCIBus *bus);
> >  } PCIBusClass;
> > =20
> >  enum PCIBusFlags {
> >      /* This bus is the root of a PCI domain */
> >      PCI_BUS_IS_ROOT                                         =3D 0x0001,
> > +    /* PCIe extended configuration space is accessible on this bus */
> > +    PCI_BUS_EXTENDED_CONFIG_SPACE                           =3D 0x0002,
> >  };
> > =20
> >  struct PCIBus {
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlykC1EACgkQbDjKyiDZ
s5LGNRAAz3/ZZhd+2CjgbmovZfJhzdsDs2xUlltutgQQGqpwF1z1EU2mzaYNcy4W
Da0wwlPybhK/Pq3GtHNO0drDy6VB2YvgZ0xLWOKAPQ7dxO+NIhttvwNsIQbCiLFT
LJlr65uhlb/m2BnOlBySpwwnOBcXcNe/UUNcgz1Ho/SMsr5dxuUKoqpcT7O0OSen
RMt6HSz7K1zo9O3kv1rRL6Igl3IkmHZTlgru7o0oPMgudsILqCrXAz3A4HSoLpqo
rgGbUA12AiH8FKsGB15qzj48C9yxuxfal9qwuPfuciGwcYREXMVWMyBJlkJdazWJ
hbwPoHo9CK2BkNO9/vYoUA4W2/0hE/ERBr9a08DBFdOTVholWaxBDZFiHhuJNzH7
oLx8EB78sytSh43IHeqBBU69i+3Mki1USwRRt8P9fjvlT4fJo2ki3VmBZ5iP6EX6
eY87BsHz2i7T7Dx6VmHJEQ3FS7dF+yROqdjQ38gWdXangNd68sxNstOtRkw86d+y
2ozLsDTi8AMXH5mWdAOgUiF8+etjihV9bsx9ox/g3yTckDzXe33sJbv9acWGMRh2
ifXxIZrcdGuvsb9nl1oHjoKtIoZ8suBe5HiE3RjS+BQ5trQEzQN2v37v2ix8Xgl+
9kb6wymcUeZpuBwoe48wqtuqbgeUi7B0jn24P6WdcIO3RZ+mz9g=
=eC6L
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
