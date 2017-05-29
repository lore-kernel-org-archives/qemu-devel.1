Received: from eggs.gnu.org ([2001:4830:134:3::10]:59362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dF8OX-0000A6-JL
	for qemu-devel@nongnu.org; Sun, 28 May 2017 20:18:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dF8OW-0006EX-O8
	for qemu-devel@nongnu.org; Sun, 28 May 2017 20:18:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dF8OW-0006EJ-FP
	for qemu-devel@nongnu.org; Sun, 28 May 2017 20:18:48 -0400
Date: Mon, 29 May 2017 03:18:46 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1496017081-24032-8-git-send-email-mst@redhat.com>
References: <1496017081-24032-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496017081-24032-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 07/13] intel_iommu: allow dev-iotlb context
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Peter Xu <peterx@redhat.com>

When device-iotlb is not specified, we should fail this check. A new
function vtd_ce_type_check() is introduced.

While I'm at it, clean up the vtd_dev_to_context_entry() a bit - replace
many "else if" usage into direct if check. That'll make the logic more
clear.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Jason Wang <jasowang@redhat.com>
---
 hw/i386/intel_iommu.c | 49 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 3240e5d..aac2cc7 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -600,6 +600,26 @@ static inline uint32_t vtd_ce_get_type(VTDContextEntry *ce)
     return ce->lo & VTD_CONTEXT_ENTRY_TT;
 }
 
+/* Return true if check passed, otherwise false */
+static inline bool vtd_ce_type_check(X86IOMMUState *x86_iommu,
+                                     VTDContextEntry *ce)
+{
+    switch (vtd_ce_get_type(ce)) {
+    case VTD_CONTEXT_TT_MULTI_LEVEL:
+        /* Always supported */
+        break;
+    case VTD_CONTEXT_TT_DEV_IOTLB:
+        if (!x86_iommu->dt_supported) {
+            return false;
+        }
+        break;
+    default:
+        /* Unknwon type */
+        return false;
+    }
+    return true;
+}
+
 static inline uint64_t vtd_iova_limit(VTDContextEntry *ce)
 {
     uint32_t ce_agaw = vtd_ce_get_agaw(ce);
@@ -836,6 +856,7 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
 {
     VTDRootEntry re;
     int ret_fr;
+    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
 
     ret_fr = vtd_get_root_entry(s, bus_num, &re);
     if (ret_fr) {
@@ -846,7 +867,9 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
         /* Not error - it's okay we don't have root entry. */
         trace_vtd_re_not_present(bus_num);
         return -VTD_FR_ROOT_ENTRY_P;
-    } else if (re.rsvd || (re.val & VTD_ROOT_ENTRY_RSVD)) {
+    }
+
+    if (re.rsvd || (re.val & VTD_ROOT_ENTRY_RSVD)) {
         trace_vtd_re_invalid(re.rsvd, re.val);
         return -VTD_FR_ROOT_ENTRY_RSVD;
     }
@@ -860,26 +883,26 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
         /* Not error - it's okay we don't have context entry. */
         trace_vtd_ce_not_present(bus_num, devfn);
         return -VTD_FR_CONTEXT_ENTRY_P;
-    } else if ((ce->hi & VTD_CONTEXT_ENTRY_RSVD_HI) ||
-               (ce->lo & VTD_CONTEXT_ENTRY_RSVD_LO)) {
+    }
+
+    if ((ce->hi & VTD_CONTEXT_ENTRY_RSVD_HI) ||
+        (ce->lo & VTD_CONTEXT_ENTRY_RSVD_LO)) {
         trace_vtd_ce_invalid(ce->hi, ce->lo);
         return -VTD_FR_CONTEXT_ENTRY_RSVD;
     }
+
     /* Check if the programming of context-entry is valid */
     if (!vtd_is_level_supported(s, vtd_ce_get_level(ce))) {
         trace_vtd_ce_invalid(ce->hi, ce->lo);
         return -VTD_FR_CONTEXT_ENTRY_INV;
-    } else {
-        switch (vtd_ce_get_type(ce)) {
-        case VTD_CONTEXT_TT_MULTI_LEVEL:
-            /* fall through */
-        case VTD_CONTEXT_TT_DEV_IOTLB:
-            break;
-        default:
-            trace_vtd_ce_invalid(ce->hi, ce->lo);
-            return -VTD_FR_CONTEXT_ENTRY_INV;
-        }
     }
+
+    /* Do translation type check */
+    if (!vtd_ce_type_check(x86_iommu, ce)) {
+        trace_vtd_ce_invalid(ce->hi, ce->lo);
+        return -VTD_FR_CONTEXT_ENTRY_INV;
+    }
+
     return 0;
 }
 
-- 
MST
