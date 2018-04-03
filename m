Received: from eggs.gnu.org ([2001:4830:134:3::10]:38851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1f3Cex-0001WY-FG
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 23:31:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1f3Cet-0000mR-EF
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 23:30:59 -0400
Received: from mail-pl0-x236.google.com ([2607:f8b0:400e:c01::236]:33881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1f3Cet-0000ln-3Y
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 23:30:55 -0400
Received: by mail-pl0-x236.google.com with SMTP id u11-v6so7049217plq.1
	for <qemu-devel@nongnu.org>; Mon, 02 Apr 2018 20:30:54 -0700 (PDT)
References: <20180322081837.21460-1-aik@ozlabs.ru>
	<6975e05c-da7a-5a96-4fb5-1234694136d0@redhat.com>
	<102833aa-9046-f4d7-0a66-71e67b89c78f@ozlabs.ru>
	<a77f5133-318c-c144-7ce2-fb264da0b246@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <ce1e88d5-b09b-40c1-8e51-67d40a20ec8e@ozlabs.ru>
Date: Tue, 3 Apr 2018 13:30:49 +1000
MIME-Version: 1.0
In-Reply-To: <a77f5133-318c-c144-7ce2-fb264da0b246@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] vfio: Print address space address
 when cannot map MMIO for DMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>

On 29/3/18 9:14 pm, Auger Eric wrote:
> Hi Alexey,
> On 29/03/18 03:55, Alexey Kardashevskiy wrote:
>> On 29/3/18 8:03 am, Auger Eric wrote:
>>> Hi Alexey, Alex,
>>> On 22/03/18 09:18, Alexey Kardashevskiy wrote:
>>>> The 567b5b309abe ("vfio/pci: Relax DMA map errors for MMIO regions") added
>>>> an error message if a passed memory section address or size is not aligned
>>>> to the minimal IOMMU page size. However although it checks
>>>> offset_within_address_space for the alignment, offset_within_region is
>>>> printed instead which makes it harder to find out what device caused
>>>> the message so this replaces offset_within_region with
>>>> offset_within_address_space.
>>>>
>>>> While we are here, this replaces '..' with 'size=' (as the second number
>>>> is a size, not an end offset) and adds a memory region name.
>>>>
>>>> Fixes: 567b5b309abe "vfio/pci: Relax DMA map errors for MMIO regions"
>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>> The patch indeed fixes the reported format issues.
>>>
>>> However I have some other concerns with the info that is reported to the
>>> end-user. See below.
>>>
>>> Assigning an e1000e device with a 64kB host, here are the traces I get:
>>>
>>> Region XXX is not aligned to 0x10000 and cannot be mapped for DMA
>>>
>>> "0004:01:00.0 BAR 3 mmaps[0]" 0x100a0050 size=0x3fb0
>>> "0004:01:00.0 BAR 3 mmaps[0]" 0x100a0050 size=0xffb0
>>> "0004:01:00.0 BAR 3 mmaps[0]" 0x100a0050 size=0x3fb0
>>> "0004:01:00.0 BAR 3 mmaps[0]" 0x100a0050 size=0xffb0
>>> "0004:01:00.0 BAR 3 mmaps[0]" 0x100a0050 size=0x3fb0
>>> "0004:01:00.0 BAR 3 mmaps[0]" 0x100a4808 size=0xb7f8
>>> "0004:01:00.0 BAR 3 mmaps[0]" 0x100e0050 size=0x3fb0
>>> "0004:01:00.0 BAR 3 mmaps[0]" 0x100e4808 size=0xb7f8
>>>
>>> It took me some time to understand what happens but here is now my
>>> understanding:
>>>
>>> 1) When looking at vfio_pci_write_config() pdev->io_regions[bar].addr =
>>> bar_addr in vfio_sub_page_bar_update_mapping() I see the following values:
>>>
>>> UNMAPPED -> 0x0 ->UNMAPPED -> 0x100a0000 -> UNMAPPED -> 0x100a0000 ->
>>> UNMAPPED -> 0x100e0000
>>>
>>> vfio_sub_page_bar_update_mapping() create mrs with base bar at
>>> 0x100a0000 and 0x100e0000 successively, hence the
>>> vfio_listener_region_add on 0x100axxxx. Indeed, 0x0-0x50 msix-table mmio
>>> region induces some memory section at 0x100a0050 and 0x100e50 successively.
>>>
>>> However this is confusing for the end-user who only has access to the
>>> final mapping (0x100e0000) through lspi [1].
>>
>>
>> The trace shows that at least at some point the BAR actually was
>> 0x100a0000, I find this info rather useful than confusing as it might
>> expose a bug of some sort, for example.
>>
>> The user also has access to the MR name which is the host PCI address + BAR
>> index, how is that confusing?
> 
> To me it is confusing since it does not match the final location of bar3
> as output by lspci. I couldn't understanding how 0x100axxxx related to bar3.


PCI resource reallocation is not that rate on PPC, at least, so I am kinda
used to it...



>>> 2) The changes in the size (0x3fb0 <-> 0xffb0) relate to the extension
>>> of the 16kB bar to 64kB in vfio_sub_page_bar_update_mapping
>>>> 3) Also it happens that I have a virtio-scsi-pci device that is put just
>>> after the BAR3 at 0x100a4000 and 0x100e4000 successively. The device has
>>
>> e1000e gets aligned to 64k but this one avoids the alignment for some reason?
> 
> Yes I will enquire about the allocation policy
>>
>>
>>> its own msi-table and pba mmio regions[2]. As mmaps[0] is extended to
>>> 64kB (with prio 0), we have those MMIO regions which result in new
>>> memory sections, which cause vfio_listener_region_add calls. This
>>> typically explains why we get a warning on 0x100e4808 (0xb7f8). By the
>>> way I don't get why we don't have a trace for "0004:01:00.0 BAR 3
>>> mmaps[0]" 0x100e4040 size=0x7c0, ie. mmaps[0] space between
>>> virtio-scsi-pci msic-table and pba.
>>
>>
>> "info mtree -f" might give a hint how MRs got resolved, could it end up
>> being emulated (==skipped by the vfio listener)?
> 
> Actually that's what is strange as I can see it in info mtree -f output. See at the end of the mail.

Hm. Looks strange. Would be nice to know why...


>>> So at the end of the day, my fear is all those info become really
>>> frightening and confusing for the end-user and even not relevant
>>> (0x100a0000 stuff). So I would rather simply remove the trace in 2.12
>>> until we find a place where we could generate a clear hint for the
>>> end-user, suggesting to relocate the msix bar.
>>>
>>> Thoughts?
>>
>> Please post complete "lspci -v" output for both pci devices and "info mtree
>> -f" (in addition to "info mtree", not instead).
> 
> see at the end
>>
>> In general, the error_report() could be removed as we did not have any
>> indication of not mapping before so we do not have to start now, I am just
>> missing the point here - the message exposes potentially not-working P2P
>> which is useful for people who care about that and do not know if actually
>> might work. Rather than silencing it, I'd convert it into the trace point.
> 
> But typically output that
> Region "0004:01:00.0 BAR 3 mmaps[0]" 0x100a0050 size=0x3fb0 cannot be DMA mapped
> is not strictly correct (by chance it was not re-allocated to something else, right?)


I get the point that it might be confusing and not matching "lspci -vb" but
still - what is not correct about it? At the time when the message
appeared, BAR was 0x100a0000.



-- 
Alexey
