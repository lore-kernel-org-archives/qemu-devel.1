Received: from eggs.gnu.org ([2001:4830:134:3::10]:35091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fQOHg-0008Pw-Aj
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 22:34:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fQOHd-0000XF-5t
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 22:34:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39240 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fQOHd-0000WJ-0l
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 22:34:45 -0400
References: <1528225683-11413-1-git-send-email-wexu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <22f43a8e-7e98-e034-e9f7-1046f4b4b554@redhat.com>
Date: Wed, 6 Jun 2018 10:34:32 +0800
MIME-Version: 1.0
In-Reply-To: <1528225683-11413-1-git-send-email-wexu@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 0/8] packed ring virtio-net userspace
 backend support
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



On 2018=E5=B9=B406=E6=9C=8806=E6=97=A5 03:07, wexu@redhat.com wrote:
> From: Wei Xu <wexu@redhat.com>
>
> Todo:
> - address Rx slow performance
> - event index interrupt suppression test

Tiwei's code support event index, you can try with that.

Actually, unless you disable event_idx explicitly, it work by default.

>
> v1->v2
> - sync to tiwei's v5
> - reuse memory cache function with 1.0
> - dropped detach patch and notification helper(04 & 05 in v1)
> - guest virtio-net driver unload/reload support
> - event suppression support(not tested)
> - addressed feedback from v1
>
> About guest virtio-net load/unload:
> Since last_avail, avail_wrap_count, used_idx and used_wrap_count are
> all 16 or bool type variables, so I turned to merge them to
> 'vhost_vring_state.num' in stead of introducing a new case
> in handling ioctl, test has been done with a tweak in kernel side like:

s.num is unsigned int which is 32bit, but you want to hold 2 16bit vars=20
and a boolean.

So I'm afraid it won't work...

>
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1439,10 +1439,16 @@ long vhost_vring_ioctl(struct vhost_dev *d, int=
 ioctl, void __user *argp)
>              r =3D -EFAULT;
>              break;
>          }
> -               if (s.num > 0xffff) {
> -                       r =3D -EINVAL;
> -                       break;
> -               }
> +               if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED)) {
> +                       vq->avail_wrap_counter =3D (bool)(uint16_t)(s.n=
um >> 16);
> +                       vq->last_used_idx =3D (uint16_t)(s.num >> 32);
> +                       vq->used_wrap_counter =3D (bool)(uint16_t)(s.nu=
m >> 48);
> +                } else {
> +                    if (s.num > 0xffff) {
> +                            r =3D -EINVAL;
> +                            break;
> +                    }
> +                }
>          vq->last_avail_idx =3D s.num;
>          /* Forget the cached index value. */
>          vq->avail_idx =3D vq->last_avail_idx;
> @@ -1450,8 +1456,15 @@ long vhost_vring_ioctl(struct vhost_dev *d, int =
ioctl, void __user *argp)
>      case VHOST_GET_VRING_BASE:
>          s.index =3D idx;
>          s.num =3D vq->last_avail_idx;
> +               if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED)) {
> +                       s.num |=3D vq->avail_wrap_counter << 16;
> +                       s.num |=3D vq->last_used_idx << 32;
> +                       s.num |=3D vq->used_wrap_counter << 48;
> +                }
>          if (copy_to_user(argp, &s, sizeof s))
>              r =3D -EFAULT;
> +               if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
> +                       s.num |=3D vq->avail_wrap_counter << 31;
>          break;
>      case VHOST_SET_VRING_ADDR:
>          if (copy_from_user(&a, argp, sizeof a)) {
>
> Wei Xu (8):
>    virtio: feature bit, data structure, init for packed ring
>    virtio: memory cache for packed ring
>    virtio: empty check and desc read for packed ring
>    virtio: get avail bytes check for packed ring
>    virtio: queue pop support for packed ring
>    virtio: flush/push support for packed ring
>    virtio: event suppression support for packed ring
>    virtio: support guest driver reload for vhost-net
>
>   hw/net/vhost_net.c                             |   2 +
>   hw/virtio/virtio.c                             | 677 ++++++++++++++++=
+++++++--
>   include/hw/virtio/virtio.h                     |   4 +-
>   include/standard-headers/linux/virtio_config.h |  15 +
>   4 files changed, 649 insertions(+), 49 deletions(-)
>
