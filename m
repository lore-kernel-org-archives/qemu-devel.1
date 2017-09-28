Received: from eggs.gnu.org ([2001:4830:134:3::10]:53953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dxQCT-0000cQ-06
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 00:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dxQCR-0003VF-SP
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 00:13:24 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:53289)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1dxQCQ-0003TK-G9
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 00:13:23 -0400
Date: Thu, 28 Sep 2017 14:08:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170928040809.GA12504@umbus>
References: <20170927195635.16014-1-ehabkost@redhat.com>
	<20170927195635.16014-3-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y/KK5WT0dXhrzWcJ"
Content-Disposition: inline
In-Reply-To: <20170927195635.16014-3-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] pci: Add interface names to hybrid
 PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, David Gibson <dgibson@redhat.com>, Alistair Francis <alistair23@gmail.com>, Laine Stump <laine@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>


--y/KK5WT0dXhrzWcJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2017 at 04:56:32PM -0300, Eduardo Habkost wrote:
> The following devices support both PCI Express and Conventional
> PCI, by including special code to handle the QEMU_PCI_CAP_EXPRESS
> flag and/or conditional pcie_endpoint_cap_init() calls:
>=20
> * vfio-pci (is_express=3D1, but legacy PCI handled by
>   vfio_populate_device())

In the case of VFIO, won't this depend on the capabilities of the
device on the host?

> * vmxnet3 (is_express=3D0, but PCIe handled by vmxnet3_realize())
> * pvscsi (is_express=3D0, but PCIe handled by pvscsi_realize())
> * virtio-pci (is_express=3D0, but PCIe handled by
>   virtio_pci_dc_realize(), and additional legacy PCI code at
>   virtio_pci_realize())
> * base-xhci (is_express=3D1, but pcie_endpoint_cap_init() call
>   is conditional on pci_bus_is_express(dev->bus)
>   * Note that xhci does not clear QEMU_PCI_CAP_EXPRESS like the
>     other hybrid devices
>=20
> Cc: Dmitry Fleytman <dmitry@daynix.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Except for the query above,

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> Changes v1 -> v2:
> * s/legacy/conventional/
>   * Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> * Mark base-xhci as hybrid too
> ---
>  hw/net/vmxnet3.c       | 5 +++++
>  hw/scsi/vmw_pvscsi.c   | 2 ++
>  hw/usb/hcd-xhci.c      | 5 +++++
>  hw/vfio/pci.c          | 5 +++++
>  hw/virtio/virtio-pci.c | 5 +++++
>  5 files changed, 22 insertions(+)
>=20
> diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
> index a19a7a31dd..f99d9a69ec 100644
> --- a/hw/net/vmxnet3.c
> +++ b/hw/net/vmxnet3.c
> @@ -2651,6 +2651,11 @@ static const TypeInfo vmxnet3_info =3D {
>      .instance_size =3D sizeof(VMXNET3State),
>      .class_init    =3D vmxnet3_class_init,
>      .instance_init =3D vmxnet3_instance_init,
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { INTERFACE_PCIE_DEVICE },
> +        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +        { }
> +    },
>  };
> =20
>  static void vmxnet3_register_types(void)
> diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
> index 6d3f0bf11d..d6b315f8b2 100644
> --- a/hw/scsi/vmw_pvscsi.c
> +++ b/hw/scsi/vmw_pvscsi.c
> @@ -1300,6 +1300,8 @@ static const TypeInfo pvscsi_info =3D {
>      .class_init    =3D pvscsi_class_init,
>      .interfaces =3D (InterfaceInfo[]) {
>          { TYPE_HOTPLUG_HANDLER },
> +        { INTERFACE_PCIE_DEVICE },
> +        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
>          { }
>      }
>  };
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index d75c085d94..af3a9d88de 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -3670,6 +3670,11 @@ static const TypeInfo xhci_info =3D {
>      .instance_size =3D sizeof(XHCIState),
>      .class_init    =3D xhci_class_init,
>      .abstract      =3D true,
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { INTERFACE_PCIE_DEVICE },
> +        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +        { }
> +    },
>  };
> =20
>  static void qemu_xhci_class_init(ObjectClass *klass, void *data)
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 31e1edf447..913433d6ba 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3023,6 +3023,11 @@ static const TypeInfo vfio_pci_dev_info =3D {
>      .class_init =3D vfio_pci_dev_class_init,
>      .instance_init =3D vfio_instance_init,
>      .instance_finalize =3D vfio_instance_finalize,
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { INTERFACE_PCIE_DEVICE },
> +        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +        { }
> +    },
>  };
> =20
>  static void register_vfio_pci_dev_type(void)
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 8b0d6b69cd..67c8ab63ad 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1958,6 +1958,11 @@ static const TypeInfo virtio_pci_info =3D {
>      .class_init    =3D virtio_pci_class_init,
>      .class_size    =3D sizeof(VirtioPCIClass),
>      .abstract      =3D true,
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { INTERFACE_PCIE_DEVICE },
> +        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +        { }
> +    },
>  };
> =20
>  /* virtio-blk-pci */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--y/KK5WT0dXhrzWcJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnMdakACgkQbDjKyiDZ
s5LefQ/+IPPil4/V8M9Fm3g3dTm9hBiKxLbeGNMXQ2ax46j5m+AySc1CUIa5beAf
622//9qw8PoLmiFdk9mCs2izpyP48eaBdx8Nm1tIoGXULFo0z7HWyqk1KCn58D1N
M0PEMqGZfshzY8x7XsFX+H8ca9tmM9BDZAbGbG/4AYJCIpuzp9L5uUt87pt6OzZr
C/7s4q3kG5fr9oQ9y1FOM4QMKajaoUM4AFZyS9JGi51eyyT2ftwAmsiJEopRyTJ/
GetwzKmSZLH0SC6Ufs+U6jP3jT0P+frnQESyZkIiFL/ooMyXofiltuB9QlLn19lC
ft8rBVekBxu8sH0XscvA5lvMh7ZKSYqeJmybKbQrLe6ZbfIUBSPTPr+TObp5ZsDH
ewjIYkh5b6llqhlbiX+hEEW07ON98X7ly3PqYa7PYowOqvvT8YrqIAh2I3tcpYMf
d6cMvfJGgk85rP0uMgAxz7IsZ8iLY5hqZbr2JDkr6/2a7yQ7hR11uK9Hm4m0x3H7
sEoYgwIepCToR9IR9k398c0wKv7rcAOZ/17sWo6S5ihLUzA7pFsS4LgDhSNqIYol
wAymCvwy6jrXsYgYqIo3cz9tquPRPzXkZwSQeXxHmpRj/OiEIZjBN47JtjQWAaI7
5CiEsYDskgY+zg+TlbuJLZUPQRtYGR62Jtyprk/xnveMS2Cr0xk=
=OE6a
-----END PGP SIGNATURE-----

--y/KK5WT0dXhrzWcJ--
