Received: from eggs.gnu.org ([2001:4830:134:3::10]:40563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dWzxL-0002ao-Al
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 02:56:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dWzxJ-0001ZT-C8
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 02:56:35 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 17 Jul 2017 16:56:19 +1000
Message-Id: <20170717065621.4688-20-david@gibson.dropbear.id.au>
In-Reply-To: <20170717065621.4688-1-david@gibson.dropbear.id.au>
References: <20170717065621.4688-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 19/21] pseries: Allow HPT resizing with KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, sjitindarsingh@gmail.com, David Gibson <david@gibson.dropbear.id.au>

So far, qemu implements the PAPR Hash Page Table (HPT) resizing extension
with TCG.  The same implementation will work with KVM PR, but we don't
currently allow that.  For KVM HV we can only implement resizing with the
assistance of the host kernel, which needs a new capability and ioctl()s.

This patch adds support for testing the new KVM capability and implementing
the resize in terms of KVM facilities when necessary.  If we're running on
a kernel which doesn't have the new capability flag at all, we fall back to
testing for PR vs. HV KVM using the same hack that we already use in a
number of places for older kernels.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_hcall.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
 target/ppc/kvm.c     | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 target/ppc/kvm_ppc.h | 21 ++++++++++++++++
 3 files changed, 152 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 436f5e2b22..72ea5a8247 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -426,6 +426,44 @@ static void cancel_hpt_prepare(sPAPRMachineState *spapr)
     free_pending_hpt(pending);
 }
 
+/* Convert a return code from the KVM ioctl()s implementing resize HPT
+ * into a PAPR hypercall return code */
+static target_ulong resize_hpt_convert_rc(int ret)
+{
+    if (ret >= 100000) {
+        return H_LONG_BUSY_ORDER_100_SEC;
+    } else if (ret >= 10000) {
+        return H_LONG_BUSY_ORDER_10_SEC;
+    } else if (ret >= 1000) {
+        return H_LONG_BUSY_ORDER_1_SEC;
+    } else if (ret >= 100) {
+        return H_LONG_BUSY_ORDER_100_MSEC;
+    } else if (ret >= 10) {
+        return H_LONG_BUSY_ORDER_10_MSEC;
+    } else if (ret > 0) {
+        return H_LONG_BUSY_ORDER_1_MSEC;
+    }
+
+    switch (ret) {
+    case 0:
+        return H_SUCCESS;
+    case -EPERM:
+        return H_AUTHORITY;
+    case -EINVAL:
+        return H_PARAMETER;
+    case -ENXIO:
+        return H_CLOSED;
+    case -ENOSPC:
+        return H_PTEG_FULL;
+    case -EBUSY:
+        return H_BUSY;
+    case -ENOMEM:
+        return H_NO_MEM;
+    default:
+        return H_HARDWARE;
+    }
+}
+
 static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
                                          sPAPRMachineState *spapr,
                                          target_ulong opcode,
@@ -435,6 +473,7 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
     int shift = args[1];
     sPAPRPendingHPT *pending = spapr->pending_hpt;
     uint64_t current_ram_size = MACHINE(spapr)->ram_size;
+    int rc;
 
     if (spapr->resize_hpt == SPAPR_RESIZE_HPT_DISABLED) {
         return H_AUTHORITY;
@@ -464,6 +503,11 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
         return H_RESOURCE;
     }
 
+    rc = kvmppc_resize_hpt_prepare(cpu, flags, shift);
+    if (rc != -ENOSYS) {
+        return resize_hpt_convert_rc(rc);
+    }
+
     if (pending) {
         /* something already in progress */
         if (pending->shift == shift) {
@@ -659,6 +703,11 @@ static target_ulong h_resize_hpt_commit(PowerPCCPU *cpu,
 
     trace_spapr_h_resize_hpt_commit(flags, shift);
 
+    rc = kvmppc_resize_hpt_commit(cpu, flags, shift);
+    if (rc != -ENOSYS) {
+        return resize_hpt_convert_rc(rc);
+    }
+
     if (flags != 0) {
         return H_PARAMETER;
     }
@@ -684,6 +733,13 @@ static target_ulong h_resize_hpt_commit(PowerPCCPU *cpu,
         spapr->htab = pending->hpt;
         spapr->htab_shift = pending->shift;
 
+        if (kvm_enabled()) {
+            /* For KVM PR, update the HPT pointer */
+            target_ulong sdr1 = (target_ulong)(uintptr_t)spapr->htab
+                | (spapr->htab_shift - 18);
+            kvmppc_update_sdr1(sdr1);
+        }
+
         pending->hpt = NULL; /* so it's not free()d */
     }
 
@@ -1494,11 +1550,21 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
         }
 
         if (spapr->htab_shift < maxshift) {
+            CPUState *cs;
+
             /* Guest doesn't know about HPT resizing, so we
              * pre-emptively resize for the maximum permitted RAM.  At
              * the point this is called, nothing should have been
              * entered into the existing HPT */
             spapr_reallocate_hpt(spapr, maxshift, &error_fatal);
+            CPU_FOREACH(cs) {
+                if (kvm_enabled()) {
+                    /* For KVM PR, update the HPT pointer */
+                    target_ulong sdr1 = (target_ulong)(uintptr_t)spapr->htab
+                        | (spapr->htab_shift - 18);
+                    kvmppc_update_sdr1(sdr1);
+                }
+            }
         }
     }
 
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 8bafd1e932..85713795de 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -89,6 +89,7 @@ static int cap_fixup_hcalls;
 static int cap_htm;             /* Hardware transactional memory support */
 static int cap_mmu_radix;
 static int cap_mmu_hash_v3;
+static int cap_resize_hpt;
 
 static uint32_t debug_inst_opcode;
 
@@ -145,6 +146,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     cap_htm = kvm_vm_check_extension(s, KVM_CAP_PPC_HTM);
     cap_mmu_radix = kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_RADIX);
     cap_mmu_hash_v3 = kvm_vm_check_extension(s, KVM_CAP_PPC_MMU_HASH_V3);
