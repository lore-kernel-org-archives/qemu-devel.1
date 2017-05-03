Received: from eggs.gnu.org ([2001:4830:134:3::10]:58840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5tN2-0001d4-Tq
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:27:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5tMz-0000lt-0E
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:27:04 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:34219)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5tMy-0000lm-QJ
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:27:00 -0400
Received: by mail-qt0-x242.google.com with SMTP id l39so437606qtb.1
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 05:27:00 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170503121143.14925-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f2d892bd-9a95-a470-0490-042c98d8b0d9@amsat.org>
Date: Wed, 3 May 2017 09:26:57 -0300
MIME-Version: 1.0
In-Reply-To: <20170503121143.14925-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] libvhost-user: fix
 vu_queue_get_avail_bytes() crash
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

Hi Marc-André,

On 05/03/2017 09:11 AM, Marc-André Lureau wrote:
> Calling vu_queue_get_avail_bytes() when the queue doesn't yet have
> addresses will result in the following crash:
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
> Check if vring.avail != null before accessing it.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  contrib/libvhost-user/libvhost-user.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
> index af4faad60b..f9680b6279 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -1031,6 +1031,10 @@ vu_queue_get_avail_bytes(VuDev *dev, VuVirtq *vq, unsigned int *in_bytes,
>      idx = vq->last_avail_idx;
>
>      total_bufs = in_total = out_total = 0;
> +    if (!vq->vring.avail) {
> +        goto done;
> +    }
> +
>      while ((rc = virtqueue_num_heads(dev, vq, idx)) > 0) {
>          unsigned int max, num_bufs, indirect = 0;
>          struct vring_desc *desc;
>

It seems to me safer to fix instead vring_avail_ring(), and fix 
neighbours vring_avail_flags() and vring_avail_idx() while here.
