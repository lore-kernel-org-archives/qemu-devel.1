Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_RHS_DOB,URI_WP_DIRINDEX,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B874C35671
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 08:10:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74DB72071E
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 08:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74DB72071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5PrT-000886-Kb
	for qemu-devel@archiver.kernel.org; Sat, 22 Feb 2020 03:10:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1j5Pjm-0002BY-GZ
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:02:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1j5Pji-00081m-ST
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:02:10 -0500
Received: from mga12.intel.com ([192.55.52.136]:36218)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1j5Pji-0007tM-Fp
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:02:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Feb 2020 00:01:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,471,1574150400"; d="scan'208";a="240547662"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga006.jf.intel.com with ESMTP; 22 Feb 2020 00:01:56 -0800
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org,
	alex.williamson@redhat.com,
	peterx@redhat.com
Subject: [RFC v3.1 04/22] hw/iommu: introduce HostIOMMUContext
Date: Sat, 22 Feb 2020 00:07:05 -0800
Message-Id: <1582358843-51931-5-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582358843-51931-1-git-send-email-yi.l.liu@intel.com>
References: <1582358843-51931-1-git-send-email-yi.l.liu@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.136
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
 Jacob Pan <jacob.jun.pan@linux.intel.com>, pbonzini@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently, many platform vendors provide the capability of dual stage
DMA address translation in hardware. For example, nested translation
on Intel VT-d scalable mode, nested stage translation on ARM SMMUv3,
and etc. In dual stage DMA address translation, there are two stages
address translation, stage-1 (a.k.a first-level) and stage-2 (a.k.a
second-level) translation structures. Stage-1 translation results are
also subjected to stage-2 translation structures. Take vSVA (Virtual
Shared Virtual Addressing) as an example, guest IOMMU driver owns
stage-1 translation structures (covers GVA->GPA translation), and host
IOMMU driver owns stage-2 translation structures (covers GPA->HPA
translation). VMM is responsible to bind stage-1 translation structures
to host, thus hardware could achieve GVA->GPA and then GPA->HPA
translation. For more background on SVA, refer the below links.
 - https://www.youtube.com/watch?v=Kq_nfGK5MwQ
 - https://events19.lfasiallc.com/wp-content/uploads/2017/11/\
Shared-Virtual-Memory-in-KVM_Yi-Liu.pdf

In QEMU, vIOMMU emualtors expose IOMMUs to VM per their own spec. Devices
are pass-through to guest via device pass-through components like VFIO.
VFIO is a userspace driver framework which exposes host IOMMU programming
capability to userspace in a secure way. e.g. IOVA MAP/UNMAP requests. Thus
the major connection between VFIO and vIOMMU are MAP/UNMAP. However, with
the dual stage DMA translation support, there are more interactions between
vIOMMU and VFIO as below:
 1) PASID allocation (allow host to intercept in PASID allocation)
 2) bind stage-1 translation structures to host
 3) propagate stage-1 cache invalidation to host
 4) DMA address translation fault (I/O page fault) servicing etc.

With the above new interactions, it requires an abstract layer to abstract
the above operations and expose to vIOMMU emulators as an explicit way for
vIOMMU emulators call into VFIO. This patch introduces HostIOMMUContext to
stand for hardware IOMMU w/ dual stage DMA address translation capability.
PASID allocation/free are the first two operations included to demonstrate
the design, in future, there will be more operations like bind_stage1_pgtbl
and invalidate_stage1_cache and etc.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 hw/Makefile.objs                      |  1 +
 hw/iommu/Makefile.objs                |  1 +
 hw/iommu/host_iommu_context.c         | 55 +++++++++++++++++++++++++++++++
 include/hw/iommu/host_iommu_context.h | 61 +++++++++++++++++++++++++++++++++++
 4 files changed, 118 insertions(+)
 create mode 100644 hw/iommu/Makefile.objs
 create mode 100644 hw/iommu/host_iommu_context.c
 create mode 100644 include/hw/iommu/host_iommu_context.h

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 660e2b4..cab83fe 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -40,6 +40,7 @@ devices-dirs-$(CONFIG_MEM_DEVICE) += mem/
 devices-dirs-$(CONFIG_NUBUS) += nubus/
 devices-dirs-y += semihosting/
 devices-dirs-y += smbios/
