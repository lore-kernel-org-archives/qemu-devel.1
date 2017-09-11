Received: from eggs.gnu.org ([2001:4830:134:3::10]:37597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1drNWB-0006vZ-6f
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 08:08:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1drNW5-0000g6-V3
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 08:08:47 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:36272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1drNW5-0000dT-NR
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 08:08:41 -0400
Received: by mail-it0-x244.google.com with SMTP id e134so1107416ite.3
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 05:08:39 -0700 (PDT)
References: <20170907092010.3605-1-aik@ozlabs.ru>
	<20170907092010.3605-4-aik@ozlabs.ru>
	<984ae4a4-3045-e880-b39e-da846b1e2821@redhat.com>
	<b0ddd613-701c-4814-8241-d15d6917643f@ozlabs.ru>
	<32ae1779-0d00-0d1b-194f-130477531fdc@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <38a55868-aea6-b0ef-3785-6d3621c2ab78@ozlabs.ru>
Date: Mon, 11 Sep 2017 22:08:32 +1000
MIME-Version: 1.0
In-Reply-To: <32ae1779-0d00-0d1b-194f-130477531fdc@redhat.com>
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

On 11/09/17 19:37, Paolo Bonzini wrote:
> On 11/09/2017 11:06, Alexey Kardashevskiy wrote:
>> On 11/09/17 17:40, Paolo Bonzini wrote:
>>> On 07/09/2017 11:20, Alexey Kardashevskiy wrote:
>>>>  
>>>>      /* Accessed via RCU.  */
>>>>      struct FlatView *current_map;
>>>>  
>>>>      int ioeventfd_nb;
>>>>      struct MemoryRegionIoeventfd *ioeventfds;
>>>> -    struct AddressSpaceDispatch *dispatch;
>>>> -    struct AddressSpaceDispatch *next_dispatch;
>>>> +
>>>
>>> The rough idea of the patch matches my suggestion indeed.  However, I am
>>> not sure why all of the changes in patch 2 are needed.
>>
>> For this:
>>
>>  struct MemoryRegionSection {
>>      MemoryRegion *mr;
>> -    AddressSpace *address_space;
>> +    AddressSpaceDispatch *dispatch;
>>
>> as there are many ASes attached to the same flatview/dispatch.
> 
> Ok, this makes sense.  Maybe it should be a flatview rather than an
> AddressSpaceDispatch (a FlatView is essentially a list of
> MemoryRegionSections; attaching the ASD to the FlatView is more or less
> an implementation detail).

The helpers I converted from AddressSpace to AddressSpaceDispatch do use
dispatch structure only and do not use FlatView so it seemed logical.

btw this address_space in MemoryRegionSection - it does not seem to make
much sense in the PhysPageMap::sections array, it only makes sense when
MemoryRegionSection uses as a temporary object when calling listeners. Will
it make sense if we enforce MemoryRegionSection::address_space to be NULL
in the array and not NULL when used temporary?


> 
> 
>> And because of that, there is also:
>>
>>  struct IOMMUTLBEntry {
>> -    AddressSpace    *target_as;
>> +    AddressSpaceDispatch *target_dispatch;
>>
>> as the "section" in address_space_get_iotlb_entry() does not have
>> address_space any more, even though the only user of it -
>> vhost_device_iotlb_miss() - only checks if (iotlb.target_dispatch != NULL).
> 
> You could change address_space_do_translate's "as" to AddressSpace **as.
>  Then, address_space_get_iotlb_entry can populate the .target_as from
> the output value of the argument.

Ok, since this seems better.


> 
>>> In addition, you could change the computation of FlatView's root to
>>> resolve 2^64-sized aliases;
>>
>> Here we reached the boundary of my english :)
>>
>> Roots are given when AS/Flatview is created, and aliases are resolved already.
>>
> 
> Currently, you're doing
> 
> +        if (view->root == root) {
> +            as->current_map = flatview_get(view);
> +            break;
> +        }
> 
> (and by the way the above doesn't resolve aliases; aliases are only
> resolved by render_memory_region).

I am learning as we speak :)


> 
> Instead, the FlatViews should be shared at transaction commit time.  At
> the beginning of commit, the list of flat views is empty.  As you
> process each AddressSpace, you resolve the root alias(*) and search for
> the resulting MemoryRegion in the list of FlatViews.  If you find it,
> you do flatview_ref and point as->current_map to the FlatView you just
> found.  Otherwise, you do generate_memory_topology etc. as in the old code.
> 
> (*) something like
> 
> 	MemoryRegion *mr = as->root;
> 	MemoryRegion *root_mr;
> 	while (mr->alias && !mr->alias_offset &&
> 	       int128_ge(mr->size, mr->alias->size)) {
> 	    /* The alias is included in its entirety.  Use it as
> 	     * the "real" root, so that we can share more FlatViews.
> 	     */
> 	    mr = mr->alias;
> 	}	
> 
> 	/* We found the "real" root, but maybe we can use a shared empty
> 	 * FlatView instead?
> 	 */
>         for (root_mr = mr; root_mr; root_mr = root_mr->alias) {
> 	    if (!root_mr->enabled) {
> 		/* Use a shared empty FlatView.  */
> 		return NULL;
> 	    }
>         }
> 
>         return mr;


Ah, makes sense now, thanks.

> 
> Also:
> 
>> +static FlatView *flatview_get(FlatView *view)
>>  {
>> -    FlatView *view;
>> -
>>      rcu_read_lock();
>> -    view = atomic_rcu_read(&as->current_map);
>> +    view = atomic_rcu_read(&view);
> 
> This is "view = view" so it makes little sense, and then in the caller
> 
> +    view = flatview_get(as->current_map);
> 
> as->current_map is accessed without atomic_rcu_read.  So
> address_space_get_flatview must stay.  Probably this will solve itself
> when you do the rest.
> 
> Paolo
> 
>>> also set it to NULL if the AddressSpace's
>>> root is disabled or the alias it resolves to is disabled (and so on
>>> recursively until a non-alias is found).  This should remove the need
>>> for address_space_root() and the change to pci_init_bus_master.
>>
>>
>>
>>
> 


-- 
Alexey
