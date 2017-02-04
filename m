Received: from eggs.gnu.org ([2001:4830:134:3::10]:56573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cZzez-0006Q7-04
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 07:41:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cZzev-0003m3-T2
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 07:41:45 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:34725)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cZzev-0003lc-Mb
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 07:41:41 -0500
Received: by mail-pf0-x241.google.com with SMTP id y143so3498556pfb.1
	for <qemu-devel@nongnu.org>; Sat, 04 Feb 2017 04:41:41 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1486141597-13941-1-git-send-email-fred.konrad@greensocs.com>
	<1486141597-13941-5-git-send-email-fred.konrad@greensocs.com>
	<d64a7dfd-cb55-ba59-9731-282bb98cf20e@redhat.com>
	<1673015b-b059-8094-1b8c-b7039a45cf8e@greensocs.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <14c737f4-b965-a1b8-ba3c-003e5fa9e3fd@redhat.com>
Date: Sat, 4 Feb 2017 04:41:36 -0800
MIME-Version: 1.0
In-Reply-To: <1673015b-b059-8094-1b8c-b7039a45cf8e@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC 4/5] exec: allow to get a pointer for some
 mmio memory region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Frederic Konrad <fred.konrad@greensocs.com>
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org, mark.burton@greensocs.com, qemu-devel@nongnu.org, alistair.francis@xilinx.com, clg@kaod.org



On 03/02/2017 13:09, Frederic Konrad wrote:
> On 02/03/2017 06:26 PM, Paolo Bonzini wrote:
>>
>>
>> On 03/02/2017 09:06, fred.konrad@greensocs.com wrote:
>>> +    host = mr->ops->request_ptr(mr->opaque, addr - mr->addr, &size, &offset);
>>> +
>>> +    if (!host || !size) {
>>> +        memory_region_transaction_commit();
>>> +        return false;
>>> +    }
>>> +
>>> +    sub = g_new(MemoryRegion, 1);
>>> +    memory_region_init_ram_ptr(sub, OBJECT(mr), "mmio-map", size, host);
>>> +    memory_region_add_subregion(mr, offset, sub);
>>> +    memory_region_transaction_commit();
>>> +    return true;
>>> +}
>>> +
>>> +void memory_region_invalidate_mmio_ptr(MemoryRegion *mr, hwaddr offset,
>>> +                                       unsigned size)
>>> +{
>>> +    MemoryRegionSection section = memory_region_find(mr, offset, size);
>>> +
>>> +    if (section.mr != mr) {
>>> +        memory_region_del_subregion(mr, section.mr);
>>> +        /* memory_region_find add a ref on section.mr */
>>> +        memory_region_unref(section.mr);
>>> +        object_unparent(OBJECT(section.mr));
>>
>> I think this would cause a use-after-free when using MTTCG.  In general,
>> creating and dropping MemoryRegions dynamically can cause bugs that are
>> nondeterministic and hard to fix without rewriting everything.
> 
> Hi Paolo,
> 
> Thanks for your comment.
> Yes, I read in the docs that dynamically dropping MemoryRegions is badly
> broken when we use NULL as an owner because the machine owns it.
> But it seems nothing said this is the case with an owner.
> 
> But I think I see your point here:
>   * memory_region_unref will unref the owner.
>   * object_unparent will unref the memory region (which should be 1).
>   => the region will be dropped immediately.
> 
> Doesn't hotplug use dynamic MemoryRegion? In which case we better
> make that work with MTTCG. I wonder if we can't simply handle that
> with a safe_work for this case?

Hot-unplug works because the backing memory is only freed when the
device gets instance_finalize, so at that point the region cannot have
any references.

What can go wrong is the following (from the docs):

- the memory region's owner had a reference taken via memory_region_ref
  (for example by address_space_map)

- the region is unparented, and has no owner anymore

- when address_space_unmap is called, the reference to the memory
  region's owner is leaked.

In your case you have phys_section_add/phys_section_destroy instead of
address_space_map/unmap, but the problem is the same.

I am a bit unsure about using the same lqspi_buf for caching different
addresses, and about using the same buffer for MMIO execution and read.
What if you allocate a different buffer every time
lqspi_request_mmio_ptr is called (adding a char* argument to
lqspi_load_cache) and free the old one from the safe_work item, after a
global TLB flush?  Then you don't need the Notifiers which were the
complicated and handwavy part of my proposal.

Paolo

> 
> BTW the tests I have seems to pass without issues.
> 
>>
>> An alternative design could be:
>>
>> - memory_region_request_mmio_ptr returns a MemoryRegionCache instead of
>> a pointer, so that the device can map a subset of the device (e.g. a
>> single page)
> 
> I'm not aware of this MemoryRegionCache yet, it seems pretty new.
> I'll take a look.
> 
> Thanks,
> Fred
> 
>>
>> - memory_region_request_mmio_ptr and MemoryRegionOps.request_ptr accept
>> a Notifier
>>
>> - the device adds the Notifier to a NotifierList.  Before invalidating,
>> it invokes the Notifier and empties the NotifierList.
>>
>> - for the TLB case, the Notifier calls tlb_flush_page.
>>
>> I like the general idea though!
>>
>> Paolo
>>
>>> +    }
>>> +}
> 
> 
> 
