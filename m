Received: from eggs.gnu.org ([2001:4830:134:3::10]:50179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fEGUS-0000h1-CB
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:49:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fEGUQ-0003gP-O8
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:49:52 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  3 May 2018 17:49:30 +0200
Message-Id: <20180503154936.18946-3-david@redhat.com>
In-Reply-To: <20180503154936.18946-1-david@redhat.com>
References: <20180503154936.18946-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 2/8] qdev: introduce ResourceHandler as a
 first-stage hotplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

Hotplug handlers usually do 3 things:
1. Allocate some resources for a new device
2. Make the new device visible for the guest
3. Notify the guest about the new device

While 2. and 3. are only ever performed once for a device, there
might be various resources to allocate. E.g. a MemoryDevice could be
exposed via Virtio. The proxy device hotplug handler (e.g. virtio-pci,
virtio-ccw) takes care of exposing the device to the guest. However,
we also have to allocate system resources, like a portion in guest
physical address space, which is to be handled by the machine.

One key difference between a hotplug handler and a resource handler is
that resource handlers have no "unplug_request". There is no
communication with the guest (this is done by a "hotplug" handler). So
conceptually, they are different.

For now we live with the assumption, that - in additon to the existing
hotplug handler which can do some resource asignment - at most one
resource handler is necessary.

We might even later decide to have multiple resource handlers for a
specific device (e.g. one for each interface they implement). For now,
this design is sufficient.

Resource handlers have to run before the hotplug handler runs (esp
before exposing the device to the guest).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/core/Makefile.objs         |  1 +
 hw/core/qdev.c                | 41 ++++++++++++++++++++++++++++++-
 hw/core/resource-handler.c    | 57 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/boards.h           |  9 +++++++
 include/hw/resource-handler.h | 46 ++++++++++++++++++++++++++++++++++
 5 files changed, 153 insertions(+), 1 deletion(-)
 create mode 100644 hw/core/resource-handler.c
 create mode 100644 include/hw/resource-handler.h

diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index eb88ca979e..7474387fcd 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -6,6 +6,7 @@ common-obj-$(CONFIG_SOFTMMU) += fw-path-provider.o
 # irq.o needed for qdev GPIO handling:
 common-obj-y += irq.o
 common-obj-y += hotplug.o
+common-obj-y += resource-handler.o
 common-obj-$(CONFIG_SOFTMMU) += nmi.o
 
 common-obj-$(CONFIG_EMPTY_SLOT) += empty_slot.o
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index f6f92473b8..042e275884 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -35,6 +35,7 @@
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "hw/hotplug.h"
+#include "hw/resource-handler.h"
 #include "hw/boards.h"
 #include "hw/sysbus.h"
 
@@ -271,6 +272,17 @@ HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev)
     return hotplug_ctrl;
 }
 
+static ResourceHandler *qdev_get_resource_handler(DeviceState *dev)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+
+    if (mc->get_resource_handler) {
+            return mc->get_resource_handler(ms, dev);
+    }
+    return NULL;
+}
+
 static int qdev_reset_one(DeviceState *dev, void *opaque)
 {
     device_reset(dev);
@@ -814,6 +826,7 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
     DeviceClass *dc = DEVICE_GET_CLASS(dev);
+    ResourceHandler *resource_ctrl;
     HotplugHandler *hotplug_ctrl;
     BusState *bus;
     Error *local_err = NULL;
@@ -825,6 +838,8 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
         return;
     }
 
