Received: from eggs.gnu.org ([2001:4830:134:3::10]:36969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1clZDW-0007ao-5I
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 05:53:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1clZDR-00036M-W9
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 05:53:14 -0500
Received: from 6.mo177.mail-out.ovh.net ([46.105.51.249]:51672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1clZDR-00034d-PY
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 05:53:09 -0500
Received: from player714.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 7C4F73BD6F
	for <qemu-devel@nongnu.org>; Wed,  8 Mar 2017 11:53:01 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  8 Mar 2017 11:52:44 +0100
Message-Id: <1488970371-8865-2-git-send-email-clg@kaod.org>
In-Reply-To: <1488970371-8865-1-git-send-email-clg@kaod.org>
References: <1488970371-8865-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.10 1/8] ppc/xics: add a
 xics_get_cpu_index_by_pir() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

This helper will be used to translate the server number of the XIVE
(which is a PIR) into an ICPState index number (which is a cpu index).

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics.c        | 11 +++++++++++
 hw/ppc/ppc.c          | 16 ++++++++++++++++
 include/hw/ppc/xics.h |  1 +
 target/ppc/cpu.h      | 10 ++++++++++
 4 files changed, 38 insertions(+)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index e740989a1162..209e1a75ecb9 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -49,6 +49,17 @@ int xics_get_cpu_index_by_dt_id(int cpu_dt_id)
     return -1;
 }
=20
+int xics_get_cpu_index_by_pir(int pir)
+{
+    PowerPCCPU *cpu =3D ppc_get_vcpu_by_pir(pir);
+
+    if (cpu) {
+        return cpu->parent_obj.cpu_index;
+    }
+
+    return -1;
+}
+
 void xics_cpu_destroy(XICSFabric *xi, PowerPCCPU *cpu)
 {
     CPUState *cs =3D CPU(cpu);
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 5f93083d4a16..94bbe382a73a 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -1379,6 +1379,22 @@ PowerPCCPU *ppc_get_vcpu_by_dt_id(int cpu_dt_id)
     return NULL;
 }
=20
+PowerPCCPU *ppc_get_vcpu_by_pir(int pir)
+{
+    CPUState *cs;
+
+    CPU_FOREACH(cs) {
+        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+        CPUPPCState *env =3D &cpu->env;
+
+        if (env->spr_cb[SPR_PIR].default_value =3D=3D pir) {
+            return cpu;
+        }
+    }
+
+    return NULL;
+}
+
 void ppc_cpu_parse_features(const char *cpu_model)
 {
     CPUClass *cc;
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 9a5e715fe553..42bd24e975cb 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -173,6 +173,7 @@ void xics_cpu_destroy(XICSFabric *xi, PowerPCCPU *cpu=
);
=20
 /* Internal XICS interfaces */
 int xics_get_cpu_index_by_dt_id(int cpu_dt_id);
+int xics_get_cpu_index_by_pir(int pir);
=20
 void icp_set_cppr(ICPState *icp, uint8_t cppr);
 void icp_set_mfrr(ICPState *icp, uint8_t mfrr);
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 7c4a1f50b38b..24a5af95cb45 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2518,5 +2518,15 @@ int ppc_get_vcpu_dt_id(PowerPCCPU *cpu);
  */
 PowerPCCPU *ppc_get_vcpu_by_dt_id(int cpu_dt_id);
=20
+/**
+ * ppc_get_vcpu_by_pir_id:
+ * @pir: Processor Identifier Register (SPR_PIR)
+ *
+ * Searches for a CPU by @pir.
+ *
+ * Returns: a PowerPCCPU struct
+ */
+PowerPCCPU *ppc_get_vcpu_by_pir(int pir);
+
 void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int le=
n);
 #endif /* PPC_CPU_H */
--=20
2.7.4
