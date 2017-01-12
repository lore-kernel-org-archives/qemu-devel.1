Received: from eggs.gnu.org ([2001:4830:134:3::10]:46349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUk2-0002yC-3k
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRUjz-0006WY-9K
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:03:50 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 12 Jan 2017 13:02:37 +1100
Message-Id: <20170112020327.24882-18-david@gibson.dropbear.id.au>
In-Reply-To: <20170112020327.24882-1-david@gibson.dropbear.id.au>
References: <20170112020327.24882-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 17/67] ppc: Clean up and QOMify hypercall
 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

The pseries machine type is a bit unusual in that it runs a paravirtualized
guest.  The guest expects to interact with a hypervisor, and qemu
emulates the functions of that hypervisor directly, rather than executing
hypervisor code within the emulated system.

To implement this in TCG, we need to intercept hypercall instructions and
direct them to the machine's hypercall handlers, rather than attempting to
perform a privilege change within TCG.  This is controlled by a global
hook - cpu_ppc_hypercall.

This cleanup makes the handling a little cleaner and more extensible than
a single global variable.  Instead, each CPU to have hypercalls intercepted
has a pointer set to a QOM object implementing a new virtual hypervisor
interface.  A method in that interface is called by TCG when it sees a
hypercall instruction.  It's possible we may want to add other methods in
future.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 hw/ppc/spapr.c              |  8 +++++---
 hw/ppc/spapr_cpu_core.c     |  1 +
 target/ppc/cpu.h            | 26 ++++++++++++++++++++++++--
 target/ppc/excp_helper.c    | 11 ++++-------
 target/ppc/translate_init.c | 12 ++++++++++++
 5 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 52970db..b3bbad0 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1005,7 +1005,8 @@ static uint64_t translate_kernel_address(void *opaque, uint64_t addr)
     return (addr & 0x0fffffff) + KERNEL_LOAD_ADDR;
 }
 
