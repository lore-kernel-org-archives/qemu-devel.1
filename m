Received: from eggs.gnu.org ([2001:4830:134:3::10]:46697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gaEPJ-0007aY-2L
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 01:35:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gaEPF-00048D-ST
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 01:35:37 -0500
Received: from 9.mo179.mail-out.ovh.net ([46.105.76.148]:39983)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gaEPF-000477-GZ
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 01:35:33 -0500
Received: from player798.ha.ovh.net (unknown [10.109.143.3])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 26A6E10EB84
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 07:35:32 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 21 Dec 2018 07:35:14 +0100
Message-ID: <154537411408.891668.13796612948399384908.stgit@bahia.lan>
In-Reply-To: <154535246529.862554.6113740443866753456.stgit@bahia.lan>
References: <154535246529.862554.6113740443866753456.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 14/15] spapr: Expose the name of the interrupt
 controller node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>

This will be needed by PHB hotplug in order to access the phandle property.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/spapr_xive.c        |    9 +++++++--
 hw/intc/xics_spapr.c        |    9 ++++++++-
 hw/ppc/spapr_irq.c          |    3 +++
 include/hw/ppc/spapr_irq.h  |    1 +
 include/hw/ppc/spapr_xive.h |    1 +
 include/hw/ppc/xics.h       |    1 +
 6 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 87424de26c1c..0540aac88d2a 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -1410,6 +1410,12 @@ void spapr_xive_hcall_init(sPAPRMachineState *spapr)
     spapr_register_hypercall(H_INT_RESET, h_int_reset);
 }
 
+gchar *spapr_xive_get_nodename(sPAPRMachineState *spapr)
+{
+    return g_strdup_printf("interrupt-controller@%" PRIx64,
+                    spapr->xive->tm_base + XIVE_TM_USER_PAGE * (1 << TM_SHIFT));
+}
+
 void spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void *fdt,
                    uint32_t phandle)
 {
@@ -1444,8 +1450,7 @@ void spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void *fdt,
                            XIVE_TM_OS_PAGE * (1ull << TM_SHIFT));
     timas[3] = cpu_to_be64(1ull << TM_SHIFT);
 
-    nodename = g_strdup_printf("interrupt-controller@%" PRIx64,
-                           xive->tm_base + XIVE_TM_USER_PAGE * (1 << TM_SHIFT));
+    nodename = spapr_xive_get_nodename(spapr);
     _FDT(node = fdt_add_subnode(fdt, 0, nodename));
     g_free(nodename);
 
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index f67d3c80bf3a..75d40daf518d 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -244,6 +244,13 @@ void xics_spapr_init(sPAPRMachineState *spapr)
     spapr_register_hypercall(H_IPOLL, h_ipoll);
 }
 
+#define NODENAME "interrupt-controller"
+
+gchar *spapr_xics_get_nodename(sPAPRMachineState *spapr)
+{
+    return g_strdup(NODENAME);
+}
+
 void spapr_dt_xics(sPAPRMachineState *spapr, uint32_t nr_servers, void *fdt,
                    uint32_t phandle)
 {
@@ -252,7 +259,7 @@ void spapr_dt_xics(sPAPRMachineState *spapr, uint32_t nr_servers, void *fdt,
     };
     int node;
 
-    _FDT(node = fdt_add_subnode(fdt, 0, "interrupt-controller"));
+    _FDT(node = fdt_add_subnode(fdt, 0, NODENAME));
 
     _FDT(fdt_setprop_string(fdt, node, "device_type",
                             "PowerPC-External-Interrupt-Presentation"));
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 0999a2b2d69c..703c3a3c20d5 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -223,6 +223,7 @@ sPAPRIrq spapr_irq_xics = {
     .qirq        = spapr_qirq_xics,
     .print_info  = spapr_irq_print_info_xics,
     .dt_populate = spapr_dt_xics,
+    .get_nodename = spapr_xics_get_nodename,
     .cpu_intc_create = spapr_irq_cpu_intc_create_xics,
     .post_load   = spapr_irq_post_load_xics,
 };
@@ -349,6 +350,7 @@ sPAPRIrq spapr_irq_xive = {
     .qirq        = spapr_qirq_xive,
     .print_info  = spapr_irq_print_info_xive,
     .dt_populate = spapr_dt_xive,
+    .get_nodename = spapr_xive_get_nodename,
     .cpu_intc_create = spapr_irq_cpu_intc_create_xive,
     .post_load   = spapr_irq_post_load_xive,
     .reset       = spapr_irq_reset_xive,
@@ -462,6 +464,7 @@ sPAPRIrq spapr_irq_xics_legacy = {
     .qirq        = spapr_qirq_xics,
     .print_info  = spapr_irq_print_info_xics,
     .dt_populate = spapr_dt_xics,
+    .get_nodename = spapr_xics_get_nodename,
     .cpu_intc_create = spapr_irq_cpu_intc_create_xics,
     .post_load   = spapr_irq_post_load_xics,
 };
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index b34d5a00381b..59a1cf8bbc1d 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -42,6 +42,7 @@ typedef struct sPAPRIrq {
     void (*print_info)(sPAPRMachineState *spapr, Monitor *mon);
     void (*dt_populate)(sPAPRMachineState *spapr, uint32_t nr_servers,
                         void *fdt, uint32_t phandle);
+    gchar *(*get_nodename)(sPAPRMachineState *spapr);
     Object *(*cpu_intc_create)(sPAPRMachineState *spapr, Object *cpu,
                                Error **errp);
     int (*post_load)(sPAPRMachineState *spapr, int version_id);
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 728735dbcfbe..d280310ed587 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -47,6 +47,7 @@ typedef struct sPAPRMachineState sPAPRMachineState;
 void spapr_xive_hcall_init(sPAPRMachineState *spapr);
 void spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void *fdt,
                    uint32_t phandle);
+gchar *spapr_xive_get_nodename(sPAPRMachineState *spapr);
 void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx);
 
 #endif /* PPC_SPAPR_XIVE_H */
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 14afda198cdb..eafb6428787f 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -204,6 +204,7 @@ typedef struct sPAPRMachineState sPAPRMachineState;
 
 void spapr_dt_xics(sPAPRMachineState *spapr, uint32_t nr_servers, void *fdt,
                    uint32_t phandle);
+gchar *spapr_xics_get_nodename(sPAPRMachineState *spapr);
 int xics_kvm_init(sPAPRMachineState *spapr, Error **errp);
 void xics_spapr_init(sPAPRMachineState *spapr);
 
