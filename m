Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URI_WP_DIRINDEX,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8500FC35240
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 12:16:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D9DE20716
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 12:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D9DE20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwmGr-0007v6-FA
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 07:16:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1iwmCH-0007co-2V
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:11:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1iwmCF-0001VZ-A5
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:11:53 -0500
Received: from mga09.intel.com ([134.134.136.24]:58727)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1iwmCB-0001Rn-L2
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:11:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Jan 2020 04:11:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,377,1574150400"; d="scan'208";a="314070787"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by fmsmga001.fm.intel.com with ESMTP; 29 Jan 2020 04:11:43 -0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, pbonzini@redhat.com,
 alex.williamson@redhat.com, peterx@redhat.com
Subject: [RFC v3 02/25] hw/iommu: introduce DualStageIOMMUObject
Date: Wed, 29 Jan 2020 04:16:33 -0800
Message-Id: <1580300216-86172-3-git-send-email-yi.l.liu@intel.com>
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

From: Liu Yi L <yi.l.liu@intel.com>

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

As above, dual stage DMA translation offers two stage address mappings,
which could have better DMA address translation support for passthru
devices. This is also what vIOMMU developers are doing so far. Efforts
includes vSVA enabling from Yi Liu and SMMUv3 Nested Stage Setup from
Eric Auger.
https://www.spinics.net/lists/kvm/msg198556.html
https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg02842.html

Both efforts are aiming to expose a vIOMMU with dual stage hardware
backed. As so, QEMU needs to have an explicit object to stand for
the dual stage capability from hardware. Such object offers abstract
for the dual stage DMA translation related operations, like:

 1) PASID allocation (allow host to intercept in PASID allocation)
 2) bind stage-1 translation structures to host
 3) propagate stage-1 cache invalidation to host
 4) DMA address translation fault (I/O page fault) servicing etc.

This patch introduces DualStageIOMMUObject to stand for the hardware
dual stage DMA translation capability. PASID allocation/free are the
first operation included in it, in future, there will be more operations
like bind_stage1_pgtbl and invalidate_stage1_cache and etc.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 hw/Makefile.objs                    |  1 +
 hw/iommu/Makefile.objs              |  1 +
 hw/iommu/dual_stage_iommu.c         | 59 +++++++++++++++++++++++++++++++++++++
 include/hw/iommu/dual_stage_iommu.h | 59 +++++++++++++++++++++++++++++++++++++
 4 files changed, 120 insertions(+)
 create mode 100644 hw/iommu/Makefile.objs
 create mode 100644 hw/iommu/dual_stage_iommu.c
 create mode 100644 include/hw/iommu/dual_stage_iommu.h

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
index 0000000..d4f3b39
--- /dev/null
+++ b/hw/iommu/Makefile.objs
@@ -0,0 +1 @@
+obj-y += dual_stage_iommu.o
diff --git a/hw/iommu/dual_stage_iommu.c b/hw/iommu/dual_stage_iommu.c
new file mode 100644
index 0000000..be4179d
--- /dev/null
+++ b/hw/iommu/dual_stage_iommu.c
@@ -0,0 +1,59 @@
+/*
+ * QEMU abstract of Hardware Dual Stage DMA translation capability
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
+#include "hw/iommu/dual_stage_iommu.h"
+
+int ds_iommu_pasid_alloc(DualStageIOMMUObject *dsi_obj, uint32_t min,
+                         uint32_t max, uint32_t *pasid)
+{
+    if (!dsi_obj) {
+        return -ENOENT;
+    }
+
+    if (dsi_obj->ops && dsi_obj->ops->pasid_alloc) {
+        return dsi_obj->ops->pasid_alloc(dsi_obj, min, max, pasid);
+    }
+    return -ENOENT;
+}
+
+int ds_iommu_pasid_free(DualStageIOMMUObject *dsi_obj, uint32_t pasid)
+{
+    if (!dsi_obj) {
+        return -ENOENT;
+    }
+
+    if (dsi_obj->ops && dsi_obj->ops->pasid_free) {
+        return dsi_obj->ops->pasid_free(dsi_obj, pasid);
+    }
+    return -ENOENT;
+}
+
+void ds_iommu_object_init(DualStageIOMMUObject *dsi_obj,
+                          DualStageIOMMUOps *ops)
+{
+    dsi_obj->ops = ops;
+}
+
+void ds_iommu_object_destroy(DualStageIOMMUObject *dsi_obj)
+{
+    dsi_obj->ops = NULL;
+}
diff --git a/include/hw/iommu/dual_stage_iommu.h b/include/hw/iommu/dual_stage_iommu.h
new file mode 100644
index 0000000..e9891e3
--- /dev/null
+++ b/include/hw/iommu/dual_stage_iommu.h
@@ -0,0 +1,59 @@
+/*
+ * QEMU abstraction of IOMMU Context
+ *
+ * Copyright (C) 2020 Red Hat Inc.
+ *
+ * Authors: Liu, Yi L <yi.l.liu@intel.com>
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
+#ifndef HW_DS_IOMMU_H
+#define HW_DS_IOMMU_H
+
+#include "qemu/queue.h"
+#ifndef CONFIG_USER_ONLY
+#include "exec/hwaddr.h"
+#endif
+
+typedef struct DualStageIOMMUObject DualStageIOMMUObject;
+typedef struct DualStageIOMMUOps DualStageIOMMUOps;
+
+struct DualStageIOMMUOps {
+    /* Allocate pasid from DualStageIOMMU (a.k.a. host IOMMU) */
+    int (*pasid_alloc)(DualStageIOMMUObject *dsi_obj,
+                       uint32_t min,
+                       uint32_t max,
+                       uint32_t *pasid);
+    /* Reclaim a pasid from DualStageIOMMU (a.k.a. host IOMMU) */
+    int (*pasid_free)(DualStageIOMMUObject *dsi_obj,
+                      uint32_t pasid);
+};
+
+/*
+ * This is an abstraction of Dual-stage IOMMU.
+ */
+struct DualStageIOMMUObject {
+    DualStageIOMMUOps *ops;
+};
+
+int ds_iommu_pasid_alloc(DualStageIOMMUObject *dsi_obj, uint32_t min,
+                         uint32_t max, uint32_t *pasid);
+int ds_iommu_pasid_free(DualStageIOMMUObject *dsi_obj, uint32_t pasid);
+
+void ds_iommu_object_init(DualStageIOMMUObject *dsi_obj,
+                          DualStageIOMMUOps *ops);
+void ds_iommu_object_destroy(DualStageIOMMUObject *dsi_obj);
+
+#endif
-- 
2.7.4


