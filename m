Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B8DC55178
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 17:15:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4867A20936
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 17:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4867A20936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaiqh-0003Fo-6j
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 12:14:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1kaipH-0001ro-0B
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:13:31 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2048)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1kaipE-0008Gh-4B
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:13:30 -0500
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CRqn54jrnz67Hpt;
 Fri,  6 Nov 2020 01:11:37 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 5 Nov 2020 18:13:12 +0100
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Thu, 5 Nov 2020 17:13:12 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH] hw/arm/virt enable support for virtio-mem
Date: Fri, 6 Nov 2020 01:11:44 +0800
Message-ID: <20201105171144.560612-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.123.41.22]
X-ClientProxiedBy: lhreml705-chm.china.huawei.com (10.201.108.54) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 12:13:13
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>, linuxarm@huawei.com,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Basically a cut and paste job from the x86 support with the exception of
needing a larger block size as the Memory Block Size (MIN_SECTION_SIZE)
on ARM64 in Linux is 1G.

Tested:
* In full emulation and with KVM on an arm64 server.
* cold and hotplug for the virtio-mem-pci device.
* Wide range of memory sizes, added at creation and later.
* Fairly basic memory usage of memory added.  Seems to function as normal.
* NUMA setup with virtio-mem-pci devices on each node.
* Simple migration test.

Related kernel patch just enables the Kconfig item for ARM64 as an
alternative to x86 in drivers/virtio/Kconfig

The original patches from David Hildenbrand stated that he thought it should
work for ARM64 but it wasn't enabled in the kernel [1]
It appears he was correct and everything 'just works'.

The build system related stuff is intended to ensure virtio-mem support is
not built for arm32 (build will fail due no defined block size).
If there is a more elegant way to do this, please point me in the right
direction.

[1] https://lore.kernel.org/linux-mm/20191212171137.13872-1-david@redhat.com/

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 default-configs/devices/aarch64-softmmu.mak |  1 +
 hw/arm/Kconfig                              |  1 +
 hw/arm/virt.c                               | 64 ++++++++++++++++++++-
 hw/virtio/Kconfig                           |  4 ++
 hw/virtio/virtio-mem.c                      |  2 +
 5 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/default-configs/devices/aarch64-softmmu.mak b/default-configs/devices/aarch64-softmmu.mak
index 958b1e08e4..31d6128a29 100644
--- a/default-configs/devices/aarch64-softmmu.mak
+++ b/default-configs/devices/aarch64-softmmu.mak
@@ -6,3 +6,4 @@ include arm-softmmu.mak
 CONFIG_XLNX_ZYNQMP_ARM=y
 CONFIG_XLNX_VERSAL=y
 CONFIG_SBSA_REF=y
+CONFIG_ARCH_VIRTIO_MEM_SUPPORTED=y
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index fdf4464b94..eeae77eee9 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -20,6 +20,7 @@ config ARM_VIRT
     select PLATFORM_BUS
     select SMBIOS
     select VIRTIO_MMIO
+    select VIRTIO_MEM_SUPPORTED if ARCH_VIRTIO_MEM_SUPPORTED
     select ACPI_PCI
     select MEM_DEVICE
     select DIMM
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 8abb385d4e..a9f927ce83 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -73,9 +73,11 @@
 #include "hw/acpi/acpi.h"
 #include "target/arm/internals.h"
 #include "hw/mem/pc-dimm.h"
+#include "hw/mem/memory-device.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/acpi/generic_event_device.h"
 #include "hw/virtio/virtio-iommu.h"
+#include "hw/virtio/virtio-mem-pci.h"
 #include "hw/char/pl011.h"
 #include "qemu/guest-random.h"
 
@@ -2286,6 +2288,34 @@ static void virt_memory_plug(HotplugHandler *hotplug_dev,
                          dev, &error_abort);
 }
 
