Received: from eggs.gnu.org ([2001:4830:134:3::10]:45800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cdvmY-0007mf-QM
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 04:21:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cdvmV-0003JK-JG
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 04:21:50 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 15 Feb 2017 10:21:44 +0100
Message-Id: <1487150504-30335-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/ppc/spapr: Check for valid page size when
 hot plugging memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

On POWER, the valid page sizes that the guest can use are bound
to the CPU and not to the memory region. QEMU already has some
fancy logic to find out the right maximum memory size to tell
it to the guest during boot (see getrampagesize() in the file
target/ppc/kvm.c for more information).
However, once we're booted and the guest is using huge pages
already, it is currently still possible to hot-plug memory regions
that does not support huge pages - which of course does not work
on POWER, since the guest thinks that it is possible to use huge
pages everywhere. The KVM_RUN ioctl will then abort with -EFAULT,
QEMU spills out a not very helpful error message together with
a register dump and the user is annoyed that the VM unexpectedly
died.
To avoid this situation, we should check the page size of hot-plugged
DIMMs to see whether it is possible to use it in the current VM.
If it does not fit, we can print out a better error message and
refuse to add it, so that the VM does not die unexpectely and the
user has a second chance to plug a DIMM with a matching memory
backend instead.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1419466
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/ppc/spapr.c       |  8 ++++++++
 target/ppc/kvm.c     | 32 ++++++++++++++++++++++++++++----
 target/ppc/kvm_ppc.h |  7 +++++++
 3 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e465d7a..1a90aae 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2357,6 +2357,7 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     uint64_t align = memory_region_get_alignment(mr);
     uint64_t size = memory_region_size(mr);
     uint64_t addr;
+    char *mem_dev;
 
     if (size % SPAPR_MEMORY_BLOCK_SIZE) {
         error_setg(&local_err, "Hotplugged memory size must be a multiple of "
@@ -2364,6 +2365,13 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         goto out;
     }
 
+    mem_dev = object_property_get_str(OBJECT(dimm), PC_DIMM_MEMDEV_PROP, NULL);
+    if (mem_dev && !kvmppc_is_mem_backend_page_size_ok(mem_dev)) {
+        error_setg(&local_err, "Memory backend has bad page size. "
+                   "Use 'memory-backend-file' with correct mem-path.");
+        goto out;
+    }
+
     pc_dimm_memory_plug(dev, &ms->hotplug_memory, mr, align, &local_err);
     if (local_err) {
         goto out;
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 663d2e7..584546b 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -438,12 +438,13 @@ static bool kvm_valid_page_size(uint32_t flags, long rampgsize, uint32_t shift)
     return (1ul << shift) <= rampgsize;
 }
 
+static long max_cpu_page_size;
+
 static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
 {
     static struct kvm_ppc_smmu_info smmu_info;
     static bool has_smmu_info;
     CPUPPCState *env = &cpu->env;
-    long rampagesize;
     int iq, ik, jq, jk;
     bool has_64k_pages = false;
 
@@ -458,7 +459,9 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
         has_smmu_info = true;
     }
 
-    rampagesize = getrampagesize();
+    if (!max_cpu_page_size) {
+        max_cpu_page_size = getrampagesize();
+    }
 
     /* Convert to QEMU form */
     memset(&env->sps, 0, sizeof(env->sps));
@@ -478,14 +481,14 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
         struct ppc_one_seg_page_size *qsps = &env->sps.sps[iq];
         struct kvm_ppc_one_seg_page_size *ksps = &smmu_info.sps[ik];
 
-        if (!kvm_valid_page_size(smmu_info.flags, rampagesize,
+        if (!kvm_valid_page_size(smmu_info.flags, max_cpu_page_size,
                                  ksps->page_shift)) {
             continue;
         }
         qsps->page_shift = ksps->page_shift;
         qsps->slb_enc = ksps->slb_enc;
         for (jk = jq = 0; jk < KVM_PPC_PAGE_SIZES_MAX_SZ; jk++) {
-            if (!kvm_valid_page_size(smmu_info.flags, rampagesize,
+            if (!kvm_valid_page_size(smmu_info.flags, max_cpu_page_size,
                                      ksps->enc[jk].page_shift)) {
                 continue;
             }
@@ -510,12 +513,33 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
         env->mmu_model &= ~POWERPC_MMU_64K;
     }
 }
+
+bool kvmppc_is_mem_backend_page_size_ok(char *obj_path)
+{
+    Object *mem_obj = object_resolve_path(obj_path, NULL);
+    char *mempath = object_property_get_str(mem_obj, "mem-path", NULL);
+    long pagesize;
+
+    if (mempath) {
+        pagesize = gethugepagesize(mempath);
+    } else {
+        pagesize = getpagesize();
+    }
+
+    return pagesize >= max_cpu_page_size;
+}
+
 #else /* defined (TARGET_PPC64) */
 
 static inline void kvm_fixup_page_sizes(PowerPCCPU *cpu)
 {
 }
 
+int kvmppc_is_mem_backend_page_size_ok(char *obj_path)
+{
+    return true;
+}
+
 #endif /* !defined (TARGET_PPC64) */
 
 unsigned long kvm_arch_vcpu_id(CPUState *cpu)
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 151c00b..8da2ee4 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -60,6 +60,8 @@ int kvmppc_enable_hwrng(void);
 int kvmppc_put_books_sregs(PowerPCCPU *cpu);
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
 
+bool kvmppc_is_mem_backend_page_size_ok(char *obj_path);
+
 #else
 
 static inline uint32_t kvmppc_get_tbfreq(void)
@@ -192,6 +194,11 @@ static inline uint64_t kvmppc_rma_size(uint64_t current_size,
     return ram_size;
 }
 
+static inline bool kvmppc_is_mem_backend_page_size_ok(char *obj_path)
+{
+    return true;
+}
+
 #endif /* !CONFIG_USER_ONLY */
 
 static inline bool kvmppc_has_cap_epr(void)
-- 
1.8.3.1
