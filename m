Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3BCC43463
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 13:26:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EABE21531
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 13:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EABE21531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJzMb-0005ej-Cl
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 09:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1kJzLl-0004D1-Vs
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 09:25:54 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:44348)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1kJzLj-0003Do-BJ
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 09:25:53 -0400
Received: from MUA
 by vps-vb.mhejs.net with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
 (Exim 4.93.0.4) (envelope-from <mail@maciej.szmigiero.name>)
 id 1kJzLX-00087Z-3U; Sun, 20 Sep 2020 15:25:39 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 1/3] haprot: add a device for memory hot-add protocols
Date: Sun, 20 Sep 2020 15:25:20 +0200
Message-Id: <711ff6f2a973293a2ae8933094b3b0207f135aa0.1600556526.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600556526.git.maciej.szmigiero@oracle.com>
References: <cover.1600556526.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 09:25:30
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

This device works like a virtual DIMM stick: it allows inserting extra RAM
into the guest at run time.

The main differences from the ACPI-based PC DIMM hotplug are:
* Notifying the guest about the new memory range is not done via ACPI but
via a protocol handler that registers with the haprot framework.
This means that the ACPI DIMM slot limit does not apply.

* A protocol handler can prevent removal of a haprot device when it is
still in use by setting its "busy" field.

* A protocol handler can also register an "unplug" callback so it gets
notified when an user decides to remove the haprot device.
This way the protocol handler can inform the guest about this fact and / or
do its own cleanup.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/i386/Kconfig         |   2 +
 hw/i386/pc.c            |  18 ++-
 hw/mem/Kconfig          |   4 +
 hw/mem/haprot.c         | 263 ++++++++++++++++++++++++++++++++++++++++
 hw/mem/meson.build      |   1 +
 include/hw/mem/haprot.h |  72 +++++++++++
 6 files changed, 359 insertions(+), 1 deletion(-)
 create mode 100644 hw/mem/haprot.c
 create mode 100644 include/hw/mem/haprot.h

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index d0bd8b537d55..ca143e568de2 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -58,6 +58,7 @@ config I440FX
     imply E1000_PCI
     imply VMPORT
     imply VMMOUSE
+    imply HAPROT
     select PC_PCI
     select PC_ACPI
     select ACPI_SMBUS
@@ -85,6 +86,7 @@ config Q35
     imply E1000E_PCI_EXPRESS
     imply VMPORT
     imply VMMOUSE
+    imply HAPROT
     select PC_PCI
     select PC_ACPI
     select PCI_EXPRESS_Q35
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b55369357e5d..b7a0e4ee3ea2 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -77,6 +77,7 @@
 #include "hw/acpi/cpu_hotplug.h"
 #include "hw/boards.h"
 #include "acpi-build.h"
+#include "hw/mem/haprot.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/mem/nvdimm.h"
 #include "qapi/error.h"
@@ -1416,6 +1417,18 @@ static void pc_virtio_md_pci_unplug_request(HotplugHandler *hotplug_dev,
     error_setg(errp, "virtio based memory devices cannot be unplugged.");
 }
 
+static void pc_haprot_unplug_request(DeviceState *dev, Error **errp)
+{
+    HAProtDevice *haprot = HAPROT(dev);
+
+    if (haprot->busy) {
+        error_setg(errp, "the memory is still busy, cannot unplug");
+        return;
+    }
+
+    object_unparent(OBJECT(dev));
+}
+
 static void pc_virtio_md_pci_unplug(HotplugHandler *hotplug_dev,
                                     DeviceState *dev, Error **errp)
 {
@@ -1458,6 +1471,8 @@ static void pc_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI) ||
                object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
         pc_virtio_md_pci_unplug_request(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_HAPROT)) {
+        pc_haprot_unplug_request(dev, errp);
     } else {
         error_setg(errp, "acpi: device unplug request for not supported device"
                    " type: %s", object_get_typename(OBJECT(dev)));
@@ -1486,7 +1501,8 @@ static HotplugHandler *pc_get_hotplug_handler(MachineState *machine,
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
         object_dynamic_cast(OBJECT(dev), TYPE_CPU) ||
         object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI) ||
-        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
+        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI) ||
+        object_dynamic_cast(OBJECT(dev), TYPE_HAPROT)) {
         return HOTPLUG_HANDLER(machine);
     }
 
