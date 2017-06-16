Received: from eggs.gnu.org ([2001:4830:134:3::10]:45337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dLtVf-0002yW-UT
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:50:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dLtVe-0002yP-O0
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:50:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dLtVe-0002xa-HK
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:50:06 -0400
Date: Fri, 16 Jun 2017 18:50:01 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1497628168-30489-7-git-send-email-mst@redhat.com>
References: <1497628168-30489-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1497628168-30489-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 6/7] intel_iommu: cleanup
 vtd_interrupt_remap_msi()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Peter Xu <peterx@redhat.com>

Move the memcpy upper into where needed, then share the trace so that we
trace every correct remapping.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 24bdd00..a9b59bd 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2520,7 +2520,8 @@ static int vtd_interrupt_remap_msi(IntelIOMMUState *iommu,
     trace_vtd_ir_remap_msi_req(origin->address, origin->data);
 
     if (!iommu || !iommu->intr_enabled) {
-        goto do_not_translate;
+        memcpy(translated, origin, sizeof(*origin));
+        goto out;
     }
 
     if (origin->address & VTD_MSI_ADDR_HI_MASK) {
@@ -2537,7 +2538,8 @@ static int vtd_interrupt_remap_msi(IntelIOMMUState *iommu,
 
     /* This is compatible mode. */
     if (addr.addr.int_mode != VTD_IR_INT_FORMAT_REMAP) {
-        goto do_not_translate;
+        memcpy(translated, origin, sizeof(*origin));
+        goto out;
     }
 
     index = addr.addr.index_h << 15 | le16_to_cpu(addr.addr.index_l);
@@ -2589,13 +2591,9 @@ static int vtd_interrupt_remap_msi(IntelIOMMUState *iommu,
     /* Translate VTDIrq to MSI message */
     vtd_generate_msi_message(&irq, translated);
 
+out:
     trace_vtd_ir_remap_msi(origin->address, origin->data,
                            translated->address, translated->data);
-
-    return 0;
-
-do_not_translate:
-    memcpy(translated, origin, sizeof(*origin));
     return 0;
 }
 
-- 
MST
