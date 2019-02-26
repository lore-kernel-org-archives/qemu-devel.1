Received: from eggs.gnu.org ([209.51.188.92]:58110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUlH-0005PB-ID
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUlF-0002u3-I7
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:35 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:52:49 +1100
Message-Id: <20190226045304.25618-36-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 35/50] spapr: Expose the name of the interrupt
 controller node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

This will be needed by PHB hotplug in order to access the "phandle"
property of the interrupt controller node.

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <155059668867.1466090.6339199751719123386.stgit@bahia.lab.tou=
louse-stg.fr.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive.c        |  9 ++++-----
 hw/intc/xics_spapr.c        |  2 +-
 hw/ppc/spapr_irq.c          | 21 ++++++++++++++++++++-
 include/hw/ppc/spapr_irq.h  |  1 +
 include/hw/ppc/spapr_xive.h |  3 +++
 include/hw/ppc/xics_spapr.h |  2 ++
 6 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 290a290e43..06e3c9fdbf 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -317,6 +317,9 @@ static void spapr_xive_realize(DeviceState *dev, Erro=
r **errp)
     /* Map all regions */
     spapr_xive_map_mmio(xive);
=20
+    xive->nodename =3D g_strdup_printf("interrupt-controller@%" PRIx64,
+                           xive->tm_base + XIVE_TM_USER_PAGE * (1 << TM_=
SHIFT));
+
     qemu_register_reset(spapr_xive_reset, dev);
 }
=20
@@ -1448,7 +1451,6 @@ void spapr_dt_xive(sPAPRMachineState *spapr, uint32=
_t nr_servers, void *fdt,
         cpu_to_be32(7),    /* start */
         cpu_to_be32(0xf8), /* count */
     };
-    gchar *nodename;
=20
     /* Thread Interrupt Management Area : User (ring 3) and OS (ring 2) =
*/
     timas[0] =3D cpu_to_be64(xive->tm_base +
@@ -1458,10 +1460,7 @@ void spapr_dt_xive(sPAPRMachineState *spapr, uint3=
2_t nr_servers, void *fdt,
                            XIVE_TM_OS_PAGE * (1ull << TM_SHIFT));
     timas[3] =3D cpu_to_be64(1ull << TM_SHIFT);
=20
-    nodename =3D g_strdup_printf("interrupt-controller@%" PRIx64,
-                           xive->tm_base + XIVE_TM_USER_PAGE * (1 << TM_=
SHIFT));
-    _FDT(node =3D fdt_add_subnode(fdt, 0, nodename));
-    g_free(nodename);
+    _FDT(node =3D fdt_add_subnode(fdt, 0, xive->nodename));
=20
     _FDT(fdt_setprop_string(fdt, node, "device_type", "power-ivpe"));
     _FDT(fdt_setprop(fdt, node, "reg", timas, sizeof(timas)));
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index e2d8b38183..53bda6661b 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -254,7 +254,7 @@ void spapr_dt_xics(sPAPRMachineState *spapr, uint32_t=
 nr_servers, void *fdt,
     };
     int node;
=20
-    _FDT(node =3D fdt_add_subnode(fdt, 0, "interrupt-controller"));
+    _FDT(node =3D fdt_add_subnode(fdt, 0, XICS_NODENAME));
=20
     _FDT(fdt_setprop_string(fdt, node, "device_type",
                             "PowerPC-External-Interrupt-Presentation"));
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 4297eed600..359761494c 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -230,6 +230,11 @@ static void spapr_irq_reset_xics(sPAPRMachineState *=
spapr, Error **errp)
     /* TODO: create the KVM XICS device */
 }
=20
+static const char *spapr_irq_get_nodename_xics(sPAPRMachineState *spapr)
+{
+    return XICS_NODENAME;
+}
+
 #define SPAPR_IRQ_XICS_NR_IRQS     0x1000
 #define SPAPR_IRQ_XICS_NR_MSIS     \
     (XICS_IRQ_BASE + SPAPR_IRQ_XICS_NR_IRQS - SPAPR_IRQ_MSI)
