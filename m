Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE80CCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:21:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84EBC2084C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84EBC2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNd3Q-0002Js-Ub
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 09:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1iNckI-0005FS-Em
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1iNckG-0002SO-Cr
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:01:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:40494)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1iNckF-0002O1-GA
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:01:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Oct 2019 06:01:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,224,1569308400"; d="scan'208";a="210156175"
Received: from iov.bj.intel.com ([10.238.145.67])
 by fmsmga001.fm.intel.com with ESMTP; 24 Oct 2019 06:01:18 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com,
 alex.williamson@redhat.com, peterx@redhat.com
Subject: [RFC v2 04/22] hw/iommu: introduce IOMMUContext
Date: Thu, 24 Oct 2019 08:34:25 -0400
Message-Id: <1571920483-3382-5-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
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
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>, kvm@vger.kernel.org, jun.j.tian@intel.com,
 eric.auger@redhat.com, yi.y.sun@intel.com, jacob.jun.pan@linux.intel.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Xu <peterx@redhat.com>

This patch adds IOMMUContext as an abstract layer of IOMMU related
operations. The current usage of this abstract layer is setup dual-
stage IOMMU translation (vSVA) for vIOMMU.

To setup dual-stage IOMMU translation, vIOMMU needs to propagate
guest changes to host via passthru channels (e.g. VFIO). To have
a better abstraction, it is better to avoid direct calling between
vIOMMU and VFIO. So we have this new structure to act as abstract
layer between VFIO and vIOMMU. So far, it is proposed to provide a
notifier mechanism, which registered by VFIO and fired by vIOMMU.

For more background, may refer to the discussion below:

https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg05022.html

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 hw/Makefile.objs         |  1 +
 hw/iommu/Makefile.objs   |  1 +
 hw/iommu/iommu.c         | 66 ++++++++++++++++++++++++++++++++++++++++
 include/hw/iommu/iommu.h | 79 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 147 insertions(+)
 create mode 100644 hw/iommu/Makefile.objs
 create mode 100644 hw/iommu/iommu.c
 create mode 100644 include/hw/iommu/iommu.h

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index ece6cc3..ac19f9c 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -39,6 +39,7 @@ devices-dirs-y += xen/
 devices-dirs-$(CONFIG_MEM_DEVICE) += mem/
 devices-dirs-y += semihosting/
 devices-dirs-y += smbios/
+devices-dirs-y += iommu/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/iommu/Makefile.objs b/hw/iommu/Makefile.objs
new file mode 100644
index 0000000..0484b79
--- /dev/null
+++ b/hw/iommu/Makefile.objs
@@ -0,0 +1 @@
+obj-y += iommu.o
diff --git a/hw/iommu/iommu.c b/hw/iommu/iommu.c
new file mode 100644
index 0000000..2391b0d
--- /dev/null
+++ b/hw/iommu/iommu.c
@@ -0,0 +1,66 @@
+/*
+ * QEMU abstract of IOMMU context
+ *
+ * Copyright (C) 2019 Red Hat Inc.
+ *
+ * Authors: Peter Xu <peterx@redhat.com>,
+ *          Liu Yi L <yi.l.liu@intel.com>
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
+#include "hw/iommu/iommu.h"
+
+void iommu_ctx_notifier_register(IOMMUContext *iommu_ctx,
+                                 IOMMUCTXNotifier *n,
+                                 IOMMUCTXNotifyFn fn,
+                                 IOMMUCTXEvent event)
+{
+    n->event = event;
+    n->iommu_ctx_event_notify = fn;
+    QLIST_INSERT_HEAD(&iommu_ctx->iommu_ctx_notifiers, n, node);
+    return;
+}
+
+void iommu_ctx_notifier_unregister(IOMMUContext *iommu_ctx,
+                                   IOMMUCTXNotifier *notifier)
+{
+    IOMMUCTXNotifier *cur, *next;
+
+    QLIST_FOREACH_SAFE(cur, &iommu_ctx->iommu_ctx_notifiers, node, next) {
+        if (cur == notifier) {
+            QLIST_REMOVE(cur, node);
+            break;
+        }
+    }
+}
+
+void iommu_ctx_event_notify(IOMMUContext *iommu_ctx,
+                            IOMMUCTXEventData *event_data)
+{
+    IOMMUCTXNotifier *cur;
+
+    QLIST_FOREACH(cur, &iommu_ctx->iommu_ctx_notifiers, node) {
+        if ((cur->event == event_data->event) &&
+                                 cur->iommu_ctx_event_notify) {
+            cur->iommu_ctx_event_notify(cur, event_data);
+        }
+    }
+}
+
+void iommu_context_init(IOMMUContext *iommu_ctx)
+{
+    QLIST_INIT(&iommu_ctx->iommu_ctx_notifiers);
+}
diff --git a/include/hw/iommu/iommu.h b/include/hw/iommu/iommu.h
new file mode 100644
index 0000000..c22c442
--- /dev/null
+++ b/include/hw/iommu/iommu.h
@@ -0,0 +1,79 @@
+/*
+ * QEMU abstraction of IOMMU Context
+ *
+ * Copyright (C) 2019 Red Hat Inc.
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
+typedef struct IOMMUContext IOMMUContext;
+
+enum IOMMUCTXEvent {
+    IOMMU_CTX_EVENT_NUM,
+};
+typedef enum IOMMUCTXEvent IOMMUCTXEvent;
+
+struct IOMMUCTXEventData {
+    IOMMUCTXEvent event;
+    uint64_t length;
+    void *data;
+};
+typedef struct IOMMUCTXEventData IOMMUCTXEventData;
+
+typedef struct IOMMUCTXNotifier IOMMUCTXNotifier;
+
+typedef void (*IOMMUCTXNotifyFn)(IOMMUCTXNotifier *notifier,
+                                 IOMMUCTXEventData *event_data);
+
+struct IOMMUCTXNotifier {
+    IOMMUCTXNotifyFn iommu_ctx_event_notify;
+    /*
+     * What events we are listening to. Let's allow multiple event
+     * registrations from beginning.
+     */
+    IOMMUCTXEvent event;
+    QLIST_ENTRY(IOMMUCTXNotifier) node;
+};
+
+/*
+ * This is an abstraction of IOMMU context.
+ */
+struct IOMMUContext {
+    uint32_t pasid;
+    QLIST_HEAD(, IOMMUCTXNotifier) iommu_ctx_notifiers;
+};
+
+void iommu_ctx_notifier_register(IOMMUContext *iommu_ctx,
+                                 IOMMUCTXNotifier *n,
+                                 IOMMUCTXNotifyFn fn,
+                                 IOMMUCTXEvent event);
+void iommu_ctx_notifier_unregister(IOMMUContext *iommu_ctx,
+                                   IOMMUCTXNotifier *notifier);
+void iommu_ctx_event_notify(IOMMUContext *iommu_ctx,
+                            IOMMUCTXEventData *event_data);
+
+void iommu_context_init(IOMMUContext *iommu_ctx);
+
+#endif
-- 
2.7.4


