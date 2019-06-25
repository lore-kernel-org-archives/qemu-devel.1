Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B00CC48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 12:29:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D0F7213F2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 12:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D0F7213F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59676 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfkZU-0007IJ-Bv
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 08:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36355)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1hfkMw-0007El-NS
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 08:16:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1hfkMm-0004Gn-Bq
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 08:16:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2247 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1hfkMW-000453-OD; Tue, 25 Jun 2019 08:15:50 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 6CDC1307F09D6D18EFA0;
 Tue, 25 Jun 2019 20:15:44 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.202.227.237) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Tue, 25 Jun 2019 20:15:36 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <eric.auger@redhat.com>,
 <imammedo@redhat.com>
Date: Tue, 25 Jun 2019 13:14:16 +0100
Message-ID: <20190625121421.22280-4-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20190625121421.22280-1-shameerali.kolothum.thodi@huawei.com>
References: <20190625121421.22280-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.237]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.191
Subject: [Qemu-devel] [PATCH v6 3/8] hw/acpi: Add ACPI Generic Event Device
 Support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, ard.biesheuvel@linaro.org,
 linuxarm@huawei.com, xuwei5@hisilicon.com, shannon.zhaosl@gmail.com,
 sebastien.boeuf@intel.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Samuel Ortiz <sameo@linux.intel.com>

The ACPI Generic Event Device (GED) is a hardware-reduced specific
device[ACPI v6.1 Section 5.6.9] that handles all platform events,
including the hotplug ones. This patch generates the AML code that
defines GEDs.

Platforms need to specify their own GED Event bitmap to describe
what kind of events they want to support through GED.  Also this
uses a a single interrupt for the  GED device, relying on IO
memory region to communicate the type of device affected by the
interrupt. This way, we can support up to 32 events with a unique
interrupt.

This supports only memory hotplug for now.

Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
v5-->v6
-Added !s->memhp_state.is_enabled case handling.
-Addressed other comments on v5
 
v4-->v5
 -Removed gsi/irq routing code.
 -Changed GED Event array to bitmap.
 -Added Migration support

---
 hw/acpi/Kconfig                        |   4 +
 hw/acpi/Makefile.objs                  |   1 +
 hw/acpi/generic_event_device.c         | 336 +++++++++++++++++++++++++
 include/hw/acpi/generic_event_device.h | 102 ++++++++
 4 files changed, 443 insertions(+)
 create mode 100644 hw/acpi/generic_event_device.c
 create mode 100644 include/hw/acpi/generic_event_device.h

diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
index 7c59cf900b..12e3f1e86e 100644
--- a/hw/acpi/Kconfig
+++ b/hw/acpi/Kconfig
@@ -31,3 +31,7 @@ config ACPI_VMGENID
     bool
     default y
     depends on PC
+
+config ACPI_HW_REDUCED
+    bool
+    depends on ACPI
diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
index 9bb2101e3b..655a9c1973 100644
--- a/hw/acpi/Makefile.objs
+++ b/hw/acpi/Makefile.objs
@@ -6,6 +6,7 @@ common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) += memory_hotplug.o
 common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) += cpu.o
 common-obj-$(CONFIG_ACPI_NVDIMM) += nvdimm.o
 common-obj-$(CONFIG_ACPI_VMGENID) += vmgenid.o
+common-obj-$(CONFIG_ACPI_HW_REDUCED) += generic_event_device.o
 common-obj-$(call lnot,$(CONFIG_ACPI_X86)) += acpi-stub.o
 
 common-obj-y += acpi_interface.o
diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
new file mode 100644
index 0000000000..2a83d68e82
--- /dev/null
+++ b/hw/acpi/generic_event_device.c
@@ -0,0 +1,336 @@
+/*
+ *
+ * Copyright (c) 2018 Intel Corporation
+ * Copyright (c) 2019 Huawei Technologies R & D (UK) Ltd
+ * Written by Samuel Ortiz, Shameer Kolothum
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "exec/address-spaces.h"
+#include "hw/acpi/acpi.h"
+#include "hw/acpi/generic_event_device.h"
+#include "hw/mem/pc-dimm.h"
+#include "qemu/error-report.h"
+
+static const uint32_t ged_supported_events[] = {
+    ACPI_GED_MEM_HOTPLUG_EVT,
+};
+
+/*
+ * The ACPI Generic Event Device (GED) is a hardware-reduced specific
+ * device[ACPI v6.1 Section 5.6.9] that handles all platform events,
+ * including the hotplug ones. Platforms need to specify their own
+ * GED Event bitmap to describe what kind of events they want to support
+ * through GED. This routine uses a single interrupt for the GED device,
+ * relying on IO memory region to communicate the type of device
+ * affected by the interrupt. This way, we can support up to 32 events
+ * with a unique interrupt.
+ */
+void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
+                   uint32_t ged_irq, AmlRegionSpace rs)
+{
+    AcpiGedState *s = ACPI_GED(hotplug_dev);
+    Aml *crs = aml_resource_template();
+    Aml *evt, *field;
+    Aml *dev = aml_device("%s", name);
+    Aml *evt_sel = aml_local(0);
+    Aml *esel = aml_name(AML_GED_EVT_SEL);
+
+    assert(s->ged_base);
+
+    /* _CRS interrupt */
+    aml_append(crs, aml_interrupt(AML_CONSUMER, AML_EDGE, AML_ACTIVE_HIGH,
+                                  AML_EXCLUSIVE, &ged_irq, 1));
+
+    aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0013")));
+    aml_append(dev, aml_name_decl("_UID", aml_string(GED_DEVICE)));
+    aml_append(dev, aml_name_decl("_CRS", crs));
+
+    /* Append IO region */
+    aml_append(dev, aml_operation_region(AML_GED_EVT_REG, rs,
+               aml_int(s->ged_base + ACPI_GED_EVT_SEL_OFFSET),
+               ACPI_GED_EVT_SEL_LEN));
+    field = aml_field(AML_GED_EVT_REG, AML_DWORD_ACC, AML_NOLOCK,
+                      AML_WRITE_AS_ZEROS);
+    aml_append(field, aml_named_field(AML_GED_EVT_SEL,
+                                      ACPI_GED_EVT_SEL_LEN * BITS_PER_BYTE));
+    aml_append(dev, field);
+
+    /*
+     * For each GED event we:
+     * - Add a conditional block for each event, inside a loop.
+     * - Call a method for each supported GED event type.
+     *
+     * The resulting ASL code looks like:
+     *
+     * Local0 = ESEL
+     * If ((Local0 & One) == One)
+     * {
+     *     MethodEvent0()
+     * }
+     *
+     * If ((Local0 & 0x2) == 0x2)
+     * {
+     *     MethodEvent1()
+     * }
+     * ...
+     */
+    evt = aml_method("_EVT", 1, AML_SERIALIZED);
+    {
+        Aml *if_ctx;
+        uint32_t i;
+        uint32_t ged_events = ctpop32(s->ged_event_bitmap);
+
+        /* Local0 = ESEL */
+        aml_append(evt, aml_store(esel, evt_sel));
+
+        for (i = 0; i < ARRAY_SIZE(ged_supported_events) && ged_events; i++) {
+            uint32_t event = s->ged_event_bitmap & ged_supported_events[i];
+
+            if (!event) {
+                continue;
+            }
+
+            if_ctx = aml_if(aml_equal(aml_and(evt_sel, aml_int(event), NULL),
+                                      aml_int(event)));
+            switch (event) {
+            case ACPI_GED_MEM_HOTPLUG_EVT:
+                aml_append(if_ctx, aml_call0(MEMORY_DEVICES_CONTAINER "."
+                                             MEMORY_SLOT_SCAN_METHOD));
+                break;
+            default:
+                /*
+                 * Please make sure all the events in ged_supported_events[]
+                 * are handled above.
+                 */
+                g_assert_not_reached();
+            }
+
+            aml_append(evt, if_ctx);
+            ged_events--;
+        }
+
+        if (ged_events) {
+            error_report("GED: Unsupported events specified");
+            exit(1);
+        }
+    }
+
+    /* Append _EVT method */
+    aml_append(dev, evt);
+
+    aml_append(table, dev);
+}
+
+/* Memory read by the GED _EVT AML dynamic method */
+static uint64_t ged_read(void *opaque, hwaddr addr, unsigned size)
+{
+    uint64_t val = 0;
+    GEDState *ged_st = opaque;
+
+    switch (addr) {
+    case ACPI_GED_EVT_SEL_OFFSET:
+        /* Read the selector value and reset it */
+        qemu_mutex_lock(&ged_st->lock);
+        val = ged_st->sel;
+        ged_st->sel = 0;
+        qemu_mutex_unlock(&ged_st->lock);
+        break;
+    default:
+        break;
+    }
+
+    return val;
+}
+
+/* Nothing is expected to be written to the GED memory region */
+static void ged_write(void *opaque, hwaddr addr, uint64_t data,
+                      unsigned int size)
+{
+}
+
+static const MemoryRegionOps ged_ops = {
+    .read = ged_read,
+    .write = ged_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void acpi_ged_event(AcpiGedState *s, uint32_t sel)
+{
+    GEDState *ged_st = &s->ged_state;
+    /*
+     * Set the GED IRQ selector to the expected device type value. This
+     * way, the ACPI method will be able to trigger the right code based
+     * on a unique IRQ.
+     */
+    qemu_mutex_lock(&ged_st->lock);
+    ged_st->sel |= sel;
+    qemu_mutex_unlock(&ged_st->lock);
+
+    /* Trigger the event by sending an interrupt to the guest. */
+    qemu_irq_pulse(s->irq);
+}
+
+static void acpi_ged_init(MemoryRegion *as, DeviceState *dev, GEDState *ged_st)
+{
+    AcpiGedState *s = ACPI_GED(dev);
+
+    assert(s->ged_base);
+
+    qemu_mutex_init(&ged_st->lock);
+    memory_region_init_io(&ged_st->io, OBJECT(dev), &ged_ops, ged_st,
+                          TYPE_ACPI_GED, ACPI_GED_REG_LEN);
+    memory_region_add_subregion(as, s->ged_base, &ged_st->io);
+    qdev_init_gpio_out_named(DEVICE(s), &s->irq, "ged-irq", 1);
+}
+
+static void acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
+                                    DeviceState *dev, Error **errp)
+{
+    AcpiGedState *s = ACPI_GED(hotplug_dev);
+
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
+        if (s->memhp_state.is_enabled) {
+            acpi_memory_plug_cb(hotplug_dev, &s->memhp_state, dev, errp);
+        } else {
+            error_setg(errp,
+                 "memory hotplug is not enabled: %s.memory-hotplug-support "
+                 "is not set", object_get_typename(OBJECT(s)));
+        }
+    } else {
+        error_setg(errp, "virt: device plug request for unsupported device"
+                   " type: %s", object_get_typename(OBJECT(dev)));
+    }
+}
+
+static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
+{
+    AcpiGedState *s = ACPI_GED(adev);
+    uint32_t sel;
+
+    if (ev & ACPI_MEMORY_HOTPLUG_STATUS) {
+        sel = ACPI_GED_MEM_HOTPLUG_EVT;
+    } else {
+        /* Unknown event. Return without generating interrupt. */
+        warn_report("GED: Unsupported event %d. No irq injected", ev);
+        return;
+    }
+
+    /*
+     * We inject the hotplug interrupt. The IRQ selector will make
+     * the difference from the ACPI table.
+     */
+    acpi_ged_event(s, sel);
+}
+
+static void acpi_ged_device_realize(DeviceState *dev, Error **errp)
+{
+    AcpiGedState *s = ACPI_GED(dev);
+
+    if (s->memhp_state.is_enabled) {
+        acpi_memory_hotplug_init(get_system_memory(), OBJECT(dev),
+                                 &s->memhp_state,
+                                 s->memhp_base);
+    }
+
+    acpi_ged_init(get_system_memory(), dev, &s->ged_state);
+}
+
+static Property acpi_ged_properties[] = {
+    /*
+     * Memory hotplug base address is a property of GED here,
+     * because GED handles memory hotplug event and acpi-mem-hotplug
+     * memory region gets initialized when GED device is realized.
+     */
+    DEFINE_PROP_UINT64("memhp-base", AcpiGedState, memhp_base, 0),
+    DEFINE_PROP_BOOL("memory-hotplug-support", AcpiGedState,
+                     memhp_state.is_enabled, true),
+    DEFINE_PROP_UINT64("ged-base", AcpiGedState, ged_base, 0),
+    DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static bool vmstate_test_use_memhp(void *opaque)
+{
+    AcpiGedState *s = opaque;
+    return s->memhp_state.is_enabled;
+}
+
+static const VMStateDescription vmstate_memhp_state = {
+    .name = "acpi-ged/memhp",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = vmstate_test_use_memhp,
+    .fields      = (VMStateField[]) {
+        VMSTATE_MEMORY_HOTPLUG(memhp_state, AcpiGedState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_ged_state = {
+    .name = "acpi-ged-state",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields      = (VMStateField[]) {
+        VMSTATE_UINT32(sel, GEDState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_acpi_ged = {
+    .name = "acpi-ged",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_STRUCT(ged_state, AcpiGedState, 1, vmstate_ged_state, GEDState),
+        VMSTATE_END_OF_LIST(),
+    },
+    .subsections = (const VMStateDescription * []) {
+        &vmstate_memhp_state,
+        NULL
+    }
+};
+
+static void acpi_ged_class_init(ObjectClass *class, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(class);
+    HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(class);
+    AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_CLASS(class);
+
+    dc->desc = "ACPI Generic Event Device";
+    dc->props = acpi_ged_properties;
+    dc->realize = acpi_ged_device_realize;
+    dc->vmsd = &vmstate_acpi_ged;
+
+    hc->plug = acpi_ged_device_plug_cb;
+
+    adevc->send_event = acpi_ged_send_event;
+}
+
+static const TypeInfo acpi_ged_info = {
+    .name          = TYPE_ACPI_GED,
+    .parent        = TYPE_DEVICE,
+    .instance_size = sizeof(AcpiGedState),
+    .class_init    = acpi_ged_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_HOTPLUG_HANDLER },
+        { TYPE_ACPI_DEVICE_IF },
+        { }
+    }
+};
+
+static void acpi_ged_register_types(void)
+{
+    type_register_static(&acpi_ged_info);
+}
+
+type_init(acpi_ged_register_types)
diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
new file mode 100644
index 0000000000..f69d084c89
--- /dev/null
+++ b/include/hw/acpi/generic_event_device.h
@@ -0,0 +1,102 @@
+/*
+ *
+ * Copyright (c) 2018 Intel Corporation
+ * Copyright (c) 2019 Huawei Technologies R & D (UK) Ltd
+ * Written by Samuel Ortiz, Shameer Kolothum
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * The ACPI Generic Event Device (GED) is a hardware-reduced specific
+ * device[ACPI v6.1 Section 5.6.9] that handles all platform events,
+ * including the hotplug ones. Generic Event Device allows platforms
+ * to handle interrupts in ACPI ASL statements. It follows a very
+ * similar approach like the _EVT method from GPIO events. All
+ * interrupts are listed in  _CRS and the handler is written in _EVT
+ * method. Here, we use a single interrupt for the GED device, relying
+ * on IO memory region to communicate the type of device affected by
+ * the interrupt. This way, we can support up to 32 events with a
+ * unique interrupt.
+ *
+ * Here is an example.
+ *
+ * Device (\_SB.GED)
+ * {
+ *     Name (_HID, "ACPI0013")
+ *     Name (_UID, Zero)
+ *     Name (_CRS, ResourceTemplate ()
+ *     {
+ *         Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, ,, )
+ *         {
+ *              0x00000029,
+ *         }
+ *     })
+ *     OperationRegion (EREG, SystemMemory, 0x09080000, 0x04)
+ *     Field (EREG, DWordAcc, NoLock, WriteAsZeros)
+ *     {
+ *         ESEL,   32
+ *     }
+ *
+ *     Method (_EVT, 1, Serialized)  // _EVT: Event
+ *     {
+ *         Local0 = ESEL // ESEL = IO memory region which specifies the
+ *                       // device type.
+ *         If (((Local0 & One) == One))
+ *         {
+ *             MethodEvent1()
+ *         }
+ *         If ((Local0 & 0x2) == 0x2)
+ *         {
+ *             MethodEvent2()
+ *         }
+ *         ...
+ *     }
+ * }
+ *
+ */
+
+#ifndef HW_ACPI_GED_H
+#define HW_ACPI_GED_H
+
+#include "hw/acpi/memory_hotplug.h"
+
+#define TYPE_ACPI_GED "acpi-ged"
+#define ACPI_GED(obj) \
+    OBJECT_CHECK(AcpiGedState, (obj), TYPE_ACPI_GED)
+
+#define ACPI_GED_EVT_SEL_OFFSET    0x0
+#define ACPI_GED_EVT_SEL_LEN       0x4
+#define ACPI_GED_REG_LEN           0x4
+
+#define GED_DEVICE      "GED"
+#define AML_GED_EVT_REG "EREG"
+#define AML_GED_EVT_SEL "ESEL"
+
+/*
+ * Platforms need to specify the GED event bitmap
+ * to describe what kind of events they want to support
+ * through GED.
+ */
+#define ACPI_GED_MEM_HOTPLUG_EVT   0x1
+
+typedef struct GEDState {
+    MemoryRegion io;
+    uint32_t     sel;
+    QemuMutex    lock;
+} GEDState;
+
+typedef struct AcpiGedState {
+    DeviceClass parent_obj;
+    MemHotplugState memhp_state;
+    hwaddr memhp_base;
+    hwaddr ged_base;
+    GEDState ged_state;
+    uint32_t ged_event_bitmap;
+    qemu_irq irq;
+} AcpiGedState;
+
+void build_ged_aml(Aml *table, const char* name, HotplugHandler *hotplug_dev,
+                   uint32_t ged_irq, AmlRegionSpace rs);
+
+#endif
-- 
2.17.1



