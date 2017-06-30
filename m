Received: from eggs.gnu.org ([2001:4830:134:3::10]:37758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dQyrX-0002kC-Ty
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 12:33:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dQyrT-0007Zj-0l
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 12:33:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dQyrS-0007Yw-Qo
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 12:33:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C0AE77F41A
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 16:33:37 +0000 (UTC)
Date: Fri, 30 Jun 2017 12:33:33 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <374372131.45583910.1498840413273.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170630160422.14842-2-maxime.coquelin@redhat.com>
References: <20170630160422.14842-1-maxime.coquelin@redhat.com>
	<20170630160422.14842-2-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] vhost: ensure vhost_ops are set before
 calling iotlb callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, mst@redhat.com



----- Original Message -----
> This patch fixes a crash that happens when vhost-user iommu
> support is enabled and vhost-user socket is closed.
>=20
> When it happens, if an IOTLB invalidation notification is sent
> by the IOMMU, vhost_ops's NULL pointer is dereferenced.
>=20
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

looks fine to me,

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/virtio/vhost-backend.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
> index 4e31de1..cb055e8 100644
> --- a/hw/virtio/vhost-backend.c
> +++ b/hw/virtio/vhost-backend.c
> @@ -309,7 +309,10 @@ int vhost_backend_update_device_iotlb(struct vhost_d=
ev
> *dev,
>          return -EINVAL;
>      }
> =20
> -    return dev->vhost_ops->vhost_send_device_iotlb_msg(dev, &imsg);
> +    if (dev->vhost_ops && dev->vhost_ops->vhost_send_device_iotlb_msg)
> +        return dev->vhost_ops->vhost_send_device_iotlb_msg(dev, &imsg);
> +
> +    return -ENODEV;
>  }
> =20
>  int vhost_backend_invalidate_device_iotlb(struct vhost_dev *dev,
> @@ -321,7 +324,10 @@ int vhost_backend_invalidate_device_iotlb(struct
> vhost_dev *dev,
>      imsg.size =3D len;
>      imsg.type =3D VHOST_IOTLB_INVALIDATE;
> =20
> -    return dev->vhost_ops->vhost_send_device_iotlb_msg(dev, &imsg);
> +    if (dev->vhost_ops && dev->vhost_ops->vhost_send_device_iotlb_msg)
> +        return dev->vhost_ops->vhost_send_device_iotlb_msg(dev, &imsg);
> +
> +    return -ENODEV;
>  }
> =20
>  int vhost_backend_handle_iotlb_msg(struct vhost_dev *dev,
> --
> 2.9.4
>=20
>=20
