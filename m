Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78B0C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 11:07:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A82E20872
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 11:07:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A82E20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbMZ1-0001ao-Mf
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 07:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jbMYI-0000NI-00; Wed, 20 May 2020 07:06:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3766 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jbMYG-0007zY-BS; Wed, 20 May 2020 07:06:21 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id E867F647BB5BB2D5ABED;
 Wed, 20 May 2020 19:06:09 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.47.27.193) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Wed, 20 May 2020 19:06:01 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: [PATCH v2] arm/virt: Add memory hot remove support
Date: Wed, 20 May 2020 12:03:54 +0100
Message-ID: <20200520110354.14352-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.27.193]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=shameerali.kolothum.thodi@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 05:37:42
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, mst@redhat.com, linuxarm@huawei.com,
 xuwei5@hisilicon.com, eric.auger@redhat.com, prime.zeng@hisilicon.com,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds support for memory hot remove on arm/virt that
uses acpi ged device.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
RFC v1 --> v2
  -Rebased on top of latest Qemu master.
  -Dropped "RFC" and tested with kernel 5.7-rc6
---
 hw/acpi/generic_event_device.c | 28 +++++++++++++++++
 hw/arm/virt.c                  | 56 ++++++++++++++++++++++++++++++++--
 2 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index b1cbdd86b6..2b3bedcd2f 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -193,6 +193,32 @@ static void acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
     }
 }
 
+static void acpi_ged_unplug_request_cb(HotplugHandler *hotplug_dev,
+                                       DeviceState *dev, Error **errp)
+{
+    AcpiGedState *s = ACPI_GED(hotplug_dev);
+
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
+        acpi_memory_unplug_request_cb(hotplug_dev, &s->memhp_state, dev, errp);
+    } else {
+        error_setg(errp, "acpi: device unplug request for unsupported device"
+                   " type: %s", object_get_typename(OBJECT(dev)));
+    }
+}
+
+static void acpi_ged_unplug_cb(HotplugHandler *hotplug_dev,
+                               DeviceState *dev, Error **errp)
+{
+    AcpiGedState *s = ACPI_GED(hotplug_dev);
+
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
+        acpi_memory_unplug_cb(&s->memhp_state, dev, errp);
+    } else {
+        error_setg(errp, "acpi: device unplug for unsupported device"
+                   " type: %s", object_get_typename(OBJECT(dev)));
+    }
+}
+
 static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
 {
     AcpiGedState *s = ACPI_GED(adev);
@@ -318,6 +344,8 @@ static void acpi_ged_class_init(ObjectClass *class, void *data)
     dc->vmsd = &vmstate_acpi_ged;
 
     hc->plug = acpi_ged_device_plug_cb;
+    hc->unplug_request = acpi_ged_unplug_request_cb;
+    hc->unplug = acpi_ged_unplug_cb;
 
     adevc->send_event = acpi_ged_send_event;
 }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 37462a6f78..110fa73990 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2177,11 +2177,62 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
     }
 }
 
+static void virt_dimm_unplug_request(HotplugHandler *hotplug_dev,
+                                     DeviceState *dev, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
+    Error *local_err = NULL;
+
+    if (!vms->acpi_dev) {
+        error_setg(errp,
+                   "memory hotplug is not enabled: missing acpi-ged device");
+        goto out;
+    }
+
+    hotplug_handler_unplug_request(HOTPLUG_HANDLER(vms->acpi_dev), dev,
+                                   &local_err);
+out:
+    error_propagate(errp, local_err);
+}
+
+static void virt_dimm_unplug(HotplugHandler *hotplug_dev,
+                             DeviceState *dev, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
+    Error *local_err = NULL;
+
+    hotplug_handler_unplug(HOTPLUG_HANDLER(vms->acpi_dev), dev, &local_err);
+    if (local_err) {
+        goto out;
+    }
+
+    pc_dimm_unplug(PC_DIMM(dev), MACHINE(vms));
+    object_property_set_bool(OBJECT(dev), false, "realized", NULL);
+
+ out:
+    error_propagate(errp, local_err);
+}
+
 static void virt_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
                                           DeviceState *dev, Error **errp)
 {
-    error_setg(errp, "device unplug request for unsupported device"
-               " type: %s", object_get_typename(OBJECT(dev)));
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
+        virt_dimm_unplug_request(hotplug_dev, dev, errp);
+    } else {
+        error_setg(errp, "device unplug request for unsupported device"
+                   " type: %s", object_get_typename(OBJECT(dev)));
+    }
+}
+
+static void virt_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
+                                          DeviceState *dev, Error **errp)
+{
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
+        virt_dimm_unplug(hotplug_dev, dev, errp);
+    } else {
+        error_setg(errp, "virt: device unplug for unsupported device"
+                   " type: %s", object_get_typename(OBJECT(dev)));
+    }
 }
 
 static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
@@ -2262,6 +2313,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     hc->pre_plug = virt_machine_device_pre_plug_cb;
     hc->plug = virt_machine_device_plug_cb;
     hc->unplug_request = virt_machine_device_unplug_request_cb;
+    hc->unplug = virt_machine_device_unplug_cb;
     mc->numa_mem_supported = true;
     mc->nvdimm_supported = true;
     mc->auto_enable_numa_with_memhp = true;
-- 
2.17.1



