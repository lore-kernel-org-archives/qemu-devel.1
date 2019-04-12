Received: from eggs.gnu.org ([209.51.188.92]:52585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <npiggin@gmail.com>) id 1hEmrZ-0003HF-S1
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 23:28:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <npiggin@gmail.com>) id 1hEmrY-0007Lh-QY
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 23:28:25 -0400
Date: Fri, 12 Apr 2019 13:28:16 +1000
From: Nicholas Piggin <npiggin@gmail.com>
References: <20190411063408.3998-1-clg@kaod.org>
In-Reply-To: <20190411063408.3998-1-clg@kaod.org>
MIME-Version: 1.0
Message-Id: <1555039552.i5y8oxfv9m.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ppc/spapr: Add H_PROD and H_CONFER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?q?C=E9dric?= Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

C=C3=A9dric Le Goater's on April 11, 2019 4:34 pm:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> H_PROD should be fully functional, H_CEDE is modified to
> ignore a proded CPU. H_CONFER is a stub to avoid returning
> an error.

Huh, I just implemented these a couple of days ago to test pseries
suspend, also H_JOIN.

---
 hw/ppc/spapr_hcall.c | 79 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 8a736797b9..47ee933333 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1065,6 +1065,81 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprMac=
hineState *spapr,
     return H_SUCCESS;
 }
=20
+static target_ulong h_join(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                           target_ulong opcode, target_ulong *args)
+{
+    CPUPPCState *env =3D &cpu->env;
+    CPUState *cs =3D CPU(cpu);
+
+    if (env->msr & (1ULL << MSR_EE))
+        return H_BAD_MODE;
+
+    /*
+     * This should check for single-threaded mode. In practice, Linux
+     * does not try to H_JOIN all CPUs.
+     */
+
+    cs->halted =3D 1;
+    cs->exception_index =3D EXCP_HALTED;
+    cs->exit_request =3D 1;
+
+    return H_SUCCESS;
+}
+
+static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                           target_ulong opcode, target_ulong *args)
+{
+    target_long target =3D args[0];
+    CPUState *cs =3D CPU(cpu);
+
+    /*
+     * This does not do a targeted yield, but check the parameter anyway.
+     */
+    if (target !=3D -1 && !CPU(spapr_find_cpu(target)))
+        return H_PARAMETER;
+
+    /*
+     * H_CONFER with target =3D=3D this is not exactly the same as H_JOIN
+     * according to PAPR (e.g., MSR[EE] check and single threaded check
+     * is not done in this case), but unlikely to matter.
+     */
+    if (cpu =3D=3D spapr_find_cpu(target))
+        return h_join(cpu, spapr, opcode, args);
+
+    /*
+     * This does not implement the dispatch sequence check.
+     */
+    cs->exception_index =3D EXCP_YIELD;
+    cpu_loop_exit(cs);
+
+    return H_SUCCESS;
+}
+
+/*
+ * H_PROD and H_CONFER are specified to only modify GPR r3, which is not
+ * achievable running under KVM, although KVM already implements H_CONFER
+ * this way.
+ */
+static target_ulong h_prod(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                           target_ulong opcode, target_ulong *args)
+{
+    target_long target =3D args[0];
+    CPUState *cs;
+
+    /*
+     * Should set the prod flag in the VPA.
+     */
+
+    cs =3D CPU(spapr_find_cpu(target));
+    if (!cs)
+        return H_PARAMETER;
+
+    cs->halted =3D 0;
+    qemu_cpu_kick(cs);
+
+    return H_SUCCESS;
+}
+
 static target_ulong h_rtas(PowerPCCPU *cpu, SpaprMachineState *spapr,
                            target_ulong opcode, target_ulong *args)
 {
@@ -1860,6 +1935,10 @@ static void hypercall_register_types(void)
     /* hcall-splpar */
     spapr_register_hypercall(H_REGISTER_VPA, h_register_vpa);
     spapr_register_hypercall(H_CEDE, h_cede);
+    spapr_register_hypercall(H_CONFER, h_confer);
+    spapr_register_hypercall(H_JOIN, h_join);
+    spapr_register_hypercall(H_PROD, h_prod);
+
     spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_reset);
=20
     /* processor register resource access h-calls */
--=20
2.20.1

=
