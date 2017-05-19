Received: from eggs.gnu.org ([2001:4830:134:3::10]:33762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dBfD3-0000f2-Ts
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:32:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dBfD0-0007us-KS
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:32:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47525
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dBfD0-0007ue-F9
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:32:34 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4JAO8tJ171716
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 06:32:33 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ahvaxg1dy-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 06:32:33 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 19 May 2017 06:32:33 -0400
From: Greg Kurz <groug@kaod.org>
Date: Fri, 19 May 2017 12:32:27 +0200
In-Reply-To: <149518991537.24289.6673616934370284758.stgit@bahia.lan>
References: <149518991537.24289.6673616934370284758.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <149518994738.24289.215239362416048889.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH v2 4/4] spapr: fix migration of ICP objects
 from/to older QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Cedric Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

Commit 5bc8d26de20c ("spapr: allocate the ICPState object from under
sPAPRCPUCore") moved ICP objects from the machine to CPU cores. This
is an improvement since we no longer allocate ICP objects that will
never be used. But it has the side-effect of breaking migration of
older machine types from older QEMU versions.

This patch introduces a compat flag in the sPAPR machine class so
that all pseries machine up to 2.9 go on with the previous behavior
of pre-allocating ICP objects.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
v2: - s/void* /void * in xics_system_init()
    - don't use "[*]" in the ICP object name
    - use pre_2_10_ prefix in field names
    - added xics_nr_servers() helper
---
 hw/ppc/spapr.c          |   40 +++++++++++++++++++++++++++++++++++++++-
 hw/ppc/spapr_cpu_core.c |   29 ++++++++++++++++++++---------
 include/hw/ppc/spapr.h  |    2 ++
 3 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1bb05a9a6b07..182262257c60 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -123,9 +123,15 @@ error:
     return NULL;
 }
 
+static inline int xics_nr_servers(void)
+{
+    return ppc_cpu_dt_id_from_index(max_cpus);
+}
+
 static void xics_system_init(MachineState *machine, int nr_irqs, Error **errp)
 {
     sPAPRMachineState *spapr = SPAPR_MACHINE(machine);
+    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
 
     if (kvm_enabled()) {
         if (machine_kernel_irqchip_allowed(machine) &&
@@ -147,6 +153,35 @@ static void xics_system_init(MachineState *machine, int nr_irqs, Error **errp)
             return;
         }
     }
+
+    if (smc->pre_2_10_icp_allocation) {
+        int nr_servers = xics_nr_servers();
+        Error *local_err = NULL;
+        int i;
+
+        spapr->pre_2_10_icps = g_malloc0(nr_servers * sizeof(ICPState));
+
+        for (i = 0; i < nr_servers; i++) {
+            void *obj = &spapr->pre_2_10_icps[i];
+            char *name = g_strdup_printf("icp[%d]", i);
+
+            object_initialize(obj, sizeof(ICPState), spapr->icp_type);
+            object_property_add_child(OBJECT(spapr), name, obj, &error_abort);
+            g_free(name);
+            object_unref(obj);
+            object_property_add_const_link(obj, "xics", OBJECT(spapr),
+                                           &error_abort);
+            object_property_set_bool(obj, true, "realized", &local_err);
+            if (local_err) {
+                while (i--) {
+                    object_unparent(obj);
+                }
+                g_free(spapr->pre_2_10_icps);
+                error_propagate(errp, local_err);
+                break;
+            }
+        }
+    }
 }
 
 static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu,
@@ -1020,7 +1055,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spapr,
     _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
 
     /* /interrupt controller */
-    spapr_dt_xics(ppc_cpu_dt_id_from_index(max_cpus), fdt, PHANDLE_XICP);
+    spapr_dt_xics(xics_nr_servers(), fdt, PHANDLE_XICP);
 
     ret = spapr_populate_memory(spapr, fdt);
     if (ret < 0) {
@@ -3286,9 +3321,12 @@ static void spapr_machine_2_9_instance_options(MachineState *machine)
 
 static void spapr_machine_2_9_class_options(MachineClass *mc)
 {
+    sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
+
     spapr_machine_2_10_class_options(mc);
     SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_9);
     mc->numa_auto_assign_ram = numa_legacy_auto_assign_ram;
+    smc->pre_2_10_icp_allocation = true;
 }
 
 DEFINE_SPAPR_MACHINE(2_9, "2.9", false);
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index ff7058ecc00e..13c4916aa5e6 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -119,6 +119,7 @@ static void spapr_cpu_core_unrealizefn(DeviceState *dev, Error **errp)
     size_t size = object_type_get_instance_size(typename);
     CPUCore *cc = CPU_CORE(dev);
     int i;
+    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
 
     for (i = 0; i < cc->nr_threads; i++) {
         void *obj = sc->threads + i * size;
@@ -127,7 +128,9 @@ static void spapr_cpu_core_unrealizefn(DeviceState *dev, Error **errp)
         PowerPCCPU *cpu = POWERPC_CPU(cs);
 
         spapr_cpu_destroy(cpu);
-        object_unparent(cpu->intc);
+        if (!spapr->pre_2_10_icps) {
+            object_unparent(cpu->intc);
+        }
         cpu_remove_sync(cs);
         object_unparent(obj);
     }
@@ -142,13 +145,19 @@ static void spapr_cpu_core_realize_child(Object *child, Error **errp)
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     Object *obj;
 
-    obj = object_new(spapr->icp_type);
-    object_property_add_child(OBJECT(cpu), "icp", obj, &error_abort);
-    object_unref(obj);
-    object_property_add_const_link(obj, "xics", OBJECT(spapr), &error_abort);
-    object_property_set_bool(obj, true, "realized", &local_err);
-    if (local_err) {
-        goto error;
+    if (spapr->pre_2_10_icps) {
+        int index = cpu->parent_obj.cpu_index;
+
+        obj = OBJECT(&spapr->pre_2_10_icps[index]);
+    } else {
+        obj = object_new(spapr->icp_type);
+        object_property_add_child(OBJECT(cpu), "icp", obj, &error_abort);
+        object_property_add_const_link(obj, "xics", OBJECT(spapr),
+                                       &error_abort);
+        object_property_set_bool(obj, true, "realized", &local_err);
+        if (local_err) {
+            goto error;
+        }
     }
 
     object_property_set_bool(child, true, "realized", &local_err);
@@ -165,7 +174,9 @@ static void spapr_cpu_core_realize_child(Object *child, Error **errp)
     return;
 
 error:
-    object_unparent(obj);
+    if (!spapr->pre_2_10_icps) {
+        object_unparent(obj);
+    }
     error_propagate(errp, local_err);
 }
 
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index f875dc41d811..d1dcf0c8bddf 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -54,6 +54,7 @@ struct sPAPRMachineClass {
     bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
     bool pre_2_9_cas_pvr;      /* Use old logic for PVR compat negotiation */
     const char *tcg_default_cpu; /* which (TCG) CPU to simulate by default */
+    bool pre_2_10_icp_allocation;
     void (*phb_placement)(sPAPRMachineState *spapr, uint32_t index,
                           uint64_t *buid, hwaddr *pio, 
                           hwaddr *mmio32, hwaddr *mmio64,
@@ -110,6 +111,7 @@ struct sPAPRMachineState {
     MemoryHotplugState hotplug_memory;
 
     const char *icp_type;
+    ICPState *pre_2_10_icps;
 };
 
 #define H_SUCCESS         0
