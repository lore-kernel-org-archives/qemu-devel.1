Received: from eggs.gnu.org ([2001:4830:134:3::10]:47662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eRDGc-0002Wr-1n
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:28:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eRDGY-00052H-QP
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:28:50 -0500
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:46076)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eRDGY-00051t-F8
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:28:46 -0500
Received: by mail-it0-x241.google.com with SMTP id z6so1824300iti.4
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 00:28:46 -0800 (PST)
References: <20171218040852.13478.19208.stgit@gimli.home>
	<20171218050253.13478.49457.stgit@gimli.home>
	<b3cab6e2-eccf-990a-12ac-213512377cdf@ozlabs.ru>
	<20171218204007.5acb33fb@w520.home>
	<f4017df6-0fa4-9454-92b2-68918e051de0@ozlabs.ru>
	<20171218235610.3c985246@w520.home>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <166d9f28-f582-7f8b-e26b-db5ec266265d@ozlabs.ru>
Date: Tue, 19 Dec 2017 19:28:40 +1100
MIME-Version: 1.0
In-Reply-To: <20171218235610.3c985246@w520.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC/RFT PATCH 5/5] vfio/pci: Allow relocating
 MSI-X MMIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, eric.auger@redhat.com

On 19/12/17 17:56, Alex Williamson wrote:
> On Tue, 19 Dec 2017 17:02:59 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
>> On 19/12/17 14:40, Alex Williamson wrote:
>>> On Tue, 19 Dec 2017 14:07:13 +1100
>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>   
>>>> On 18/12/17 16:02, Alex Williamson wrote:  
>>>>> With recently proposed kernel side vfio-pci changes, the MSI-X vector
>>>>> table area can be mmap'd from userspace, allowing direct access to
>>>>> non-MSI-X registers within the host page size of this area.  However,
>>>>> we only get that direct access if QEMU isn't also emulating MSI-X
>>>>> within that same page.  For x86/64 host, the system page size is 4K
>>>>> and the PCI spec recommends a minimum of 4K to 8K alignment to
>>>>> separate MSI-X from non-MSI-X registers, therefore only devices which
>>>>> don't honor this recommendation would see any improvement from this
>>>>> option.  The real targets for this feature are hosts where the page
>>>>> size exceeds the PCI spec recommended alignment, such as ARM64 systems
>>>>> with 64K pages.
>>>>>
>>>>> This new x-msix-relocation option accepts the following options:
>>>>>
>>>>>   off: Disable MSI-X relocation, use native device config (default)
>>>>>   auto: Automaically relocate MSI-X MMIO to another BAR or offset
>>>>>        based on minimum additional MMIO requirement
>>>>>   bar0..bar5: Specify the target BAR, which will either be extended
>>>>>        if the BAR exists or added if the BAR slot is available.
>>>>>
>>>>> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>>>>> ---
>>>>>  hw/vfio/pci.c        |  102 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>  hw/vfio/pci.h        |    1 
>>>>>  hw/vfio/trace-events |    2 +
>>>>>  3 files changed, 104 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>>>> index c383b842da20..b4426abf297a 100644
>>>>> --- a/hw/vfio/pci.c
>>>>> +++ b/hw/vfio/pci.c
>>>>> @@ -1352,6 +1352,101 @@ static void vfio_pci_fixup_msix_region(VFIOPCIDevice *vdev)
>>>>>      }
>>>>>  }
>>>>>  
>>>>> +static void vfio_pci_relocate_msix(VFIOPCIDevice *vdev)
>>>>> +{
>>>>> +    int target_bar = -1;
>>>>> +    size_t msix_sz;
>>>>> +
>>>>> +    if (!vdev->msix || vdev->msix_relo == OFF_AUTOPCIBAR_OFF) {
>>>>> +        return;
>>>>> +    }
>>>>> +
>>>>> +    /* The actual minimum size of MSI-X structures */
>>>>> +    msix_sz = (vdev->msix->entries * PCI_MSIX_ENTRY_SIZE) +
>>>>> +              (QEMU_ALIGN_UP(vdev->msix->entries, 64) / 8);
>>>>> +    /* Round up to host pages, we don't want to share a page */
>>>>> +    msix_sz = REAL_HOST_PAGE_ALIGN(msix_sz);
>>>>> +    /* PCI BARs must be a power of 2 */
>>>>> +    msix_sz = pow2ceil(msix_sz);
>>>>> +
>>>>> +    /* Auto: pick the BAR that incurs the least additional MMIO space */
>>>>> +    if (vdev->msix_relo == OFF_AUTOPCIBAR_AUTO) {
>>>>> +        int i;
>>>>> +        size_t best = UINT64_MAX;
>>>>> +
>>>>> +        for (i = 0; i < PCI_ROM_SLOT; i++) {    
>>>>
>>>>
>>>> I belieive that going from the other end is safer approach for "auto",
>>>> especially after discovering how mpt3sas works. Or you could add
>>>> "autoreverse" switch...  
>>>
>>> Or is extending the smallest BAR really a safer option?  I wonder how
>>> many drivers go through and fill fixed sized arrays with BAR info,
>>> expecting only the device implemented number of BARs.  Maybe they
>>> wouldn't notice if the BAR was simply bigger than expected.  On the
>>> other hand there are probably drivers dumb enough to index registers
>>> from the end for the BAR as well.  I don't think there exists an
>>> auto algorithm that will fit every device, but a higher hit rate than
>>> we have so far would be nice.  
>>
>> Everything is possible :(
>>
>> I do not know if there are many users for this relocation though. So far
>> only one device has the problem (in 5 years or so) and it is fixed by
>> moving msix to bar5, I'd suggest start with this for now.
> 
> Interesting, I would have thought it to be more common.

Just to clarify - one device with performance issue because of msix
emulation, non-64k-aligned msix data is not that unusual.


> 
>> In general, I think we still need a way to simply disable that msix_table
>> region anyway if we find a device driver which uses all BARs, does not
>> tolerate changes to the default set of BARs, etc.
> 
> Only SPAPR can do that.  In fact, I'm somewhat surprised by your
> interest in this series as I positioned it as a way for other
> platforms, which require interaction with MSI-X MMIO space for
> programming interrupts.

Well, it moves the guest-visible msix section away from the BAR causing
performance issues so I figured it might work for SPAPR eventually :)


>>>  We could also implement MemoryRegionOps
>>> for the base BAR with some error reporting if it gets called.  That
>>> might make the problem more obvious than unassigned_mem_ops silently
>>> eating those accesses.  
>>
>> Makes sense.
>>
>>
>>>   
>>>>> +            size_t size;
>>>>> +
>>>>> +            if (vdev->bars[i].ioport) {
>>>>> +                continue;
>>>>> +            }
>>>>> +
>>>>> +            /* MSI-X MMIO must reside within first 32bit offset of BAR */
>>>>> +            if (vdev->bars[i].size > (UINT32_MAX / 2))  
>>>
>>> Adding a '|| !vdev->bars[i].size' here would make auto only extend BARs.
>>>
>>> NB, the existing test here needs a bit of work too, 32bit BARs max out
>>> at 2G not 4G, so maybe we need separate tests here. >1G for 32bit
>>> BARs, >2G for 64bit BARs.  Hmm, do we have the option of promoting
>>> 32bit BARs to 64bit? It's all virtual addresses anyway, right.  We're
>>> in real trouble if were extending BARs where this is an issue though.   
>>
>> until you get a driver like this :)
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/rapidio/devices/tsi721.c?h=v4.15-rc4#n2782
> 
> Right, a diametric opposite of the SAS driver, verifying all the
> attributes it can of specific BARs rather than assuming the first BAR
> it finds must be the one to use.  Is it even worthwhile to try to have
> any automatic selection?  I suppose this driver is another point
> towards a reverse search rather than extended BAR.  Thanks,

Well, guessing like this may fail occasionally and simply allowing MSIX
mapping won't fail on SPAPR, I do not really know if it is going to be very
useful anywhere else than just SPAPR.

And I guess if we go the automatic selection path, than extending a BAR
does not have much benefit over using the last BAR because it seems quite
unlikely that a device 1) does not have any BARs unused and 2) none of BARs
is MSIX-only but if this is a case, I am not sure what guess would be safer.

