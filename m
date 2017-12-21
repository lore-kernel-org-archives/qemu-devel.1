Received: from eggs.gnu.org ([2001:4830:134:3::10]:47487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eRuOX-0001Vp-Ko
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 01:31:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eRuOU-0001mN-Hc
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 01:31:53 -0500
Received: from mga11.intel.com ([192.55.52.93]:32422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1eRuOU-0001lx-85
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 01:31:50 -0500
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Thu, 21 Dec 2017 14:15:19 +0800
Message-Id: <1513836919-13458-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [PATCH] intel_iommu: a fix to vtd_dev_get_trans_type()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peterx@redhat.com, jasowang@redhat.com
Cc: yi.l.liu@intel.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>

vtd_ce_get_type() returns uin32_t and vtd_dev_get_trans_type() returns
the value from vtd_ce_get_type(). However, vtd_dev_get_trans_type()
returns int. This patch switchs to return the translation type by
parameter. It avoids unsigned to int transfer and also avoid potential
reading confusion.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 hw/i386/intel_iommu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 3a5bb0b..609f087 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -916,7 +916,7 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
  * happens, otherwise return the shifted type to check against
  * VTD_CONTEXT_TT_*.
  */
-static int vtd_dev_get_trans_type(VTDAddressSpace *as)
+static int vtd_dev_get_trans_type(VTDAddressSpace *as, uint32_t *tt)
 {
     IntelIOMMUState *s;
     VTDContextEntry ce;
@@ -930,16 +930,18 @@ static int vtd_dev_get_trans_type(VTDAddressSpace *as)
         return ret;
     }
 
-    return vtd_ce_get_type(&ce);
+    *tt = vtd_ce_get_type(&ce);
+    return 0;
 }
 
 static bool vtd_dev_pt_enabled(VTDAddressSpace *as)
 {
     int ret;
+    uint32_t tt;
 
     assert(as);
 
-    ret = vtd_dev_get_trans_type(as);
+    ret = vtd_dev_get_trans_type(as, &tt);
     if (ret < 0) {
         /*
          * Possibly failed to parse the context entry for some reason
@@ -950,7 +952,7 @@ static bool vtd_dev_pt_enabled(VTDAddressSpace *as)
         return false;
     }
 
-    return ret == VTD_CONTEXT_TT_PASS_THROUGH;
+    return tt == VTD_CONTEXT_TT_PASS_THROUGH;
 }
 
 /* Return whether the device is using IOMMU translation. */
-- 
1.9.1
