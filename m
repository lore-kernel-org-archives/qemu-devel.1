Received: from eggs.gnu.org ([2001:4830:134:3::10]:56517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fn5fr-0001Dd-6E
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 13:21:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fn5fp-0002uZ-SJ
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 13:21:35 -0400
References: <20180725143413.9728-1-geert+renesas@glider.be>
	<20180725143413.9728-5-geert+renesas@glider.be>
	<e52bfdab-5c23-a617-8bef-0c17ab831ec1@redhat.com>
	<CAMuHMdUuHcoZxFVFivBwD3LveeE8yQ+AnaWFr76kATG+rCzd=w@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <9305142a-8b88-8beb-dd95-02dd84881aa8@redhat.com>
Date: Tue, 7 Aug 2018 19:21:16 +0200
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUuHcoZxFVFivBwD3LveeE8yQ+AnaWFr76kATG+rCzd=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 4/4] hw/arm/sysbus-fdt: Add support for
 instantiating generic devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <damm+renesas@opensource.se>, QEMU Developers <qemu-devel@nongnu.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Alex Williamson <alex.williamson@redhat.com>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, qemu-arm <qemu-arm@nongnu.org>

Hi Geert,

On 08/07/2018 05:32 PM, Geert Uytterhoeven wrote:
> Hi Eric,
> 
> On Tue, Aug 7, 2018 at 4:19 PM Auger Eric <eric.auger@redhat.com> wrote:
>> On 07/25/2018 04:34 PM, Geert Uytterhoeven wrote:
>>> Add a fallback for instantiating generic devices without a type-specific
>>> or compatible-specific instantation method.  This will be used when no
>>> other match is found.
>>>
>>> The generic instantation method creates a device node with "reg" and
>>> (optional) "interrupts" properties, and copies the "compatible"
>>> property and other optional properties from the host.
>>> For now the following optional properties are copied, if found:
>>>   - "#gpio-cells",
>>>   - "gpio-controller",
>>>   - "#interrupt-cells",
>>>   - "interrupt-controller",
>>>   - "interrupt-names".
>>>
>>> More can be added when needed.
>>>
>>> This avoids having to write device-specific instantation methods for
>> instantiation
> 
> Thanks, will fix.
> 
>>> each and every "simple" device using only a set of generic properties.
>>> Devices that need more specialized handling can still provide their
>>> own instantation method.
> 
> Arghl, one more.
> 
>>> --- a/hw/arm/sysbus-fdt.c
>>> +++ b/hw/arm/sysbus-fdt.c
>>> @@ -415,6 +415,99 @@ static int add_amd_xgbe_fdt_node(SysBusDevice *sbdev, void *opaque)
>>>      return 0;
>>>  }
>>>
>>> +static HostProperty generic_copied_properties[] = {
>>> +    {"compatible", false},
>>> +    {"#gpio-cells", true},
>>> +    {"gpio-controller", true},
>>> +    {"#interrupt-cells", true},
>>> +    {"interrupt-controller", true},
>>> +    {"interrupt-names", true},
>>
>> I think we would need to enumerate the other source properties which
>> were not copied to the guest fdt and either warn the userspace those
>> were omitted or fail. We may end up generating an incomplete guest dt
>> node that may not work properly.
> 
> The list above is quite generic, so it is expected that some of the optional
> properties (marked "true") cannot be copied. Hence warning about them
> will be noisy, and confuse users.  Failing is definitely the wrong thing
> to do.
I was not talking about those listed here and optional. Those ones are
taken care of. I was rather talking about potential other ones, present
on host side and not copied on guest side. For instance, let's say your
host dt node has a clocks property. You will attempt to create a guest
dt node without this property and obviously the device will not work
properly on guest side. The end user attempting this assignment does not
get any warning on guest launch. Maybe the driver on guest side will be
cool enough to issue a warning but we cannot really rely on this
assumption. So from a maintenance point of view, it looks not
manageable. I think we should checl all props found in the host dt node
are considered and copied into the guest node. Otherwise this means the
host dt node does not belong to the category of a "simple" one and thus
cannot use this creation function.
> 
> If the host lacks a property that is mandatory for a specific device, the
> device won't have worked on the host before neither, right?
> 
> The major issue remains that an incomplete guest DT node may be generated
> if the list above lacks certain needed properties, or if subnodes are
> needed.
> I expect the guest OS driver would complain about the missing parts, though.
> In that case, either the list should be extended, or a device-specific
> instantiation method should be written.
> 
>>> +/**
>>> + * add_generic_fdt_node
>>> + *
>>> + * Generates a generic DT node by copying properties from the host
>>> + */
>>> +static int add_generic_fdt_node(SysBusDevice *sbdev, void *opaque)
>>> +{
> 
>>> +    /* Copy interrupts (remapped) */
>>> +    if (vbasedev->num_irqs) {
>>> +        irq_attr = g_new(uint32_t, vbasedev->num_irqs * 3);
>>> +        for (i = 0; i < vbasedev->num_irqs; i++) {
>>> +            irq_number = platform_bus_get_irqn(pbus, sbdev , i)
>>> +                             + data->irq_start;
>>> +            irq_attr[3 * i] = cpu_to_be32(GIC_FDT_IRQ_TYPE_SPI);
>>> +            irq_attr[3 * i + 1] = cpu_to_be32(irq_number);
>>> +            irq_attr[3 * i + 2] = cpu_to_be32(GIC_FDT_IRQ_FLAGS_LEVEL_HI);
>>
>> I think this part is not generic enough. How can you assume the IRQs are
>> level or edge? Can't you copy the source interrupt properties and just
>> overwrite the IRQ number?
> 
> I have to check that. I wouldn't be surprised if the virtualized GIC supports
> only a subset of all possible flags and/or remaps interrupt types too.
> 
> I see the AMD XGBE driver looks at VFIO_IRQ_INFO_AUTOMASKED to choose
> between GIC_FDT_IRQ_FLAGS_LEVEL_HI and GIC_FDT_IRQ_FLAGS_EDGE_LO_HI.
> The VFIO_IRQ_INFO_* don't seem to provide more details.
Yep it tells you whether this is edge or level. That's why I initially
suggested to keep the copied values for the type.

Thanks

Eric
> There are also no users of GIC_FDT_IRQ_FLAGS_LEVEL_LO and
> GIC_FDT_IRQ_FLAGS_EDGE_HI_LO in the Qemu sources...
> 
> So probably following the AMD XGBE example is the way forward?
> 
> Thanks!
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
