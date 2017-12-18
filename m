Received: from eggs.gnu.org ([2001:4830:134:3::10]:34239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1eQv5U-0004sE-NK
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:04:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1eQv5Q-0001R5-Ld
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:04:08 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <i.maximets@samsung.com>)
	id 1eQv5Q-0001OB-8A
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:04:04 -0500
From: Ilya Maximets <i.maximets@samsung.com>
Message-id: <f4c6539b-1266-1602-577d-d4a29efd03d2@samsung.com>
Date: Mon, 18 Dec 2017 16:03:56 +0300
MIME-version: 1.0
In-reply-to: <1513195345-9506-1-git-send-email-mst@redhat.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
References: <CGME20171213200345epcas2p16eb8617995e8517ee3ae83e5d72af961@epcas2p1.samsung.com>
	<1513195345-9506-1-git-send-email-mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtio_error: don't invoke status callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>

On 13.12.2017 23:03, Michael S. Tsirkin wrote:
> Backends don't need to know what frontend requested a reset,
> and notifying then from virtio_error is messy because
> virtio_error itself might be invoked from backend.
> 
> Let's just set the status directly.
> 
> Reported-by: Ilya Maximets <i.maximets@samsung.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> Ilya this should fix the crash you are seeing
I tested it and it really fixes the QEMU crash.
Thanks. 

> but
> the error itself still shows there's something wrong.
> So I'd like to defer applying that patch until we
> figure out what corrupted guest index.
> 
> If you know pls let me know!

It looks like virtio driver crash caused by the same issue that was fixed in recent
patches from Maxime Coquelin:

  2ae39a113af3 ("vhost: restore avail index from vring used index on disconnection")
  2d4ba6cc741d ("virtio: Add queue interface to restore avail index from vring used index")

Applying above patches on top of 2.10.1 fixes virtio driver's crash.

> 
>  hw/virtio/virtio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index ad564b0..d6002ee 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2469,7 +2469,7 @@ void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt, ...)
>      va_end(ap);
>  
>      if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> -        virtio_set_status(vdev, vdev->status | VIRTIO_CONFIG_S_NEEDS_RESET);
> +        vdev->status = vdev->status | VIRTIO_CONFIG_S_NEEDS_RESET;
>          virtio_notify_config(vdev);
>      }
>  
> 
