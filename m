Received: from eggs.gnu.org ([2001:4830:134:3::10]:47480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dc7fz-0007BV-NL
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:11:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dc7fw-0000AO-BC
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:11:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dc7fw-00009F-1d
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:11:48 -0400
References: <1500761743-1669-1-git-send-email-zuban32s@gmail.com>
	<1500761743-1669-5-git-send-email-zuban32s@gmail.com>
	<20170726215625-mutt-send-email-mst@kernel.org>
	<CAKSfGUAh_rqGy8uNJXThH4v1z5zbPdLhkBx77Tui8PL-N-7JXw@mail.gmail.com>
	<20170727022103-mutt-send-email-mst@kernel.org>
	<f210b52b-b7ea-b27e-cca8-9f11a4b4f353@redhat.com>
	<20170729020945-mutt-send-email-mst@kernel.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <e182ae9b-f87c-c80b-e4b0-fa3ef4cab69d@redhat.com>
Date: Mon, 31 Jul 2017 13:06:23 +0300
MIME-Version: 1.0
In-Reply-To: <20170729020945-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alexander Bezzubikov <zuban32s@gmail.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, seabios@seabios.org

On 29/07/2017 2:12, Michael S. Tsirkin wrote:
> On Thu, Jul 27, 2017 at 12:39:54PM +0300, Marcel Apfelbaum wrote:
>> On 27/07/2017 2:28, Michael S. Tsirkin wrote:
>>> On Thu, Jul 27, 2017 at 12:54:07AM +0300, Alexander Bezzubikov wrote:
>>>> 2017-07-26 22:43 GMT+03:00 Michael S. Tsirkin <mst@redhat.com>:
>>>>> On Sun, Jul 23, 2017 at 01:15:41AM +0300, Aleksandr Bezzubikov wrote:
>>>>>> On PCI init PCI bridges may need some
>>>>>> extra info about bus number to reserve, IO, memory and
>>>>>> prefetchable memory limits. QEMU can provide this
>>>>>> with special
>>>>>
>>>>> with a special
>>>>>
>>>>>> vendor-specific PCI capability.
>>>>>>
>>>>>> Sizes of limits match ones from
>>>>>> PCI Type 1 Configuration Space Header,
>>>>>> number of buses to reserve occupies only 1 byte
>>>>>> since it is the size of Subordinate Bus Number register.
>>>>>>
>>>>>> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
>>>>>> ---
>>>>>>    hw/pci/pci_bridge.c         | 27 +++++++++++++++++++++++++++
>>>>>>    include/hw/pci/pci_bridge.h | 18 ++++++++++++++++++
>>>>>>    2 files changed, 45 insertions(+)
>>>>>>
>>>>>> diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
>>>>>> index 720119b..8ec6c2c 100644
>>>>>> --- a/hw/pci/pci_bridge.c
>>>>>> +++ b/hw/pci/pci_bridge.c
>>>>>> @@ -408,6 +408,33 @@ void pci_bridge_map_irq(PCIBridge *br, const char* bus_name,
>>>>>>        br->bus_name = bus_name;
>>>>>>    }
>>>>>>
>>>>>> +
>>>>>> +int pci_bridge_help_cap_init(PCIDevice *dev, int cap_offset,
>>>>>
>>>>> help? should be qemu_cap_init?
>>>>>
>>>>>> +                              uint8_t bus_reserve, uint32_t io_limit,
>>>>>> +                              uint16_t mem_limit, uint64_t pref_limit,
>>>>>> +                              Error **errp)
>>>>>> +{
>>>>>> +    size_t cap_len = sizeof(PCIBridgeQemuCap);
>>>>>> +    PCIBridgeQemuCap cap;
>>>>>
>>>>> This leaks info to guest. You want to init all fields here:
>>>>>
>>>>> cap = {
>>>>>    .len = ....
>>>>> };
>>>>
>>>> I surely can do this for len field, but as Laszlo proposed
>>>> we can use mutually exclusive fields,
>>>> e.g. pref_32 and pref_64, the only way I have left
>>>> is to use ternary operator (if we surely need this
>>>> big initializer). Keeping some if's would look better,
>>>> I think.
>>>>
>>>>>
>>>>>> +
>>>>>> +    cap.len = cap_len;
>>>>>> +    cap.bus_res = bus_reserve;
>>>>>> +    cap.io_lim = io_limit & 0xFF;
>>>>>> +    cap.io_lim_upper = io_limit >> 8 & 0xFFFF;
>>>>>> +    cap.mem_lim = mem_limit;
>>>>>> +    cap.pref_lim = pref_limit & 0xFFFF;
>>>>>> +    cap.pref_lim_upper = pref_limit >> 16 & 0xFFFFFFFF;
>>>>>
>>>>> Please use pci_set_word etc or cpu_to_leXX.
>>>>>
>>>>
>>>> Since now we've decided to avoid fields separation into <field> + <field_upper>,
>>>> this bitmask along with pci_set_word are no longer needed.
>>>>
>>>>> I think it's easiest to replace struct with a set of macros then
>>>>> pci_set_word does the work for you.
>>>>>
>>>>
>>>> I don't really want to use macros here because structure
>>>> show us the whole capability layout and this can
>>>> decrease documenting efforts. More than that,
>>>> memcpy usage is very convenient here, and I wouldn't like
>>>> to lose it.
>>>>
>>>>>
>>>>>> +
>>>>>> +    int offset = pci_add_capability(dev, PCI_CAP_ID_VNDR,
>>>>>> +                                    cap_offset, cap_len, errp);
>>>>>> +    if (offset < 0) {
>>>>>> +        return offset;
>>>>>> +    }
>>>>>> +
>>>>>> +    memcpy(dev->config + offset + 2, (char *)&cap + 2, cap_len - 2);
>>>>>
>>>>> +2 is yacky. See how virtio does it:
>>>>>
>>>>>       memcpy(dev->config + offset + PCI_CAP_FLAGS, &cap->cap_len,
>>>>>              cap->cap_len - PCI_CAP_FLAGS);
>>>>>
>>>>>
>>>>
>>>> OK.
>>>>
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>>    static const TypeInfo pci_bridge_type_info = {
>>>>>>        .name = TYPE_PCI_BRIDGE,
>>>>>>        .parent = TYPE_PCI_DEVICE,
>>>>>> diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
>>>>>> index ff7cbaa..c9f642c 100644
>>>>>> --- a/include/hw/pci/pci_bridge.h
>>>>>> +++ b/include/hw/pci/pci_bridge.h
>>>>>> @@ -67,4 +67,22 @@ void pci_bridge_map_irq(PCIBridge *br, const char* bus_name,
>>>>>>    #define  PCI_BRIDGE_CTL_DISCARD_STATUS       0x400   /* Discard timer status */
>>>>>>    #define  PCI_BRIDGE_CTL_DISCARD_SERR 0x800   /* Discard timer SERR# enable */
>>>>>>
>>>>>> +typedef struct PCIBridgeQemuCap {
>>>>>> +    uint8_t id;     /* Standard PCI capability header field */
>>>>>> +    uint8_t next;   /* Standard PCI capability header field */
>>>>>> +    uint8_t len;    /* Standard PCI vendor-specific capability header field */
>>>>>> +    uint8_t bus_res;
>>>>>> +    uint32_t pref_lim_upper;
>>>>>
>>>>> Big endian? Ugh.
>>>>>
>>>>
>>>> Agreed, and this's gonna to disappear with
>>>> the new layout.
>>>>
>>>>>> +    uint16_t pref_lim;
>>>>>> +    uint16_t mem_lim;
>>>>>
>>>>> I'd say we need 64 bit for memory.
>>>>>
>>>>
>>>> Why? Non-prefetchable MEMORY_LIMIT register is 16 bits long.
>>>
>>> Hmm ok, but e.g. for io there are bridges that have extra registers
>>> to specify non-standard non-aligned registers.
>>>
>>>>>> +    uint16_t io_lim_upper;
>>>>>> +    uint8_t io_lim;
>>>>>> +    uint8_t padding;
>>>>>
>>>>> IMHO each type should have a special "don't care" flag
>>>>> that would mean "I don't know".
>>>>>
>>>>>
>>>>
>>>> Don't know what? Now 0 is an indicator to do nothing with this field.
>>>
>>> In that case how do you say "don't allocate any memory"?
>>>
>>
>> We can keep the MEM/Limit registers read-only for such cases,
>> as they are optional registers.
>>
>> Thanks,
>> Marcel
>

Hi Michael,


> I don't believe they are - from the spec (1.2):
> 	The Memory Base and Memory Limit registers are both required registers
> 
> Rest of ranges are indeed optional.
> 


Oops, my mistake, I looked at prefetchable memory, sorry for the mix-up.
I wonder what would be the use case to disable IOMEM.

Anyway, we can have a "-1" default value giving the hint: do not reserve
anything, but in this case we should use it also for IO/prefetch mem.
The problem is, the guest OS can try to allocate IO space even if
the firmware didn't; Linux does it today.
Having IO-base/IO-limit registers read-only will solve the problem.

What am I getting at is we would have now 2 ways to solve the same
problem and the hint would be inferior.

I would use the hint to reserve a specific range and read only registers
to disable the range. IOMEM cannot be disabled in this way, but
should not bother us.

Thanks,
Marcel

> 
>>>
>>>>>> +} PCIBridgeQemuCap;
>>>>>
>>>>> You don't really need this struct in the header. And pls document all fields.
>>>>>
>>>>>> +
>>>>>> +int pci_bridge_help_cap_init(PCIDevice *dev, int cap_offset,
>>>>>> +                              uint8_t bus_reserve, uint32_t io_limit,
>>>>>> +                              uint16_t mem_limit, uint64_t pref_limit,
>>>>>> +                              Error **errp);
>>>>>> +
>>>>>>    #endif /* QEMU_PCI_BRIDGE_H */
>>>>>> --
>>>>>> 2.7.4
>>>>
>>>>
>>>>
>>>> --
>>>> Alexander Bezzubikov
