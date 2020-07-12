Return-Path: <SRS0=QItv=AX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F70C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 11:23:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE7972070B
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 11:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE7972070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jua4n-0007yI-1M
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 07:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1jua1R-0002qT-Mk
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 07:19:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:51218)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1jua1P-0004uN-SO
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 07:19:53 -0400
IronPort-SDR: CVyxGm8asPNDDI6c+g+BDJ+C9QY563CNanNoavPL93DlaU9wQnJj+JJRovEO1kr4byvKz2Ali7
 K+eur+Ty78iA==
X-IronPort-AV: E=McAfee;i="6000,8403,9679"; a="148490158"
X-IronPort-AV: E=Sophos;i="5.75,343,1589266800"; d="scan'208";a="148490158"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2020 04:19:44 -0700
IronPort-SDR: 91xmKFkmaW2NlJanUxoTV3LEqCeaVHDSynJVfAhjKV82CEwsXqOWYOs8h18vv8H5e82MBCSbzP
 Y5z4g/QYRKGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,343,1589266800"; d="scan'208";a="307121393"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by fmsmga004.fm.intel.com with ESMTP; 12 Jul 2020 04:19:43 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org,
	alex.williamson@redhat.com,
	peterx@redhat.com
Subject: [RFC v8 06/25] vfio: pass nesting requirement into vfio_get_group()
Date: Sun, 12 Jul 2020 04:26:02 -0700
Message-Id: <1594553181-55810-7-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594553181-55810-1-git-send-email-yi.l.liu@intel.com>
References: <1594553181-55810-1-git-send-email-yi.l.liu@intel.com>
Received-SPF: pass client-ip=134.134.136.65; envelope-from=yi.l.liu@intel.com;
 helo=mga03.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/12 07:19:41
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
 hao.wu@intel.com, jasowang@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch passes the nesting requirement into vfio_get_group() to
indicate whether VFIO_TYPE1_NESTING_IOMMU is required.

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
 hw/vfio/pci.c                 | 9 ++++++++-
 hw/vfio/platform.c            | 2 +-
 include/hw/vfio/vfio-common.h | 3 ++-
 6 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 95564c1..933b118 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -82,7 +82,7 @@ static VFIOGroup *vfio_ap_get_group(VFIOAPDevice *vapdev, Error **errp)
 
     g_free(group_path);
 
-    return vfio_get_group(groupid, &address_space_memory, errp);
+    return vfio_get_group(groupid, &address_space_memory, false, errp);
 }
 
 static void vfio_ap_realize(DeviceState *dev, Error **errp)
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 06e69d7..7c20103 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -620,7 +620,7 @@ static VFIOGroup *vfio_ccw_get_group(S390CCWDevice *cdev, Error **errp)
         return NULL;
     }
 
-    return vfio_get_group(groupid, &address_space_memory, errp);
+    return vfio_get_group(groupid, &address_space_memory, false, errp);
 }
 
 static void vfio_ccw_realize(DeviceState *dev, Error **errp)
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 0b3593b..89c6a25 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1453,7 +1453,8 @@ static void vfio_disconnect_container(VFIOGroup *group)
     }
 }
 
-VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
+VFIOGroup *vfio_get_group(int groupid, AddressSpace *as,
+                          bool want_nested, Error **errp)
 {
     VFIOGroup *group;
     char path[32];
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 6838bcc..9d8d27f 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2717,6 +2717,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     int groupid;
     int i, ret;
     bool is_mdev;
+    bool want_nested;
 
     if (!vdev->vbasedev.sysfsdev) {
         if (!(~vdev->host.domain || ~vdev->host.bus ||
@@ -2775,7 +2776,13 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
 
     trace_vfio_realize(vdev->vbasedev.name, groupid);
 
-    group = vfio_get_group(groupid, pci_device_iommu_address_space(pdev), errp);
+    if (pci_device_get_iommu_attr(pdev,
+                         IOMMU_WANT_NESTING, &want_nested)) {
+        want_nested = false;
+    }
+
+    group = vfio_get_group(groupid, pci_device_iommu_address_space(pdev),
+                           want_nested, errp);
     if (!group) {
         goto error;
     }
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index ac2cefc..7ad7702 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -580,7 +580,7 @@ static int vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
 
     trace_vfio_platform_base_device_init(vbasedev->name, groupid);
 
-    group = vfio_get_group(groupid, &address_space_memory, errp);
+    group = vfio_get_group(groupid, &address_space_memory, false, errp);
     if (!group) {
         return -ENOENT;
     }
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index fd56420..a77d0ed 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -174,7 +174,8 @@ void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled);
 void vfio_region_exit(VFIORegion *region);
 void vfio_region_finalize(VFIORegion *region);
 void vfio_reset_handler(void *opaque);
-VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp);
+VFIOGroup *vfio_get_group(int groupid, AddressSpace *as,
+                          bool want_nested, Error **errp);
 void vfio_put_group(VFIOGroup *group);
 int vfio_get_device(VFIOGroup *group, const char *name,
                     VFIODevice *vbasedev, Error **errp);
-- 
2.7.4


