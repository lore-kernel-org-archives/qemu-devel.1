Received: from eggs.gnu.org ([209.51.188.92]:37107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1hJGmk-0002ls-W4
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 08:14:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1hJGY4-0004p1-Ni
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 07:58:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hJGY4-0004n8-Fj
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 07:58:48 -0400
References: <20190409055850.25797-1-jasowang@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c2bf2ef7-36ab-723f-b245-055d22f68978@redhat.com>
Date: Wed, 24 Apr 2019 19:58:42 +0800
MIME-Version: 1.0
In-Reply-To: <20190409055850.25797-1-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V3] vhost_net: don't set backend for the
 uninitialized virtqueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, qemu-devel@nongnu.org
Cc: yuri.benditovich@daynix.com


On 2019/4/9 =E4=B8=8B=E5=8D=881:58, Jason Wang wrote:
> We used to set backend unconditionally, this won't work for some
> guests (e.g windows driver) who may not initialize all virtqueues. For
> kernel backend, this will fail since it may try to validate the rings
> during setting backend.
>
> Fixing this by simply skipping the backend set when we find desc is
> not ready.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes from V1:
> - introduce a generic helper to check if a virtqueue is enabled
> ---


Michael, does this look good to you?

Thanks


>   hw/net/vhost_net.c         | 10 ++++++++++
>   hw/virtio/virtio.c         |  5 +++++
>   include/hw/virtio/virtio.h |  1 +
>   3 files changed, 16 insertions(+)
>
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index be3cc88370..a6b719035c 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -244,6 +244,11 @@ static int vhost_net_start_one(struct vhost_net *n=
et,
>           qemu_set_fd_handler(net->backend, NULL, NULL, NULL);
>           file.fd =3D net->backend;
>           for (file.index =3D 0; file.index < net->dev.nvqs; ++file.ind=
ex) {
> +            if (!virtio_queue_enabled(dev, net->dev.vq_index +
> +                                      file.index)) {
> +                /* Queue might not be ready for start */
> +                continue;
> +            }
>               r =3D vhost_net_set_backend(&net->dev, &file);
>               if (r < 0) {
>                   r =3D -errno;
> @@ -256,6 +261,11 @@ fail:
>       file.fd =3D -1;
>       if (net->nc->info->type =3D=3D NET_CLIENT_DRIVER_TAP) {
>           while (file.index-- > 0) {
> +            if (!virtio_queue_enabled(dev, net->dev.vq_index +
> +                                      file.index)) {
> +                /* Queue might not be ready for start */
> +                continue;
> +            }
>               int r =3D vhost_net_set_backend(&net->dev, &file);
>               assert(r >=3D 0);
>           }
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 2626a895cb..28056a7ef7 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2318,6 +2318,11 @@ hwaddr virtio_queue_get_desc_addr(VirtIODevice *=
vdev, int n)
>       return vdev->vq[n].vring.desc;
>   }
>  =20
> +bool virtio_queue_enabled(VirtIODevice *vdev, int n)
> +{
> +    return virtio_queue_get_desc_addr(vdev, n) !=3D 0;
> +}
> +
>   hwaddr virtio_queue_get_avail_addr(VirtIODevice *vdev, int n)
>   {
>       return vdev->vq[n].vring.avail;
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index ce9516236a..7140381e3a 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -282,6 +282,7 @@ typedef struct VirtIORNGConf VirtIORNGConf;
>                         VIRTIO_F_IOMMU_PLATFORM, false)
>  =20
>   hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
> +bool virtio_queue_enabled(VirtIODevice *vdev, int n);
>   hwaddr virtio_queue_get_avail_addr(VirtIODevice *vdev, int n);
>   hwaddr virtio_queue_get_used_addr(VirtIODevice *vdev, int n);
>   hwaddr virtio_queue_get_desc_size(VirtIODevice *vdev, int n);
