Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4599FC33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 12:16:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EDCD20716
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 12:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EDCD20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwmGr-0007su-9I
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 07:16:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1iwmCI-0007d2-GL
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:11:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1iwmCG-0001Zp-P7
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:11:54 -0500
Received: from mga09.intel.com ([134.134.136.24]:58712)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1iwmCG-0001Pn-FB
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:11:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Jan 2020 04:11:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,377,1574150400"; d="scan'208";a="314070935"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by fmsmga001.fm.intel.com with ESMTP; 29 Jan 2020 04:11:46 -0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, pbonzini@redhat.com,
 alex.williamson@redhat.com, peterx@redhat.com
Subject: [RFC v3 08/25] vfio: pass IOMMUContext into vfio_get_group()
Date: Wed, 29 Jan 2020 04:16:39 -0800
Message-Id: <1580300216-86172-9-git-send-email-yi.l.liu@intel.com>
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

IOMMUContext provides an explicit way for VFIO to talk with vIOMMU.

This patch passes IOMMUContext instance into vfio_get_group() for
the reason of potential VFIO_TYPE1_NESTING_IOMMU configuration as
such configuration requires interaction with vIOMMU.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 hw/vfio/ap.c                  | 2 +-
 hw/vfio/ccw.c                 | 2 +-
 hw/vfio/common.c              | 3 ++-
 hw/vfio/pci.c                 | 3 ++-
 hw/vfio/platform.c            | 2 +-
 include/hw/vfio/vfio-common.h | 4 +++-
 6 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 8fbaa72..7b03c12 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -82,7 +82,7 @@ static VFIOGroup *vfio_ap_get_group(VFIOAPDevice *vapdev, Error **errp)
 
     g_free(group_path);
 
-    return vfio_get_group(groupid, &address_space_memory, errp);
+    return vfio_get_group(groupid, &address_space_memory, NULL, errp);
 }
 
 static void vfio_ap_realize(DeviceState *dev, Error **errp)
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 3b5520a..0764af5 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -471,7 +471,7 @@ static VFIOGroup *vfio_ccw_get_group(S390CCWDevice *cdev, Error **errp)
         return NULL;
     }
 
-    return vfio_get_group(groupid, &address_space_memory, errp);
+    return vfio_get_group(groupid, &address_space_memory, NULL, errp);
 }
 
 static void vfio_ccw_realize(DeviceState *dev, Error **errp)
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 5ca1148..0cc7ff5 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1453,7 +1453,8 @@ static void vfio_disconnect_container(VFIOGroup *group)
     }
 }
 
-VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
+VFIOGroup *vfio_get_group(int groupid, AddressSpace *as,
+                          IOMMUContext *iommu_ctx, Error **errp)
 {
     VFIOGroup *group;
     char path[32];
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 2d40b39..77b941f 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2782,7 +2782,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
 
     trace_vfio_realize(vdev->vbasedev.name, groupid);
 
-    group = vfio_get_group(groupid, pci_device_iommu_address_space(pdev), errp);
+    group = vfio_get_group(groupid, pci_device_iommu_address_space(pdev),
+                           pci_device_iommu_context(pdev), errp);
     if (!group) {
         goto error;
     }
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index d7598c6..2029a1c 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -581,7 +581,7 @@ static int vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
 
     trace_vfio_platform_base_device_init(vbasedev->name, groupid);
 
-    group = vfio_get_group(groupid, &address_space_memory, errp);
+    group = vfio_get_group(groupid, &address_space_memory, NULL, errp);
     if (!group) {
         return -ENOENT;
     }
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index fd56420..8ab68fa 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -26,6 +26,7 @@
 #include "qemu/notify.h"
 #include "ui/console.h"
 #include "hw/display/ramfb.h"
+#include "hw/iommu/iommu_context.h"
 #ifdef CONFIG_LINUX
 #include <linux/vfio.h>
 #endif
@@ -174,7 +175,8 @@ void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled);
 void vfio_region_exit(VFIORegion *region);
 void vfio_region_finalize(VFIORegion *region);
 void vfio_reset_handler(void *opaque);
-VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp);
+VFIOGroup *vfio_get_group(int groupid, AddressSpace *as,
+                          IOMMUContext *iommu_ctx, Error **errp);
 void vfio_put_group(VFIOGroup *group);
 int vfio_get_device(VFIOGroup *group, const char *name,
                     VFIODevice *vbasedev, Error **errp);
-- 
2.7.4


