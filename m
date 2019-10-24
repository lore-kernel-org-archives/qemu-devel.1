Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D8CCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:26:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C31172070B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C31172070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNe4i-0007pG-FL
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1iNckI-0005G2-RM
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1iNckG-0002TN-UA
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:01:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:40494)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1iNckG-0002O1-KY
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:01:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Oct 2019 06:01:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,224,1569308400"; d="scan'208";a="210156239"
Received: from iov.bj.intel.com ([10.238.145.67])
 by fmsmga001.fm.intel.com with ESMTP; 24 Oct 2019 06:01:33 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com,
 alex.williamson@redhat.com, peterx@redhat.com
Subject: [RFC v2 09/22] vfio/pci: add iommu_context notifier for pasid
 alloc/free
Date: Thu, 24 Oct 2019 08:34:30 -0400
Message-Id: <1571920483-3382-10-git-send-email-yi.l.liu@intel.com>
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

This patch adds pasid alloc/free notifiers for vfio-pci. It is
supposed to be fired by vIOMMU. VFIO then sends PASID allocation
or free request to host.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 hw/vfio/common.c         |  9 ++++++
 hw/vfio/pci.c            | 81 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/iommu/iommu.h | 15 +++++++++
 3 files changed, 105 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index d418527..e6ad21c 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1436,6 +1436,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
     if (QLIST_EMPTY(&container->group_list)) {
         VFIOAddressSpace *space = container->space;
         VFIOGuestIOMMU *giommu, *tmp;
+        VFIOIOMMUContext *giommu_ctx, *ctx;
 
         QLIST_REMOVE(container, next);
 
@@ -1446,6 +1447,14 @@ static void vfio_disconnect_container(VFIOGroup *group)
             g_free(giommu);
         }
 
+        QLIST_FOREACH_SAFE(giommu_ctx, &container->iommu_ctx_list,
+                                                   iommu_ctx_next, ctx) {
+            iommu_ctx_notifier_unregister(giommu_ctx->iommu_ctx,
+                                                      &giommu_ctx->n);
+            QLIST_REMOVE(giommu_ctx, iommu_ctx_next);
+            g_free(giommu_ctx);
+        }
+
         trace_vfio_disconnect_container(container->fd);
         close(container->fd);
         g_free(container);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 12fac39..8721ff6 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2699,11 +2699,80 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
     vdev->req_enabled = false;
 }
 
