Received: from eggs.gnu.org ([208.118.235.92]:38339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gesZi-0002au-Rh
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 21:17:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gesZg-00059w-J0
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 21:17:34 -0500
Date: Thu, 3 Jan 2019 11:36:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190103003632.GG10853@umbus.fritz.box>
References: <154535246529.862554.6113740443866753456.stgit@bahia.lan>
	<154535253055.862554.10471167343589360987.stgit@bahia.lan>
	<20181221111904-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XaUbO9McV5wPQijU"
Content-Disposition: inline
In-Reply-To: <20181221111904-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH 03/15] pci: allow cleanup/unregistration of
 PCI root buses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>


--XaUbO9McV5wPQijU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 21, 2018 at 11:19:18AM -0500, Michael S. Tsirkin wrote:
> On Fri, Dec 21, 2018 at 01:35:30AM +0100, Greg Kurz wrote:
> > From: Michael Roth <mdroth@linux.vnet.ibm.com>
> >=20
> > This adds cleanup counterparts to pci_register_root_bus(),
> > pci_root_bus_new(), and pci_bus_irqs().
> >=20
> > These cleanup routines are needed in the case of hotpluggable
> > PCIHostBridge implementations. Currently we can rely on the
> > object_unparent()'ing of the PCIHostState recursively unparenting
> > and cleaning up it's child buses, but we need explicit calls
> > to also:
> >=20
> >   1) remove the PCIHostState from pci_host_bridges global list.
> >      otherwise, we risk accessing freed memory when we access
> >      the list later
> >   2) clean up memory allocated in pci_bus_irqs()
> >=20
> > Both are handled outside the context of any particular bus or
> > host bridge's init/realize functions, making it difficult to
> > avoid the need for explicit cleanup functions without remodeling
> > how PCIHostBridges are created. So keep it simple and just add
> > them for now.
> >=20
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> > Signed-off-by: Greg Kurz <groug@kaod.org>
>=20
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

I've applied this tentatively to ppc-for-4.0.  Let me know, Michael,
if you'd prefer to take it through your tree.

