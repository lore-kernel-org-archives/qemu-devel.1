Received: from eggs.gnu.org ([208.118.235.92]:53891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geugN-0003Y5-TR
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 23:32:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geugM-0005hX-7u
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 23:32:35 -0500
Date: Thu, 3 Jan 2019 14:41:59 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190103034159.GP10853@umbus.fritz.box>
References: <154535246529.862554.6113740443866753456.stgit@bahia.lan>
	<154535253055.862554.10471167343589360987.stgit@bahia.lan>
	<20181221111904-mutt-send-email-mst@kernel.org>
	<20190103003632.GG10853@umbus.fritz.box>
	<20190102222703-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nLMor0SRtNCuLS/8"
Content-Disposition: inline
In-Reply-To: <20190102222703-mutt-send-email-mst@kernel.org>
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


--nLMor0SRtNCuLS/8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2019 at 10:27:14PM -0500, Michael S. Tsirkin wrote:
> On Thu, Jan 03, 2019 at 11:36:33AM +1100, David Gibson wrote:
> > On Fri, Dec 21, 2018 at 11:19:18AM -0500, Michael S. Tsirkin wrote:
> > > On Fri, Dec 21, 2018 at 01:35:30AM +0100, Greg Kurz wrote:
> > > > From: Michael Roth <mdroth@linux.vnet.ibm.com>
> > > >=20
> > > > This adds cleanup counterparts to pci_register_root_bus(),
> > > > pci_root_bus_new(), and pci_bus_irqs().
> > > >=20
> > > > These cleanup routines are needed in the case of hotpluggable
> > > > PCIHostBridge implementations. Currently we can rely on the
> > > > object_unparent()'ing of the PCIHostState recursively unparenting
> > > > and cleaning up it's child buses, but we need explicit calls
> > > > to also:
> > > >=20
> > > >   1) remove the PCIHostState from pci_host_bridges global list.
> > > >      otherwise, we risk accessing freed memory when we access
> > > >      the list later
> > > >   2) clean up memory allocated in pci_bus_irqs()
> > > >=20
> > > > Both are handled outside the context of any particular bus or
> > > > host bridge's init/realize functions, making it difficult to
> > > > avoid the need for explicit cleanup functions without remodeling
> > > > how PCIHostBridges are created. So keep it simple and just add
> > > > them for now.
> > > >=20
> > > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > > > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > >=20
> > > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> >=20
> > I've applied this tentatively to ppc-for-4.0.  Let me know, Michael,
> > if you'd prefer to take it through your tree.
>=20
>=20
> I think your tree makes sense for this.

Great, will do.