+static void vfio_register_iommu_ctx_notifier(VFIOPCIDevice *vdev,
+                                             IOMMUContext *iommu_ctx,
+                                             IOMMUCTXNotifyFn fn,
+                                             IOMMUCTXEvent event)
+{
+    VFIOContainer *container = vdev->vbasedev.group->container;
+    VFIOIOMMUContext *giommu_ctx;
+
+    giommu_ctx = g_malloc0(sizeof(*giommu_ctx));
+    giommu_ctx->container = container;
+    giommu_ctx->iommu_ctx = iommu_ctx;
+    QLIST_INSERT_HEAD(&container->iommu_ctx_list,
+                      giommu_ctx,
+                      iommu_ctx_next);
+    iommu_ctx_notifier_register(iommu_ctx,
+                                &giommu_ctx->n,
+                                fn,
+                                event);
+}
+
+static void vfio_iommu_pasid_alloc_notify(IOMMUCTXNotifier *n,
+                                          IOMMUCTXEventData *event_data)
+{
+    VFIOIOMMUContext *giommu_ctx = container_of(n, VFIOIOMMUContext, n);
+    VFIOContainer *container = giommu_ctx->container;
+    IOMMUCTXPASIDReqDesc *pasid_req =
+                              (IOMMUCTXPASIDReqDesc *) event_data->data;
+    struct vfio_iommu_type1_pasid_request req;
+    unsigned long argsz;
+    int pasid;
+
+    argsz = sizeof(req);
+    req.argsz = argsz;
+    req.flag = VFIO_IOMMU_PASID_ALLOC;
+    req.min_pasid = pasid_req->min_pasid;
+    req.max_pasid = pasid_req->max_pasid;
+
+    pasid = ioctl(container->fd, VFIO_IOMMU_PASID_REQUEST, &req);
+    if (pasid < 0) {
+        error_report("%s: %d, alloc failed", __func__, -errno);
+    }
+    pasid_req->alloc_result = pasid;
+}
+
+static void vfio_iommu_pasid_free_notify(IOMMUCTXNotifier *n,
+                                          IOMMUCTXEventData *event_data)
+{
+    VFIOIOMMUContext *giommu_ctx = container_of(n, VFIOIOMMUContext, n);
+    VFIOContainer *container = giommu_ctx->container;
+    IOMMUCTXPASIDReqDesc *pasid_req =
+                              (IOMMUCTXPASIDReqDesc *) event_data->data;
+    struct vfio_iommu_type1_pasid_request req;
+    unsigned long argsz;
+    int ret = 0;
+
+    argsz = sizeof(req);
+    req.argsz = argsz;
+    req.flag = VFIO_IOMMU_PASID_FREE;
+    req.pasid = pasid_req->pasid;
+
+    ret = ioctl(container->fd, VFIO_IOMMU_PASID_REQUEST, &req);
+    if (ret != 0) {
+        error_report("%s: %d, pasid %u free failed",
+                   __func__, -errno, (unsigned) pasid_req->pasid);
+    }
+    pasid_req->free_result = ret;
+}
+
 static void vfio_realize(PCIDevice *pdev, Error **errp)
 {
     VFIOPCIDevice *vdev = PCI_VFIO(pdev);
     VFIODevice *vbasedev_iter;
     VFIOGroup *group;
+    IOMMUContext *iommu_context;
     char *tmp, *subsys, group_path[PATH_MAX], *group_name;
     Error *err = NULL;
     ssize_t len;
@@ -3000,6 +3069,18 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     vfio_register_req_notifier(vdev);
     vfio_setup_resetfn_quirk(vdev);
 
+    iommu_context = pci_device_iommu_context(pdev);
+    if (iommu_context) {
+        vfio_register_iommu_ctx_notifier(vdev,
+                                         iommu_context,
+                                         vfio_iommu_pasid_alloc_notify,
+                                         IOMMU_CTX_EVENT_PASID_ALLOC);
+        vfio_register_iommu_ctx_notifier(vdev,
+                                         iommu_context,
+                                         vfio_iommu_pasid_free_notify,
+                                         IOMMU_CTX_EVENT_PASID_FREE);
+    }
+
     return;
 
 out_teardown:
diff --git a/include/hw/iommu/iommu.h b/include/hw/iommu/iommu.h
index c22c442..4352afd 100644
--- a/include/hw/iommu/iommu.h
+++ b/include/hw/iommu/iommu.h
@@ -31,10 +31,25 @@
 typedef struct IOMMUContext IOMMUContext;
 
 enum IOMMUCTXEvent {
+    IOMMU_CTX_EVENT_PASID_ALLOC,
+    IOMMU_CTX_EVENT_PASID_FREE,
     IOMMU_CTX_EVENT_NUM,
 };
 typedef enum IOMMUCTXEvent IOMMUCTXEvent;
 
+union IOMMUCTXPASIDReqDesc {
+    struct {
+        uint32_t min_pasid;
+        uint32_t max_pasid;
+        int32_t alloc_result; /* pasid allocated for the alloc request */
+    };
+    struct {
+        uint32_t pasid; /* pasid to be free */
+        int free_result;
+    };
+};
+typedef union IOMMUCTXPASIDReqDesc IOMMUCTXPASIDReqDesc;
+
 struct IOMMUCTXEventData {
     IOMMUCTXEvent event;
     uint64_t length;
-- 
2.7.4