>=20
> > ---
> >  hw/pci/pci.c         |   33 +++++++++++++++++++++++++++++++++
> >  include/hw/pci/pci.h |    3 +++
> >  2 files changed, 36 insertions(+)
> >=20
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index efb5ce196ffb..16354f91206c 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -333,6 +333,13 @@ static void pci_host_bus_register(DeviceState *hos=
t)
> >      QLIST_INSERT_HEAD(&pci_host_bridges, host_bridge, next);
> >  }
> > =20
> > +static void pci_host_bus_unregister(DeviceState *host)
> > +{
> > +    PCIHostState *host_bridge =3D PCI_HOST_BRIDGE(host);
> > +
> > +    QLIST_REMOVE(host_bridge, next);
> > +}
> > +
> >  PCIBus *pci_device_root_bus(const PCIDevice *d)
> >  {
> >      PCIBus *bus =3D pci_get_bus(d);
> > @@ -379,6 +386,11 @@ static void pci_root_bus_init(PCIBus *bus, DeviceS=
tate *parent,
> >      pci_host_bus_register(parent);
> >  }
> > =20
> > +static void pci_bus_uninit(PCIBus *bus)
> > +{
> > +    pci_host_bus_unregister(BUS(bus)->parent);
> > +}
> > +
> >  bool pci_bus_is_express(PCIBus *bus)
> >  {
> >      return object_dynamic_cast(OBJECT(bus), TYPE_PCIE_BUS);
> > @@ -413,6 +425,12 @@ PCIBus *pci_root_bus_new(DeviceState *parent, cons=
t char *name,
> >      return bus;
> >  }
> > =20
> > +void pci_root_bus_cleanup(PCIBus *bus)
> > +{
> > +    pci_bus_uninit(bus);
> > +    object_unparent(OBJECT(bus));
> > +}
> > +
> >  void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn set_irq, pci_map_irq_fn =
map_irq,
> >                    void *irq_opaque, int nirq)
> >  {
> > @@ -423,6 +441,15 @@ void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn set_=
irq, pci_map_irq_fn map_irq,
> >      bus->irq_count =3D g_malloc0(nirq * sizeof(bus->irq_count[0]));
> >  }
> > =20
> > +void pci_bus_irqs_cleanup(PCIBus *bus)
> > +{
> > +    bus->set_irq =3D NULL;
> > +    bus->map_irq =3D NULL;
> > +    bus->irq_opaque =3D NULL;
> > +    bus->nirq =3D 0;
> > +    g_free(bus->irq_count);
> > +}
> > +
> >  PCIBus *pci_register_root_bus(DeviceState *parent, const char *name,
> >                                pci_set_irq_fn set_irq, pci_map_irq_fn m=
ap_irq,
> >                                void *irq_opaque,
> > @@ -439,6 +466,12 @@ PCIBus *pci_register_root_bus(DeviceState *parent,=
 const char *name,
> >      return bus;
> >  }
> > =20
> > +void pci_unregister_root_bus(PCIBus *bus)
> > +{
> > +    pci_bus_irqs_cleanup(bus);
> > +    pci_root_bus_cleanup(bus);
> > +}
> > +
> >  int pci_bus_num(PCIBus *s)
> >  {
> >      return PCI_BUS_GET_CLASS(s)->bus_num(s);
> > diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> > index e6514bba23aa..8998e3be3390 100644
> > --- a/include/hw/pci/pci.h
> > +++ b/include/hw/pci/pci.h
> > @@ -405,8 +405,10 @@ PCIBus *pci_root_bus_new(DeviceState *parent, cons=
t char *name,
> >                           MemoryRegion *address_space_mem,
> >                           MemoryRegion *address_space_io,
> >                           uint8_t devfn_min, const char *typename);
> > +void pci_root_bus_cleanup(PCIBus *bus);
> >  void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn set_irq, pci_map_irq_fn =
map_irq,
> >                    void *irq_opaque, int nirq);
> > +void pci_bus_irqs_cleanup(PCIBus *bus);
> >  int pci_bus_get_irq_level(PCIBus *bus, int irq_num);
> >  /* 0 <=3D pin <=3D 3 0 =3D INTA, 1 =3D INTB, 2 =3D INTC, 3 =3D INTD */
> >  int pci_swizzle_map_irq_fn(PCIDevice *pci_dev, int pin);
> > @@ -417,6 +419,7 @@ PCIBus *pci_register_root_bus(DeviceState *parent, =
const char *name,
> >                                MemoryRegion *address_space_io,
> >                                uint8_t devfn_min, int nirq,
> >                                const char *typename);
> > +void pci_unregister_root_bus(PCIBus *bus);
> >  void pci_bus_set_route_irq_fn(PCIBus *, pci_route_irq_fn);
> >  PCIINTxRoute pci_device_route_intx_to_irq(PCIDevice *dev, int pin);
> >  bool pci_intx_route_changed(PCIINTxRoute *old, PCIINTxRoute *new);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XaUbO9McV5wPQijU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwtWRAACgkQbDjKyiDZ
s5Kwlg/+L+u6ht/1GoYjtvHgc/8m4G3CcJuV2JJwkBufEiGcd4XYXdAgY6UE3pEC
G/jY31xmiBlz/fGS/XrsEBJ/ypXdm4OxzaKRbh+tYHsI/U+PsKCtexnPjqKH4giF
tjC+AFFtjrAinvQkx55U23/P2H36KBw1T1pu51kaxMg5au0+DBmTcff7FRbHo6kx
moP9AxLdbqlhxV92R3Is8EtZjeDoDPDOKwPVsmqDWu7D6DrCu1JMuFFrZcw+ldla
xXnwsQAtTrVF8oahfkCIYAyMoFkqbXK3B5fENMjtF2ZZ/tUDW53dHnqcBuuJZ92t
ZlllqWSrZzwFGzydOzOmANGtgzYRQtxdKdS85N9O04u1luijusiqLHNgt5UmV4FJ
P0BpZW22H1uGSesGYclGIET43vdYnTqKueNC29TJEvYkG1/T4MD7biWYnSsh3+Yj
CLc7PEQm62kh7Fi8cJvwfs1mFqGhXm+4VpdnfffmVeH4+81p7IxUp5UQorBpy95z
tGW/3q05tgk6QIRupM7EcMA0LZIXKjWpF6BgzNConejmQ91X5T/PU9HA5Xtl4eIJ
w+qqeLEySMAEnXKJJg/CjXIfUaAbV04e9OwL9yO30JtCd0YtCcax+9ivTrigIIQ6
iJTnDOdEr4aUnY6+sErYr/KC0nl41NTXP/bPZgr/u9gjzMAc4YQ=
=RsSK
-----END PGP SIGNATURE-----

--XaUbO9McV5wPQijU--
