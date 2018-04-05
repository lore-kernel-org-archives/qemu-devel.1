Received: from eggs.gnu.org ([2001:4830:134:3::10]:52622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1f3yFs-0003AT-91
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 02:20:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1f3yFp-00063r-0w
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 02:20:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52534 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1f3yFo-00063H-Ri
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 02:20:12 -0400
References: <1522873850-28733-1-git-send-email-eric.auger@redhat.com>
	<20180404170950.54eb7975@w520.home>
	<beaf3c80-767c-9fcf-2cc3-09a294d77c0c@ozlabs.ru>
	<20180404201706.22af4643@t450s.home>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <b52706c7-b2e7-0841-72e4-f84569a509ca@redhat.com>
Date: Thu, 5 Apr 2018 08:20:01 +0200
MIME-Version: 1.0
In-Reply-To: <20180404201706.22af4643@t450s.home>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for 2.12] vfio: Use a trace point when a
 RAM section cannot be DMA mapped
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, eric.auger.pro@gmail.com

Hi,

On 05/04/18 04:17, Alex Williamson wrote:
> On Thu, 5 Apr 2018 10:53:38 +1000
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
>> On 5/4/18 9:09 am, Alex Williamson wrote:
>>> On Wed,  4 Apr 2018 22:30:50 +0200
>>> Eric Auger <eric.auger@redhat.com> wrote:
>>>   
>>>> The 567b5b309abe ("vfio/pci: Relax DMA map errors for MMIO regions")
>>>> added an error message if a passed memory section address or size
>>>> is not aligned to the page size and thus cannot be DMA mapped.
>>>>
>>>> This patch fixes the trace by printing the region name and the
>>>> memory region section offset within the address space (instead of
>>>> offset_within_region).
>>>>
>>>> We also turn the error_report into a trace event. Indeed, In some
>>>> cases, the traces can be confusing to non expert end-users and
>>>> let think the use case does not work (whereas it
>>>> works as before).
>>>>
>>>> This is the case where a BAR is successively mapped at different
>>>> GPAs and its sections are not compatible with dma map. The listener
>>>> is called several times and traces are issued for each intermediate
>>>> mapping.  The end-user cannot easily match those GPAs against the
>>>> final GPA output by lscpi. So let's keep those information to
>>>> informed users. In mid term, the plan is to advise the user about
>>>> BAR relocation relevance.
>>>>
>>>> Fixes: 567b5b309abe "vfio/pci: Relax DMA map errors for MMIO regions"
>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>
>>>> ---
>>>>
>>>> v1 -> v2:
>>>> - use a trace point
>>>> - add some details in the commit message  
>>>
>>> I think this is v2 with v1 being
>>> Message-Id:<20180322081837.21460-1-aik@ozlabs.ru> but this is
>>> substantially different from Alexey's posting so I'd like to verify the
>>> Sign-off.  Alexey?  
>>
>> My understanding it is not "sign-off" any more (I am fine either way, it
>> just does not seem fully correct), but
>>
>> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> Yep, I think Eric was intending to give you credit since this patch
> builds on your patch.  I'll include the R-b.
Yes this was my intent, sorry for the confusion. I was eager to get this
for 2.12, hence this follow-up.

Thanks

Eric
> 
> There's still work to do, I'd like to see a single, concise message as
> we're parsing the device, but there's no benefit in alarming users when
> nothing has changed and it's too late into the release cycle to do more
> than just silence this for now.  Patches welcome towards a better
> solution, to be considered for 2.13.  Thanks,
> 
> Alex
> 
>>>
>>> I agree that this seems to be the right thing to do for 2.12, nothing
>>> has changed for these mappings and the error reports are difficult even
>>> for experts to decipher and explain to users.  Thanks,
>>>
>>> Alex
>>>   
>>>> ---
>>>>  hw/vfio/common.c     | 11 +++++------
>>>>  hw/vfio/trace-events |  1 +
>>>>  2 files changed, 6 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>>> index 5e84716..07ffa0b 100644
>>>> --- a/hw/vfio/common.c
>>>> +++ b/hw/vfio/common.c
>>>> @@ -548,12 +548,11 @@ static void vfio_listener_region_add(MemoryListener *listener,
>>>>          hwaddr pgmask = (1ULL << ctz64(hostwin->iova_pgsizes)) - 1;
>>>>  
>>>>          if ((iova & pgmask) || (int128_get64(llsize) & pgmask)) {
>>>> -            error_report("Region 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx
>>>> -                         " is not aligned to 0x%"HWADDR_PRIx
>>>> -                         " and cannot be mapped for DMA",
>>>> -                         section->offset_within_region,
>>>> -                         int128_getlo(section->size),
>>>> -                         pgmask + 1);
>>>> +            trace_vfio_listener_region_add_no_dma_map(
>>>> +                memory_region_name(section->mr),
>>>> +                section->offset_within_address_space,
>>>> +                int128_getlo(section->size),
>>>> +                pgmask + 1);
>>>>              return;
>>>>          }
>>>>      }
>>>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>>>> index 79f63a2..20109cb 100644
>>>> --- a/hw/vfio/trace-events
>>>> +++ b/hw/vfio/trace-events
>>>> @@ -90,6 +90,7 @@ vfio_iommu_map_notify(const char *op, uint64_t iova_start, uint64_t iova_end) "i
>>>>  vfio_listener_region_add_skip(uint64_t start, uint64_t end) "SKIPPING region_add 0x%"PRIx64" - 0x%"PRIx64
>>>>  vfio_listener_region_add_iommu(uint64_t start, uint64_t end) "region_add [iommu] 0x%"PRIx64" - 0x%"PRIx64
>>>>  vfio_listener_region_add_ram(uint64_t iova_start, uint64_t iova_end, void *vaddr) "region_add [ram] 0x%"PRIx64" - 0x%"PRIx64" [%p]"
>>>> +vfio_listener_region_add_no_dma_map(const char *name, uint64_t iova, uint64_t size, uint64_t page_size) "Region \"%s\" 0x%"PRIx64" size=0x%"PRIx64" is not aligned to 0x%"PRIx64" and cannot be mapped for DMA"
>>>>  vfio_listener_region_del_skip(uint64_t start, uint64_t end) "SKIPPING region_del 0x%"PRIx64" - 0x%"PRIx64
>>>>  vfio_listener_region_del(uint64_t start, uint64_t end) "region_del 0x%"PRIx64" - 0x%"PRIx64
>>>>  vfio_disconnect_container(int fd) "close container->fd=%d"  
>>>   
>>
>>
> 
> 
