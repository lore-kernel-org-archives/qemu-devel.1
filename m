Received: from eggs.gnu.org ([2001:4830:134:3::10]:51359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dZJb5-0000f3-2E
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 12:19:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dZJb3-0005EW-IX
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 12:19:11 -0400
Received: from mail-pg0-x229.google.com ([2607:f8b0:400e:c05::229]:36882)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dZJb3-0005Dt-9w
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 12:19:09 -0400
Received: by mail-pg0-x229.google.com with SMTP id y129so47208918pgy.4
	for <qemu-devel@nongnu.org>; Sun, 23 Jul 2017 09:19:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8bf34bb0-bede-f1e4-2245-1a9572e73272@redhat.com>
References: <1500761743-1669-1-git-send-email-zuban32s@gmail.com>
	<1500761743-1669-5-git-send-email-zuban32s@gmail.com>
	<8bf34bb0-bede-f1e4-2245-1a9572e73272@redhat.com>
From: Alexander Bezzubikov <zuban32s@gmail.com>
Date: Sun, 23 Jul 2017 19:19:07 +0300
Message-ID: <CAKSfGUDWf+0DTk=9VuGAvMfa76vjpudYGN5QNinLb4_Q3ViOjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH v2 4/6] hw/pci: introduce bridge-only
 vendor-specific capability to provide some hints to firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, kraxel@redhat.com, seabios@seabios.org

2017-07-23 18:57 GMT+03:00 Marcel Apfelbaum <marcel@redhat.com>:

> On 23/07/2017 1:15, Aleksandr Bezzubikov wrote:
>
>> On PCI init PCI bridges may need some
>> extra info about bus number to reserve, IO, memory and
>> prefetchable memory limits. QEMU can provide this
>> with special vendor-specific PCI capability.
>>
>> Sizes of limits match ones from
>> PCI Type 1 Configuration Space Header,
>> number of buses to reserve occupies only 1 byte
>> since it is the size of Subordinate Bus Number register.
>>
>>
> Hi Alexandr,
>
> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
>> ---
>>   hw/pci/pci_bridge.c         | 27 +++++++++++++++++++++++++++
>>   include/hw/pci/pci_bridge.h | 18 ++++++++++++++++++
>>   2 files changed, 45 insertions(+)
>>
>> diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
>> index 720119b..8ec6c2c 100644
>> --- a/hw/pci/pci_bridge.c
>> +++ b/hw/pci/pci_bridge.c
>> @@ -408,6 +408,33 @@ void pci_bridge_map_irq(PCIBridge *br, const char*
>> bus_name,
>>       br->bus_name = bus_name;
>>   }
>>   +
>> +int pci_bridge_help_cap_init(PCIDevice *dev, int cap_offset,
>>
>
> Can you please rename to something like
> 'pci_bridge_qemu_cap_init' to be more specific?
>
> +                              uint8_t bus_reserve, uint32_t io_limit,
>> +                              uint16_t mem_limit, uint64_t pref_limit,
>>
>
>
> I am not sure regarding "limit" suffix, this
> is a reservation, not a limitation.


I'd like this fields names to match actual registers which
are going to get the values.


>
>
> +                              Error **errp)
>> +{
>> +    size_t cap_len = sizeof(PCIBridgeQemuCap);
>> +    PCIBridgeQemuCap cap;
>> +
>> +    cap.len = cap_len;
>> +    cap.bus_res = bus_reserve;
>> +    cap.io_lim = io_limit & 0xFF;
>> +    cap.io_lim_upper = io_limit >> 8 & 0xFFFF;
>> +    cap.mem_lim = mem_limit;
>> +    cap.pref_lim = pref_limit & 0xFFFF;
>> +    cap.pref_lim_upper = pref_limit >> 16 & 0xFFFFFFFF;
>> +
>> +    int offset = pci_add_capability(dev, PCI_CAP_ID_VNDR,
>> +                                    cap_offset, cap_len, errp);
>> +    if (offset < 0) {
>> +        return offset;
>> +    }
>> +
>> +    memcpy(dev->config + offset + 2, (char *)&cap + 2, cap_len - 2);
>> +    return 0;
>> +}
>> +
>>   static const TypeInfo pci_bridge_type_info = {
>>       .name = TYPE_PCI_BRIDGE,
>>       .parent = TYPE_PCI_DEVICE,
>> diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
>> index ff7cbaa..c9f642c 100644
>> --- a/include/hw/pci/pci_bridge.h
>> +++ b/include/hw/pci/pci_bridge.h
>> @@ -67,4 +67,22 @@ void pci_bridge_map_irq(PCIBridge *br, const char*
>> bus_name,
>>   #define  PCI_BRIDGE_CTL_DISCARD_STATUS        0x400   /* Discard timer
>> status */
>>   #define  PCI_BRIDGE_CTL_DISCARD_SERR  0x800   /* Discard timer SERR#
>> enable */
>>   +typedef struct PCIBridgeQemuCap {
>> +    uint8_t id;     /* Standard PCI capability header field */
>> +    uint8_t next;   /* Standard PCI capability header field */
>> +    uint8_t len;    /* Standard PCI vendor-specific capability header
>> field */
>> +    uint8_t bus_res;
>> +    uint32_t pref_lim_upper;
>> +    uint16_t pref_lim;
>> +    uint16_t mem_lim;
>>
>
> This 32bit IOMEM, right?
>
> +    uint16_t io_lim_upper;
>> +    uint8_t io_lim;
>>
>
> Why do we need io_lim and io_lim_upper?
>

The idea was to be able to directly move the capability fields values
to the registers when actually using it (in firmware) code.
Secondly, it saves a little space by avoding usage 32-bit types
when 24-bit ones are desired. And the same thing with prefetchable (48->64).
But if it's more convenient no to split this value, I can do that.



>
> Thanks,
> Marcel
>
>
> +    uint8_t padding;
>> +} PCIBridgeQemuCap;
>> +
>> +int pci_bridge_help_cap_init(PCIDevice *dev, int cap_offset,
>> +                              uint8_t bus_reserve, uint32_t io_limit,
>> +                              uint16_t mem_limit, uint64_t pref_limit,
>> +                              Error **errp);
>> +
>>   #endif /* QEMU_PCI_BRIDGE_H */
>>
>>
>


-- 
Alexander Bezzubikov
