Received: from eggs.gnu.org ([2001:4830:134:3::10]:38073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eK0Lm-0001xK-9k
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 06:16:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eK0Lh-00061J-9Q
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 06:16:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eK0Lg-00060O-Vd
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 06:16:17 -0500
Date: Wed, 29 Nov 2017 12:16:09 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171129121609.61a03d36.cohuck@redhat.com>
In-Reply-To: <nycvar.YSQ.7.76.1711291445390.12405@wniryva>
References: <20171124183446.7308-1-ppandit@redhat.com>
	<20171124183446.7308-2-ppandit@redhat.com>
	<20171127111532.GI16527@stefanha-x1.localdomain>
	<nycvar.YSQ.7.76.1711272251290.24944@wniryva>
	<20171128101154.64b49cb0.cohuck@redhat.com>
	<20171128103757.GD17146@stefanha-x1.localdomain>
	<nycvar.YSQ.7.76.1711281653440.1581@wniryva>
	<20171128130012.1466d231.cohuck@redhat.com>
	<nycvar.YSQ.7.76.1711291445390.12405@wniryva>
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

On Wed, 29 Nov 2017 15:41:45 +0530 (IST)
P J P <ppandit@redhat.com> wrote:

>   Hello Cornelia,
> 
> +-- On Tue, 28 Nov 2017, Cornelia Huck wrote --+
> | What is "unfit for use"?
> 
> Unfit for use because we see checks like
> 
>   if (!virtio_queue_get_num(vdev, n)) {
>             continue;
>   ...
>   if (!vdev->vq[n].vring.num) {
>       return;
> 
> 'virtio_queue_set_rings' sets 'vring.desc' as
> 
>   vdev->vq[n].vring.desc = desc;
> 
> and calls virtio_init_region_cache(vdev, n);
> which returns if vq->vring.desc is zero(0).
> 
>   addr = vq->vring.desc;
>   if (!addr) {
>       return;
>   }
> 
> Same in virtio_queue_set_addr() -> virtio_queue_update_rings().
> 
> It seems that for 'vq' instance to be useful, vring.num, vring.desc etc. 
> fields need to be set properly. Unless an unused/free 'vq' is being accessed 
> to set these fields.

I think the basic problem is still that you conflate two things:
- vring.num, which cannot be flipped between 0 and !0 by the guest
- vring.{desc,avail,used}, which can

IOW, if vring.num == 0, the guest cannot manipulate the queue; if
vring.desc == 0, the guest can. 

> 
> | I'm not quite sure what you want to achieve with this patch. I assume
> | you want to fix the issue that a guest may provide invalid values for
> | align etc. which can cause qemu to crash or behave badly.
> 
> True. In the process I'm trying to figure out if a usable 'vq' instance could 
> be decided in once place, than having repeating checks, if possible.
> 
> Ex. 'virtio_queue_update_rings' is called as
> 
> virtio_queue_set_addr
>  -> virtio_queue_update_rings  
> 
> virtio_queue_set_align
>  -> virtio_queue_update_rings  
> 
> virtio_load
>  for (i = 0; i < num; i++) {
>    if (vdev->vq[i].vring.desc) {
>    ...
>      virtio_queue_update_rings
> 
> Of these, virtio_load checks that 'vring.desc' is non-zero(0). Current 
> patch adds couple checks to the other two callers above. And again,
> 
> virtio_queue_update_rings would check
> 
>     if (!vring->num || !vring->desc || !vring->align) {
>        /* not yet setup -> nothing to do */
>        return;
>     }

vring.num and vring.desc are really different things. You don't want
the guest to do anything with the queue if vring.num == 0, while you
just want to skip various processing if vring.desc == 0.

(virtio_load() does not need to care about vring.num, as it is not
triggered by the guest.)

> 
> | If so, you need to do different things for the different points above.
> | - The guest should not muck around with a non-existing queue (num == 0)
> |   in any case, so this should be fenced for any manipulation triggered
> |   by the guest.
> 
> I guess done by !virtio_queue_get_num() check above?

Yes.

> 
> | - Processing a non-setup queue (desc == 0; also applies to the other
> |   buffers for virtio-1) should be skipped. However, _setting_ desc etc.
> |   to 0 from the guest is fine (as long as it follows the other
> |   constraints of the spec).
> 
> Okay. Though its non-zero(0) value is preferred?

Many functions have a likely/unlikely check, setup routines excepted.

> 
> | - Setting alignment to 0 only applies to legacy + virtio-mmio. I would
> |   not overengineer fencing this. A simple check in update_rings should
> |   be enough.
> 
> Okay.x
