Received: from eggs.gnu.org ([2001:4830:134:3::10]:55622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dVujz-00055S-OM
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 03:10:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dVujw-0002f5-Ip
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 03:10:19 -0400
Received: from mga03.intel.com ([134.134.136.65]:57188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dVujw-0002cX-7G
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 03:10:16 -0400
Message-ID: <59686EEB.8080805@intel.com>
Date: Fri, 14 Jul 2017 15:12:43 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1499863221-16206-1-git-send-email-wei.w.wang@intel.com>
	<1499863221-16206-6-git-send-email-wei.w.wang@intel.com>
	<20170712160129-mutt-send-email-mst@kernel.org>
	<5966241C.9060503@intel.com>
	<20170712163746-mutt-send-email-mst@kernel.org>
	<5967246B.9030804@intel.com>
	<20170713210819-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170713210819-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v12 5/8] virtio-balloon: VIRTIO_BALLOON_F_SG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, david@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, virtio-dev@lists.oasis-open.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

On 07/14/2017 04:19 AM, Michael S. Tsirkin wrote:
> On Thu, Jul 13, 2017 at 03:42:35PM +0800, Wei Wang wrote:
>> On 07/12/2017 09:56 PM, Michael S. Tsirkin wrote:
>>> So the way I see it, there are several issues:
>>>
>>> - internal wait - forces multiple APIs like kick/kick_sync
>>>     note how kick_sync can fail but your code never checks return code
>>> - need to re-write the last descriptor - might not work
>>>     for alternative layouts which always expose descriptors
>>>     immediately
>> Probably it wasn't clear. Please let me explain the two functions here:
>>
>> 1) virtqueue_add_chain_desc(vq, head_id, prev_id,..):
>> grabs a desc from the vq and inserts it to the chain tail (which is indexed
>> by
>> prev_id, probably better to call it tail_id). Then, the new added desc
>> becomes
>> the tail (i.e. the last desc). The _F_NEXT flag is cleared for each desc
>> when it's
>> added to the chain, and set when another desc comes to follow later.
> And this only works if there are multiple rings like
> avail + descriptor ring.
> It won't work e.g. with the proposed new layout where
> writing out a descriptor exposes it immediately.

I think it can support the 1.1 proposal, too. But before getting
into that, I think we first need to deep dive into the implementation
and usage of _first/next/last. The usage would need to lock the vq
from the first to the end (otherwise, the returned info about the number
of available desc in the vq, i.e. num_free, would be invalid):

lock(vq);
add_first();
add_next();
add_last();
unlock(vq);

However, I think the case isn't this simple, since we need to check more 
things
after each add_xx() step. For example, if only one entry is available at 
the time
we start to use the vq, that is, num_free is 0 after add_first(), we 
wouldn't be
able to add_next and add_last. So, it would work like this:

start:
     ...get free page block..
     lock(vq)
retry:
     ret = add_first(..,&num_free,);
     if(ret == -ENOSPC) {
         goto retry;
     } else if (!num_free) {
         add_chain_head();
         unlock(vq);
         kick & wait;
         goto start;
     }
next_one:
     ...get free page block..
     add_next(..,&num_free,);
     if (!num_free) {
         add_chain_head();
         unlock(vq);
         kick & wait;
         goto start;
     } if (num_free == 1) {
         ...get free page block..
         add_last(..);
         unlock(vq);
         kick & wait;
         goto start;
     } else {
         goto next_one;
     }

The above seems unnecessary to me to have three different APIs.
That's the reason to combine them into one virtqueue_add_chain_desc().

-- or, do you have a different thought about using the three APIs?


Implementation Reference:

struct desc_iterator {
     unsigned int head;
     unsigned int tail;
};

add_first(*vq, *desc_iterator, *num_free, ..)
{
     if (vq->vq.num_free < 1)
         return -ENOSPC;
     get_desc(&desc_id);
     desc[desc_id].flag &= ~_F_NEXT;
     desc_iterator->head = desc_id
     desc_iterator->tail = desc_iterator->head;
     *num_free = vq->vq.num_free;
}

add_next(vq, desc_iterator, *num_free,..)
{
     get_desc(&desc_id);
     desc[desc_id].flag &= ~_F_NEXT;
     desc[desc_iterator.tail].next = desc_id;
     desc[desc_iterator->tail].flag |= _F_NEXT;
     desc_iterator->tail = desc_id;
     *num_free = vq->vq.num_free;
}

add_last(vq, desc_iterator,..)
{
     get_desc(&desc_id);
     desc[desc_id].flag &= ~_F_NEXT;
     desc[desc_iterator.tail].next = desc_id;
     desc_iterator->tail = desc_id;

     add_chain_head(); // put the desc_iterator.head to the ring
}


Best,
Wei
