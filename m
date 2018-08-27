Received: from eggs.gnu.org ([2001:4830:134:3::10]:46947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuHP3-0002WE-86
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 09:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuHP0-0005a6-1f
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 09:17:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50108 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fuHOz-0005ZR-SC
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 09:17:53 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180815095328.32414-1-peterx@redhat.com>
	<20180815095328.32414-4-peterx@redhat.com>
Date: Mon, 27 Aug 2018 15:17:45 +0200
In-Reply-To: <20180815095328.32414-4-peterx@redhat.com> (Peter Xu's message of
	"Wed, 15 Aug 2018 17:53:28 +0800")
Message-ID: <8736v0t0cm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 3/3] intel-iommu: replace more vtd_err_*
 traces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Halil Pasic <pasic@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> Replace all the trace_vtd_err_*() hooks with the new error_report_once()
> since they are similar to trace_vtd_err() - dumping the first error
> would be mostly enough, then we have them on by default too.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
[...]

Let's use "%x" instead of "%" PRIx16 for simplicity, and add spaces
around PRIx64 & friends.

Squashing in:

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 9e4e7ed3bb..6cc6e65260 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -705,7 +705,7 @@ static int vtd_iova_to_slpte(VTDContextEntry *ce, uint64_t iova, bool is_write,
     uint64_t access_right_check;
 
     if (!vtd_iova_range_check(iova, ce, aw_bits)) {
-        error_report_once("%s: detected IOVA overflow (iova=0x%"PRIx64")",
+        error_report_once("%s: detected IOVA overflow (iova=0x%" PRIx64 ")",
                           __func__, iova);
         return -VTD_FR_ADDR_BEYOND_MGAW;
     }
@@ -719,7 +719,7 @@ static int vtd_iova_to_slpte(VTDContextEntry *ce, uint64_t iova, bool is_write,
 
         if (slpte == (uint64_t)-1) {
             error_report_once("%s: detected read error on DMAR slpte "
-                              "(iova=0x%"PRIx64")", __func__, iova);
+                              "(iova=0x%" PRIx64 ")", __func__, iova);
             if (level == vtd_ce_get_level(ce)) {
                 /* Invalid programming of context-entry */
                 return -VTD_FR_CONTEXT_ENTRY_INV;
@@ -731,15 +731,15 @@ static int vtd_iova_to_slpte(VTDContextEntry *ce, uint64_t iova, bool is_write,
         *writes = (*writes) && (slpte & VTD_SL_W);
         if (!(slpte & access_right_check)) {
             error_report_once("%s: detected slpte permission error "
-                              "(iova=0x%"PRIx64", level=0x%"PRIx32", "
-                              "slpte=0x%"PRIx64", write=%d)", __func__,
+                              "(iova=0x%" PRIx64 ", level=0x%" PRIx32 ", "
+                              "slpte=0x%" PRIx64 ", write=%d)", __func__,
                               iova, level, slpte, is_write);
             return is_write ? -VTD_FR_WRITE : -VTD_FR_READ;
         }
         if (vtd_slpte_nonzero_rsvd(slpte, level)) {
             error_report_once("%s: detected splte reserve non-zero "
-                              "iova=0x%"PRIx64", level=0x%"PRIx32
-                              "slpte=0x%"PRIx64")", __func__, iova,
+                              "iova=0x%" PRIx64 ", level=0x%" PRIx32
+                              "slpte=0x%" PRIx64 ")", __func__, iova,
                               level, slpte);
             return -VTD_FR_PAGING_ENTRY_RSVD;
         }
@@ -1705,9 +1705,9 @@ static void vtd_handle_gcmd_qie(IntelIOMMUState *s, bool en)
             vtd_set_clear_mask_long(s, DMAR_GSTS_REG, VTD_GSTS_QIES, 0);
         } else {
             error_report_once("%s: detected improper state when disable QI "
-                              "(head=0x%"PRIx16", tail=0x%"PRIx16", "
-                              "last_type=%d)", __func__, s->iq_head,
-                              s->iq_tail, s->iq_last_desc_type);
+                              "(head=0x%x, tail=0x%x, last_type=%d)",
+                              __func__,
+                              s->iq_head, s->iq_tail, s->iq_last_desc_type);
         }
     }
 }
@@ -2105,7 +2105,7 @@ static void vtd_fetch_inv_desc(IntelIOMMUState *s)
     if (s->iq_tail >= s->iq_size) {
         /* Detects an invalid Tail pointer */
         error_report_once("%s: detected invalid QI tail "
-                          "(tail=0x%"PRIx16", size=0x%"PRIx16")",
+                          "(tail=0x%x, size=0x%x)",
                           __func__, s->iq_tail, s->iq_size);
         vtd_handle_inv_queue_error(s);
         return;
@@ -2520,7 +2520,7 @@ static IOMMUTLBEntry vtd_iommu_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
                                  iotlb.addr_mask);
     } else {
         error_report_once("%s: detected translation failure "
-                          "(dev=%02x:%02x:%02x, iova=0x%"PRIx64")",
+                          "(dev=%02x:%02x:%02x, iova=0x%" PRIx64 ")",
                           __func__, pci_bus_num(vtd_as->bus),
                           VTD_PCI_SLOT(vtd_as->devfn),
                           VTD_PCI_FUNC(vtd_as->devfn),
@@ -2641,7 +2641,7 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
 
     if (!entry->irte.present) {
         error_report_once("%s: detected non-present IRTE "
-                          "(index=%u, high=0x%"PRIx64", low=0x%"PRIx64")",
+                          "(index=%u, high=0x%" PRIx64 ", low=0x%" PRIx64 ")",
                           __func__, index, le64_to_cpu(entry->data[1]),
                           le64_to_cpu(entry->data[0]));
         return -VTD_FR_IR_ENTRY_P;
@@ -2650,7 +2650,7 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
     if (entry->irte.__reserved_0 || entry->irte.__reserved_1 ||
         entry->irte.__reserved_2) {
         error_report_once("%s: detected non-zero reserved IRTE "
-                          "(index=%u, high=0x%"PRIx64", low=0x%"PRIx64")",
+                          "(index=%u, high=0x%" PRIx64 ", low=0x%" PRIx64 ")",
                           __func__, index, le64_to_cpu(entry->data[1]),
                           le64_to_cpu(entry->data[0]));
         return -VTD_FR_IR_IRTE_RSVD;
@@ -2811,7 +2811,8 @@ static int vtd_interrupt_remap_msi(IntelIOMMUState *iommu,
         trace_vtd_ir_remap_type("MSI");
         if (origin->data & VTD_IR_MSI_DATA_RESERVED) {
             error_report_once("%s: invalid IR MSI "
-                              "(sid=%u, address=0x%"PRIx64", data=0x%"PRIx32")",
+                              "(sid=%u, address=0x%" PRIx64
+                              ", data=0x%" PRIx32 ")",
                               __func__, sid, origin->address, origin->data);
             return -VTD_FR_IR_REQ_RSVD;
         }
