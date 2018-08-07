Received: from eggs.gnu.org ([2001:4830:134:3::10]:37310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geert.uytterhoeven@gmail.com>) id 1fn3yZ-000065-EG
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 11:32:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geert.uytterhoeven@gmail.com>) id 1fn3yY-0002wa-7T
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 11:32:47 -0400
MIME-Version: 1.0
References: <20180725143413.9728-1-geert+renesas@glider.be>
	<20180725143413.9728-5-geert+renesas@glider.be>
	<e52bfdab-5c23-a617-8bef-0c17ab831ec1@redhat.com>
In-Reply-To: <e52bfdab-5c23-a617-8bef-0c17ab831ec1@redhat.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 7 Aug 2018 17:32:27 +0200
Message-ID: <CAMuHMdUuHcoZxFVFivBwD3LveeE8yQ+AnaWFr76kATG+rCzd=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Auger Eric <eric.auger@redhat.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Peter Maydell <peter.maydell@linaro.org>, Alex Williamson <alex.williamson@redhat.com>, Magnus Damm <damm+renesas@opensource.se>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Eric,

On Tue, Aug 7, 2018 at 4:19 PM Auger Eric <eric.auger@redhat.com> wrote:
> On 07/25/2018 04:34 PM, Geert Uytterhoeven wrote:
> > Add a fallback for instantiating generic devices without a type-specific
> > or compatible-specific instantation method.  This will be used when no
> > other match is found.
> >
> > The generic instantation method creates a device node with "reg" and
> > (optional) "interrupts" properties, and copies the "compatible"
> > property and other optional properties from the host.
> > For now the following optional properties are copied, if found:
> >   - "#gpio-cells",
> >   - "gpio-controller",
> >   - "#interrupt-cells",
> >   - "interrupt-controller",
> >   - "interrupt-names".
> >
> > More can be added when needed.
> >
> > This avoids having to write device-specific instantation methods for
> instantiation

Thanks, will fix.

> > each and every "simple" device using only a set of generic properties.
> > Devices that need more specialized handling can still provide their
> > own instantation method.

Arghl, one more.

> > --- a/hw/arm/sysbus-fdt.c
> > +++ b/hw/arm/sysbus-fdt.c
> > @@ -415,6 +415,99 @@ static int add_amd_xgbe_fdt_node(SysBusDevice *sbdev, void *opaque)
> >      return 0;
> >  }
> >
> > +static HostProperty generic_copied_properties[] = {
> > +    {"compatible", false},
> > +    {"#gpio-cells", true},
> > +    {"gpio-controller", true},
> > +    {"#interrupt-cells", true},
> > +    {"interrupt-controller", true},
> > +    {"interrupt-names", true},
>
> I think we would need to enumerate the other source properties which
> were not copied to the guest fdt and either warn the userspace those
> were omitted or fail. We may end up generating an incomplete guest dt
> node that may not work properly.

The list above is quite generic, so it is expected that some of the optional
properties (marked "true") cannot be copied. Hence warning about them
will be noisy, and confuse users.  Failing is definitely the wrong thing
to do.

If the host lacks a property that is mandatory for a specific device, the
device won't have worked on the host before neither, right?

The major issue remains that an incomplete guest DT node may be generated
if the list above lacks certain needed properties, or if subnodes are
needed.
I expect the guest OS driver would complain about the missing parts, though.
In that case, either the list should be extended, or a device-specific
instantiation method should be written.

> > +/**
> > + * add_generic_fdt_node
> > + *
> > + * Generates a generic DT node by copying properties from the host
> > + */
> > +static int add_generic_fdt_node(SysBusDevice *sbdev, void *opaque)
> > +{

> > +    /* Copy interrupts (remapped) */
> > +    if (vbasedev->num_irqs) {
> > +        irq_attr = g_new(uint32_t, vbasedev->num_irqs * 3);
> > +        for (i = 0; i < vbasedev->num_irqs; i++) {
> > +            irq_number = platform_bus_get_irqn(pbus, sbdev , i)
> > +                             + data->irq_start;
> > +            irq_attr[3 * i] = cpu_to_be32(GIC_FDT_IRQ_TYPE_SPI);
> > +            irq_attr[3 * i + 1] = cpu_to_be32(irq_number);
> > +            irq_attr[3 * i + 2] = cpu_to_be32(GIC_FDT_IRQ_FLAGS_LEVEL_HI);
>
> I think this part is not generic enough. How can you assume the IRQs are
> level or edge? Can't you copy the source interrupt properties and just
> overwrite the IRQ number?

I have to check that. I wouldn't be surprised if the virtualized GIC supports
only a subset of all possible flags and/or remaps interrupt types too.

I see the AMD XGBE driver looks at VFIO_IRQ_INFO_AUTOMASKED to choose
between GIC_FDT_IRQ_FLAGS_LEVEL_HI and GIC_FDT_IRQ_FLAGS_EDGE_LO_HI.
The VFIO_IRQ_INFO_* don't seem to provide more details.
There are also no users of GIC_FDT_IRQ_FLAGS_LEVEL_LO and
GIC_FDT_IRQ_FLAGS_EDGE_HI_LO in the Qemu sources...

So probably following the AMD XGBE example is the way forward?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
