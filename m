Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736F7C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:59:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D916F20BED
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:59:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D916F20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGKIt-0002zG-TV
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1kGKEP-0003sZ-Fb
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:55:09 -0400
Received: from mga03.intel.com ([134.134.136.65]:26688)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1kGKEM-0005xR-Nd
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:55:09 -0400
IronPort-SDR: tTKZjrxIHAiPmp1XR/d/RpF2lnKbP3Tr1qoSpsFaAC0CP2Ogxn8AjAaUPSsw3tc8vq1hgz5ptU
 LUq/3+LNzLFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="158545480"
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; d="scan'208";a="158545480"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 03:54:40 -0700
IronPort-SDR: Lg/YocG4uXAse06rpE8j5g/twjMfJ6RN8zCVrBp7jwBJpDQf9pWib0g9Z8XV36dvo/auNERa6y
 esQx33aLZKZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; d="scan'208";a="334140057"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga008.jf.intel.com with ESMTP; 10 Sep 2020 03:54:39 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org, alex.williamson@redhat.com, peterx@redhat.com,
 jasowang@redhat.com
Subject: [RFC v10 08/25] hw/iommu: introduce HostIOMMUContext
Date: Thu, 10 Sep 2020 03:56:21 -0700
Message-Id: <1599735398-6829-9-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599735398-6829-1-git-send-email-yi.l.liu@intel.com>
References: <1599735398-6829-1-git-send-email-yi.l.liu@intel.com>
Received-SPF: pass client-ip=134.134.136.65; envelope-from=yi.l.liu@intel.com;
 helo=mga03.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 06:54:39
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, yi.l.liu@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>, kvm@vger.kernel.org, mst@redhat.com,
 jun.j.tian@intel.com, eric.auger@redhat.com, yi.y.sun@intel.com,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, pbonzini@redhat.com,
 hao.wu@intel.com, david@gibson.dropbear.id.au
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
 - https://events19.lfasiallc.com/wp-content/uploads/2017/11/Shared-Virtual-Memory-in-KVM_Yi-Liu.pdf

In QEMU, vIOMMU emulators expose IOMMUs to VM per their own spec (e.g.
Intel VT-d spec). Devices are pass-through to guest via device pass-
through components like VFIO. VFIO is a userspace driver framework
which exposes host IOMMU programming capability to userspace in a
secure manner. e.g. IOVA MAP/UNMAP requests. Information, different
from map/unmap notifications need to be passed from QEMU vIOMMU device
to/from the host IOMMU driver through the VFIO/IOMMU layer:
 1) PASID allocation (allow host to intercept in PASID allocation)
 2) bind stage-1 translation structures to host
 3) propagate stage-1 cache invalidation to host
 4) DMA address translation fault (I/O page fault) servicing etc.

With the above new interactions in QEMU, it requires an abstract layer
to facilitate the above operations and expose to vIOMMU emulators as an
explicit way for vIOMMU emulators call into VFIO. This patch introduces
HostIOMMUContext to serve it. The HostIOMMUContext is an object which
allows to manage the stage-1 translation when a vIOMMU is implemented
upon physical IOMMU nested paging (VFIO case). It is an abstract object
which needs to be derived for each vIOMMU immplementation based on
physical nested paging. An HostIOMMUContext derived object will be passed
to each VFIO device protected by a vIOMMU using physical nested paging.

This patchg also introduces HostIOMMUContextClass to provide methods for
vIOMMU emulators to propagate dual-stage translation related requests to
host. As a beginning, PASID allocation/free are defined to propagate PASID
allocation/free requests to host which is required for the vendors which
manage PASID in system-wide.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
rfcv9 -> rfcv10:
*) adjust to meson build
---
 hw/Kconfig                            |  3 ++
 hw/iommu/Kconfig                      |  4 ++
 hw/iommu/host_iommu_context.c         | 97 +++++++++++++++++++++++++++++++++++
 hw/iommu/meson.build                  |  6 +++
 hw/meson.build                        |  1 +
 include/hw/iommu/host_iommu_context.h | 75 +++++++++++++++++++++++++++
 6 files changed, 186 insertions(+)
 create mode 100644 hw/iommu/Kconfig
 create mode 100644 hw/iommu/host_iommu_context.c
 create mode 100644 hw/iommu/meson.build
 create mode 100644 include/hw/iommu/host_iommu_context.h

diff --git a/hw/Kconfig b/hw/Kconfig
index 4de1797..ac74bed 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -65,6 +65,9 @@ source tricore/Kconfig
 source unicore32/Kconfig
 source xtensa/Kconfig
 
+# iommu Kconfig
+source iommu/Kconfig
+
 # Symbols used by multiple targets
 config TEST_DEVICES
     bool
