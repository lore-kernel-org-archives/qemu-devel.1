Received: from eggs.gnu.org ([2001:4830:134:3::10]:53573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fLCXs-0003mZ-EI
	for qemu-devel@nongnu.org; Tue, 22 May 2018 15:02:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fLCXo-0003wZ-G7
	for qemu-devel@nongnu.org; Tue, 22 May 2018 15:02:04 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:39701)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fLCXo-0003wP-5f
	for qemu-devel@nongnu.org; Tue, 22 May 2018 15:02:00 -0400
Received: by mail-wm0-x244.google.com with SMTP id f8-v6so2614474wmc.4
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 12:01:59 -0700 (PDT)
References: <1526801333-30613-1-git-send-email-whois.zihan.yang@gmail.com>
	<1526801333-30613-4-git-send-email-whois.zihan.yang@gmail.com>
	<ef3fc85d-7726-c888-e8ca-9dfae1b908d3@gmail.com>
	<17a3765f-b835-2d45-e8b9-ffd4aff909f9@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <cbdfe0d6-f071-3560-009d-3bbdde12b33c@gmail.com>
Date: Tue, 22 May 2018 22:01:56 +0300
MIME-Version: 1.0
In-Reply-To: <17a3765f-b835-2d45-e8b9-ffd4aff909f9@redhat.com>
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
To: Laszlo Ersek <lersek@redhat.com>, Zihan Yang <whois.zihan.yang@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Alex Williamson <alex.williamson@redhat.com>

Hi Laszlo,

