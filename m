Received: from eggs.gnu.org ([2001:4830:134:3::10]:36722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVfcM-00022z-Qb
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:01:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVfcK-0006kB-9T
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:01:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dVfcK-0006hB-3u
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:01:24 -0400
Date: Thu, 13 Jul 2017 17:00:59 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170713170059.10278d9e@gondolin>
In-Reply-To: <20170713110237.6712-7-lprosek@redhat.com>
References: <20170713110237.6712-1-lprosek@redhat.com>
	<20170713110237.6712-7-lprosek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 6/8] virtio-net: use virtqueue_error for
 errors with queue context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel@nongnu.org, casasfernando@hotmail.com, mst@redhat.com, jasowang@redhat.com, armbru@redhat.com, groug@kaod.org, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com, stefanha@redhat.com

On Thu, 13 Jul 2017 13:02:35 +0200
Ladi Prosek <lprosek@redhat.com> wrote:

> virtqueue_error includes queue index in the error output and is preferred
> for errors that pertain to a virtqueue rather than to the device as a whole.
> 
> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> ---
>  hw/net/virtio-net.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 5630a9e..b3d0b85 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -970,7 +970,7 @@ static void virtio_net_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
>          }
>          if (iov_size(elem->in_sg, elem->in_num) < sizeof(status) ||
>              iov_size(elem->out_sg, elem->out_num) < sizeof(ctrl)) {
> -            virtio_error(vdev, "virtio-net ctrl missing headers");
> +            virtqueue_error(vq, "virtio-net ctrl missing headers");

This does not add much information, as there's just one control queue
anyway, but it doesn't hurt either.

>              virtqueue_detach_element(vq, elem, 0);
>              g_free(elem);
>              break;

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
