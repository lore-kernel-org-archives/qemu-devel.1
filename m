Received: from eggs.gnu.org ([2001:4830:134:3::10]:35823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1drSIb-00025d-0m
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:15:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1drSIW-0004s9-3E
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:15:05 -0400
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:53420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1drSIV-0004rm-St
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:15:00 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 80B67AB2DB
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 19:14:58 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 11 Sep 2017 19:12:32 +0200
Message-Id: <20170911171235.29331-19-clg@kaod.org>
In-Reply-To: <20170911171235.29331-1-clg@kaod.org>
References: <20170911171235.29331-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v2 18/21] ppc/xive: add device tree support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Like for XICS, the XIVE interface for the guest is described in the
device tree under the "interrupt-controller" node. A couple of new
properties are specific to XIVE :

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

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive_hcall.c  | 54 +++++++++++++++++++++++++++++++++++++++=
++++++
 include/hw/ppc/spapr_xive.h |  1 +
 2 files changed, 55 insertions(+)

diff --git a/hw/intc/spapr_xive_hcall.c b/hw/intc/spapr_xive_hcall.c
index 4c77b65683de..7b19ea6373dd 100644
--- a/hw/intc/spapr_xive_hcall.c
+++ b/hw/intc/spapr_xive_hcall.c
@@ -874,3 +874,57 @@ void spapr_xive_hcall_init(sPAPRMachineState *spapr)
     spapr_register_hypercall(H_INT_SYNC, h_int_sync);
     spapr_register_hypercall(H_INT_RESET, h_int_reset);
 }
+
+void spapr_xive_populate(sPAPRXive *xive, void *fdt, uint32_t phandle)
+{
+    int node;
+    uint64_t timas[2 * 2];
+    uint32_t lisn_ranges[] =3D {
+        cpu_to_be32(xive->nr_irqs - xive->nr_targets + xive->ics->offset=
),
+        cpu_to_be32(xive->nr_targets),
+    };
+    uint32_t eq_sizes[] =3D {
+        cpu_to_be32(12), /* 4K */
+        cpu_to_be32(16), /* 64K */
+        cpu_to_be32(21), /* 2M */
+        cpu_to_be32(24), /* 16M */
+    };
+
+    /* Use some ranges to exercise the Linux driver, which should
+     * result in Linux choosing priority 6. This is not strictly
+     * necessary
+     */
+    uint32_t reserved_priorities[] =3D {
+        cpu_to_be32(1),  /* start */
+        cpu_to_be32(2),  /* count */
+        cpu_to_be32(7),  /* start */
+        cpu_to_be32(0xf8),  /* count */
+    };
+    int i;
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
+                     reserved_priorities, sizeof(reserved_priorities)));
+}
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index ae5ff89533c0..0a156f2d8591 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -69,5 +69,6 @@ struct sPAPRXive {
 typedef struct sPAPRMachineState sPAPRMachineState;
=20
 void spapr_xive_hcall_init(sPAPRMachineState *spapr);
+void spapr_xive_populate(sPAPRXive *xive, void *fdt, uint32_t phandle);
=20
 #endif /* PPC_SPAPR_XIVE_H */
--=20
2.13.5
