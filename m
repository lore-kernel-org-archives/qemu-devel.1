Received: from eggs.gnu.org ([2001:4830:134:3::10]:33773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1f3uJX-0006XZ-FE
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 22:07:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1f3uJT-0006Sj-U6
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 22:07:47 -0400
Received: from [107.173.13.209] (port=38860 helo=ozlabs.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1f3uJT-0006S5-Md
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 22:07:43 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu,  5 Apr 2018 12:07:38 +1000
Message-Id: <20180405020738.35865-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu] spapr: Initialize reserved areas list in
 FDT in H_CAS handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

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
---
 hw/ppc/spapr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 2c0be8c..a81570e 100644
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
2.11.0
