Received: from eggs.gnu.org ([2001:4830:134:3::10]:47559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dbETW-0008Fe-1N
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:15:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dbETT-0000Zp-B2
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:15:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dbETT-0000Ys-1S
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:15:15 -0400
Date: Sat, 29 Jul 2017 02:15:06 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170729021229-mutt-send-email-mst@kernel.org>
References: <1500761743-1669-1-git-send-email-zuban32s@gmail.com>
	<1500761743-1669-5-git-send-email-zuban32s@gmail.com>
	<20170726215625-mutt-send-email-mst@kernel.org>
	<CAKSfGUAh_rqGy8uNJXThH4v1z5zbPdLhkBx77Tui8PL-N-7JXw@mail.gmail.com>
	<20170727022103-mutt-send-email-mst@kernel.org>
	<f210b52b-b7ea-b27e-cca8-9f11a4b4f353@redhat.com>
	<98048fb7-34e7-d92f-cbe5-90f39c9fcb46@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98048fb7-34e7-d92f-cbe5-90f39c9fcb46@redhat.com>
Subject: Re: [Qemu-devel] [SeaBIOS] [RFC PATCH v2 4/6] hw/pci: introduce
 bridge-only vendor-specific capability to provide some hints to firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, Alexander Bezzubikov <zuban32s@gmail.com>, seabios@seabios.org, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com, rth@twiddle.net

On Thu, Jul 27, 2017 at 03:58:58PM +0200, Laszlo Ersek wrote:
> On 07/27/17 11:39, Marcel Apfelbaum wrote:
> > On 27/07/2017 2:28, Michael S. Tsirkin wrote:
> >> On Thu, Jul 27, 2017 at 12:54:07AM +0300, Alexander Bezzubikov wrote:
> >>> 2017-07-26 22:43 GMT+03:00 Michael S. Tsirkin <mst@redhat.com>:
> >>>> On Sun, Jul 23, 2017 at 01:15:41AM +0300, Aleksandr Bezzubikov wrote:
> >>>>> On PCI init PCI bridges may need some
> >>>>> extra info about bus number to reserve, IO, memory and
> >>>>> prefetchable memory limits. QEMU can provide this
> >>>>> with special
> >>>>
> >>>> with a special
> >>>>
> >>>>> vendor-specific PCI capability.
> >>>>>
> >>>>> Sizes of limits match ones from
> >>>>> PCI Type 1 Configuration Space Header,
> >>>>> number of buses to reserve occupies only 1 byte
> >>>>> since it is the size of Subordinate Bus Number register.
> >>>>>
> >>>>> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
> >>>>> ---
> >>>>>   hw/pci/pci_bridge.c         | 27 +++++++++++++++++++++++++++
> >>>>>   include/hw/pci/pci_bridge.h | 18 ++++++++++++++++++
> >>>>>   2 files changed, 45 insertions(+)
> >>>>>
> >>>>> diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
> >>>>> index 720119b..8ec6c2c 100644
> >>>>> --- a/hw/pci/pci_bridge.c
> >>>>> +++ b/hw/pci/pci_bridge.c
> >>>>> @@ -408,6 +408,33 @@ void pci_bridge_map_irq(PCIBridge *br, const
> >>>>> char* bus_name,
> >>>>>       br->bus_name = bus_name;
> >>>>>   }
> >>>>>
> >>>>> +
> >>>>> +int pci_bridge_help_cap_init(PCIDevice *dev, int cap_offset,
> >>>>
> >>>> help? should be qemu_cap_init?
> >>>>
> >>>>> +                              uint8_t bus_reserve, uint32_t io_limit,
> >>>>> +                              uint16_t mem_limit, uint64_t
> >>>>> pref_limit,
> >>>>> +                              Error **errp)
> >>>>> +{
> >>>>> +    size_t cap_len = sizeof(PCIBridgeQemuCap);
> >>>>> +    PCIBridgeQemuCap cap;
> >>>>
> >>>> This leaks info to guest. You want to init all fields here:
> >>>>
> >>>> cap = {
> >>>>   .len = ....
> >>>> };
> >>>
> >>> I surely can do this for len field, but as Laszlo proposed
> >>> we can use mutually exclusive fields,
> >>> e.g. pref_32 and pref_64, the only way I have left
> >>> is to use ternary operator (if we surely need this
> >>> big initializer). Keeping some if's would look better,
> >>> I think.
> >>>
> >>>>
> >>>>> +
> >>>>> +    cap.len = cap_len;
> >>>>> +    cap.bus_res = bus_reserve;
> >>>>> +    cap.io_lim = io_limit & 0xFF;
> >>>>> +    cap.io_lim_upper = io_limit >> 8 & 0xFFFF;
> >>>>> +    cap.mem_lim = mem_limit;
> >>>>> +    cap.pref_lim = pref_limit & 0xFFFF;
> >>>>> +    cap.pref_lim_upper = pref_limit >> 16 & 0xFFFFFFFF;
> >>>>
> >>>> Please use pci_set_word etc or cpu_to_leXX.
> >>>>
> >>>
> >>> Since now we've decided to avoid fields separation into <field> +
> >>> <field_upper>,
> >>> this bitmask along with pci_set_word are no longer needed.
> >>>
> >>>> I think it's easiest to replace struct with a set of macros then
> >>>> pci_set_word does the work for you.
> >>>>
> >>>
> >>> I don't really want to use macros here because structure
> >>> show us the whole capability layout and this can
> >>> decrease documenting efforts. More than that,
> >>> memcpy usage is very convenient here, and I wouldn't like
> >>> to lose it.
> >>>
> >>>>
> >>>>> +
> >>>>> +    int offset = pci_add_capability(dev, PCI_CAP_ID_VNDR,
> >>>>> +                                    cap_offset, cap_len, errp);
> >>>>> +    if (offset < 0) {
> >>>>> +        return offset;
> >>>>> +    }
> >>>>> +
> >>>>> +    memcpy(dev->config + offset + 2, (char *)&cap + 2, cap_len - 2);
> >>>>
> >>>> +2 is yacky. See how virtio does it:
> >>>>
> >>>>      memcpy(dev->config + offset + PCI_CAP_FLAGS, &cap->cap_len,
> >>>>             cap->cap_len - PCI_CAP_FLAGS);
> >>>>
> >>>>
> >>>
> >>> OK.
> >>>
> >>>>> +    return 0;
> >>>>> +}
> >>>>> +
> >>>>>   static const TypeInfo pci_bridge_type_info = {
> >>>>>       .name = TYPE_PCI_BRIDGE,
> >>>>>       .parent = TYPE_PCI_DEVICE,
> >>>>> diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
> >>>>> index ff7cbaa..c9f642c 100644
> >>>>> --- a/include/hw/pci/pci_bridge.h
> >>>>> +++ b/include/hw/pci/pci_bridge.h
> >>>>> @@ -67,4 +67,22 @@ void pci_bridge_map_irq(PCIBridge *br, const
> >>>>> char* bus_name,
> >>>>>   #define  PCI_BRIDGE_CTL_DISCARD_STATUS       0x400   /* Discard
> >>>>> timer status */
> >>>>>   #define  PCI_BRIDGE_CTL_DISCARD_SERR 0x800   /* Discard timer
> >>>>> SERR# enable */
> >>>>>
> >>>>> +typedef struct PCIBridgeQemuCap {
> >>>>> +    uint8_t id;     /* Standard PCI capability header field */
> >>>>> +    uint8_t next;   /* Standard PCI capability header field */
> >>>>> +    uint8_t len;    /* Standard PCI vendor-specific capability
> >>>>> header field */
> >>>>> +    uint8_t bus_res;
> >>>>> +    uint32_t pref_lim_upper;
> >>>>
> >>>> Big endian? Ugh.
> >>>>
> >>>
> >>> Agreed, and this's gonna to disappear with
> >>> the new layout.
> >>>
> >>>>> +    uint16_t pref_lim;
> >>>>> +    uint16_t mem_lim;
> >>>>
> >>>> I'd say we need 64 bit for memory.
> >>>>
> >>>
> >>> Why? Non-prefetchable MEMORY_LIMIT register is 16 bits long.
> >>
> >> Hmm ok, but e.g. for io there are bridges that have extra registers
> >> to specify non-standard non-aligned registers.
> >>
> >>>>> +    uint16_t io_lim_upper;
> >>>>> +    uint8_t io_lim;
> >>>>> +    uint8_t padding;
> >>>>
> >>>> IMHO each type should have a special "don't care" flag
> >>>> that would mean "I don't know".
> >>>>
> >>>>
> >>>
> >>> Don't know what? Now 0 is an indicator to do nothing with this field.
> >>
> >> In that case how do you say "don't allocate any memory"?
> >>
> > 
> > We can keep the MEM/Limit registers read-only for such cases,
> > as they are optional registers.
> 
> For OVMF, it would be really nice if OVMF could gather the reservation
> numbers with
> - read-only accesses
> - to the one exact hotplug controller (root port, bridge, etc) that's
>   being queried for reservation.
> 
> Deciding whether some registers in config space are r/o would require
> OVMF to attempt a write and check the result (and if it succeeded, to
> restore the original value). I'm not too attracted to doing this in a
> platform hook, while PciBusDxe is in the middle of enumerating /
> configuring the PCI(e) hierarchy :)
> 
> Thanks
> Laszlo

Well that's the PCI spec, I don't think there's a choice for
regular bridges. If we have this capability this is a possible
optimization.
But without it, if you assign ranges without checking whether they are
available they won't have any effect practically.
It's mostly harmless, but you are going to waste resources.

-- 
MST
