Received: from eggs.gnu.org ([2001:4830:134:3::10]:47236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dozDK-0003uN-Ie
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 17:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dozDE-00037a-Hi
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 17:47:26 -0400
Received: from 4.mo178.mail-out.ovh.net ([46.105.49.171]:32921)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dozDE-00036Y-A7
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 17:47:20 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 30B1351124
	for <qemu-devel@nongnu.org>; Mon,  4 Sep 2017 23:47:19 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 04 Sep 2017 23:47:14 +0200
Message-ID: <150456163456.17000.11736294199857677034.stgit@bahia.lan>
In-Reply-To: <150456160452.17000.3290192176290246589.stgit@bahia.lan>
References: <150456160452.17000.3290192176290246589.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 3/4] ppc: kvm: introduce a helper to update
 SDR1 for a single CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Thomas Huth <thuth@redhat.com>

When running with KVM PR, we hijack the SDR1 slot to pass the address of
the HPT allocated by QEMU to KVM.  On pseries virtual machines, we have to
do this when the guest calls the KVMPPC_H_CAS or the H_RESIZE_HPT_COMMIT
hypercalls. This is currently handled by kvmppc_update_sdr1() which updates
SDR1 for all CPUs. But we also need to update SDR1 at machine reset, and
this is currently open-coded in spapr_cpu_reset() on a per-CPU basis.

This patch renames kvmppc_update_sdr1() to kvmppc_update_sdr1_all() and
reuses the kvmppc_update_sdr1() function name to update a single CPU,
like we already do with in the CPU compat mode code.

It finally converts the sPAPR code to use the all CPUs or single CPU helpers
where appropriate.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_cpu_core.c |    6 +-----
 hw/ppc/spapr_hcall.c    |    4 ++--
 target/ppc/kvm.c        |   12 ++++++++----
 target/ppc/kvm_ppc.h    |    3 ++-
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 581eb4d92de9..da81688b0f4d 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -95,11 +95,7 @@ static void spapr_cpu_reset(void *opaque)
     if (kvm_enabled()) {
         target_ulong sdr1 = spapr_get_hpt_pointer(spapr);
         if (sdr1) {
-            env->spr[SPR_SDR1] = sdr1;
-            if (kvmppc_put_books_sregs(cpu) < 0) {
-                error_report("Unable to update SDR1 in KVM");
-                exit(1);
-            }
+            kvmppc_update_sdr1(cpu, sdr1);
         }
     }
 }
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 06059b44ab40..e090b69efe7f 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -737,7 +737,7 @@ static target_ulong h_resize_hpt_commit(PowerPCCPU *cpu,
             /* For KVM PR, update the HPT pointer */
             target_ulong sdr1 = spapr_get_hpt_pointer(spapr);
             if (sdr1) {
-                kvmppc_update_sdr1(sdr1);
+                kvmppc_update_sdr1_all(sdr1);
             }
         }
 
@@ -1569,7 +1569,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
                 /* For KVM PR, update the HPT pointer */
                 target_ulong sdr1 = spapr_get_hpt_pointer(spapr);
                 if (sdr1) {
-                    kvmppc_update_sdr1(sdr1);
+                    kvmppc_update_sdr1_all(sdr1);
                 }
             }
         }
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 6442dfcb95b3..e69366968f15 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2806,10 +2806,9 @@ int kvmppc_resize_hpt_commit(PowerPCCPU *cpu, target_ulong flags, int shift)
     return kvm_vm_ioctl(cs->kvm_state, KVM_PPC_RESIZE_HPT_COMMIT, &rhpt);
 }
 
-static void kvmppc_pivot_hpt_cpu(CPUState *cs, run_on_cpu_data arg)
+void kvmppc_update_sdr1(PowerPCCPU *cpu, target_ulong sdr1)
 {
-    target_ulong sdr1 = arg.target_ptr;
-    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
 
     /* This is just for the benefit of PR KVM */
@@ -2821,7 +2820,12 @@ static void kvmppc_pivot_hpt_cpu(CPUState *cs, run_on_cpu_data arg)
     }
 }
 
-void kvmppc_update_sdr1(target_ulong sdr1)
+static void kvmppc_pivot_hpt_cpu(CPUState *cs, run_on_cpu_data arg)
+{
+    kvmppc_update_sdr1(POWERPC_CPU(cs), arg.target_ptr);
+}
+
+void kvmppc_update_sdr1_all(target_ulong sdr1)
 {
     CPUState *cs;
 
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index f780e6ec7b72..9524a7a0c21c 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -68,7 +68,8 @@ PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
 void kvmppc_check_papr_resize_hpt(Error **errp);
 int kvmppc_resize_hpt_prepare(PowerPCCPU *cpu, target_ulong flags, int shift);
 int kvmppc_resize_hpt_commit(PowerPCCPU *cpu, target_ulong flags, int shift);
-void kvmppc_update_sdr1(target_ulong sdr1);
+void kvmppc_update_sdr1(PowerPCCPU *cpu, target_ulong sdr1);
+void kvmppc_update_sdr1_all(target_ulong sdr1);
 bool kvmppc_pvr_workaround_required(PowerPCCPU *cpu);
 
 bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path);
