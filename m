Received: from eggs.gnu.org ([2001:4830:134:3::10]:46432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dS7H0-0007M5-S0
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:44:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dS7Gz-0002SE-TW
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:44:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52705)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dS7Gz-0002Qt-KL
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:44:41 -0400
Date: Mon, 3 Jul 2017 22:44:37 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1499111049-13721-4-git-send-email-mst@redhat.com>
References: <1499111049-13721-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1499111049-13721-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 03/21] intel_iommu: relax iq tail check on
 VTD_GCMD_QIE enable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Ladi Prosek <lprosek@redhat.com>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Ladi Prosek <lprosek@redhat.com>

The VT-d spec (section 6.5.2) prescribes software to zero the
Invalidation Queue Tail Register before enabling the VTD_GCMD_QIE
Global Command Register bit. Windows Server 2012 R2 and possibly
other older Windows versions violate the protocol and set a
non-zero queue tail first, which in effect makes them crash early
on boot with -device intel-iommu,intremap=on.

This commit relaxes the check and instead of failing to enable
VTD_GCMD_QIE with vtd_err_qi_enable, it behaves as if the tail
register was set just after enabling VTD_GCMD_QIE
(see vtd_handle_iqt_write).

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 33 +++++++++++++++++++--------------
 hw/i386/trace-events  |  2 +-
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index a9b59bd..2ddf3bd 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1450,10 +1450,7 @@ static uint64_t vtd_iotlb_flush(IntelIOMMUState *s, uint64_t val)
     return iaig;
 }
 
-static inline bool vtd_queued_inv_enable_check(IntelIOMMUState *s)
-{
-    return s->iq_tail == 0;
-}
+static void vtd_fetch_inv_desc(IntelIOMMUState *s);
 
 static inline bool vtd_queued_inv_disable_check(IntelIOMMUState *s)
 {
@@ -1468,16 +1465,24 @@ static void vtd_handle_gcmd_qie(IntelIOMMUState *s, bool en)
     trace_vtd_inv_qi_enable(en);
 
     if (en) {
-        if (vtd_queued_inv_enable_check(s)) {
-            s->iq = iqa_val & VTD_IQA_IQA_MASK;
-            /* 2^(x+8) entries */
-            s->iq_size = 1UL << ((iqa_val & VTD_IQA_QS) + 8);
-            s->qi_enabled = true;
-            trace_vtd_inv_qi_setup(s->iq, s->iq_size);
-            /* Ok - report back to driver */
-            vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_QIES);
-        } else {
-            trace_vtd_err_qi_enable(s->iq_tail);
+        s->iq = iqa_val & VTD_IQA_IQA_MASK;
+        /* 2^(x+8) entries */
+        s->iq_size = 1UL << ((iqa_val & VTD_IQA_QS) + 8);
+        s->qi_enabled = true;
+        trace_vtd_inv_qi_setup(s->iq, s->iq_size);
+        /* Ok - report back to driver */
+        vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_QIES);
+
+        if (s->iq_tail != 0) {
+            /*
+             * This is a spec violation but Windows guests are known to set up
+             * Queued Invalidation this way so we allow the write and process
+             * Invalidation Descriptors right away.
+             */
+            trace_vtd_warn_invalid_qi_tail(s->iq_tail);
+            if (!(vtd_get_long_raw(s, DMAR_FSTS_REG) & VTD_FSTS_IQE)) {
+                vtd_fetch_inv_desc(s);
+            }
         }
     } else {
         if (vtd_queued_inv_disable_check(s)) {
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 5f111d6..42d8a7e 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -74,7 +74,7 @@ vtd_err_dmar_slpte_read_error(uint64_t iova, int level) "iova 0x%"PRIx64" level
 vtd_err_dmar_slpte_perm_error(uint64_t iova, int level, uint64_t slpte, bool is_write) "iova 0x%"PRIx64" level %d slpte 0x%"PRIx64" write %d"
 vtd_err_dmar_slpte_resv_error(uint64_t iova, int level, uint64_t slpte) "iova 0x%"PRIx64" level %d slpte 0x%"PRIx64
 vtd_err_dmar_translate(uint8_t bus, uint8_t slot, uint8_t func, uint64_t iova) "dev %02x:%02x.%02x iova 0x%"PRIx64
-vtd_err_qi_enable(uint16_t tail) "tail 0x%"PRIx16
+vtd_warn_invalid_qi_tail(uint16_t tail) "tail 0x%"PRIx16
 vtd_err_qi_disable(uint16_t head, uint16_t tail, int type) "head 0x%"PRIx16" tail 0x%"PRIx16" last_desc_type %d"
 vtd_err_qi_tail(uint16_t tail, uint16_t size) "tail 0x%"PRIx16" size 0x%"PRIx16
 vtd_err_irte(int index, uint64_t lo, uint64_t hi) "index %d low 0x%"PRIx64" high 0x%"PRIx64
-- 
MST
