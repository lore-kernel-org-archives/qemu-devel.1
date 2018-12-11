Received: from eggs.gnu.org ([2001:4830:134:3::10]:36756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWqgz-0007R7-Pn
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:39:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWqgu-0008H5-Kb
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:39:53 -0500
Received: from 3.mo179.mail-out.ovh.net ([178.33.251.175]:46213)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gWqgu-0008A8-5k
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:39:48 -0500
Received: from player688.ha.ovh.net (unknown [10.109.159.159])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 9CE4510C78C
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 23:39:42 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 11 Dec 2018 23:38:14 +0100
Message-Id: <20181211223823.13770-4-clg@kaod.org>
In-Reply-To: <20181211223823.13770-1-clg@kaod.org>
References: <20181211223823.13770-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 03/12] spapr: add device tree support for
 the XIVE exploitation mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The XIVE interface for the guest is described in the device tree under
the "interrupt-controller" node. A couple of new properties are
specific to XIVE :

 - "reg"

   contains the base address and size of the thread interrupt
   managnement areas (TIMA), for the User level and for the Guest OS
   level. Only the Guest OS level is taken into account today.

 - "ibm,xive-eq-sizes"

   the size of the event queues. One cell per size supported, contains
   log2 of size, in ascending order.

 - "ibm,xive-lisn-ranges"

   the IRQ interrupt number ranges assigned to the guest for the IPIs.

and also under the root node :

 - "ibm,plat-res-int-priorities"

   contains a list of priorities that the hypervisor has reserved for
   its own use. OPAL uses the priority 7 queue to automatically
   escalate interrupts for all other queues (DD2.X POWER9). So only
   priorities [0..6] are allowed for the guest.

Extend the sPAPR IRQ backend with a new handler to populate the DT
with the appropriate "interrupt-controller" node.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 Changes since v7:

 - changed the EQ sizes list property to contain 64K only
=20
 include/hw/ppc/spapr_irq.h  |  2 ++
 include/hw/ppc/spapr_xive.h |  2 ++
 include/hw/ppc/xics.h       |  4 +--
 hw/intc/spapr_xive.c        | 64 +++++++++++++++++++++++++++++++++++++
 hw/intc/xics_spapr.c        |  3 +-
 hw/ppc/spapr.c              |  3 +-
 hw/ppc/spapr_irq.c          |  3 ++
 7 files changed, 77 insertions(+), 4 deletions(-)

diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 23cdb51b879e..e51e9f052f63 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -39,6 +39,8 @@ typedef struct sPAPRIrq {
     void (*free)(sPAPRMachineState *spapr, int irq, int num);
     qemu_irq (*qirq)(sPAPRMachineState *spapr, int irq);
     void (*print_info)(sPAPRMachineState *spapr, Monitor *mon);
+    void (*dt_populate)(sPAPRMachineState *spapr, uint32_t nr_servers,
+                        void *fdt, uint32_t phandle);
 } sPAPRIrq;
=20
 extern sPAPRIrq spapr_irq_xics;
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 9506a8f4d10a..728a5e8dc163 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -45,5 +45,7 @@ qemu_irq spapr_xive_qirq(sPAPRXive *xive, uint32_t lisn=
);
 typedef struct sPAPRMachineState sPAPRMachineState;
=20
 void spapr_xive_hcall_init(sPAPRMachineState *spapr);
+void spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void *=
fdt,
+                   uint32_t phandle);
=20
 #endif /* PPC_SPAPR_XIVE_H */
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 9958443d1984..14afda198cdb 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -181,8 +181,6 @@ typedef struct XICSFabricClass {
     ICPState *(*icp_get)(XICSFabric *xi, int server);
 } XICSFabricClass;
=20
-void spapr_dt_xics(int nr_servers, void *fdt, uint32_t phandle);
-
 ICPState *xics_icp_get(XICSFabric *xi, int server);
=20
 /* Internal XICS interfaces */
@@ -204,6 +202,8 @@ void icp_resend(ICPState *ss);
=20
 typedef struct sPAPRMachineState sPAPRMachineState;
=20
+void spapr_dt_xics(sPAPRMachineState *spapr, uint32_t nr_servers, void *=
fdt,
+                   uint32_t phandle);
 int xics_kvm_init(sPAPRMachineState *spapr, Error **errp);
 void xics_spapr_init(sPAPRMachineState *spapr);
=20
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 982ac6e17051..9e5b2db2439a 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -14,6 +14,7 @@
 #include "target/ppc/cpu.h"
 #include "sysemu/cpus.h"
 #include "monitor/monitor.h"
+#include "hw/ppc/fdt.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_xive.h"
 #include "hw/ppc/xive.h"
@@ -1381,3 +1382,66 @@ void spapr_xive_hcall_init(sPAPRMachineState *spap=
r)
     spapr_register_hypercall(H_INT_SYNC, h_int_sync);
     spapr_register_hypercall(H_INT_RESET, h_int_reset);
 }