>=20
> > >=20
> > > > ---
> > > >  hw/pci/pci.c         |   33 +++++++++++++++++++++++++++++++++
> > > >  include/hw/pci/pci.h |    3 +++
> > > >  2 files changed, 36 insertions(+)
> > > >=20
> > > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > > index efb5ce196ffb..16354f91206c 100644
> > > > --- a/hw/pci/pci.c
> > > > +++ b/hw/pci/pci.c
> > > > @@ -333,6 +333,13 @@ static void pci_host_bus_register(DeviceState =
*host)
> > > >      QLIST_INSERT_HEAD(&pci_host_bridges, host_bridge, next);
> > > >  }
> > > > =20
> > > > +static void pci_host_bus_unregister(DeviceState *host)
> > > > +{
> > > > +    PCIHostState *host_bridge =3D PCI_HOST_BRIDGE(host);
> > > > +
> > > > +    QLIST_REMOVE(host_bridge, next);
> > > > +}
> > > > +
> > > >  PCIBus *pci_device_root_bus(const PCIDevice *d)
> > > >  {
> > > >      PCIBus *bus =3D pci_get_bus(d);
> > > > @@ -379,6 +386,11 @@ static void pci_root_bus_init(PCIBus *bus, Dev=
iceState *parent,
> > > >      pci_host_bus_register(parent);
> > > >  }
> > > > =20
> > > > +static void pci_bus_uninit(PCIBus *bus)
> > > > +{
> > > > +    pci_host_bus_unregister(BUS(bus)->parent);
> > > > +}
> > > > +
> > > >  bool pci_bus_is_express(PCIBus *bus)
> > > >  {
> > > >      return object_dynamic_cast(OBJECT(bus), TYPE_PCIE_BUS);
> > > > @@ -413,6 +425,12 @@ PCIBus *pci_root_bus_new(DeviceState *parent, =
const char *name,
> > > >      return bus;
> > > >  }
> > > > =20
> > > > +void pci_root_bus_cleanup(PCIBus *bus)
> > > > +{
> > > > +    pci_bus_uninit(bus);
> > > > +    object_unparent(OBJECT(bus));
> > > > +}
> > > > +
> > > >  void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn set_irq, pci_map_irq=
_fn map_irq,
> > > >                    void *irq_opaque, int nirq)
> > > >  {
> > > > @@ -423,6 +441,15 @@ void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn =
set_irq, pci_map_irq_fn map_irq,
> > > >      bus->irq_count =3D g_malloc0(nirq * sizeof(bus->irq_count[0]));
> > > >  }
> > > > =20
> > > > +void pci_bus_irqs_cleanup(PCIBus *bus)
> > > > +{
> > > > +    bus->set_irq =3D NULL;
> > > > +    bus->map_irq =3D NULL;
> > > > +    bus->irq_opaque =3D NULL;
> > > > +    bus->nirq =3D 0;
> > > > +    g_free(bus->irq_count);
> > > > +}
> > > > +
> > > >  PCIBus *pci_register_root_bus(DeviceState *parent, const char *nam=
e,
> > > >                                pci_set_irq_fn set_irq, pci_map_irq_=
fn map_irq,
> > > >                                void *irq_opaque,
> > > > @@ -439,6 +466,12 @@ PCIBus *pci_register_root_bus(DeviceState *par=
ent, const char *name,
> > > >      return bus;
> > > >  }
> > > > =20
> > > > +void pci_unregister_root_bus(PCIBus *bus)
> > > > +{
> > > > +    pci_bus_irqs_cleanup(bus);
> > > > +    pci_root_bus_cleanup(bus);
> > > > +}
> > > > +
> > > >  int pci_bus_num(PCIBus *s)
> > > >  {
> > > >      return PCI_BUS_GET_CLASS(s)->bus_num(s);
> > > > diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> > > > index e6514bba23aa..8998e3be3390 100644
> > > > --- a/include/hw/pci/pci.h
> > > > +++ b/include/hw/pci/pci.h
> > > > @@ -405,8 +405,10 @@ PCIBus *pci_root_bus_new(DeviceState *parent, =
const char *name,
> > > >                           MemoryRegion *address_space_mem,
> > > >                           MemoryRegion *address_space_io,
> > > >                           uint8_t devfn_min, const char *typename);
> > > > +void pci_root_bus_cleanup(PCIBus *bus);
> > > >  void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn set_irq, pci_map_irq=
_fn map_irq,
> > > >                    void *irq_opaque, int nirq);
> > > > +void pci_bus_irqs_cleanup(PCIBus *bus);
> > > >  int pci_bus_get_irq_level(PCIBus *bus, int irq_num);
> > > >  /* 0 <=3D pin <=3D 3 0 =3D INTA, 1 =3D INTB, 2 =3D INTC, 3 =3D INT=
D */
> > > >  int pci_swizzle_map_irq_fn(PCIDevice *pci_dev, int pin);
> > > > @@ -417,6 +419,7 @@ PCIBus *pci_register_root_bus(DeviceState *pare=
nt, const char *name,
> > > >                                MemoryRegion *address_space_io,
> > > >                                uint8_t devfn_min, int nirq,
> > > >                                const char *typename);
> > > > +void pci_unregister_root_bus(PCIBus *bus);
> > > >  void pci_bus_set_route_irq_fn(PCIBus *, pci_route_irq_fn);
> > > >  PCIINTxRoute pci_device_route_intx_to_irq(PCIDevice *dev, int pin);
> > > >  bool pci_intx_route_changed(PCIINTxRoute *old, PCIINTxRoute *new);
> > >=20
> >=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nLMor0SRtNCuLS/8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwthIcACgkQbDjKyiDZ
s5I/6Q//XdnjfxNvbfeJvgjEQqPQJi20r034CX0qSlkchEoNex5YcaXy4xWTA9G8
BbEyf2Mw1sIoxBqA8L1WM5B1QqN8CPo3rP5OcBqJFR9dwqd6QoSSDoq1ExqvNg4T
hPJ7VSbS+xt/kid1cOn9AqWLT5N5JHV+LKf/OeevX75B7AZgFHR/7i7NHY9rLSNe
0R/ubc/g3SMHa5/5GMhNHiCGnE4fETXBqsklzqNx7GD6gFNu2RFitytajWdzKiaF
blGTY4jHYUMzy6BvdgjE8urmQbLPl9IpI8b0txY1rylpEs+frt0XPusIse4ZucM/
FQ2rrGFF/WxtZipMXKA5T0RYzy1kwD9ptRFx89fRO9LsXaA7pgSQStvv4erOmKGu
wBl3n+4HB104kEuHCp3TGBKB1JULmvDglnB3wOtyeTIbgFIc1eAj2mGGAGgZG8Rh
T6tYrJHVKL5VUVlIyMqwSC9SmaQBjLBrBevplmXB9PgwhzMucsz2EvnFjuUysQTK
sgoHQ7NOtP44+5hDckGfGj+YvCutP5ikkW7FH+V02JraoXkxPW80z0QUtO9ldu29
ssQSOA9E62Luctx2j3bbVsVKlKP34PwKmR5H+gxrH7Ywq9JOtUvgc3IGHRAo6gxv
qq4dSoNlvMAaKjM0Dn6OoxPsEZNuDYmL4m6wcm+UM8rGn/PiCWs=
=OUrF
-----END PGP SIGNATURE-----

--nLMor0SRtNCuLS/8--
