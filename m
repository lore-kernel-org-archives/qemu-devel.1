Received: from eggs.gnu.org ([2001:4830:134:3::10]:56706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3Gwk-0005Eg-Rw
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:01:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3Gwe-000809-6K
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:01:06 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 26 Apr 2017 17:00:04 +1000
Message-Id: <20170426070034.10727-19-david@gibson.dropbear.id.au>
In-Reply-To: <20170426070034.10727-1-david@gibson.dropbear.id.au>
References: <20170426070034.10727-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 18/48] spapr: move the IRQ server number mapping
 under the machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

This is the second step to abstract the IRQ 'server' number of the
XICS layer. Now that the prereq cleanups have been done in the
previous patch, we can move down the 'cpu_dt_id' to 'cpu_index'
mapping in the sPAPR machine handler.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics_spapr.c    | 5 ++---
 hw/ppc/spapr.c          | 3 ++-
 hw/ppc/spapr_cpu_core.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 58f100d..f05308b8 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -52,9 +52,8 @@ static target_ulong h_cppr(PowerPCCPU *cpu, sPAPRMachin=
eState *spapr,
 static target_ulong h_ipi(PowerPCCPU *cpu, sPAPRMachineState *spapr,
                           target_ulong opcode, target_ulong *args)
 {
-    target_ulong server =3D xics_get_cpu_index_by_dt_id(args[0]);
     target_ulong mfrr =3D args[1];
-    ICPState *icp =3D xics_icp_get(XICS_FABRIC(spapr), server);
+    ICPState *icp =3D xics_icp_get(XICS_FABRIC(spapr), args[0]);
=20
     if (!icp) {
         return H_PARAMETER;
@@ -122,7 +121,7 @@ static void rtas_set_xive(PowerPCCPU *cpu, sPAPRMachi=
neState *spapr,
     }
=20
     nr =3D rtas_ld(args, 0);
-    server =3D xics_get_cpu_index_by_dt_id(rtas_ld(args, 1));
+    server =3D rtas_ld(args, 1);
     priority =3D rtas_ld(args, 2);
=20
     if (!ics_valid_irq(ics, nr) || !xics_icp_get(XICS_FABRIC(spapr), ser=
ver)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 8749f1b..08f8615 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3112,9 +3112,10 @@ static void spapr_ics_resend(XICSFabric *dev)
     ics_resend(spapr->ics);
 }
=20
-static ICPState *spapr_icp_get(XICSFabric *xi, int server)
+static ICPState *spapr_icp_get(XICSFabric *xi, int cpu_dt_id)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
+    int server =3D xics_get_cpu_index_by_dt_id(cpu_dt_id);
=20
     return (server < spapr->nr_servers) ? &spapr->icps[server] : NULL;
 }
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 7db61bd..4e1a995 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -64,7 +64,7 @@ static void spapr_cpu_init(sPAPRMachineState *spapr, Po=
werPCCPU *cpu,
 {
     CPUPPCState *env =3D &cpu->env;
     XICSFabric *xi =3D XICS_FABRIC(spapr);
-    ICPState *icp =3D xics_icp_get(xi, CPU(cpu)->cpu_index);
+    ICPState *icp =3D xics_icp_get(xi, cpu->cpu_dt_id);
=20
     /* Set time-base frequency to 512 MHz */
     cpu_ppc_tb_init(env, SPAPR_TIMEBASE_FREQ);
--=20
2.9.3
