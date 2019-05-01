Received: from eggs.gnu.org ([209.51.188.92]:49023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1hLn8R-0005RN-8Z
	for qemu-devel@nongnu.org; Wed, 01 May 2019 07:10:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1hLn8N-0007BX-Fw
	for qemu-devel@nongnu.org; Wed, 01 May 2019 07:10:47 -0400
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141]:35525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1hLn8J-0007AG-PJ
	for qemu-devel@nongnu.org; Wed, 01 May 2019 07:10:40 -0400
Received: by mail-it1-x141.google.com with SMTP id l140so8043585itb.0
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 04:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190409102935.28292-1-shameerali.kolothum.thodi@huawei.com>
	<20190409102935.28292-4-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20190409102935.28292-4-shameerali.kolothum.thodi@huawei.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 1 May 2019 13:10:24 +0200
Message-ID: <CAKv+Gu_guvAydmCZDeVnj0NR_WyTHeCmwh4tK9WKUBY6cy-4Pg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 3/8] hw/acpi: Add ACPI Generic Event
 Device Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Auger Eric <eric.auger@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, shannon.zhaosl@gmail.com, sameo@linux.intel.com, sebastien.boeuf@intel.com, Wei Xu <xuwei5@hisilicon.com>, Laszlo Ersek <lersek@redhat.com>, Linuxarm <linuxarm@huawei.com>

On Tue, 9 Apr 2019 at 12:31, Shameer Kolothum
<shameerali.kolothum.thodi@huawei.com> wrote:
>
> From: Samuel Ortiz <sameo@linux.intel.com>
>
> The ACPI Generic Event Device (GED) is a hardware-reduced specific
> device[ACPI v6.1 Section 5.6.9] that handles all platform events,
> including the hotplug ones.This patch generates the AML code that
> defines GEDs.
>
> Platforms need to specify their own GedEvent array to describe what
> kind of events they want to support through GED.  Also this uses a
> a single interrupt for the  GED device, relying on IO memory region
> to communicate the type of device affected by the interrupt. This
> way, we can support up to 32 events with a unique interrupt.
>
> This supports only memory hotplug for now.
>
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Apologies if this question has been raised before, but do we really
need a separate device for this? We already handle the power button
via _AEI/_Exx on the GPIO device, and I think we should be able to add
additional events using that interface, rather than have two event
signalling methods/devices on the same platform.