On 05/22/2018 12:52 PM, Laszlo Ersek wrote:
> On 05/21/18 13:53, Marcel Apfelbaum wrote:
>>
>> On 05/20/2018 10:28 AM, Zihan Yang wrote:
>>> Currently only q35 host bridge us allocated space in MCFG table. To
>>> put pxb host
>>> into sepratate pci domain, each of them should have its own
>>> configuration space
>>> int MCFG table
>>>
>>> Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
>>> ---
>>>    hw/i386/acpi-build.c | 83
>>> +++++++++++++++++++++++++++++++++++++++-------------
>>>    1 file changed, 62 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>>> index 9bc6d97..808d815 100644
>>> --- a/hw/i386/acpi-build.c
>>> +++ b/hw/i386/acpi-build.c
>>> @@ -89,6 +89,7 @@
>>>    typedef struct AcpiMcfgInfo {
>>>        uint64_t mcfg_base;
>>>        uint32_t mcfg_size;
>>> +    struct AcpiMcfgInfo *next;
>>>    } AcpiMcfgInfo;
>>>      typedef struct AcpiPmInfo {
>>> @@ -2427,14 +2428,15 @@ build_mcfg_q35(GArray *table_data, BIOSLinker
>>> *linker, AcpiMcfgInfo *info)
>>>    {
>>>        AcpiTableMcfg *mcfg;
>>>        const char *sig;
>>> -    int len = sizeof(*mcfg) + 1 * sizeof(mcfg->allocation[0]);
>>> +    int len, count = 0;
>>> +    AcpiMcfgInfo *cfg = info;
>>>    +    while (cfg) {
>>> +        ++count;
>>> +        cfg = cfg->next;
>>> +    }
>>> +    len = sizeof(*mcfg) + count * sizeof(mcfg->allocation[0]);
>>>        mcfg = acpi_data_push(table_data, len);
>>> -    mcfg->allocation[0].address = cpu_to_le64(info->mcfg_base);
>>> -    /* Only a single allocation so no need to play with segments */
>>> -    mcfg->allocation[0].pci_segment = cpu_to_le16(0);
>>> -    mcfg->allocation[0].start_bus_number = 0;
>>> -    mcfg->allocation[0].end_bus_number =
>>> PCIE_MMCFG_BUS(info->mcfg_size - 1);
>>>          /* MCFG is used for ECAM which can be enabled or disabled by
>>> guest.
>>>         * To avoid table size changes (which create migration issues),
>>> @@ -2448,6 +2450,17 @@ build_mcfg_q35(GArray *table_data, BIOSLinker
>>> *linker, AcpiMcfgInfo *info)
>>>        } else {
>>>            sig = "MCFG";
>>>        }
>>> +
>>> +    count = 0;
>>> +    while (info) {
>>> +        mcfg[count].allocation[0].address =
>>> cpu_to_le64(info->mcfg_base);
>>> +        /* Only a single allocation so no need to play with segments */
>>> +        mcfg[count].allocation[0].pci_segment = cpu_to_le16(count);
>>> +        mcfg[count].allocation[0].start_bus_number = 0;
>>> +        mcfg[count++].allocation[0].end_bus_number =
>>> PCIE_MMCFG_BUS(info->mcfg_size - 1);
>> An interesting point is if we want to limit the MMFCG size for PXBs, as
>> we may not be
>> interested to use all the buses in a specific domain. For each bus we
>> require some
>> address space that remains unused.
>>
>>> +        info = info->next;
>>> +    }
>>> +
>>>        build_header(linker, table_data, (void *)mcfg, sig, len, 1,
>>> NULL, NULL);
>>>    }
>>>    @@ -2602,26 +2615,52 @@ struct AcpiBuildState {
>>>        MemoryRegion *linker_mr;
>>>    } AcpiBuildState;
>>>    -static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
>>> +static inline void cleanup_mcfg(AcpiMcfgInfo *mcfg)
>>> +{
>>> +    AcpiMcfgInfo *tmp;
>>> +    while (mcfg) {
>>> +        tmp = mcfg->next;
>>> +        g_free(mcfg);
>>> +        mcfg = tmp;
>>> +    }
>>> +}
>>> +
>>> +static AcpiMcfgInfo *acpi_get_mcfg(void)
>>>    {
>>>        Object *pci_host;
>>>        QObject *o;
>>> +    AcpiMcfgInfo *head = NULL, *tail, *mcfg;
>>>          pci_host = acpi_get_i386_pci_host();
>>>        g_assert(pci_host);
>>>    -    o = object_property_get_qobject(pci_host, PCIE_HOST_MCFG_BASE,
>>> NULL);
>>> -    if (!o) {
>>> -        return false;
>>> +    while (pci_host) {
>>> +        mcfg = g_new0(AcpiMcfgInfo, 1);
>>> +        mcfg->next = NULL;
>>> +        if (!head) {
>>> +            tail = head = mcfg;
>>> +        } else {
>>> +            tail->next = mcfg;
>>> +            tail = mcfg;
>>> +        }
>>> +
>>> +        o = object_property_get_qobject(pci_host,
>>> PCIE_HOST_MCFG_BASE, NULL);
>>> +        if (!o) {
>>> +            cleanup_mcfg(head);
>>> +            g_free(mcfg);
>>> +            return NULL;
>>> +        }
>>> +        mcfg->mcfg_base = qnum_get_uint(qobject_to(QNum, o));
>>> +        qobject_unref(o);
>>> +
>>> +        o = object_property_get_qobject(pci_host,
>>> PCIE_HOST_MCFG_SIZE, NULL);
>> I'll let Igor to comment on the APCI bits, but the idea of querying each
>> PCI host
>> for the MMFCG details and put it into a different table sounds good to me.
>>
>> [Adding Laszlo for his insights]
> Thanks for the CC -- I don't have many (positive) insights here to
> offer, I'm afraid. First, the patch set (including the blurb) doesn't
> seem to explain *why* multiple host bridges / ECAM areas are a good
> idea.

The issue we want to solve is the hard limitation of 256 PCIe devices
that can be used in a Q35 machine. We can use "PCI functions" to increase
the number, but then we loose the hot-plugging granularity.

Currently pxb-pcie host bridges share the same PCI domain (0)
bus numbers, so adding more of them will not result in more usable
devices (each PCIe device resides on its own bus),
but putting each of them on a different domain removes
that limitation.

Another possible use (there is a good chance I am wrong, adding Alex to 
correct me),
may be the "modeling" of a multi-function assigned device.
Currently all the functions of an assigneddevice will be placed on 
different PCIe
Root Ports "loosing" the connection between them.

However, if we put all the functions of the same assigned device in the same
PCI domain we may be able to "re-connect" them.

>   Second, supporting such would take very intrusive patches / large
> feature development for OVMF (and that's not just for OvmfPkg and
> ArmVirtPkg platform code, but also core MdeModulePkg code).
>
> Obviously I'm not saying this feature should not be implemented for QEMU
> + SeaBIOS, just that don't expect edk2 support for it anytime soon.
> Without a convincing use case, even the review impact seems hard to justify.

I understand, thank you for the feedback, the point was to be sure
we don't decide something that *can't be done* in OVMF.

Thanks,
Marcel

> Thanks,
> Laszlo
