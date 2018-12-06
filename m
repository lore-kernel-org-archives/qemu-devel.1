Received: from eggs.gnu.org ([2001:4830:134:3::10]:48794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gUntv-0006Ux-16
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 02:16:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gUntu-0003RE-2q
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 02:16:46 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gUntt-0003Ph-S8
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 02:16:46 -0500
Received: by mail-wm1-x343.google.com with SMTP id c126so15261970wmh.0
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 23:16:45 -0800 (PST)
MIME-Version: 1.0
References: <20181206063552.6701-1-xieyongji@baidu.com>
	<20181206063552.6701-4-xieyongji@baidu.com>
In-Reply-To: <20181206063552.6701-4-xieyongji@baidu.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 6 Dec 2018 11:16:32 +0400
Message-ID: <CAJ+F1C+B7-d2e=LYF0mtOrjxHJri4Mkh4OY9qWQj398fGu5NFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 3/6] libvhost-user: Introduce
 vu_queue_map_desc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongji Xie <elohimes@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, nixun@baidu.com, QEMU <qemu-devel@nongnu.org>, lilin24@baidu.com, zhangyu31@baidu.com, chaiwen@baidu.com, xieyongji@baidu.com

On Thu, Dec 6, 2018 at 10:40 AM <elohimes@gmail.com> wrote:
>
> From: Xie Yongji <xieyongji@baidu.com>
>
> Introduce vu_queue_map_desc() which should be
> independent with vu_queue_pop();
>
> Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> Signed-off-by: Zhang Yu <zhangyu31@baidu.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  contrib/libvhost-user/libvhost-user.c | 86 +++++++++++++++------------
>  1 file changed, 49 insertions(+), 37 deletions(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
> index a6b46cdc03..4432bd8bb4 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -1853,49 +1853,20 @@ virtqueue_alloc_element(size_t sz,
>      return elem;
>  }
>
> -void *
> -vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz)
> +static void *
> +vu_queue_map_desc(VuDev *dev, VuVirtq *vq, unsigned int idx, size_t sz)
>  {
> -    unsigned int i, head, max, desc_len;
> +    struct vring_desc *desc =3D vq->vring.desc;
>      uint64_t desc_addr, read_len;
> +    unsigned int desc_len;
> +    unsigned int max =3D vq->vring.num;
> +    unsigned int i =3D idx;
>      VuVirtqElement *elem;
> -    unsigned out_num, in_num;
> +    unsigned int out_num =3D 0, in_num =3D 0;
>      struct iovec iov[VIRTQUEUE_MAX_SIZE];
>      struct vring_desc desc_buf[VIRTQUEUE_MAX_SIZE];
> -    struct vring_desc *desc;
>      int rc;
>
> -    if (unlikely(dev->broken) ||
> -        unlikely(!vq->vring.avail)) {
> -        return NULL;
> -    }
> -
> -    if (vu_queue_empty(dev, vq)) {
> -        return NULL;
> -    }
> -    /* Needed after virtio_queue_empty(), see comment in
> -     * virtqueue_num_heads(). */
> -    smp_rmb();
> -
> -    /* When we start there are none of either input nor output. */
> -    out_num =3D in_num =3D 0;
> -
> -    max =3D vq->vring.num;
> -    if (vq->inuse >=3D vq->vring.num) {
> -        vu_panic(dev, "Virtqueue size exceeded");
> -        return NULL;
> -    }
> -
> -    if (!virtqueue_get_head(dev, vq, vq->last_avail_idx++, &head)) {
> -        return NULL;
> -    }
> -
> -    if (vu_has_feature(dev, VIRTIO_RING_F_EVENT_IDX)) {
> -        vring_set_avail_event(vq, vq->last_avail_idx);
> -    }
> -
> -    i =3D head;
> -    desc =3D vq->vring.desc;
>      if (desc[i].flags & VRING_DESC_F_INDIRECT) {
>          if (desc[i].len % sizeof(struct vring_desc)) {
>              vu_panic(dev, "Invalid size for indirect buffer table");
> @@ -1947,12 +1918,13 @@ vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz)
>      } while (rc =3D=3D VIRTQUEUE_READ_DESC_MORE);
>
>      if (rc =3D=3D VIRTQUEUE_READ_DESC_ERROR) {
> +        vu_panic(dev, "read descriptor error");
>          return NULL;
>      }
>
>      /* Now copy what we have collected and mapped */
>      elem =3D virtqueue_alloc_element(sz, out_num, in_num);
> -    elem->index =3D head;
> +    elem->index =3D idx;
>      for (i =3D 0; i < out_num; i++) {
>          elem->out_sg[i] =3D iov[i];
>      }
> @@ -1960,6 +1932,46 @@ vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz)
>          elem->in_sg[i] =3D iov[out_num + i];
>      }
>
> +    return elem;
> +}
> +
> +void *
> +vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz)
> +{
> +    unsigned int head;
> +    VuVirtqElement *elem;
> +
> +    if (unlikely(dev->broken) ||
> +        unlikely(!vq->vring.avail)) {
> +        return NULL;
> +    }
> +
> +    if (vu_queue_empty(dev, vq)) {
> +        return NULL;
> +    }
> +    /* Needed after virtio_queue_empty(), see comment in
> +     * virtqueue_num_heads(). */
> +    smp_rmb();
> +
> +    if (vq->inuse >=3D vq->vring.num) {
> +        vu_panic(dev, "Virtqueue size exceeded");
> +        return NULL;
> +    }
> +
> +    if (!virtqueue_get_head(dev, vq, vq->last_avail_idx++, &head)) {
> +        return NULL;
> +    }
> +
> +    if (vu_has_feature(dev, VIRTIO_RING_F_EVENT_IDX)) {
> +        vring_set_avail_event(vq, vq->last_avail_idx);
> +    }
> +
> +    elem =3D vu_queue_map_desc(dev, vq, head, sz);
> +
> +    if (!elem) {
> +        return NULL;
> +    }
> +
>      vq->inuse++;
>
>      return elem;
> --
> 2.17.1
>
>


--=20
Marc-Andr=C3=A9 Lureau
