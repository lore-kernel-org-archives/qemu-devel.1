Received: from eggs.gnu.org ([209.51.188.92]:58471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh09H-0006QE-Sy
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:47:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh09H-00074Y-0g
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:47:03 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  9 Jan 2019 09:45:52 +1100
Message-Id: <20190108224600.23125-22-david@gibson.dropbear.id.au>
In-Reply-To: <20190108224600.23125-1-david@gibson.dropbear.id.au>
References: <20190108224600.23125-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 21/29] ppc/xive: introduce a XiveTCTX pointer
 under PowerPCCPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

which will be used by the machine only when the XIVE interrupt mode is
in use.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xive.c          | 6 +++---
 hw/ppc/spapr_cpu_core.c | 7 ++++++-
 hw/ppc/spapr_irq.c      | 8 ++++----
 target/ppc/cpu.h        | 2 ++
 4 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index ea33494338..410c53278a 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -321,7 +321,7 @@ static void xive_tm_write(void *opaque, hwaddr offset=
,
                           uint64_t value, unsigned size)
 {
     PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
-    XiveTCTX *tctx =3D XIVE_TCTX(cpu->intc);
+    XiveTCTX *tctx =3D cpu->tctx;
     const XiveTmOp *xto;
=20
     /*
@@ -360,7 +360,7 @@ static void xive_tm_write(void *opaque, hwaddr offset=
,
 static uint64_t xive_tm_read(void *opaque, hwaddr offset, unsigned size)
 {
     PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
-    XiveTCTX *tctx =3D XIVE_TCTX(cpu->intc);
+    XiveTCTX *tctx =3D cpu->tctx;
     const XiveTmOp *xto;
=20
     /*
@@ -1186,7 +1186,7 @@ static bool xive_presenter_match(XiveRouter *xrtr, =
uint8_t format,
=20
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu =3D POWERPC_CPU(cs);
-        XiveTCTX *tctx =3D XIVE_TCTX(cpu->intc);
+        XiveTCTX *tctx =3D cpu->tctx;
         int ring;
=20
         /*
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 2739b2a4b8..1473ef8533 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -194,7 +194,12 @@ static void spapr_unrealize_vcpu(PowerPCCPU *cpu, sP=
APRCPUCore *sc)
         vmstate_unregister(NULL, &vmstate_spapr_cpu_state, cpu->machine_=
data);
     }
     qemu_unregister_reset(spapr_cpu_reset, cpu);
-    object_unparent(cpu->intc);
+    if (cpu->intc) {
+        object_unparent(cpu->intc);
+    }
+    if (cpu->tctx) {
+        object_unparent(OBJECT(cpu->tctx));
+    }
     cpu_remove_sync(CPU(cpu));
     object_unparent(OBJECT(cpu));
 }
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index eca2317cf3..598b91a808 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -315,7 +315,7 @@ static void spapr_irq_print_info_xive(sPAPRMachineSta=
te *spapr,
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu =3D POWERPC_CPU(cs);
=20
-        xive_tctx_pic_print_info(XIVE_TCTX(cpu->intc), mon);
+        xive_tctx_pic_print_info(cpu->tctx, mon);
     }
=20
     spapr_xive_pic_print_info(spapr->xive, mon);
@@ -333,13 +333,13 @@ static void spapr_irq_cpu_intc_create_xive(sPAPRMac=
hineState *spapr,
         return;
     }
=20
-    cpu->intc =3D obj;
+    cpu->tctx =3D XIVE_TCTX(obj);
=20
     /*
      * (TCG) Early setting the OS CAM line for hotplugged CPUs as they
      * don't beneficiate from the reset of the XIVE IRQ backend
      */
-    spapr_xive_set_tctx_os_cam(XIVE_TCTX(obj));
+    spapr_xive_set_tctx_os_cam(cpu->tctx);
 }
=20
 static int spapr_irq_post_load_xive(sPAPRMachineState *spapr, int versio=
n_id)
@@ -355,7 +355,7 @@ static void spapr_irq_reset_xive(sPAPRMachineState *s=
papr, Error **errp)
         PowerPCCPU *cpu =3D POWERPC_CPU(cs);
=20
         /* (TCG) Set the OS CAM line of the thread interrupt context. */
-        spapr_xive_set_tctx_os_cam(XIVE_TCTX(cpu->intc));
+        spapr_xive_set_tctx_os_cam(cpu->tctx);
     }
 }
=20
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 91951d7730..64e94fd83c 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1177,6 +1177,7 @@ do {                                            \
=20
 typedef struct PPCVirtualHypervisor PPCVirtualHypervisor;
 typedef struct PPCVirtualHypervisorClass PPCVirtualHypervisorClass;
+typedef struct XiveTCTX XiveTCTX;
=20
 /**
  * PowerPCCPU:
@@ -1196,6 +1197,7 @@ struct PowerPCCPU {
     uint32_t compat_pvr;
     PPCVirtualHypervisor *vhyp;
     Object *intc;
+    XiveTCTX *tctx;
     void *machine_data;
     int32_t node_id; /* NUMA node this CPU belongs to */
     PPCHash64Options *hash64_opts;
--=20
2.20.1
