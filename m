Received: from eggs.gnu.org ([2001:4830:134:3::10]:55983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cJDSk-0004Ix-3f
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 00:59:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cJDSg-0000OR-VP
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 00:59:46 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 20 Dec 2016 16:58:57 +1100
Message-Id: <20161220055857.9674-7-david@gibson.dropbear.id.au>
In-Reply-To: <20161220055857.9674-1-david@gibson.dropbear.id.au>
References: <20161220055857.9674-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCHv5 for 2.9 6/6] pseries: Allow HPT resizing with
 KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: paulus@samba.org, sjitindarsingh@gmail.com
Cc: thuth@redhat.com, lvivier@redhat.com, agraf@suse.de, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

So far, qemu implements the PAPR Hash Page Table (HPT) resizing extension
with TCG.  The same implementation will work with KVM PR, but we don't
currently allow that.  For KVM HV we can only implement resizing with the
assistance of the host kernel, which needs a new capability and ioctl()s.

This patch adds support for testing the new KVM capability and implementing
the resize in terms of KVM facilities when necessary.  If we're running on
a kernel which doesn't have the new capability flag at all, we fall back to
testing for PR vs. HV KVM using the same hack that we already use in a
number of places for older kernels.

NOTE: This patch updates the linux-headers tree with the define for the
new capability and ioctl()s.  Since the corresponding kernel changes aren't
yet upstream this is a temporary hack to be replaced by a proper headers
update before merge.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_hcall.c      | 49 +++++++++++++++++++++++++++++++++++++++++++++++
 linux-headers/linux/kvm.h | 11 +++++++++++
 target-ppc/kvm.c          | 43 +++++++++++++++++++++++++++++++++++++++--
 target-ppc/kvm_ppc.h      | 14 ++++++++++++++
 4 files changed, 115 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 3991c15..a42d0cb 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -460,6 +460,44 @@ static ram_addr_t get_current_ram_size(void)
     return size;
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
@@ -468,6 +506,7 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
     target_ulong flags = args[0];
     int shift = args[1];
     sPAPRPendingHPT *pending = spapr->pending_hpt;
+    int rc;
 
     if (spapr->resize_hpt == SPAPR_RESIZE_HPT_DISABLED) {
         return H_AUTHORITY;
@@ -491,6 +530,11 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
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
@@ -696,6 +740,11 @@ static target_ulong h_resize_hpt_commit(PowerPCCPU *cpu,
 
     trace_spapr_h_resize_hpt_commit(flags, shift);
 
+    rc = kvmppc_resize_hpt_commit(cpu, flags, shift);
+    if (rc != -ENOSYS) {
+        return resize_hpt_convert_rc(rc);
+    }
+
     if (flags != 0) {
         return H_PARAMETER;
     }
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 4806e06..da85bbd 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -684,6 +684,13 @@ struct kvm_ppc_smmu_info {
 
 #define KVM_PPC_PVINFO_FLAGS_EV_IDLE   (1<<0)
 
+/* for KVM_PPC_RESIZE_HPT_{PREPARE,COMMIT} */
+struct kvm_ppc_resize_hpt {
+	__u64 flags;
+	__u32 shift;
+	__u32 pad;
+};
+
 #define KVMIO 0xAE
 
 /* machine type bits, to be used as argument to KVM_CREATE_VM */
@@ -870,6 +877,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_S390_USER_INSTR0 130
 #define KVM_CAP_MSI_DEVID 131
 #define KVM_CAP_PPC_HTM 132
+#define KVM_CAP_SPAPR_RESIZE_HPT 133
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1179,6 +1187,9 @@ struct kvm_s390_ucas_mapping {
 #define KVM_ARM_SET_DEVICE_ADDR	  _IOW(KVMIO,  0xab, struct kvm_arm_device_addr)
 /* Available with KVM_CAP_PPC_RTAS */
 #define KVM_PPC_RTAS_DEFINE_TOKEN _IOW(KVMIO,  0xac, struct kvm_rtas_token_args)
+/* Available with KVM_CAP_SPAPR_RESIZE_HPT */
+#define KVM_PPC_RESIZE_HPT_PREPARE _IOR(KVMIO, 0xad, struct kvm_ppc_resize_hpt)
+#define KVM_PPC_RESIZE_HPT_COMMIT _IOR(KVMIO, 0xae, struct kvm_ppc_resize_hpt)
 
 /* ioctl for vm fd */
 #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)
diff --git a/target-ppc/kvm.c b/target-ppc/kvm.c
index f015d56..d3b314c 100644
--- a/target-ppc/kvm.c
+++ b/target-ppc/kvm.c
@@ -82,6 +82,7 @@ static int cap_papr;
 static int cap_htab_fd;
 static int cap_fixup_hcalls;
 static int cap_htm;             /* Hardware transactional memory support */
+static int cap_resize_hpt;
 
 static uint32_t debug_inst_opcode;
 
@@ -135,6 +136,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     cap_htab_fd = kvm_check_extension(s, KVM_CAP_PPC_HTAB_FD);
     cap_fixup_hcalls = kvm_check_extension(s, KVM_CAP_PPC_FIXUP_HCALL);
     cap_htm = kvm_vm_check_extension(s, KVM_CAP_PPC_HTM);
+    cap_resize_hpt = kvm_vm_check_extension(s, KVM_CAP_SPAPR_RESIZE_HPT);
 
     if (!cap_interrupt_level) {
         fprintf(stderr, "KVM: Couldn't find level irq capability. Expect the "
@@ -2677,10 +2679,47 @@ int kvmppc_enable_hwrng(void)
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
 
     error_setg(errp, "Hash page table resizing not available with this KVM version");
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
diff --git a/target-ppc/kvm_ppc.h b/target-ppc/kvm_ppc.h
index 3e852ba..a3e3b1e 100644
--- a/target-ppc/kvm_ppc.h
+++ b/target-ppc/kvm_ppc.h
@@ -60,6 +60,8 @@ int kvmppc_enable_hwrng(void);
 int kvmppc_put_books_sregs(PowerPCCPU *cpu);
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
 void kvmppc_check_papr_resize_hpt(Error **errp);
+int kvmppc_resize_hpt_prepare(PowerPCCPU *cpu, target_ulong flags, int shift);
+int kvmppc_resize_hpt_commit(PowerPCCPU *cpu, target_ulong flags, int shift);
 
 #else
 
@@ -275,6 +277,18 @@ static inline void kvmppc_check_papr_resize_hpt(Error **errp)
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
 #endif
 
 #ifndef CONFIG_KVM
-- 
2.9.3
