Received: from eggs.gnu.org ([2001:4830:134:3::10]:35570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cS4AC-0007WJ-2G
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 10:53:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cS4A8-0006ra-TO
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 10:53:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cS4A8-0006r9-NX
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 10:53:08 -0500
Date: Fri, 13 Jan 2017 17:53:05 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170113175234-mutt-send-email-mst@kernel.org>
References: <20170112114612.14520-1-stefanha@redhat.com>
	<20170112114612.14520-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170112114612.14520-3-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] virtio: disable notifications again
 after poll succeeded
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Doug Goldstein <cardoe@cardoe.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Jan 12, 2017 at 11:46:11AM +0000, Stefan Hajnoczi wrote:
> While AioContext is in polling mode virtqueue notifications are not
> necessary.  Some device virtqueue handlers enable notifications.  Make
> sure they stay disabled to avoid unnecessary vmexits.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

So I'll put just the revert in today's pull request,
let's make sure this one is not causing regressions.

> ---
>  hw/virtio/virtio.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index f04ab7a..34065c7 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2126,6 +2126,9 @@ static bool virtio_queue_host_notifier_aio_poll(void *opaque)
>      }
>  
>      virtio_queue_notify_aio_vq(vq);
> +
> +    /* In case the handler function re-enabled notifications */
> +    virtio_queue_set_notification(vq, 0);
>      return true;
>  }
>  
> -- 
> 2.9.3
