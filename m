Received: from eggs.gnu.org ([209.51.188.92]:41204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44u-0001ft-HA
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44t-0003eS-Jl
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB44t-0003YA-6G
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:47 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L1pma062074
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:02:36 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rksw4s219-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:02:35 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:34 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:28 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-55-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 54/97] intel_iommu: introduce vtd_reset_caches()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Xu <peterx@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

From: Peter Xu <peterx@redhat.com>

Provide the function and use it in vtd_init().  Used to reset both
context entry cache and iotlb cache for the whole IOMMU unit.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 06aba4ca52fd2c8718b8ba486f22f0aa7c99ed55)
*functional dep. for 2cc9ddcceb
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/i386/intel_iommu.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 0a8cd4e9cc..f66e93ed2c 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -227,6 +227,14 @@ static void vtd_reset_iotlb(IntelIOMMUState *s)
     vtd_iommu_unlock(s);
 }
 
+static void vtd_reset_caches(IntelIOMMUState *s)
+{
+    vtd_iommu_lock(s);
+    vtd_reset_iotlb_locked(s);
+    vtd_reset_context_cache_locked(s);
+    vtd_iommu_unlock(s);
+}
+
 static uint64_t vtd_get_iotlb_key(uint64_t gfn, uint16_t source_id,
                                   uint32_t level)
 {
@@ -3123,10 +3131,7 @@ static void vtd_init(IntelIOMMUState *s)
         s->cap |= VTD_CAP_CM;
     }
 
-    vtd_iommu_lock(s);
-    vtd_reset_context_cache_locked(s);
-    vtd_reset_iotlb_locked(s);
-    vtd_iommu_unlock(s);
+    vtd_reset_caches(s);
 
     /* Define registers with default values and bit semantics */
     vtd_define_long(s, DMAR_VER_REG, 0x10UL, 0, 0);
-- 
2.17.1
