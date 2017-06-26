Received: from eggs.gnu.org ([2001:4830:134:3::10]:37346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dPcpC-000412-BV
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:49:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dPcpB-0000cJ-5z
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:49:42 -0400
MIME-Version: 1.0
In-Reply-To: <CALHRZurUtRV+3=L0PCADuj2BLbu2i1=MQomx2vbEiJSt1TNb+Q@mail.gmail.com>
References: <1494949133-2202-1-git-send-email-sundeep.lkml@gmail.com>
	<1494949133-2202-6-git-send-email-sundeep.lkml@gmail.com>
	<CAKmqyKPwRaXsgcuGC28x_pA9CYA-tcCnSBGNX1Qv3d3cXX8rsg@mail.gmail.com>
	<CALHRZupvtuE7oVdPa+kpaxP+ZrkHNzdJJV+fJq9nW1nHKX=5OA@mail.gmail.com>
	<CAKmqyKNA9VUV311XACwpt15PKas5HbBNM0Vdi5Z60q_HGhioTA@mail.gmail.com>
	<CALHRZurUtRV+3=L0PCADuj2BLbu2i1=MQomx2vbEiJSt1TNb+Q@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 26 Jun 2017 15:49:08 -0700
Message-ID: <CAKmqyKOcWFNKusosunD=MF3x0B=8=n2q9MLZmx5QzXrMxeH-FQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu devel v5 PATCH 5/5] msf2: Add Emcraft's
 Smartfusion2 SOM kit.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sundeep subbaraya <sundeep.lkml@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Mon, Jun 26, 2017 at 9:01 AM, sundeep subbaraya
