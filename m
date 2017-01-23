Received: from eggs.gnu.org ([2001:4830:134:3::10]:55376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cVi3C-0005vI-Nh
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 12:05:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cVi3B-0001Jj-V8
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 12:05:02 -0500
Date: Mon, 23 Jan 2017 19:04:55 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170123190257-mutt-send-email-mst@kernel.org>
References: <1485132904-17632-1-git-send-email-zhaoshenglong@huawei.com>
	<20170123180247-mutt-send-email-mst@kernel.org>
	<49fcc1e0-f439-9212-25f1-9b8dce6462cc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49fcc1e0-f439-9212-25f1-9b8dce6462cc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V2] virtio: Fix no interrupt when not
 creating msi controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Shannon Zhao <zhaoshenglong@huawei.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, christoffer.dall@linaro.org

On Mon, Jan 23, 2017 at 05:46:47PM +0100, Paolo Bonzini wrote:
> 
> 
> On 23/01/2017 17:07, Michael S. Tsirkin wrote:
> > On Mon, Jan 23, 2017 at 08:55:04AM +0800, Shannon Zhao wrote:
> >> From: Shannon Zhao <shannon.zhao@linaro.org>
> >>
> >> For ARM virt machine, if we use virt-2.7 which will not create ITS node,
> >> the virtio-net can not recieve interrupts so it can't get ip address
> >> through dhcp.
> >> This fixes commit 83d768b(virtio: set ISR on dataplane notifications).
> >>
> >> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> > 
> > Paolo, could you comment on this pls?
> 
> For virtio-blk, my patch moved the setting of ISR from
> virtio_queue_guest_notifier_read to virtio_notify_irqfd.  This is
> because the irqfd emulation only needs to trigger the interrupt.
> Setting the ISR should have been done elsewhere.
> 
> Can vhost set ISR (I thought it couldn't)?  If so, it seems like ARM was
> relying on QEMU's irqfd emulation, as a work around for vhost not
> setting ISR.  But this only works if irqfd is directed to QEMU and not
> to KVM.  So if vhost cannot set ISR, I think vhost should be disabled
> unless MSI is active.
> 
> Am I missing something?
> 
> Paolo

vhost doesn't set ISR ATM.  Without MSI we are always bouncing
interrupts through QEMU in particular in order to set ISR.

Disabling vhost when user requested it was what we did
at some point but this just confused people.


> > 
> >> ---
> >> V2: Factor out a common function instead of duplicating code
> >> ---
> >>  hw/virtio/virtio.c | 11 ++++++++---
> >>  1 file changed, 8 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >> index aa4f38f..00e8f74 100644
> >> --- a/hw/virtio/virtio.c
> >> +++ b/hw/virtio/virtio.c
> >> @@ -1441,6 +1441,12 @@ void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq)
> >>      event_notifier_set(&vq->guest_notifier);
> >>  }
> >>  
> >> +static void virtio_irq(VirtQueue *vq)
> >> +{
> >> +    virtio_set_isr(vq->vdev, 0x1);
> >> +    virtio_notify_vector(vq->vdev, vq->vector);
> >> +}
> >> +
> >>  void virtio_notify(VirtIODevice *vdev, VirtQueue *vq)
> >>  {
> >>      if (!virtio_should_notify(vdev, vq)) {
> >> @@ -1448,8 +1454,7 @@ void virtio_notify(VirtIODevice *vdev, VirtQueue *vq)
> >>      }
> >>  
> >>      trace_virtio_notify(vdev, vq);
> >> -    virtio_set_isr(vq->vdev, 0x1);
> >> -    virtio_notify_vector(vdev, vq->vector);
> >> +    virtio_irq(vq);
> >>  }
> >>  
> >>  void virtio_notify_config(VirtIODevice *vdev)
> >> @@ -2082,7 +2087,7 @@ static void virtio_queue_guest_notifier_read(EventNotifier *n)
> >>  {
> >>      VirtQueue *vq = container_of(n, VirtQueue, guest_notifier);
> >>      if (event_notifier_test_and_clear(n)) {
> >> -        virtio_notify_vector(vq->vdev, vq->vector);
> >> +        virtio_irq(vq);
> >>      }
> >>  }
> >>  
> >> -- 
> >> 2.0.4
> >>
