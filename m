Received: from eggs.gnu.org ([2001:4830:134:3::10]:59053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5tNx-0002ls-Up
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:28:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5tNu-0000yy-11
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:28:01 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:35738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5tNt-0000yn-Td
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:27:57 -0400
Received: by mail-qk0-x243.google.com with SMTP id u68so2392749qkd.2
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 05:27:57 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170503121143.14925-1-marcandre.lureau@redhat.com>
	<20170503121143.14925-2-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d7e13506-2c19-fb5e-b3cc-43c4167bc249@amsat.org>
Date: Wed, 3 May 2017 09:27:54 -0300
MIME-Version: 1.0
In-Reply-To: <20170503121143.14925-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] libvhost-user: make vu_queue_empty()
 safer
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

On 05/03/2017 09:11 AM, Marc-André Lureau wrote:
> Check if vring.avail != null before accessing it.
>
> Fix crashes from callers such a vu_queue_pop() when queue isn't ready.
>
> Fix documentation and return type while at it.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  contrib/libvhost-user/libvhost-user.h | 6 +++---
>  contrib/libvhost-user/libvhost-user.c | 8 ++++++--
>  2 files changed, 9 insertions(+), 5 deletions(-)
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
> index f9680b6279..b0f15b76e3 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -1125,11 +1125,15 @@ vu_queue_avail_bytes(VuDev *dev, VuVirtq *vq, unsigned int in_bytes,
>
>  /* Fetch avail_idx from VQ memory only when we really need to know if
>   * guest has added some buffers. */
> -int
> +bool
>  vu_queue_empty(VuDev *dev, VuVirtq *vq)
>  {
> +    if (!vq->vring.avail) {
> +        return true;
> +    }
> +
>      if (vq->shadow_avail_idx != vq->last_avail_idx) {
> -        return 0;
> +        return false;
>      }
>
>      return vring_avail_idx(vq) == vq->last_avail_idx;
>
