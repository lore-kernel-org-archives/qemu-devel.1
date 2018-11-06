Received: from eggs.gnu.org ([2001:4830:134:3::10]:53767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gJwAE-0003cP-CK
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 02:52:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gJwAC-0000zk-Dz
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 02:52:42 -0500
Date: Tue, 6 Nov 2018 17:03:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181106060306.GB3539@umbus.fritz.box>
References: <20181105102044.20547-1-david@redhat.com>
	<20181105102044.20547-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <20181105102044.20547-2-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 01/10] pci/pcie: rename hotplug handler
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


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2018 at 11:20:35AM +0100, David Hildenbrand wrote:
> The callbacks are also called for cold plugged devices. Drop the "hot"
> to better match the actual callback names.
>=20
> While at it, also rename  pcie_cap_slot_hotplug_common() to
> pcie_cap_slot_check_common().

Uh.. this part of the message doesn't appear to be accurate any more.

>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Apart from that,

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/pci/pcie.c         | 17 ++++++++---------
>  hw/pci/pcie_port.c    |  4 ++--
>  include/hw/pci/pcie.h |  8 ++++----
>  3 files changed, 14 insertions(+), 15 deletions(-)
>=20
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 6c91bd44a0..44737cc1cd 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -315,9 +315,8 @@ static void pcie_cap_slot_event(PCIDevice *dev, PCIEx=
pressHotPlugEvent event)
>      hotplug_event_notify(dev);
>  }
> =20
> -static void pcie_cap_slot_hotplug_common(PCIDevice *hotplug_dev,
> -                                         DeviceState *dev,
> -                                         uint8_t **exp_cap, Error **errp)
> +static void pcie_cap_slot_plug_common(PCIDevice *hotplug_dev, DeviceStat=
e *dev,
> +                                      uint8_t **exp_cap, Error **errp)
>  {
>      *exp_cap =3D hotplug_dev->config + hotplug_dev->exp.exp_cap;
>      uint16_t sltsta =3D pci_get_word(*exp_cap + PCI_EXP_SLTSTA);
> @@ -331,13 +330,13 @@ static void pcie_cap_slot_hotplug_common(PCIDevice =
*hotplug_dev,
>      }
>  }
> =20
> -void pcie_cap_slot_hotplug_cb(HotplugHandler *hotplug_dev, DeviceState *=
dev,
> -                              Error **errp)
> +void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
> +                           Error **errp)
>  {
>      uint8_t *exp_cap;
>      PCIDevice *pci_dev =3D PCI_DEVICE(dev);
> =20
> -    pcie_cap_slot_hotplug_common(PCI_DEVICE(hotplug_dev), dev, &exp_cap,=
 errp);
> +    pcie_cap_slot_plug_common(PCI_DEVICE(hotplug_dev), dev, &exp_cap, er=
rp);
> =20
>      /* Don't send event when device is enabled during qemu machine creat=
ion:
>       * it is present on boot, no hotplug event is necessary. We do send =
an
> @@ -365,14 +364,14 @@ static void pcie_unplug_device(PCIBus *bus, PCIDevi=
ce *dev, void *opaque)
>      object_unparent(OBJECT(dev));
>  }
> =20
> -void pcie_cap_slot_hot_unplug_request_cb(HotplugHandler *hotplug_dev,
> -                                         DeviceState *dev, Error **errp)
> +void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
> +                                     DeviceState *dev, Error **errp)
>  {
>      uint8_t *exp_cap;
>      PCIDevice *pci_dev =3D PCI_DEVICE(dev);
>      PCIBus *bus =3D pci_get_bus(pci_dev);
> =20
> -    pcie_cap_slot_hotplug_common(PCI_DEVICE(hotplug_dev), dev, &exp_cap,=
 errp);
> +    pcie_cap_slot_plug_common(PCI_DEVICE(hotplug_dev), dev, &exp_cap, er=
rp);
> =20
>      /* In case user cancel the operation of multi-function hot-add,
>       * remove the function that is unexposed to guest individually,
> diff --git a/hw/pci/pcie_port.c b/hw/pci/pcie_port.c
> index 6432b9ac1f..73e81e5847 100644
> --- a/hw/pci/pcie_port.c
> +++ b/hw/pci/pcie_port.c
> @@ -154,8 +154,8 @@ static void pcie_slot_class_init(ObjectClass *oc, voi=
d *data)
>      HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(oc);
> =20
>      dc->props =3D pcie_slot_props;
> -    hc->plug =3D pcie_cap_slot_hotplug_cb;
> -    hc->unplug_request =3D pcie_cap_slot_hot_unplug_request_cb;
> +    hc->plug =3D pcie_cap_slot_plug_cb;
> +    hc->unplug_request =3D pcie_cap_slot_unplug_request_cb;
>  }
> =20
>  static const TypeInfo pcie_slot_type_info =3D {
> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> index b71e369703..735f8e8154 100644
> --- a/include/hw/pci/pcie.h
> +++ b/include/hw/pci/pcie.h
> @@ -131,8 +131,8 @@ void pcie_ari_init(PCIDevice *dev, uint16_t offset, u=
int16_t nextfn);
>  void pcie_dev_ser_num_init(PCIDevice *dev, uint16_t offset, uint64_t ser=
_num);
>  void pcie_ats_init(PCIDevice *dev, uint16_t offset);
> =20
> -void pcie_cap_slot_hotplug_cb(HotplugHandler *hotplug_dev, DeviceState *=
dev,
> -                              Error **errp);
> -void pcie_cap_slot_hot_unplug_request_cb(HotplugHandler *hotplug_dev,
> -                                         DeviceState *dev, Error **errp);
> +void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
> +                           Error **errp);
> +void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
> +                                     DeviceState *dev, Error **errp);
>  #endif /* QEMU_PCIE_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvhLpcACgkQbDjKyiDZ
s5JLxxAAs8aAjUBLbXHYdps3QRkmFK9nqZZm4PLt4Gun62Bh9T2EtmMNGBR5jDfT
fNBiGn2gdmt3WTcObjoEdLboPNR+TJ7DsAMfrU7Tk9gZdYrM5JtILFHIych2i+Ea
gcw+TzFIX6ZyChDTkDYeXgctw1TWfx9v6Y3rGcCt2fqzYHv+9gO+gptN7u2pQrtF
b4mtt37iAFq0LE1s3ueKWiUkd2u8kZ8Awvo9OsKXD8wS8EiJ67r5pCicYQq+Zv13
nR4dblz5XWHJswzotpwXN7Pr+tR/qwMuEMAxTo1y1EHIYSsHb5eSPdl1l7d/PeW4
ZK9TjcCdNfi4NcXtLPYd02QxeH+lwTkjNmU9G1RHZ1t20/MB83yaCvFJNECTUZzD
FASUQmN7FD28NQZbdGyPvisZDkVOqIJbtsp5f78mrPxbrw/+kRkwrYnCs3vjj9mU
POJG0Qa83uejWoDV6vxr47/B68+8cyj2X6/mTyKYWnt9wlBkotaPth0BxEjhiuBF
RxEWPbPdbenEHk0kAzIZX0Bb51vjpd/qclCAAccA8B5LBgzEkNqdwAz5iLnKCFLS
VdtLyrDG4DESdTnRO8knLdPbZkqHryqIB/SmBmC85VOJs5rhLIRORPN5gkPc1o6o
9tEBd9kJGaEMG1FK2TrXXR4PX+dpBtrf9oulxATMcQ769xMgPtk=
=6dw/
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
