Received: from eggs.gnu.org ([2001:4830:134:3::10]:45410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f5slW-00078y-Fb
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:52:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f5slV-0002fk-Bm
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:52:50 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 10 Apr 2018 22:52:30 +1000
Message-Id: <20180410125233.31618-5-david@gibson.dropbear.id.au>
In-Reply-To: <20180410125233.31618-1-david@gibson.dropbear.id.au>
References: <20180410125233.31618-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 4/7] spapr: Initialize reserved areas list in
 FDT in H_CAS handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

At the moment the device tree produced by the H_CAS handler has no
reserved map initialized at all which is not correct as at least one
empty record is required to be present as a marker of the end.
This does not cause problems now as the only consumer is SLOF which
does not look at the reserved map area.

However when DTC's "Improve libfdt's memory safety" changeset hits
the QEMU upstream, there will be errors reported and crashes observed.

This fixes the problem by adding an empty entry to the reserved map,
just like create_device_tree() does already.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 2c0be8c898..a81570e7c8 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -865,6 +865,7 @@ int spapr_h_cas_compose_response(sPAPRMachineState *spapr,
     /* Create skeleton */
     fdt_skel = g_malloc0(size);
     _FDT((fdt_create(fdt_skel, size)));
+    _FDT((fdt_finish_reservemap(fdt_skel)));
     _FDT((fdt_begin_node(fdt_skel, "")));
     _FDT((fdt_end_node(fdt_skel)));
     _FDT((fdt_finish(fdt_skel)));
-- 
2.14.3