diff --git a/hw/mem/Kconfig b/hw/mem/Kconfig
index a0ef2cf648e1..a5d8c8851d1b 100644
--- a/hw/mem/Kconfig
+++ b/hw/mem/Kconfig
@@ -10,3 +10,7 @@ config NVDIMM
     default y
     depends on (PC || PSERIES || ARM_VIRT)
     select MEM_DEVICE
+
+config HAPROT
+    bool
+    select MEM_DEVICE
diff --git a/hw/mem/haprot.c b/hw/mem/haprot.c
new file mode 100644
index 000000000000..38373351b55c
--- /dev/null
+++ b/hw/mem/haprot.c
@@ -0,0 +1,263 @@
+/*
+ * A device for memory hot-add protocols
+ *
+ * Copyright (C) 2020 Oracle and/or its affiliates.
+ *
+ * Author: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
+ *
+ * Heavily based on pc-dimm.c:
+ * Copyright ProfitBricks GmbH 2012
+ * Copyright (C) 2014 Red Hat Inc
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/boards.h"
+#include "hw/mem/haprot.h"
+#include "hw/mem/memory-device.h"
+#include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
+#include "qemu/module.h"
+#include "sysemu/hostmem.h"
+#include "trace.h"
+
+static Property haprot_properties[] = {
+    DEFINE_PROP_UINT64(HAPROT_ADDR_PROP, HAProtDevice, addr, 0),
+    DEFINE_PROP_UINT32(HAPROT_NODE_PROP, HAProtDevice, node, 0),
+    DEFINE_PROP_LINK(HAPROT_MEMDEV_PROP, HAProtDevice, hostmem,
+                     TYPE_MEMORY_BACKEND, HostMemoryBackend *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void haprot_get_size(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    Error *local_err = NULL;
+    uint64_t value;
+
+    value = memory_device_get_region_size(MEMORY_DEVICE(obj), &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    visit_type_uint64(v, name, &value, errp);
+}
+
+static void haprot_init(Object *obj)
+{
+    object_property_add(obj, HAPROT_SIZE_PROP, "uint64", haprot_get_size,
+                        NULL, NULL, NULL);
+}
+
+static void haprot_realize(DeviceState *dev, Error **errp)
+{
+    HAProtDevice *haprot = HAPROT(dev);
+    HAProtDeviceClass *hc = HAPROT_GET_CLASS(haprot);
+    uint64_t align;
+    MachineState *ms = MACHINE(qdev_get_machine());
+    Error *local_err = NULL;
+    int nb_numa_nodes = ms->numa_state->num_nodes;
+
+    if (!hc->plug_notify_cb) {
+        error_setg(errp, "no mem hot add protocol registered");
+        return;
+    }
+
+    if (hc->get_align_cb) {
+        align = hc->get_align_cb(hc->notify_cb_ctx, haprot);
+    } else {
+        align = 0;
+    }
+
+    memory_device_pre_plug(MEMORY_DEVICE(haprot), ms,
+                           align ? &align : NULL,
+                           &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    if (!haprot->hostmem) {
+        error_setg(errp, "'" HAPROT_MEMDEV_PROP "' property is not set");
+        return;
+    } else if (host_memory_backend_is_mapped(haprot->hostmem)) {
+        const char *path;
+
+        path = object_get_canonical_path_component(OBJECT(haprot->hostmem));
+        error_setg(errp, "can't use already busy memdev: %s", path);
+        return;
+    }
+    if (((nb_numa_nodes > 0) && (haprot->node >= nb_numa_nodes)) ||
+        (!nb_numa_nodes && haprot->node)) {
+        error_setg(errp,
+                   "Node property value %"PRIu32" exceeds the number of numa nodes %d",
+                   haprot->node, nb_numa_nodes ? nb_numa_nodes : 1);
+        return;
+    }
+
+    host_memory_backend_set_mapped(haprot->hostmem, true);
+
+    memory_device_plug(MEMORY_DEVICE(haprot), ms);
+    vmstate_register_ram(host_memory_backend_get_memory(haprot->hostmem),
+                         dev);
+
+    hc->plug_notify_cb(hc->notify_cb_ctx, haprot, &local_err);
+    if (local_err) {
+        memory_device_unplug(MEMORY_DEVICE(haprot), ms);
+        vmstate_unregister_ram(host_memory_backend_get_memory(haprot->hostmem),
+                               dev);
+        host_memory_backend_set_mapped(haprot->hostmem, false);
+
+        error_propagate(errp, local_err);
+        return;
+    }
+}
+
+static void haprot_unrealize(DeviceState *dev)
+{
+    HAProtDevice *haprot = HAPROT(dev);
+    HAProtDeviceClass *hc = HAPROT_GET_CLASS(haprot);
+    MachineState *ms = MACHINE(qdev_get_machine());
+
+    if (hc->unplug_notify_cb) {
+        hc->unplug_notify_cb(hc->notify_cb_ctx, haprot);
+    }
+
+    memory_device_unplug(MEMORY_DEVICE(haprot), ms);
+    vmstate_unregister_ram(host_memory_backend_get_memory(haprot->hostmem),
+                           dev);
+
+    host_memory_backend_set_mapped(haprot->hostmem, false);
+}
+
+static uint64_t haprot_md_get_addr(const MemoryDeviceState *md)
+{
+    return object_property_get_uint(OBJECT(md), HAPROT_ADDR_PROP,
+                                    &error_abort);
+}
+
+static void haprot_md_set_addr(MemoryDeviceState *md, uint64_t addr,
+                               Error **errp)
+{
+    object_property_set_uint(OBJECT(md), HAPROT_ADDR_PROP, addr, errp);
+}
+
+static MemoryRegion *haprot_md_get_memory_region(MemoryDeviceState *md,
+                                                 Error **errp)
+{
+    HAProtDevice *haprot = HAPROT(md);
+
+    if (!haprot->hostmem) {
+        error_setg(errp, "'" HAPROT_MEMDEV_PROP "' property must be set");
+        return NULL;
+    }
+
+    return host_memory_backend_get_memory(haprot->hostmem);
+}
+
+static void haprot_md_fill_device_info(const MemoryDeviceState *md,
+                                       MemoryDeviceInfo *info)
+{
+    PCDIMMDeviceInfo *di = g_new0(PCDIMMDeviceInfo, 1);
+    const DeviceClass *dc = DEVICE_GET_CLASS(md);
+    const HAProtDevice *haprot = HAPROT(md);
+    const DeviceState *dev = DEVICE(md);
+
+    if (dev->id) {
+        di->has_id = true;
+        di->id = g_strdup(dev->id);
+    }
+    di->hotplugged = dev->hotplugged;
+    di->hotpluggable = dc->hotpluggable;
+    di->addr = haprot->addr;
+    di->slot = -1;
+    di->node = haprot->node;
+    di->size = object_property_get_uint(OBJECT(haprot), HAPROT_SIZE_PROP,
+                                        NULL);
+    di->memdev = object_get_canonical_path(OBJECT(haprot->hostmem));
+
+    info->u.dimm.data = di;
+    info->type = MEMORY_DEVICE_INFO_KIND_DIMM;
+}
+
+static void haprot_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    MemoryDeviceClass *mdc = MEMORY_DEVICE_CLASS(oc);
+
+    dc->realize = haprot_realize;
+    dc->unrealize = haprot_unrealize;
+    device_class_set_props(dc, haprot_properties);
+    dc->desc = "Memory for a hot add protocol";
+
+    mdc->get_addr = haprot_md_get_addr;
+    mdc->set_addr = haprot_md_set_addr;
+    mdc->get_plugged_size = memory_device_get_region_size;
+    mdc->get_memory_region = haprot_md_get_memory_region;
+    mdc->fill_device_info = haprot_md_fill_device_info;
+}
+
+void haprot_register_protocol(HAProtocolGetAlign get_align_cb,
+                              HAProtocolPlugNotify plug_notify_cb,
+                              HAProtocolUnplugNotify unplug_notify_cb,
+                              void *notify_ctx, Error **errp)
+{
+    HAProtDeviceClass *hc = HAPROT_CLASS(object_class_by_name(TYPE_HAPROT));
+
+    if (hc->plug_notify_cb) {
+        error_setg(errp, "a mem hot add protocol was already registered");
+        return;
+    }
+
+    hc->get_align_cb = get_align_cb;
+    hc->plug_notify_cb = plug_notify_cb;
+    hc->unplug_notify_cb = unplug_notify_cb;
+    hc->notify_cb_ctx = notify_ctx;
+}
+
+void haprot_unregister_protocol(HAProtocolPlugNotify plug_notify_cb,
+                                Error **errp)
+{
+    HAProtDeviceClass *hc = HAPROT_CLASS(object_class_by_name(TYPE_HAPROT));
+
+    if (!hc->plug_notify_cb) {
+        error_setg(errp, "no mem hot add protocol was registered");
+        return;
+    }
+
+    if (hc->plug_notify_cb != plug_notify_cb) {
+        error_setg(errp, "different mem hot add protocol was registered");
+        return;
+    }
+
+    hc->get_align_cb = NULL;
+    hc->plug_notify_cb = NULL;
+    hc->unplug_notify_cb = NULL;
+    hc->notify_cb_ctx = NULL;
+}
+
+static TypeInfo haprot_info = {
+    .name          = TYPE_HAPROT,
+    .parent        = TYPE_DEVICE,
+    .instance_size = sizeof(HAProtDevice),
+    .instance_init = haprot_init,
+    .class_init    = haprot_class_init,
+    .class_size    = sizeof(HAProtDeviceClass),
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_MEMORY_DEVICE },
+        { }
+    },
+};
+
+static void haprot_register_types(void)
+{
+    type_register_static(&haprot_info);
+}
+
+type_init(haprot_register_types)
diff --git a/hw/mem/meson.build b/hw/mem/meson.build
index 0d22f2b5727e..764062077dca 100644
--- a/hw/mem/meson.build
+++ b/hw/mem/meson.build
@@ -3,5 +3,6 @@ mem_ss.add(files('memory-device.c'))
 mem_ss.add(when: 'CONFIG_DIMM', if_true: files('pc-dimm.c'))
 mem_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_mc.c'))
 mem_ss.add(when: 'CONFIG_NVDIMM', if_true: files('nvdimm.c'))
+mem_ss.add(when: 'CONFIG_HAPROT', if_true: files('haprot.c'))
 
 softmmu_ss.add_all(when: 'CONFIG_MEM_DEVICE', if_true: mem_ss)
diff --git a/include/hw/mem/haprot.h b/include/hw/mem/haprot.h
new file mode 100644
index 000000000000..9d44007b4945
--- /dev/null
+++ b/include/hw/mem/haprot.h
@@ -0,0 +1,72 @@
+/*
+ * A device for memory hot-add protocols
+ *
+ * Copyright (C) 2020 Oracle and/or its affiliates.
+ *
+ * Author: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
+ *
+ * Heavily based on pc-dimm.h:
+ * Copyright ProfitBricks GmbH 2012
+ * Copyright (C) 2013-2014 Red Hat Inc
+ *
+ * Authors:
+ *  Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>
+ *  Igor Mammedov <imammedo@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef QEMU_HAPROT_H
+#define QEMU_HAPROT_H
+
+#include "exec/memory.h"
+#include "hw/qdev-core.h"
+
+#define TYPE_HAPROT "mem-haprot"
+#define HAPROT(obj) \
+    OBJECT_CHECK(HAProtDevice, (obj), TYPE_HAPROT)
+#define HAPROT_CLASS(oc) \
+    OBJECT_CLASS_CHECK(HAProtDeviceClass, (oc), TYPE_HAPROT)
+#define HAPROT_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(HAProtDeviceClass, (obj), TYPE_HAPROT)
+
+#define HAPROT_ADDR_PROP "addr"
+#define HAPROT_NODE_PROP "node"
+#define HAPROT_SIZE_PROP "size"
+#define HAPROT_MEMDEV_PROP "memdev"
+
+typedef struct HAProtDevice {
+    /* private */
+    DeviceState parent_obj;
+
+    /* public */
+    uint64_t addr;
+    uint32_t node;
+    HostMemoryBackend *hostmem;
+    bool busy;
+} HAProtDevice;
+
+typedef uint64_t (*HAProtocolGetAlign)(void *ctx, HAProtDevice *haprot);
+typedef void (*HAProtocolPlugNotify)(void *ctx, HAProtDevice *haprot,
+                                     Error **errp);
+typedef void (*HAProtocolUnplugNotify)(void *ctx, HAProtDevice *haprot);
+
+typedef struct HAProtDeviceClass {
+    /* private */
+    DeviceClass parent_class;
+    HAProtocolGetAlign get_align_cb;
+    HAProtocolPlugNotify plug_notify_cb;
+    HAProtocolUnplugNotify unplug_notify_cb;
+    void *notify_cb_ctx;
+} HAProtDeviceClass;
+
+void haprot_register_protocol(HAProtocolGetAlign get_align_cb,
+                              HAProtocolPlugNotify plug_notify_cb,
+                              HAProtocolUnplugNotify unplug_notify_cb,
+                              void *notify_ctx, Error **errp);
+void haprot_unregister_protocol(HAProtocolPlugNotify plug_notify_cb,
+                                Error **errp);
+
+#endif

