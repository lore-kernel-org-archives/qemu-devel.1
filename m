Received: from eggs.gnu.org ([2001:4830:134:3::10]:54044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC5Co-0000QZ-Vg
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 11:22:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC5Cn-0005N6-Up
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 11:22:38 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:34114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC5Cn-0005Mn-Pk
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 11:22:37 -0400
Received: by mail-ot0-x243.google.com with SMTP id i5-v6so2448144oth.1
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 08:22:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180424141258.cuenuefdtkefikr6@kamzik.brq.redhat.com>
References: <3301c5bc-7b47-1b0e-8ce4-30435057a276@web.de>
	<CAFEAcA9KSUppGGom-ipX+N49j0gDJH3KDY8oyqT8cVOU0Mn8Rw@mail.gmail.com>
	<20180424141258.cuenuefdtkefikr6@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 16:22:16 +0100
Message-ID: <CAFEAcA_o0vZkFqeZMhm0bYnbk1OQfmozXGq8cpmP0V8T_HZ2Tg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/arm/virt: Add linux, pci-domain property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: Jan Kiszka <jan.kiszka@web.de>, qemu-devel <qemu-devel@nongnu.org>

On 24 April 2018 at 15:12, Andrew Jones <drjones@redhat.com> wrote:
> On Mon, Apr 23, 2018 at 02:11:40PM +0100, Peter Maydell wrote:
>> On 23 April 2018 at 06:18, Jan Kiszka <jan.kiszka@web.de> wrote:
>> > From: Jan Kiszka <jan.kiszka@siemens.com>
>> >
>> > This allows to pin the host controller in the Linux PCI domain space.
>> > Linux requires that property to be available consistently or not at all,
>> > in which case the domain number becomes unstable on additions/removals.
>> > Adding it here won't make a difference in practice for most setups as we
>> > only expose one controller.
>> >
>> > However, enabling Jailhouse on top may introduce another controller, and
>> > that one would like to have stable address as well. So the property is
>> > needed for the first controller as well.
>>
>> Am I right in thinking that for ACPI the PCI domain number is
>> communicated via the _SEG method? If so, looks like we already
>> set that, and we set it to 0, which matches what we're doing here
>> in the DT, so that's good.
>
> _SEG and linux,pci-domain are similar in definition, but don't appear to
> be equivalent, as the same _SEG number is permitted across multiple host
> bridges, but linux,pci-domain must be unique for each host bridge. I
> think the (_SEG, _BBN) pair may form the equivalent. We also set _BBN
> to zero, so I think we're fine anyway.
>
>>
>> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> > ---
>> >  hw/arm/virt.c | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> > index 94dcb125d3..943371b75e 100644
>> > --- a/hw/arm/virt.c
>> > +++ b/hw/arm/virt.c
>> > @@ -1023,6 +1023,7 @@ static void create_pcie(const VirtMachineState *vms, qemu_irq *pic)
>> >      qemu_fdt_setprop_string(vms->fdt, nodename, "device_type", "pci");
>> >      qemu_fdt_setprop_cell(vms->fdt, nodename, "#address-cells", 3);
>> >      qemu_fdt_setprop_cell(vms->fdt, nodename, "#size-cells", 2);
>> > +    qemu_fdt_setprop_cell(vms->fdt, nodename, "linux,pci-domain", 0);
>> >      qemu_fdt_setprop_cells(vms->fdt, nodename, "bus-range", 0,
>> >                             nr_pcie_buses - 1);
>> >      qemu_fdt_setprop(vms->fdt, nodename, "dma-coherent", NULL, 0);
>> > --
>>
>> Drew -- is minor changes to the DTC something we can do without
>> having to condition it on machine version? I forget...
>
> Yes, and even less minor changes than this one can be made to ACPI and DT
> generation, per the "if a firwmare update could change it, then don't
> worry about it" policy.

Cool; applied to target-arm.next, then.

-- PMM
