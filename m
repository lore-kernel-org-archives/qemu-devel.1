Received: from eggs.gnu.org ([2001:4830:134:3::10]:43255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fQPQw-0006iu-Rn
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 23:48:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fQPQw-0001y2-2T
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 23:48:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33722 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fQPQv-0001xo-Sy
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 23:48:25 -0400
References: <1528225683-11413-1-git-send-email-wexu@redhat.com>
	<1528225683-11413-9-git-send-email-wexu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6972a450-117a-2f3c-fb44-fb985c35b8e6@redhat.com>
Date: Wed, 6 Jun 2018 11:48:19 +0800
MIME-Version: 1.0
In-Reply-To: <1528225683-11413-9-git-send-email-wexu@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 8/8] virtio: guest driver reload for
 vhost-net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wexu@redhat.com, qemu-devel@nongnu.org
Cc: tiwei.bie@intel.com, mst@redhat.com, jfreimann@redhat.com



On 2018=E5=B9=B406=E6=9C=8806=E6=97=A5 03:08, wexu@redhat.com wrote:
> From: Wei Xu <wexu@redhat.com>
>
> last_avail, avail_wrap_count, used_idx and used_wrap_count are
> needed to support vhost-net backend, all these are either 16 or
> bool variables, since state.num is 64bit wide, so here it is
> possible to put them to the 'num' without introducing a new case
> while handling ioctl.
>
> Unload/Reload test has been done successfully with a patch in vhost ker=
nel.

You need a patch to enable vhost.

And I think you can only do it for vhost-kenrel now since vhost-user=20
protocol needs some extension I believe.

>
> Signed-off-by: Wei Xu <wexu@redhat.com>
> ---
>   hw/virtio/virtio.c | 42 ++++++++++++++++++++++++++++++++++--------
>   1 file changed, 34 insertions(+), 8 deletions(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 4543974..153f6d7 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2862,33 +2862,59 @@ hwaddr virtio_queue_get_used_size(VirtIODevice =
*vdev, int n)
>       }
>   }
>  =20
> -uint16_t virtio_queue_get_last_avail_idx(VirtIODevice *vdev, int n)
> +uint64_t virtio_queue_get_last_avail_idx(VirtIODevice *vdev, int n)
>   {
> -    return vdev->vq[n].last_avail_idx;
> +    uint64_t num;
> +
> +    num =3D vdev->vq[n].last_avail_idx;
> +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> +        num |=3D ((uint64_t)vdev->vq[n].avail_wrap_counter) << 16;
> +        num |=3D ((uint64_t)vdev->vq[n].used_idx) << 32;
> +        num |=3D ((uint64_t)vdev->vq[n].used_wrap_counter) << 48;

So s.num is 32bit, I don't think this can even work.

Thanks

> +    }
> +
> +    return num;
>   }
>  =20
> -void virtio_queue_set_last_avail_idx(VirtIODevice *vdev, int n, uint16=
_t idx)
> +void virtio_queue_set_last_avail_idx(VirtIODevice *vdev, int n, uint64=
_t num)
>   {
> -    vdev->vq[n].last_avail_idx =3D idx;
> -    vdev->vq[n].shadow_avail_idx =3D idx;
> +    vdev->vq[n].shadow_avail_idx =3D vdev->vq[n].last_avail_idx =3D (u=
int16_t)(num);
> +
> +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> +        vdev->vq[n].avail_wrap_counter =3D (uint16_t)(num >> 16);
> +        vdev->vq[n].used_idx =3D (uint16_t)(num >> 32);
> +        vdev->vq[n].used_wrap_counter =3D (uint16_t)(num >> 48);
> +    }
>   }
>  =20
>   void virtio_queue_restore_last_avail_idx(VirtIODevice *vdev, int n)
>   {
>       rcu_read_lock();
> -    if (vdev->vq[n].vring.desc) {
> +    if (!vdev->vq[n].vring.desc) {
> +        goto out;
> +    }
> +
> +    if (!virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
>           vdev->vq[n].last_avail_idx =3D vring_used_idx(&vdev->vq[n]);
> -        vdev->vq[n].shadow_avail_idx =3D vdev->vq[n].last_avail_idx;
>       }
> +    vdev->vq[n].shadow_avail_idx =3D vdev->vq[n].last_avail_idx;
> +
> +out:
>       rcu_read_unlock();
>   }
>  =20
>   void virtio_queue_update_used_idx(VirtIODevice *vdev, int n)
>   {
>       rcu_read_lock();
> -    if (vdev->vq[n].vring.desc) {
> +    if (!vdev->vq[n].vring.desc) {
> +        goto out;
> +    }
> +
> +    if (!virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
>           vdev->vq[n].used_idx =3D vring_used_idx(&vdev->vq[n]);
>       }
> +
> +out:
>       rcu_read_unlock();
>   }
>  =20
