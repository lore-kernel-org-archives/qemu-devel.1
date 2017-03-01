Received: from eggs.gnu.org ([2001:4830:134:3::10]:36083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cj3mR-0007iO-46
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:54:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cj3mO-0001nR-2h
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:54:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:17201)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cj3mN-0001nL-TC
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 07:54:52 -0500
Date: Wed, 1 Mar 2017 14:54:49 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170301145306-mutt-send-email-mst@kernel.org>
References: <20170301115004.96073-1-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170301115004.96073-1-pasic@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] virtio: fallback from irqfd to
 non-irqfd notify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

On Wed, Mar 01, 2017 at 12:50:04PM +0100, Halil Pasic wrote:
> The commits 03de2f527 "virtio-blk: do not use vring in dataplane"  and
> 9ffe337c08 "virtio-blk: always use dataplane path if ioeventfd is active"
> changed how notifications are done for virtio-blk substantially. Due to a
> race condition interrupts are lost when irqfd is torn down after
> notify_guest_bh was scheduled but before it actually runs.  Furthermore
> virtio_notify_irqfd ignores the value returned by event_notifier_set
> which correctly indicates that notification has failed due to bad file
> descriptor.
> 
> Let's fix this by making virtio_notify_irqfd fall back to the non-irqfd
> notification mechanism if event_notifier_set fails.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
> 
> This is probably not the only way to fix this: suggestions welcome. I
> did not use a fixes tag because I'm not sure yet where exactly things got
> broken. Maybe guys more familiar with dataplane an coroutines can help
> (Paolo, Stefan).
> ---
>  hw/virtio/virtio.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 23483c7..8e1c1e9 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1581,7 +1581,9 @@ void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq)
>       * to an atomic operation.
>       */
>      virtio_set_isr(vq->vdev, 0x1);
> -    event_notifier_set(&vq->guest_notifier);
> +    if (event_notifier_set(&vq->guest_notifier)) {
> +        virtio_notify_vector(vdev, vq->vector);
> +    }

Does this fail because the underlying fd got closed?
Then there's a problem: trying to write to a closed
fd might corrupt an unrelated fd.
If you want to use this way we need to set fds to -1 when we close.

>  }
>  
>  static void virtio_irq(VirtQueue *vq)
> -- 
> 2.8.4
