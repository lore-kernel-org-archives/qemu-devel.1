Received: from eggs.gnu.org ([2001:4830:134:3::10]:54957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d0Jp3-0003xQ-53
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 23:28:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d0Jp1-0007Ix-MI
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 23:28:57 -0400
Date: Tue, 18 Apr 2017 12:21:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170418022151.GD12235@umbus.fritz.box>
References: <20170328021651.19350-1-david@gibson.dropbear.id.au>
	<20170328021651.19350-3-david@gibson.dropbear.id.au>
	<20170417183045.GA7078@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k4f25fnPtRuIRUb3"
Content-Disposition: inline
In-Reply-To: <20170417183045.GA7078@thinpad.lan.raisama.net>
Subject: Re: [Qemu-devel] [RFC for-2.10 2/3] pci: Allow host bridges to
 override PCI/PCIe hybrid device behaviour
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: aik@ozlabs.ru, marcel@redhat.com, lersek@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mst@redhat.com


--k4f25fnPtRuIRUb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 17, 2017 at 03:30:46PM -0300, Eduardo Habkost wrote:
> On Tue, Mar 28, 2017 at 01:16:50PM +1100, David Gibson wrote:
> > Currently PCI/PCIe hybrid devices - that is, devices which can appear as
> > either plain PCI or PCIe depending on where they're attached - will only
> > appear in PCIe mode if they're attached to a PCIe bus via a root port or
> > downstream port.
> >=20
> > This is correct for "standard" PCIe setups, but there are some platforms
> > which need different behaviour (notably "pseries" whose paravirtualized
> > PCI host bridges have some idiosyncracies).
> >=20
> > This patch allows the host bridge to override the normal behaviour.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/pci/pci.c              | 11 +++++++++--
> >  include/hw/pci/pci_host.h |  1 +
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index 779787b..ac68065 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -392,9 +392,16 @@ bool pci_bus_is_root(PCIBus *bus)
> > =20
> >  bool pci_allow_hybrid_pcie(PCIDevice *pci_dev)
>=20
> Why are we asking the device about allowing hybrid pcie, and not
> the bus itself? Shouldn't we be able to query this before the
> device is plugged, and before pci_dev->bus is even set?
>=20
> In other words, why pci_allow_hyberid_pcie() and
> pci_device_get_bus() get a PCIDevice* argument instead of a
> PCIBus* argument?

Ah good point.  I made it a PCIDevice simply for convenience, but
you're right we should be able to query before the device is plugged.

>=20
> >  {
> > -    PCIBus *bus =3D pci_dev->bus;
> > +    PCIHostState *host_bridge =3D PCI_HOST_BRIDGE(pci_device_root_bus(=
pci_dev)->qbus.parent);
>=20
> There's something I don't understand completely: what exactly
> guarantees that pci_device_root_bus(...)->qbus.parent is always
> going to be a PCI_HOST_BRIDGE?

Well, by definition whatever is above the root bus isn't PCI, which
pretty much means it has to be a PCI host bridge.  A machine could
break this assumption, but I think that would be a bug.  We use this
same pattern to find a PCI device's (or bus's) host bridge in other
places - there doesn't appear to be another way.

> > +    PCIHostBridgeClass *hc =3D PCI_HOST_BRIDGE_GET_CLASS(host_bridge);
> > +
> > +    if (hc->allow_hybrid_pcie) {
> > +        return hc->allow_hybrid_pcie(host_bridge, pci_dev);
> > +    } else {
> > +        PCIBus *bus =3D pci_dev->bus;
> > =20
> > -    return pci_bus_is_express(bus) && !pci_bus_is_root(bus);
> > +        return pci_bus_is_express(bus) && !pci_bus_is_root(bus);
> > +    }
> >  }
> > =20
> >  void pci_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *pa=
rent,
> > diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
> > index ba31595..ad03cca 100644
> > --- a/include/hw/pci/pci_host.h
> > +++ b/include/hw/pci/pci_host.h
> > @@ -54,6 +54,7 @@ typedef struct PCIHostBridgeClass {
> >      SysBusDeviceClass parent_class;
> > =20
> >      const char *(*root_bus_path)(PCIHostState *, PCIBus *);
> > +    bool (*allow_hybrid_pcie)(PCIHostState *, PCIDevice *);
> >  } PCIHostBridgeClass;
> > =20
> >  /* common internal helpers for PCI/PCIe hosts, cut off overflows */
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--k4f25fnPtRuIRUb3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY9Xg/AAoJEGw4ysog2bOSklYP/055wj4yq6sevItQuWmdVW/b
xcYuOftfl8s9YfZxKQQp5Wga2csszcewQe25NaMtEitaWNNXlYKaDGLJMuzXck9N
EwYwYXiwwOg59Rc5GOLj/oaRDCS+D/cF9H60R7ELw7TFJcgMVxQwj2behQkxTLCs
SSvgYbMGGfQv30AGOIOC1wTzrFe8V+/jQ9nCHYFjTFtobmyMbwbkkkEDAgeTC55K
CtC4+BH8R+ycMnaN34YXPkxndpjWUVVWpeR6BOQW5/F2mCOJBqC8PXsugkNnAxUN
frrif0gpgbZ2OhW/s1kJE9bHRrgbIWoTOR5S/afCpTPKOxaWXYXkZYnKEbwd9NIU
p/Sp6wgM5lQEwXflA0Qpf1gY/PmQwgqEOCRM1gW7LiObDf0J1wBPVVgUp9DVaDln
5wKw9GFDaX3SjN8Tt4Qg9vB8wY1tV8C/HL6MipPipKhPnjcMC86uBkek3hlEXPu1
ISCwz3PE1Mf7yGI8AifmGGEIMdoHQWLVGdeDjR4YWygqmwwDiJ62WhUKsiEVXu/z
08a+LuSBvdswR8NBEgw5nQFrRD/Bwvo9LGtDfY/USOwBOVV30MQkl/PWZkjAd/7O
43BzBxMN6octXKb4LtSGODgqF0ZTjOEQqMekZhA0Qm7D6HHnTLfgTNIok7KvcdMo
9VoCs02pY+Rvi1wDv56C
=MCbZ
-----END PGP SIGNATURE-----

--k4f25fnPtRuIRUb3--
