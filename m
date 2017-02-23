Received: from eggs.gnu.org ([2001:4830:134:3::10]:41605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cgqfB-0004bJ-42
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 05:30:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cgqf8-00085M-0x
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 05:30:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cgqf7-000856-Ri
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 05:30:13 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 74BC5C04BD41
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 10:30:12 +0000 (UTC)
References: <20170223085130.19954-1-pbonzini@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <b00e1a06-2de1-39fa-14d7-b9f600e749de@redhat.com>
Date: Thu, 23 Feb 2017 11:30:08 +0100
MIME-Version: 1.0
In-Reply-To: <20170223085130.19954-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] virtio: check for vring setup in
 virtio_queue_empty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, alex.williamson@redhat.com, mst@redhat.com

On 02/23/17 09:51, Paolo Bonzini wrote:
> If the vring has not been set up, there is nothing in the virtqueue.
> virtio_queue_host_notifier_aio_poll calls virtio_queue_empty even in
> this case; we have to filter it out just like virtio_queue_notify_aio_vq.
> 
> Reported-by: Gerd Hoffmann <kraxel@redhat.com>
> Tested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/virtio/virtio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 23483c7..e487e36 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2291,7 +2291,7 @@ static bool virtio_queue_host_notifier_aio_poll(void *opaque)
>      VirtQueue *vq = container_of(n, VirtQueue, host_notifier);
>      bool progress;
>  
> -    if (virtio_queue_empty(vq)) {
> +    if (!vq->vring.desc || virtio_queue_empty(vq)) {
>          return false;
>      }
>  
> 

Tested-by: Laszlo Ersek <lersek@redhat.com>

Thanks!
Laszlo