<sundeep.lkml@gmail.com> wrote:
> Hi Alistair,
>
> On Wed, May 31, 2017 at 4:02 AM, Alistair Francis <alistair23@gmail.com>
> wrote:
>>
>> On Sun, May 28, 2017 at 10:26 PM, sundeep subbaraya
>> <sundeep.lkml@gmail.com> wrote:
>> > Hi Alistair,
>> >
>> > On Sat, May 27, 2017 at 5:30 AM, Alistair Francis <alistair23@gmail.com>
>> > wrote:
>> >>
>> >> On Tue, May 16, 2017 at 8:38 AM, Subbaraya Sundeep
>> >> <sundeep.lkml@gmail.com> wrote:
>> >> > Emulated Emcraft's Smartfusion2 System On Module starter
>> >> > kit.
>> >> >
>> >> > Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
>> >> > ---
>> >> >  hw/arm/Makefile.objs |  1 +
>> >> >  hw/arm/msf2-som.c    | 89
>> >> > ++++++++++++++++++++++++++++++++++++++++++++++++++++
>> >> >  2 files changed, 90 insertions(+)
>> >> >  create mode 100644 hw/arm/msf2-som.c
>> >> >
>> >> > diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
>> >> > index c828061..4b02093 100644
>> >> > --- a/hw/arm/Makefile.objs
>> >> > +++ b/hw/arm/Makefile.objs
>> >> > @@ -5,6 +5,7 @@ obj-y += omap_sx1.o palm.o realview.o spitz.o
>> >> > stellaris.o
>> >> >  obj-y += tosa.o versatilepb.o vexpress.o virt.o xilinx_zynq.o z2.o
>> >> >  obj-$(CONFIG_ACPI) += virt-acpi-build.o
>> >> >  obj-y += netduino2.o
>> >> > +obj-y += msf2-som.o
>> >>
>> >> This should be obj-$(CONFIG_MSF2).
>> >
>> >
>> > Ok will change it.
>> >>
>> >>
>> >> >  obj-y += sysbus-fdt.o
>> >> >
>> >> >  obj-y += armv7m.o exynos4210.o pxa2xx.o pxa2xx_gpio.o pxa2xx_pic.o
>> >> > diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
>> >> > new file mode 100644
>> >> > index 0000000..cd2b759
>> >> > --- /dev/null
>> >> > +++ b/hw/arm/msf2-som.c
>> >> > @@ -0,0 +1,89 @@
>> >> > +/*
>> >> > + * SmartFusion2 SOM starter kit(from Emcraft) emulation.
>> >> > + *
>> >> > + * Copyright (c) 2017 Subbaraya Sundeep <sundeep.lkml@gmail.com>
>> >> > + *
>> >> > + * Permission is hereby granted, free of charge, to any person
>> >> > obtaining a copy
>> >> > + * of this software and associated documentation files (the
>> >> > "Software"), to deal
>> >> > + * in the Software without restriction, including without limitation
>> >> > the rights
>> >> > + * to use, copy, modify, merge, publish, distribute, sublicense,
>> >> > and/or
>> >> > sell
>> >> > + * copies of the Software, and to permit persons to whom the
>> >> > Software
>> >> > is
>> >> > + * furnished to do so, subject to the following conditions:
>> >> > + *
>> >> > + * The above copyright notice and this permission notice shall be
>> >> > included in
>> >> > + * all copies or substantial portions of the Software.
>> >> > + *
>> >> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> >> > EXPRESS OR
>> >> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> >> > MERCHANTABILITY,
>> >> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
>> >> > SHALL
>> >> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
>> >> > OR
>> >> > OTHER
>> >> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> >> > ARISING FROM,
>> >> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
>> >> > DEALINGS IN
>> >> > + * THE SOFTWARE.
>> >> > + */
>> >> > +
>> >> > +#include "qemu/osdep.h"
>> >> > +#include "qapi/error.h"
>> >> > +#include "hw/boards.h"
>> >> > +#include "hw/arm/msf2-soc.h"
>> >> > +#include "hw/arm/arm.h"
>> >> > +#include "exec/address-spaces.h"
>> >> > +
>> >> > +#define DDR_BASE_ADDRESS      0xA0000000
>> >> > +#define DDR_SIZE              (64 * M_BYTE)
>> >> > +
>> >> > +static void emcraft_sf2_init(MachineState *machine)
>> >> > +{
>> >> > +    DeviceState *dev;
>> >> > +    DeviceState *spi_flash;
>> >> > +    MSF2State *soc;
>> >> > +    DriveInfo *dinfo = drive_get_next(IF_MTD);
>> >> > +    qemu_irq cs_line;
>> >> > +    SSIBus *spi_bus;
>> >> > +    MemoryRegion *sysmem = get_system_memory();
>> >> > +    MemoryRegion *ddr = g_new(MemoryRegion, 1);
>> >> > +
>> >> > +    memory_region_init_ram(ddr, NULL, "ddr-ram", DDR_SIZE,
>> >> > +                           &error_fatal);
>> >> > +    vmstate_register_ram_global(ddr);
>> >> > +    memory_region_add_subregion(sysmem, DDR_BASE_ADDRESS, ddr);
>> >>
>> >> The user can use -m to specify the amount of RAM to create in the
>> >> machine. Unless this board only ever includes 64MB of RAM you should
>> >> use that option (you will need to sanity check it though). If the
>> >> board only ever has 64MB it might be worth printing a warning to the
>> >> user if they specify an something. Although there might be a default
>> >> if they don't use -m, which makes it hard to print out a warning
>> >> message.
>> >
>> >
>> > This -m confuses me. Why is it necessary for an embedded board? RAM chip
>> > is fixed and not extendable. Whereas normal PC may have extra RAM slots.
>> > If another board has more RAM then we would instantiate another machine
>> > for
>> > it
>> > with that RAM size. Please explain. Maybe I am thinking in wrong
>> > direction.
>>
>> I agree with you, it doesn't make sense for every board. For some
>> embedded boards it does make sense (ZynqMP can have a customisable
>> amount of memory) but for most it doesn't make too much sense.
>>
>> In saying that it is a commonly used QEMU option, if you can find a
>> way to report a warning if the user tries to specify a custom amount
>> of memory I think that would be beneficial as QEMU will just ignore
>> their input. I have a feeling that the ram_size variable will be set
>> even if the user doesn't specify anything, which we don't want to
>> report a warning on.
>
>
> Do we need to report and exit if user specifies custom amount of memory?

I had a quick look at other ARM machines and it looks like a lot of
them use the ram_size variable from the machine to set the size of the
memory, but some have just hard coded values.

I'm not sure if there is an accepted "right" way to do this. If the
board only ever has 64MB of memory then it's probably ok to just hard
code it. Like you said, I don't think user have a high expectation of
adjusting the memory in embedded boards.

Thanks,
Alistair
