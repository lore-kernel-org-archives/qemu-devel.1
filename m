Received: from eggs.gnu.org ([2001:4830:134:3::10]:33944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gNbqQ-0007j7-Kz
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:59:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gNbqI-00084q-Jz
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:59:26 -0500
Received: from 1.mo2.mail-out.ovh.net ([46.105.63.121]:57851)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gNbqI-00083p-Au
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 05:59:18 -0500
Received: from player734.ha.ovh.net (unknown [10.109.146.137])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 233F41739CC
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 11:59:16 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 16 Nov 2018 11:57:10 +0100
Message-Id: <20181116105729.23240-18-clg@kaod.org>
In-Reply-To: <20181116105729.23240-1-clg@kaod.org>
References: <20181116105729.23240-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 17/36] spapr: add device tree support for
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
 include/hw/ppc/spapr_irq.h  |  2 ++
 include/hw/ppc/spapr_xive.h |  2 ++
 hw/intc/spapr_xive_hcall.c  | 62 +++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr.c              |  3 +-
 hw/ppc/spapr_irq.c          | 17 ++++++++++
 5 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index c854ae527808..cfdc1f86e713 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -40,6 +40,8 @@ typedef struct sPAPRIrq {
     void (*free)(sPAPRMachineState *spapr, int irq, int num);
     qemu_irq (*qirq)(sPAPRMachineState *spapr, int irq);
     void (*print_info)(sPAPRMachineState *spapr, Monitor *mon);
+    void (*dt_populate)(sPAPRMachineState *spapr, uint32_t nr_servers,
+                        void *fdt, uint32_t phandle);
 } sPAPRIrq;
=20
 extern sPAPRIrq spapr_irq_xics;
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 418511f3dc10..5b3fab192d41 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -65,5 +65,7 @@ bool spapr_xive_priority_is_valid(uint8_t priority);
 typedef struct sPAPRMachineState sPAPRMachineState;
=20
 void spapr_xive_hcall_init(sPAPRMachineState *spapr);
+void spapr_dt_xive(sPAPRXive *xive, int nr_servers, void *fdt,
+                   uint32_t phandle);
=20
 #endif /* PPC_SPAPR_XIVE_H */
diff --git a/hw/intc/spapr_xive_hcall.c b/hw/intc/spapr_xive_hcall.c
index 52e4e23995f5..66c78aa88500 100644
--- a/hw/intc/spapr_xive_hcall.c
+++ b/hw/intc/spapr_xive_hcall.c
@@ -890,3 +890,65 @@ void spapr_xive_hcall_init(sPAPRMachineState *spapr)
     spapr_register_hypercall(H_INT_SYNC, h_int_sync);
     spapr_register_hypercall(H_INT_RESET, h_int_reset);
 }
+
+void spapr_dt_xive(sPAPRXive *xive, int nr_servers, void *fdt, uint32_t =
phandle)
+{
+    int node;
+    uint64_t timas[2 * 2];
+    /* Interrupt number ranges for the IPIs */
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
+    /* The following array is in sync with the 'spapr_xive_priority_is_v=
alid'
+     * routine above. The O/S is expected to choose priority 6.
+     */
+    uint32_t plat_res_int_priorities[] =3D {
+        cpu_to_be32(7),    /* start */
+        cpu_to_be32(0xf8), /* count */
+    };
+    gchar *nodename;
+
+    /* Thread Interrupt Management Area : User (ring 3) and OS (ring 2) =
*/
+    timas[0] =3D cpu_to_be64(xive->tm_base + 3 * (1ull << TM_SHIFT));
+    timas[1] =3D cpu_to_be64(1ull << TM_SHIFT);
+    timas[2] =3D cpu_to_be64(xive->tm_base + 2 * (1ull << TM_SHIFT));
+    timas[3] =3D cpu_to_be64(1ull << TM_SHIFT);
+
+    nodename =3D g_strdup_printf("interrupt-controller@%" PRIx64,
+                               xive->tm_base + 3 * (1 << TM_SHIFT));
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
+    /* For Linux to link the LSIs to the main interrupt controller.
+     * These properties are not in XIVE exploitation mode sPAPR
+     * specs
+     */
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
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 9f8c19e56e7a..ad1692cdcd0f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1270,7 +1270,8 @@ static void *spapr_build_fdt(sPAPRMachineState *spa=
pr,
     _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
=20
     /* /interrupt controller */
-    spapr_dt_xics(xics_max_server_number(spapr), fdt, PHANDLE_XICP);
+    smc->irq->dt_populate(spapr, xics_max_server_number(spapr), fdt,
+                          PHANDLE_XICP);
=20
     ret =3D spapr_populate_memory(spapr, fdt);
     if (ret < 0) {
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index da6fcfaa3c52..d88a029d8c5c 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -190,6 +190,13 @@ static void spapr_irq_print_info_xics(sPAPRMachineSt=
ate *spapr, Monitor *mon)
     ics_pic_print_info(spapr->ics, mon);
 }
=20
+static void spapr_irq_dt_populate_xics(sPAPRMachineState *spapr,
+                                       uint32_t nr_servers, void *fdt,
+                                       uint32_t phandle)
+{
+    spapr_dt_xics(nr_servers, fdt, phandle);
+}
+
 #define SPAPR_IRQ_XICS_NR_IRQS     0x1000
 #define SPAPR_IRQ_XICS_NR_MSIS     \
     (XICS_IRQ_BASE + SPAPR_IRQ_XICS_NR_IRQS - SPAPR_IRQ_MSI)
@@ -203,6 +210,7 @@ sPAPRIrq spapr_irq_xics =3D {
     .free        =3D spapr_irq_free_xics,
     .qirq        =3D spapr_qirq_xics,
     .print_info  =3D spapr_irq_print_info_xics,
+    .dt_populate =3D spapr_irq_dt_populate_xics,
 };
=20
  /*
@@ -300,6 +308,13 @@ static void spapr_irq_print_info_xive(sPAPRMachineSt=
ate *spapr,
     spapr_xive_pic_print_info(spapr->xive, mon);
 }
=20
+static void spapr_irq_dt_populate_xive(sPAPRMachineState *spapr,
+                                       uint32_t nr_servers, void *fdt,
+                                       uint32_t phandle)
+{
+    spapr_dt_xive(spapr->xive, nr_servers, fdt, phandle);
+}
+
 /*
  * XIVE uses the full IRQ number space. Set it to 8K to be compatible
  * with XICS.
@@ -317,6 +332,7 @@ sPAPRIrq spapr_irq_xive =3D {
     .free        =3D spapr_irq_free_xive,
     .qirq        =3D spapr_qirq_xive,
     .print_info  =3D spapr_irq_print_info_xive,
+    .dt_populate =3D spapr_irq_dt_populate_xive,
 };
=20
 /*
@@ -421,4 +437,5 @@ sPAPRIrq spapr_irq_xics_legacy =3D {
     .free        =3D spapr_irq_free_xics,
     .qirq        =3D spapr_qirq_xics,
     .print_info  =3D spapr_irq_print_info_xics,
+    .dt_populate =3D spapr_irq_dt_populate_xics,
 };
--=20
2.17.2
