Received: from eggs.gnu.org ([2001:4830:134:3::10]:47708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cHv7T-0002Hx-AV
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 11:12:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cHv7S-0006fB-9W
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 11:12:27 -0500
MIME-Version: 1.0
In-Reply-To: <86f7031a-981a-ef51-8a20-0a3c38e88835@linux.vnet.ibm.com>
References: <20161215154330.700-1-pasic@linux.vnet.ibm.com>
	<20161216102528.GB4129@stefanha-x1.localdomain>
	<86f7031a-981a-ef51-8a20-0a3c38e88835@linux.vnet.ibm.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 16 Dec 2016 16:12:24 +0000
Message-ID: <CAJSP0QVZQ=AXb+gZ3VftkYZ2y=SM_3uhV4VMAmK7GEmJYmpgHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] virtio: fix vring->inuse recalc after migr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-stable <qemu-stable@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On Fri, Dec 16, 2016 at 3:41 PM, Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> On 12/16/2016 11:25 AM, Stefan Hajnoczi wrote:
>> On Thu, Dec 15, 2016 at 04:43:30PM +0100, Halil Pasic wrote:
>>> Correct recalculation of vring->inuse after migration for
>>> the corner case where the avail_idx has already wrapped
>>> but used_idx not yet.
>>>
>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>> Fixes: bccdef6b ("virtio: recalculate vq->inuse after migration")
>>> CC: qemu-stable@nongnu.org
>>> ---
>>>
>>> I think we could also change the type of inuse to uint16_t.
>>> Would this be considered a good idea?
>>
>> VRing.num is unsigned int.  I would use the same type as num since this
>> is a size, not an index.
>>
>
> Thanks. I asked myself the question why are VRing.num and inuse (at
> least theoretically arch depended width but at least 16 bit) int while
> the indexes of the available and used rings uint16_t. Only thing I can
> think of is some sort of optimization, because the only difference I can
> see is that the VRing.num is communicated via the transport while the
> indexes are a part (and/or corresponding to) of the ring layout (that is
> the shared memory virtio structures and have a fixed width).
>
> Now I'm kind of in doubt: I think having a signed has the benefit of a
> negative value being more obviously wrong size (for a human looking at
> it) that a to large positive, but purely theoretically the maximum value
> of inuse is not guaranteed to fit int (as in C99 MIN_INT is 2^15 - 1).
>
> What is your opinion? Should we keep 'inuse' as is, or should I change
> it to unsigned with v2 (or prepare a separate patch)?

I'm happy with unsigned.  I've CCed Michael Tsirkin in case he has a preference.

>>> ---
>>>  hw/virtio/virtio.c | 7 +++++--
>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>>> index 1af2de2..089c6f6 100644
>>> --- a/hw/virtio/virtio.c
>>> +++ b/hw/virtio/virtio.c
>>> @@ -1855,9 +1855,12 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
>>>              /*
>>>               * Some devices migrate VirtQueueElements that have been popped
>>>               * from the avail ring but not yet returned to the used ring.
>>> +             * Cast to uint16_t is OK because max ring size is 0x8000. Thus
>>> +             * no the size of largest array indexable by an integral type
>>> +             * can not be represented by the same type problem.
>>
>> I think it would be safe up to max ring size UINT16_MAX - 1 (we need
>> that extra value to distinguish between empty and full avail rings)?
>>
>
> Yeah.
>
>> The last sentence is hard to understand due to the double negative.  I
>> think you are saying "Since max ring size < UINT16_MAX it's safe to use
>> uint16_t to represent the size of the ring".
>>
>
> You are not the first one complaining, so the sentence is definitively
> bad. What disturbs me regarding your formulation is that we do not use
> uint16_t to represent neither the ring size nor inuse.
>
> How about "Since max ring size < UINT16_MAX it's safe to use modulo
> UINT16_MAX + 1 subtraction."?

That doesn't mention "representing the size of the ring" so it's
unclear what "safe" means.

Stefan
