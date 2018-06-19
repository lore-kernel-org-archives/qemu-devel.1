Received: from eggs.gnu.org ([2001:4830:134:3::10]:44959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5h7-0000g6-HG
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:44:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5h6-0007th-Ep
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:44:29 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:41:38 -0500
Message-Id: <20180619014319.28272-13-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 012/113] spapr: rename spapr_vcpu_id() to
 spapr_get_vcpu_id()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

The spapr_vcpu_id() function is an accessor actually. Let's rename it
for symmetry with the recently added spapr_set_vcpu_id() helper.

The motivation behind this is that a later patch will consolidate
the VCPU id formula in a function and spapr_vcpu_id looks like an
appropriate name.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
(cherry picked from commit 14bb4486c819ea797a151b3e0fe53d6f5c7b3fc5)
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c         | 16 ++++++++--------
 include/hw/ppc/spapr.h |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index fc6ebe1b3a..0be60fb044 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -210,7 +210,7 @@ static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu,
     int i, ret = 0;
     uint32_t servers_prop[smt_threads];
     uint32_t gservers_prop[smt_threads * 2];
-    int index = spapr_vcpu_id(cpu);
+    int index = spapr_get_vcpu_id(cpu);
 
     if (cpu->compat_pvr) {
         ret = fdt_setprop_cell(fdt, offset, "cpu-version", cpu->compat_pvr);
@@ -239,7 +239,7 @@ static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu,
 
 static int spapr_fixup_cpu_numa_dt(void *fdt, int offset, PowerPCCPU *cpu)
 {
-    int index = spapr_vcpu_id(cpu);
+    int index = spapr_get_vcpu_id(cpu);
     uint32_t associativity[] = {cpu_to_be32(0x5),
                                 cpu_to_be32(0x0),
                                 cpu_to_be32(0x0),
@@ -343,7 +343,7 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachineState *spapr)
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu = POWERPC_CPU(cs);
         DeviceClass *dc = DEVICE_GET_CLASS(cs);
-        int index = spapr_vcpu_id(cpu);
+        int index = spapr_get_vcpu_id(cpu);
         int compat_smt = MIN(smp_threads, ppc_compat_max_vthreads(cpu));
 
         if (index % spapr->vsmt != 0) {
@@ -492,7 +492,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cs);
-    int index = spapr_vcpu_id(cpu);
+    int index = spapr_get_vcpu_id(cpu);
     uint32_t segs[] = {cpu_to_be32(28), cpu_to_be32(40),
                        0xffffffff, 0xffffffff};
     uint32_t tbfreq = kvm_enabled() ? kvmppc_get_tbfreq()
@@ -626,7 +626,7 @@ static void spapr_populate_cpus_dt_node(void *fdt, sPAPRMachineState *spapr)
      */
     CPU_FOREACH_REVERSE(cs) {
         PowerPCCPU *cpu = POWERPC_CPU(cs);
-        int index = spapr_vcpu_id(cpu);
+        int index = spapr_get_vcpu_id(cpu);
         DeviceClass *dc = DEVICE_GET_CLASS(cs);
         int offset;
 
@@ -3213,7 +3213,7 @@ static void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     DeviceClass *dc = DEVICE_GET_CLASS(cs);
-    int id = spapr_vcpu_id(cpu);
+    int id = spapr_get_vcpu_id(cpu);
     void *fdt;
     int offset, fdt_size;
     char *nodename;
@@ -3636,7 +3636,7 @@ static void spapr_pic_print_info(InterruptStatsProvider *obj,
     ics_pic_print_info(spapr->ics, mon);
 }
 
-int spapr_vcpu_id(PowerPCCPU *cpu)
+int spapr_get_vcpu_id(PowerPCCPU *cpu)
 {
     CPUState *cs = CPU(cpu);
 
@@ -3673,7 +3673,7 @@ PowerPCCPU *spapr_find_cpu(int vcpu_id)
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu = POWERPC_CPU(cs);
 
-        if (spapr_vcpu_id(cpu) == vcpu_id) {
+        if (spapr_get_vcpu_id(cpu) == vcpu_id) {
             return cpu;
         }
     }
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 38a657426a..fa02539b07 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -756,7 +756,7 @@ void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg);
 
 #define HTAB_SIZE(spapr)        (1ULL << ((spapr)->htab_shift))
 
-int spapr_vcpu_id(PowerPCCPU *cpu);
+int spapr_get_vcpu_id(PowerPCCPU *cpu);
 void spapr_set_vcpu_id(PowerPCCPU *cpu, int cpu_index, Error **errp);
 PowerPCCPU *spapr_find_cpu(int vcpu_id);
 
-- 
2.11.0
