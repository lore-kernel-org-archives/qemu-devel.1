Received: from eggs.gnu.org ([2001:4830:134:3::10]:37062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bztemail@gmail.com>) id 1e6vuB-0006QO-9F
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 05:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bztemail@gmail.com>) id 1e6vu9-0008RC-9G
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 05:53:51 -0400
MIME-Version: 1.0
In-Reply-To: <MWHPR21MB01590CD596A992C93E01B5079E460@MWHPR21MB0159.namprd21.prod.outlook.com>
References: <CADYoBw2dogvU6-3vChG4js0BNdyTPG8eDvMSRoU50eTX_9DdEQ@mail.gmail.com>
	<MWHPR21MB01590CD596A992C93E01B5079E460@MWHPR21MB0159.namprd21.prod.outlook.com>
From: bzt bzt <bztemail@gmail.com>
Date: Tue, 24 Oct 2017 11:53:46 +0200
Message-ID: <CADYoBw1ksGDo26-PC4eMnyqxZQoZkXNLDeGoWfcRHs-SfTCJkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] BCM2837 and machine raspi3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>

Hi Andrew!

On Mon, Oct 23, 2017 at 6:34 PM, Andrew Baumann <
Andrew.Baumann@microsoft.com> wrote:

> > From: Qemu-devel On Behalf Of bzt bzt
> > Sent: Sunday, 22 October 2017 06:21
> >
> > I've added support for "-M raspi3" to qemu. This is my first patch, I
> hope
> > it's okay. The github repo is here: https://github.com/bztsrc/
> qemu-raspi3
> > in case my patch does not work for some reason.
>
> Thanks for the patch!
>

Welcome!


>
> [...]
>
> > Subject: [PATCH] BCM2837 and machine raspi3
>
> *add
>
> [...]
>
> > --- /dev/null
> > +++ b/hw/arm/bcm2837.c
> > @@ -0,0 +1,179 @@
> > +/*
> > + * Raspberry Pi emulation (c) 2012 Gregory Estrade
> > + * Upstreaming code cleanup [including bcm2835_*] (c) 2013 Jan Petrous
> > + *
> > + * Rasperry Pi 2 emulation and refactoring Copyright (c) 2015, Microsoft
> > + * Written by Andrew Baumann
> > + *
> > + * Raspberry Pi 3 emulation 2017 by bzt
> > + *
> > + * This code is licensed under the GNU GPLv2 and later.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qapi/error.h"
> > +#include "qemu-common.h"
> > +#include "cpu.h"
> > +#include "hw/arm/bcm2836.h"
> > +#include "hw/arm/bcm2837.h"
> > +#include "hw/arm/raspi_platform.h"
> > +#include "hw/sysbus.h"
> > +#include "exec/address-spaces.h"
> > +
> > +/* According to
> > https://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm2837/
> > README.md
> > + * The underlying architecture of the BCM2837 is identical to the
> BCM2836.
> > The only significant
> > + * difference is the replacement of the ARMv7 quad core cluster with a
> > quad-core ARM Cortex A53
> > + * (ARMv8) cluster. So we use cortex-a53- here. */
>
> Are there any changes from bcm2836 other than the CPU model?


> Duplicating the whole file just to have a different CPU seems like a bad
> idea to me. I would suggest parameterising the CPU model in bcm2836 (and
> maybe noting in header comments etc. that it can also model 2837), and then
> instantiating it from raspi.c with the correct CPU type depending on which
> machine is being used. That will also reduce the size of the patch
> significantly, which will make it easier to get it reviewed.
>

For now, there's no more difference in the emulation than the CPU, but
BCM2837 has a lot more to offer (40 bit address space, wifi, bluetooth
etc.). So sooner or later it will need it's own source file to support all
of that without getting the code messy. I have asked Peter whether it does
worth writing future proof code, or keep the change at the bare minimum,
but had no answer yet.


