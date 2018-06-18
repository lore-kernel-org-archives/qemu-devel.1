Received: from eggs.gnu.org ([2001:4830:134:3::10]:41307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUnm3-0008OK-IH
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 02:36:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUnm1-0001RN-Pw
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 02:36:23 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 18 Jun 2018 16:36:03 +1000
Message-Id: <20180618063606.2513-7-david@gibson.dropbear.id.au>
In-Reply-To: <20180618063606.2513-1-david@gibson.dropbear.id.au>
References: <20180618063606.2513-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 6/9] spapr: Use maximum page size capability to
 simplify memory backend checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org, abologna@redhat.com
Cc: clg@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

The way we used to handle KVM allowable guest pagesizes for PAPR guests
required some convoluted checking of memory attached to the guest.

The allowable pagesizes advertised to the guest cpus depended on the memory
which was attached at boot, but then we needed to ensure that any memory
later hotplugged didn't change which pagesizes were allowed.

Now that we have an explicit machine option to control the allowable
maximum pagesize we can simplify this.  We just check all memory backends
against that declared pagesize.  We check base and cold-plugged memory at
reset time, and hotplugged memory at pre_plug() time.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c         | 17 +++++++----------
 hw/ppc/spapr_caps.c    | 20 ++++++++++++++++++++
 include/hw/ppc/spapr.h |  3 +++
 target/ppc/kvm.c       | 14 --------------
 target/ppc/kvm_ppc.h   |  6 ------
 5 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 74a76e7e09..efd36e92e2 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3192,11 +3192,13 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                                   Error **errp)
 {
     const sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(hotplug_dev);
+    sPAPRMachineState *spapr = SPAPR_MACHINE(hotplug_dev);
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *mr;
     uint64_t size;
-    char *mem_dev;
+    Object *memdev;
+    hwaddr pagesize;
 
     if (!smc->dr_lmb_enabled) {
         error_setg(errp, "Memory hotplug not supported for this machine");
@@ -3215,15 +3217,10 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    mem_dev = object_property_get_str(OBJECT(dimm), PC_DIMM_MEMDEV_PROP, NULL);
-    if (mem_dev && !kvmppc_is_mem_backend_page_size_ok(mem_dev)) {
-        error_setg(errp, "Memory backend has bad page size. "
-                   "Use 'memory-backend-file' with correct mem-path.");
-        goto out;
-    }
-
-out:
-    g_free(mem_dev);
+    memdev = object_property_get_link(OBJECT(dimm), PC_DIMM_MEMDEV_PROP,
+                                      &error_abort);
+    pagesize = host_memory_backend_pagesize(MEMORY_BACKEND(memdev));
+    spapr_check_pagesize(spapr, pagesize, errp);
 }
 
 struct sPAPRDIMMState {
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 6cdc0c94e7..9fc739b3f5 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -26,6 +26,7 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "sysemu/hw_accel.h"
+#include "exec/ram_addr.h"
 #include "target/ppc/cpu.h"
 #include "target/ppc/mmu-hash64.h"
 #include "cpu-models.h"
@@ -304,6 +305,23 @@ static void cap_safe_indirect_branch_apply(sPAPRMachineState *spapr,
 
 #define VALUE_DESC_TRISTATE     " (broken, workaround, fixed)"
 
+void spapr_check_pagesize(sPAPRMachineState *spapr, hwaddr pagesize,
+                          Error **errp)
+{
+    hwaddr maxpagesize = (1ULL << spapr->eff.caps[SPAPR_CAP_HPT_MPS]);
+
+    if (!kvmppc_hpt_needs_host_contiguous_pages()) {
+        return;
+    }
+
+    if (maxpagesize > pagesize) {
+        error_setg(errp,
+                   "Can't support %"HWADDR_PRIu" kiB guest pages with %"
+                   HWADDR_PRIu" kiB host pages with this KVM implementation",
+                   maxpagesize >> 10, pagesize >> 10);
+    }
+}
+
 static void cap_hpt_maxpagesize_apply(sPAPRMachineState *spapr,
                                       uint8_t val, Error **errp)
 {
@@ -312,6 +330,8 @@ static void cap_hpt_maxpagesize_apply(sPAPRMachineState *spapr,
     } else if (val < 16) {
         warn_report("Many guests require at least 64kiB hpt-max-page-size");
     }
+
+    spapr_check_pagesize(spapr, qemu_getrampagesize(), errp);
 }
 
 sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index c97593d032..75e2cf2687 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -806,4 +806,7 @@ void spapr_caps_cpu_apply(sPAPRMachineState *spapr, PowerPCCPU *cpu);
 void spapr_caps_add_properties(sPAPRMachineClass *smc, Error **errp);
 int spapr_caps_post_migration(sPAPRMachineState *spapr);
 
+void spapr_check_pagesize(sPAPRMachineState *spapr, hwaddr pagesize,
+                          Error **errp);
+
 #endif /* HW_SPAPR_H */
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 50b5d01432..9cfbd388ad 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -500,26 +500,12 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
         cpu->hash64_opts->flags &= ~PPC_HASH64_1TSEG;
     }
 }
-
-bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
-{
-    Object *mem_obj = object_resolve_path(obj_path, NULL);
-    long pagesize = host_memory_backend_pagesize(MEMORY_BACKEND(mem_obj));
-
-    return pagesize >= max_cpu_page_size;
-}
-
 #else /* defined (TARGET_PPC64) */
 
 static inline void kvm_fixup_page_sizes(PowerPCCPU *cpu)
 {
 }
 
-bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
-{
-    return true;
-}
-
 #endif /* !defined (TARGET_PPC64) */
 
 unsigned long kvm_arch_vcpu_id(CPUState *cpu)
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index a7ddb8a5d6..443fca0a4e 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -71,7 +71,6 @@ int kvmppc_resize_hpt_commit(PowerPCCPU *cpu, target_ulong flags, int shift);
 bool kvmppc_pvr_workaround_required(PowerPCCPU *cpu);
 
 bool kvmppc_hpt_needs_host_contiguous_pages(void);
-bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path);
 
 #else
 
@@ -228,11 +227,6 @@ static inline bool kvmppc_hpt_needs_host_contiguous_pages(void)
     return false;
 }
 
-static inline bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
-{
-    return true;
-}
-
 static inline bool kvmppc_has_cap_spapr_vfio(void)
 {
     return false;
-- 
2.17.1
