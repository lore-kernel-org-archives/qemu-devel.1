Received: from eggs.gnu.org ([2001:4830:134:3::10]:38805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciMLm-0002rZ-0d
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:32:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciMLi-0008D1-0V
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:32:30 -0500
Received: from 19.mo6.mail-out.ovh.net ([188.165.56.177]:58928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ciMLh-0008CU-Nl
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:32:25 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id BC294A7B9D
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 15:32:21 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 27 Feb 2017 15:29:25 +0100
Message-Id: <1488205773-30436-19-git-send-email-clg@kaod.org>
In-Reply-To: <1488205773-30436-1-git-send-email-clg@kaod.org>
References: <1488205773-30436-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 18/26] ppc/xics: use the QOM interface to
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

 Changes since v3:

 - changed ICSState 'xics' backlink to be a XICSFabric.

 hw/intc/xics.c          | 32 ++++++++++++++++++--------------
 hw/intc/xics_spapr.c    | 17 +++++++++--------
 hw/ppc/spapr.c          |  2 +-
 hw/ppc/spapr_cpu_core.c |  4 ++--
 include/hw/ppc/xics.h   | 10 +++++-----
 5 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 674ac4c91b77..ddb0a6f48b5c 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -49,26 +49,26 @@ int xics_get_cpu_index_by_dt_id(int cpu_dt_id)
     return -1;
 }
=20
-void xics_cpu_destroy(XICSState *xics, PowerPCCPU *cpu)
+void xics_cpu_destroy(XICSFabric *xi, PowerPCCPU *cpu)
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
+void xics_cpu_setup(XICSFabric *xi, PowerPCCPU *cpu)
 {
     CPUState *cs =3D CPU(cpu);
     CPUPPCState *env =3D &cpu->env;
-    ICPState *ss =3D &xics->ss[cs->cpu_index];
+    ICPState *ss =3D xics_icp_get(xi, cs->cpu_index);
     ICPStateClass *icpc;
=20
-    assert(cs->cpu_index < xics->nr_servers);
+    assert(ss);
=20
     ss->cs =3D cs;
=20
@@ -308,8 +308,7 @@ void icp_eoi(ICPState *ss, uint32_t xirr)
=20
 static void icp_irq(ICSState *ics, int server, int nr, uint8_t priority)
 {
-    XICSState *xics =3D ics->xics;
-    ICPState *ss =3D xics->ss + server;
+    ICPState *ss =3D xics_icp_get(ics->xics, server);
=20
     trace_xics_icp_irq(server, nr, priority);
=20
@@ -582,12 +581,10 @@ static void ics_simple_reset(DeviceState *dev)
=20
 static int ics_simple_post_load(ICSState *ics, int version_id)
 {
-    int i;
-
-    for (i =3D 0; i < ics->xics->nr_servers; i++) {
-        icp_resend(&ics->xics->ss[i]);
-    }
+    XICSFabric *xi =3D ics->xics;
+    XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(xi);
=20
+    xic->icp_resend(xi);
     return 0;
 }
=20
@@ -711,7 +708,7 @@ static void ics_base_realize(DeviceState *dev, Error =
**errp)
                    __func__, error_get_pretty(err));
         return;
     }
-    ics->xics =3D XICS_COMMON(obj);
+    ics->xics =3D XICS_FABRIC(obj);
=20
=20
     if (icsc->realize) {
@@ -756,6 +753,13 @@ qemu_irq xics_get_qirq(XICSFabric *xi, int irq)
     return NULL;
 }
