Received: from eggs.gnu.org ([2001:4830:134:3::10]:36265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gYtSD-0005A2-Df
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 09:01:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gYtS9-0000OA-RW
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 09:01:05 -0500
From: Laurent Vivier <lvivier@redhat.com>
Date: Mon, 17 Dec 2018 15:00:55 +0100
Message-Id: <20181217140055.8545-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] spapr: Add H-Call H_HOME_NODE_ASSOCIATIVITY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>

H_HOME_NODE_ASSOCIATIVITY H-Call returns the associativity domain
designation associated with the identifier input parameter.

Remove the warning message from the kernel:
  VPHN is not supported. Disabling polling..

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
Based-on: <20181213040126.6768-1-david@gibson.dropbear.id.au>
          "[PULL 00/27] ppc-for-4.0 queue 20181213"

 hw/ppc/spapr_hcall.c   | 39 +++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |  1 +
 2 files changed, 40 insertions(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 78fecc8fe9..454ec594fd 100644
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
+    if ((flags & 0x1) =3D=3D 0) {
+        return H_PARAMETER;
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
