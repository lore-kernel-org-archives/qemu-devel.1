Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33501C33CB7
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 12:14:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 098C520716
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 12:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098C520716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwmF4-0004Ps-5a
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 07:14:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52201)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1iwmCH-0007cr-Dy
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:11:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1iwmCF-0001Wb-M8
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:11:53 -0500
Received: from mga09.intel.com ([134.134.136.24]:58702)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1iwmCF-0001NW-Bf
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:11:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Jan 2020 04:11:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,377,1574150400"; d="scan'208";a="314070811"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by fmsmga001.fm.intel.com with ESMTP; 29 Jan 2020 04:11:44 -0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, pbonzini@redhat.com,
 alex.williamson@redhat.com, peterx@redhat.com
Subject: [RFC v3 03/25] hw/iommu: introduce IOMMUContext
Date: Wed, 29 Jan 2020 04:16:34 -0800
Message-Id: <1580300216-86172-4-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580300216-86172-1-git-send-email-yi.l.liu@intel.com>
References: <1580300216-86172-1-git-send-email-yi.l.liu@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.24
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
Cc: kevin.tian@intel.com, yi.l.liu@intel.com, Yi Sun <yi.y.sun@linux.intel.com>,
 kvm@vger.kernel.org, mst@redhat.com, jun.j.tian@intel.com,
 eric.auger@redhat.com, yi.y.sun@intel.com,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, hao.wu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Xu <peterx@redhat.com>

Currently, many platform vendors provide the capability of dual stage
DMA address translation in hardware. For example, nested translation
on Intel VT-d scalable mode, nested stage translation on ARM SMMUv3,
and etc. Also there are efforts to make QEMU vIOMMU be backed by dual
stage DMA address translation capability provided by hardware to have
better address translation support for passthru devices.

As so, making vIOMMU be backed by dual stage translation capability
requires QEMU vIOMMU to have a way to get aware of such hardware
capability and also require a way to receive DMA address translation
faults (e.g. I/O page request) from host as guest owns stage-1 translation
structures in dual stage DAM address translation.

This patch adds IOMMUContext as an abstract of vIOMMU related operations.
Like provide a way for passthru modules (e.g. VFIO) to register
DualStageIOMMUObject instances. And in future, it is expected to offer
support for receiving host DMA translation faults happened on stage-1
translation.

For more backgrounds, may refer to the discussion below, while there
is also difference between the current implementation and original
proposal. This patch introduces the IOMMUContext as an abstract layer
for passthru module (e.g. VFIO) calls into vIOMMU. The first introduced
interface is to make QEMU vIOMMU be aware of dual stage translation
capability.

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
 hw/iommu/Makefile.objs           |  1 +
 hw/iommu/iommu_context.c         | 54 +++++++++++++++++++++++++++++++++++
 include/hw/iommu/iommu_context.h | 61 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 116 insertions(+)
 create mode 100644 hw/iommu/iommu_context.c
 create mode 100644 include/hw/iommu/iommu_context.h

diff --git a/hw/iommu/Makefile.objs b/hw/iommu/Makefile.objs
index d4f3b39..1e45072 100644
--- a/hw/iommu/Makefile.objs
+++ b/hw/iommu/Makefile.objs
@@ -1 +1,2 @@
 obj-y += dual_stage_iommu.o
+obj-y += iommu_context.o
diff --git a/hw/iommu/iommu_context.c b/hw/iommu/iommu_context.c
new file mode 100644
index 0000000..6340ca3
--- /dev/null
+++ b/hw/iommu/iommu_context.c
@@ -0,0 +1,54 @@
+/*
+ * QEMU abstract of vIOMMU context
+ *
+ * Copyright (C) 2020 Red Hat Inc.
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
+#include "hw/iommu/iommu_context.h"
+
+int iommu_context_register_ds_iommu(IOMMUContext *iommu_ctx,
+                                    DualStageIOMMUObject *dsi_obj)
+{
+    if (!iommu_ctx || !dsi_obj) {
+        return -ENOENT;
+    }
+
+    if (iommu_ctx->ops && iommu_ctx->ops->register_ds_iommu) {
+        return iommu_ctx->ops->register_ds_iommu(iommu_ctx, dsi_obj);
+    }
+    return -ENOENT;
+}
+
+void iommu_context_unregister_ds_iommu(IOMMUContext *iommu_ctx,
+                                      DualStageIOMMUObject *dsi_obj)
+{
+    if (!iommu_ctx || !dsi_obj) {
+        return;
+    }
+
+    if (iommu_ctx->ops && iommu_ctx->ops->unregister_ds_iommu) {
+        iommu_ctx->ops->unregister_ds_iommu(iommu_ctx, dsi_obj);
+    }
+}
+
+void iommu_context_init(IOMMUContext *iommu_ctx, IOMMUContextOps *ops)
+{
+    iommu_ctx->ops = ops;
+}
diff --git a/include/hw/iommu/iommu_context.h b/include/hw/iommu/iommu_context.h
new file mode 100644
index 0000000..6f2ccb5
--- /dev/null
+++ b/include/hw/iommu/iommu_context.h
@@ -0,0 +1,61 @@
+/*
+ * QEMU abstraction of IOMMU Context
+ *
+ * Copyright (C) 2020 Red Hat Inc.
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
+#ifndef HW_IOMMU_CONTEXT_H
+#define HW_IOMMU_CONTEXT_H
+
+#include "qemu/queue.h"
+#ifndef CONFIG_USER_ONLY
+#include "exec/hwaddr.h"
+#endif
+#include "hw/iommu/dual_stage_iommu.h"
+
+typedef struct IOMMUContext IOMMUContext;
+typedef struct IOMMUContextOps IOMMUContextOps;
+
+struct IOMMUContextOps {
+    /*
+     * Register DualStageIOMMUObject to vIOMMU thus vIOMMU
+     * is aware of dual stage translation capability, and
+     * also be able to setup dual stage translation via
+     * interfaces exposed by DualStageIOMMUObject.
+     */
+    int (*register_ds_iommu)(IOMMUContext *iommu_ctx,
+                             DualStageIOMMUObject *dsi_obj);
+    void (*unregister_ds_iommu)(IOMMUContext *iommu_ctx,
+                                DualStageIOMMUObject *dsi_obj);
+};
+
+/*
+ * This is an abstraction of IOMMU context.
+ */
+struct IOMMUContext {
+    IOMMUContextOps *ops;
+};
+
+int iommu_context_register_ds_iommu(IOMMUContext *iommu_ctx,
+                                    DualStageIOMMUObject *dsi_obj);
+void iommu_context_unregister_ds_iommu(IOMMUContext *iommu_ctx,
+                                       DualStageIOMMUObject *dsi_obj);
+void iommu_context_init(IOMMUContext *iommu_ctx, IOMMUContextOps *ops);
+
+#endif
-- 
2.7.4


