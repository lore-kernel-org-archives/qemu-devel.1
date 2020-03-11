Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0F2C0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:26:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 912B020736
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 912B020736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC57v-0000Ev-70
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 13:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jC55I-0002Wa-Se
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:23:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jC55H-0004D8-EA
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:23:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3281 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jC55E-00043l-8L; Wed, 11 Mar 2020 13:23:52 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id D61AA2032573321C81E2;
 Thu, 12 Mar 2020 01:23:49 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.202.227.237) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 12 Mar 2020 01:23:38 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <eric.auger@redhat.com>,
 <imammedo@redhat.com>
Subject: [PATCH v3 07/10] hw/arm/virt: Add nvdimm hotplug support
Date: Wed, 11 Mar 2020 17:20:11 +0000
Message-ID: <20200311172014.33052-8-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20200311172014.33052-1-shameerali.kolothum.thodi@huawei.com>
References: <20200311172014.33052-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.237]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: peter.maydell@linaro.org, xiaoguangrong.eric@gmail.com, david@redhat.com,
 mst@redhat.com, linuxarm@huawei.com, xuwei5@hisilicon.com,
 shannon.zhaosl@gmail.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds support for nvdimm hotplug events through GED
and enables nvdimm for the arm/virt. Now Guests with ACPI
can have both cold and hot plug of nvdimms.

Hot removal functionality is not yet supported.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 docs/specs/acpi_hw_reduced_hotplug.rst |  1 +
 hw/acpi/generic_event_device.c         | 15 ++++++++++++++-
 hw/arm/virt.c                          | 16 +++++++++++-----
 include/hw/acpi/generic_event_device.h |  1 +
 4 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/docs/specs/acpi_hw_reduced_hotplug.rst b/docs/specs/acpi_hw_reduced_hotplug.rst
index 911a98255b..e3abe975bf 100644
--- a/docs/specs/acpi_hw_reduced_hotplug.rst
+++ b/docs/specs/acpi_hw_reduced_hotplug.rst
@@ -63,6 +63,7 @@ GED IO interface (4 byte access)
     bits:
        0: Memory hotplug event
        1: System power down event
+       2: NVDIMM hotplug event
     2-31: Reserved
 
 **write_access:**
diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 021ed2bf23..5d17f78a1e 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -16,6 +16,7 @@
 #include "hw/acpi/generic_event_device.h"
 #include "hw/irq.h"
 #include "hw/mem/pc-dimm.h"
+#include "hw/mem/nvdimm.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
@@ -23,6 +24,7 @@
 static const uint32_t ged_supported_events[] = {
     ACPI_GED_MEM_HOTPLUG_EVT,
     ACPI_GED_PWR_DOWN_EVT,
+    ACPI_GED_NVDIMM_HOTPLUG_EVT,
 };
 
 /*
@@ -110,6 +112,11 @@ void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
                            aml_notify(aml_name(ACPI_POWER_BUTTON_DEVICE),
                                       aml_int(0x80)));
                 break;
+            case ACPI_GED_NVDIMM_HOTPLUG_EVT:
+                aml_append(if_ctx,
+                           aml_notify(aml_name("\\_SB.NVDR"),
+                                      aml_int(0x80)));
+                break;
             default:
                 /*
                  * Please make sure all the events in ged_supported_events[]
@@ -175,7 +182,11 @@ static void acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
     AcpiGedState *s = ACPI_GED(hotplug_dev);
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
-        acpi_memory_plug_cb(hotplug_dev, &s->memhp_state, dev, errp);
+        if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {
+            nvdimm_acpi_plug_cb(hotplug_dev, dev);
+        } else {
+            acpi_memory_plug_cb(hotplug_dev, &s->memhp_state, dev, errp);
+        }
     } else {
         error_setg(errp, "virt: device plug request for unsupported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
@@ -192,6 +203,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
         sel = ACPI_GED_MEM_HOTPLUG_EVT;
     } else if (ev & ACPI_POWER_DOWN_STATUS) {
         sel = ACPI_GED_PWR_DOWN_EVT;
+    } else if (ev & ACPI_NVDIMM_HOTPLUG_STATUS) {
+        sel = ACPI_GED_NVDIMM_HOTPLUG_EVT;
     } else {
         /* Unknown event. Return without generating interrupt. */
         warn_report("GED: Unsupported event %d. No irq injected", ev);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 18178553fa..f1546ec2e6 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -548,6 +548,10 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
         event |= ACPI_GED_MEM_HOTPLUG_EVT;
     }
 
+    if (ms->nvdimms_state->is_enabled) {
+        event |= ACPI_GED_NVDIMM_HOTPLUG_EVT;
+    }
+
     dev = qdev_create(NULL, TYPE_ACPI_GED);
     qdev_prop_set_uint32(dev, "ged-event", event);
 
@@ -1963,19 +1967,20 @@ static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                                  Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
+    const MachineState *ms = MACHINE(hotplug_dev);
     const bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
 
-    if (is_nvdimm) {
-        error_setg(errp, "nvdimm is not yet supported");
-        return;
-    }
-
     if (!vms->acpi_dev) {
         error_setg(errp,
                    "memory hotplug is not enabled: missing acpi-ged device");
         return;
     }
 
+    if (is_nvdimm && !ms->nvdimms_state->is_enabled) {
+        error_setg(errp, "nvdimm is not enabled: add 'nvdimm=on' to '-M'");
+        return;
+    }
+
     pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL, errp);
 }
 
@@ -2120,6 +2125,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     hc->plug = virt_machine_device_plug_cb;
     hc->unplug_request = virt_machine_device_unplug_request_cb;
     mc->numa_mem_supported = true;
+    mc->nvdimm_supported = true;
     mc->auto_enable_numa_with_memhp = true;
     mc->default_ram_id = "mach-virt.ram";
 }
diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
index d157eac088..9eb86ca4fd 100644
--- a/include/hw/acpi/generic_event_device.h
+++ b/include/hw/acpi/generic_event_device.h
@@ -82,6 +82,7 @@
  */
 #define ACPI_GED_MEM_HOTPLUG_EVT   0x1
 #define ACPI_GED_PWR_DOWN_EVT      0x2
+#define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
 
 typedef struct GEDState {
     MemoryRegion io;
-- 
2.17.1



