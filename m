Received: from eggs.gnu.org ([2001:4830:134:3::10]:52978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d55K3-0005Pe-54
	for qemu-devel@nongnu.org; Mon, 01 May 2017 03:00:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d55K0-0007PO-4h
	for qemu-devel@nongnu.org; Mon, 01 May 2017 03:00:39 -0400
Date: Mon, 1 May 2017 16:56:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170501065612.GB9514@umbus.fritz.box>
References: <20170328021651.19350-1-david@gibson.dropbear.id.au>
	<20170328021651.19350-3-david@gibson.dropbear.id.au>
	<20170426182535-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline
In-Reply-To: <20170426182535-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: ehabkost@redhat.com, aik@ozlabs.ru, marcel@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lersek@redhat.com


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 26, 2017 at 06:29:05PM +0300, Michael S. Tsirkin wrote:
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
> >  {
> > -    PCIBus *bus =3D pci_dev->bus;
> > +    PCIHostState *host_bridge =3D PCI_HOST_BRIDGE(pci_device_root_bus(=
pci_dev)->qbus.parent);
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
>=20
> I think I'd prefer adding some flags in PCIBus

I'm not really sure what you have in mind from that.  Remember that we
need to be able to set this based on machine type for backwards
compatibility.

>  While we are at it,
> is_root can become a flag too.

Seems a bit odd to me, since it can be derived from the existing
information.

>=20
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

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZBtwMAAoJEGw4ysog2bOS5xoP/2P8KAGmF0AE9U36bRk7xsj8
/h8Fs5RNDg1rus5ig6gFlIiw8Qc3U/bt/WAQVghEWMu2oR8wgYJsbIzkUYYdt8sh
UQPnFXSSTDB+ShjERVuMkRRiDQjcu4vPkDEpZTxj7gDNg0lbKEqdqTiCyeYd+F4o
M99D1TrFvVNwrU2JaTFRm9hJo0p6gKO0OBZhA9ITDQdtYfIQOE4S+LEU2dszymSV
72C/tLfezSPr+hUaUK9IJT2arjU22BLqd0TG9yxbc54w2aDVpjWDUgsJB791x0YT
uTg1y7xPCQYvIMYuiGZEMd8jv48mwLzHACQhGmqRJNYygKi9CCytD5jUPEpmIpGS
38fIenVzOyE/F3LyAXCXijBU3XbrK5z3lqVr5Fce/aHpabzzZ6oET66eWkopUWoE
B0LiMOTthOyhTq9qdeIWqeMJLS9w3jiTgWTfFyDc//QwGy9ntKRfHpFbaUO2vwoJ
Efjo3Tuqkz6ECNgK+WRuR5kZ4IiQwz0HAb9+Aw36UYSyg+yB/g1mclKbvmTL6lZQ
+SmRJADFzBvMnParhXC9/grmLj7oUWg5iCUQc4ubFyHRTLgQBq79V16i5EwurGqX
xGQbeihlzVU6u7oW1ffVJGxxgafGeBJZ4cNpuwNY7aMQT/eeWlKFXF5LGPBR1KkA
oWsrOY4B83HsGCOy8tD1
=Lkid
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
