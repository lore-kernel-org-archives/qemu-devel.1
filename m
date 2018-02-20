Received: from eggs.gnu.org ([2001:4830:134:3::10]:52152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eo6qh-0005JL-Ab
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 07:16:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eo6qd-0003Ci-CA
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 07:16:43 -0500
References: <20180219174231.10874-1-david@redhat.com>
	<493dbfb3-086b-cc89-2d8d-4298345c6bb2@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <ef55dc18-971f-b012-40cc-0c32f24664cf@redhat.com>
Date: Tue, 20 Feb 2018 13:16:37 +0100
MIME-Version: 1.0
In-Reply-To: <493dbfb3-086b-cc89-2d8d-4298345c6bb2@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFCv2] s390x/sclp: remove memory hotplug
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>

On 20.02.2018 13:05, Christian Borntraeger wrote:
> 
> 
> On 02/19/2018 06:42 PM, David Hildenbrand wrote:
>> From an architecture point of view, nothing can be mapped into the address
>> space on s390x. All there is is memory. Therefore there is also not really
>> an interface to communicate such information to the guest. All we can do is
>> specify the maximum ram address and guests can probe in that range if
>> memory is available and usable (TPROT).
> 
> In fact there is an interface in SCLP that describes the memory sizes (maximum in 
> read scp info) and the details (read_storage_element0_info).  I am asking myself
> if we should re-introduce read_storage_element_info and use that to avoid tprot

Yes, we could do that (basically V1 of this patch) but have to glue it
to the a compatibility machine then.

> in the guests. Anyway that is future but maybe change your "TPROT" to sclp + tprot.

Yes, makes sense.

> 
> 
>>
>> Also memory hotplug is strange. The guest can decide at some point in
>> time to add / remove memory in some range. And nobody can really hinder it
>> from doing so.
> 
> The host can reject to online an increment. For example on LPAR this is used as
> a poor mans overcommitment. You can online prepared standy memory if there is
> enough memory left.

Interesting, didn't know about that. Will rephrase then to

"While the hypervisor can deny to online an increment, all increments
have to be predefined and there is no way of telling the guest about a
newly "hotplugged" increment."

> 
>  So if we specify right now e.g.
>>     -m 2G,slots=2,maxmem=20G
>> An ordinary fedora guest will happily online (hotplug) all memory,
>> resulting in a guest consuming 20G. So it really behaves rather like
>>     -m 22G
>> There is no way to hotplug memory from the outside like on other
>> architectures. This is of course bad for upper management layers.
> 
> This is the main issue with the current code.


-- 

Thanks,

David / dhildenb
