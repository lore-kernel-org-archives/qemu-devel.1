Received: from eggs.gnu.org ([2001:4830:134:3::10]:49587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eJbvz-0006G5-It
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 04:12:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eJbvt-0005DS-W4
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 04:12:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eJbvt-0005DC-Pn
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 04:12:01 -0500
Date: Tue, 28 Nov 2017 10:11:54 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171128101154.64b49cb0.cohuck@redhat.com>
In-Reply-To: <nycvar.YSQ.7.76.1711272251290.24944@wniryva>
References: <20171124183446.7308-1-ppandit@redhat.com>
	<20171124183446.7308-2-ppandit@redhat.com>
	<20171127111532.GI16527@stefanha-x1.localdomain>
	<nycvar.YSQ.7.76.1711272251290.24944@wniryva>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/2] virtio: check VirtQueue Vring
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, zhangboxian <zhangboxian@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 27 Nov 2017 23:25:28 +0530 (IST)
P J P <ppandit@redhat.com> wrote:

> +-- On Mon, 27 Nov 2017, Cornelia Huck wrote --+
> |The check for align is not really needed, as virtio-1 disallows setting align 
> |anyway.
> 
>  disallows...?

See the check in virtio_queue_set_align(). Moreover, the calculation
that breaks virtqueue setup for align == 0 is only called for the
legacy setup, IOW not for this virtio-1 only function.

> 
> | Checking for !desc is wrong (why shouldn't a driver be able to unset a
> | descriptor table?)
> 
> +-- On Mon, 27 Nov 2017, Stefan Hajnoczi wrote --+
> | > +    if (!vdev->vq[n].vring.num || !desc || !vdev->vq[n].vring.align) {
> | ...
> |   vdev->vq[n].vring.desc = desc;
> |
> | Why !desc?
> 
> virtio_queue_set_rings
>  virtio_init_region_cache
>    VirtQueue *vq = &vdev->vq[n];
>    ...
>    addr = vq->vring.desc;
>    if (!addr) {
>        return;
>    }
> 
> These checks seem to be repeating all over. As mentioned earlier, could these 
> be collated in one place, maybe virtio_queue_get_num()?
> 
>   int virtio_queue_get_num(VirtIODevice *vdev, int n)
>   {
>       VirtQueue *vq = &vdev->vq[n];
> 
>       if (!vq->.vring.num
>            || !vq->vring.desc
>            || !vq->vring.align) {
>           return 0;  /* vq not set */
>       }
> 
>       return vdev->vq[n].vring.num;
>   }

This is conflating different things:
- vq does not exist (num == 0)
- vq is not setup by the guest (desc == 0)
- vq has no valid alignment (which is only relevant for legacy)
