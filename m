Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0740CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:24:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8939C2084C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8939C2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNd6W-0006xw-Ch
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 09:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51703)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1iNckg-0005mD-AH
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:02:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1iNckd-0002k8-4R
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:02:06 -0400
Received: from mga11.intel.com ([192.55.52.93]:40529)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1iNckc-0002c5-QZ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:02:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Oct 2019 06:01:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,224,1569308400"; d="scan'208";a="210156294"
Received: from iov.bj.intel.com ([10.238.145.67])
 by fmsmga001.fm.intel.com with ESMTP; 24 Oct 2019 06:01:49 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com,
 alex.williamson@redhat.com, peterx@redhat.com
Subject: [RFC v2 14/22] vfio/pci: add iommu_context notifier for pasid
 bind/unbind
Date: Thu, 24 Oct 2019 08:34:35 -0400
Message-Id: <1571920483-3382-15-git-send-email-yi.l.liu@intel.com>
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

This patch adds notifier for pasid bind/unbind. VFIO registers this
notifier to listen to the dual-stage translation (a.k.a. nested
translation) configuration changes and propagate to host. Thus vIOMMU
is able to set its translation structures to host.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 hw/vfio/pci.c            | 39 +++++++++++++++++++++++++++++++++++++++
 include/hw/iommu/iommu.h | 11 +++++++++++
 2 files changed, 50 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 8721ff6..012b8ed 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2767,6 +2767,41 @@ static void vfio_iommu_pasid_free_notify(IOMMUCTXNotifier *n,
     pasid_req->free_result = ret;
 }
 
+static void vfio_iommu_pasid_bind_notify(IOMMUCTXNotifier *n,
+                                         IOMMUCTXEventData *event_data)
+{
+#ifdef __linux__
+    VFIOIOMMUContext *giommu_ctx = container_of(n, VFIOIOMMUContext, n);
+    VFIOContainer *container = giommu_ctx->container;
+    IOMMUCTXPASIDBindData *pasid_bind =
+                              (IOMMUCTXPASIDBindData *) event_data->data;
+    struct vfio_iommu_type1_bind *bind;
+    struct iommu_gpasid_bind_data *bind_data;
+    unsigned long argsz;
+
+    argsz = sizeof(*bind) + sizeof(*bind_data);
+    bind = g_malloc0(argsz);
+    bind->argsz = argsz;
+    bind->bind_type = VFIO_IOMMU_BIND_GUEST_PASID;
+    bind_data = (struct iommu_gpasid_bind_data *) &bind->data;
+    *bind_data = *pasid_bind->data;
+
+    if (pasid_bind->flag & IOMMU_CTX_BIND_PASID) {
+        if (ioctl(container->fd, VFIO_IOMMU_BIND, bind) != 0) {
+            error_report("%s: pasid (%llu:%llu) bind failed: %d", __func__,
+                         bind_data->gpasid, bind_data->hpasid, -errno);
+        }
+    } else if (pasid_bind->flag & IOMMU_CTX_UNBIND_PASID) {
+        if (ioctl(container->fd, VFIO_IOMMU_UNBIND, bind) != 0) {
+            error_report("%s: pasid (%llu:%llu) unbind failed: %d", __func__,
+                         bind_data->gpasid, bind_data->hpasid, -errno);
+        }
+    }
+
+    g_free(bind);
+#endif
+}
+
 static void vfio_realize(PCIDevice *pdev, Error **errp)
 {
     VFIOPCIDevice *vdev = PCI_VFIO(pdev);
@@ -3079,6 +3114,10 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
                                          iommu_context,
                                          vfio_iommu_pasid_free_notify,
                                          IOMMU_CTX_EVENT_PASID_FREE);
+        vfio_register_iommu_ctx_notifier(vdev,
+                                         iommu_context,
+                                         vfio_iommu_pasid_bind_notify,
+                                         IOMMU_CTX_EVENT_PASID_BIND);
     }
 
     return;
diff --git a/include/hw/iommu/iommu.h b/include/hw/iommu/iommu.h
index 4352afd..4f21aa1 100644
--- a/include/hw/iommu/iommu.h
+++ b/include/hw/iommu/iommu.h
@@ -33,6 +33,7 @@ typedef struct IOMMUContext IOMMUContext;
 enum IOMMUCTXEvent {
     IOMMU_CTX_EVENT_PASID_ALLOC,
     IOMMU_CTX_EVENT_PASID_FREE,
+    IOMMU_CTX_EVENT_PASID_BIND,
     IOMMU_CTX_EVENT_NUM,
 };
 typedef enum IOMMUCTXEvent IOMMUCTXEvent;
@@ -50,6 +51,16 @@ union IOMMUCTXPASIDReqDesc {
 };
 typedef union IOMMUCTXPASIDReqDesc IOMMUCTXPASIDReqDesc;
 
+struct IOMMUCTXPASIDBindData {
+#define IOMMU_CTX_BIND_PASID   (1 << 0)
+#define IOMMU_CTX_UNBIND_PASID (1 << 1)
+    uint32_t flag;
+#ifdef __linux__
+    struct iommu_gpasid_bind_data *data;
+#endif
+};
+typedef struct IOMMUCTXPASIDBindData IOMMUCTXPASIDBindData;
+
 struct IOMMUCTXEventData {
     IOMMUCTXEvent event;
     uint64_t length;
-- 
2.7.4