=20
+ICPState *xics_icp_get(XICSFabric *xi, int server)
+{
+    XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(xi);
+
+    return xic->icp_get(xi, server);
+}
+
 void ics_set_irq_type(ICSState *ics, int srcno, bool lsi)
 {
     assert(!(ics->irqs[srcno].flags & XICS_FLAGS_IRQ_MASK));
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 1501e796e5e0..bc62b0ccc254 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -44,7 +44,7 @@ static target_ulong h_cppr(PowerPCCPU *cpu, sPAPRMachin=
eState *spapr,
                            target_ulong opcode, target_ulong *args)
 {
     CPUState *cs =3D CPU(cpu);
-    ICPState *icp =3D &spapr->xics->ss[cs->cpu_index];
+    ICPState *icp =3D xics_icp_get(XICS_FABRIC(spapr), cs->cpu_index);
     target_ulong cppr =3D args[0];
=20
     icp_set_cppr(icp, cppr);
@@ -56,12 +56,13 @@ static target_ulong h_ipi(PowerPCCPU *cpu, sPAPRMachi=
neState *spapr,
 {
     target_ulong server =3D xics_get_cpu_index_by_dt_id(args[0]);
     target_ulong mfrr =3D args[1];
+    ICPState *icp =3D xics_icp_get(XICS_FABRIC(spapr), server);
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
+    ICPState *icp =3D xics_icp_get(XICS_FABRIC(spapr), cs->cpu_index);
     uint32_t xirr =3D icp_accept(icp);
=20
     args[0] =3D xirr;
@@ -80,7 +81,7 @@ static target_ulong h_xirr_x(PowerPCCPU *cpu, sPAPRMach=
ineState *spapr,
                              target_ulong opcode, target_ulong *args)
 {
     CPUState *cs =3D CPU(cpu);
-    ICPState *icp =3D &spapr->xics->ss[cs->cpu_index];
+    ICPState *icp =3D xics_icp_get(XICS_FABRIC(spapr), cs->cpu_index);
     uint32_t xirr =3D icp_accept(icp);
=20
     args[0] =3D xirr;
@@ -92,7 +93,7 @@ static target_ulong h_eoi(PowerPCCPU *cpu, sPAPRMachine=
State *spapr,
                           target_ulong opcode, target_ulong *args)
 {
     CPUState *cs =3D CPU(cpu);
-    ICPState *icp =3D &spapr->xics->ss[cs->cpu_index];
+    ICPState *icp =3D xics_icp_get(XICS_FABRIC(spapr), cs->cpu_index);
     target_ulong xirr =3D args[0];
=20
     icp_eoi(icp, xirr);
@@ -103,7 +104,7 @@ static target_ulong h_ipoll(PowerPCCPU *cpu, sPAPRMac=
hineState *spapr,
                             target_ulong opcode, target_ulong *args)
 {
     CPUState *cs =3D CPU(cpu);
-    ICPState *icp =3D &spapr->xics->ss[cs->cpu_index];
+    ICPState *icp =3D xics_icp_get(XICS_FABRIC(spapr), cs->cpu_index);
     uint32_t mfrr;
     uint32_t xirr =3D icp_ipoll(icp, &mfrr);
=20
@@ -134,7 +135,7 @@ static void rtas_set_xive(PowerPCCPU *cpu, sPAPRMachi=
neState *spapr,
     server =3D xics_get_cpu_index_by_dt_id(rtas_ld(args, 1));
     priority =3D rtas_ld(args, 2);
=20
-    if (!ics_valid_irq(ics, nr) || (server >=3D ics->xics->nr_servers)
+    if (!ics_valid_irq(ics, nr) || !xics_icp_get(XICS_FABRIC(spapr), ser=
ver)
         || (priority > 0xff)) {
         rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
         return;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 7273157ad50e..309b9ff91563 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -117,7 +117,7 @@ static XICSState *try_create_xics(sPAPRMachineState *=
spapr,
     qdev_set_parent_bus(DEVICE(ics), sysbus_get_default());
     object_property_add_child(OBJECT(spapr), "ics", OBJECT(ics), NULL);
     object_property_set_int(OBJECT(ics), nr_irqs, "nr-irqs", &err);
-    object_property_add_const_link(OBJECT(ics), "xics", OBJECT(xics), NU=
LL);
+    object_property_add_const_link(OBJECT(ics), "xics", OBJECT(xi), NULL=
);
     object_property_set_bool(OBJECT(ics), true, "realized", &local_err);
     error_propagate(&err, local_err);
     if (err) {
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 55cd0456ebe8..befe53a65863 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -42,7 +42,7 @@ static void spapr_cpu_destroy(PowerPCCPU *cpu)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
=20
-    xics_cpu_destroy(spapr->xics, cpu);
+    xics_cpu_destroy(XICS_FABRIC(spapr), cpu);
     qemu_unregister_reset(spapr_cpu_reset, cpu);
 }
=20
@@ -76,7 +76,7 @@ static void spapr_cpu_init(sPAPRMachineState *spapr, Po=
werPCCPU *cpu,
             cs->numa_node =3D i;
     }
=20
-    xics_cpu_setup(spapr->xics, cpu);
+    xics_cpu_setup(XICS_FABRIC(spapr), cpu);
=20
     qemu_register_reset(spapr_cpu_reset, cpu);
     spapr_cpu_reset(cpu);
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index d17f62c5cc82..c57e80e4187b 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -151,7 +151,7 @@ struct ICSState {
     uint32_t offset;
     qemu_irq *qirqs;
     ICSIRQState *irqs;
-    XICSState *xics;
+    XICSFabric *xics;
 };
=20
 static inline bool ics_valid_irq(ICSState *ics, uint32_t nr)
@@ -198,16 +198,16 @@ typedef struct XICSFabricClass {
=20
 #define XICS_IRQS_SPAPR               1024
=20
-qemu_irq xics_get_qirq(XICSFabric *xi, int irq);
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
+qemu_irq xics_get_qirq(XICSFabric *xi, int irq);
+ICPState *xics_icp_get(XICSFabric *xi, int server);
+void xics_cpu_setup(XICSFabric *xi, PowerPCCPU *cpu);
+void xics_cpu_destroy(XICSFabric *xi, PowerPCCPU *cpu);
=20
 /* Internal XICS interfaces */
 int xics_get_cpu_index_by_dt_id(int cpu_dt_id);
--=20
2.7.4
