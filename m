Received: from eggs.gnu.org ([2001:4830:134:3::10]:36346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXEO7-0003XX-Ow
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 18:58:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXEO3-0002xj-AB
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 18:57:59 -0500
Date: Thu, 13 Dec 2018 10:57:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181212235730.GE29278@umbus.fritz.box>
References: <20181212091623.16950-1-david@redhat.com>
	<20181212091623.16950-10-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SNIs70sCzqvszXB4"
Content-Disposition: inline
In-Reply-To: <20181212091623.16950-10-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 09/11] pci: Reuse pci-bridge hotplug
 handler handlers for pcie-pci-bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Greg Kurz <groug@kaod.org>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, qemu-ppc@nongnu.org


--SNIs70sCzqvszXB4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 12, 2018 at 10:16:21AM +0100, David Hildenbrand wrote:
> These functions are essentially the same, we only have to use
> object_get_typename() for reporting errors. So let's share the
> implementation of hotplug handler callbacks.
>=20
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/pci-bridge/pci_bridge_dev.c  | 12 ++++++------
>  hw/pci-bridge/pcie_pci_bridge.c | 30 ++----------------------------
>  include/hw/pci/pci_bridge.h     |  4 ++++
>  3 files changed, 12 insertions(+), 34 deletions(-)
>=20
> diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_de=
v.c
> index e1df9a52ac..fa0be13ac4 100644
> --- a/hw/pci-bridge/pci_bridge_dev.c
> +++ b/hw/pci-bridge/pci_bridge_dev.c
> @@ -206,27 +206,27 @@ static const VMStateDescription pci_bridge_dev_vmst=
ate =3D {
>      }
>  };
> =20
> -static void pci_bridge_dev_plug_cb(HotplugHandler *hotplug_dev,
> -                                   DeviceState *dev, Error **errp)
> +void pci_bridge_dev_plug_cb(HotplugHandler *hotplug_dev, DeviceState *de=
v,
> +                            Error **errp)
>  {
>      PCIDevice *pci_hotplug_dev =3D PCI_DEVICE(hotplug_dev);
> =20
>      if (!shpc_present(pci_hotplug_dev)) {
>          error_setg(errp, "standard hotplug controller has been disabled =
for "
> -                   "this %s", TYPE_PCI_BRIDGE_DEV);
> +                   "this %s", object_get_typename(OBJECT(hotplug_dev)));
>          return;
>      }
>      shpc_device_plug_cb(hotplug_dev, dev, errp);
>  }
> =20
> -static void pci_bridge_dev_unplug_request_cb(HotplugHandler *hotplug_dev,
> -                                             DeviceState *dev, Error **e=
rrp)
> +void pci_bridge_dev_unplug_request_cb(HotplugHandler *hotplug_dev,
> +                                      DeviceState *dev, Error **errp)
>  {
>      PCIDevice *pci_hotplug_dev =3D PCI_DEVICE(hotplug_dev);
> =20
>      if (!shpc_present(pci_hotplug_dev)) {
>          error_setg(errp, "standard hotplug controller has been disabled =
for "
> -                   "this %s", TYPE_PCI_BRIDGE_DEV);
> +                   "this %s", object_get_typename(OBJECT(hotplug_dev)));
>          return;
>      }
>      shpc_device_unplug_request_cb(hotplug_dev, dev, errp);
> diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bri=
dge.c
> index c634353b06..0ffea680d5 100644
> --- a/hw/pci-bridge/pcie_pci_bridge.c
> +++ b/hw/pci-bridge/pcie_pci_bridge.c
> @@ -137,32 +137,6 @@ static const VMStateDescription pcie_pci_bridge_dev_=
vmstate =3D {
>          }
>  };
> =20
> -static void pcie_pci_bridge_plug_cb(HotplugHandler *hotplug_dev,
> -                                    DeviceState *dev, Error **errp)
> -{
> -    PCIDevice *pci_hotplug_dev =3D PCI_DEVICE(hotplug_dev);
> -
> -    if (!shpc_present(pci_hotplug_dev)) {
> -        error_setg(errp, "standard hotplug controller has been disabled =
for "
> -                   "this %s", TYPE_PCIE_PCI_BRIDGE_DEV);
> -        return;
> -    }
> -    shpc_device_plug_cb(hotplug_dev, dev, errp);
> -}
> -
> -static void pcie_pci_bridge_unplug_request_cb(HotplugHandler *hotplug_de=
v,
> -                                              DeviceState *dev, Error **=
errp)
> -{
> -    PCIDevice *pci_hotplug_dev =3D PCI_DEVICE(hotplug_dev);
> -
> -    if (!shpc_present(pci_hotplug_dev)) {
> -        error_setg(errp, "standard hotplug controller has been disabled =
for "
> -                   "this %s", TYPE_PCIE_PCI_BRIDGE_DEV);
> -        return;
> -    }
> -    shpc_device_unplug_request_cb(hotplug_dev, dev, errp);
> -}
> -
>  static void pcie_pci_bridge_class_init(ObjectClass *klass, void *data)
>  {
>      PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
> @@ -179,8 +153,8 @@ static void pcie_pci_bridge_class_init(ObjectClass *k=
lass, void *data)
>      dc->props =3D pcie_pci_bridge_dev_properties;
>      dc->reset =3D &pcie_pci_bridge_reset;
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> -    hc->plug =3D pcie_pci_bridge_plug_cb;
> -    hc->unplug_request =3D pcie_pci_bridge_unplug_request_cb;
> +    hc->plug =3D pci_bridge_dev_plug_cb;
> +    hc->unplug_request =3D pci_bridge_dev_unplug_request_cb;
>  }
> =20
>  static const TypeInfo pcie_pci_bridge_info =3D {
> diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
> index cdff7edfd1..6e37c7551a 100644
> --- a/include/hw/pci/pci_bridge.h
> +++ b/include/hw/pci/pci_bridge.h
> @@ -99,6 +99,10 @@ void pci_bridge_reset(DeviceState *qdev);
>  void pci_bridge_initfn(PCIDevice *pci_dev, const char *typename);
>  void pci_bridge_exitfn(PCIDevice *pci_dev);
> =20
> +void pci_bridge_dev_plug_cb(HotplugHandler *hotplug_dev, DeviceState *de=
v,
> +                            Error **errp);
> +void pci_bridge_dev_unplug_request_cb(HotplugHandler *hotplug_dev,
> +                                      DeviceState *dev, Error **errp);
> =20
>  /*
>   * before qdev initialization(qdev_init()), this function sets bus_name =
and

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SNIs70sCzqvszXB4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwRoGoACgkQbDjKyiDZ
s5KnVg//Qh6UPkoJ7uUZyzY0Lh1YVFHs3mC4vp/Ftqv+ky/l+eR2KzO8scozZGzW
6ZO1gMosRhm2g1EH1ewZ5QfjcuWN0xn1zr70awKJTpyMc+5tgavZ27OKUd/NHagW
vuf/KsJWRmqg07ZpnGA6ABgDz9oO+3Ya+gu+XI0UZz6NiOrUZW04Hpx+99z32u2t
G4k3xV1sXt122DLaJKogufMrNNSrcUv+aq5Np/wdqn1pItDk7NDHHL7WCs+b1ke+
EjDBNp/tLDFwc2Z+RaJXtUoYBPiM2q2H7IHjrSn1vvOfox6n3FliS6TkhX/q4a5a
+LcLVHH6P5lU6gItGQfgTRDC54F6Yh/SfIRyLBEWzIPGKkU96xGv9GR90QIXlbd5
zuTA70lZpQlAI/PIKeLCOPKHSteSJgLnke8DWguY3nodCLGcEWkpU3MqOks5mcrq
f6mptkNW4kvQ1ehlHNG96wxcx5ppUsPKdK6CfMh4dseVRSbAlJJfTVEQzsLTRiT8
fZGUlxwV2iNZMdFxXmARWwUhfs7cvTcmnmJKOQvIUPrJstG6bhDm+40iTpmgx+M6
j/63kx8ZRROLOvqwcY7+3GULH4XDf5Dyizma/FRj0Sp22Ig+FJ75wr9Y1X/hQXm1
5c7ztjDY0CXxKdDMDsDQugYUwZRNJPXfzP2iCQoOLwJNzGkl6WE=
=HGOi
-----END PGP SIGNATURE-----

--SNIs70sCzqvszXB4--