+devices-dirs-y += iommu/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/iommu/Makefile.objs b/hw/iommu/Makefile.objs
new file mode 100644
index 0000000..e6eed4e
--- /dev/null
+++ b/hw/iommu/Makefile.objs
@@ -0,0 +1 @@
+obj-y += host_iommu_context.o
diff --git a/hw/iommu/host_iommu_context.c b/hw/iommu/host_iommu_context.c
new file mode 100644
index 0000000..11b092f
--- /dev/null
+++ b/hw/iommu/host_iommu_context.c
@@ -0,0 +1,55 @@
+/*
+ * QEMU abstract of Host IOMMU
+ *
+ * Copyright (C) 2020 Intel Corporation.
+ *
+ * Authors: Liu Yi L <yi.l.liu@intel.com>
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
+#include "hw/iommu/host_iommu_context.h"
+
+int host_iommu_ctx_pasid_alloc(HostIOMMUContext *host_icx, uint32_t min,
+                               uint32_t max, uint32_t *pasid)
+{
+    if (host_icx && (host_icx->flags & HOST_IOMMU_PASID_REQUEST) &&
+        host_icx->ops && host_icx->ops->pasid_alloc) {
+        return host_icx->ops->pasid_alloc(host_icx, min, max, pasid);
+    }
+    return -ENOENT;
+}
+
+int host_iommu_ctx_pasid_free(HostIOMMUContext *host_icx, uint32_t pasid)
+{
+    if (host_icx && (host_icx->flags & HOST_IOMMU_PASID_REQUEST) &&
+        host_icx->ops && host_icx->ops->pasid_free) {
+        return host_icx->ops->pasid_free(host_icx, pasid);
+    }
+    return -ENOENT;
+}
+
+void host_iommu_ctx_init(HostIOMMUContext *host_icx,
+                         uint64_t flags, HostIOMMUOps *ops)
+{
+    host_icx->flags = flags;
+    host_icx->ops = ops;
+}
+
+void host_iommu_ctx_destroy(HostIOMMUContext *host_icx)
+{
+    host_icx->flags = 0x0;
+    host_icx->ops = NULL;
+}
diff --git a/include/hw/iommu/host_iommu_context.h b/include/hw/iommu/host_iommu_context.h
new file mode 100644
index 0000000..f4d811a
--- /dev/null
+++ b/include/hw/iommu/host_iommu_context.h
@@ -0,0 +1,61 @@
+/*
+ * QEMU abstraction of Host IOMMU
+ *
+ * Copyright (C) 2020 Intel Corporation.
+ *
+ * Authors: Liu Yi L <yi.l.liu@intel.com>
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
+
+typedef struct HostIOMMUContext HostIOMMUContext;
+typedef struct HostIOMMUOps HostIOMMUOps;
+
+struct HostIOMMUOps {
+    /* Allocate pasid from HostIOMMUContext (a.k.a. host software) */
+    int (*pasid_alloc)(HostIOMMUContext *host_icx,
+                       uint32_t min,
+                       uint32_t max,
+                       uint32_t *pasid);
+    /* Reclaim pasid from HostIOMMUContext (a.k.a. host software) */
+    int (*pasid_free)(HostIOMMUContext *host_icx,
+                      uint32_t pasid);
+};
+
+/*
+ * This is an abstraction of host IOMMU with dual-stage capability
+ */
+struct HostIOMMUContext {
+#define HOST_IOMMU_PASID_REQUEST (1ULL << 0)
+    uint64_t flags;
+    HostIOMMUOps *ops;
+};
+
+int host_iommu_ctx_pasid_alloc(HostIOMMUContext *host_icx, uint32_t min,
+                               uint32_t max, uint32_t *pasid);
+int host_iommu_ctx_pasid_free(HostIOMMUContext *host_icx, uint32_t pasid);
+
+void host_iommu_ctx_init(HostIOMMUContext *host_icx,
+                         uint64_t flags, HostIOMMUOps *ops);
+void host_iommu_ctx_destroy(HostIOMMUContext *host_icx);
+
+#endif
-- 
2.7.4


