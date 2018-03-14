Received: from eggs.gnu.org ([2001:4830:134:3::10]:54777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1evwLA-0006kk-JT
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 22:40:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1evwL7-0003VH-FY
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 22:40:32 -0400
Received: from mail-pf0-x232.google.com ([2607:f8b0:400e:c00::232]:41849)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1evwL7-0003SW-5O
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 22:40:29 -0400
Received: by mail-pf0-x232.google.com with SMTP id f80so782823pfa.8
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 19:40:27 -0700 (PDT)
References: <20180212051954.GE11634@umbus.fritz.box>
	<0a57f0ec-4300-f4f3-3957-4bced8b57e14@ozlabs.ru>
	<20180212090653.42bdd2e2@w520.home>
	<0c594a0b-488c-b5f8-e8ed-ffa8f4a98088@ozlabs.ru>
	<20180213053630.GL11634@umbus.fritz.box>
	<20180213054124.GN11634@umbus.fritz.box>
	<8282d070-b2d3-7e43-3da9-b17c77b99a67@ozlabs.ru>
	<20180214013323.GA5247@umbus.fritz.box>
	<843efd62-7a39-8536-91ad-1abea2beb190@ozlabs.ru>
	<20180214085541.5491705f@w520.home>
	<20180216052824.GI2074@umbus.fritz.box>
	<c11af933-3f08-f2c8-0552-ce43ac8f5741@ozlabs.ru>
	<a29658e8-d2da-161d-d9b8-41f186969927@ozlabs.ru>
	<821596dc-35b0-60cf-3e1f-3df0809b2f8e@ozlabs.ru>
	<8e909bd8-2c24-abde-aa42-fd3f46ff649e@ozlabs.ru>
	<20180313105606.18d0d8af@w520.home>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <423b0a12-ed99-e9e1-eae0-d0cfd1a4d6bf@ozlabs.ru>
Date: Wed, 14 Mar 2018 13:40:21 +1100
MIME-Version: 1.0
In-Reply-To: <20180313105606.18d0d8af@w520.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Alex Williamson <alex.williamson@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Auger Eric <eric.auger@redhat.com>

On 14/3/18 3:56 am, Alex Williamson wrote:
> [Cc +Eric]
> 
> On Tue, 13 Mar 2018 15:53:19 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
>> On 7/3/18 1:17 pm, Alexey Kardashevskiy wrote:
>>> On 26/02/18 19:36, Alexey Kardashevskiy wrote:  
>>>> On 19/02/18 13:46, Alexey Kardashevskiy wrote:  
>>>>> On 16/02/18 16:28, David Gibson wrote:  
>>>>>> On Wed, Feb 14, 2018 at 08:55:41AM -0700, Alex Williamson wrote:  
>>>>>>> On Wed, 14 Feb 2018 19:09:16 +1100
>>>>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>>>>>  
>>>>>>>> On 14/02/18 12:33, David Gibson wrote:  
>>>>>>>>> On Tue, Feb 13, 2018 at 07:20:56PM +1100, Alexey Kardashevskiy wrote:    
>>>>>>>>>> On 13/02/18 16:41, David Gibson wrote:    
>>>>>>>>>>> On Tue, Feb 13, 2018 at 04:36:30PM +1100, David Gibson wrote:    
>>>>>>>>>>>> On Tue, Feb 13, 2018 at 12:15:52PM +1100, Alexey Kardashevskiy wrote:    
>>>>>>>>>>>>> On 13/02/18 03:06, Alex Williamson wrote:    
>>>>>>>>>>>>>> On Mon, 12 Feb 2018 18:05:54 +1100
>>>>>>>>>>>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>>>>>>>>>>>>    
>>>>>>>>>>>>>>> On 12/02/18 16:19, David Gibson wrote:    
>>>>>>>>>>>>>>>> On Fri, Feb 09, 2018 at 06:55:01PM +1100, Alexey Kardashevskiy wrote:      
>>>>>>>>>>>>>>>>> At the moment if vfio_memory_listener is registered in the system memory
>>>>>>>>>>>>>>>>> address space, it maps/unmaps every RAM memory region for DMA.
>>>>>>>>>>>>>>>>> It expects system page size aligned memory sections so vfio_dma_map
>>>>>>>>>>>>>>>>> would not fail and so far this has been the case. A mapping failure
>>>>>>>>>>>>>>>>> would be fatal. A side effect of such behavior is that some MMIO pages
>>>>>>>>>>>>>>>>> would not be mapped silently.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> However we are going to change MSIX BAR handling so we will end having
>>>>>>>>>>>>>>>>> non-aligned sections in vfio_memory_listener (more details is in
>>>>>>>>>>>>>>>>> the next patch) and vfio_dma_map will exit QEMU.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> In order to avoid fatal failures on what previously was not a failure and
>>>>>>>>>>>>>>>>> was just silently ignored, this checks the section alignment to
>>>>>>>>>>>>>>>>> the smallest supported IOMMU page size and prints an error if not aligned;
>>>>>>>>>>>>>>>>> it also prints an error if vfio_dma_map failed despite the page size check.
>>>>>>>>>>>>>>>>> Both errors are not fatal; only MMIO RAM regions are checked
>>>>>>>>>>>>>>>>> (aka "RAM device" regions).
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> If the amount of errors printed is overwhelming, the MSIX relocation
>>>>>>>>>>>>>>>>> could be used to avoid excessive error output.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> This is unlikely to cause any behavioral change.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>      
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> There are some relatively superficial problems noted below.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> But more fundamentally, this feels like it's extending an existing
>>>>>>>>>>>>>>>> hack past the point of usefulness.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> The explicit check for is_ram_device() here has always bothered me -
>>>>>>>>>>>>>>>> it's not like a real bus bridge magically knows whether a target
>>>>>>>>>>>>>>>> address maps to RAM or not.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> What I think is really going on is that even for systems without an
>>>>>>>>>>>>>>>> IOMMU, it's not really true to say that the PCI address space maps
>>>>>>>>>>>>>>>> directly onto address_space_memory.  Instead, there's a large, but
>>>>>>>>>>>>>>>> much less than 2^64 sized, "upstream window" at address 0 on the PCI
>>>>>>>>>>>>>>>> bus, which is identity mapped to the system bus.  Details will vary
>>>>>>>>>>>>>>>> with the system, but in practice we expect nothing but RAM to be in
>>>>>>>>>>>>>>>> that window.  Addresses not within that window won't be mapped to the
>>>>>>>>>>>>>>>> system bus but will just be broadcast on the PCI bus and might be
>>>>>>>>>>>>>>>> picked up as a p2p transaction.      
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Currently this p2p works only via the IOMMU, direct p2p is not possible as
>>>>>>>>>>>>>>> the guest needs to know physical MMIO addresses to make p2p work and it
>>>>>>>>>>>>>>> does not.    
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> /me points to the Direct Translated P2P section of the ACS spec, though
>>>>>>>>>>>>>> it's as prone to spoofing by the device as ATS.  In any case, p2p
>>>>>>>>>>>>>> reflected from the IOMMU is still p2p and offloads the CPU even if
>>>>>>>>>>>>>> bandwidth suffers vs bare metal depending on if the data doubles back
>>>>>>>>>>>>>> over any links.  Thanks,    
>>>>>>>>>>>>>
>>>>>>>>>>>>> Sure, I was just saying that p2p via IOMMU won't be as simple as broadcast
>>>>>>>>>>>>> on the PCI bus, IOMMU needs to be programmed in advance to make this work,
>>>>>>>>>>>>> and current that broadcast won't work for the passed through devices.    
>>>>>>>>>>>>
>>>>>>>>>>>> Well, sure, p2p in a guest with passthrough devices clearly needs to
>>>>>>>>>>>> be translated through the IOMMU (and p2p from a passthrough to an
>>>>>>>>>>>> emulated device is essentially impossible).
>>>>>>>>>>>>
>>>>>>>>>>>> But.. what does that have to do with this code.  This is the memory
>>>>>>>>>>>> area watcher, looking for memory regions being mapped directly into
>>>>>>>>>>>> the PCI space.  NOT IOMMU regions, since those are handled separately
>>>>>>>>>>>> by wiring up the IOMMU notifier.  This will only trigger if RAM-like,
>>>>>>>>>>>> non-RAM regions are put into PCI space *not* behind an IOMMMU.    
>>>>>>>>>>>
>>>>>>>>>>> Duh, sorry, realised I was mixing up host and guest IOMMU.  I guess
>>>>>>>>>>> the point here is that this will map RAM-like devices into the host
>>>>>>>>>>> IOMMU when there is no guest IOMMU, allowing p2p transactions between
>>>>>>>>>>> passthrough devices (though not from passthrough to emulated devices).    
>>>>>>>>>>
>>>>>>>>>> Correct.
>>>>>>>>>>    
>>>>>>>>>>>
>>>>>>>>>>> The conditions still seem kind of awkward to me, but I guess it makes
>>>>>>>>>>> sense.    
>>>>>>>>>>
>>>>>>>>>> Is it the time to split this listener to RAM-listener and PCI bus listener?    
>>>>>>>>>
>>>>>>>>> I'm not really sure what you mean by that.
>>>>>>>>>     
>>>>>>>>>> On x86 it listens on the "memory" AS, on spapr - on the
>>>>>>>>>> "pci@800000020000000" AS, this will just create more confusion over time...    
>>>>>>>>>
>>>>>>>>> Hm, it's still logically the same AS in each case - the PCI address
>>>>>>>>> space.  It's just that in the x86 case that happens to be the same as
>>>>>>>>> the memory AS (at least when there isn't a guest side IOMMU).    
>>>>>>>>
>>>>>>>> Hm. Ok.
>>>>>>>>  
>>>>>>>>> I do wonder if that's really right even for x86 without IOMMU.  The
>>>>>>>>> PCI address space is identity mapped to the "main" memory address
>>>>>>>>> space there, but I'm not sure it's mapped th *all* of the main memory    
>>>>>>>>
>>>>>>>> What should have been in the place of "th" above? :)
>>>>>>>>  
>>>>>>>>> address space, probably just certain ranges of it.  That's what I was
>>>>>>>>> suggesting earlier in the thread.    
>>>>>>>>
>>>>>>>> afaict vfio is trying to mmap every RAM MR == KVM memory slot, no ranges or
>>>>>>>> anything like that. I am trying to figure out what is not correct with the
>>>>>>>> patch. Thanks,  
>>>>>>>
>>>>>>> It is possible for x86 systems to have translation applied to MMIO vs
>>>>>>> RAM such that the processor view and device view of MMIO are different,
>>>>>>> putting them into separate address spaces, but this is not typical and
>>>>>>> not available on the class of chipsets that QEMU emulates for PC.
>>>>>>> Therefore I think it's correct that MMIO and RAM all live in one big
>>>>>>> happy, flat address space as they do now (assuming the guest IOMMU is
>>>>>>> not present or disabled).  Thanks,  
>>>>>>
>>>>>> Ah.. I think the thing I was missing is that on PC (at least with
>>>>>> typical chipsets) *all* MMIO essentially comes from PCI space.  Even
>>>>>> the legacy devices are essentially ISA which is treated as being on a
>>>>>> bridge under the PCI space.  On non-x86 there are often at least a
>>>>>> handful of MMIO devices that aren't within the PCI space - say, the
>>>>>> PCI host bridge itself at least.  x86 avoids that by using the
>>>>>> separate IO space, which is also a bit weird in that it's
>>>>>> simultaneously direct attached to the cpu (and so doesn't need bridge
>>>>>> configuration), but also identified with the legay IO space treated as
>>>>>> being under two bridges (host->PCI, PCI->ISA) for other purposes.
>>>>>>
>>>>>> Maybe it's just me, but I find it makes more sense to me if I think of
>>>>>> it as the two ASes being equal because on PC the system address map
>>>>>> (address_space_memory) is made equal to the PCI address map, rather
>>>>>> than the PCI address map being made equal to the system one.  
>>>>>
>>>>> It makes more sense to me too, we just do not exploit/expose this on SPAPR
>>>>> - the PCI address space only has 2xIOMMU and 1xMSI windows and that's it,
>>>>> no MMIO which is mapped to the system AS only (adding those to the PCI AS
>>>>> is little tricky as mentioned elsewhere).
>>>>>
>>>>> Anyway, I still wonder - what needs to be addressed in the 2/4 patch in
>>>>> order to proceed?  
>>>>
>>>> Ping?
>>>>  
>>>
>>>
>>> Ping?
>>>
>>>   
>>
>>
>> Could anyone please enlighten me what needs to be done with this patchset
>> to proceed, or confirm that it is ok but not going anywhere as everybody is
>> busy with other things? :) Thanks,
> 
> Actually making sure it compiles would have been nice:
> 
> qemu.git/hw/vfio/common.c: In function ‘vfio_listener_region_add’:
> qemu.git/hw/vfio/common.c:550:40: error: invalid operands to binary & (have ‘Int128 {aka struct Int128}’ and ‘hwaddr {aka long long unsigned int}’)
>          if ((iova & pgmask) || (llsize & pgmask)) {
>                                         ^
> qemu.git/hw/vfio/common.c: In function ‘vfio_listener_region_del’:
> qemu.git/hw/vfio/common.c:669:50: error: invalid operands to binary & (have ‘Int128 {aka struct Int128}’ and ‘hwaddr {aka long long unsigned int}’)
>          try_unmap = !((iova & pgmask) || (llsize & pgmask));
>                                                   ^
> Clearly llsize needs to be wrapped in int128_get64() here.  Should I
> presume that testing of this patch is equally lacking? 

No.

I do not know how but this definitely compiles for me with these:

gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-16)
gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)

I always thought Int128 is a struct but it turns out there are __uint128_t
and __int128_t and everywhere I compile (including x86_64 laptop) there is
CONFIG_INT128=y in config-host.mak, hence no error.

I can see that you fixed it (thanks for that!) but how do you compile it to
get this error? There is no way to disable gcc's types and even 4.8.5 can
do these. Thanks,



> Eric, have you
> done any testing of this?  I think this was fixing a mapping issue you
> reported.  Thanks,
> 
> Alex
> 


-- 
Alexey
