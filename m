Received: from eggs.gnu.org ([2001:4830:134:3::10]:38521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gZGV7-0007Xy-UJ
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:37:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gZGV2-0005ec-VQ
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:37:37 -0500
From: Laurent Vivier <lvivier@redhat.com>
Date: Tue, 18 Dec 2018 14:18:29 +0100
Message-Id: <20181218131829.5135-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] spapr: Add H-Call H_HOME_NODE_ASSOCIATIVITY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>

H_HOME_NODE_ASSOCIATIVITY H-Call returns the associativity domain
designation associated with the identifier input parameter

This fixes a crash when we try to hotplug a CPU in memory-less and
CPU-less numa node. In this case, the kernel tries to online the
node, but without the information provided by this h-call, the node id,
it cannot and the CPU is started while the node is not onlined.

It also removes the warning message from the kernel:
  VPHN is not supported. Disabling polling..

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---

Notes:
    v2:
      add hcall-vphn to ibm,hypertas-functions
      correctly check flags
      return H_FUNCTION rather than H_PARAMETER
      update description

 hw/ppc/spapr.c         |  1 +
 hw/ppc/spapr_hcall.c   | 39 +++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |  1 +
 3 files changed, 41 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 7a0ab2da54..d961272c8a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1049,6 +1049,7 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr,=
 void *fdt)
     add_str(hypertas, "hcall-sprg0");
     add_str(hypertas, "hcall-copy");
     add_str(hypertas, "hcall-debug");
+    add_str(hypertas, "hcall-vphn");
     add_str(qemu_hypertas, "hcall-memop1");
=20
     if (!kvm_enabled() || kvmppc_spapr_use_multitce()) {
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 78fecc8fe9..a48adb3cfb 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1663,6 +1663,41 @@ static target_ulong h_client_architecture_support(=
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
+#define ASSOCIATIVITY(a, b) (((uint64_t)a << 32) | ((uint64_t)b & 0xffff=
ffff))
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
@@ -1864,6 +1899,10 @@ static void hypercall_register_types(void)
     spapr_register_hypercall(KVMPPC_H_CAS, h_client_architecture_support=
);
=20
     spapr_register_hypercall(KVMPPC_H_UPDATE_DT, h_update_dt);
+
+    /* Virtual Processor Home Node */
+    spapr_register_hypercall(H_HOME_NODE_ASSOCIATIVITY,
+                             h_home_node_associativity);
 }
=20
 type_init(hypercall_register_types)
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index b1a2515107..eb13e2b614 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -447,6 +447,7 @@ struct sPAPRMachineState {
 #define H_GET_EM_PARMS          0x2B8
 #define H_SET_MPP               0x2D0
 #define H_GET_MPP               0x2D4
+#define H_HOME_NODE_ASSOCIATIVITY 0x2EC
 #define H_XIRR_X                0x2FC
 #define H_RANDOM                0x300
 #define H_SET_MODE              0x31C
--=20
2.19.2
