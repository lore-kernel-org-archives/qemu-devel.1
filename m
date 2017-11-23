Received: from eggs.gnu.org ([2001:4830:134:3::10]:39926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHrcU-0002FE-4v
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:32:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHrcQ-0003GG-V4
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:32:46 -0500
Received: from 14.mo3.mail-out.ovh.net ([188.165.43.98]:41568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eHrcQ-0003D2-MA
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:32:42 -0500
Received: from player797.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 7F08E175AB6
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 14:32:41 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 23 Nov 2017 14:29:50 +0100
Message-Id: <20171123132955.1261-21-clg@kaod.org>
In-Reply-To: <20171123132955.1261-1-clg@kaod.org>
References: <20171123132955.1261-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 20/25] spapr: add device tree support for the
 XIVE interrupt mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The XIVE interface for the guest is described in the device tree under
the "interrupt-controller" node. A couple of new properties are
specific to XIVE :

 - "reg"

   contains the base address and size of the thread interrupt
   managnement areas (TIMA), also called rings, for the User level and
   for the Guest OS level. Only the Guest OS level is taken into
   account today.

 - "ibm,xive-eq-sizes"

   the size of the event queues. One cell per size supported, contains
   log2 of size, in ascending order.

 - "ibm,xive-lisn-ranges"

   the interrupt numbers ranges assigned to the guest. These are
   allocated using a simple bitmap.

and also under the root node :

 - "ibm,plat-res-int-priorities"

   contains a list of priorities that the hypervisor has reserved for
   its own use. Simulate ranges as defined by the PowerVM Hypervisor.

When the XIVE interrupt mode is activated after the CAS negotiation,
the machine will perform a reboot to rebuild the device tree.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive_hcall.c  | 50 +++++++++++++++++++++++++++++++++++++++=
++++++
 hw/ppc/spapr.c              |  7 ++++++-
 hw/ppc/spapr_hcall.c        |  6 ++++++
 include/hw/ppc/spapr_xive.h |  2 ++
 4 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/hw/intc/spapr_xive_hcall.c b/hw/intc/spapr_xive_hcall.c
index 676fe0e2d5c7..60c6c9f4be8f 100644
--- a/hw/intc/spapr_xive_hcall.c
+++ b/hw/intc/spapr_xive_hcall.c
@@ -883,3 +883,53 @@ void spapr_xive_hcall_init(sPAPRMachineState *spapr)
     spapr_register_hypercall(H_INT_SYNC, h_int_sync);
     spapr_register_hypercall(H_INT_RESET, h_int_reset);
 }
+
+void spapr_xive_populate(sPAPRMachineState *spapr, int nr_servers,
+                         void *fdt, uint32_t phandle)
+{
+    sPAPRXive *xive =3D spapr->xive;
+    int node;
+    uint64_t timas[2 * 2];
+    uint32_t lisn_ranges[] =3D {
+        cpu_to_be32(0),
+        cpu_to_be32(nr_servers),
+    };
+    uint32_t eq_sizes[] =3D {
+        cpu_to_be32(12), /* 4K */
+        cpu_to_be32(16), /* 64K */
+        cpu_to_be32(21), /* 2M */
+        cpu_to_be32(24), /* 16M */
+    };
+    uint32_t plat_res_int_priorities[ARRAY_SIZE(reserved_priorities)];
+    int i;
+
+    for (i =3D 0; i < ARRAY_SIZE(plat_res_int_priorities); i++) {
+        plat_res_int_priorities[i] =3D cpu_to_be32(reserved_priorities[i=
]);
+    }
+
+    /* Thread Interrupt Management Areas : User and OS */
+    for (i =3D 0; i < 2; i++) {
+        timas[i * 2] =3D cpu_to_be64(xive->tm_base + i * (1 << xive->tm_=
shift));
+        timas[i * 2 + 1] =3D cpu_to_be64(1 << xive->tm_shift);
+    }
+
+    _FDT(node =3D fdt_add_subnode(fdt, 0, "interrupt-controller"));
+
+    _FDT(fdt_setprop_string(fdt, node, "name", "interrupt-controller"));
+    _FDT(fdt_setprop_string(fdt, node, "device_type", "power-ivpe"));
+    _FDT(fdt_setprop(fdt, node, "reg", timas, sizeof(timas)));
+
+    _FDT(fdt_setprop_string(fdt, node, "compatible", "ibm,power-ivpe"));
+    _FDT(fdt_setprop(fdt, node, "ibm,xive-eq-sizes", eq_sizes,
+                     sizeof(eq_sizes)));
+    _FDT(fdt_setprop(fdt, node, "ibm,xive-lisn-ranges", lisn_ranges,
+                     sizeof(lisn_ranges)));
+
+    /* For SLOF */
+    _FDT(fdt_setprop_cell(fdt, node, "linux,phandle", phandle));
+    _FDT(fdt_setprop_cell(fdt, node, "phandle", phandle));
+
+    /* top properties */
+    _FDT(fdt_setprop(fdt, 0, "ibm,plat-res-int-priorities",
+                     plat_res_int_priorities, sizeof(plat_res_int_priori=
ties)));
+}
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 8b15c0b500d0..3a62369883cc 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1127,7 +1127,12 @@ static void *spapr_build_fdt(sPAPRMachineState *sp=
apr,
     _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
=20
     /* /interrupt controller */
-    spapr_dt_xics(xics_max_server_number(), fdt, PHANDLE_XICP);
+    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        spapr_dt_xics(xics_max_server_number(), fdt, PHANDLE_XICP);
+    } else {
+        /* Populate device tree for XIVE */
+        spapr_xive_populate(spapr, xics_max_server_number(), fdt, PHANDL=
E_XICP);
+    }
=20
     ret =3D spapr_populate_memory(spapr, fdt);
     if (ret < 0) {
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index be22a6b2895f..e2a1665beee9 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1646,6 +1646,12 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu,
             (spapr_h_cas_compose_response(spapr, args[1], args[2],
                                           ov5_updates) !=3D 0);
     }
+
+    /* We need to rebuild the device tree for XIVE, generate a reset */
+    if (!spapr->cas_reboot) {
+        spapr->cas_reboot =3D spapr_ovec_test(ov5_updates, OV5_XIVE_EXPL=
OIT);
+    }
+
     spapr_ovec_cleanup(ov5_updates);
=20
     if (spapr->cas_reboot) {
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 3f822220647f..f6d4bf26e06a 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -82,5 +82,7 @@ void spapr_xive_icp_pic_print_info(sPAPRXiveICP *xicp, =
Monitor *mon);
 typedef struct sPAPRMachineState sPAPRMachineState;
=20
 void spapr_xive_hcall_init(sPAPRMachineState *spapr);
+void spapr_xive_populate(sPAPRMachineState *spapr, int nr_servers, void =
*fdt,
+                         uint32_t phandle);
=20
 #endif /* PPC_SPAPR_XIVE_H */
--=20
2.13.6
