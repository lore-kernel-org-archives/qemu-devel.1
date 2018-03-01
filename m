Received: from eggs.gnu.org ([2001:4830:134:3::10]:52677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1erLli-00048d-7T
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:49:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1erLlg-0007iF-LY
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:48:58 -0500
Received: from mga14.intel.com ([192.55.52.115]:7314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1erLlg-0007fT-8o
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:48:56 -0500
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Thu,  1 Mar 2018 18:31:53 +0800
Message-Id: <1519900322-30263-4-git-send-email-yi.l.liu@linux.intel.com>
In-Reply-To: <1519900322-30263-1-git-send-email-yi.l.liu@linux.intel.com>
References: <1519900322-30263-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v3 03/12] hw/core: introduce IOMMUSVAContext
 for virt-SVA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au
Cc: pbonzini@redhat.com, alex.williamson@redhat.com, eric.auger.pro@gmail.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>

From: Peter Xu <peterx@redhat.com>

This patch adds IOMMUSVAContext as an abstract for virt-SVA in
Qemu.

IOMMUSVAContext is per-PASID(Process Address Space Identity).
A PASID Tagged AddressSpace should have an IOMMUSVAContext
created for it. virt-SVA emulation for emulated SVA capable
devices would use IOMMUSVAContext. And for assigned devices,
Qemu also needs to propagate guest tlb flush to host through
the sva_notifer based on IOMMUSVAContext.

This patch proposes to include a sva_notifier list and
an IOMMUSVAContextOps in IOMMUSVAContext.

* The sva_notifier list would include tlb invalidate nofitifer
  to propagate guest's iotlb flush to host.
* The first callback in IOMMUSVAContextOps would be an address
  translation callback. For the SVA aware DMAs issued by emulated
  SVA capable devices, it requires Qemu to emulate data read/write
  to guest process address space. Qemu needs to do address translation
  with guest process page table. So the IOMMUSVAContextOps.translate()
  callback would be helpful for emulating SVA capable devices.

Note: to fulfill the IOMMUSVAContext based address translation
framework, may duplicate quite a few existing MemoryRegion based
translation code in Qemu. As this patchset is mainly to support
assigned SVA capable devices. So this patchset hasn't done the
duplication. In future, if any requirement for emulating SVA
capable device, it would require a separate patchset to fulfill
the translation framework.

Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 hw/core/Makefile.objs   |   1 +
 hw/core/pasid.c         |  64 ++++++++++++++++++++++++++++
 include/hw/core/pasid.h | 110 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 175 insertions(+)
 create mode 100644 hw/core/pasid.c
 create mode 100644 include/hw/core/pasid.h

diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index 1240728..01989d2 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -6,6 +6,7 @@ common-obj-$(CONFIG_SOFTMMU) += fw-path-provider.o
 # irq.o needed for qdev GPIO handling:
 common-obj-y += irq.o
 common-obj-y += hotplug.o
+common-obj-y += pasid.o
 common-obj-$(CONFIG_SOFTMMU) += nmi.o
 
 common-obj-$(CONFIG_EMPTY_SLOT) += empty_slot.o
diff --git a/hw/core/pasid.c b/hw/core/pasid.c
new file mode 100644
index 0000000..c4b0c5d
--- /dev/null
+++ b/hw/core/pasid.c
@@ -0,0 +1,64 @@
+/*
+ * QEMU abstract of Shared Virtual Memory logic
+ *
+ * Copyright (C) 2018 Red Hat Inc.
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
+#include "hw/core/pasid.h"
+
+void iommu_sva_notifier_register(IOMMUSVAContext *sva_ctx,
+                                 IOMMUSVANotifier *n,
+                                 IOMMUSVANotifyFn fn,
+                                 IOMMUSVAEvent event)
+{
+    n->event = event;
+    n->sva_notify = fn;
+    QLIST_INSERT_HEAD(&sva_ctx->sva_notifiers, n, node);
+    return;
+}
+
+void iommu_sva_notifier_unregister(IOMMUSVAContext *sva_ctx,
+                                   IOMMUSVANotifier *notifier)
+{
+    IOMMUSVANotifier *cur, *next;
+
+    QLIST_FOREACH_SAFE(cur, &sva_ctx->sva_notifiers, node, next) {
+        if (cur == notifier) {
+            QLIST_REMOVE(cur, node);
+            break;
+        }
+    }
+}
+
+void iommu_sva_notify(IOMMUSVAContext *sva_ctx, IOMMUSVAEventData *event_data)
+{
+    IOMMUSVANotifier *cur;
+
+    QLIST_FOREACH(cur, &sva_ctx->sva_notifiers, node) {
+        if ((cur->event == event_data->event) && cur->sva_notify) {
+            cur->sva_notify(cur, event_data);
+        }
+    }
+}
+
+void iommu_sva_ctx_init(IOMMUSVAContext *sva_ctx)
+{
+    QLIST_INIT(&sva_ctx->sva_notifiers);
+}
diff --git a/include/hw/core/pasid.h b/include/hw/core/pasid.h
new file mode 100644
index 0000000..4c7dccb
--- /dev/null
+++ b/include/hw/core/pasid.h
@@ -0,0 +1,110 @@
+/*
+ * QEMU abstraction of Shared Virtual Memory
+ *
+ * Copyright (C) 2018 Red Hat Inc.
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
+#ifndef HW_PCI_PASID_H
+#define HW_PCI_PASID_H
+
+#include "qemu/queue.h"
+#ifndef CONFIG_USER_ONLY
+#include "exec/hwaddr.h"
+#endif
+
+typedef struct IOMMUSVAContext IOMMUSVAContext;
+
+enum IOMMUSVAEvent {
+    IOMMU_SVA_EVENT_TLB_INV,
+};
+typedef enum IOMMUSVAEvent IOMMUSVAEvent;
+
+struct IOMMUSVAEventData {
+    IOMMUSVAEvent event;
+    uint64_t length;
+    void *data;
+};
+typedef struct IOMMUSVAEventData IOMMUSVAEventData;
+
+typedef struct IOMMUSVANotifier IOMMUSVANotifier;
+
+typedef void (*IOMMUSVANotifyFn)(IOMMUSVANotifier *notifier,
+                                 IOMMUSVAEventData *event_data);
+
+typedef struct IOMMUSVATLBEntry IOMMUSVATLBEntry;
+
+/* See address_space_translate: bit 0 is read, bit 1 is write.  */
+typedef enum {
+    IOMMU_SVA_NONE = 0,
+    IOMMU_SVA_RO   = 1,
+    IOMMU_SVA_WO   = 2,
+    IOMMU_SVA_RW   = 3,
+} IOMMUSVAAccessFlags;
+
+#define IOMMU_SVA_ACCESS_FLAG(r, w) (((r) ? IOMMU_SVA_RO : 0) | \
+                                     ((w) ? IOMMU_SVA_WO : 0))
+
+struct IOMMUSVATLBEntry {
+    AddressSpace    *target_as;
+    hwaddr           va;
+    hwaddr           translated_addr;
+    hwaddr           addr_mask;  /* 0xfff = 4k translation */
+    IOMMUSVAAccessFlags perm;
+};
+
+typedef struct IOMMUSVAContextOps IOMMUSVAContextOps;
+struct IOMMUSVAContextOps {
+    /* Return a TLB entry that contains a given address. */
+    IOMMUSVATLBEntry (*translate)(IOMMUSVAContext *sva_ctx,
+                                  hwaddr addr, bool is_write);
+};
+
+struct IOMMUSVANotifier {
+    IOMMUSVANotifyFn sva_notify;
+    /*
+     * What events we are listening to. Let's allow multiple event
+     * registrations from beginning.
+     */
+    IOMMUSVAEvent event;
+    QLIST_ENTRY(IOMMUSVANotifier) node;
+};
+
+/*
+ * This stands for an IOMMU unit. Any translation device should have
+ * this struct inside its own structure to make sure it can leverage
+ * common IOMMU functionalities.
+ */
+struct IOMMUSVAContext {
+    uint32_t pasid;
+    QLIST_HEAD(, IOMMUSVANotifier) sva_notifiers;
+    const IOMMUSVAContextOps *sva_ctx_ops;
+};
+
+void iommu_sva_notifier_register(IOMMUSVAContext *sva_ctx,
+                                 IOMMUSVANotifier *n,
+                                 IOMMUSVANotifyFn fn,
+                                 IOMMUSVAEvent event);
+void iommu_sva_notifier_unregister(IOMMUSVAContext *sva_ctx,
+                                   IOMMUSVANotifier *notifier);
+void iommu_sva_notify(IOMMUSVAContext *sva_ctx,
+                      IOMMUSVAEventData *event_data);
+
+void iommu_sva_ctx_init(IOMMUSVAContext *sva_ctx);
+
+#endif
-- 
1.9.1
