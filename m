Received: from eggs.gnu.org ([2001:4830:134:3::10]:52193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1em2vD-0003Kk-Eq
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:40:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1em2vC-0002zl-J3
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:40:51 -0500
Received: from 4.mo179.mail-out.ovh.net ([46.105.36.149]:55681)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1em2vC-0002zO-BC
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 14:40:50 -0500
Received: from player168.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 20F2AA38BC
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 20:40:49 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 14 Feb 2018 20:40:44 +0100
Message-ID: <151863724465.3003.14485203815672867421.stgit@bahia.lan>
In-Reply-To: <151863720814.3003.4939908778788942974.stgit@bahia.lan>
References: <151863720814.3003.4939908778788942974.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 3/5] spapr: rename spapr_vcpu_id() to
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
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Sam Bobroff <sam.bobroff@au1.ibm.com>, Laurent Vivier <lvivier@redhat.com>

The spapr_vcpu_id() function is an accessor actually. Let's rename it
for symmetry with the recently added spapr_set_vcpu_id() helper.

The motivation behind this is that a later patch will consolidate
the VCPU id formula in a function and spapr_vcpu_id looks like an
appropriate name.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c         |   16 ++++++++--------
 include/hw/ppc/spapr.h |    2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 30cc48fd5264..18ebc058acdd 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -209,7 +209,7 @@ static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu,
     int i, ret = 0;
     uint32_t servers_prop[smt_threads];
     uint32_t gservers_prop[smt_threads * 2];
-    int index = spapr_vcpu_id(cpu);
+    int index = spapr_get_vcpu_id(cpu);
 
     if (cpu->compat_pvr) {
         ret = fdt_setprop_cell(fdt, offset, "cpu-version", cpu->compat_pvr);
@@ -238,7 +238,7 @@ static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu,
 
 static int spapr_fixup_cpu_numa_dt(void *fdt, int offset, PowerPCCPU *cpu)
 {
-    int index = spapr_vcpu_id(cpu);
+    int index = spapr_get_vcpu_id(cpu);
     uint32_t associativity[] = {cpu_to_be32(0x5),
                                 cpu_to_be32(0x0),
                                 cpu_to_be32(0x0),
@@ -342,7 +342,7 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachineState *spapr)
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
 
@@ -3234,7 +3234,7 @@ static void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     DeviceClass *dc = DEVICE_GET_CLASS(cs);
-    int id = spapr_vcpu_id(cpu);
+    int id = spapr_get_vcpu_id(cpu);
     void *fdt;
     int offset, fdt_size;
     char *nodename;
@@ -3791,7 +3791,7 @@ static void spapr_pic_print_info(InterruptStatsProvider *obj,
     ics_pic_print_info(spapr->ics, mon);
 }
 
-int spapr_vcpu_id(PowerPCCPU *cpu)
+int spapr_get_vcpu_id(PowerPCCPU *cpu)
 {
     CPUState *cs = CPU(cpu);
 
@@ -3828,7 +3828,7 @@ PowerPCCPU *spapr_find_cpu(int vcpu_id)
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu = POWERPC_CPU(cs);
 
-        if (spapr_vcpu_id(cpu) == vcpu_id) {
+        if (spapr_get_vcpu_id(cpu) == vcpu_id) {
             return cpu;
         }
     }
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index af19320d2f8a..36942b378daa 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -766,7 +766,7 @@ void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg);
 
 #define HTAB_SIZE(spapr)        (1ULL << ((spapr)->htab_shift))
 
-int spapr_vcpu_id(PowerPCCPU *cpu);
+int spapr_get_vcpu_id(PowerPCCPU *cpu);
 void spapr_set_vcpu_id(PowerPCCPU *cpu, int cpu_index, Error **errp);
 PowerPCCPU *spapr_find_cpu(int vcpu_id);
 