+    resource_ctrl = qdev_get_resource_handler(dev);
+
     if (value && !dev->realized) {
         if (!check_only_migratable(obj, &local_err)) {
             goto fail;
@@ -840,6 +855,13 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
             g_free(name);
         }
 
+        if (resource_ctrl) {
+            resource_handler_pre_assign(resource_ctrl, dev, &local_err);
+            if (local_err != NULL) {
+                goto fail;
+            }
+        }
+
         hotplug_ctrl = qdev_get_hotplug_handler(dev);
         if (hotplug_ctrl) {
             hotplug_handler_pre_plug(hotplug_ctrl, dev, &local_err);
@@ -858,12 +880,19 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
 
         DEVICE_LISTENER_CALL(realize, Forward, dev);
 
+        if (resource_ctrl) {
+            resource_handler_assign(resource_ctrl, dev, &local_err);
+            if (local_err != NULL) {
+                goto post_realize_fail;
+            }
+        }
+
         if (hotplug_ctrl) {
             hotplug_handler_plug(hotplug_ctrl, dev, &local_err);
         }
 
         if (local_err != NULL) {
-            goto post_realize_fail;
+            goto post_assign_fail;
         }
 
         /*
@@ -903,6 +932,11 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
         if (qdev_get_vmsd(dev)) {
             vmstate_unregister(dev, qdev_get_vmsd(dev), dev);
         }
+
+        if (resource_ctrl) {
+            resource_handler_unassign(resource_ctrl, dev);
+        }
+
         if (dc->unrealize) {
             local_errp = local_err ? NULL : &local_err;
             dc->unrealize(dev, local_errp);
@@ -928,6 +962,11 @@ child_realize_fail:
         vmstate_unregister(dev, qdev_get_vmsd(dev), dev);
     }
 
+post_assign_fail:
+    if (resource_ctrl) {
+        resource_handler_unassign(resource_ctrl, dev);
+    }
+
 post_realize_fail:
     g_free(dev->canonical_path);
     dev->canonical_path = NULL;
diff --git a/hw/core/resource-handler.c b/hw/core/resource-handler.c
new file mode 100644
index 0000000000..0a1ff0e66a
--- /dev/null
+++ b/hw/core/resource-handler.c
@@ -0,0 +1,57 @@
+/*
+ * Resource handler interface.
+ *
+ * Copyright (c) 2018 Red Hat Inc.
+ *
+ * Authors:
+ *  David Hildenbrand <david@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/resource-handler.h"
+#include "qemu/module.h"
+
+void resource_handler_pre_assign(ResourceHandler *rh,
+                                 const DeviceState *dev, Error **errp)
+{
+    ResourceHandlerClass *rhc = RESOURCE_HANDLER_GET_CLASS(rh);
+
+    if (rhc->pre_assign) {
+        rhc->pre_assign(rh, dev, errp);
+    }
+}
+
+void resource_handler_assign(ResourceHandler *rh, DeviceState *dev,
+                             Error **errp)
+{
+    ResourceHandlerClass *rhc = RESOURCE_HANDLER_GET_CLASS(rh);
+
+    if (rhc->assign) {
+        rhc->assign(rh, dev, errp);
+    }
+}
+
+void resource_handler_unassign(ResourceHandler *rh, DeviceState *dev)
+{
+    ResourceHandlerClass *rhc = RESOURCE_HANDLER_GET_CLASS(rh);
+
+    if (rhc->unassign) {
+        rhc->unassign(rh, dev);
+    }
+}
+
+static const TypeInfo resource_handler_info = {
+    .name          = TYPE_RESOURCE_HANDLER,
+    .parent        = TYPE_INTERFACE,
+    .class_size = sizeof(ResourceHandlerClass),
+};
+
+static void resource_handler_register_types(void)
+{
+    type_register_static(&resource_handler_info);
+}
+
+type_init(resource_handler_register_types)
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 8748964e6f..ff5142d7c2 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -8,6 +8,7 @@
 #include "hw/qdev.h"
 #include "qom/object.h"
 #include "qom/cpu.h"
+#include "hw/resource-handler.h"
 
 /**
  * memory_region_allocate_system_memory - Allocate a board's main memory
@@ -115,6 +116,12 @@ typedef struct {
  *    of HotplugHandler object, which handles hotplug operation
  *    for a given @dev. It may return NULL if @dev doesn't require
  *    any actions to be performed by hotplug handler.
+ * @get_resource_handler: this function is called when a new device is
+ *                        about to be hotplugged. If defined, it returns pointer
+ *                        to an instance of ResourceHandler object, which
+ *                        handles resource asignment for a given @dev. It
+ *                        may return NULL if @dev doesn't require any actions
+ *                        to be performed by a resource handler.
  * @cpu_index_to_instance_props:
  *    used to provide @cpu_index to socket/core/thread number mapping, allowing
  *    legacy code to perform maping from cpu_index to topology properties
@@ -208,6 +215,8 @@ struct MachineClass {
 
     HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
                                            DeviceState *dev);
+    ResourceHandler *(*get_resource_handler)(MachineState *machine,
+                                             const DeviceState *dev);
     CpuInstanceProperties (*cpu_index_to_instance_props)(MachineState *machine,
                                                          unsigned cpu_index);
     const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
diff --git a/include/hw/resource-handler.h b/include/hw/resource-handler.h
new file mode 100644
index 0000000000..3eda1bec5c
--- /dev/null
+++ b/include/hw/resource-handler.h
@@ -0,0 +1,46 @@
+/*
+ * Resource handler interface.
+ *
+ * Copyright (c) 2018 Red Hat Inc.
+ *
+ * Authors:
+ *  David Hildenbrand <david@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef RESOURCE_HANDLER_H
+#define RESOURCE_HANDLER_H
+
+#include "qom/object.h"
+
+#define TYPE_RESOURCE_HANDLER "resource-handler"
+
+#define RESOURCE_HANDLER_CLASS(klass) \
+    OBJECT_CLASS_CHECK(ResourceHandlerClass, (klass), TYPE_RESOURCE_HANDLER)
+#define RESOURCE_HANDLER_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(ResourceHandlerClass, (obj), TYPE_RESOURCE_HANDLER)
+#define RESOURCE_HANDLER(obj) \
+    INTERFACE_CHECK(ResourceHandler, (obj), TYPE_RESOURCE_HANDLER)
+
+typedef struct ResourceHandler {
+    Object Parent;
+} ResourceHandler;
+
+typedef struct ResourceHandlerClass {
+    InterfaceClass parent;
+
+    void (*pre_assign)(ResourceHandler *rh, const DeviceState *dev,
+                       Error **errp);
+    void (*assign)(ResourceHandler *rh, DeviceState *dev, Error **errp);
+    void (*unassign)(ResourceHandler *rh, DeviceState *dev);
+} ResourceHandlerClass;
+
+void resource_handler_pre_assign(ResourceHandler *rh, const DeviceState *dev,
+                                 Error **errp);
+void resource_handler_assign(ResourceHandler *rh, DeviceState *dev,
+                             Error **errp);
+void resource_handler_unassign(ResourceHandler *rh, DeviceState *dev);
+
+#endif /* RESOURCE_HANDLER_H */
-- 
2.14.3
