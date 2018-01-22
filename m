Received: from eggs.gnu.org ([2001:4830:134:3::10]:55437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edayR-0003JT-I4
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:13:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edayM-0005XO-US
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:13:15 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:46786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1edayM-0005X9-LK
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:13:10 -0500
Received: by mail-ot0-x242.google.com with SMTP id t35so7233863otd.13
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 04:13:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CADYoBw27wU3CsYPeP7ONFWt4aj+6tvzwU5roDSOKz8qq1n8GSg@mail.gmail.com>
References: <CADYoBw2dogvU6-3vChG4js0BNdyTPG8eDvMSRoU50eTX_9DdEQ@mail.gmail.com>
	<MWHPR21MB01590CD596A992C93E01B5079E460@MWHPR21MB0159.namprd21.prod.outlook.com>
	<CADYoBw1ksGDo26-PC4eMnyqxZQoZkXNLDeGoWfcRHs-SfTCJkw@mail.gmail.com>
	<MWHPR21MB01591543E188B048145985709E470@MWHPR21MB0159.namprd21.prod.outlook.com>
	<CADYoBw0RjiW2as9jGtPg92E8XK3KR+gM9C5vjC7HHsBauFn4ug@mail.gmail.com>
	<CADYoBw19GifmUR=Rztkzzc-v3-zWR6frjiNb_wjzsevreAqPDQ@mail.gmail.com>
	<CAFEAcA9_+wZJa7Ht6EHCCZYm+hrfdbjd9gUmVJPGgZ0yvbZOPA@mail.gmail.com>
	<MWHPR21MB0480DE1F826056BC8377EE289E250@MWHPR21MB0480.namprd21.prod.outlook.com>
	<CADYoBw31C0Z2vp0S0ZFBOC6A3146wxtZWvzJabACkGh44ZwC0w@mail.gmail.com>
	<MWHPR21MB0480A1F01D2CEF51E7CE21B09E3A0@MWHPR21MB0480.namprd21.prod.outlook.com>
	<CADYoBw1Ro5gxROvhCVXGv0=-Y8zXmGbKR3D6xOqhkb0zp__LkA@mail.gmail.com>
	<CADYoBw27wU3CsYPeP7ONFWt4aj+6tvzwU5roDSOKz8qq1n8GSg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2018 12:12:49 +0000
Message-ID: <CAFEAcA--i8RVKaBw5yXn4xRXBy5S+Yk=WDNKbuqzfDxn6jjtOA@mail.gmail.com>
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
To: bzt bzt <bztemail@gmail.com>
Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>

On 18 January 2018 at 21:39, bzt bzt <bztemail@gmail.com> wrote:
> Dear All,
>
> Since you still haven't merged Alistair's patch, I decided to include it in
> my own.
> I've shrinked the number of modified files to two, that's the bare minimum
> to support "-M raspi3" switch. Bcm2836.c modified minimally, the rest is in
> raspi.c. I've renamed raspi2_init() to raspi_init() 'cos now it initializes
> raspi3 as well, no additional function.
>

Can you send this as a proper patch email, not as a reply to
an existing email thread, please? (This makes our automated tooling
much happier.)

In particular we can't apply patches if they don't come with
the right Signed-off-by: lines from everybody who contributed
code to them.

I've made some code review comments below.

> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
> index 8c43291112..5119e00051 100644
> --- a/hw/arm/bcm2836.c
> +++ b/hw/arm/bcm2836.c
> @@ -15,6 +15,7 @@
>  #include "hw/arm/bcm2836.h"
>  #include "hw/arm/raspi_platform.h"
>  #include "hw/sysbus.h"
> +#include "hw/boards.h"
>  #include "exec/address-spaces.h"
>
>  /* Peripheral base address seen by the CPU */
> @@ -30,7 +31,7 @@ static void bcm2836_init(Object *obj)
>
>      for (n = 0; n < BCM2836_NCPUS; n++) {
>          object_initialize(&s->cpus[n], sizeof(s->cpus[n]),
> -                          "cortex-a15-" TYPE_ARM_CPU);
> +                          current_machine->cpu_type);

This SoC code shouldn't be looking at the current_machine settings.
It should have a QOM property that specifies the cpu type, and
the raspi.c code should set that property. (Call the property
'cpu-type' -- if you grep in hw/arm for that string you'll find
some examples of existing devices/boards that do this.)

>          object_property_add_child(obj, "cpu[*]", OBJECT(&s->cpus[n]),
>                                    &error_abort);
>      }
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index cd5fa8c3dc..24a9243440 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -5,6 +5,8 @@
>   * Rasperry Pi 2 emulation Copyright (c) 2015, Microsoft
>   * Written by Andrew Baumann
>   *
> + * Raspberry Pi 3 emulation Copyright (c) 2018 by bzt
> + *
>   * This code is licensed under the GNU GPLv2 and later.
>   */
>
> @@ -22,10 +24,11 @@
>  #define SMPBOOT_ADDR    0x300 /* this should leave enough space for ATAGS
> */
>  #define MVBAR_ADDR      0x400 /* secure vectors */
>  #define BOARDSETUP_ADDR (MVBAR_ADDR + 0x20) /* board setup code */
> -#define FIRMWARE_ADDR   0x8000 /* Pi loads kernel.img here by default */
> +#define FIRMWARE_ADDR_2    0x8000 /* Pi 2 loads kernel.img here by default
> */
> +#define FIRMWARE_ADDR_3   0x80000 /* Pi 3 loads kernel8.img here by default
> */
>
>  /* Table of Linux board IDs for different Pi versions */
> -static const int raspi_boardid[] = {[1] = 0xc42, [2] = 0xc43};
> +static const int raspi_boardid[] = {[1] = 0xc42, [2] = 0xc43, [3] = 0xc44};
>
>  typedef struct RasPiState {
>      BCM2836State soc;
> @@ -83,8 +86,8 @@ static void setup_boot(MachineState *machine, int version,
> size_t ram_size)
>      binfo.secure_board_setup = true;
>      binfo.secure_boot = true;
>
> -    /* Pi2 requires SMP setup */
> -    if (version == 2) {
> +    /* Pi2 and Pi3 requires SMP setup */
> +    if (version >= 2) {
>          binfo.smp_loader_start = SMPBOOT_ADDR;
>          binfo.write_secondary_boot = write_smpboot;
>          binfo.secondary_cpu_reset_hook = reset_secondary;
> @@ -94,15 +97,15 @@ static void setup_boot(MachineState *machine, int
> version, size_t ram_size)
>       * the normal Linux boot process
>       */
>      if (machine->firmware) {
> +        binfo.entry = version==3? FIRMWARE_ADDR_3 : FIRMWARE_ADDR_2;

There should be more spaces in this : "version == 3 ? ...".
If you run your patch through scripts/checkpatch.pl it should
help with this kind of style nit (though it doesn't always find
everything and sometimes it gets confused, so it's not always right).

>          /* load the firmware image (typically kernel.img) */
> -        r = load_image_targphys(machine->firmware, FIRMWARE_ADDR,
> -                                ram_size - FIRMWARE_ADDR);
> +        r = load_image_targphys(machine->firmware, binfo.entry,
> +                                ram_size - binfo.entry);
>          if (r < 0) {
>              error_report("Failed to load firmware from %s",
> machine->firmware);
>              exit(1);
>          }
>
> -        binfo.entry = FIRMWARE_ADDR;
>          binfo.firmware_loaded = true;
>      } else {
>          binfo.kernel_filename = machine->kernel_filename;
> @@ -113,7 +116,7 @@ static void setup_boot(MachineState *machine, int
> version, size_t ram_size)
>      arm_load_kernel(ARM_CPU(first_cpu), &binfo);
>  }
>
> -static void raspi2_init(MachineState *machine)
> +static void raspi_init(MachineState *machine)
>  {
>      RasPiState *s = g_new0(RasPiState, 1);
>      uint32_t vcram_size;
> @@ -121,6 +124,7 @@ static void raspi2_init(MachineState *machine)
>      BlockBackend *blk;
>      BusState *bus;
>      DeviceState *carddev;
> +    int version = machine->cpu_type==ARM_CPU_TYPE_NAME("cortex-a15")? 2 :
> 3;

This will get confused if the user passes a -cpu argument. Instead
we should just have the machine type directly determine the version.
There are several ways to do this, but the simplest way is to have
raspi2_machine_init() set mc->init to raspi2_init() and raspi3_machine_init()
set mc->niit to raspi3_init(), and thenthose function calls
raspi_init(machine, 2) or raspi_init(machine, 3).

(The other approach would be to make the board set up a subclass
of MachineState and then have raspi2 and raspi3 be subclasses of
that, which gives you a place to define raspi-specific data fields
like "version". You can see that approach in hw/arm/vexpress.c. But
that seems like a lot of effort to go to given where we've started,
so I don't really recommend it.)

>      object_initialize(&s->soc, sizeof(s->soc), TYPE_BCM2836);
>      object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
> @@ -137,8 +141,8 @@ static void raspi2_init(MachineState *machine)
>                                     &error_abort);
>      object_property_set_int(OBJECT(&s->soc), smp_cpus, "enabled-cpus",
>                              &error_abort);
> -    object_property_set_int(OBJECT(&s->soc), 0xa21041, "board-rev",
> -                            &error_abort);
> +    object_property_set_int(OBJECT(&s->soc), version==3 ? 0xa02082 :
> 0xa21041,
> +                            "board-rev", &error_abort);
>      object_property_set_bool(OBJECT(&s->soc), true, "realized",
> &error_abort);
>
>      /* Create and plug in the SD cards */
> @@ -155,21 +159,39 @@ static void raspi2_init(MachineState *machine)
>
>      vcram_size = object_property_get_uint(OBJECT(&s->soc), "vcram-size",
>                                            &error_abort);
> -    setup_boot(machine, 2, machine->ram_size - vcram_size);
> +    setup_boot(machine, version, machine->ram_size - vcram_size);
>  }
>
>  static void raspi2_machine_init(MachineClass *mc)
>  {
>      mc->desc = "Raspberry Pi 2";
> -    mc->init = raspi2_init;
> +    mc->init = raspi_init;
>      mc->block_default_type = IF_SD;
>      mc->no_parallel = 1;
>      mc->no_floppy = 1;
>      mc->no_cdrom = 1;
>      mc->max_cpus = BCM2836_NCPUS;
>      mc->min_cpus = BCM2836_NCPUS;
>      mc->default_cpus = BCM2836_NCPUS;
> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
>      mc->default_ram_size = 1024 * 1024 * 1024;
>      mc->ignore_memory_transaction_failures = true;
>  };
>  DEFINE_MACHINE("raspi2", raspi2_machine_init)
> +
> +static void raspi3_machine_init(MachineClass *mc)
> +{
> +    mc->desc = "Raspberry Pi 3";
> +    mc->init = raspi_init;
> +    mc->block_default_type = IF_SD;
> +    mc->no_parallel = 1;
> +    mc->no_floppy = 1;
> +    mc->no_cdrom = 1;
> +    mc->max_cpus = BCM2836_NCPUS;
> +    mc->min_cpus = BCM2836_NCPUS;
> +    mc->default_cpus = BCM2836_NCPUS;
> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a53");
> +    mc->default_ram_size = 1024 * 1024 * 1024;
> +    mc->ignore_memory_transaction_failures = true;
> +};
> +DEFINE_MACHINE("raspi3", raspi3_machine_init)


I don't want to add new machine types which set the
ignore_memory_transaction_failures flag to true -- this is
only for existing board models where we don't know what
guest code that used to run would break when the flag was
flipped. For new boards we know that no code runs on them
so can leave the flag at its correct default.

This may mean that you need to add some extra dummy
devices to the the SoC model using
create_unimplemented_device() so that your guest image
doesn't crash trying to probe those devices.

I appreciate that this is a bit annoying for a case like this
where it's adding a new variant of an existing SoC, but
this is one of the situations where the only practical
opportunity to get the implementation right without breaking
existing QEMU users is at the point where we add the new
board model.

thanks
-- PMM
