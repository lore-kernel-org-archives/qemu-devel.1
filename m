Received: from eggs.gnu.org ([2001:4830:134:3::10]:57848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ciNQM-0004Ek-3n
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:41:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ciNQH-0005s4-8G
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:41:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ciNQH-0005ry-23
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:41:13 -0500
References: <baa954b4-53fc-2b4e-b79c-917ba9171a60@de.ibm.com>
	<20170227160609.0d49a87d.cornelia.huck@de.ibm.com>
	<20170227163708.796ab27f.cornelia.huck@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a5ada7c2-4166-1cdf-a4e0-7c49a68374f9@redhat.com>
Date: Mon, 27 Feb 2017 16:41:09 +0100
MIME-Version: 1.0
In-Reply-To: <20170227163708.796ab27f.cornelia.huck@de.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] segfault use VRingMemoryRegionCaches for avail and
 used ring vs num-queues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>



On 27/02/2017 16:37, Cornelia Huck wrote:
> With the following applied (probably whitespace damaged), my guest
> starts:
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index e487e36..28906e5 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -287,6 +287,9 @@ static inline void vring_set_avail_event(VirtQueue *vq, uint16_t val)
>  void virtio_queue_set_notification(VirtQueue *vq, int enable)
>  {
>      vq->notification = enable;
> +    if (!vq->vring.desc) {
> +        return;
> +    }
>  
>      rcu_read_lock();
>      if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
> 
> Maybe introduction of caches just exposed bugs that were already there
> (trying to muck with vring state for queues that have not been setup?)

Yes, it did.  I had caught a few while writing the patches, but it does
feel like whack-a-mole...

Paolo

> Should we stick some asserts into the respective functions to help
> flush out the remaining bugs?
