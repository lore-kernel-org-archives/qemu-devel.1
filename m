Received: from eggs.gnu.org ([2001:4830:134:3::10]:33255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1coWXE-0002v1-Ko
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:37:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1coWXA-0006pZ-7C
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:37:48 -0400
Received: from 19.mo1.mail-out.ovh.net ([178.32.97.206]:47814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1coWXA-0006pM-0k
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:37:44 -0400
Received: from player756.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id E2BBC625C9
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 15:37:41 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 16 Mar 2017 15:35:06 +0100
Message-Id: <1489674912-21942-3-git-send-email-clg@kaod.org>
In-Reply-To: <1489674912-21942-1-git-send-email-clg@kaod.org>
References: <1489674912-21942-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/8] spapr: move the IRQ server number
 mapping under the machine
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

This is the second step to abstract the IRQ 'server' number of the
XICS layer. Now that the prereq cleanups have been done in the
previous patch, we can move down the 'cpu_dt_id' to 'cpu_index'
mapping in the sPAPR machine handler.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics_spapr.c    | 5 ++---
 hw/ppc/spapr.c          | 3 ++-
 hw/ppc/spapr_cpu_core.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 178b3adc8af7..9574cae14944 100644
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
index 6ee566d658f8..396490bc5dfc 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3024,9 +3024,10 @@ static void spapr_ics_resend(XICSFabric *dev)
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
index 59f1cba6fba5..1d5e7fbeeb1f 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -81,7 +81,7 @@ static void spapr_cpu_init(sPAPRMachineState *spapr, Po=
werPCCPU *cpu,
         }
     }
=20
-    cpu->icp =3D xics_icp_get(xi, CPU(cpu)->cpu_index);
+    cpu->icp =3D xics_icp_get(xi, cpu->cpu_dt_id);
     xics_cpu_setup(xi, cpu);
=20
     qemu_register_reset(spapr_cpu_reset, cpu);
--=20
2.7.4
