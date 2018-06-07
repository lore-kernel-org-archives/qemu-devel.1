Received: from eggs.gnu.org ([2001:4830:134:3::10]:39196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxCj-0002lu-6Z
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:52:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxCe-0004C3-E7
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:52:01 -0400
Received: from 9.mo5.mail-out.ovh.net ([178.32.96.204]:51158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fQxCe-0004BQ-4T
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:51:56 -0400
Received: from player169.ha.ovh.net (unknown [10.109.120.100])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 967F01BDF45
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 17:51:54 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  7 Jun 2018 17:49:53 +0200
Message-Id: <20180607155003.1580-19-clg@kaod.org>
In-Reply-To: <20180607155003.1580-1-clg@kaod.org>
References: <20180607155003.1580-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 18/28] spapr: add device tree support for
 the XIVE exploitation mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

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
 hw/intc/spapr_xive_hcall.c  | 62 +++++++++++++++++++++++++++++++++++++++=
++++++
 hw/ppc/spapr.c              |  3 ++-
 hw/ppc/spapr_irq.c          | 25 ++++++++++++++++++
 5 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index aa41c487b705..b070276c9abb 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -42,6 +42,8 @@ typedef struct sPAPRIrq {
     void (*free)(sPAPRMachineState *spapr, int irq, int num, Error **err=
p);
     qemu_irq (*qirq)(sPAPRMachineState *spapr, int irq);
     void (*print_info)(sPAPRMachineState *spapr, Monitor *mon);
+    void (*dt_populate)(sPAPRMachineState *spapr, uint32_t nr_servers,
+                        void *fdt, uint32_t phandle);
 } sPAPRIrq;
=20
 extern sPAPRIrq spapr_irq_legacy;
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 5dedb9e5c7c0..3cbf8dbefb87 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -62,5 +62,7 @@ bool spapr_xive_eq_is_valid(uint8_t priority);
 typedef struct sPAPRMachineState sPAPRMachineState;
=20
 void spapr_xive_hcall_init(sPAPRMachineState *spapr);
+void spapr_dt_xive(sPAPRXive *xive, int nr_servers, void *fdt,
+                   uint32_t phandle);
=20
 #endif /* PPC_SPAPR_XIVE_H */
diff --git a/hw/intc/spapr_xive_hcall.c b/hw/intc/spapr_xive_hcall.c
index 376ff7ba00f9..526f79276927 100644
--- a/hw/intc/spapr_xive_hcall.c
+++ b/hw/intc/spapr_xive_hcall.c
@@ -885,3 +885,65 @@ void spapr_xive_hcall_init(sPAPRMachineState *spapr)
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
+    /* The following array is in sync with the 'spapr_xive_eq_is_valid'
+     * routine above. Linux is expected to choose priority 6.
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
index 156feff6e3fa..3340264e4cfb 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1233,7 +1233,8 @@ static void *spapr_build_fdt(sPAPRMachineState *spa=
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
index c9a3c9694a91..be71998777c2 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -240,6 +240,14 @@ static void spapr_irq_print_info_legacy(sPAPRMachine=
State *spapr,
     ics_pic_print_info(spapr->ics, mon);
 }
=20
+
+static void spapr_irq_dt_populate_legacy(sPAPRMachineState *spapr,
+                                         uint32_t nr_servers, void *fdt,
+                                         uint32_t phandle)
+{
+    spapr_dt_xics(nr_servers, fdt, phandle);
+}
+
 sPAPRIrq spapr_irq_legacy =3D {
     .nr_irqs     =3D XICS_IRQS_SPAPR,
     .init        =3D spapr_irq_init_legacy,
@@ -249,6 +257,7 @@ sPAPRIrq spapr_irq_legacy =3D {
     .free        =3D spapr_irq_free_legacy,
     .qirq        =3D spapr_qirq_legacy,
     .print_info  =3D spapr_irq_print_info_legacy,
+    .dt_populate =3D spapr_irq_dt_populate_legacy,
 };
=20
 /*
@@ -457,6 +466,13 @@ static void spapr_irq_print_info_xics(sPAPRMachineSt=
ate *spapr,
     spapr_irq_print_info_legacy(spapr, mon);
 }
=20
+static void spapr_irq_dt_populate_xics(sPAPRMachineState *spapr,
+                                       uint32_t nr_servers, void *fdt,
+                                       uint32_t phandle)
+{
+    spapr_irq_dt_populate_legacy(spapr, nr_servers, fdt, phandle);
+}
+
 /*
  * XICS IRQ number space
  *
@@ -501,6 +517,7 @@ sPAPRIrq spapr_irq_xics =3D {
     .free        =3D spapr_irq_free_xics,
     .qirq        =3D spapr_qirq_xics,
     .print_info  =3D spapr_irq_print_info_xics,
+    .dt_populate =3D spapr_irq_dt_populate_xics,
 };
=20
 /*
@@ -659,6 +676,13 @@ static void spapr_irq_print_info_xive(sPAPRMachineSt=
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
  * XIVE IRQ number space
  *
@@ -705,6 +729,7 @@ sPAPRIrq spapr_irq_xive =3D {
     .free        =3D spapr_irq_free_xive,
     .qirq        =3D spapr_qirq_xive,
     .print_info  =3D spapr_irq_print_info_xive,
+    .dt_populate =3D spapr_irq_dt_populate_xive,
 };
=20
 /*
--=20
2.13.6
