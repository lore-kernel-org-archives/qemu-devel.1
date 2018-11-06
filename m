Received: from eggs.gnu.org ([2001:4830:134:3::10]:59293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gJwZt-0002AD-DI
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 03:19:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gJwV3-0008Tf-7T
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 03:14:16 -0500
Date: Tue, 6 Nov 2018 19:14:02 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181106081401.GC3539@umbus.fritz.box>
References: <20181105102044.20547-1-david@redhat.com>
	<20181105102044.20547-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline
In-Reply-To: <20181105102044.20547-3-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 02/10] pci/shpc: rename hotplug handler
 callbacks
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


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2018 at 11:20:36AM +0100, David Hildenbrand wrote:
> The callbacks are also called for cold plugged devices. Drop the "hot"
> to better match the actual callback names.
>=20
> While at it, also rename shpc_device_hotplug_common() to
> shpc_device_plug_common().
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/pci-bridge/pci_bridge_dev.c  | 17 ++++++++---------
>  hw/pci-bridge/pcie_pci_bridge.c | 17 ++++++++---------
>  hw/pci/shpc.c                   | 14 +++++++-------
>  include/hw/pci/shpc.h           |  8 ++++----
>  4 files changed, 27 insertions(+), 29 deletions(-)
>=20
> diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_de=
v.c
> index 97a8e8b6a4..e1df9a52ac 100644
> --- a/hw/pci-bridge/pci_bridge_dev.c
> +++ b/hw/pci-bridge/pci_bridge_dev.c
> @@ -206,8 +206,8 @@ static const VMStateDescription pci_bridge_dev_vmstat=
e =3D {
>      }
>  };
> =20
> -static void pci_bridge_dev_hotplug_cb(HotplugHandler *hotplug_dev,
> -                                      DeviceState *dev, Error **errp)
> +static void pci_bridge_dev_plug_cb(HotplugHandler *hotplug_dev,
> +                                   DeviceState *dev, Error **errp)
>  {
>      PCIDevice *pci_hotplug_dev =3D PCI_DEVICE(hotplug_dev);
> =20
> @@ -216,12 +216,11 @@ static void pci_bridge_dev_hotplug_cb(HotplugHandle=
r *hotplug_dev,
>                     "this %s", TYPE_PCI_BRIDGE_DEV);
>          return;
>      }
> -    shpc_device_hotplug_cb(hotplug_dev, dev, errp);
> +    shpc_device_plug_cb(hotplug_dev, dev, errp);
>  }
> =20
> -static void pci_bridge_dev_hot_unplug_request_cb(HotplugHandler *hotplug=
_dev,
> -                                                 DeviceState *dev,
> -                                                 Error **errp)
> +static void pci_bridge_dev_unplug_request_cb(HotplugHandler *hotplug_dev,
> +                                             DeviceState *dev, Error **e=
rrp)
>  {
>      PCIDevice *pci_hotplug_dev =3D PCI_DEVICE(hotplug_dev);
> =20
> @@ -230,7 +229,7 @@ static void pci_bridge_dev_hot_unplug_request_cb(Hotp=
lugHandler *hotplug_dev,
>                     "this %s", TYPE_PCI_BRIDGE_DEV);
>          return;
>      }
> -    shpc_device_hot_unplug_request_cb(hotplug_dev, dev, errp);
> +    shpc_device_unplug_request_cb(hotplug_dev, dev, errp);
>  }
> =20
>  static void pci_bridge_dev_class_init(ObjectClass *klass, void *data)
> @@ -251,8 +250,8 @@ static void pci_bridge_dev_class_init(ObjectClass *kl=
ass, void *data)
>      dc->props =3D pci_bridge_dev_properties;
>      dc->vmsd =3D &pci_bridge_dev_vmstate;
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> -    hc->plug =3D pci_bridge_dev_hotplug_cb;
> -    hc->unplug_request =3D pci_bridge_dev_hot_unplug_request_cb;
> +    hc->plug =3D pci_bridge_dev_plug_cb;
> +    hc->unplug_request =3D pci_bridge_dev_unplug_request_cb;
>  }
> =20
>  static const TypeInfo pci_bridge_dev_info =3D {
> diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bri=
dge.c
> index 04cf5a6a92..c634353b06 100644
> --- a/hw/pci-bridge/pcie_pci_bridge.c
> +++ b/hw/pci-bridge/pcie_pci_bridge.c
> @@ -137,8 +137,8 @@ static const VMStateDescription pcie_pci_bridge_dev_v=
mstate =3D {
>          }
>  };
> =20
> -static void pcie_pci_bridge_hotplug_cb(HotplugHandler *hotplug_dev,
> -                                      DeviceState *dev, Error **errp)
> +static void pcie_pci_bridge_plug_cb(HotplugHandler *hotplug_dev,
> +                                    DeviceState *dev, Error **errp)
>  {
>      PCIDevice *pci_hotplug_dev =3D PCI_DEVICE(hotplug_dev);
> =20
> @@ -147,12 +147,11 @@ static void pcie_pci_bridge_hotplug_cb(HotplugHandl=
er *hotplug_dev,
>                     "this %s", TYPE_PCIE_PCI_BRIDGE_DEV);
>          return;
>      }
> -    shpc_device_hotplug_cb(hotplug_dev, dev, errp);
> +    shpc_device_plug_cb(hotplug_dev, dev, errp);
>  }
> =20
> -static void pcie_pci_bridge_hot_unplug_request_cb(HotplugHandler *hotplu=
g_dev,
> -                                                 DeviceState *dev,
> -                                                 Error **errp)
> +static void pcie_pci_bridge_unplug_request_cb(HotplugHandler *hotplug_de=
v,
> +                                              DeviceState *dev, Error **=
errp)
>  {
>      PCIDevice *pci_hotplug_dev =3D PCI_DEVICE(hotplug_dev);
> =20
> @@ -161,7 +160,7 @@ static void pcie_pci_bridge_hot_unplug_request_cb(Hot=
plugHandler *hotplug_dev,
>                     "this %s", TYPE_PCIE_PCI_BRIDGE_DEV);
>          return;
>      }
> -    shpc_device_hot_unplug_request_cb(hotplug_dev, dev, errp);
> +    shpc_device_unplug_request_cb(hotplug_dev, dev, errp);
>  }
> =20
>  static void pcie_pci_bridge_class_init(ObjectClass *klass, void *data)
> @@ -180,8 +179,8 @@ static void pcie_pci_bridge_class_init(ObjectClass *k=
lass, void *data)
>      dc->props =3D pcie_pci_bridge_dev_properties;
>      dc->reset =3D &pcie_pci_bridge_reset;
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> -    hc->plug =3D pcie_pci_bridge_hotplug_cb;
> -    hc->unplug_request =3D pcie_pci_bridge_hot_unplug_request_cb;
> +    hc->plug =3D pcie_pci_bridge_plug_cb;
> +    hc->unplug_request =3D pcie_pci_bridge_unplug_request_cb;
>  }
> =20
>  static const TypeInfo pcie_pci_bridge_info =3D {
> diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
> index a8462d48bb..098ffaef1d 100644
> --- a/hw/pci/shpc.c
> +++ b/hw/pci/shpc.c
> @@ -482,8 +482,8 @@ static const MemoryRegionOps shpc_mmio_ops =3D {
>          .max_access_size =3D 4,
>      },
>  };
> -static void shpc_device_hotplug_common(PCIDevice *affected_dev, int *slo=
t,
> -                                       SHPCDevice *shpc, Error **errp)
> +static void shpc_device_plug_common(PCIDevice *affected_dev, int *slot,
> +                                    SHPCDevice *shpc, Error **errp)
>  {
>      int pci_slot =3D PCI_SLOT(affected_dev->devfn);
>      *slot =3D SHPC_PCI_TO_IDX(pci_slot);
> @@ -497,7 +497,7 @@ static void shpc_device_hotplug_common(PCIDevice *aff=
ected_dev, int *slot,
>      }
>  }
> =20
> -void shpc_device_hotplug_cb(HotplugHandler *hotplug_dev, DeviceState *de=
v,
> +void shpc_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>                              Error **errp)
>  {
>      Error *local_err =3D NULL;
> @@ -505,7 +505,7 @@ void shpc_device_hotplug_cb(HotplugHandler *hotplug_d=
ev, DeviceState *dev,
>      SHPCDevice *shpc =3D pci_hotplug_dev->shpc;
>      int slot;
> =20
> -    shpc_device_hotplug_common(PCI_DEVICE(dev), &slot, shpc, &local_err);
> +    shpc_device_plug_common(PCI_DEVICE(dev), &slot, shpc, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
> @@ -540,8 +540,8 @@ void shpc_device_hotplug_cb(HotplugHandler *hotplug_d=
ev, DeviceState *dev,
>      shpc_interrupt_update(pci_hotplug_dev);
>  }
> =20
> -void shpc_device_hot_unplug_request_cb(HotplugHandler *hotplug_dev,
> -                                       DeviceState *dev, Error **errp)
> +void shpc_device_unplug_request_cb(HotplugHandler *hotplug_dev,
> +                                   DeviceState *dev, Error **errp)
>  {
>      Error *local_err =3D NULL;
>      PCIDevice *pci_hotplug_dev =3D PCI_DEVICE(hotplug_dev);
> @@ -550,7 +550,7 @@ void shpc_device_hot_unplug_request_cb(HotplugHandler=
 *hotplug_dev,
>      uint8_t led;
>      int slot;
> =20
> -    shpc_device_hotplug_common(PCI_DEVICE(dev), &slot, shpc, &local_err);
> +    shpc_device_plug_common(PCI_DEVICE(dev), &slot, shpc, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
> diff --git a/include/hw/pci/shpc.h b/include/hw/pci/shpc.h
> index ee19fecf61..71293aca58 100644
> --- a/include/hw/pci/shpc.h
> +++ b/include/hw/pci/shpc.h
> @@ -45,10 +45,10 @@ void shpc_free(PCIDevice *dev);
>  void shpc_cap_write_config(PCIDevice *d, uint32_t addr, uint32_t val, in=
t len);
> =20
> =20
> -void shpc_device_hotplug_cb(HotplugHandler *hotplug_dev, DeviceState *de=
v,
> -                            Error **errp);
> -void shpc_device_hot_unplug_request_cb(HotplugHandler *hotplug_dev,
> -                                       DeviceState *dev, Error **errp);
> +void shpc_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
> +                         Error **errp);
> +void shpc_device_unplug_request_cb(HotplugHandler *hotplug_dev,
> +                                   DeviceState *dev, Error **errp);
> =20
>  extern VMStateInfo shpc_vmstate_info;
>  #define SHPC_VMSTATE(_field, _type,  _test) \

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvhTUcACgkQbDjKyiDZ
s5LFRw//Yfaq/3HYdN6QOTD12kumjnS/o2BIMN7/Wj2hf9wUHXp1XkLMbsJr571q
/NfFsZTyr+EyBgIEgPyRUcZe/yY6wHmPXU/1/uqh/CxlTxWD3tJ5Wh6GJkBguNBz
QjnAQmo7eSPYD9k6ON0SnVZ7h+lmHKEtoLcvrtFiEkRz2A94thH05L7xJEl6d+g+
EaN2f2suGPgL+/hKZD/XtC4i2TENwdllDAUY1f4GuwlPQgDm2adDkTMY38LaGKmS
RnMFzl9K/Omlj29Cq3Ve1EnVj/we6uw0SsXF3cDYy6/pOnbKiwpPq3AVmusOoFK8
iKo+G1gWDGV2PIql01nPyDX2B1nE4ZSVb+2cAN8yXa9sP+jEVev3Iimzo+Rl5KLQ
vfY3sDu/T5Cv0Vb1o/ot6VUhM0Jr9AZnwtBVD3ElfSRTMO3k4YqN/nEvOmzS59YK
uU3tfO+5gOUITQRHkSVRvtxlVTe3TmMJbETbJ9L/Qh2PrODh/iN7IONjVOx4L2+8
BqBpylp9E8zGa/Fp+4wNiW2FRtjxGNf+FLVL6KSGpRxhSCJEjUka5dJ5r7yWijTU
Kk3KQ0e0V5zVsFtqgZQE0AM2gY92kmGkHY4P0YTJtFwbSLcXg5kUMaLd1cJu3yeZ
IIFQIJKYE7nLua2zPLXfVQ2QzXkNUac3fJ4RL86fOttqVLa4UCA=
=X4Mf
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
