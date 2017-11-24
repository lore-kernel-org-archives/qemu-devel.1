Received: from eggs.gnu.org ([2001:4830:134:3::10]:48310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eI9zF-0003yg-JA
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 04:09:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eI9zD-0000ED-MW
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 04:09:29 -0500
Received: from mga14.intel.com ([192.55.52.115]:26004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1eI9zD-00006q-6k
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 04:09:27 -0500
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Fri, 24 Nov 2017 16:52:36 +0800
Message-Id: <1511513560-28611-4-git-send-email-yi.l.liu@linux.intel.com>
In-Reply-To: <1511513560-28611-1-git-send-email-yi.l.liu@linux.intel.com>
References: <1511513560-28611-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v2 3/7] hw/core: introduce IOMMUObject
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au
Cc: pbonzini@redhat.com, alex.williamson@redhat.com, eric.auger.pro@gmail.com, tianyu.lan@intel.com, yi.l.liu@intel.com, peterx@redhat.com, kevin.tian@intel.com, jasowang@redhat.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>

From: Peter Xu <peterx@redhat.com>

This patch is introducing an IOMMU abstract in Qemu to support the
new IOMMU operations other than MAP/UNMAP.

For systems that have IOMMUs, it would introduce DMA isolation. The
isolation may be multiple DMA AddressSpaces or multiple DMA windows.
Without IOMMU, the DMA AddressSpace would be a single and shared
DMA address space across the system.

For the DMA AddressSpace, modern IOMMUs has introduced more address
space other than traditional IOVA. e.g. VT-d/AMD-IOMMU/ARM-SMMU has
included Process Virtual Address Space as a DMA AddressSpace. This
enables Shared-Virtual-Memory usage on such platform.
* For IOVA address space, IOMMU owns it. IOMMU needs to do MAP/UNMAP for
  mappings. It's mapping level operation.
* For process-VA, MMU owns it, IOMMU just consumes it. IOMMU only links
  the translation table pointer to the corresponding process page table(it
  is CR3 table on x86 platform). So it is much like page table level(or
  say it address space level) operation.

So the treatment to IOVA and process-VA are different in IOMMU.

Regards to the current vIOMMU emulation in Qemu, it only exposes the
traditional IOVA isolation to guest, so the operations of vIOMMU is
mostly MAP/UNMAP. While for process-VA, it requires new operation. e.g.
link the CR3 page table pointer to the iommu translation hierarchy, or
flush the process-VA mappings in iotlb. So far, Qemu attaches MAP/UNMAP
on MemoryRegion, it doesn't suit the new IOMMU operations mentioned above.
Let me take virt-SVM on VT-d as an example. And it can be applied to other
vendors which supports virt-SVM by performing nested translation.
Reason as below:
- virt-SVM works along with PT = 1
- if PT = 1 IOMMU MR are disabled so MR notifier are not registered
- new notifiers do not fit nicely in this framework as they need to be
  registered even if PT = 1
- so need to introduce a new notifier framework.

Based on the statements above, IOMMUObject is introduced. It is supposed to
be an abstract of IOMMU(aka. isolation unit). It can be used to attach new
IOMMU operations other than MAP/UNMAP, and it can also be used to detect if
vIOMMU is exposed to guest.

Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 hw/core/Makefile.objs   |  1 +
 hw/core/iommu.c         | 64 +++++++++++++++++++++++++++++++++++++++++
 include/hw/core/iommu.h | 76 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+)
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
index 0000000..6e89f3b
--- /dev/null
+++ b/hw/core/iommu.c
@@ -0,0 +1,64 @@
+/*
+ * QEMU abstract of IOMMU logic
+ *
+ * Copyright (C) 2017 Red Hat Inc.
+ *
+ * Authors: Peter Xu <peterx@redhat.com>,
+ *          Liu, Yi L <yi.l.liu@intel.com>
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
+
+void iommu_object_init(IOMMUObject *iommu)
+{
+    QLIST_INIT(&iommu->iommu_notifiers);
+}
diff --git a/include/hw/core/iommu.h b/include/hw/core/iommu.h
new file mode 100644
index 0000000..453ea64
--- /dev/null
+++ b/include/hw/core/iommu.h
@@ -0,0 +1,76 @@
+/*
+ * QEMU abstraction of IOMMU logic
+ *
+ * Copyright (C) 2017 Red Hat Inc.
+ *
+ * Authors: Peter Xu <peterx@redhat.com>,
+ *          Liu, Yi L <yi.l.liu@intel.com>
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
+void iommu_object_init(IOMMUObject *iommu);
+
+#endif
-- 
1.9.1
