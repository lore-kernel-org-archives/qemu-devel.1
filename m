Received: from eggs.gnu.org ([2001:4830:134:3::10]:39127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ceMRM-0002SS-HM
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:49:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ceMRI-0005in-1m
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:49:44 -0500
Received: from 10.mo173.mail-out.ovh.net ([46.105.74.148]:41053)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ceMRH-0005iU-OS
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:49:39 -0500
Received: from player791.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id A4A5824167
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 14:49:37 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 16 Feb 2017 14:47:37 +0100
Message-Id: <1487252865-12064-15-git-send-email-clg@kaod.org>
In-Reply-To: <1487252865-12064-1-git-send-email-clg@kaod.org>
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 14/22] ppc/xics: use the QOM interface to
 grab an ICP
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

Also introduce a xics_icp_get() helper to simplify the changes.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics.c          | 31 ++++++++++++++++++-------------
 hw/intc/xics_spapr.c    | 17 +++++++++--------
 hw/ppc/spapr_cpu_core.c |  4 ++--
 include/hw/ppc/xics.h   |  8 ++++----
 4 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index c14797fb1964..dd41340d41a5 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -49,26 +49,26 @@ int xics_get_cpu_index_by_dt_id(int cpu_dt_id)
     return -1;
 }
=20
-void xics_cpu_destroy(XICSState *xics, PowerPCCPU *cpu)
+void xics_cpu_destroy(XICSInterface *xi, PowerPCCPU *cpu)
 {
     CPUState *cs =3D CPU(cpu);
-    ICPState *ss =3D &xics->ss[cs->cpu_index];
+    ICPState *ss =3D xics_icp_get(xi, cs->cpu_index);
=20
-    assert(cs->cpu_index < xics->nr_servers);
+    assert(ss);
     assert(cs =3D=3D ss->cs);
=20
     ss->output =3D NULL;
     ss->cs =3D NULL;
 }