+static void virt_virtio_md_pci_pre_plug(HotplugHandler *hotplug_dev,
+                                      DeviceState *dev, Error **errp)
+{
+    HotplugHandler *hotplug_dev2 = qdev_get_bus_hotplug_handler(dev);
+    Error *local_err = NULL;
+
+    if (!hotplug_dev2 && dev->hotplugged) {
+        /*
+         * Without a bus hotplug handler, we cannot control the plug/unplug
+         * order. We should never reach this point when hotplugging,
+         * however, better add a safety net.
+         */
+        error_setg(errp, "hotplug of virtio-mem based memory devices not supported"
+                   " on this bus.");
+        return;
+    }
+    /*
+     * First, see if we can plug this memory device at all. If that
+     * succeeds, branch of to the actual hotplug handler.
+     */
+    memory_device_pre_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev), NULL,
+                           &local_err);
+    if (!local_err && hotplug_dev2) {
+        hotplug_handler_pre_plug(hotplug_dev2, dev, &local_err);
+    }
+    error_propagate(errp, local_err);
+}
+
 static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
                                             DeviceState *dev, Error **errp)
 {
@@ -2293,6 +2323,8 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         virt_memory_pre_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
+        virt_virtio_md_pci_pre_plug(hotplug_dev, dev, errp);        
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
         hwaddr db_start = 0, db_end = 0;
         char *resv_prop_str;
@@ -2322,6 +2354,27 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
     }
 }
 
+static void virt_virtio_md_pci_plug(HotplugHandler *hotplug_dev,
+                                  DeviceState *dev, Error **errp)
+{
+    HotplugHandler *hotplug_dev2 = qdev_get_bus_hotplug_handler(dev);
+    Error *local_err = NULL;
+
+    /*
+     * Plug the memory device first and then branch off to the actual
+     * hotplug handler. If that one fails, we can easily undo the memory
+     * device bits.
+     */
+    memory_device_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
+    if (hotplug_dev2) {
+        hotplug_handler_plug(hotplug_dev2, dev, &local_err);
+        if (local_err) {
+            memory_device_unplug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
+        }
+    }
+    error_propagate(errp, local_err);
+}
+
 static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
                                         DeviceState *dev, Error **errp)
 {
@@ -2336,6 +2389,9 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         virt_memory_plug(hotplug_dev, dev, errp);
     }
+    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
+        virt_virtio_md_pci_plug(hotplug_dev, dev, errp);
+    }
     if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
         PCIDevice *pdev = PCI_DEVICE(dev);
 
@@ -2363,6 +2419,11 @@ static void virt_dimm_unplug_request(HotplugHandler *hotplug_dev,
         goto out;
     }
 
+    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
+        error_setg(&local_err,
+                   "virtio-mem based memory devices cannot be unplugged.");
+        goto out;
+    }
     hotplug_handler_unplug_request(HOTPLUG_HANDLER(vms->acpi_dev), dev,
                                    &local_err);
 out:
@@ -2413,7 +2474,8 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
                                                         DeviceState *dev)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE) ||
-       (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM))) {
+        object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
+        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)){
         return HOTPLUG_HANDLER(machine);
     }
     if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index 0eda25c4e1..00dbf2939e 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -48,6 +48,10 @@ config VIRTIO_PMEM
     depends on VIRTIO_PMEM_SUPPORTED
     select MEM_DEVICE
 
+config ARCH_VIRTIO_MEM_SUPPORTED
+    bool
+    default n
+
 config VIRTIO_MEM_SUPPORTED
     bool
 
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 7c8ca9f28b..c28f12547a 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -53,6 +53,8 @@
  */
 #if defined(TARGET_X86_64) || defined(TARGET_I386)
 #define VIRTIO_MEM_USABLE_EXTENT (2 * (128 * MiB))
+#elif defined (TARGET_AARCH64)
+#define VIRTIO_MEM_USABLE_EXTENT (2 * (1024 * MiB))
 #else
 #error VIRTIO_MEM_USABLE_EXTENT not defined
 #endif
-- 
2.19.1


