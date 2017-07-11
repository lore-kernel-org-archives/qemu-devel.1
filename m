Received: from eggs.gnu.org ([2001:4830:134:3::10]:40734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUmxS-0002QM-I1
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:39:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUmxR-0007XS-Jg
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:39:34 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 11 Jul 2017 14:39:17 +1000
Message-Id: <20170711043917.1757-18-david@gibson.dropbear.id.au>
In-Reply-To: <20170711043917.1757-1-david@gibson.dropbear.id.au>
References: <20170711043917.1757-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 17/17] spapr: populate device tree depending on
 XIVE_EXPLOIT option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, groug@kaod.org, bharata@linux.vnet.ibm.com, lvivier@redhat.com, aik@ozlabs.ru, surajjs@au1.ibm.com, sbobroff@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

When XIVE is supported, the device tree should be populated
accordingly and the XIVE memory regions mapped to activate MMIOs.

Depending on the design we choose, we could also allocate different
ICS and ICP objects, or switch between objects. This needs to be
discussed.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ff78a22..f4e011c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -778,6 +778,11 @@ static int spapr_dt_cas_updates(sPAPRMachineState *s=
papr, void *fdt,
         }
     }
=20
+    /* /interrupt controller */
+    if (!spapr_ovec_test(ov5_updates, OV5_XIVE_EXPLOIT)) {
+        spapr_dt_xics(xics_max_server_number(), fdt, PHANDLE_XICP);
+    }
+
     offset =3D fdt_path_offset(fdt, "/chosen");
     if (offset < 0) {
         offset =3D fdt_add_subnode(fdt, 0, "chosen");
@@ -801,7 +806,7 @@ int spapr_h_cas_compose_response(sPAPRMachineState *s=
papr,
=20
     size -=3D sizeof(hdr);
=20
-    /* Create sceleton */
+    /* Create skeleton */
     fdt_skel =3D g_malloc0(size);
     _FDT((fdt_create(fdt_skel, size)));
     _FDT((fdt_begin_node(fdt_skel, "")));
@@ -1069,9 +1074,6 @@ static void *spapr_build_fdt(sPAPRMachineState *spa=
pr,
     _FDT(fdt_setprop_cell(fdt, 0, "#address-cells", 2));
     _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
=20
-    /* /interrupt controller */
-    spapr_dt_xics(xics_max_server_number(), fdt, PHANDLE_XICP);
-
     ret =3D spapr_populate_memory(spapr, fdt);
     if (ret < 0) {
         error_report("couldn't setup memory nodes in fdt");
--=20
2.9.4
