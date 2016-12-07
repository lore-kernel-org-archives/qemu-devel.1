Received: from eggs.gnu.org ([2001:4830:134:3::10]:41239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cEVEQ-0007AF-Gj
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 00:57:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cEVEO-0001sD-L3
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 00:57:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cEVEO-0001s1-F1
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 00:57:28 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 83929619FA
	for <qemu-devel@nongnu.org>; Wed,  7 Dec 2016 05:57:27 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  7 Dec 2016 13:52:45 +0800
Message-Id: <1481089965-3888-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1481089965-3888-1-git-send-email-peterx@redhat.com>
References: <1481089965-3888-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 2/2] intel_iommu: extend supported
 guest aw to 48 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, famz@redhat.com, peterx@redhat.com, mst@redhat.com

Previously vt-d codes only supports 39 bits iova address width. It won't
be hard to extend it to 48 bits.

After enabling this, we should be able to map larger iova addresses.

To check whether 48 bits aw is enabled, we can grep in the guest dmesg
with line: "dmar: Host address width 48" (previously it was 39).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu_internal.h | 5 +++--
 include/hw/i386/intel_iommu.h  | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index e808c67..00e1e16 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -195,7 +195,7 @@
 #define VTD_DOMAIN_ID_SHIFT         16  /* 16-bit domain id for 64K domains */
 #define VTD_DOMAIN_ID_MASK          ((1UL << VTD_DOMAIN_ID_SHIFT) - 1)
 #define VTD_CAP_ND                  (((VTD_DOMAIN_ID_SHIFT - 4) / 2) & 7ULL)
-#define VTD_MGAW                    39  /* Maximum Guest Address Width */
+#define VTD_MGAW                    48  /* Maximum Guest Address Width */
 #define VTD_CAP_MGAW                (((VTD_MGAW - 1) & 0x3fULL) << 16)
 #define VTD_MAMV                    18ULL
 #define VTD_CAP_MAMV                (VTD_MAMV << 48)
@@ -209,7 +209,8 @@
 #define VTD_CAP_SAGAW_39bit         (0x2ULL << VTD_CAP_SAGAW_SHIFT)
  /* 48-bit AGAW, 4-level page-table */
 #define VTD_CAP_SAGAW_48bit         (0x4ULL << VTD_CAP_SAGAW_SHIFT)
-#define VTD_CAP_SAGAW               VTD_CAP_SAGAW_39bit
+#define VTD_CAP_SAGAW               (VTD_CAP_SAGAW_39bit | \
+                                     VTD_CAP_SAGAW_48bit)
 
 /* IQT_REG */
 #define VTD_IQT_QT(val)             (((val) >> 4) & 0x7fffULL)
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 405c9d1..8e0fe65 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -44,7 +44,7 @@
 #define VTD_SID_TO_DEVFN(sid)       ((sid) & 0xff)
 
 #define DMAR_REG_SIZE               0x230
-#define VTD_HOST_ADDRESS_WIDTH      39
+#define VTD_HOST_ADDRESS_WIDTH      48
 #define VTD_HAW_MASK                ((1ULL << VTD_HOST_ADDRESS_WIDTH) - 1)
 
 #define DMAR_REPORT_F_INTR          (1)
-- 
2.7.4