>
> (Alternatively, if there are minor but non-trivial differences between
> 2836 and 2837 other than the CPU model, you may want to create something
> like bcm2835_peripherals that contains all the functionality common to
> both. But I suspect that isn't the case here.)
>

Well, bcm2837 is backward compatible with the bcm2836, but has a lot more
registers and a different boot up process (different address and no atags).
The common functionality is already in bcm2835_peripherals, and the MMIO
address change from bcm2835 to bcm2836 has already been added by you.
What's different is a lot more devices, which imho would be unwise to add
to bcm2835 or either to bcm2836. So to be future proof I've created a
separated file, but you are right at the current level of emulation it's
not necessary.


>
> > --- a/hw/arm/raspi.c
> > +++ b/hw/arm/raspi.c
> [...]
> > @@ -171,3 +177,62 @@ static void raspi2_machine_init(MachineClass *mc)
> >      mc->ignore_memory_transaction_failures = true;
> >  };
> >  DEFINE_MACHINE("raspi2", raspi2_machine_init)
> > +
> > +static void raspi3_init(MachineState *machine)
> > +{
> > +    RasPiState *s = g_new0(RasPiState, 1);
> > +    uint32_t vcram_size;
> > +    DriveInfo *di;
> > +    BlockBackend *blk;
> > +    BusState *bus;
> > +    DeviceState *carddev;
> > +
> > +    object_initialize(&s->soc, sizeof(s->soc), TYPE_BCM2837);
> > +    object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
> > +                              &error_abort);
> > +
> > +    /* Allocate and map RAM */
> > +    memory_region_allocate_system_memory(&s->ram, OBJECT(machine),
> > "ram",
> > +                                         machine->ram_size);
> > +    /* FIXME: Remove when we have custom CPU address space support */
> > +    memory_region_add_subregion_overlap(get_system_memory(), 0, &s-
> > >ram,
> > 0);
> > +
> > +    /* Setup the SOC */
> > +    object_property_add_const_link(OBJECT(&s->soc), "ram", OBJECT(&s-
> > >ram),
> > +                                   &error_abort);
> > +    object_property_set_int(OBJECT(&s->soc), smp_cpus, "enabled-cpus",
> > +                            &error_abort);
> > +    object_property_set_int(OBJECT(&s->soc), 0xa02082, "board-rev",
> > +                            &error_abort);
> > +    object_property_set_bool(OBJECT(&s->soc), true, "realized",
> > &error_abort);
> > +
> > +    /* Create and plug in the SD cards */
> > +    di = drive_get_next(IF_SD);
> > +    blk = di ? blk_by_legacy_dinfo(di) : NULL;
> > +    bus = qdev_get_child_bus(DEVICE(&s->soc), "sd-bus");
> > +    if (bus == NULL) {
> > +        error_report("No SD bus found in SOC object");
> > +        exit(1);
> > +    }
> > +    carddev = qdev_create(bus, TYPE_SD_CARD);
> > +    qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
> > +    object_property_set_bool(OBJECT(carddev), true, "realized",
> > &error_fatal);
> > +
> > +    vcram_size = object_property_get_uint(OBJECT(&s->soc),
> "vcram-size",
> > +                                          &error_abort);
> > +    setup_boot(machine, 3, machine->ram_size - vcram_size);
> > +}
>
> Similarly, this looks like a clone of raspi2_init. I think it would be
> better to have one function, parametrised if needed.
>

For now, yes. But the extra devices bcm2837 have will need extra
initialization, and I though it would be clearer to separate in advance.
Again, I've asked Peter about this, but had no response. As I see having a
parametrised single function is simplier for now, but could lead to a messy
code later when all the SoC features will be added. But I'm ain't no expert
on qemu source, this is my first patch, so I'm open to suggestions! :-)

Summa summarum, which one is preferred? Think of the future or keep it at a
bare minimum?

Cheers,
bzt


>
> Regards,
> Andrew
>
