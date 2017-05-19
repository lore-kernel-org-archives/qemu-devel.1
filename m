Received: from eggs.gnu.org ([2001:4830:134:3::10]:33702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dBfCw-0000W9-N6
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:32:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dBfCt-0007mP-FP
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:32:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dBfCt-0007mB-5G
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:32:27 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4JAUFSv058363
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 06:32:26 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ahnff7gac-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 06:32:25 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 19 May 2017 06:32:24 -0400
From: Greg Kurz <groug@kaod.org>
Date: Fri, 19 May 2017 12:32:20 +0200
In-Reply-To: <149518991537.24289.6673616934370284758.stgit@bahia.lan>
References: <149518991537.24289.6673616934370284758.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <149518994010.24289.12584852638589552255.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH v2 3/4] target/ppc: consolidate CPU device-tree
 id computation in helper
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

For historical reasons, we compute CPU device-tree ids with a non-trivial
logic. This patch consolidate the logic in a single helper to be used
in various places where it is currently open-coded.

It is okay to get rid of DIV_ROUND_UP() because we're sure that the number
of threads per core in the guest cannot exceed the number of threads per
core in the host.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c              |    6 ++----
 target/ppc/cpu.h            |   17 +++++++++++++++++
 target/ppc/translate_init.c |    3 +--
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 75e298b4c6be..1bb05a9a6b07 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -981,7 +981,6 @@ static void *spapr_build_fdt(sPAPRMachineState *spapr,
     void *fdt;
     sPAPRPHBState *phb;
     char *buf;
-    int smt = kvmppc_smt_threads();
 
     fdt = g_malloc0(FDT_MAX_SIZE);
     _FDT((fdt_create_empty_tree(fdt, FDT_MAX_SIZE)));
@@ -1021,7 +1020,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spapr,
     _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
 
     /* /interrupt controller */
-    spapr_dt_xics(DIV_ROUND_UP(max_cpus * smt, smp_threads), fdt, PHANDLE_XICP);
+    spapr_dt_xics(ppc_cpu_dt_id_from_index(max_cpus), fdt, PHANDLE_XICP);
 
     ret = spapr_populate_memory(spapr, fdt);
     if (ret < 0) {
@@ -1977,7 +1976,6 @@ static void spapr_init_cpus(sPAPRMachineState *spapr)
     MachineState *machine = MACHINE(spapr);
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     char *type = spapr_get_cpu_core_type(machine->cpu_model);
-    int smt = kvmppc_smt_threads();
     const CPUArchIdList *possible_cpus;
     int boot_cores_nr = smp_cpus / smp_threads;
     int i;
@@ -2014,7 +2012,7 @@ static void spapr_init_cpus(sPAPRMachineState *spapr)
             sPAPRDRConnector *drc =
                 spapr_dr_connector_new(OBJECT(spapr),
                                        SPAPR_DR_CONNECTOR_TYPE_CPU,
-                                       (core_id / smp_threads) * smt);
+                                       ppc_cpu_dt_id_from_index(core_id));
 
             qemu_register_reset(spapr_drc_reset, drc);
         }
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 401e10e7dad8..47fe6c64698f 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2529,4 +2529,21 @@ int ppc_get_vcpu_dt_id(PowerPCCPU *cpu);
 PowerPCCPU *ppc_get_vcpu_by_dt_id(int cpu_dt_id);
 
 void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int len);
+
+#if !defined(CONFIG_USER_ONLY)
+#include "sysemu/cpus.h"
+#include "target/ppc/kvm_ppc.h"
+
+static inline int ppc_cpu_dt_id_from_index(int cpu_index)
+{
+    /* POWER HV support has an historical limitation that different threads
+     * on a single core cannot be in different guests at the same time. In
+     * order to allow KVM to assign guest threads to host cores accordingly,
+     * CPU device tree ids are spaced by the number of threads per host cores.
+     */
+    return (cpu_index / smp_threads) * kvmppc_smt_threads()
+        + (cpu_index % smp_threads);
+}
+#endif
+
 #endif /* PPC_CPU_H */
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 56a0ab22cfbe..837a9a496a65 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -9851,8 +9851,7 @@ static void ppc_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
 #if !defined(CONFIG_USER_ONLY)
-    cpu->cpu_dt_id = (cs->cpu_index / smp_threads) * max_smt
-        + (cs->cpu_index % smp_threads);
+    cpu->cpu_dt_id = ppc_cpu_dt_id_from_index(cs->cpu_index);
 
     if (kvm_enabled() && !kvm_vcpu_id_is_valid(cpu->cpu_dt_id)) {
         error_setg(errp, "Can't create CPU with id %d in KVM", cpu->cpu_dt_id);
