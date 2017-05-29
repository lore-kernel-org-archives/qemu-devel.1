Received: from eggs.gnu.org ([2001:4830:134:3::10]:59338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dF8OV-00009s-AE
	for qemu-devel@nongnu.org; Sun, 28 May 2017 20:18:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dF8OU-0006DC-A9
	for qemu-devel@nongnu.org; Sun, 28 May 2017 20:18:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dF8OU-0006C9-4K
	for qemu-devel@nongnu.org; Sun, 28 May 2017 20:18:46 -0400
Date: Mon, 29 May 2017 03:18:42 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1496017081-24032-6-git-send-email-mst@redhat.com>
References: <1496017081-24032-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496017081-24032-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 05/13] intel_iommu: provide vtd_ce_get_type()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Peter Xu <peterx@redhat.com>

Helper to fetch VT-d context entry type.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Jason Wang <jasowang@redhat.com>
---
 hw/i386/intel_iommu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index f06055f..b477143 100644
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
MST
