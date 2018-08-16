Received: from eggs.gnu.org ([2001:4830:134:3::10]:42050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqJ0g-0005XB-5Y
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:12:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqJ0f-0003CT-4L
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:12:22 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:37534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqJ0e-0003Aq-Ql
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:12:20 -0400
Received: by mail-oi0-x241.google.com with SMTP id j205-v6so8248226oib.4
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 07:12:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180803052137.10602-4-joel@jms.id.au>
References: <20180803052137.10602-1-joel@jms.id.au>
	<20180803052137.10602-4-joel@jms.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 15:11:59 +0100
Message-ID: <CAFEAcA9o8JE-ZE3SLBTFrrNCgtJ85L6T7opPZnd0pJaZVkRdVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 3/3] arm: Add BBC micro:bit machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Jim Mussared <jim.mussared@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>

On 3 August 2018 at 06:21, Joel Stanley <joel@jms.id.au> wrote:
> This adds the base for a machine model of the BBC micro:bit:
>
>   https://en.wikipedia.org/wiki/Micro_Bit
>
> This is a system with a nRF51 SoC containing the main processor, with
> various peripherals on board.
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v2:
>  - Instead of setting kernel filename property, load the image directly
>  - Add link to hardware overview website
> v3:
>  - Rebase microbit on m0 changes
>  - Remove hard-coded flash size and retrieve from the soc
>  - Add Stefan's reviewed-by
> ---
>  hw/arm/Makefile.objs |  2 +-
>  hw/arm/microbit.c    | 54 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+), 1 deletion(-)
>  create mode 100644 hw/arm/microbit.c
>
> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> index e31875ec69bc..2798a257921d 100644
> --- a/hw/arm/Makefile.objs
> +++ b/hw/arm/Makefile.objs
> @@ -36,4 +36,4 @@ obj-$(CONFIG_MSF2) += msf2-soc.o msf2-som.o
>  obj-$(CONFIG_IOTKIT) += iotkit.o
>  obj-$(CONFIG_FSL_IMX7) += fsl-imx7.o mcimx7d-sabre.o
>  obj-$(CONFIG_ARM_SMMUV3) += smmu-common.o smmuv3.o
> -obj-$(CONFIG_NRF51_SOC) += nrf51_soc.o
> +obj-$(CONFIG_NRF51_SOC) += nrf51_soc.o microbit.o
> diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
> new file mode 100644
> index 000000000000..ecf64e883f4f
> --- /dev/null
> +++ b/hw/arm/microbit.c
> @@ -0,0 +1,54 @@
> +/*
> + * BBC micro:bit machine
> + * http://tech.microbit.org/hardware/
> + *
> + * Copyright 2018 Joel Stanley <joel@jms.id.au>
> + *
> + * This code is licensed under the GPL version 2 or later.  See
> + * the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/boards.h"
> +#include "hw/arm/arm.h"
> +#include "exec/address-spaces.h"
> +
> +#include "hw/arm/nrf51_soc.h"
> +
> +typedef struct {
> +    MachineState parent;
> +
> +    NRF51State nrf51;
> +} MICROBITMachineState;

Can we call this "MicrobitMachineState", please? I don't
think the board name is all-caps, and our convention
for struct type names is CamelCase.

> +
> +#define TYPE_MICROBIT_MACHINE "microbit"

Should be MACHINE_TYPE_NAME("microbit")

> +
> +#define MICROBIT_MACHINE(obj) \
> +    OBJECT_CHECK(MICROBITMachineState, obj, TYPE_MICROBIT_MACHINE)
> +
> +static void microbit_init(MachineState *machine)
> +{
> +    MICROBITMachineState *s = g_new(MICROBITMachineState, 1);

This is odd. The MICROBITMachineState is the state struct
for your subclass of MachineState, and that object has
already been allocated (you get a pointer to it as the
argument to the init function here). So all you need to do
is cast it to the right type:
      MICROBITMachineState *s = MICROBIT_MACHINE(machine);

You don't need to allocate a second copy. (You do need to
get the type registration right so that you declare that the
type is of size sizeof(MICROBITMachineState) rather than
just sizeof(MachineState), though -- see below.)

> +    MemoryRegion *system_memory = get_system_memory();
> +    Object *soc;
> +
> +    object_initialize(&s->nrf51, sizeof(s->nrf51), TYPE_NRF51_SOC);
> +    soc = OBJECT(&s->nrf51);
> +    object_property_add_child(OBJECT(machine), "nrf51", soc, &error_fatal);

You should use the new function init_sysbus_child() here
rather than doing separate initialize and add_child steps
(we realised late in the 3.0 cycle that we had refcount
leaks as a result of doing this as a 2-step process, hence
the new function).

> +    object_property_set_link(soc, OBJECT(system_memory),
> +                             "memory", &error_abort);
> +
> +    object_property_set_bool(soc, true, "realized", &error_abort);

Better to use error_fatal rather than error_abort in these two calls,
I think.

> +
> +    arm_m_profile_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
> +            NRF51_SOC(soc)->flash_size);
> +}
> +
> +static void microbit_machine_init(MachineClass *mc)
> +{
> +    mc->desc = "BBC micro:bit";
> +    mc->init = microbit_init;
> +    mc->max_cpus = 1;
> +}
> +DEFINE_MACHINE("microbit", microbit_machine_init);

Your subclass of TYPE_MACHINE has extra state, so it can't
use DEFINE_MACHINE (which creates a subclass whose instance_size
is the same as the parent TYPE_MACHINE). You need to do this
longhand:

static void machine_class_init(ObjectClass *oc, void *data)
{
    MachineClass *mc = MACHINE_CLASS(oc);

    mc->desc = "BBC micro:bit";
    mc->init = microbit_init;
    mc->max_cpus = 1;
}

static const TypeInfo microbit_info = {
    .name = TYPE_MICROBIT_MACHINE,
    .parent = TYPE_MACHINE,
    .instance_size = sizeof(MICROBITMachineState),
    .class_init = microbit_class_init,
};

static void microbit_machine_init(void)
{
    type_register_static(&microbit_info);
}

type_init(microbit_machine_init);


(code untested but should be correct; compare against other boards.)

thanks
-- PMM
