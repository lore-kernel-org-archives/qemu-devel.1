Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A942C2D0ED
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 04:20:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14584206F6
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 04:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14584206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIlua-0002gE-3i
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 00:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jIltR-0000qZ-Ko
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 00:19:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jIltQ-0007pQ-CS
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 00:19:21 -0400
Received: from mga07.intel.com ([134.134.136.100]:12573)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1jIltQ-0007o2-5J
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 00:19:20 -0400
IronPort-SDR: E9RHadqledxleVOePZn/yyYNP9XXMCkfmTmUP9e7VrObPrLnJuOJzlDwzwTDvsohmcybhypS0W
 EE/L7i3PqEHQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2020 21:19:15 -0700
IronPort-SDR: pvzNqe/wRmrOT/Q4jA66Yw2/UoXbFi0XPuJL5NXYzvOeW9gh/4WqsiHVdhFjHd5hGz//eQPJ2J
 2/A4NAuMWmfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,322,1580803200"; d="scan'208";a="327632016"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga001.jf.intel.com with ESMTP; 29 Mar 2020 21:19:15 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org,
	alex.williamson@redhat.com,
	peterx@redhat.com
Subject: [PATCH v2 03/22] vfio: check VFIO_TYPE1_NESTING_IOMMU support
Date: Sun, 29 Mar 2020 21:24:42 -0700
Message-Id: <1585542301-84087-4-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
References: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.100
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

VFIO needs to check VFIO_TYPE1_NESTING_IOMMU support with Kernel before
further using it. e.g. requires to check IOMMU UAPI version.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
---
 hw/vfio/common.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 0b3593b..c276732 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1157,12 +1157,21 @@ static void vfio_put_address_space(VFIOAddressSpace *space)
 static int vfio_get_iommu_type(VFIOContainer *container,
                                Error **errp)
 {
-    int iommu_types[] = { VFIO_TYPE1v2_IOMMU, VFIO_TYPE1_IOMMU,
+    int iommu_types[] = { VFIO_TYPE1_NESTING_IOMMU,
+                          VFIO_TYPE1v2_IOMMU, VFIO_TYPE1_IOMMU,
                           VFIO_SPAPR_TCE_v2_IOMMU, VFIO_SPAPR_TCE_IOMMU };
-    int i;
+    int i, version;
 
     for (i = 0; i < ARRAY_SIZE(iommu_types); i++) {
         if (ioctl(container->fd, VFIO_CHECK_EXTENSION, iommu_types[i])) {
+            if (iommu_types[i] == VFIO_TYPE1_NESTING_IOMMU) {
+                version = ioctl(container->fd, VFIO_CHECK_EXTENSION,
+                                VFIO_NESTING_IOMMU_UAPI);
+                if (version < IOMMU_UAPI_VERSION) {
+                    info_report("IOMMU UAPI incompatible for nesting");
+                    continue;
+                }
+            }
             return iommu_types[i];
         }
     }
@@ -1278,6 +1287,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     }
 
     switch (container->iommu_type) {
+    case VFIO_TYPE1_NESTING_IOMMU:
     case VFIO_TYPE1v2_IOMMU:
     case VFIO_TYPE1_IOMMU:
     {
-- 
2.7.4


