Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9AAC4332B
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 12:39:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17DF0206F8
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 12:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17DF0206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFztL-0006qK-8j
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 08:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jFzko-0000yq-Oy
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 08:31:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jFzkm-0003uI-QV
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 08:30:58 -0400
Received: from mga11.intel.com ([192.55.52.93]:51492)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1jFzkm-0003ry-HO
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 08:30:56 -0400
IronPort-SDR: yy7Vvlx/ijGKn8pfeoaTjtnI3dIu6MRbKiBIfZ1WV7OENlhXWfCQZ8Np753KsuGq8ux3eazZ72
 KaXEHxHUejww==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2020 05:30:38 -0700
IronPort-SDR: V/nzAlH9YqHMTcQkZyxThK6ne48aqyQs4WOfCN84p6KT3j4E3B4rCPLfCfapymZhPVUusNrfsx
 8gAn6nhB0UOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,292,1580803200"; d="scan'208";a="239664377"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga008.jf.intel.com with ESMTP; 22 Mar 2020 05:30:38 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org,
	alex.williamson@redhat.com,
	peterx@redhat.com
Subject: [PATCH v1 09/22] vfio/common: check PASID alloc/free availability
Date: Sun, 22 Mar 2020 05:36:06 -0700
Message-Id: <1584880579-12178-10-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
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
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, yi.l.liu@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>, kvm@vger.kernel.org, mst@redhat.com,
 jun.j.tian@intel.com, eric.auger@redhat.com, yi.y.sun@intel.com,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, pbonzini@redhat.com,
 hao.wu@intel.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VFIO exposes host IOMMU dual-stage DMA translation programming capability
to userspace by VFIO_TYPE1_NESTING_IOMMU type. However, userspace needs
more info on the nesting type. e.g. the supported stage 1 format and PASID
alloc/free request availability.

This patch gets the iommu nesting cap info from kernel by using IOCTL
VFIO_IOMMU_GET_INFO. And checks the HOST_IOMMU_PASID_REQUEST bit in the
nesting capabilities.

This patch referred some code from Shameer Kolothum.
https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg03759.html

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 hw/vfio/common.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 91 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index e4f5f10..e0f2828 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1223,6 +1223,84 @@ static int vfio_host_icx_pasid_free(HostIOMMUContext *host_icx,
     return 0;
 }
 
+/**
+ * Get iommu info from host. Caller of this funcion should free
+ * the memory pointed by the returned pointer stored in @info
+ * after a successful calling when finished its usage.
+ */
+static int vfio_get_iommu_info(VFIOContainer *container,
+                         struct vfio_iommu_type1_info **info)
+{
+
+    size_t argsz = sizeof(struct vfio_iommu_type1_info);
+
+    *info = g_malloc0(argsz);
+
+retry:
+    (*info)->argsz = argsz;
+
+    if (ioctl(container->fd, VFIO_IOMMU_GET_INFO, *info)) {
+        g_free(*info);
+        *info = NULL;
+        return -errno;
+    }
+
+    if (((*info)->argsz > argsz)) {
+        argsz = (*info)->argsz;
+        *info = g_realloc(*info, argsz);
+        goto retry;
+    }
+
+    return 0;
+}
+
+static struct vfio_info_cap_header *
+vfio_get_iommu_info_cap(struct vfio_iommu_type1_info *info, uint16_t id)
+{
+    struct vfio_info_cap_header *hdr;
+    void *ptr = info;
+
+    if (!(info->flags & VFIO_IOMMU_INFO_CAPS)) {
+        return NULL;
+    }
+
+    for (hdr = ptr + info->cap_offset; hdr != ptr; hdr = ptr + hdr->next) {
+        if (hdr->id == id) {
+            return hdr;
+        }
+    }
+
+    return NULL;
+}
+
+static int vfio_get_nesting_iommu_cap(VFIOContainer *container,
+                   struct vfio_iommu_type1_info_cap_nesting *cap_nesting)
+{
+    struct vfio_iommu_type1_info *info;
+    struct vfio_info_cap_header *hdr;
+    struct vfio_iommu_type1_info_cap_nesting *cap;
+    int ret;
+
+    ret = vfio_get_iommu_info(container, &info);
+    if (ret) {
+        return ret;
+    }
+
+    hdr = vfio_get_iommu_info_cap(info,
+                        VFIO_IOMMU_TYPE1_INFO_CAP_NESTING);
+    if (!hdr) {
+        g_free(info);
+        return -errno;
+    }
+
+    cap = container_of(hdr,
+                struct vfio_iommu_type1_info_cap_nesting, header);
+    *cap_nesting = *cap;
+
+    g_free(info);
+    return 0;
+}
+
 static int vfio_init_container(VFIOContainer *container, int group_fd,
                                Error **errp)
 {
@@ -1256,11 +1334,19 @@ static int vfio_init_container(VFIOContainer *container, int group_fd,
     }
 
     if (iommu_type == VFIO_TYPE1_NESTING_IOMMU) {
-        /*
-         * TODO: config flags per host IOMMU nesting capability
-         * e.g. check if VFIO_TYPE1_NESTING_IOMMU supports PASID
-         * alloc/free
-         */
+        struct vfio_iommu_type1_info_cap_nesting nesting = {
+                                         .nesting_capabilities = 0x0,
+                                         .stage1_formats = 0, };
+
+        ret = vfio_get_nesting_iommu_cap(container, &nesting);
+        if (ret) {
+            error_setg_errno(errp, -ret,
+                             "Failed to get nesting iommu cap");
+            return ret;
+        }
+
+        flags |= (nesting.nesting_capabilities & VFIO_IOMMU_PASID_REQS) ?
+                 HOST_IOMMU_PASID_REQUEST : 0;
         host_iommu_ctx_init(&container->host_icx,
                             sizeof(container->host_icx),
                             TYPE_VFIO_HOST_IOMMU_CONTEXT,
-- 
2.7.4