diff --git a/hw/iommu/Kconfig b/hw/iommu/Kconfig
new file mode 100644
index 0000000..039b9a4
--- /dev/null
+++ b/hw/iommu/Kconfig
@@ -0,0 +1,4 @@
+config IOMMU
+    bool
+    default y
+    depends on LINUX
diff --git a/hw/iommu/host_iommu_context.c b/hw/iommu/host_iommu_context.c
new file mode 100644
index 0000000..5fb2223
--- /dev/null
+++ b/hw/iommu/host_iommu_context.c
@@ -0,0 +1,97 @@
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
+#include "qapi/error.h"
+#include "qom/object.h"
+#include "qapi/visitor.h"
+#include "hw/iommu/host_iommu_context.h"
+
+int host_iommu_ctx_pasid_alloc(HostIOMMUContext *iommu_ctx, uint32_t min,
+                               uint32_t max, uint32_t *pasid)
+{
+    HostIOMMUContextClass *hicxc;
+
+    if (!iommu_ctx) {
+        return -EINVAL;
+    }
+
+    hicxc = HOST_IOMMU_CONTEXT_GET_CLASS(iommu_ctx);
+
+    if (!hicxc) {
+        return -EINVAL;
+    }
+
+    if (!(iommu_ctx->flags & HOST_IOMMU_PASID_REQUEST) ||
+        !hicxc->pasid_alloc) {
+        return -EINVAL;
+    }
+
+    return hicxc->pasid_alloc(iommu_ctx, min, max, pasid);
+}
+
+int host_iommu_ctx_pasid_free(HostIOMMUContext *iommu_ctx, uint32_t pasid)
+{
+    HostIOMMUContextClass *hicxc;
+
+    if (!iommu_ctx) {
+        return -EINVAL;
+    }
+
+    hicxc = HOST_IOMMU_CONTEXT_GET_CLASS(iommu_ctx);
+    if (!hicxc) {
+        return -EINVAL;
+    }
+
+    if (!(iommu_ctx->flags & HOST_IOMMU_PASID_REQUEST) ||
+        !hicxc->pasid_free) {
+        return -EINVAL;
+    }
+
+    return hicxc->pasid_free(iommu_ctx, pasid);
+}
+
+void host_iommu_ctx_init(void *_iommu_ctx, size_t instance_size,
+                         const char *mrtypename,
+                         uint64_t flags)
+{
+    HostIOMMUContext *iommu_ctx;
+
+    object_initialize(_iommu_ctx, instance_size, mrtypename);
+    iommu_ctx = HOST_IOMMU_CONTEXT(_iommu_ctx);
+    iommu_ctx->flags = flags;
+    iommu_ctx->initialized = true;
+}
+
+static const TypeInfo host_iommu_context_info = {
+    .parent             = TYPE_OBJECT,
+    .name               = TYPE_HOST_IOMMU_CONTEXT,
+    .class_size         = sizeof(HostIOMMUContextClass),
+    .instance_size      = sizeof(HostIOMMUContext),
+    .abstract           = true,
+};
+
+static void host_iommu_ctx_register_types(void)
+{
+    type_register_static(&host_iommu_context_info);
+}
+
+type_init(host_iommu_ctx_register_types)
diff --git a/hw/iommu/meson.build b/hw/iommu/meson.build
new file mode 100644
index 0000000..acf72ac
--- /dev/null
+++ b/hw/iommu/meson.build
@@ -0,0 +1,6 @@
+iommu_ss = ss.source_set()
+iommu_ss.add(files(
+  'host_iommu_context.c',
+))
+
+specific_ss.add_all(when: 'CONFIG_IOMMU', if_true: iommu_ss)
diff --git a/hw/meson.build b/hw/meson.build
index 010de72..5578923 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -65,3 +65,4 @@ subdir('sparc64')
 subdir('tricore')
 subdir('unicore32')
 subdir('xtensa')
+subdir('iommu')
diff --git a/include/hw/iommu/host_iommu_context.h b/include/hw/iommu/host_iommu_context.h
new file mode 100644
index 0000000..35c4861
--- /dev/null
+++ b/include/hw/iommu/host_iommu_context.h
@@ -0,0 +1,75 @@
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
+#include "qemu/thread.h"
+#include "qom/object.h"
+#include <linux/iommu.h>
+#ifndef CONFIG_USER_ONLY
+#include "exec/hwaddr.h"
+#endif
+
+#define TYPE_HOST_IOMMU_CONTEXT "qemu:host-iommu-context"
+#define HOST_IOMMU_CONTEXT(obj) \
+        OBJECT_CHECK(HostIOMMUContext, (obj), TYPE_HOST_IOMMU_CONTEXT)
+#define HOST_IOMMU_CONTEXT_GET_CLASS(obj) \
+        OBJECT_GET_CLASS(HostIOMMUContextClass, (obj), \
+                         TYPE_HOST_IOMMU_CONTEXT)
+
+typedef struct HostIOMMUContext HostIOMMUContext;
+
+typedef struct HostIOMMUContextClass {
+    /* private */
+    ObjectClass parent_class;
+
+    /* Allocate pasid from HostIOMMUContext (a.k.a. host software) */
+    int (*pasid_alloc)(HostIOMMUContext *iommu_ctx,
+                       uint32_t min,
+                       uint32_t max,
+                       uint32_t *pasid);
+    /* Reclaim pasid from HostIOMMUContext (a.k.a. host software) */
+    int (*pasid_free)(HostIOMMUContext *iommu_ctx,
+                      uint32_t pasid);
+} HostIOMMUContextClass;
+
+/*
+ * This is an abstraction of host IOMMU with dual-stage capability
+ */
+struct HostIOMMUContext {
+    Object parent_obj;
+#define HOST_IOMMU_PASID_REQUEST (1ULL << 0)
+    uint64_t flags;
+    bool initialized;
+};
+
+int host_iommu_ctx_pasid_alloc(HostIOMMUContext *iommu_ctx, uint32_t min,
+                               uint32_t max, uint32_t *pasid);
+int host_iommu_ctx_pasid_free(HostIOMMUContext *iommu_ctx, uint32_t pasid);
+
+void host_iommu_ctx_init(void *_iommu_ctx, size_t instance_size,
+                         const char *mrtypename,
+                         uint64_t flags);
+void host_iommu_ctx_destroy(HostIOMMUContext *iommu_ctx);
+
+#endif
-- 
2.7.4


