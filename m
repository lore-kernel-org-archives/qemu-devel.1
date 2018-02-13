Received: from eggs.gnu.org ([2001:4830:134:3::10]:59936)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1elhaZ-0006Lm-Ti
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 15:54:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1elhaW-0002n8-Sx
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 15:54:07 -0500
Received: from mx01.kamp.de ([82.141.2.16]:38929)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1elhaW-0002kd-I2
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 15:54:04 -0500
Received: from submission.kamp.de ([195.62.97.28]) by kerio.kamp.de with ESMTPS
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 21:53:57 +0100
References: <1513866427-27125-1-git-send-email-mst@redhat.com>
	<1513866427-27125-11-git-send-email-mst@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <800aef3f-56c1-b896-1c93-24e2a523833d@kamp.de>
Date: Tue, 13 Feb 2018 21:53:58 +0100
MIME-Version: 1.0
In-Reply-To: <1513866427-27125-11-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [Qemu-stable] [PULL 10/25] virtio_error: don't
 invoke status callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Ilya Maximets <i.maximets@samsung.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org


Am 21.12.2017 um 15:29 schrieb Michael S. Tsirkin:
> Backends don't need to know what frontend requested a reset,
> and notifying then from virtio_error is messy because
> virtio_error itself might be invoked from backend.
>
> Let's just set the status directly.
>
> Cc: qemu-stable@nongnu.org
> Reported-by: Ilya Maximets <i.maximets@samsung.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
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


Is it possible that this patch introduces a stall in I/O and a deadlock on a drain all?

I have seen Qemu VMs being I/O stalled and deadlocking on a vm stop command in

blk_drain_all. This happened after a longer storage outage.


I am asking just theoretically because I have seen this behaviour first when we

backported this patch in our stable 2.9 branch.


Thank you,

Peter
