Received: from eggs.gnu.org ([2001:4830:134:3::10]:38023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gXSSs-0000g8-9I
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:59:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gXSSr-00057i-01
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:59:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gXSSq-00055b-GY
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:59:48 -0500
Date: Thu, 13 Dec 2018 15:59:31 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181213155931.1f576e55@redhat.com>
In-Reply-To: <7e959e03-b914-474f-7d99-4c170816bcaa@redhat.com>
References: <20181212092821.18260-1-david@redhat.com>
	<20181212092821.18260-3-david@redhat.com>
	<20181213132850.2b79d12f@redhat.com>
	<0ba15f35-4827-f6f9-7a62-94a13027c727@redhat.com>
	<20181213154838.5c7af97a@redhat.com>
	<7e959e03-b914-474f-7d99-4c170816bcaa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 2/2] memory-device: rewrite address
 assignment using ranges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, 13 Dec 2018 15:54:47 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 13.12.18 15:48, Igor Mammedov wrote:
> > On Thu, 13 Dec 2018 13:35:28 +0100
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> On 13.12.18 13:28, Igor Mammedov wrote:  
> >>> On Wed, 12 Dec 2018 10:28:21 +0100
> >>> David Hildenbrand <david@redhat.com> wrote:
> >>>     
> >>>> Let's rewrite it properly using ranges. This fixes certain overflows that
> >>>> are right now possible. E.g.
> >>>>
> >>>> qemu-system-x86_64 -m 4G,slots=20,maxmem=40G -M pc \
> >>>>     -object memory-backend-file,id=mem1,share,mem-path=/dev/zero,size=2G
> >>>>     -device pc-dimm,memdev=mem1,id=dimm1,addr=-0x40000000
> >>>>
> >>>> Now properly errors out instead of succeeding. (Note that qapi
> >>>> parsing of huge uint64_t values is broken and fixes are on the way)
> >>>>
> >>>> "can't add memory device [0xffffffffa0000000:0x80000000], usable range for
> >>>> memory devices [0x140000000:0xe00000000]"
> >>>>
> >>>> Signed-off-by: David Hildenbrand <david@redhat.com>
> >>>> ---
> >>>>  hw/mem/memory-device.c | 54 ++++++++++++++++++++++++------------------
> >>>>  1 file changed, 31 insertions(+), 23 deletions(-)
> >>>>
> >>>> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
> >>>> index 8be63c8032..28e871f562 100644
> >>>> --- a/hw/mem/memory-device.c
> >>>> +++ b/hw/mem/memory-device.c
> >>>> @@ -100,9 +100,8 @@ static uint64_t memory_device_get_free_addr(MachineState *ms,
> >>>>                                              uint64_t align, uint64_t size,
> >>>>                                              Error **errp)
> >>>>  {
> >>>> -    uint64_t address_space_start, address_space_end;
> >>>>      GSList *list = NULL, *item;
> >>>> -    uint64_t new_addr = 0;
> >>>> +    Range as, new = range_empty;
> >>>>  
> >>>>      if (!ms->device_memory) {
> >>>>          error_setg(errp, "memory devices (e.g. for memory hotplug) are not "
> >>>> @@ -115,13 +114,11 @@ static uint64_t memory_device_get_free_addr(MachineState *ms,
> >>>>                           "enabled, please specify the maxmem option");
> >>>>          return 0;
> >>>>      }
> >>>> -    address_space_start = ms->device_memory->base;
> >>>> -    address_space_end = address_space_start +
> >>>> -                        memory_region_size(&ms->device_memory->mr);
> >>>> -    g_assert(address_space_end >= address_space_start);
> >>>> +    range_init_nofail(&as, ms->device_memory->base,
> >>>> +                      memory_region_size(&ms->device_memory->mr));
> >>>>  
> >>>> -    /* address_space_start indicates the maximum alignment we expect */
> >>>> -    if (!QEMU_IS_ALIGNED(address_space_start, align)) {
> >>>> +    /* start of address space indicates the maximum alignment we expect */
> >>>> +    if (!QEMU_IS_ALIGNED(range_lob(&as), align)) {
> >>>>          error_setg(errp, "the alignment (0x%" PRIx64 ") is not supported",
> >>>>                     align);
> >>>>          return 0;
> >>>> @@ -145,20 +142,25 @@ static uint64_t memory_device_get_free_addr(MachineState *ms,
> >>>>      }
> >>>>  
> >>>>      if (hint) {
> >>>> -        new_addr = *hint;
> >>>> -        if (new_addr < address_space_start) {
> >>>> +        if (range_init(&new, *hint, size)) {
> >>>>              error_setg(errp, "can't add memory device [0x%" PRIx64 ":0x%" PRIx64
> >>>> -                       "] before 0x%" PRIx64, new_addr, size,
> >>>> -                       address_space_start);
> >>>> +                       "], usable range for memory devices [0x%" PRIx64 ":0x%"
> >>>> +                       PRIx64 "]", *hint, size, range_lob(&as),
> >>>> +                       range_size(&as));    
> >>> this changes error message to be the same as the next one and looses 'before' meaning
> >>> so if you'd like to have the same error message, then prbably merging both branches would be better.    
> >>
> >> I can do that, but I'll have to refer to "*hint" and "size" then instead
> >> of range_lob(&new) and range_size(&new), because the range might not be
> >> initialized.  
> > either that or better make errors different to avoid confusion.
> >   
> 
> Will see what turns out better. As we indicate the ranges the user can
> figure out what is going wrong.
ok

> 
> > [...]  
> >>>> -            new_addr = QEMU_ALIGN_UP(md_addr + md_size, align);
> >>>> +
> >>>> +            next_addr = QEMU_ALIGN_UP(range_upb(&tmp) + 1, align);
> >>>> +            if (!next_addr || range_init(&new, next_addr, range_size(&new))) {
> >>>> +                range_make_empty(&new);
> >>>> +                break;
> >>>> +            }
> >>>>          }
> >>>>      }
> >>>>  
> >>>> -    if (new_addr + size > address_space_end) {
> >>>> +    if (!range_contains_range(&as, &new)) {
> >>>>          error_setg(errp, "could not find position in guest address space for "
> >>>>                     "memory device - memory fragmented due to alignments");    
> >>> it could happen due to fragmentation but also in case remaining free space is no enough    
> >>
> >> That should be handled via memory_device_check_addable(), which is
> >> called at the beginning of the function. It checks for general size
> >> availability.  
> > 
> > I've meant
> >  AS_LOB                 AS_UPB
> >    100                   1000
> >  MEM1_LOB  MEM1_UPB
> >    100     900
> > then hotplugging MEM2 with size 200 would fail with this message,
> > which could be a bit confusing.
> > Maybe "not enough space to plug device of size %d" would be better?  
> 
> 
> That should be covered by memory_device_check_addable() if I am not wrong.
> 
> used_region_size + size > ms->maxram_size - ms->ram_size
> 
> For your example (if I don't mess up the numbers):
> 
> ms->maxram_size - ms->ram_size = 900
> used_region_size = 800
> 
> So trying to add anything > 100 will bail out.
Thanks, I see it now.

> 
> 
> >      
> >>
> >> Thanks!
> >>  
> >   
> 
> 
