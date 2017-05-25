Received: from eggs.gnu.org ([2001:4830:134:3::10]:57201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjoM-0006UM-RQ
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:51:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjoL-0007Rz-Ny
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:51:42 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 25 May 2017 13:51:16 +1000
Message-Id: <20170525035132.24268-3-david@gibson.dropbear.id.au>
In-Reply-To: <20170525035132.24268-1-david@gibson.dropbear.id.au>
References: <20170525035132.24268-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/18] ppc/xics: simplify prototype of
 xics_spapr_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, sbobroff@redhat.com, sursingh@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

This function only does hypercall and RTAS-call registration, and thus
never returns an error. This patch adapt the prototype to reflect that.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics_spapr.c  | 3 +--
 hw/ppc/spapr.c        | 2 +-
 include/hw/ppc/xics.h | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index f05308b8..d98ea8b 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -229,7 +229,7 @@ static void rtas_int_on(PowerPCCPU *cpu, sPAPRMachine=
State *spapr,
     rtas_st(rets, 0, RTAS_OUT_SUCCESS);
 }
=20
-int xics_spapr_init(sPAPRMachineState *spapr, Error **errp)
+void xics_spapr_init(sPAPRMachineState *spapr)
 {
     /* Registration of global state belongs into realize */
     spapr_rtas_register(RTAS_IBM_SET_XIVE, "ibm,set-xive", rtas_set_xive=
);
@@ -243,7 +243,6 @@ int xics_spapr_init(sPAPRMachineState *spapr, Error *=
*errp)
     spapr_register_hypercall(H_XIRR_X, h_xirr_x);
     spapr_register_hypercall(H_EOI, h_eoi);
     spapr_register_hypercall(H_IPOLL, h_ipoll);
-    return 0;
 }
=20
 #define ICS_IRQ_FREE(ics, srcno)   \
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0980d73..18709ad 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -139,7 +139,7 @@ static void xics_system_init(MachineState *machine, i=
nt nr_irqs, Error **errp)
     }
=20
     if (!spapr->ics) {
-        xics_spapr_init(spapr, errp);
+        xics_spapr_init(spapr);
         spapr->icp_type =3D TYPE_ICP;
         spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_irqs,=
 errp);
     }
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 05e6acb..d6cb51f 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -206,6 +206,6 @@ void icp_resend(ICPState *ss);
 typedef struct sPAPRMachineState sPAPRMachineState;
=20
 int xics_kvm_init(sPAPRMachineState *spapr, Error **errp);
-int xics_spapr_init(sPAPRMachineState *spapr, Error **errp);
+void xics_spapr_init(sPAPRMachineState *spapr);
=20
 #endif /* XICS_H */
--=20
2.9.4
