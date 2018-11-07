Received: from eggs.gnu.org ([2001:4830:134:3::10]:52120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKCD3-0007In-4J
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 20:00:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKCD0-00071E-93
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 20:00:40 -0500
Date: Wed, 7 Nov 2018 11:59:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181107005958.GB1754@umbus.fritz.box>
References: <20181105102044.20547-1-david@redhat.com>
	<20181105102044.20547-10-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Content-Disposition: inline
In-Reply-To: <20181105102044.20547-10-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 09/10] pci/shpc: perform unplug via the
 hotplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2018 at 11:20:43AM +0100, David Hildenbrand wrote:
> Introduce and use the "unplug" callback.
>=20
> This is a preparation for multi-stage hotplug handlers, whereby the bus
> hotplug handler is overwritten by the machine hotplug handler. This handl=
er
> will then pass control to the bus hotplug handler. So to get this running
> cleanly, we also have to make sure to go via the hotplug handler chain wh=
en
> actually unplugging a device after an unplug request. Lookup the hotplug
> handler and call "unplug".
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/pci-bridge/pci_bridge_dev.c  | 14 ++++++++++++++
>  hw/pci-bridge/pcie_pci_bridge.c | 14 ++++++++++++++
>  hw/pci/shpc.c                   | 11 ++++++++++-
>  include/hw/pci/shpc.h           |  2 ++
>  4 files changed, 40 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_de=
v.c
> index e1df9a52ac..91415f114c 100644
> --- a/hw/pci-bridge/pci_bridge_dev.c
> +++ b/hw/pci-bridge/pci_bridge_dev.c
> @@ -219,6 +219,19 @@ static void pci_bridge_dev_plug_cb(HotplugHandler *h=
otplug_dev,
>      shpc_device_plug_cb(hotplug_dev, dev, errp);
>  }
> =20
> +static void pci_bridge_dev_unplug_cb(HotplugHandler *hotplug_dev,
> +                                     DeviceState *dev, Error **errp)
> +{
> +    PCIDevice *pci_hotplug_dev =3D PCI_DEVICE(hotplug_dev);
> +
> +    if (!shpc_present(pci_hotplug_dev)) {
> +        error_setg(errp, "standard hotplug controller has been disabled =
for "
> +                   "this %s", TYPE_PCI_BRIDGE_DEV);
> +        return;
> +    }
> +    shpc_device_unplug_cb(hotplug_dev, dev, errp);
> +}
> +
>  static void pci_bridge_dev_unplug_request_cb(HotplugHandler *hotplug_dev,
>                                               DeviceState *dev, Error **e=
rrp)
>  {
> @@ -251,6 +264,7 @@ static void pci_bridge_dev_class_init(ObjectClass *kl=
ass, void *data)
>      dc->vmsd =3D &pci_bridge_dev_vmstate;
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>      hc->plug =3D pci_bridge_dev_plug_cb;
> +    hc->unplug =3D pci_bridge_dev_unplug_cb;
>      hc->unplug_request =3D pci_bridge_dev_unplug_request_cb;
>  }
> =20
> diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bri=
dge.c
> index c634353b06..7c667bc97c 100644
> --- a/hw/pci-bridge/pcie_pci_bridge.c
> +++ b/hw/pci-bridge/pcie_pci_bridge.c
> @@ -150,6 +150,19 @@ static void pcie_pci_bridge_plug_cb(HotplugHandler *=
hotplug_dev,
>      shpc_device_plug_cb(hotplug_dev, dev, errp);
>  }
> =20
> +static void pcie_pci_bridge_unplug_cb(HotplugHandler *hotplug_dev,
> +                                      DeviceState *dev, Error **errp)
> +{
> +    PCIDevice *pci_hotplug_dev =3D PCI_DEVICE(hotplug_dev);
> +
> +    if (!shpc_present(pci_hotplug_dev)) {
> +        error_setg(errp, "standard hotplug controller has been disabled =
for "
> +                   "this %s", TYPE_PCIE_PCI_BRIDGE_DEV);
> +        return;
> +    }
> +    shpc_device_unplug_cb(hotplug_dev, dev, errp);
> +}
> +
>  static void pcie_pci_bridge_unplug_request_cb(HotplugHandler *hotplug_de=
v,
>                                                DeviceState *dev, Error **=
errp)
>  {
> @@ -180,6 +193,7 @@ static void pcie_pci_bridge_class_init(ObjectClass *k=
lass, void *data)
>      dc->reset =3D &pcie_pci_bridge_reset;
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>      hc->plug =3D pcie_pci_bridge_plug_cb;
> +    hc->unplug =3D pcie_pci_bridge_unplug_cb;
>      hc->unplug_request =3D pcie_pci_bridge_unplug_request_cb;
>  }
> =20
> diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
> index 098ffaef1d..5de905cb56 100644
> --- a/hw/pci/shpc.c
> +++ b/hw/pci/shpc.c
> @@ -238,6 +238,7 @@ static void shpc_invalid_command(SHPCDevice *shpc)
> =20
>  static void shpc_free_devices_in_slot(SHPCDevice *shpc, int slot)
>  {
> +    HotplugHandler *hotplug_ctrl;
>      int devfn;
>      int pci_slot =3D SHPC_IDX_TO_PCI(slot);
>      for (devfn =3D PCI_DEVFN(pci_slot, 0);
> @@ -245,7 +246,9 @@ static void shpc_free_devices_in_slot(SHPCDevice *shp=
c, int slot)
>           ++devfn) {
>          PCIDevice *affected_dev =3D shpc->sec_bus->devices[devfn];
>          if (affected_dev) {
> -            object_unparent(OBJECT(affected_dev));
> +            hotplug_ctrl =3D qdev_get_hotplug_handler(DEVICE(affected_de=
v));
> +            hotplug_handler_unplug(hotplug_ctrl, DEVICE(affected_dev),
> +                                   &error_abort);
>          }
>      }
>  }
> @@ -540,6 +543,12 @@ void shpc_device_plug_cb(HotplugHandler *hotplug_dev=
, DeviceState *dev,
>      shpc_interrupt_update(pci_hotplug_dev);
>  }
> =20
> +void shpc_device_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
> +                           Error **errp)
> +{
> +    object_unparent(OBJECT(dev));
> +}
> +
>  void shpc_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>                                     DeviceState *dev, Error **errp)
>  {
> diff --git a/include/hw/pci/shpc.h b/include/hw/pci/shpc.h
> index 71293aca58..18f6ec1cd5 100644
> --- a/include/hw/pci/shpc.h
> +++ b/include/hw/pci/shpc.h
> @@ -47,6 +47,8 @@ void shpc_cap_write_config(PCIDevice *d, uint32_t addr,=
 uint32_t val, int len);
> =20
>  void shpc_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>                           Error **errp);
> +void shpc_device_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
> +                           Error **errp);
>  void shpc_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>                                     DeviceState *dev, Error **errp);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlviOQ4ACgkQbDjKyiDZ
s5KGjg//VxUZhbGGbO969WFkjognUeDpeKNULkh+yYs8Q3CvRGt+oBP/CXROucmn
q/pZjfq3hJ3quj/KY/479/8bh3Zbfc3T2K2UKKlQAs6oCiF/koEkAMaerVK1wu7W
VC1NQMr96sKFDmMZ5tCe3gtm4DOz1MkHC3CIkjcwjKuuea+IB/NoKnPMRfryRHPJ
Sgf/OpXV5GPy8Tesn5fFDKbHud1ipB6jfhABLchU0udtOFyawuFr+bUzNDsujGCu
oCXOeLWmcUi3KbKDxtb1YNMC+sWKa8/128sFPS2gSTCuUyiTVYtD0OkNAipyMrjm
dDS32tMy5RECtK4grmogP3rDswSlo4bbemEv3MN5V0gBnkHK1lQgaAZLf+GsW+CY
v5VSHKsjXQGDN+5FP5hYQZIew9dmF9OlrcuJoL9j5Gn/SkFsrK7MSbCIDLzynAxY
WuFQ8Gj5XwYpqZHERazaz14mutAKR+DvAb1f8eW6MRlj7BZrbwbCcuYcR9ejH/FD
vpikXriAhe0cbWz3hWwgRXaDKFQwAAGXrVB09iBLKWS0Gy9cf5PAqFvHgL95qHcv
zmzYHkQbHcWHRe1Oi6Fxv96rkUV5ylzzeqiZJPRddjVxqdYM4IVCNxp1TkgXZl25
cz8NfgMrAGwPOX1yeJnUbv8PoujHTD9DUirFAml0gZ03gZ537Kk=
=A1Zv
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--
