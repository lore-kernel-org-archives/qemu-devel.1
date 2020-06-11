Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190D3C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 12:57:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2A7520760
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 12:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2A7520760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjMlt-00022h-5x
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 08:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1jjMd3-0002rB-FH
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 08:48:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:42686)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1jjMcy-0007zN-Ts
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 08:48:21 -0400
IronPort-SDR: HrGRWe3L6a/PSw1IvbmvciUwC8adGrdjf2WWwRjDHWkYafHvU6n878Hr5/JrrfhYA/SjEPN6pn
 q8P7qyffrwjQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2020 05:48:01 -0700
IronPort-SDR: 1CrkBE0Z9ARVwYSdZa+Cqjw2QayRuxKXjomx0h896QrO4T8IK/f7BnnogDcyCaRA+dVOh+ARWK
 u7DSShGx2iNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,499,1583222400"; d="scan'208";a="447911247"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga005.jf.intel.com with ESMTP; 11 Jun 2020 05:48:00 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org,
	alex.williamson@redhat.com,
	peterx@redhat.com
Subject: [RFC v6 11/25] vfio/common: provide PASID alloc/free hooks
Date: Thu, 11 Jun 2020 05:54:10 -0700
Message-Id: <1591880064-30638-12-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591880064-30638-1-git-send-email-yi.l.liu@intel.com>
References: <1591880064-30638-1-git-send-email-yi.l.liu@intel.com>
Received-SPF: pass client-ip=192.55.52.43; envelope-from=yi.l.liu@intel.com;
 helo=mga05.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 08:48:00
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

This patch defines vfio_host_iommu_context_info, implements the PASID
alloc/free hooks defined in HostIOMMUContextClass.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 hw/vfio/common.c                      | 66 +++++++++++++++++++++++++++++++++++
 include/hw/iommu/host_iommu_context.h |  3 ++
 include/hw/vfio/vfio-common.h         |  4 +++
 3 files changed, 73 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index b85fbcf..f650ad1 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1184,6 +1184,50 @@ static int vfio_get_iommu_type(VFIOContainer *container,
     return ret;
 }
 
+static int vfio_host_iommu_ctx_pasid_alloc(HostIOMMUContext *iommu_ctx,
+                                           uint32_t min, uint32_t max,
+                                           uint32_t *pasid)
+{
+    VFIOContainer *container = container_of(iommu_ctx,
+                                            VFIOContainer, iommu_ctx);
+    struct vfio_iommu_type1_pasid_request req;
+    int ret = 0;
+
+    req.argsz = sizeof(req);
+    req.flags = VFIO_IOMMU_ALLOC_PASID;
+    req.range.min = min;
+    req.range.max = max;
+
+    ret = ioctl(container->fd, VFIO_IOMMU_PASID_REQUEST, &req);
+    if (ret < 0) {
+        error_report("%s: alloc failed (%m)", __func__);
+        return ret;
+    }
+    *pasid = ret;
+    return 0;
+}
+
+static int vfio_host_iommu_ctx_pasid_free(HostIOMMUContext *iommu_ctx,
+                                          uint32_t pasid)
+{
+    VFIOContainer *container = container_of(iommu_ctx,
+                                            VFIOContainer, iommu_ctx);
+    struct vfio_iommu_type1_pasid_request req;
+
+    int ret = 0;
+
+    req.argsz = sizeof(req);
+    req.flags = VFIO_IOMMU_FREE_PASID;
+    req.range.min = pasid;
+    req.range.max = pasid + 1;
+
+    ret = ioctl(container->fd, VFIO_IOMMU_PASID_REQUEST, &req);
+    if (ret) {
+        error_report("%s: free failed (%m)", __func__);
+    }
+    return ret;
+}
+
 static int vfio_init_container(VFIOContainer *container, int group_fd,
                                bool want_nested, Error **errp)
 {
@@ -1797,3 +1841,25 @@ int vfio_eeh_as_op(AddressSpace *as, uint32_t op)
     }
     return vfio_eeh_container_op(container, op);
 }
+
+static void vfio_host_iommu_context_class_init(ObjectClass *klass,
+                                                       void *data)
+{
+    HostIOMMUContextClass *hicxc = HOST_IOMMU_CONTEXT_CLASS(klass);
+
+    hicxc->pasid_alloc = vfio_host_iommu_ctx_pasid_alloc;
+    hicxc->pasid_free = vfio_host_iommu_ctx_pasid_free;
+}
+
+static const TypeInfo vfio_host_iommu_context_info = {
+    .parent = TYPE_HOST_IOMMU_CONTEXT,
+    .name = TYPE_VFIO_HOST_IOMMU_CONTEXT,
+    .class_init = vfio_host_iommu_context_class_init,
+};
+
+static void vfio_register_types(void)
+{
+    type_register_static(&vfio_host_iommu_context_info);
+}
+
+type_init(vfio_register_types)
diff --git a/include/hw/iommu/host_iommu_context.h b/include/hw/iommu/host_iommu_context.h
index 35c4861..227c433 100644
--- a/include/hw/iommu/host_iommu_context.h
+++ b/include/hw/iommu/host_iommu_context.h
@@ -33,6 +33,9 @@
 #define TYPE_HOST_IOMMU_CONTEXT "qemu:host-iommu-context"
 #define HOST_IOMMU_CONTEXT(obj) \
         OBJECT_CHECK(HostIOMMUContext, (obj), TYPE_HOST_IOMMU_CONTEXT)
+#define HOST_IOMMU_CONTEXT_CLASS(klass) \
+        OBJECT_CLASS_CHECK(HostIOMMUContextClass, (klass), \
+                         TYPE_HOST_IOMMU_CONTEXT)
 #define HOST_IOMMU_CONTEXT_GET_CLASS(obj) \
         OBJECT_GET_CLASS(HostIOMMUContextClass, (obj), \
                          TYPE_HOST_IOMMU_CONTEXT)
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index a77d0ed..f8694d6 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -26,12 +26,15 @@
 #include "qemu/notify.h"
 #include "ui/console.h"
 #include "hw/display/ramfb.h"
+#include "hw/iommu/host_iommu_context.h"
 #ifdef CONFIG_LINUX
 #include <linux/vfio.h>
 #endif
 
 #define VFIO_MSG_PREFIX "vfio %s: "
 
+#define TYPE_VFIO_HOST_IOMMU_CONTEXT "qemu:vfio-host-iommu-context"
+
 enum {
     VFIO_DEVICE_TYPE_PCI = 0,
     VFIO_DEVICE_TYPE_PLATFORM = 1,
@@ -71,6 +74,7 @@ typedef struct VFIOContainer {
     MemoryListener listener;
     MemoryListener prereg_listener;
     unsigned iommu_type;
+    HostIOMMUContext iommu_ctx;
     Error *error;
     bool initialized;
     unsigned long pgsizes;
-- 
2.7.4


