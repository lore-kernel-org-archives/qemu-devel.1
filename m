Received: from eggs.gnu.org ([2001:4830:134:3::10]:55513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cii6a-0001ii-Uv
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:46:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cii6X-0004I5-Oc
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:46:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cii6X-0004GY-Iz
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:46:13 -0500
References: <baa954b4-53fc-2b4e-b79c-917ba9171a60@de.ibm.com>
	<20170227160609.0d49a87d.cornelia.huck@de.ibm.com>
	<20170227163708.796ab27f.cornelia.huck@de.ibm.com>
	<a5ada7c2-4166-1cdf-a4e0-7c49a68374f9@redhat.com>
	<20170228134854.141a10e6.cornelia.huck@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6b9508d3-98d4-bce4-8f50-f6f3b09178a9@redhat.com>
Date: Tue, 28 Feb 2017 14:46:10 +0100
MIME-Version: 1.0
In-Reply-To: <20170228134854.141a10e6.cornelia.huck@de.ibm.com>
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
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>



On 28/02/2017 13:48, Cornelia Huck wrote:
> On Mon, 27 Feb 2017 16:41:09 +0100
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
>> On 27/02/2017 16:37, Cornelia Huck wrote:
>>> With the following applied (probably whitespace damaged), my guest
>>> starts:
>>>
>>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>>> index e487e36..28906e5 100644
>>> --- a/hw/virtio/virtio.c
>>> +++ b/hw/virtio/virtio.c
>>> @@ -287,6 +287,9 @@ static inline void vring_set_avail_event(VirtQueue *vq, uint16_t val)
>>>  void virtio_queue_set_notification(VirtQueue *vq, int enable)
>>>  {
>>>      vq->notification = enable;
>>> +    if (!vq->vring.desc) {
>>> +        return;
>>> +    }
>>>  
>>>      rcu_read_lock();
>>>      if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
>>>
>>> Maybe introduction of caches just exposed bugs that were already there
>>> (trying to muck with vring state for queues that have not been setup?)
>>
>> Yes, it did.  I had caught a few while writing the patches, but it does
>> feel like whack-a-mole...
>>
>> Paolo
>>
>>> Should we stick some asserts into the respective functions to help
>>> flush out the remaining bugs?
> 
> I've been staring at the code some more and I'm not really sure how to
> fix this properly.
> 
> The dataplane code tries to switch handlers for all virtqueues,
> regardless whether they are configured or not. My hack above leaves the
> notification in a bit of an ambiguous state, as it cannot
> enable/disable notifications on the real queues.

What if virtio_queue_set_addr called virtio_queue_set_notification(vq,
vq->notification)?  In fact the RCU-protected part of
virtio_queue_set_notification could become its own function, something
like virtio_queue_update_notification or perhaps a better name.

virtio_queue_set_addr is only called by the virtio transports, not e.g.
on migration, so it seems to be the right spot.

Paolo

> This is ok for this particular case, where we hand over from the bios
> (which only enables the first queue) to the Linux kernel (which uses
> multiple queues) - but with a virtio reset before additional queues are
> configured. I don't think the spec prohibits configuring extra queues
> (if present) on the fly, however...
> 
