Received: from eggs.gnu.org ([2001:4830:134:3::10]:35559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eyuuu-0006Zu-Tf
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 03:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eyuuq-0007Vx-Rh
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 03:45:44 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:36867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eyuuq-0007VT-J0
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 03:45:40 -0400
Received: by mail-it0-x244.google.com with SMTP id p67-v6so5027312itc.2
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 00:45:40 -0700 (PDT)
References: <20180209075503.16996-1-aik@ozlabs.ru>
	<20180209075503.16996-3-aik@ozlabs.ru>
	<410aeb28-e940-35f9-c7de-cb1c95422857@redhat.com>
	<20180321092941.446a2aea@w520.home>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <27c15570-fb04-5ab0-6dd4-d100a5f30179@ozlabs.ru>
Date: Thu, 22 Mar 2018 18:45:33 +1100
MIME-Version: 1.0
In-Reply-To: <20180321092941.446a2aea@w520.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v7 2/4] vfio/pci: Relax DMA map errors
 for MMIO regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, Auger Eric <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 22/3/18 2:29 am, Alex Williamson wrote:
> On Mon, 19 Mar 2018 21:49:58 +0100
> Auger Eric <eric.auger@redhat.com> wrote:
> 
>> Hi Alexey,
>>
>> On 09/02/18 08:55, Alexey Kardashevskiy wrote:
>>> At the moment if vfio_memory_listener is registered in the system memory
>>> address space, it maps/unmaps every RAM memory region for DMA.
>>> It expects system page size aligned memory sections so vfio_dma_map
>>> would not fail and so far this has been the case. A mapping failure
>>> would be fatal. A side effect of such behavior is that some MMIO pages
>>> would not be mapped silently.
>>>
>>> However we are going to change MSIX BAR handling so we will end having
>>> non-aligned sections in vfio_memory_listener (more details is in
>>> the next patch) and vfio_dma_map will exit QEMU.
>>>
>>> In order to avoid fatal failures on what previously was not a failure and
>>> was just silently ignored, this checks the section alignment to
>>> the smallest supported IOMMU page size and prints an error if not aligned;
>>> it also prints an error if vfio_dma_map failed despite the page size check.
>>> Both errors are not fatal; only MMIO RAM regions are checked
>>> (aka "RAM device" regions).
>>>
>>> If the amount of errors printed is overwhelming, the MSIX relocation
>>> could be used to avoid excessive error output.
>>>
>>> This is unlikely to cause any behavioral change.
>>>
>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>> ---
>>>  hw/vfio/common.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++------
>>>  1 file changed, 49 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>> index f895e3c..736f271 100644
>>> --- a/hw/vfio/common.c
>>> +++ b/hw/vfio/common.c
>>> @@ -544,18 +544,40 @@ static void vfio_listener_region_add(MemoryListener *listener,
>>>  
>>>      llsize = int128_sub(llend, int128_make64(iova));
>>>  
>>> +    if (memory_region_is_ram_device(section->mr)) {
>>> +        hwaddr pgmask = (1ULL << ctz64(hostwin->iova_pgsizes)) - 1;
>>> +
>>> +        if ((iova & pgmask) || (llsize & pgmask)) {
>>> +            error_report("Region 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx
>>> +                         " is not aligned to 0x%"HWADDR_PRIx
>>> +                         " and cannot be mapped for DMA",
>>> +                         section->offset_within_region,
>>> +                         int128_getlo(section->size),  
>> Didn't you want to print the section->offset_within_address_space
>> instead of section->offset_within_region?


I do, my bad - this offset_within_region is a leftover from an earlier
version, iova is offset_within_address_space essentially.


>>
>> For an 1000e card*, with a 64kB page, it outputs:
>> "Region 0x50..0xffb0 is not aligned to 0x10000 and cannot be mapped for DMA"
>>
>> an absolute gpa range would be simpler I think.
> 
> I agree, the offset within the address space seems like it'd be much
> easier to map back to the device.  Since we're handling it as
> non-fatal, perhaps we can even add "MMIO Region" to give the user a bit
> more context where the issue occurs.  Alexey, do you want to submit a
> follow-up patch, or Eric, you may have the best resources to tune the
> message.  Thanks,


I can if somebody gives a hint about what needs to be tuned in the message.
I am also fine if Eric does this too :)


> 
> Alex
>  
>> * where 	Region 3: Memory at 100e0000 (32-bit, non-prefetchable)
>> [size=16K] contains the MSIX table
>>
>> 	Capabilities: [a0] MSI-X: Enable+ Count=5 Masked-
>> 		Vector table: BAR=3 offset=00000000
>> 		PBA: BAR=3 offset=00002000
>>
>> Thanks
>>
>> Eric
>>> +                         pgmask + 1);
>>> +            return;
>>> +        }
>>> +    }
>>> +
>>>      ret = vfio_dma_map(container, iova, int128_get64(llsize),
>>>                         vaddr, section->readonly);
>>>      if (ret) {
>>>          error_report("vfio_dma_map(%p, 0x%"HWADDR_PRIx", "
>>>                       "0x%"HWADDR_PRIx", %p) = %d (%m)",
>>>                       container, iova, int128_get64(llsize), vaddr, ret);
>>> +        if (memory_region_is_ram_device(section->mr)) {
>>> +            /* Allow unexpected mappings not to be fatal for RAM devices */
>>> +            return;
>>> +        }
>>>          goto fail;
>>>      }
>>>  
>>>      return;
>>>  
>>>  fail:
>>> +    if (memory_region_is_ram_device(section->mr)) {
>>> +        error_report("failed to vfio_dma_map. pci p2p may not work");
>>> +        return;
>>> +    }
>>>      /*
>>>       * On the initfn path, store the first error in the container so we
>>>       * can gracefully fail.  Runtime, there's not much we can do other
>>> @@ -577,6 +599,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
>>>      hwaddr iova, end;
>>>      Int128 llend, llsize;
>>>      int ret;
>>> +    bool try_unmap = true;
>>>  
>>>      if (vfio_listener_skipped_section(section)) {
>>>          trace_vfio_listener_region_del_skip(
>>> @@ -629,13 +652,33 @@ static void vfio_listener_region_del(MemoryListener *listener,
>>>  
>>>      trace_vfio_listener_region_del(iova, end);
>>>  
>>> -    ret = vfio_dma_unmap(container, iova, int128_get64(llsize));
>>> +    if (memory_region_is_ram_device(section->mr)) {
>>> +        hwaddr pgmask;
>>> +        VFIOHostDMAWindow *hostwin;
>>> +        bool hostwin_found = false;
>>> +
>>> +        QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
>>> +            if (hostwin->min_iova <= iova && end <= hostwin->max_iova) {
>>> +                hostwin_found = true;
>>> +                break;
>>> +            }
>>> +        }
>>> +        assert(hostwin_found); /* or region_add() would have failed */
>>> +
>>> +        pgmask = (1ULL << ctz64(hostwin->iova_pgsizes)) - 1;
>>> +        try_unmap = !((iova & pgmask) || (llsize & pgmask));
>>> +    }
>>> +
>>> +    if (try_unmap) {
>>> +        ret = vfio_dma_unmap(container, iova, int128_get64(llsize));
>>> +        if (ret) {
>>> +            error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
>>> +                         "0x%"HWADDR_PRIx") = %d (%m)",
>>> +                         container, iova, int128_get64(llsize), ret);
>>> +        }
>>> +    }
>>> +
>>>      memory_region_unref(section->mr);
>>> -    if (ret) {
>>> -        error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
>>> -                     "0x%"HWADDR_PRIx") = %d (%m)",
>>> -                     container, iova, int128_get64(llsize), ret);
>>> -    }
>>>  
>>>      if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
>>>          vfio_spapr_remove_window(container,
>>>   
> 


-- 
Alexey