@@ -249,6 +254,7 @@ sPAPRIrq spapr_irq_xics =3D {
     .post_load   =3D spapr_irq_post_load_xics,
     .reset       =3D spapr_irq_reset_xics,
     .set_irq     =3D spapr_irq_set_irq_xics,
+    .get_nodename =3D spapr_irq_get_nodename_xics,
 };
=20
 /*
@@ -384,6 +390,11 @@ static void spapr_irq_set_irq_xive(void *opaque, int=
 srcno, int val)
     xive_source_set_irq(&spapr->xive->source, srcno, val);
 }
=20
+static const char *spapr_irq_get_nodename_xive(sPAPRMachineState *spapr)
+{
+    return spapr->xive->nodename;
+}
+
 /*
  * XIVE uses the full IRQ number space. Set it to 8K to be compatible
  * with XICS.
@@ -407,6 +418,7 @@ sPAPRIrq spapr_irq_xive =3D {
     .post_load   =3D spapr_irq_post_load_xive,
     .reset       =3D spapr_irq_reset_xive,
     .set_irq     =3D spapr_irq_set_irq_xive,
+    .get_nodename =3D spapr_irq_get_nodename_xive,
 };
=20
 /*
@@ -541,6 +553,11 @@ static void spapr_irq_set_irq_dual(void *opaque, int=
 srcno, int val)
     spapr_irq_current(spapr)->set_irq(spapr, srcno, val);
 }
=20
+static const char *spapr_irq_get_nodename_dual(sPAPRMachineState *spapr)
+{
+    return spapr_irq_current(spapr)->get_nodename(spapr);
+}
+
 /*
  * Define values in sync with the XIVE and XICS backend
  */
@@ -561,7 +578,8 @@ sPAPRIrq spapr_irq_dual =3D {
     .cpu_intc_create =3D spapr_irq_cpu_intc_create_dual,
     .post_load   =3D spapr_irq_post_load_dual,
     .reset       =3D spapr_irq_reset_dual,
-    .set_irq     =3D spapr_irq_set_irq_dual
+    .set_irq     =3D spapr_irq_set_irq_dual,
+    .get_nodename =3D spapr_irq_get_nodename_dual,
 };
=20
 /*
@@ -691,4 +709,5 @@ sPAPRIrq spapr_irq_xics_legacy =3D {
     .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
     .post_load   =3D spapr_irq_post_load_xics,
     .set_irq     =3D spapr_irq_set_irq_xics,
+    .get_nodename =3D spapr_irq_get_nodename_xics,
 };
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 488511c3d8..8bf1a72919 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -47,6 +47,7 @@ typedef struct sPAPRIrq {
     int (*post_load)(sPAPRMachineState *spapr, int version_id);
     void (*reset)(sPAPRMachineState *spapr, Error **errp);
     void (*set_irq)(void *opaque, int srcno, int val);
+    const char *(*get_nodename)(sPAPRMachineState *spapr);
 } sPAPRIrq;
=20
 extern sPAPRIrq spapr_irq_xics;
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 9bec9192e4..2d31f24e3b 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -26,6 +26,9 @@ typedef struct sPAPRXive {
     XiveENDSource end_source;
     hwaddr        end_base;
=20
+    /* DT */
+    gchar *nodename;
+
     /* Routing table */
     XiveEAS       *eat;
     uint32_t      nr_irqs;
diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
index b1ab27d022..b8d924baf4 100644
--- a/include/hw/ppc/xics_spapr.h
+++ b/include/hw/ppc/xics_spapr.h
@@ -29,6 +29,8 @@
=20
 #include "hw/ppc/spapr.h"
=20
+#define XICS_NODENAME "interrupt-controller"
+
 void spapr_dt_xics(sPAPRMachineState *spapr, uint32_t nr_servers, void *=
fdt,
                    uint32_t phandle);
 int xics_kvm_init(sPAPRMachineState *spapr, Error **errp);
--=20
2.20.1
