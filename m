Received: from eggs.gnu.org ([2001:4830:134:3::10]:56443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dc2Ia-0005uH-2i
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 00:27:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dc2IZ-0003VA-6i
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 00:27:20 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 31 Jul 2017 14:27:10 +1000
Message-Id: <20170731042710.19924-3-david@gibson.dropbear.id.au>
In-Reply-To: <20170731042710.19924-1-david@gibson.dropbear.id.au>
References: <20170731042710.19924-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 2/2] Revert "spapr: populate device tree
 depending on XIVE_EXPLOIT option"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, groug@kaod.org, agraf@suse.de, David Gibson <david@gibson.dropbear.id.au>

This reverts commit b87680427e8a3ff682f66514e99a8344e7437247.

I thought this was a harmless preliminary for XIVE enablement patches
we expect later on.  However, due to some subtle interactions between
qemu and SLOF (guest firmware) this breaks some things.  Revert it for
now, we'll work out how to fix it when the rest of the XIVE patches
are ready.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 2a3e53d5d5..f7a19720dc 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -776,11 +776,6 @@ static int spapr_dt_cas_updates(sPAPRMachineState *spapr, void *fdt,
         }
     }
 
-    /* /interrupt controller */
-    if (!spapr_ovec_test(ov5_updates, OV5_XIVE_EXPLOIT)) {
-        spapr_dt_xics(xics_max_server_number(), fdt, PHANDLE_XICP);
-    }
-
     offset = fdt_path_offset(fdt, "/chosen");
     if (offset < 0) {
         offset = fdt_add_subnode(fdt, 0, "chosen");
@@ -804,7 +799,7 @@ int spapr_h_cas_compose_response(sPAPRMachineState *spapr,
 
     size -= sizeof(hdr);
 
-    /* Create skeleton */
+    /* Create sceleton */
     fdt_skel = g_malloc0(size);
     _FDT((fdt_create(fdt_skel, size)));
     _FDT((fdt_begin_node(fdt_skel, "")));
@@ -1077,6 +1072,9 @@ static void *spapr_build_fdt(sPAPRMachineState *spapr,
     _FDT(fdt_setprop_cell(fdt, 0, "#address-cells", 2));
     _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
 
+    /* /interrupt controller */
+    spapr_dt_xics(xics_max_server_number(), fdt, PHANDLE_XICP);
+
     ret = spapr_populate_memory(spapr, fdt);
     if (ret < 0) {
         error_report("couldn't setup memory nodes in fdt");
-- 
2.13.3