+    cap_resize_hpt = kvm_vm_check_extension(s, KVM_CAP_SPAPR_RESIZE_HPT);
 
     if (!cap_interrupt_level) {
         fprintf(stderr, "KVM: Couldn't find level irq capability. Expect the "
@@ -2714,11 +2716,72 @@ int kvmppc_enable_hwrng(void)
 void kvmppc_check_papr_resize_hpt(Error **errp)
 {
     if (!kvm_enabled()) {
-        return;
+        return; /* No KVM, we're good */
+    }
+
+    if (cap_resize_hpt) {
+        return; /* Kernel has explicit support, we're good */
     }
 
-    /* TODO: Check for resize-capable KVM implementations */
+    /* Otherwise fallback on looking for PR KVM */
+    if (kvmppc_is_pr(kvm_state)) {
+        return;
+    }
 
     error_setg(errp,
                "Hash page table resizing not available with this KVM version");
 }
+
+int kvmppc_resize_hpt_prepare(PowerPCCPU *cpu, target_ulong flags, int shift)
+{
+    CPUState *cs = CPU(cpu);
+    struct kvm_ppc_resize_hpt rhpt = {
+        .flags = flags,
+        .shift = shift,
+    };
+
+    if (!cap_resize_hpt) {
+        return -ENOSYS;
+    }
+
+    return kvm_vm_ioctl(cs->kvm_state, KVM_PPC_RESIZE_HPT_PREPARE, &rhpt);
+}
+
+int kvmppc_resize_hpt_commit(PowerPCCPU *cpu, target_ulong flags, int shift)
+{
+    CPUState *cs = CPU(cpu);
+    struct kvm_ppc_resize_hpt rhpt = {
+        .flags = flags,
+        .shift = shift,
+    };
+
+    if (!cap_resize_hpt) {
+        return -ENOSYS;
+    }
+
+    return kvm_vm_ioctl(cs->kvm_state, KVM_PPC_RESIZE_HPT_COMMIT, &rhpt);
+}
+
+static void kvmppc_pivot_hpt_cpu(CPUState *cs, run_on_cpu_data arg)
+{
+    target_ulong sdr1 = arg.target_ptr;
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
+
+    /* This is just for the benefit of PR KVM */
+    cpu_synchronize_state(cs);
+    env->spr[SPR_SDR1] = sdr1;
+    if (kvmppc_put_books_sregs(cpu) < 0) {
+        error_report("Unable to update SDR1 in KVM");
+        exit(1);
+    }
+}
+
+void kvmppc_update_sdr1(target_ulong sdr1)
+{
+    CPUState *cs;
+
+    CPU_FOREACH(cs) {
+        run_on_cpu(cs, kvmppc_pivot_hpt_cpu, RUN_ON_CPU_TARGET_PTR(sdr1));
+    }
+}
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 9be706c5c9..6bc6fb3e2d 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -64,6 +64,9 @@ int kvmppc_enable_hwrng(void);
 int kvmppc_put_books_sregs(PowerPCCPU *cpu);
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
 void kvmppc_check_papr_resize_hpt(Error **errp);
+int kvmppc_resize_hpt_prepare(PowerPCCPU *cpu, target_ulong flags, int shift);
+int kvmppc_resize_hpt_commit(PowerPCCPU *cpu, target_ulong flags, int shift);
+void kvmppc_update_sdr1(target_ulong sdr1);
 
 bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path);
 
@@ -302,6 +305,24 @@ static inline void kvmppc_check_papr_resize_hpt(Error **errp)
 {
     return;
 }
+
+static inline int kvmppc_resize_hpt_prepare(PowerPCCPU *cpu,
+                                            target_ulong flags, int shift)
+{
+    return -ENOSYS;
+}
+
+static inline int kvmppc_resize_hpt_commit(PowerPCCPU *cpu,
+                                           target_ulong flags, int shift)
+{
+    return -ENOSYS;
+}
+
+static inline void kvmppc_update_sdr1(target_ulong sdr1)
+{
+    abort();
+}
+
 #endif
 
 #ifndef CONFIG_KVM
-- 
2.13.3
