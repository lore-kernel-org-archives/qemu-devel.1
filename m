Received: from eggs.gnu.org ([209.51.188.92]:37783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gkBH0-00036p-D5
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:16:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gkBGy-0001DA-VE
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:16:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34764
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gkBGy-0001Bk-Ot
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:16:08 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0HHESON017183
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 12:16:08 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q2whj97y8-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 12:16:07 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 17 Jan 2019 17:16:05 -0000
From: Greg Kurz <groug@kaod.org>
Date: Thu, 17 Jan 2019 18:15:58 +0100
In-Reply-To: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
References: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <154774535838.1208625.13126682782876422159.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH v3 14/19] spapr: Factor out setting of
 "phandle" DT property to sPAPR irq frontend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Greg Kurz <groug@kaod.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>

The setting of the "phandle" and "linux,phandle" properties of the
interrupt controller node is duplicate code in XICS and XIVE. Move
it to a new spapr_irq_dt_populate() function.

Note that for XIVE, we set the "ibm,plat-res-int-priorities" machine
property earlier so that the offset returned by fdt_add_subnode()
can be safely returned to the caller.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/spapr_xive.c        |   21 +++++++++------------
 hw/intc/xics_spapr.c        |    7 +++----
 hw/ppc/spapr.c              |    2 +-
 hw/ppc/spapr_irq.c          |   17 +++++++++++++----
 include/hw/ppc/spapr_irq.h  |    6 ++++--
 include/hw/ppc/spapr_xive.h |    3 +--
 include/hw/ppc/xics_spapr.h |    3 +--
 7 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index aab63cfd1178..e542ae59d7fd 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -1411,8 +1411,7 @@ void spapr_xive_hcall_init(sPAPRMachineState *spapr)
     spapr_register_hypercall(H_INT_RESET, h_int_reset);
 }
 
-void spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void *fdt,
-                   uint32_t phandle)
+int spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void *fdt)
 {
     sPAPRXive *xive = spapr->xive;
     int node;
@@ -1439,6 +1438,13 @@ void spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void *fdt,
     };
     gchar *nodename;
 
+    /*
+     * The "ibm,plat-res-int-priorities" property defines the priority
+     * ranges reserved by the hypervisor
+     */
+    _FDT(fdt_setprop(fdt, 0, "ibm,plat-res-int-priorities",
+                     plat_res_int_priorities, sizeof(plat_res_int_priorities)));
+
     /* Thread Interrupt Management Area : User (ring 3) and OS (ring 2) */
     timas[0] = cpu_to_be64(xive->tm_base +
                            XIVE_TM_USER_PAGE * (1ull << TM_SHIFT));
@@ -1465,14 +1471,5 @@ void spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void *fdt,
     _FDT(fdt_setprop(fdt, node, "interrupt-controller", NULL, 0));
     _FDT(fdt_setprop_cell(fdt, node, "#interrupt-cells", 2));
 
-    /* For SLOF */
-    _FDT(fdt_setprop_cell(fdt, node, "linux,phandle", phandle));
-    _FDT(fdt_setprop_cell(fdt, node, "phandle", phandle));
-
-    /*
-     * The "ibm,plat-res-int-priorities" property defines the priority
-     * ranges reserved by the hypervisor
-     */
-    _FDT(fdt_setprop(fdt, 0, "ibm,plat-res-int-priorities",
-                     plat_res_int_priorities, sizeof(plat_res_int_priorities)));
+    return node;
 }
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index de6cc15b6474..375cb883c86d 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -245,8 +245,7 @@ void xics_spapr_init(sPAPRMachineState *spapr)
     spapr_register_hypercall(H_IPOLL, h_ipoll);
 }
 
-void spapr_dt_xics(sPAPRMachineState *spapr, uint32_t nr_servers, void *fdt,
-                   uint32_t phandle)
+int spapr_dt_xics(sPAPRMachineState *spapr, uint32_t nr_servers, void *fdt)
 {
     uint32_t interrupt_server_ranges_prop[] = {
         0, cpu_to_be32(nr_servers),
@@ -263,6 +262,6 @@ void spapr_dt_xics(sPAPRMachineState *spapr, uint32_t nr_servers, void *fdt,
                      interrupt_server_ranges_prop,
                      sizeof(interrupt_server_ranges_prop)));
     _FDT(fdt_setprop_cell(fdt, node, "#interrupt-cells", 2));
-    _FDT(fdt_setprop_cell(fdt, node, "linux,phandle", phandle));
-    _FDT(fdt_setprop_cell(fdt, node, "phandle", phandle));
+
+    return node;
 }
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 2c8d0c0e149c..135136b4cf5f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1275,7 +1275,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spapr,
     _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
 
     /* /interrupt controller */
