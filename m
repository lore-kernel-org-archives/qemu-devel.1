Received: from eggs.gnu.org ([2001:4830:134:3::10]:41210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dJKMK-00076K-Fn
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:53:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dJKMJ-0006fZ-L0
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:53:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dJKMJ-0006fN-Ed
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:53:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6CB36C0467CF
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 13:53:50 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri,  9 Jun 2017 21:53:29 +0800
Message-Id: <1497016409-22650-4-git-send-email-peterx@redhat.com>
In-Reply-To: <1497016409-22650-1-git-send-email-peterx@redhat.com>
References: <1497016409-22650-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/3] intel_iommu: cleanup
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

Move the memcpy upper into where needed, then share the trace so that we
trace every correct remapping.

Signed-off-by: Peter Xu <peterx@redhat.com>
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
2.7.4
