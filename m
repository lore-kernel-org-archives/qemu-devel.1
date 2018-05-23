Received: from eggs.gnu.org ([2001:4830:134:3::10]:60231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fLX89-0005S0-GM
	for qemu-devel@nongnu.org; Wed, 23 May 2018 13:00:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fLX86-0001Af-98
	for qemu-devel@nongnu.org; Wed, 23 May 2018 13:00:53 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fLX85-0001AX-Us
	for qemu-devel@nongnu.org; Wed, 23 May 2018 13:00:50 -0400
Received: by mail-wm0-x244.google.com with SMTP id n10-v6so11131223wmc.1
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 10:00:49 -0700 (PDT)
References: <1526801333-30613-1-git-send-email-whois.zihan.yang@gmail.com>
	<1526801333-30613-4-git-send-email-whois.zihan.yang@gmail.com>
	<ef3fc85d-7726-c888-e8ca-9dfae1b908d3@gmail.com>
	<17a3765f-b835-2d45-e8b9-ffd4aff909f9@redhat.com>
	<cbdfe0d6-f071-3560-009d-3bbdde12b33c@gmail.com>
	<f71a8c61-a0d7-6ebc-62ad-3dab8b9f8e5a@redhat.com>
	<20180522151732.36122156@w520.home>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <e3f4ec71-98d2-1a82-cf8d-502bac431bc4@gmail.com>
Date: Wed, 23 May 2018 20:00:45 +0300
MIME-Version: 1.0
In-Reply-To: <20180522151732.36122156@w520.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [RFC 3/3] acpi-build: allocate mcfg for multiple
 host bridges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: Zihan Yang <whois.zihan.yang@gmail.com>, qemu-devel@nongnu.org, Wei Huang <wei@redhat.com>, Drew Jones <drjones@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eric Auger <eauger@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Hi Alex,

On 05/23/2018 12:17 AM, Alex Williamson wrote:
> On Tue, 22 May 2018 21:51:47 +0200
> Laszlo Ersek <lersek@redhat.com> wrote:
>
>> On 05/22/18 21:01, Marcel Apfelbaum wrote:
>>> Hi Laszlo,
>>>
>>> On 05/22/2018 12:52 PM, Laszlo Ersek wrote:
>>>> On 05/21/18 13:53, Marcel Apfelbaum wrote:
>>>>> On 05/20/2018 10:28 AM, Zihan Yang wrote:
>>>>>> Currently only q35 host bridge us allocated space in MCFG table. To
>>>>>> put pxb host
>>>>>> into sepratate pci domain, each of them should have its own
>>>>>> configuration space
>>>>>> int MCFG table
>>>>>>
>>>>>> Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
>>>>>> ---
>>>>>>     hw/i386/acpi-build.c | 83
>>>>>> +++++++++++++++++++++++++++++++++++++++-------------
>>>>>>     1 file changed, 62 insertions(+), 21 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>>>>>> index 9bc6d97..808d815 100644
>>>>>> --- a/hw/i386/acpi-build.c
>>>>>> +++ b/hw/i386/acpi-build.c
>>>>>> @@ -89,6 +89,7 @@
>>>>>>     typedef struct AcpiMcfgInfo {
>>>>>>         uint64_t mcfg_base;
>>>>>>         uint32_t mcfg_size;
>>>>>> +    struct AcpiMcfgInfo *next;
>>>>>>     } AcpiMcfgInfo;
>>>>>>       typedef struct AcpiPmInfo {
>>>>>> @@ -2427,14 +2428,15 @@ build_mcfg_q35(GArray *table_data, BIOSLinker
>>>>>> *linker, AcpiMcfgInfo *info)
>>>>>>     {
>>>>>>         AcpiTableMcfg *mcfg;
>>>>>>         const char *sig;
>>>>>> -    int len = sizeof(*mcfg) + 1 * sizeof(mcfg->allocation[0]);
>>>>>> +    int len, count = 0;
>>>>>> +    AcpiMcfgInfo *cfg = info;
>>>>>>     +    while (cfg) {
>>>>>> +        ++count;
>>>>>> +        cfg = cfg->next;
>>>>>> +    }
>>>>>> +    len = sizeof(*mcfg) + count * sizeof(mcfg->allocation[0]);
>>>>>>         mcfg = acpi_data_push(table_data, len);
>>>>>> -    mcfg->allocation[0].address = cpu_to_le64(info->mcfg_base);
>>>>>> -    /* Only a single allocation so no need to play with segments */
>>>>>> -    mcfg->allocation[0].pci_segment = cpu_to_le16(0);
>>>>>> -    mcfg->allocation[0].start_bus_number = 0;
>>>>>> -    mcfg->allocation[0].end_bus_number =
>>>>>> PCIE_MMCFG_BUS(info->mcfg_size - 1);
>>>>>>           /* MCFG is used for ECAM which can be enabled or disabled by
>>>>>> guest.
>>>>>>          * To avoid table size changes (which create migration issues),
>>>>>> @@ -2448,6 +2450,17 @@ build_mcfg_q35(GArray *table_data, BIOSLinker
>>>>>> *linker, AcpiMcfgInfo *info)
>>>>>>         } else {
>>>>>>             sig = "MCFG";
>>>>>>         }
>>>>>> +
>>>>>> +    count = 0;
>>>>>> +    while (info) {
>>>>>> +        mcfg[count].allocation[0].address =
>>>>>> cpu_to_le64(info->mcfg_base);
>>>>>> +        /* Only a single allocation so no need to play with
>>>>>> segments */
>>>>>> +        mcfg[count].allocation[0].pci_segment = cpu_to_le16(count);
>>>>>> +        mcfg[count].allocation[0].start_bus_number = 0;
>>>>>> +        mcfg[count++].allocation[0].end_bus_number =
>>>>>> PCIE_MMCFG_BUS(info->mcfg_size - 1);
>>>>> An interesting point is if we want to limit the MMFCG size for PXBs, as
>>>>> we may not be
>>>>> interested to use all the buses in a specific domain. For each bus we
>>>>> require some
>>>>> address space that remains unused.
>>>>>   
>>>>>> +        info = info->next;
>>>>>> +    }
>>>>>> +
>>>>>>         build_header(linker, table_data, (void *)mcfg, sig, len, 1,
>>>>>> NULL, NULL);
>>>>>>     }
>>>>>>     @@ -2602,26 +2615,52 @@ struct AcpiBuildState {
>>>>>>         MemoryRegion *linker_mr;
>>>>>>     } AcpiBuildState;
>>>>>>     -static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
>>>>>> +static inline void cleanup_mcfg(AcpiMcfgInfo *mcfg)
>>>>>> +{
>>>>>> +    AcpiMcfgInfo *tmp;
>>>>>> +    while (mcfg) {
>>>>>> +        tmp = mcfg->next;
>>>>>> +        g_free(mcfg);
>>>>>> +        mcfg = tmp;
>>>>>> +    }
>>>>>> +}
>>>>>> +
>>>>>> +static AcpiMcfgInfo *acpi_get_mcfg(void)
>>>>>>     {
>>>>>>         Object *pci_host;
>>>>>>         QObject *o;
>>>>>> +    AcpiMcfgInfo *head = NULL, *tail, *mcfg;
>>>>>>           pci_host = acpi_get_i386_pci_host();
>>>>>>         g_assert(pci_host);
>>>>>>     -    o = object_property_get_qobject(pci_host, PCIE_HOST_MCFG_BASE,
>>>>>> NULL);
>>>>>> -    if (!o) {
>>>>>> -        return false;
>>>>>> +    while (pci_host) {
>>>>>> +        mcfg = g_new0(AcpiMcfgInfo, 1);
>>>>>> +        mcfg->next = NULL;
>>>>>> +        if (!head) {
>>>>>> +            tail = head = mcfg;
>>>>>> +        } else {
>>>>>> +            tail->next = mcfg;
>>>>>> +            tail = mcfg;
>>>>>> +        }
>>>>>> +
>>>>>> +        o = object_property_get_qobject(pci_host,
>>>>>> PCIE_HOST_MCFG_BASE, NULL);
>>>>>> +        if (!o) {
>>>>>> +            cleanup_mcfg(head);
>>>>>> +            g_free(mcfg);
>>>>>> +            return NULL;
>>>>>> +        }
>>>>>> +        mcfg->mcfg_base = qnum_get_uint(qobject_to(QNum, o));
>>>>>> +        qobject_unref(o);
>>>>>> +
>>>>>> +        o = object_property_get_qobject(pci_host,
>>>>>> PCIE_HOST_MCFG_SIZE, NULL);
>>>>> I'll let Igor to comment on the APCI bits, but the idea of querying each
>>>>> PCI host
>>>>> for the MMFCG details and put it into a different table sounds good
>>>>> to me.
>>>>>
>>>>> [Adding Laszlo for his insights]
>>>> Thanks for the CC -- I don't have many (positive) insights here to
>>>> offer, I'm afraid. First, the patch set (including the blurb) doesn't
>>>> seem to explain *why* multiple host bridges / ECAM areas are a good
>>>> idea.
>>> The issue we want to solve is the hard limitation of 256 PCIe devices
>>> that can be used in a Q35 machine.
> Isn't it interesting that conventional PCI can easily support so many
> more devices?  Sorta makes you wonder why we care that virtual devices
> are express rather than conventional for a high density configuration...
>
>> Implying that there are use cases for which ~256 PCIe devices aren't
>> enough. I remain unconvinced until proved wrong :)
>>
>> Anyway, a significant source of waste comes from the restriction that we
>> can only put 1 device (with up to 8 functions) on each non-root-complex
>> PCI Express bus (such as root ports and downstream ports). This forfeits
>> a huge portion of the ECAM area (about 31/32th) that we already have.
>> Rather than spending more MMIO guest-phys address range on new
>> discontiguous ECAM ranges, I'd prefer if we could look into ARI. I seem
>> to recall from your earlier presentation that ARI could recover that
>> lost address space (meaning both ECAM ranges and PCIe B/D/F address space).
> How does ARI solve the hotplug problem?  ARI is effectively
> multifunction on steroids,

+1

>   the ARI capability in each function points
> to the next function number so that we don't need to scan the entire
> devfn address space per bus (an inefficiency we don't care about when
> there are only 8 function).  So yeah, we can fill an entire bus with
> devices with ARI, but they're all rooted at 00.0.
>   
>> There are signs that the edk2 core supports ARI if the underlying
>> platform supports it. (Which is not the case with multiple PCIe domains
>> / multiple ECAM ranges.)
> It's pretty surprising to me that edk2 wouldn't already have support
> for multiple PCIe domains, they're really not *that* uncommon.  Some
> architectures make almost gratuitous use of PCIe domains.  I certainly
> know there were UEFI ia64 platforms with multiple domains.
>
>> ARI support could also help aarch64/virt. Eric (CC'd) has been working
>> on raising the max PCIe bus count from *16* to 256 for aarch64/virt, and
>> AFAIR one of the challenges there has been finding a good spot for the
>> larger ECAM in guest-phys address space. Fiddling with such address maps
>> is always a pain.
>>
>> Back to x86, the guest-phys address space is quite crowded too. The
>> 32-bit PCI MMIO aperture (with the neighboring ECAM and platform MMIO
>> areas such as LAPIC, IO-APIC, HPET, TPM, pflash, ...) is always a scarce
>> resource. Plus, reaching agreement between OVMF and QEMU on the exact
>> location of the 32-bit PCI MMIO aperture has always been a huge pain; so
>> you'd likely shoot for 64-bit.
> Why do we need to equally split 32-bit MMIO space between domains?  Put
> it on domain 0 and require devices installed into non-zero domains have
> no 32-bit dependencies.
>
>> But 64-bit is ill-partitioned and/or crowded too: first you have the
>> cold-plugged >4GB DRAM (whose size the firmware can interrogate), then
>> the hotplug DIMM area up to "etc/reserved-memory-end" (ditto), then the
>> 64-bit PCI MMIO aperture (whose size the firmware decides itself,
>> because QEMU cannot be asked about it presently). Placing the additional
>> MMCFGs somewhere would need extending the total order between these
>> things at the design level, more fw_cfg files, more sanity checks in
>> platform code in the firmware, and, quite importantly, adding support to
>> multiple discontiguous MMCFGs to core edk2 code.
> Hmm, we're doing something wrong if we can't figure out some standards
> within QEMU for placing per domain 64-bit MMIO and MMCFG ranges.
>
>> I don't know much about ARI but it already looks a whole lot more
>> attractive to me.
>>
>>> We can use "PCI functions" to increase
>>> the number, but then we loose the hot-plugging granularity.
>>>
>>> Currently pxb-pcie host bridges share the same PCI domain (0)
>>> bus numbers, so adding more of them will not result in more usable
>>> devices (each PCIe device resides on its own bus),
>>> but putting each of them on a different domain removes
>>> that limitation.
>>>
>>> Another possible use (there is a good chance I am wrong, adding Alex to
>>> correct me),
>>> may be the "modeling" of a multi-function assigned device.
>>> Currently all the functions of an assigneddevice will be placed on
>>> different PCIe
>>> Root Ports "loosing" the connection between them.
>>>
>>> However, if we put all the functions of the same assigned device in the
>>> same
>>> PCI domain we may be able to "re-connect" them.
>> OK -- why is that useful? What's the current practical problem with the
>> splitting you describe?
> There are very few cases where this is useful, things like associating
> USB companion devices or translating a guest bus reset to host bus
> reset when functions are split to separate virtual buses.  That said, I
> have no idea how multiple domains plays a factor here.  Regardless of
> how many PCIe domains a VM supports, we can easily use existing
> multifunction within a single domain to expose multifunction assigned
> devices in a way that better resembles the physical hardware.
> Multifunction PCIe endpoints cannot span PCIe domains.

Sorry for the misunderstanding.  I was referring to the complete opposite.
We want to assign two functions of the same phys device to the same VM.
They will land on different PCIe Root Ports and we may have issues with
the data flow between them.

I was wondering if assigning them both to the same PCI domain (different 
from 0) will
help us avoid implementing the ACS for a PCIe Root Ports. But again, I 
may be way off here.

> In fact, IOMMUs generally cannot span domains either, so we better also
> be thinking about at least a VT-d DHRD or vIOMMU per PCIe domain.
>   

Right


Thanks,
Marcel


[...]
