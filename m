Received: from eggs.gnu.org ([2001:4830:134:3::10]:34416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d5yLJ-0004sn-11
	for qemu-devel@nongnu.org; Wed, 03 May 2017 13:45:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d5yLF-0004cG-OS
	for qemu-devel@nongnu.org; Wed, 03 May 2017 13:45:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d5yLF-0004bO-En
	for qemu-devel@nongnu.org; Wed, 03 May 2017 13:45:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2E3B970721
	for <qemu-devel@nongnu.org>; Wed,  3 May 2017 17:45:32 +0000 (UTC)
Date: Wed, 3 May 2017 18:45:25 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170503174524.GI2657@work-vm>
References: <20170503165412.27766-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170503165412.27766-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] libvhost-user: fix crash when rings
 aren't ready
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com

* Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> Calling libvhost-user functions like vu_queue_get_avail_bytes() when th=
e
> queue doesn't yet have addresses will result in the crashes like the
> following:
>=20
> Program received signal SIGSEGV, Segmentation fault.
> 0x000055c414112ce4 in vring_avail_idx (vq=3D0x55c41582fd68, vq=3D0x55c4=
1582fd68)
>     at /home/dgilbert/git/qemu/contrib/libvhost-user/libvhost-user.c:94=
0
> 940            vq->shadow_avail_idx =3D vq->vring.avail->idx;
> (gdb) p vq
> $1 =3D (VuVirtq *) 0x55c41582fd68
> (gdb) p vq->vring
> $2 =3D {num =3D 0, desc =3D 0x0, avail =3D 0x0, used =3D 0x0, log_guest=
_addr =3D 0, flags =3D 0}
>=20
>     at /home/dgilbert/git/qemu/contrib/libvhost-user/libvhost-user.c:94=
0
> No locals.
>     at /home/dgilbert/git/qemu/contrib/libvhost-user/libvhost-user.c:96=
0
>         num_heads =3D <optimized out>
>     out_bytes=3Dout_bytes@entry=3D0x7fffd035d7c4, max_in_bytes=3Dmax_in=
_bytes@entry=3D0,
>     max_out_bytes=3Dmax_out_bytes@entry=3D0) at /home/dgilbert/git/qemu=
/contrib/libvhost-user/libvhost-user.c:1034
>=20
> Add a pre-condition checks on vring.avail before accessing it.
>=20
> Fix documentation and return type of vu_queue_empty() while at it.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Yep, that's much happier.
I've succesfully done a migrate while running some guest networking so:

Tested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks,

Dave

> ---
>  contrib/libvhost-user/libvhost-user.h |  6 +++---
>  contrib/libvhost-user/libvhost-user.c | 26 ++++++++++++++++++++------
>  2 files changed, 23 insertions(+), 9 deletions(-)
>=20
> diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-u=
ser/libvhost-user.h
> index 156b50e989..af02a31ebe 100644
> --- a/contrib/libvhost-user/libvhost-user.h
> +++ b/contrib/libvhost-user/libvhost-user.h
> @@ -327,13 +327,13 @@ void vu_queue_set_notification(VuDev *dev, VuVirt=
q *vq, int enable);
>  bool vu_queue_enabled(VuDev *dev, VuVirtq *vq);
> =20
>  /**
> - * vu_queue_enabled:
> + * vu_queue_empty:
>   * @dev: a VuDev context
>   * @vq: a VuVirtq queue
>   *
> - * Returns: whether the queue is empty.
> + * Returns: true if the queue is empty or not ready.
>   */
> -int vu_queue_empty(VuDev *dev, VuVirtq *vq);
> +bool vu_queue_empty(VuDev *dev, VuVirtq *vq);
> =20
>  /**
>   * vu_queue_notify:
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-u=
ser/libvhost-user.c
> index af4faad60b..e1bf9644b5 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -1031,6 +1031,11 @@ vu_queue_get_avail_bytes(VuDev *dev, VuVirtq *vq=
, unsigned int *in_bytes,
>      idx =3D vq->last_avail_idx;
> =20
>      total_bufs =3D in_total =3D out_total =3D 0;
> +    if (unlikely(dev->broken) ||
> +        unlikely(!vq->vring.avail)) {
> +        goto done;
> +    }
> +
>      while ((rc =3D virtqueue_num_heads(dev, vq, idx)) > 0) {
>          unsigned int max, num_bufs, indirect =3D 0;
>          struct vring_desc *desc;
> @@ -1121,11 +1126,16 @@ vu_queue_avail_bytes(VuDev *dev, VuVirtq *vq, u=
nsigned int in_bytes,
> =20
>  /* Fetch avail_idx from VQ memory only when we really need to know if
>   * guest has added some buffers. */
> -int
> +bool
>  vu_queue_empty(VuDev *dev, VuVirtq *vq)
>  {
> +    if (unlikely(dev->broken) ||
> +        unlikely(!vq->vring.avail)) {
> +        return true;
> +    }
> +
>      if (vq->shadow_avail_idx !=3D vq->last_avail_idx) {
> -        return 0;
> +        return false;
>      }
> =20
>      return vring_avail_idx(vq) =3D=3D vq->last_avail_idx;
> @@ -1174,7 +1184,8 @@ vring_notify(VuDev *dev, VuVirtq *vq)
>  void
>  vu_queue_notify(VuDev *dev, VuVirtq *vq)
>  {
> -    if (unlikely(dev->broken)) {
> +    if (unlikely(dev->broken) ||
> +        unlikely(!vq->vring.avail)) {
>          return;
>      }
> =20
> @@ -1291,7 +1302,8 @@ vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz)
>      struct vring_desc *desc;
>      int rc;
> =20
> -    if (unlikely(dev->broken)) {
> +    if (unlikely(dev->broken) ||
> +        unlikely(!vq->vring.avail)) {
>          return NULL;
>      }
> =20
> @@ -1445,7 +1457,8 @@ vu_queue_fill(VuDev *dev, VuVirtq *vq,
>  {
>      struct vring_used_elem uelem;
> =20
> -    if (unlikely(dev->broken)) {
> +    if (unlikely(dev->broken) ||
> +        unlikely(!vq->vring.avail)) {
>          return;
>      }
> =20
> @@ -1474,7 +1487,8 @@ vu_queue_flush(VuDev *dev, VuVirtq *vq, unsigned =
int count)
>  {
>      uint16_t old, new;
> =20
> -    if (unlikely(dev->broken)) {
> +    if (unlikely(dev->broken) ||
> +        unlikely(!vq->vring.avail)) {
>          return;
>      }
> =20
> --=20
> 2.12.0.191.gc5d8de91d
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
