Received: from eggs.gnu.org ([2001:4830:134:3::10]:48962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gBwlz-0006jK-A6
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 02:54:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gBwlw-0003Mh-1M
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 02:54:39 -0400
References: <20181012032431.32693-1-david@gibson.dropbear.id.au>
	<20181012032431.32693-2-david@gibson.dropbear.id.au>
	<20181012140306-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <996ed901-14b6-7461-a094-771a715cd6b2@redhat.com>
Date: Mon, 15 Oct 2018 08:54:27 +0200
MIME-Version: 1.0
In-Reply-To: <20181012140306-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 1/5] virtio-balloon: Remove unnecessary
 MADV_WILLNEED on deflate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: dhildenb@redhat.com, imammedo@redhat.com, ehabkost@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 12/10/2018 20:05, Michael S. Tsirkin wrote:
> On Fri, Oct 12, 2018 at 02:24:27PM +1100, David Gibson wrote:
>> When the balloon is inflated, we discard memory place in it using madvise()
>> with MADV_DONTNEED.  And when we deflate it we use MADV_WILLNEED, which
>> sounds like it makes sense but is actually unnecessary.
>>
>> The misleadingly named MADV_DONTNEED just discards the memory in question,
>> it doesn't set any persistent state on it in-kernel; all that's necessary
>> to bring the memory back is to touch it.  MADV_WILLNEED in contrast
>> specifically says that the memory will be used soon and faults it in.
>>
>> Memory that's being given back to the guest by deflating the balloon
>> *might* be used soon, but it equally could just sit around in the guest's
>> pools until it actually needs it.  And, over the general timescale that
>> memory ballooning operates, it seems unlikely that one extra fault for the
>> guest will be a vast performance issue.
> 
> Thinking about it, it might be for RT guests.
> 
> So I suspect if you want to drop MADV_WILLNEED you need a flag
> telling qemu that's not the usecase.
> 

As far as I know RT guests

1. mlock all memory
2. use huge pages

"MADV_DONTNEED cannot be applied to locked pages, Huge TLB pages, or
VM_PFNMAP pages."

As DONTNEED never succeeded, WILLNEED will do nothing. (e.g. postcopy
temporarily has to unlock all memory in order to make DONTNEED work)

(And "Expect access in the near future." does not sound like guarantees
to me either way)

So I think this can go.

-- 

Thanks,

David / dhildenb
