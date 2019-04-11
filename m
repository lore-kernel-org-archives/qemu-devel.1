Received: from eggs.gnu.org ([209.51.188.92]:58775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hETI5-0000mL-Qz
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 02:34:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hETI4-0003iG-MM
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 02:34:29 -0400
Received: from 4.mo1.mail-out.ovh.net ([46.105.76.26]:46678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hETI4-0003Xj-FE
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 02:34:28 -0400
Received: from player746.ha.ovh.net (unknown [10.109.159.35])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id CBB6E167D15
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 08:34:18 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 11 Apr 2019 08:34:08 +0200
Message-Id: <20190411063408.3998-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] ppc/spapr: Add H_PROD and H_CONFER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

H_PROD should be fully functional, H_CEDE is modified to
ignore a proded CPU. H_CONFER is a stub to avoid returning
an error.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/cpu.h     |  3 +++
 hw/ppc/spapr_hcall.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 42eadc4b7997..07cea7268c0c 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1141,6 +1141,9 @@ struct CPUPPCState {
      * sreset), so flag this here.
      */
     bool resume_as_sreset;
+
+    /* Used by SPAPR for H_CEDE/H_PROD */
+    bool prodded;
 #endif
=20
     /* Those resources are used only during code translation */
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 8a736797b9bf..be8044a92f2f 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1057,6 +1057,11 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprM=
achineState *spapr,
=20
     env->msr |=3D (1ULL << MSR_EE);
     hreg_compute_hflags(env);
+    if (env->prodded) {
+        env->prodded =3D false;
+        return H_SUCCESS;
+    }
+
     if (!cpu_has_work(cs)) {
         cs->halted =3D 1;
         cs->exception_index =3D EXCP_HLT;
@@ -1065,6 +1070,36 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprM=
achineState *spapr,
     return H_SUCCESS;
 }
=20
+static void spapr_do_wakeup_on_cpu(CPUState *cs, run_on_cpu_data data)
+{
+    cs->halted =3D 0;
+    cs->exception_index =3D -1;
+}
+
+static target_ulong h_prod(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                           target_ulong opcode, target_ulong *args)
+{
+    target_ulong target =3D args[0];
+    CPUPPCState *env;
+
+    cpu =3D spapr_find_cpu(target);
+    if (cpu) {
+        env =3D &cpu->env;
+        env->prodded =3D true;
+        run_on_cpu(CPU(cpu), spapr_do_wakeup_on_cpu, RUN_ON_CPU_NULL);
+    } else {
+        return H_PARAMETER;
+    }
+    return H_SUCCESS;
+}
+
+static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                             target_ulong opcode, target_ulong *args)
+{
+    /* Do nothing (supposed to confer timeslice). */
+    return H_SUCCESS;
+}
+
 static target_ulong h_rtas(PowerPCCPU *cpu, SpaprMachineState *spapr,
                            target_ulong opcode, target_ulong *args)
 {
@@ -1860,6 +1895,8 @@ static void hypercall_register_types(void)
     /* hcall-splpar */
     spapr_register_hypercall(H_REGISTER_VPA, h_register_vpa);
     spapr_register_hypercall(H_CEDE, h_cede);
+    spapr_register_hypercall(H_PROD, h_prod);
+    spapr_register_hypercall(H_CONFER, h_confer);
     spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_reset);
=20
     /* processor register resource access h-calls */
--=20
2.20.1
