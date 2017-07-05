Received: from eggs.gnu.org ([2001:4830:134:3::10]:41943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSnu5-0004ey-Lh
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:15:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSnu1-00040B-LY
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:15:53 -0400
Received: from 15.mo3.mail-out.ovh.net ([87.98.150.177]:43678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dSnu1-0003xr-EK
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:15:49 -0400
Received: from player158.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 4A1E8FCCD6
	for <qemu-devel@nongnu.org>; Wed,  5 Jul 2017 19:15:48 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  5 Jul 2017 19:13:31 +0200
Message-Id: <1499274819-15607-19-git-send-email-clg@kaod.org>
In-Reply-To: <1499274819-15607-1-git-send-email-clg@kaod.org>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 18/26] ppc/xive: add device tree support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

As for XICS, the XIVE interface for the guest is described in the
device tree under the interrupt controller node. A couple of new
properties are specific to XIVE :

 - "reg"

   contains the base address and size of the thread interrupt
   managnement areas (TIMA) for the user level for the OS level. Only
   the OS level is taken into account.

 - "ibm,xive-eq-sizes"

   the size of the event queues.

 - "ibm,xive-lisn-ranges"

   the interrupt numbers ranges assigned to the guest. These are
   allocated using a simple bitmap.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xive_spapr.c  | 36 ++++++++++++++++++++++++++++++++++++
 include/hw/ppc/xive.h |  1 +
 2 files changed, 37 insertions(+)

diff --git a/hw/intc/xive_spapr.c b/hw/intc/xive_spapr.c
index b634d1f28f10..64282cb4bfab 100644
--- a/hw/intc/xive_spapr.c
+++ b/hw/intc/xive_spapr.c
@@ -743,3 +743,39 @@ void xive_spapr_init(sPAPRMachineState *spapr)
     spapr_register_hypercall(H_INT_SYNC, h_int_sync);
     spapr_register_hypercall(H_INT_RESET, h_int_reset);
 }
+
+void xive_spapr_populate(XIVE *x, void *fdt)
+{
+    int node;
+    uint64_t timas[2 * 2];
+    uint32_t lisn_ranges[] =3D {
+        cpu_to_be32(x->int_ipi_top - x->int_base - x->nr_targets),  /* s=
tart */
+        cpu_to_be32(x->nr_targets),  /* count */
+    };
+    uint32_t eq_sizes[] =3D {
+        cpu_to_be32(12), /* 4K */
+        cpu_to_be32(16), /* 64K */
+        cpu_to_be32(21), /* 2M */
+        cpu_to_be32(24), /* 16M */
+    };
+    int i;
+
+    /* Thread Interrupt Management Areas : User and OS */
+    for (i =3D 0; i < 2; i++) {
+        timas[i * 2] =3D cpu_to_be64(x->tm_base + i * (1 << x->tm_shift)=
);
+        timas[i * 2 + 1] =3D cpu_to_be64(1 << x->tm_shift);
+    }
+
+    _FDT(node =3D fdt_add_subnode(fdt, 0, "interrupt-controller"));
+
+    _FDT(fdt_setprop_string(fdt, node, "name", "interrupt-controller"));
+    _FDT(fdt_setprop_string(fdt, node, "device_type", "power-ivpe"));
+    _FDT(fdt_setprop(fdt, node, "reg", timas, sizeof(timas)));
+
+    _FDT(fdt_setprop_string(fdt, node, "compatible", "ibm,power-ivpe"));
+    _FDT(fdt_setprop_cell(fdt, node, "#interrupt-cells", 2));
+    _FDT(fdt_setprop(fdt, node, "ibm,xive-eq-sizes", eq_sizes,
+                     sizeof(eq_sizes)));
+    _FDT(fdt_setprop(fdt, node, "ibm,xive-lisn-ranges", lisn_ranges,
+                     sizeof(lisn_ranges)));
+}
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index af48d62cc776..288116aeb8f4 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -66,5 +66,6 @@ struct XiveICPState {
 typedef struct sPAPRMachineState sPAPRMachineState;
=20
 void xive_spapr_init(sPAPRMachineState *spapr);
+void xive_spapr_populate(XIVE *x, void *fdt);
=20
 #endif /* PPC_XIVE_H */
--=20
2.7.5
