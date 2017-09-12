Received: from eggs.gnu.org ([2001:4830:134:3::10]:52395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1drhmk-0006lA-0e
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:47:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1drhmg-0007S3-VB
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:47:14 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:34653)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1drhmg-0007Rq-N6
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:47:10 -0400
Received: by mail-io0-x244.google.com with SMTP id g32so5851051ioj.1
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 02:47:10 -0700 (PDT)
References: <20170907092010.3605-1-aik@ozlabs.ru>
	<20170907092010.3605-4-aik@ozlabs.ru>
	<984ae4a4-3045-e880-b39e-da846b1e2821@redhat.com>
	<b0ddd613-701c-4814-8241-d15d6917643f@ozlabs.ru>
	<32ae1779-0d00-0d1b-194f-130477531fdc@redhat.com>
	<38a55868-aea6-b0ef-3785-6d3621c2ab78@ozlabs.ru>
	<15727777-9a90-3da9-dfa0-17a717dcab15@redhat.com>
	<7fff3fb3-0d55-9c80-6269-ceb693ba93f0@ozlabs.ru>
	<adb82532-59fc-5eed-0976-0a08fea56601@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <f6ef4cf1-d60f-e05d-a2c0-79dae240b0f6@ozlabs.ru>
Date: Tue, 12 Sep 2017 19:47:04 +1000
MIME-Version: 1.0
In-Reply-To: <adb82532-59fc-5eed-0976-0a08fea56601@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH qemu 3/4] memory: Share flat views and
 dispatch trees between address spaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

On 12/09/17 17:12, Paolo Bonzini wrote:
> On 12/09/2017 07:55, Alexey Kardashevskiy wrote:
>> On 12/09/17 01:30, Paolo Bonzini wrote:
>>> On 11/09/2017 14:08, Alexey Kardashevskiy wrote:
>>>>> Ok, this makes sense.  Maybe it should be a flatview rather than an
>>>>> AddressSpaceDispatch (a FlatView is essentially a list of
>>>>> MemoryRegionSections; attaching the ASD to the FlatView is more or less
>>>>> an implementation detail).
>>>> The helpers I converted from AddressSpace to AddressSpaceDispatch do use
>>>> dispatch structure only and do not use FlatView so it seemed logical.
>>>
>>> Understood, but from a design POV FlatView makes more sense.
>>>
>>>> btw this address_space in MemoryRegionSection - it does not seem to make
>>>> much sense in the PhysPageMap::sections array, it only makes sense when
>>>> MemoryRegionSection uses as a temporary object when calling listeners. Will
>>>> it make sense if we enforce MemoryRegionSection::address_space to be NULL
>>>> in the array and not NULL when used temporary?
>>>
>>> memory_region_section_get_iotlb needs to access the AddressSpaceDispatch
>>> for sections stored in the PhysPageMap array, because
>>> memory_region_section_get_iotlb uses the ASD to compute the section index.
>>
>> Ohhh, not extremely trivial, out of curiosity - is that iotlb encoding
>> described anywhere?
> 
> No, I don't think so.
> 
>> Anyway, this can be simplified (or rather made more straightforward?) -
>> tlb_set_page_with_attrs() can calculate the section index and pass it to
>> memory_region_section_get_iotlb(). Still does not make much sense? It just
>> looks quite useless to keep that address_space pointer alive just for one
>> case which can easily avoid using this pointer.
> 
> Hmm I suppose address_space_translate_for_iotlb knows the ASD and could
> also return the index, basically combining it and
> memory_region_section_get_iotlb() into one function.

Ok, good.

One more question - how do we decide what goes to exec.c and what goes to
memory.c? I have a temptation to simply embed AddressSpaceDispatch into
FlatView instead of allocating it and storing the pointer (I'll probably
avoid doing so for now anyway but still curios).

The header comment for exec.c says it is "Virtual page mapping" but
AddressSpaceDispatch is a physical address space map and it seems to fit
into the memory.c's "Physical memory management" header comment.


-- 
Alexey
