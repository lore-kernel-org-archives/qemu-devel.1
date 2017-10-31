Received: from eggs.gnu.org ([2001:4830:134:3::10]:37419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1e9P1Q-00012Z-KP
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 01:23:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1e9P1O-0004ft-TE
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 01:23:32 -0400
Received: from mga07.intel.com ([134.134.136.100]:53480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1e9P1O-0004cw-HR
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 01:23:30 -0400
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Tue, 31 Oct 2017 13:07:01 +0800
Message-Id: <1509426425-23890-3-git-send-email-yi.l.liu@linux.intel.com>
In-Reply-To: <1509426425-23890-1-git-send-email-yi.l.liu@linux.intel.com>
References: <1509426425-23890-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [PATCH 2/6] memory: introduce AddressSpaceOps and
 IOMMUObject
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au, pbonzini@redhat.com, alex.williamson@redhat.com
Cc: tianyu.lan@intel.com, yi.l.liu@intel.com, peterx@redhat.com, kevin.tian@intel.com, jasowang@redhat.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>

From: Peter Xu <peterx@redhat.com>

AddressSpaceOps is similar to MemoryRegionOps, it's just for address
spaces to store arch-specific hooks.

The first hook I would like to introduce is iommu_get(). Return an
IOMMUObject behind the AddressSpace.

For systems that have IOMMUs, we will create a special address
space per device which is different from system default address
space for it (please refer to pci_device_iommu_address_space()).
Normally when that happens, there will be one specific IOMMU (or
say, translation unit) stands right behind that new address space.

This iommu_get() fetches that guy behind the address space. Here,
the guy is defined as IOMMUObject, which includes a notifier_list
so far, may extend in future. Along with IOMMUObject, a new iommu
notifier mechanism is introduced. It would be used for virt-svm.
Also IOMMUObject can further have a IOMMUObjectOps which is similar
to MemoryRegionOps. The difference is IOMMUObjectOps is not relied
on MemoryRegion.

Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 hw/core/Makefile.objs   |  1 +
 hw/core/iommu.c         | 58 +++++++++++++++++++++++++++++++++++++++
 include/exec/memory.h   | 22 +++++++++++++++
 include/hw/core/iommu.h | 73 +++++++++++++++++++++++++++++++++++++++++++++++++
 memory.c                |  8 ++++++
 5 files changed, 162 insertions(+)
 create mode 100644 hw/core/iommu.c
 create mode 100644 include/hw/core/iommu.h

diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index f8d7a4a..d688412 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -5,6 +5,7 @@ common-obj-y += fw-path-provider.o
 # irq.o needed for qdev GPIO handling:
 common-obj-y += irq.o
 common-obj-y += hotplug.o
+common-obj-y += iommu.o
 common-obj-y += nmi.o
 
 common-obj-$(CONFIG_EMPTY_SLOT) += empty_slot.o
diff --git a/hw/core/iommu.c b/hw/core/iommu.c
new file mode 100644
index 0000000..7c4fcfe
--- /dev/null
+++ b/hw/core/iommu.c
@@ -0,0 +1,58 @@
+/*
+ * QEMU emulation of IOMMU logic
+ *
+ * Copyright (C) 2017 Red Hat Inc.
+ *
+ * Authors: Peter Xu <peterx@redhat.com>,
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/iommu.h"
+
+void iommu_notifier_register(IOMMUObject *iommu,
+                             IOMMUNotifier *n,
+                             IOMMUNotifyFn fn,
+                             IOMMUEvent event)
+{
+    n->event = event;
+    n->iommu_notify = fn;
+    QLIST_INSERT_HEAD(&iommu->iommu_notifiers, n, node);
+    return;
+}
+
+void iommu_notifier_unregister(IOMMUObject *iommu,
+                               IOMMUNotifier *notifier)
+{
+    IOMMUNotifier *cur, *next;
+
+    QLIST_FOREACH_SAFE(cur, &iommu->iommu_notifiers, node, next) {
+        if (cur == notifier) {
+            QLIST_REMOVE(cur, node);
+            break;
+        }
+    }
+}
+
+void iommu_notify(IOMMUObject *iommu, IOMMUEventData *event_data)
+{
+    IOMMUNotifier *cur;
+
+    QLIST_FOREACH(cur, &iommu->iommu_notifiers, node) {
+        if ((cur->event == event_data->event) && cur->iommu_notify) {
+            cur->iommu_notify(cur, event_data);
+        }
+    }
+}
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 03595e3..8350973 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -26,6 +26,7 @@
 #include "qom/object.h"
 #include "qemu/rcu.h"
 #include "hw/qdev-core.h"
+#include "hw/core/iommu.h"
 
 #define RAM_ADDR_INVALID (~(ram_addr_t)0)
 
@@ -301,6 +302,19 @@ struct MemoryListener {
 };
 
 /**
+ * AddressSpaceOps: callbacks structure for address space specific operations
+ *
+ * @iommu_get: returns an IOMMU object that backs the address space.
+ *             Normally this should be NULL for generic address
+ *             spaces, and it's only used when there is one
+ *             translation unit behind this address space.
+ */
+struct AddressSpaceOps {
+    IOMMUObject *(*iommu_get)(AddressSpace *as);
+};
+typedef struct AddressSpaceOps AddressSpaceOps;
+
+/**
  * AddressSpace: describes a mapping of addresses to #MemoryRegion objects
  */
 struct AddressSpace {
@@ -316,6 +330,7 @@ struct AddressSpace {
     struct MemoryRegionIoeventfd *ioeventfds;
     QTAILQ_HEAD(memory_listeners_as, MemoryListener) listeners;
     QTAILQ_ENTRY(AddressSpace) address_spaces_link;
+    AddressSpaceOps as_ops;
 };
 
 FlatView *address_space_to_flatview(AddressSpace *as);
@@ -1988,6 +2003,13 @@ address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
     address_space_write(cache->as, cache->xlat + addr, MEMTXATTRS_UNSPECIFIED, buf, len);
 }
 
+/**
+ * address_space_iommu_get: Get the backend IOMMU for the address space
+ *
+ * @as: the address space to fetch IOMMU from
+ */
+IOMMUObject *address_space_iommu_get(AddressSpace *as);
+
 #endif
 
 #endif
diff --git a/include/hw/core/iommu.h b/include/hw/core/iommu.h
new file mode 100644
index 0000000..34387c0
--- /dev/null
+++ b/include/hw/core/iommu.h
@@ -0,0 +1,73 @@
+/*
+ * QEMU emulation of IOMMU logic
+ *
+ * Copyright (C) 2017 Red Hat Inc.
+ *
+ * Authors: Peter Xu <peterx@redhat.com>,
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_CORE_IOMMU_H
+#define HW_CORE_IOMMU_H
+
+#include "qemu/queue.h"
+
+enum IOMMUEvent {
+    IOMMU_EVENT_BIND_PASIDT,
+};
+typedef enum IOMMUEvent IOMMUEvent;
+
+struct IOMMUEventData {
+    IOMMUEvent event;
+    uint64_t length;
+    void *data;
+};
+typedef struct IOMMUEventData IOMMUEventData;
+
+typedef struct IOMMUNotifier IOMMUNotifier;
+
+typedef void (*IOMMUNotifyFn)(IOMMUNotifier *notifier,
+                              IOMMUEventData *event_data);
+
+struct IOMMUNotifier {
+    IOMMUNotifyFn iommu_notify;
+    /*
+     * What events we are listening to. Let's allow multiple event
+     * registrations from beginning.
+     */
+    IOMMUEvent event;
+    QLIST_ENTRY(IOMMUNotifier) node;
+};
+
+typedef struct IOMMUObject IOMMUObject;
+
+/*
+ * This stands for an IOMMU unit. Any translation device should have
+ * this struct inside its own structure to make sure it can leverage
+ * common IOMMU functionalities.
+ */
+struct IOMMUObject {
+    QLIST_HEAD(, IOMMUNotifier) iommu_notifiers;
+};
+
+void iommu_notifier_register(IOMMUObject *iommu,
+                             IOMMUNotifier *n,
+                             IOMMUNotifyFn fn,
+                             IOMMUEvent event);
+void iommu_notifier_unregister(IOMMUObject *iommu,
+                               IOMMUNotifier *notifier);
+void iommu_notify(IOMMUObject *iommu, IOMMUEventData *event_data);
+
+#endif
diff --git a/memory.c b/memory.c
index 77fb3ef..ec67441 100644
--- a/memory.c
+++ b/memory.c
@@ -2793,6 +2793,14 @@ static void do_address_space_destroy(AddressSpace *as)
     memory_region_unref(as->root);
 }
 
+IOMMUObject *address_space_iommu_get(AddressSpace *as)
+{
+    if (!as->as_ops.iommu_get) {
+        return NULL;
+    }
+    return as->as_ops.iommu_get(as);
+}
+
 void address_space_destroy(AddressSpace *as)
 {
     MemoryRegion *root = as->root;
-- 
1.9.1