-static void emulate_spapr_hypercall(PowerPCCPU *cpu)
+static void emulate_spapr_hypercall(PPCVirtualHypervisor *vhyp,
+                                    PowerPCCPU *cpu)
 {
     CPUPPCState *env = &cpu->env;
 
@@ -1843,8 +1844,6 @@ static void ppc_spapr_init(MachineState *machine)
 
     QLIST_INIT(&spapr->phbs);
 
-    cpu_ppc_hypercall = emulate_spapr_hypercall;
-
     /* Allocate RMA if necessary */
     rma_alloc_size = kvmppc_alloc_rma(&rma);
 
@@ -2680,6 +2679,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     FWPathProviderClass *fwc = FW_PATH_PROVIDER_CLASS(oc);
     NMIClass *nc = NMI_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
+    PPCVirtualHypervisorClass *vhc = PPC_VIRTUAL_HYPERVISOR_CLASS(oc);
 
     mc->desc = "pSeries Logical Partition (PAPR compliant)";
 
@@ -2711,6 +2711,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     fwc->get_dev_path = spapr_get_fw_dev_path;
     nc->nmi_monitor_handler = spapr_nmi;
     smc->phb_placement = spapr_phb_placement;
+    vhc->hypercall = emulate_spapr_hypercall;
 }
 
 static const TypeInfo spapr_machine_info = {
@@ -2726,6 +2727,7 @@ static const TypeInfo spapr_machine_info = {
         { TYPE_FW_PATH_PROVIDER },
         { TYPE_NMI },
         { TYPE_HOTPLUG_HANDLER },
+        { TYPE_PPC_VIRTUAL_HYPERVISOR },
         { }
     },
 };
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index f532689..9dddaeb 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -57,6 +57,7 @@ static void spapr_cpu_init(sPAPRMachineState *spapr, PowerPCCPU *cpu,
     cpu_ppc_tb_init(env, SPAPR_TIMEBASE_FREQ);
 
     /* Enable PAPR mode in TCG or KVM */
+    cpu_ppc_set_vhyp(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
     cpu_ppc_set_papr(cpu);
 
     if (cpu->max_compat) {
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 7a6ee3f..4fb4c20 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1150,6 +1150,9 @@ do {                                            \
     env->wdt_period[3] = (d_);                  \
  } while (0)
 
+typedef struct PPCVirtualHypervisor PPCVirtualHypervisor;
+typedef struct PPCVirtualHypervisorClass PPCVirtualHypervisorClass;
+
 /**
  * PowerPCCPU:
  * @env: #CPUPPCState
@@ -1168,6 +1171,7 @@ struct PowerPCCPU {
     int cpu_dt_id;
     uint32_t max_compat;
     uint32_t cpu_version;
+    PPCVirtualHypervisor *vhyp;
 
     /* Fields related to migration compatibility hacks */
     bool pre_2_8_migration;
@@ -1189,6 +1193,25 @@ static inline PowerPCCPU *ppc_env_get_cpu(CPUPPCState *env)
 PowerPCCPUClass *ppc_cpu_class_by_pvr(uint32_t pvr);
 PowerPCCPUClass *ppc_cpu_class_by_pvr_mask(uint32_t pvr);
 
+struct PPCVirtualHypervisor {
+    Object parent;
+};
+
+struct PPCVirtualHypervisorClass {
+    InterfaceClass parent;
+    void (*hypercall)(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu);
+};
+
+#define TYPE_PPC_VIRTUAL_HYPERVISOR "ppc-virtual-hypervisor"
+#define PPC_VIRTUAL_HYPERVISOR(obj)                 \
+    OBJECT_CHECK(PPCVirtualHypervisor, (obj), TYPE_PPC_VIRTUAL_HYPERVISOR)
+#define PPC_VIRTUAL_HYPERVISOR_CLASS(klass)         \
+    OBJECT_CLASS_CHECK(PPCVirtualHypervisorClass, (klass), \
+                       TYPE_PPC_VIRTUAL_HYPERVISOR)
+#define PPC_VIRTUAL_HYPERVISOR_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(PPCVirtualHypervisorClass, (obj), \
+                     TYPE_PPC_VIRTUAL_HYPERVISOR)
+
 void ppc_cpu_do_interrupt(CPUState *cpu);
 bool ppc_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void ppc_cpu_dump_state(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf,
@@ -1261,6 +1284,7 @@ void store_booke_tcr (CPUPPCState *env, target_ulong val);
 void store_booke_tsr (CPUPPCState *env, target_ulong val);
 void ppc_tlb_invalidate_all (CPUPPCState *env);
 void ppc_tlb_invalidate_one (CPUPPCState *env, target_ulong addr);
+void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp);
 void cpu_ppc_set_papr(PowerPCCPU *cpu);
 #endif
 #endif
@@ -2435,8 +2459,6 @@ static inline bool lsw_reg_in_range(int start, int nregs, int rx)
            (start + nregs > 32 && (rx >= start || rx < start + nregs - 32));
 }
 
-extern void (*cpu_ppc_hypercall)(PowerPCCPU *);
-
 void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUPPCState *env);
 
 /**
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 93369d4..f4ee7aa 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -35,11 +35,6 @@
 #endif
 
 /*****************************************************************************/
-/* PowerPC Hypercall emulation */
-
-void (*cpu_ppc_hypercall)(PowerPCCPU *);
-
-/*****************************************************************************/
 /* Exception processing */
 #if defined(CONFIG_USER_ONLY)
 void ppc_cpu_do_interrupt(CPUState *cs)
@@ -318,8 +313,10 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
         env->nip += 4;
 
         /* "PAPR mode" built-in hypercall emulation */
-        if ((lev == 1) && cpu_ppc_hypercall) {
-            cpu_ppc_hypercall(cpu);
+        if ((lev == 1) && cpu->vhyp) {
+            PPCVirtualHypervisorClass *vhc =
+                PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
+            vhc->hypercall(cpu->vhyp, cpu);
             return;
         }
         if (lev == 1) {
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 626e031..82ed83b 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8857,6 +8857,11 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
 
 #if !defined(CONFIG_USER_ONLY)
 
+void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
+{
+    cpu->vhyp = vhyp;
+}
+
 void cpu_ppc_set_papr(PowerPCCPU *cpu)
 {
     CPUPPCState *env = &cpu->env;
@@ -10593,9 +10598,16 @@ static const TypeInfo ppc_cpu_type_info = {
     .class_init = ppc_cpu_class_init,
 };
 
+static const TypeInfo ppc_vhyp_type_info = {
+    .name = TYPE_PPC_VIRTUAL_HYPERVISOR,
+    .parent = TYPE_INTERFACE,
+    .class_size = sizeof(PPCVirtualHypervisorClass),
+};
+
 static void ppc_cpu_register_types(void)
 {
     type_register_static(&ppc_cpu_type_info);
+    type_register_static(&ppc_vhyp_type_info);
 }
 
 type_init(ppc_cpu_register_types)
-- 
2.9.3
