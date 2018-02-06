Received: from eggs.gnu.org ([2001:4830:134:3::10]:37438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ej6aC-0002QS-8c
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 11:59:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ej6a9-0005Fj-4j
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 11:59:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ej6a8-0005FE-SQ
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 11:58:57 -0500
References: <1517880934-26141-1-git-send-email-changpeng.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b9486b71-d362-dc83-ff8c-67535b701769@redhat.com>
Date: Tue, 6 Feb 2018 17:58:03 +0100
MIME-Version: 1.0
In-Reply-To: <1517880934-26141-1-git-send-email-changpeng.liu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] virtio-blk: enable multiple vectors
 when using multiple I/O queues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changpeng Liu <changpeng.liu@intel.com>, qemu-devel@nongnu.org
Cc: stefanha@gmail.com, mst@redhat.com, marcandre.lureau@redhat.com, james.r.harris@intel.com

On 06/02/2018 02:35, Changpeng Liu wrote:
> Currently virtio-pci driver hardcoded 2 vectors for virtio-blk device,
> for multiple I/O queues scenario, all the I/O queues will share one
> interrupt vector, while here, enable multiple vectors according to
> the number of I/O queues.
>=20
> Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> ---
>  hw/virtio/virtio-pci.c | 14 ++++++++++++--
>  include/hw/compat.h    |  8 ++++++++
>  2 files changed, 20 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 9ae10f0..84a7674 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1932,7 +1932,8 @@ static Property virtio_blk_pci_properties[] =3D {
>      DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
>      DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
>                      VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
> -    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
> +    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
> +                       DEV_NVECTORS_UNSPECIFIED),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> @@ -1941,6 +1942,10 @@ static void virtio_blk_pci_realize(VirtIOPCIProx=
y *vpci_dev, Error **errp)
>      VirtIOBlkPCI *dev =3D VIRTIO_BLK_PCI(vpci_dev);
>      DeviceState *vdev =3D DEVICE(&dev->vdev);
> =20
> +    if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
> +        vpci_dev->nvectors =3D dev->vdev.conf.num_queues + 1;
> +    }
> +
>      qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
>      object_property_set_bool(OBJECT(vdev), true, "realized", errp);
>  }
> @@ -1983,7 +1988,8 @@ static const TypeInfo virtio_blk_pci_info =3D {
> =20
>  static Property vhost_user_blk_pci_properties[] =3D {
>      DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
> -    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
> +    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
> +                       DEV_NVECTORS_UNSPECIFIED),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> @@ -1992,6 +1998,10 @@ static void vhost_user_blk_pci_realize(VirtIOPCI=
Proxy *vpci_dev, Error **errp)
>      VHostUserBlkPCI *dev =3D VHOST_USER_BLK_PCI(vpci_dev);
>      DeviceState *vdev =3D DEVICE(&dev->vdev);
> =20
> +    if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
> +        vpci_dev->nvectors =3D dev->vdev.num_queues + 1;
> +    }
> +
>      qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
>      object_property_set_bool(OBJECT(vdev), true, "realized", errp);
>  }
> diff --git a/include/hw/compat.h b/include/hw/compat.h
> index 7f31850..bc9e3a6 100644
> --- a/include/hw/compat.h
> +++ b/include/hw/compat.h
> @@ -6,6 +6,14 @@
>          .driver   =3D "hpet",\
>          .property =3D "hpet-offset-saved",\
>          .value    =3D "false",\
> +    },{\
> +        .driver   =3D "virtio-blk-pci",\
> +        .property =3D "vectors",\
> +        .value    =3D "2",\
> +    },{\
> +        .driver   =3D "vhost-user-blk-pci",\
> +        .property =3D "vectors",\
> +        .value    =3D "2",\
>      },
> =20
>  #define HW_COMPAT_2_10 \
>=20

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
