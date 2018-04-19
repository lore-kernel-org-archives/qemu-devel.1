Received: from eggs.gnu.org ([2001:4830:134:3::10]:57457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98w3-0000G1-EM
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:45:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98vz-00008Y-GQ
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:45:11 -0400
Received: from 20.mo4.mail-out.ovh.net ([46.105.33.73]:33167)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f98vz-00007l-78
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:45:07 -0400
Received: from player792.ha.ovh.net (unknown [10.109.105.55])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id BC817167D19
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:45:05 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 19 Apr 2018 14:43:10 +0200
Message-Id: <20180419124331.3915-15-clg@kaod.org>
In-Reply-To: <20180419124331.3915-1-clg@kaod.org>
References: <20180419124331.3915-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 14/35] spapr: add device tree support for
 the XIVE exploitation mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

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

When the XIVE exploitation interrupt mode is activated after the CAS
negotiation, the machine will perform a reboot to rebuild the device
tree.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive_hcall.c  | 64 +++++++++++++++++++++++++++++++++++++++=
++++++
 hw/ppc/spapr.c              |  7 ++++-
 hw/ppc/spapr_hcall.c        |  6 +++++
 include/hw/ppc/spapr_xive.h |  2 ++
 4 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/hw/intc/spapr_xive_hcall.c b/hw/intc/spapr_xive_hcall.c
index 9f3d579bba2c..7dcb1f90ae5b 100644
--- a/hw/intc/spapr_xive_hcall.c
+++ b/hw/intc/spapr_xive_hcall.c
@@ -857,3 +857,67 @@ void spapr_xive_hcall_init(sPAPRMachineState *spapr)
     spapr_register_hypercall(H_INT_SYNC, h_int_sync);
     spapr_register_hypercall(H_INT_RESET, h_int_reset);
 }
+
+void spapr_dt_xive(sPAPRMachineState *spapr, int nr_servers,
+                   void *fdt, uint32_t phandle)
+{
+    sPAPRXive *xive =3D spapr->xive;
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
+    /* The following array is in sync with the 'priority_is_valid'
+     * routine above. Linux is expected to choose priority 6.
+     */
+    uint32_t plat_res_int_priorities[] =3D {
+        cpu_to_be32(7),    /* start */
+        cpu_to_be32(0xf8), /* count */
+    };
+    int i;
+    gchar *nodename;
+
+    /* Thread Interrupt Management Area : User and OS views */
+    for (i =3D 0; i < 2; i++) {
+        timas[i * 2] =3D cpu_to_be64(xive->tm_base + i * (1ull << TM_SHI=
FT));
+        timas[i * 2 + 1] =3D cpu_to_be64(1ull << TM_SHIFT);
+    }
+
+    nodename =3D g_strdup_printf("interrupt-controller@%" PRIx64, xive->=
tm_base);
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
index 7a65dcde3ff7..d4bc6f56c9d4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1188,7 +1188,12 @@ static void *spapr_build_fdt(sPAPRMachineState *sp=
apr,
     _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
=20
     /* /interrupt controller */
-    spapr_dt_xics(xics_max_server_number(spapr), fdt, PHANDLE_XICP);
+    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        spapr_dt_xics(xics_max_server_number(spapr), fdt, PHANDLE_XICP);
+    } else {
+        /* Populate device tree for XIVE */
+        spapr_dt_xive(spapr, xics_max_server_number(spapr), fdt, PHANDLE=
_XICP);
+    }
=20
     ret =3D spapr_populate_memory(spapr, fdt);
     if (ret < 0) {
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 16bccdd5c012..3215c3b4aec3 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1655,6 +1655,12 @@ static target_ulong h_client_architecture_support(=
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
index 49c78b8e33c6..416f51404ce2 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -46,5 +46,7 @@ void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor=
 *mon);
 typedef struct sPAPRMachineState sPAPRMachineState;
=20
 void spapr_xive_hcall_init(sPAPRMachineState *spapr);
+void spapr_dt_xive(sPAPRMachineState *spapr, int nr_servers, void *fdt,
+                   uint32_t phandle);
=20
 #endif /* PPC_SPAPR_XIVE_H */
--=20
2.13.6
