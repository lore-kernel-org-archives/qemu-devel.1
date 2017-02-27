Received: from eggs.gnu.org ([2001:4830:134:3::10]:57424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1ciNOh-0002kD-3p
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:39:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1ciNOc-0005SV-7f
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:39:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1ciNOb-0005SK-UD
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:39:30 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1RFaSjH117330
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 10:39:27 -0500
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28vpwe83xc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 10:39:27 -0500
Received: from localhost
	by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 27 Feb 2017 15:39:24 -0000
Date: Mon, 27 Feb 2017 16:39:19 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170223085130.19954-1-pbonzini@redhat.com>
References: <20170223085130.19954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170227163919.7276be2b.cornelia.huck@de.ibm.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, lersek@redhat.com, kraxel@redhat.com, mst@redhat.com

On Thu, 23 Feb 2017 09:51:30 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

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

Tested-by: Cornelia Huck <cornelia.huck@de.ibm.com>

...although it is not sufficient...