> ---
>  hw/acpi/Kconfig                        |   4 +
>  hw/acpi/Makefile.objs                  |   1 +
>  hw/acpi/generic_event_device.c         | 311 +++++++++++++++++++++++++++++++++
>  include/hw/acpi/generic_event_device.h | 121 +++++++++++++
>  4 files changed, 437 insertions(+)
>  create mode 100644 hw/acpi/generic_event_device.c
>  create mode 100644 include/hw/acpi/generic_event_device.h
>
> diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
> index eca3bee..01a8b41 100644
> --- a/hw/acpi/Kconfig
> +++ b/hw/acpi/Kconfig
> @@ -27,3 +27,7 @@ config ACPI_VMGENID
>      bool
>      default y
>      depends on PC
> +
> +config ACPI_HW_REDUCED
> +    bool
> +    depends on ACPI
> diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
> index 2d46e37..b753232 100644
> --- a/hw/acpi/Makefile.objs
> +++ b/hw/acpi/Makefile.objs
> @@ -6,6 +6,7 @@ common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) += memory_hotplug.o
>  common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) += cpu.o
>  common-obj-$(CONFIG_ACPI_NVDIMM) += nvdimm.o
>  common-obj-$(CONFIG_ACPI_VMGENID) += vmgenid.o
> +common-obj-$(CONFIG_ACPI_HW_REDUCED) += generic_event_device.o
>  common-obj-$(call lnot,$(CONFIG_ACPI_X86)) += acpi-stub.o
>
>  common-obj-y += acpi_interface.o
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> new file mode 100644
> index 0000000..856ca04
> --- /dev/null
> +++ b/hw/acpi/generic_event_device.c
> @@ -0,0 +1,311 @@
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
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "exec/address-spaces.h"
> +#include "hw/sysbus.h"
> +#include "hw/acpi/acpi.h"
> +#include "hw/acpi/generic_event_device.h"
> +#include "hw/mem/pc-dimm.h"
> +
> +static Aml *ged_event_aml(const GedEvent *event)
> +{
> +
> +    if (!event) {
> +        return NULL;
> +    }
> +
> +    switch (event->event) {
> +    case GED_MEMORY_HOTPLUG:
> +        /* We run a complete memory SCAN when getting a memory hotplug event */
> +        return aml_call0(MEMORY_DEVICES_CONTAINER "." MEMORY_SLOT_SCAN_METHOD);
> +    default:
> +        break;
> +    }
> +
> +    return NULL;
> +}
> +
> +/*
> + * The ACPI Generic Event Device (GED) is a hardware-reduced specific
> + * device[ACPI v6.1 Section 5.6.9] that handles all platform events,
> + * including the hotplug ones. Platforms need to specify their own
> + * GedEvent array to describe what kind of events they want to support
> + * through GED. This routine uses a single interrupt for the GED device,
> + * relying on IO memory region to communicate the type of device
> + * affected by the interrupt. This way, we can support up to 32 events
> + * with a unique interrupt.
> + */
> +void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
> +                   uint32_t ged_irq, AmlRegionSpace rs)
> +{
> +    AcpiGedState *s = ACPI_GED(hotplug_dev);
> +    GedEvent *ged_events = s->ged_events;
> +    Aml *crs = aml_resource_template();
> +    Aml *evt, *field;
> +    Aml *dev = aml_device("%s", name);
> +    Aml *irq_sel = aml_local(0);
> +    Aml *isel = aml_name(AML_GED_IRQ_SEL);
> +    uint32_t i;
> +
> +    if (!s->ged_base || !ged_events || !s->ged_events_size) {
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
> +         * ...
> +         */
> +
> +        for (i = 0; i < s->ged_events_size; i++) {
> +            ged_aml = ged_event_aml(&ged_events[i]);
> +            if (!ged_aml) {
> +                continue;
> +            }
> +
> +            /* If ((Local1 == irq))*/
> +            if_ctx = aml_if(aml_equal(aml_and(irq_sel,
> +                                      aml_int(ged_events[i].selector), NULL),
> +                                      aml_int(ged_events[i].selector)));
> +            {
> +                /* AML for this specific type of event */
> +                aml_append(if_ctx, ged_aml);
> +            }
> +
> +            /*
> +             * We append the first "if" to the "while" context.
> +             * Other "if"s will be "elseif"s.
> +             */
> +            aml_append(evt, if_ctx);
> +        }
> +    }
> +
> +    aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0013")));
> +    aml_append(dev, aml_name_decl("_UID", aml_string(GED_DEVICE)));
> +    aml_append(dev, aml_name_decl("_CRS", crs));
> +
> +    /* Append IO region */
> +    aml_append(dev, aml_operation_region(AML_GED_IRQ_REG, rs,
> +               aml_int(s->ged_base + ACPI_GED_IRQ_SEL_OFFSET),
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
> +
> +/* Memory read by the GED _EVT AML dynamic method */
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
> +        ged_st->sel = 0;
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
> +static void acpi_ged_event(GEDState *ged_st, uint32_t ged_irq_sel)
> +{
> +    /*
> +     * Set the GED IRQ selector to the expected device type value. This
> +     * way, the ACPI method will be able to trigger the right code based
> +     * on a unique IRQ.
> +     */
> +    qemu_mutex_lock(&ged_st->lock);
> +    ged_st->sel = ged_irq_sel;
> +    qemu_mutex_unlock(&ged_st->lock);
> +
> +    /* Trigger the event by sending an interrupt to the guest. */
> +    qemu_irq_pulse(ged_st->gsi[ged_st->irq]);
> +}
> +
> +static void acpi_ged_init(MemoryRegion *as, DeviceState *dev, GEDState *ged_st)
> +{
> +    AcpiGedState *s = ACPI_GED(dev);
> +
> +    assert(s->ged_base);
> +
> +    ged_st->irq = s->ged_irq;
> +    ged_st->gsi = s->gsi;
> +    qemu_mutex_init(&ged_st->lock);
> +    memory_region_init_io(&ged_st->io, OBJECT(dev), &ged_ops, ged_st,
> +                          "acpi-ged-event", ACPI_GED_REG_LEN);
> +    memory_region_add_subregion(as, s->ged_base, &ged_st->io);
> +}
> +
> +static void acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
> +                                    DeviceState *dev, Error **errp)
> +{
> +    AcpiGedState *s = ACPI_GED(hotplug_dev);
> +
> +    if (s->memhp_state.is_enabled &&
> +        object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> +            acpi_memory_plug_cb(hotplug_dev, &s->memhp_state,
> +                                dev, errp);
> +    } else {
> +        error_setg(errp, "virt: device plug request for unsupported device"
> +                   " type: %s", object_get_typename(OBJECT(dev)));
> +    }
> +}
> +
> +static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
> +{
> +    AcpiGedState *s = ACPI_GED(adev);
> +    uint32_t sel;
> +
> +    if (ev & ACPI_MEMORY_HOTPLUG_STATUS) {
> +        sel = ACPI_GED_IRQ_SEL_MEM;
> +    } else {
> +        /* Unknown event. Return without generating interrupt. */
> +        return;
> +    }
> +
> +    /*
> +     * We inject the hotplug interrupt. The IRQ selector will make
> +     * the difference from the ACPI table.
> +     */
> +    acpi_ged_event(&s->ged_state, sel);
> +}
> +
> +static void acpi_ged_device_realize(DeviceState *dev, Error **errp)
> +{
> +    AcpiGedState *s = ACPI_GED(dev);
> +
> +    if (s->memhp_state.is_enabled) {
> +        acpi_memory_hotplug_init(get_system_memory(), OBJECT(dev),
> +                                 &s->memhp_state,
> +                                 s->memhp_base);
> +        acpi_ged_init(get_system_memory(), dev, &s->ged_state);
> +    }
> +}
> +
> +static Property acpi_ged_properties[] = {
> +    /*
> +     * Memory hotplug base address is a property of GED here,
> +     * because GED handles memory hotplug event and MEMORY_HOTPLUG_DEVICE
> +     * gets initialized when GED device is realized.
> +     */
> +    DEFINE_PROP_UINT64("memhp-base", AcpiGedState, memhp_base, 0),
> +    DEFINE_PROP_BOOL("memory-hotplug-support", AcpiGedState,
> +                     memhp_state.is_enabled, true),
> +    DEFINE_PROP_PTR("gsi", AcpiGedState, gsi),
> +    DEFINE_PROP_UINT64("ged-base", AcpiGedState, ged_base, 0),
> +    DEFINE_PROP_UINT32("ged-irq", AcpiGedState, ged_irq, 0),
> +    DEFINE_PROP_PTR("ged-events", AcpiGedState, ged_events),
> +    DEFINE_PROP_UINT32("ged-events-size", AcpiGedState, ged_events_size, 0),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void acpi_ged_class_init(ObjectClass *class, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(class);
> +    HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(class);
> +    AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_CLASS(class);
> +
> +    dc->desc = "ACPI";
> +    dc->props = acpi_ged_properties;
> +    dc->realize = acpi_ged_device_realize;
> +
> +    /* Reason: pointer properties "gsi" and "ged_events" */
> +    dc->user_creatable = false;
> +
> +    hc->plug = acpi_ged_device_plug_cb;
> +
> +    adevc->send_event = acpi_ged_send_event;
> +}
> +
> +static const TypeInfo acpi_ged_info = {
> +    .name          = TYPE_ACPI_GED,
> +    .parent        = TYPE_DEVICE,
> +    .instance_size = sizeof(AcpiGedState),
> +    .class_init    = acpi_ged_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { TYPE_HOTPLUG_HANDLER },
> +        { TYPE_ACPI_DEVICE_IF },
> +        { }
> +    }
> +};
> +
> +static void acpi_ged_register_types(void)
> +{
> +    type_register_static(&acpi_ged_info);
> +}
> +
> +type_init(acpi_ged_register_types)
> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> new file mode 100644
> index 0000000..9c840d8
> --- /dev/null
> +++ b/include/hw/acpi/generic_event_device.h
> @@ -0,0 +1,121 @@
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
> + *
> + * The ACPI Generic Event Device (GED) is a hardware-reduced specific
> + * device[ACPI v6.1 Section 5.6.9] that handles all platform events,
> + * including the hotplug ones. Generic Event Device allows platforms
> + * to handle interrupts in ACPI ASL statements. It follows a very
> + * similar approach like the _EVT method from GPIO events. All
> + * interrupts are listed in  _CRS and the handler is written in _EVT
> + * method. Here, we use a single interrupt for the GED device, relying
> + * on IO memory region to communicate the type of device affected by
> + * the interrupt. This way, we can support up to 32 events with a
> + * unique interrupt.
> + *
> + * Here is an example.
> + *
> + * Device (\_SB.GED)
> + * {
> + *     Name (_HID, "ACPI0013")
> + *     Name (_UID, Zero)
> + *     Name (_CRS, ResourceTemplate ()
> + *     {
> + *         Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, ,, )
> + *         {
> + *              0x00000029,
> + *         }
> + *     })
> + *     OperationRegion (IREG, SystemMemory, 0x09080000, 0x04)
> + *     Field (IREG, DWordAcc, NoLock, WriteAsZeros)
> + *     {
> + *         ISEL,   32
> + *     }
> + *
> + *     Method (_EVT, 1, Serialized)  // _EVT: Event
> + *     {
> + *         Local0 = ISEL // ISEL = IO memory region which specifies the
> + *                       // device type.
> + *         If (((Local0 & irq0) == irq0))
> + *         {
> + *             MethodEvent0()
> + *         }
> + *         ElseIf ((Local0 & irq1) == irq1)
> + *         {
> + *             MethodEvent1()
> + *         }
> + *         ...
> + *     }
> + * }
> + *
> + */
> +
> +#ifndef HW_ACPI_GED_H
> +#define HW_ACPI_GED_H
> +
> +#include "hw/acpi/memory_hotplug.h"
> +
> +#define TYPE_ACPI_GED "acpi-ged"
> +#define ACPI_GED(obj) \
> +    OBJECT_CHECK(AcpiGedState, (obj), TYPE_ACPI_GED)
> +
> +#define ACPI_GED_IRQ_SEL_OFFSET 0x0
> +#define ACPI_GED_IRQ_SEL_LEN    0x4
> +#define ACPI_GED_IRQ_SEL_MEM    0x1
> +#define ACPI_GED_REG_LEN        0x4
> +
> +#define GED_DEVICE      "GED"
> +#define AML_GED_IRQ_REG "IREG"
> +#define AML_GED_IRQ_SEL "ISEL"
> +
> +typedef enum {
> +    GED_MEMORY_HOTPLUG = 1,
> +} GedEventType;
> +
> +/*
> + * Platforms need to specify their own GedEvent array
> + * to describe what kind of events they want to support
> + * through GED.
> + */
> +typedef struct GedEvent {
> +    uint32_t     selector;
> +    GedEventType event;
> +} GedEvent;
> +
> +typedef struct GEDState {
> +    MemoryRegion io;
> +    uint32_t     sel;
> +    uint32_t     irq;
> +    qemu_irq     *gsi;
> +    QemuMutex    lock;
> +} GEDState;
> +
> +
> +typedef struct AcpiGedState {
> +    DeviceClass parent_obj;
> +    MemHotplugState memhp_state;
> +    hwaddr memhp_base;
> +    void *gsi;
> +    hwaddr ged_base;
> +    GEDState ged_state;
> +    uint32_t ged_irq;
> +    void *ged_events;
> +    uint32_t ged_events_size;
> +} AcpiGedState;
> +
> +void build_ged_aml(Aml *table, const char* name, HotplugHandler *hotplug_dev,
> +                   uint32_t ged_irq, AmlRegionSpace rs);
> +
> +#endif
> --
> 2.7.4
>
>
