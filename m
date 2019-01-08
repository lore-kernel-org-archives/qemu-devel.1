Received: from eggs.gnu.org ([209.51.188.92]:57687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh08Y-0005dP-No
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:46:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh08U-0006Xg-F0
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:46:16 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  9 Jan 2019 09:45:32 +1100
Message-Id: <20190108224600.23125-2-david@gibson.dropbear.id.au>
In-Reply-To: <20190108224600.23125-1-david@gibson.dropbear.id.au>
References: <20190108224600.23125-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/29] spapr: Add H-Call
 H_HOME_NODE_ASSOCIATIVITY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Laurent Vivier <lvivier@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Laurent Vivier <lvivier@redhat.com>

H_HOME_NODE_ASSOCIATIVITY H-Call returns the associativity domain
designation associated with the identifier input parameter

This fixes a crash when we try to hotplug a CPU in memory-less and
CPU-less numa node. In this case, the kernel tries to online the
node, but without the information provided by this h-call, the node id,
it cannot and the CPU is started while the node is not onlined.

It also removes the warning message from the kernel:
  VPHN is not supported. Disabling polling..

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c         |  1 +
 hw/ppc/spapr_hcall.c   | 40 ++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |  1 +
 3 files changed, 42 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 5671608cea..5fba04e7b2 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1048,6 +1048,7 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr,=
 void *fdt)
     add_str(hypertas, "hcall-sprg0");
     add_str(hypertas, "hcall-copy");
     add_str(hypertas, "hcall-debug");
+    add_str(hypertas, "hcall-vphn");
     add_str(qemu_hypertas, "hcall-memop1");
=20
     if (!kvm_enabled() || kvmppc_spapr_use_multitce()) {
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index ae913d070f..f131c7e04c 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1663,6 +1663,42 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu,
     return H_SUCCESS;
 }
=20
+static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
+                                              sPAPRMachineState *spapr,
+                                              target_ulong opcode,
+                                              target_ulong *args)
+{
+    target_ulong flags =3D args[0];
+    target_ulong procno =3D args[1];
+    PowerPCCPU *tcpu;
+    int idx;
+
+    /* only support procno from H_REGISTER_VPA */
+    if (flags !=3D 0x1) {
+        return H_FUNCTION;
+    }
+
+    tcpu =3D spapr_find_cpu(procno);
+    if (tcpu =3D=3D NULL) {
+        return H_P2;
+    }
+
+    /* sequence is the same as in the "ibm,associativity" property */
+
+    idx =3D 0;
+#define ASSOCIATIVITY(a, b) (((uint64_t)(a) << 32) | \
+                             ((uint64_t)(b) & 0xffffffff))
+    args[idx++] =3D ASSOCIATIVITY(0, 0);
+    args[idx++] =3D ASSOCIATIVITY(0, tcpu->node_id);
+    args[idx++] =3D ASSOCIATIVITY(procno, -1);
+    for ( ; idx < 6; idx++) {
+        args[idx] =3D -1;
+    }
+#undef ASSOCIATIVITY
+
+    return H_SUCCESS;
+}
+
 static target_ulong h_get_cpu_characteristics(PowerPCCPU *cpu,
                                               sPAPRMachineState *spapr,
                                               target_ulong opcode,
@@ -1822,6 +1858,10 @@ static void hypercall_register_types(void)
=20
     /* ibm,client-architecture-support support */
     spapr_register_hypercall(KVMPPC_H_CAS, h_client_architecture_support=
);
+
+    /* Virtual Processor Home Node */
+    spapr_register_hypercall(H_HOME_NODE_ASSOCIATIVITY,
+                             h_home_node_associativity);
 }
=20
 type_init(hypercall_register_types)
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 2c77a8ba88..eb04300d3b 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -444,6 +444,7 @@ struct sPAPRMachineState {
 #define H_GET_EM_PARMS          0x2B8
 #define H_SET_MPP               0x2D0
 #define H_GET_MPP               0x2D4
+#define H_HOME_NODE_ASSOCIATIVITY 0x2EC
 #define H_XIRR_X                0x2FC
 #define H_RANDOM                0x300
 #define H_SET_MODE              0x31C
--=20
2.20.1