=20
-void xics_cpu_setup(XICSState *xics, PowerPCCPU *cpu)
+void xics_cpu_setup(XICSInterface *xi, PowerPCCPU *cpu)
 {
     CPUState *cs =3D CPU(cpu);
     CPUPPCState *env =3D &cpu->env;
-    ICPState *ss =3D &xics->ss[cs->cpu_index];
+    ICPState *ss =3D xics_icp_get(xi, cs->cpu_index);
     XICSStateClass *info;
=20
-    assert(cs->cpu_index < xics->nr_servers);
+    assert(ss);
=20
     ss->cs =3D cs;
=20
@@ -307,8 +307,9 @@ void icp_eoi(ICPState *ss, uint32_t xirr)
=20
 static void icp_irq(ICSState *ics, int server, int nr, uint8_t priority)
 {
-    XICSState *xics =3D ics->xics;
-    ICPState *ss =3D xics->ss + server;
+    XICSInterface *xi =3D XICS_INTERFACE(qdev_get_machine());
+    XICSInterfaceClass *xic =3D XICS_INTERFACE_GET_CLASS(xi);
+    ICPState *ss =3D xic->icp_get(xi, server);
=20
     trace_xics_icp_irq(server, nr, priority);
=20
@@ -582,12 +583,9 @@ static void ics_simple_reset(DeviceState *dev)
 static int ics_simple_post_load(ICSState *ics, int version_id)
 {
     XICSInterface *xi =3D XICS_INTERFACE(qdev_get_machine());
-    int i;
-
-    for (i =3D 0; i < ics->xics->nr_servers; i++) {
-        icp_resend(xi, &ics->xics->ss[i]);
-    }
+    XICSInterfaceClass *xic =3D XICS_INTERFACE_GET_CLASS(xi);
=20
+    xic->icp_resend(xi);
     return 0;
 }
=20
@@ -737,6 +735,13 @@ qemu_irq xics_get_qirq(XICSInterface *xi, int irq)
     return NULL;
 }
=20
+ICPState *xics_icp_get(XICSInterface *xi, int server)
+{
+    XICSInterfaceClass *xic =3D XICS_INTERFACE_GET_CLASS(xi);
+
+    return xic->icp_get(xi, server);
+}
+
 void ics_set_irq_type(ICSState *ics, int srcno, bool lsi)
 {
     assert(!(ics->irqs[srcno].flags & XICS_FLAGS_IRQ_MASK));
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 1501e796e5e0..a837ca655f87 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -44,7 +44,7 @@ static target_ulong h_cppr(PowerPCCPU *cpu, sPAPRMachin=
eState *spapr,
                            target_ulong opcode, target_ulong *args)
 {
     CPUState *cs =3D CPU(cpu);
-    ICPState *icp =3D &spapr->xics->ss[cs->cpu_index];
+    ICPState *icp =3D xics_icp_get(XICS_INTERFACE(spapr), cs->cpu_index)=
;
     target_ulong cppr =3D args[0];
=20
     icp_set_cppr(icp, cppr);
@@ -56,12 +56,13 @@ static target_ulong h_ipi(PowerPCCPU *cpu, sPAPRMachi=
neState *spapr,
 {
     target_ulong server =3D xics_get_cpu_index_by_dt_id(args[0]);
     target_ulong mfrr =3D args[1];
+    ICPState *icp =3D xics_icp_get(XICS_INTERFACE(spapr), server);
=20
-    if (server >=3D spapr->xics->nr_servers) {
+    if (!icp) {
         return H_PARAMETER;
     }
=20
-    icp_set_mfrr(spapr->xics->ss + server, mfrr);
+    icp_set_mfrr(icp, mfrr);
     return H_SUCCESS;
 }
=20
@@ -69,7 +70,7 @@ static target_ulong h_xirr(PowerPCCPU *cpu, sPAPRMachin=
eState *spapr,
                            target_ulong opcode, target_ulong *args)
 {
     CPUState *cs =3D CPU(cpu);
-    ICPState *icp =3D &spapr->xics->ss[cs->cpu_index];
+    ICPState *icp =3D xics_icp_get(XICS_INTERFACE(spapr), cs->cpu_index)=
;
     uint32_t xirr =3D icp_accept(icp);
=20
     args[0] =3D xirr;
@@ -80,7 +81,7 @@ static target_ulong h_xirr_x(PowerPCCPU *cpu, sPAPRMach=
ineState *spapr,
                              target_ulong opcode, target_ulong *args)
 {
     CPUState *cs =3D CPU(cpu);
-    ICPState *icp =3D &spapr->xics->ss[cs->cpu_index];
+    ICPState *icp =3D xics_icp_get(XICS_INTERFACE(spapr), cs->cpu_index)=
;
     uint32_t xirr =3D icp_accept(icp);
=20
     args[0] =3D xirr;
@@ -92,7 +93,7 @@ static target_ulong h_eoi(PowerPCCPU *cpu, sPAPRMachine=
State *spapr,
                           target_ulong opcode, target_ulong *args)
 {
     CPUState *cs =3D CPU(cpu);
-    ICPState *icp =3D &spapr->xics->ss[cs->cpu_index];
+    ICPState *icp =3D xics_icp_get(XICS_INTERFACE(spapr), cs->cpu_index)=
;
     target_ulong xirr =3D args[0];
=20
     icp_eoi(icp, xirr);
@@ -103,7 +104,7 @@ static target_ulong h_ipoll(PowerPCCPU *cpu, sPAPRMac=
hineState *spapr,
                             target_ulong opcode, target_ulong *args)
 {
     CPUState *cs =3D CPU(cpu);
-    ICPState *icp =3D &spapr->xics->ss[cs->cpu_index];
+    ICPState *icp =3D xics_icp_get(XICS_INTERFACE(spapr), cs->cpu_index)=
;
     uint32_t mfrr;
     uint32_t xirr =3D icp_ipoll(icp, &mfrr);
=20
@@ -134,7 +135,7 @@ static void rtas_set_xive(PowerPCCPU *cpu, sPAPRMachi=
neState *spapr,
     server =3D xics_get_cpu_index_by_dt_id(rtas_ld(args, 1));
     priority =3D rtas_ld(args, 2);
=20
-    if (!ics_valid_irq(ics, nr) || (server >=3D ics->xics->nr_servers)
+    if (!ics_valid_irq(ics, nr) || !xics_icp_get(XICS_INTERFACE(spapr), =
server)
         || (priority > 0xff)) {
         rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
         return;
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 55cd0456ebe8..2c289a6c72e2 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -42,7 +42,7 @@ static void spapr_cpu_destroy(PowerPCCPU *cpu)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
=20
-    xics_cpu_destroy(spapr->xics, cpu);
+    xics_cpu_destroy(XICS_INTERFACE(spapr), cpu);
     qemu_unregister_reset(spapr_cpu_reset, cpu);
 }
=20
@@ -76,7 +76,7 @@ static void spapr_cpu_init(sPAPRMachineState *spapr, Po=
werPCCPU *cpu,
             cs->numa_node =3D i;
     }
=20
-    xics_cpu_setup(spapr->xics, cpu);
+    xics_cpu_setup(XICS_INTERFACE(spapr), cpu);
=20
     qemu_register_reset(spapr_cpu_reset, cpu);
     spapr_cpu_reset(cpu);
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 0375d7d481ef..498f187c0dd2 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -197,16 +197,16 @@ typedef struct XICSInterfaceClass {
=20
 #define XICS_IRQS_SPAPR               1024
=20
-qemu_irq xics_get_qirq(XICSInterface *xi, int irq);
-
 int spapr_ics_alloc(ICSState *ics, int irq_hint, bool lsi, Error **errp)=
;
 int spapr_ics_alloc_block(ICSState *ics, int num, bool lsi, bool align,
                            Error **errp);
 void spapr_ics_free(ICSState *ics, int irq, int num);
 void spapr_dt_xics(XICSState *xics, void *fdt, uint32_t phandle);
=20
-void xics_cpu_setup(XICSState *icp, PowerPCCPU *cpu);
-void xics_cpu_destroy(XICSState *icp, PowerPCCPU *cpu);
+qemu_irq xics_get_qirq(XICSInterface *xi, int irq);
+ICPState *xics_icp_get(XICSInterface *xi, int server);
+void xics_cpu_setup(XICSInterface *xi, PowerPCCPU *cpu);
+void xics_cpu_destroy(XICSInterface *xi, PowerPCCPU *cpu);
=20
 /* Internal XICS interfaces */
 int xics_get_cpu_index_by_dt_id(int cpu_dt_id);
--=20
2.7.4
