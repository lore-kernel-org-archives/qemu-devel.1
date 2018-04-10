Received: from eggs.gnu.org ([2001:4830:134:3::10]:51090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f5nmO-0001Xq-73
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 03:33:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f5nmI-000525-Bc
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 03:33:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53532 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1f5nmI-00051n-6U
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 03:33:18 -0400
References: <1522846444-31725-1-git-send-email-wexu@redhat.com>
	<1522846444-31725-5-git-send-email-wexu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <61ac2a50-5583-2932-cac1-f661fd49e89b@redhat.com>
Date: Tue, 10 Apr 2018 15:32:53 +0800
MIME-Version: 1.0
In-Reply-To: <1522846444-31725-5-git-send-email-wexu@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/8] virtio: add detach element for packed
 ring(1.1)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wexu@redhat.com, mst@redhat.com, tiwei.bie@intel.com, jfreimann@redhat.com, qemu-devel@nongnu.org



On 2018=E5=B9=B404=E6=9C=8804=E6=97=A5 20:54, wexu@redhat.com wrote:
> From: Wei Xu <wexu@redhat.com>
>
> helper for packed ring

It's odd and hard to review if you put detach patch first. I think this=20
patch needs to be reordered after the implementation of pop/map.

Thanks

> Signed-off-by: Wei Xu <wexu@redhat.com>
> ---
>   hw/virtio/virtio.c | 21 +++++++++++++++++++--
>   1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 478df3d..fdee40f 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -561,6 +561,20 @@ static void virtqueue_unmap_sg(VirtQueue *vq, cons=
t VirtQueueElement *elem,
>                            elem->out_sg[i].iov_len);
>   }
>  =20
> +static void virtqueue_detach_element_split(VirtQueue *vq,
> +                            const VirtQueueElement *elem, unsigned int=
 len)
> +{
> +    vq->inuse--;
> +    virtqueue_unmap_sg(vq, elem, len);
> +}
> +
> +static void virtqueue_detach_element_packed(VirtQueue *vq,
> +                            const VirtQueueElement *elem, unsigned int=
 len)
> +{
> +    vq->inuse -=3D elem->count;
> +    virtqueue_unmap_sg(vq, elem, len);
> +}
> +
>   /* virtqueue_detach_element:
>    * @vq: The #VirtQueue
>    * @elem: The #VirtQueueElement
> @@ -573,8 +587,11 @@ static void virtqueue_unmap_sg(VirtQueue *vq, cons=
t VirtQueueElement *elem,
>   void virtqueue_detach_element(VirtQueue *vq, const VirtQueueElement *=
elem,
>                                 unsigned int len)
>   {
> -    vq->inuse--;
> -    virtqueue_unmap_sg(vq, elem, len);
> +    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
> +        virtqueue_detach_element_packed(vq, elem, len);
> +    } else {
> +        virtqueue_detach_element_split(vq, elem, len);
> +    }
>   }
>  =20
>   /* virtqueue_unpop:
