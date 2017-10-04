Received: from eggs.gnu.org ([2001:4830:134:3::10]:39873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzd09-00056V-JN
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 02:17:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzd08-0002NG-Bh
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 02:17:49 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:60575)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1dzd07-0002MA-G9
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 02:17:48 -0400
Date: Wed, 4 Oct 2017 17:03:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171004060320.GV3260@umbus.fritz.box>
References: <20171003091423.28704-1-david@gibson.dropbear.id.au>
	<20171003091423.28704-5-david@gibson.dropbear.id.au>
	<20171003144259.GK17385@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JEhTuUFIcUlI65CC"
Content-Disposition: inline
In-Reply-To: <20171003144259.GK17385@localhost.localdomain>
Subject: Re: [Qemu-devel] [RFC 4/5] pci: Simplify pci_bus_is_root()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: mst@redhat.com, marcel@redhat.com, qemu-devel@nongnu.org, alex.williamson@redhat.com


--JEhTuUFIcUlI65CC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 03, 2017 at 11:42:59AM -0300, Eduardo Habkost wrote:
> On Tue, Oct 03, 2017 at 08:14:22PM +1100, David Gibson wrote:
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
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> >=20
> > # Conflicts:
> > #	include/hw/pci/pci_bus.h
>=20
> Should this be part of the commit message?

Oops.  I'll fix that for the next spin.

> > ---
> [...]
> > diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> > index 77d92a3dc4..cbb3386207 100644
> > --- a/include/hw/pci/pci.h
> > +++ b/include/hw/pci/pci.h
> > @@ -404,6 +404,11 @@ typedef AddressSpace *(*PCIIOMMUFunc)(PCIBus *, vo=
id *, int);
> >  #define PCI_BUS_GET_CLASS(obj) OBJECT_GET_CLASS(PCIBusClass, (obj), TY=
PE_PCI_BUS)
> >  #define TYPE_PCIE_BUS "PCIE"
> > =20
> > +enum PCIBusFlags {
> > +    /* This bus is the root of a PCI domain */
> > +    PCI_BUS_IS_ROOT                                         =3D 0x0001,
> > +};
> > +
> >  typedef struct PCIBusClass {
> >      /*< private >*/
> >      BusClass parent_class;
> > @@ -416,6 +421,7 @@ typedef struct PCIBusClass {
> > =20
> >  struct PCIBus {
> >      BusState qbus;
> > +    enum PCIBusFlags flags;
>=20
> Why not a simple boolean field?  If we want to keep the struct
> size smaller when adding more flags, we can use bit-fields.

Well, mst suggested "flags", so this is what came to mind.  I guess
being a past kernel dev has given be a tendency to avoid bitfields,
though I don't think any of the problems they can cause would apply
here.

Note that I do add a second flags bit in patch 5/5.

>=20
> >      PCIIOMMUFunc iommu_fn;
> >      void *iommu_opaque;
> >      uint8_t devfn_min;
> > @@ -440,8 +446,12 @@ struct PCIBus {
> >      Notifier machine_done;
> >  };
> > =20
> > +static inline bool pci_bus_is_root(PCIBus *bus)
> > +{
> > +    return !!(bus->flags & PCI_BUS_IS_ROOT);
> > +}
> > +
> >  bool pci_bus_is_express(PCIBus *bus);
> > -bool pci_bus_is_root(PCIBus *bus);
> >  void pci_root_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceStat=
e *parent,
> >                                const char *name,
> >                                MemoryRegion *address_space_mem,
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JEhTuUFIcUlI65CC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnUeagACgkQbDjKyiDZ
s5IrkA//dPV9zZITnVhrMeC3x58lxlMM2DkJIxGpoKp2jYh4V0/EODUbigjBr5v6
Z7fjLvXMhaIqAt+jEU6F7ZCpaYTlK+fGZROtT04CAvTSA2PetUeKa7sgN13NwOPL
1Qu2OjWHLwuZWhF1gHCjrRfFc3mCC6sCxxVTG7SdOnr0932pbgdU1XCmbnOCFA4i
UDnfS8jrCkXtIzRCsHV0VquNXPyX9H+ANOXj7nyDYDKazSBXufEi2jyHmILd/e4l
H41Y5naU/CUZl9DvdMAILGj86hcB/Bm9eDV1z+LY68H/vOn479Bzy7lrf/Y7Oy9C
aHwXPYVhAnBdm/UQ3Urlj59pctRiEMlIAIipc7V2yZwq+2qZ2umzrL4tswCYPxvJ
2pEtsohOZoDXurjc79IPL4WMJz8GwWfOmX0NNpXKOTgZy87O4CH95si/F4sRStCW
udw0P40jVQv6VLaLT2qLA68GCp4XrylEZQsSjDb3E3tD+kB+0X8xiJ0MtJXaChv+
QrInJsjYDtfUu8plLHpFUUTPYuf7TKyHMiORP43sn2CsTJ5J9XGgR3HF087qepsD
iwd86PCH/n3Z470TjKlZPAYDPbqyu8tyv4uNblMb176MJM45vY8DTrZfvB8XJP//
/SE3O/A9pjAjmS8Ogb3UQuEeQQE/6Vn8xD8Ezc60mV4TCZ20z1g=
=TR9I
-----END PGP SIGNATURE-----

--JEhTuUFIcUlI65CC--