+
+void spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void *=
fdt,
+                   uint32_t phandle)
+{
+    sPAPRXive *xive =3D spapr->xive;
+    int node;
+    uint64_t timas[2 * 2];
+    /* Interrupt number ranges for the IPIs */
+    uint32_t lisn_ranges[] =3D {
+        cpu_to_be32(0),
+        cpu_to_be32(nr_servers),
+    };
+    /* EQ size - the sizes of pages supported by the system 4K, 64K,
+     * 2M, 16M. We only advertise 64K for the moment.
+     */
+    uint32_t eq_sizes[] =3D {
+        cpu_to_be32(16), /* 64K */
+    };
+    /* The following array is in sync with the reserved priorities
+     * defined by the 'spapr_xive_priority_is_reserved' routine.
+     */
+    uint32_t plat_res_int_priorities[] =3D {
+        cpu_to_be32(7),    /* start */
+        cpu_to_be32(0xf8), /* count */
+    };
+    gchar *nodename;
+
+    /* Thread Interrupt Management Area : User (ring 3) and OS (ring 2) =
*/
+    timas[0] =3D cpu_to_be64(xive->tm_base +
+                           XIVE_TM_USER_PAGE * (1ull << TM_SHIFT));
+    timas[1] =3D cpu_to_be64(1ull << TM_SHIFT);
+    timas[2] =3D cpu_to_be64(xive->tm_base +
+                           XIVE_TM_OS_PAGE * (1ull << TM_SHIFT));
+    timas[3] =3D cpu_to_be64(1ull << TM_SHIFT);
+
+    nodename =3D g_strdup_printf("interrupt-controller@%" PRIx64,
+                           xive->tm_base + XIVE_TM_USER_PAGE * (1 << TM_=
SHIFT));
+    _FDT(node =3D fdt_add_subnode(fdt, 0, nodename));
+    g_free(nodename);
+
+    _FDT(fdt_setprop_string(fdt, node, "device_type", "power-ivpe"));
+    _FDT(fdt_setprop(fdt, node, "reg", timas, sizeof(timas)));
+
+    _FDT(fdt_setprop_string(fdt, node, "compatible", "ibm,power-ivpe"));
+    _FDT(fdt_setprop(fdt, node, "ibm,xive-eq-sizes", eq_sizes,
+                     sizeof(eq_sizes)));
+    _FDT(fdt_setprop(fdt, node, "ibm,xive-lisn-ranges", lisn_ranges,
+                     sizeof(lisn_ranges)));
+
+    /* For Linux to link the LSIs to the interrupt controller. */
+    _FDT(fdt_setprop(fdt, node, "interrupt-controller", NULL, 0));
+    _FDT(fdt_setprop_cell(fdt, node, "#interrupt-cells", 2));
+
+    /* For SLOF */
+    _FDT(fdt_setprop_cell(fdt, node, "linux,phandle", phandle));
+    _FDT(fdt_setprop_cell(fdt, node, "phandle", phandle));
+
+    /* The "ibm,plat-res-int-priorities" property defines the priority
+     * ranges reserved by the hypervisor
+     */
+    _FDT(fdt_setprop(fdt, 0, "ibm,plat-res-int-priorities",
+                     plat_res_int_priorities, sizeof(plat_res_int_priori=
ties)));
+}
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 2e27b92b871a..f67d3c80bf3a 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -244,7 +244,8 @@ void xics_spapr_init(sPAPRMachineState *spapr)
     spapr_register_hypercall(H_IPOLL, h_ipoll);
 }
=20
-void spapr_dt_xics(int nr_servers, void *fdt, uint32_t phandle)
+void spapr_dt_xics(sPAPRMachineState *spapr, uint32_t nr_servers, void *=
fdt,
+                   uint32_t phandle)
 {
     uint32_t interrupt_server_ranges_prop[] =3D {
         0, cpu_to_be32(nr_servers),
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 8a18250cf74d..ab46460ddb8b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1268,7 +1268,8 @@ static void *spapr_build_fdt(sPAPRMachineState *spa=
pr,
     _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
=20
     /* /interrupt controller */
-    spapr_dt_xics(spapr_max_server_number(spapr), fdt, PHANDLE_XICP);
+    smc->irq->dt_populate(spapr, spapr_max_server_number(spapr), fdt,
+                          PHANDLE_XICP);
=20
     ret =3D spapr_populate_memory(spapr, fdt);
     if (ret < 0) {
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 9eca8a4c8c51..975954dc2712 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -204,6 +204,7 @@ sPAPRIrq spapr_irq_xics =3D {
     .free        =3D spapr_irq_free_xics,
     .qirq        =3D spapr_qirq_xics,
     .print_info  =3D spapr_irq_print_info_xics,
+    .dt_populate =3D spapr_dt_xics,
 };
=20
 /*
@@ -298,6 +299,7 @@ sPAPRIrq spapr_irq_xive =3D {
     .free        =3D spapr_irq_free_xive,
     .qirq        =3D spapr_qirq_xive,
     .print_info  =3D spapr_irq_print_info_xive,
+    .dt_populate =3D spapr_dt_xive,
 };
=20
 /*
@@ -402,4 +404,5 @@ sPAPRIrq spapr_irq_xics_legacy =3D {
     .free        =3D spapr_irq_free_xics,
     .qirq        =3D spapr_qirq_xics,
     .print_info  =3D spapr_irq_print_info_xics,
+    .dt_populate =3D spapr_dt_xics,
 };
--=20
2.17.2
