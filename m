Received: from eggs.gnu.org ([2001:4830:134:3::10]:55830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5zcn-0007CZ-20
	for qemu-devel@nongnu.org; Wed, 03 May 2017 15:07:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5zcj-0000X6-SC
	for qemu-devel@nongnu.org; Wed, 03 May 2017 15:07:45 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5zcj-0000Wl-Mx
	for qemu-devel@nongnu.org; Wed, 03 May 2017 15:07:41 -0400
Received: by mail-qt0-x243.google.com with SMTP id c45so26477640qtb.0
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 12:07:41 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170503165412.27766-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8ef2cce0-1578-678c-1782-417b511a1967@amsat.org>
Date: Wed, 3 May 2017 16:07:38 -0300
MIME-Version: 1.0
In-Reply-To: <20170503165412.27766-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, mst@redhat.com

On 05/03/2017 01:54 PM, Marc-André Lureau wrote:
> Calling libvhost-user functions like vu_queue_get_avail_bytes() when the
> queue doesn't yet have addresses will result in the crashes like the
> following:
>
> Program received signal SIGSEGV, Segmentation fault.
> 0x000055c414112ce4 in vring_avail_idx (vq=0x55c41582fd68, vq=0x55c41582fd68)
>     at /home/dgilbert/git/qemu/contrib/libvhost-user/libvhost-user.c:940
> 940            vq->shadow_avail_idx = vq->vring.avail->idx;
> (gdb) p vq
> $1 = (VuVirtq *) 0x55c41582fd68
> (gdb) p vq->vring
> $2 = {num = 0, desc = 0x0, avail = 0x0, used = 0x0, log_guest_addr = 0, flags = 0}
>
>     at /home/dgilbert/git/qemu/contrib/libvhost-user/libvhost-user.c:940
> No locals.
>     at /home/dgilbert/git/qemu/contrib/libvhost-user/libvhost-user.c:960
>         num_heads = <optimized out>
>     out_bytes=out_bytes@entry=0x7fffd035d7c4, max_in_bytes=max_in_bytes@entry=0,
>     max_out_bytes=max_out_bytes@entry=0) at /home/dgilbert/git/qemu/contrib/libvhost-user/libvhost-user.c:1034
>
> Add a pre-condition checks on vring.avail before accessing it.
>
> Fix documentation and return type of vu_queue_empty() while at it.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  contrib/libvhost-user/libvhost-user.h |  6 +++---
>  contrib/libvhost-user/libvhost-user.c | 26 ++++++++++++++++++++------
>  2 files changed, 23 insertions(+), 9 deletions(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
> index 156b50e989..af02a31ebe 100644
> --- a/contrib/libvhost-user/libvhost-user.h
> +++ b/contrib/libvhost-user/libvhost-user.h
> @@ -327,13 +327,13 @@ void vu_queue_set_notification(VuDev *dev, VuVirtq *vq, int enable);
>  bool vu_queue_enabled(VuDev *dev, VuVirtq *vq);
>
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
>
>  /**
>   * vu_queue_notify:
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
> index af4faad60b..e1bf9644b5 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -1031,6 +1031,11 @@ vu_queue_get_avail_bytes(VuDev *dev, VuVirtq *vq, unsigned int *in_bytes,
>      idx = vq->last_avail_idx;
>
>      total_bufs = in_total = out_total = 0;
> +    if (unlikely(dev->broken) ||
> +        unlikely(!vq->vring.avail)) {
> +        goto done;
> +    }
> +
>      while ((rc = virtqueue_num_heads(dev, vq, idx)) > 0) {
>          unsigned int max, num_bufs, indirect = 0;
>          struct vring_desc *desc;
> @@ -1121,11 +1126,16 @@ vu_queue_avail_bytes(VuDev *dev, VuVirtq *vq, unsigned int in_bytes,
>
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
>      if (vq->shadow_avail_idx != vq->last_avail_idx) {
> -        return 0;
> +        return false;
>      }
>
>      return vring_avail_idx(vq) == vq->last_avail_idx;
> @@ -1174,7 +1184,8 @@ vring_notify(VuDev *dev, VuVirtq *vq)
>  void
>  vu_queue_notify(VuDev *dev, VuVirtq *vq)
>  {
> -    if (unlikely(dev->broken)) {
> +    if (unlikely(dev->broken) ||
> +        unlikely(!vq->vring.avail)) {
>          return;
>      }
>
> @@ -1291,7 +1302,8 @@ vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz)
>      struct vring_desc *desc;
>      int rc;
>
> -    if (unlikely(dev->broken)) {
> +    if (unlikely(dev->broken) ||
> +        unlikely(!vq->vring.avail)) {
>          return NULL;
>      }
>
> @@ -1445,7 +1457,8 @@ vu_queue_fill(VuDev *dev, VuVirtq *vq,
>  {
>      struct vring_used_elem uelem;
>
> -    if (unlikely(dev->broken)) {
> +    if (unlikely(dev->broken) ||
> +        unlikely(!vq->vring.avail)) {
>          return;
>      }
>
> @@ -1474,7 +1487,8 @@ vu_queue_flush(VuDev *dev, VuVirtq *vq, unsigned int count)
>  {
>      uint16_t old, new;
>
> -    if (unlikely(dev->broken)) {
> +    if (unlikely(dev->broken) ||
> +        unlikely(!vq->vring.avail)) {
>          return;
>      }
>
>
