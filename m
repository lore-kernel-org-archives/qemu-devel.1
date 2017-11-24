Received: from eggs.gnu.org ([2001:4830:134:3::10]:38636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eI9rd-0000E0-9i
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 04:01:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eI9rN-0008Gp-5H
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 04:01:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eI9rM-0008Ff-UZ
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 04:01:21 -0500
Date: Fri, 24 Nov 2017 10:01:14 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171124100114.1d295940.cohuck@redhat.com>
In-Reply-To: <20171124075542.16979-2-ppandit@redhat.com>
References: <20171124075542.16979-1-ppandit@redhat.com>
	<20171124075542.16979-2-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/2] virtio: check VirtQueue Vring
 object is set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, zhangboxian <zhangboxian@huawei.com>, Stefan Hajnoczi <stefanha@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>

On Fri, 24 Nov 2017 13:25:41 +0530
P J P <ppandit@redhat.com> wrote:

> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> An user could attempt to use an uninitialised VirtQueue object
> or unset Vring.align leading to a arithmetic exception. Add check
> to avoid it.
> 
> Reported-by: Zhangboxian <zhangboxian@huawei.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/virtio/virtio.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> Updated: add vring.num check to virtio_queue_update_rings
>   -> https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg04499.html  
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 5884ce3480..0940f1daf3 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -182,7 +182,7 @@ void virtio_queue_update_rings(VirtIODevice *vdev, int n)
>  {
>      VRing *vring = &vdev->vq[n].vring;
>  
> -    if (!vring->desc) {
> +    if (!vdev->vq[n].vring.num || !vring->desc || !vring->align) {
>          /* not yet setup -> nothing to do */

The check now implies "not yet setup or non-existing queue", no?

(Not that the check is wrong.)

>          return;
>      }
> @@ -1414,6 +1414,9 @@ void virtio_config_modern_writel(VirtIODevice *vdev,
>  
>  void virtio_queue_set_addr(VirtIODevice *vdev, int n, hwaddr addr)
>  {
> +    if (!vdev->vq[n].vring.num) {
> +        return;
> +    }
>      vdev->vq[n].vring.desc = addr;
>      virtio_queue_update_rings(vdev, n);
>  }
> @@ -1494,8 +1497,10 @@ void virtio_queue_set_align(VirtIODevice *vdev, int n, int align)
>       */
>      assert(k->has_variable_vring_alignment);
>  
> -    vdev->vq[n].vring.align = align;
> -    virtio_queue_update_rings(vdev, n);
> +    if (align) {
> +        vdev->vq[n].vring.align = align;
> +        virtio_queue_update_rings(vdev, n);
> +    }
>  }
>  
>  static bool virtio_queue_notify_aio_vq(VirtQueue *vq)

I think you also need to check for num in virtio_queue_set_rings().