I looked nearby, for example:

001e:80:00.2 Ethernet controller: Broadcom Corporation NetXtreme BCM5719
Gigabit Ethernet PCIe (rev 01)
Region 0: Memory at 3fc2c0250000 (64-bit, prefetchable) [size=64K]
Region 2: Memory at 3fc2c0240000 (64-bit, prefetchable) [size=64K]
Region 4: Memory at 3fc2c0230000 (64-bit, prefetchable) [size=64K]
Capabilities: [a0] MSI-X: Enable- Count=17 Masked-
        Vector table: BAR=4 offset=00000000
        PBA: BAR=4 offset=00000120

It is fully packed and it *seems* that BAR4 is MSIX only but who knows why
it is 64K - can be anything...


This one looks more convincing but still no guarantee:

0001:09:00.0 USB controller: Texas Instruments TUSB73x0 SuperSpeed USB 3.0
xHCI Host Controller (rev 02)
Region 0: Memory at 3fe080800000 (64-bit, non-prefetchable) [size=64K]
Region 2: Memory at 3fe080810000 (64-bit, non-prefetchable) [size=8K]
Capabilities: [c0] MSI-X: Enable+ Count=8 Masked-
        Vector table: BAR=2 offset=00000000
        PBA: BAR=2 offset=00001000



A funny thing - my thinkpad x1 does not have a single msix-capable device,
many are MSI and "Express (v2) Endpoint, MSI 00". Hmmm. Xeon and POWER8
boxes do have MSIX.


-- 
Alexey
