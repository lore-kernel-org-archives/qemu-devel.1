Received: from eggs.gnu.org ([2001:4830:134:3::10]:50537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d04uG-0001i0-Ev
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 07:33:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d04uF-0003qC-Mk
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 07:33:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d04uF-0003pk-Gd
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 07:33:19 -0400
From: Peter Xu <peterx@redhat.com>
Date: Mon, 17 Apr 2017 19:32:08 +0800
Message-Id: <1492428730-13438-6-git-send-email-peterx@redhat.com>
In-Reply-To: <1492428730-13438-1-git-send-email-peterx@redhat.com>
References: <1492428730-13438-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 5/7] intel_iommu: provide vtd_ce_get_type()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Marcel Apfelbaum <marcel@redhat.com>

Helper to fetch VT-d context entry type.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 4628f04..c8751ba 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -595,6 +595,11 @@ static inline uint32_t vtd_ce_get_agaw(VTDContextEntry *ce)
     return 30 + (ce->hi & VTD_CONTEXT_ENTRY_AW) * 9;
 }
 
+static inline uint32_t vtd_ce_get_type(VTDContextEntry *ce)
+{
+    return ce->lo & VTD_CONTEXT_ENTRY_TT;
+}
+
 static inline uint64_t vtd_iova_limit(VTDContextEntry *ce)
 {
     uint32_t ce_agaw = vtd_ce_get_agaw(ce);
@@ -865,7 +870,7 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
         trace_vtd_ce_invalid(ce->hi, ce->lo);
         return -VTD_FR_CONTEXT_ENTRY_INV;
     } else {
-        switch (ce->lo & VTD_CONTEXT_ENTRY_TT) {
+        switch (vtd_ce_get_type(ce)) {
         case VTD_CONTEXT_TT_MULTI_LEVEL:
             /* fall through */
         case VTD_CONTEXT_TT_DEV_IOTLB:
-- 
2.7.4
