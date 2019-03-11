Received: from eggs.gnu.org ([209.51.188.92]:46709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1h3RT2-0006Jm-Sp
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:24:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1h3RT1-0003fu-0E
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:24:12 -0400
References: <20190308114218.26692-1-shameerali.kolothum.thodi@huawei.com>
	<20190308114218.26692-10-shameerali.kolothum.thodi@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <26c9228c-cb93-375d-11e2-4931fd939966@redhat.com>
Date: Mon, 11 Mar 2019 21:23:59 +0100
MIME-Version: 1.0
In-Reply-To: <20190308114218.26692-10-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 09/11] hw/acpi: Add ACPI Generic Event
 Device Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, imammedo@redhat.com, peter.maydell@linaro.org, shannon.zhaosl@gmail.com, sameo@linux.intel.com, sebastien.boeuf@intel.com
Cc: linuxarm@huawei.com, xuwei5@hisilicon.com

Hi,

On 3/8/19 12:42 PM, Shameer Kolothum wrote:
> From: Samuel Ortiz <sameo@linux.intel.com>
> 
> The ACPI Generic Event Device (GED) is a hardware-reduced specific
> device that handles all platform events, including the hotplug ones.
> This patch generate the AML code that defines GEDs.
s/generate/generates
> Platforms need to specify their own GedEvent array to describe what kind
> of events they want to support through GED. The build_ged_aml routine
> takes a GedEvent array that maps a specific GED event to an IRQ number.
> Then we use that array to build both the _CRS and the _EVT section
> of the GED device.
> 
> This is in preparation for making use of GED for ARM/virt
> platform and for now supports only memory hotplug.
> 
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/acpi/Makefile.objs |   1 +
>  hw/acpi/ged.c         | 198 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/hw/acpi/ged.h |  61 ++++++++++++++++
>  3 files changed, 260 insertions(+)
>  create mode 100644 hw/acpi/ged.c
>  create mode 100644 include/hw/acpi/ged.h
> 
> diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
> index 2d46e37..6cf572b 100644
> --- a/hw/acpi/Makefile.objs
> +++ b/hw/acpi/Makefile.objs
> @@ -6,6 +6,7 @@ common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) += memory_hotplug.o
>  common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) += cpu.o
>  common-obj-$(CONFIG_ACPI_NVDIMM) += nvdimm.o
>  common-obj-$(CONFIG_ACPI_VMGENID) += vmgenid.o
> +common-obj-$(CONFIG_ACPI_HW_REDUCED) += ged.o
>  common-obj-$(call lnot,$(CONFIG_ACPI_X86)) += acpi-stub.o
>  
>  common-obj-y += acpi_interface.o
> diff --git a/hw/acpi/ged.c b/hw/acpi/ged.c
> new file mode 100644
> index 0000000..5076fbc
> --- /dev/null
> +++ b/hw/acpi/ged.c
> @@ -0,0 +1,198 @@
> +/*
> + *
> + * Copyright (c) 2018 Intel Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "hw/acpi/ged.h"
Add a comment giving a short description of what is the GED, available
since 6.1 spec?
> +
> +static hwaddr ged_io_base;
 Couldn't we add a comment such as, "read by the GED _EVT AML dynamic
method"?
> +static uint64_t ged_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    uint64_t val = 0;
> +    GEDState *ged_st = opaque;
> +
> +    switch (addr) {
> +    case ACPI_GED_IRQ_SEL_OFFSET:
> +        /* Read the selector value and reset it */
> +        qemu_mutex_lock(&ged_st->lock);
> +        val = ged_st->sel;
> +        ged_st->sel = ACPI_GED_IRQ_SEL_INIT;
using 0 instead of ACPI_GED_IRQ_SEL_INIT may be clearer?
> +        qemu_mutex_unlock(&ged_st->lock);
> +        break;
> +    default:
> +        break;
> +    }
> +
> +    return val;
> +}
> +
> +/* Nothing is expected to be written to the GED memory region */
> +static void ged_write(void *opaque, hwaddr addr, uint64_t data,
> +                      unsigned int size)
> +{
> +}
> +
> +static const MemoryRegionOps ged_ops = {
> +    .read = ged_read,
> +    .write = ged_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +void acpi_ged_init(MemoryRegion *as, Object *owner, GEDState *ged_st,
> +                   hwaddr base_addr, uint32_t ged_irq)
Maybe directly pass the qemu_irq* and store it into the GEDState
> +{
> +
> +    assert(!ged_io_base);
> +
> +    ged_io_base = base_addr;
> +    ged_st->irq = ged_irq;
> +    qemu_mutex_init(&ged_st->lock);
> +    memory_region_init_io(&ged_st->io, owner, &ged_ops, ged_st,
> +                          "acpi-ged-event", ACPI_GED_REG_LEN);
> +    memory_region_add_subregion(as, base_addr, &ged_st->io);
> +}
> +
> +void acpi_ged_event(GEDState *ged_st, qemu_irq *irq, uint32_t ged_irq_sel)
... then you wouldn't need the irq parameter here?
> +{
> +    /*
> +     * Set the GED IRQ selector to the expected device type value. This
> +     * way, the ACPI method will be able to trigger the right code based
> +     * on a unique IRQ.
> +     */
> +    qemu_mutex_lock(&ged_st->lock);
> +    ged_st->sel |= ged_irq_sel;
is it allowed to have several events logged simultaneously? _EVT args is
described as "EventNumber: An integer indicating the event number (GSIV
number) of the current event"
> +    qemu_mutex_unlock(&ged_st->lock);
> +
> +    /* Trigger the event by sending an interrupt to the guest. */
> +    qemu_irq_pulse(irq[ged_st->irq]);
Is it valid to consider the irq always is edge sensitive? I understand
from the spec the irq mode may be platform dependent.
> +}
> +
> +static Aml *ged_event_aml(GedEvent *event)
> +{
> +
> +    if (!event) {
> +        return NULL;
> +    }
> +
> +    switch (event->event) {
> +    case GED_MEMORY_HOTPLUG:
> +        /* We run a complete memory SCAN when getting a memory hotplug event */
> +        return aml_call0("\\_SB.MHPC." MEMORY_SLOT_SCAN_METHOD);
use MEMORY_DEVICES_CONTAINER now exposed in
include/hw/acpi/memory_hotplug.h?
> +    default:
> +        break;
> +    }
> +
> +    return NULL;
> +}
> +
> +void build_ged_aml(Aml *table, const char *name, uint32_t ged_irq,
> +                   GedEvent *events, uint32_t events_size,
> +                   AmlRegionSpace rs)
> +{
> +    Aml *crs = aml_resource_template();
> +    Aml *evt, *field;
> +    Aml *zero = aml_int(0);
> +    Aml *dev = aml_device("%s", name);
> +    Aml *irq_sel = aml_local(0);
> +    Aml *isel = aml_name(AML_GED_IRQ_SEL);
> +    uint32_t i;
> +
> +    if (!ged_io_base) {
> +        return;
> +    }
> +
> +    /* _CRS interrupt */
> +    aml_append(crs, aml_interrupt(AML_CONSUMER, AML_EDGE, AML_ACTIVE_HIGH,
> +                                  AML_EXCLUSIVE, &ged_irq, 1));
> +    /*
> +     * For each GED event we:
> +     * - Add an interrupt to the CRS section.
> +     * - Add a conditional block for each event, inside a while loop.
> +     *   This is semantically equivalent to a switch/case implementation.
> +     */
> +    evt = aml_method("_EVT", 1, AML_SERIALIZED);
> +    {
> +        Aml *ged_aml;
> +        Aml *if_ctx;
> +
> +        /* Local0 = ISEL */
> +        aml_append(evt, aml_store(isel, irq_sel));
> +
> +        /*
> +         * Here we want to call a method for each supported GED event type.
> +         * The resulting ASL code looks like:
> +         *
> +         * Local0 = ISEL
> +         * If ((Local0 & irq0) == irq0)
> +         * {
> +         *     MethodEvent0()
> +         * }
> +         *
> +         * If ((Local0 & irq1) == irq1)
> +         * {
> +         *     MethodEvent1()
> +         * }
> +         *
> +         * If ((Local0 & irq2) == irq2)
> +         * {
> +         *     MethodEvent2()
> +         * }
> +         */
> +
> +        for (i = 0; i < events_size; i++) {
> +            ged_aml = ged_event_aml(&events[i]);
> +            if (!ged_aml) {
> +                continue;
> +            }
> +
> +            /* If ((Local1 == irq))*/
> +            if_ctx = aml_if(aml_equal(aml_and(irq_sel, aml_int(events[i].selector), NULL), aml_int(events[i].selector)));
> +            {
> +                /* AML for this specific type of event */
> +                aml_append(if_ctx, ged_aml);
> +            }
> +
> +            /*
> +             * We append the first if to the while context.
We append the first "if" to the "while" context.
> +             * Other ifs will be elseifs.
> +             */
> +            aml_append(evt, if_ctx);
> +        }
> +    }
> +
> +    aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0013")));
> +    aml_append(dev, aml_name_decl("_UID", zero));
can't we use something different from 0 like a aml_string("GED")?
> +    aml_append(dev, aml_name_decl("_CRS", crs));
> +
> +    /* Append IO region */
> +    aml_append(dev, aml_operation_region(AML_GED_IRQ_REG, rs,
> +               aml_int(ged_io_base + ACPI_GED_IRQ_SEL_OFFSET),
> +               ACPI_GED_IRQ_SEL_LEN));
> +    field = aml_field(AML_GED_IRQ_REG, AML_DWORD_ACC, AML_NOLOCK,
> +                      AML_WRITE_AS_ZEROS);
> +    aml_append(field, aml_named_field(AML_GED_IRQ_SEL,
> +                                      ACPI_GED_IRQ_SEL_LEN * 8));
> +    aml_append(dev, field);
> +
> +    /* Append _EVT method */
> +    aml_append(dev, evt);
> +
> +    aml_append(table, dev);
> +}
Spec says "The platform declare its support for the GED, and query
whether an OS supports it, via the _OSC method". \_SB._OSC. I fail to
see that method defined?
> diff --git a/include/hw/acpi/ged.h b/include/hw/acpi/ged.h
> new file mode 100644
> index 0000000..60689b0
> --- /dev/null
> +++ b/include/hw/acpi/ged.h
> @@ -0,0 +1,61 @@
> +/*
> + *
> + * Copyright (c) 2018 Intel Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_ACPI_GED_H
> +#define HW_ACPI_GED_H
> +
> +#include "qemu/osdep.h"
> +#include "exec/memory.h"
> +#include "hw/acpi/aml-build.h"
> +#include "hw/acpi/memory_hotplug.h"
> +
> +#define ACPI_GED_IRQ_SEL_OFFSET 0x0
> +#define ACPI_GED_IRQ_SEL_LEN    0x4
> +#define ACPI_GED_IRQ_SEL_INIT   0x0
> +#define ACPI_GED_IRQ_SEL_MEM    0x1
> +#define ACPI_GED_REG_LEN        0x4
> +
> +#define GED_DEVICE      "GED"
> +#define AML_GED_IRQ_REG "IREG"
> +#define AML_GED_IRQ_SEL "ISEL"
> +
> +typedef struct Aml Aml;
> +
> +typedef enum {
> +    GED_MEMORY_HOTPLUG = 1,
> +} GedEventType;
> +
> +typedef struct GedEvent {
> +    uint32_t     selector;Add a comment saying this corresponds to GSIV number?
> +    GedEventType event;
> +} GedEvent;
> +
> +typedef struct GEDState {
> +    MemoryRegion io;
> +    uint32_t     sel;
> +    uint32_t     irq;
why not storing the qemu_irq* directly?
> +    QemuMutex    lock;
> +} GEDState;
> +
> +void acpi_ged_init(MemoryRegion *as, Object *owner, GEDState *ged_st,
> +                   hwaddr base_addr, uint32_t ged_irq);
> +void acpi_ged_event(GEDState *ged_st, qemu_irq *irq, uint32_t ged_irq_sel);
> +void build_ged_aml(Aml *table, const char* name, uint32_t ged_irq,
> +                   GedEvent *events, uint32_t events_size,
> +                   AmlRegionSpace rs);
> +
> +#endif
> 

Thanks

Eric