-    spapr->irq->dt_populate(spapr, spapr_max_server_number(spapr), fdt,
+    spapr_irq_dt_populate(spapr, spapr_max_server_number(spapr), fdt,
                           PHANDLE_INTC);
 
     ret = spapr_populate_memory(spapr, fdt);
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 396dd09bdbe0..b3e0713428ed 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -11,6 +11,7 @@
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "hw/ppc/fdt.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_xive.h"
 #include "hw/ppc/xics.h"
@@ -536,11 +537,10 @@ static void spapr_irq_print_info_dual(sPAPRMachineState *spapr, Monitor *mon)
     spapr_irq_current(spapr)->print_info(spapr, mon);
 }
 
-static void spapr_irq_dt_populate_dual(sPAPRMachineState *spapr,
-                                       uint32_t nr_servers, void *fdt,
-                                       uint32_t phandle)
+static int spapr_irq_dt_populate_dual(sPAPRMachineState *spapr,
+                                      uint32_t nr_servers, void *fdt)
 {
-    spapr_irq_current(spapr)->dt_populate(spapr, nr_servers, fdt, phandle);
+    return spapr_irq_current(spapr)->dt_populate(spapr, nr_servers, fdt);
 }
 
 static void spapr_irq_cpu_intc_create_dual(sPAPRMachineState *spapr,
@@ -671,6 +671,15 @@ void spapr_irq_reset(sPAPRMachineState *spapr, Error **errp)
     }
 }
 
+void spapr_irq_dt_populate(sPAPRMachineState *spapr, uint32_t nr_servers,
+                           void *fdt, uint32_t phandle)
+{
+    int node = spapr->irq->dt_populate(spapr, nr_servers, fdt);
+
+    _FDT(fdt_setprop_cell(fdt, node, "linux,phandle", phandle));
+    _FDT(fdt_setprop_cell(fdt, node, "phandle", phandle));
+}
+
 /*
  * XICS legacy routines - to deprecate one day
  */
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 42b325eb51ba..dfed6b7e9976 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -41,8 +41,8 @@ typedef struct sPAPRIrq {
     void (*free)(sPAPRMachineState *spapr, int irq, int num);
     qemu_irq (*qirq)(sPAPRMachineState *spapr, int irq);
     void (*print_info)(sPAPRMachineState *spapr, Monitor *mon);
-    void (*dt_populate)(sPAPRMachineState *spapr, uint32_t nr_servers,
-                        void *fdt, uint32_t phandle);
+    int (*dt_populate)(sPAPRMachineState *spapr, uint32_t nr_servers,
+                       void *fdt);
     void (*cpu_intc_create)(sPAPRMachineState *spapr, PowerPCCPU *cpu,
                             Error **errp);
     int (*post_load)(sPAPRMachineState *spapr, int version_id);
@@ -63,6 +63,8 @@ void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num);
 qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);
 int spapr_irq_post_load(sPAPRMachineState *spapr, int version_id);
 void spapr_irq_reset(sPAPRMachineState *spapr, Error **errp);
+void spapr_irq_dt_populate(sPAPRMachineState *spapr, uint32_t nr_servers,
+                           void *fdt, uint32_t phandle);
 
 /*
  * XICS legacy routines
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index f8854a4a6a18..29dafead9ba0 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -44,8 +44,7 @@ void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
 typedef struct sPAPRMachineState sPAPRMachineState;
 
 void spapr_xive_hcall_init(sPAPRMachineState *spapr);
-void spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void *fdt,
-                   uint32_t phandle);
+int spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void *fdt);
 void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx);
 void spapr_xive_mmio_set_enabled(sPAPRXive *xive, bool enable);
 
diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
index b1ab27d022cf..9f51f8621f75 100644
--- a/include/hw/ppc/xics_spapr.h
+++ b/include/hw/ppc/xics_spapr.h
@@ -29,8 +29,7 @@
 
 #include "hw/ppc/spapr.h"
 
-void spapr_dt_xics(sPAPRMachineState *spapr, uint32_t nr_servers, void *fdt,
-                   uint32_t phandle);
+int spapr_dt_xics(sPAPRMachineState *spapr, uint32_t nr_servers, void *fdt);
 int xics_kvm_init(sPAPRMachineState *spapr, Error **errp);
 void xics_spapr_init(sPAPRMachineState *spapr);
 
