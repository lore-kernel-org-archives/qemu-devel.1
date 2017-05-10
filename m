Received: from eggs.gnu.org ([2001:4830:134:3::10]:57920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d8Mad-0006ZP-Ai
	for qemu-devel@nongnu.org; Wed, 10 May 2017 04:03:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d8Mac-0001R3-Kb
	for qemu-devel@nongnu.org; Wed, 10 May 2017 04:03:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d8Mac-0001QH-Ff
	for qemu-devel@nongnu.org; Wed, 10 May 2017 04:03:18 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed, 10 May 2017 16:01:52 +0800
Message-Id: <1494403315-12760-10-git-send-email-peterx@redhat.com>
In-Reply-To: <1494403315-12760-1-git-send-email-peterx@redhat.com>
References: <1494403315-12760-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 09/12] intel_iommu: allow dev-iotlb context
 entry conditionally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, "Michael S . Tsirkin" <mst@redhat.com>, yi.l.liu@intel.com, Marcel Apfelbaum <marcel@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

When device-iotlb is not specified, we should fail this check.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 05ae631..1a7eba2 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -836,6 +836,8 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
 {
     VTDRootEntry re;
     int ret_fr;
+    bool type_fail = false;
+    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
 
     ret_fr = vtd_get_root_entry(s, bus_num, &re);
     if (ret_fr) {
@@ -872,10 +874,19 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
     } else {
         switch (vtd_ce_get_type(ce)) {
         case VTD_CONTEXT_TT_MULTI_LEVEL:
-            /* fall through */
+            /* Always supported */
+            break;
         case VTD_CONTEXT_TT_DEV_IOTLB:
+            if (!x86_iommu->dt_supported) {
+                type_fail = true;
+            }
             break;
         default:
+            /* Unknwon type */
+            type_fail = true;
+            break;
+        }
+        if (type_fail) {
             trace_vtd_ce_invalid(ce->hi, ce->lo);
             return -VTD_FR_CONTEXT_ENTRY_INV;
         }
-- 
2.7.4
