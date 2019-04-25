Received: from eggs.gnu.org ([209.51.188.92]:58766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeKZ-0003o1-32
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:22:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeKX-000459-I9
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:22:27 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 25 Apr 2019 15:21:33 +0200
Message-Id: <20190425132134.2839-19-cohuck@redhat.com>
In-Reply-To: <20190425132134.2839-1-cohuck@redhat.com>
References: <20190425132134.2839-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 18/19] s390x/kvm: Configure page size after
 memory has actually been initialized
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Right now we configure the pagesize quite early, when initializing KVM.
This is long before system memory is actually allocated via
memory_region_allocate_system_memory(), and therefore memory backends
marked as mapped.

Instead, let's configure the maximum page size after initializing
memory in s390_memory_init(). cap_hpage_1m is still properly
configured before creating any CPUs, and therefore before configuring
the CPU model and eventually enabling CMMA.

This is not a fix but rather a preparation for the future, when initial
memory might reside on memory backends (not the case for s390x right now)
We will replace qemu_getrampagesize() soon by a function that will always
return the maximum page size (not the minimum page size, which only
works by pure luck so far, as there are no memory backends).

Acked-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190417113143.5551-2-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 12 ++++++++++++
 target/s390x/cpu.c         |  7 +++++++
 target/s390x/cpu.h         |  1 +
 target/s390x/kvm-stub.c    |  4 ++++
 target/s390x/kvm.c         | 35 ++++++++++++++---------------------
 target/s390x/kvm_s390x.h   |  1 +
 6 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index d11069b860b4..3be567965736 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -15,6 +15,7 @@
 #include "cpu.h"
 #include "hw/boards.h"
 #include "exec/address-spaces.h"
+#include "exec/ram_addr.h"
 #include "hw/s390x/s390-virtio-hcall.h"
 #include "hw/s390x/sclp.h"
 #include "hw/s390x/s390_flic.h"
@@ -163,6 +164,7 @@ static void s390_memory_init(ram_addr_t mem_size)
     MemoryRegion *sysmem = get_system_memory();
     ram_addr_t chunk, offset = 0;
     unsigned int number = 0;
+    Error *local_err = NULL;
     gchar *name;
 
     /* allocate RAM for core */
@@ -182,6 +184,15 @@ static void s390_memory_init(ram_addr_t mem_size)
     }
     g_free(name);
 
+    /*
+     * Configure the maximum page size. As no memory devices were created
+     * yet, this is the page size of initial memory only.
+     */
+    s390_set_max_pagesize(qemu_getrampagesize(), &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        exit(EXIT_FAILURE);
+    }
     /* Initialize storage key device */
     s390_skeys_init();
     /* Initialize storage attributes device */
@@ -253,6 +264,7 @@ static void ccw_init(MachineState *machine)
     DeviceState *dev;
 
     s390_sclp_init();
+    /* init memory + setup max page size. Required for the CPU model */
     s390_memory_init(machine->ram_size);
 
     /* init CPUs (incl. CPU model) early so s390_has_feature() works */
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 698dd9cb82ab..b58ef0a8ef62 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -399,6 +399,13 @@ int s390_set_memory_limit(uint64_t new_limit, uint64_t *hw_limit)
     return 0;
 }
 
+void s390_set_max_pagesize(uint64_t pagesize, Error **errp)
+{
+    if (kvm_enabled()) {
+        kvm_s390_set_max_pagesize(pagesize, errp);
+    }
+}
+
 void s390_cmma_reset(void)
 {
     if (kvm_enabled()) {
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index d8990c405a5d..7305cacc7b77 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -734,6 +734,7 @@ static inline void s390_do_cpu_load_normal(CPUState *cs, run_on_cpu_data arg)
 /* cpu.c */
 void s390_crypto_reset(void);
 int s390_set_memory_limit(uint64_t new_limit, uint64_t *hw_limit);
+void s390_set_max_pagesize(uint64_t pagesize, Error **errp);
 void s390_cmma_reset(void);
 void s390_enable_css_support(S390CPU *cpu);
 int s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch_id,
diff --git a/target/s390x/kvm-stub.c b/target/s390x/kvm-stub.c
index bf7795e47a1c..22b4514ca68c 100644
--- a/target/s390x/kvm-stub.c
+++ b/target/s390x/kvm-stub.c
@@ -93,6 +93,10 @@ int kvm_s390_set_mem_limit(uint64_t new_limit, uint64_t *hw_limit)
     return 0;
 }
 
+void kvm_s390_set_max_pagesize(uint64_t pagesize, Error **errp)
+{
+}
+
 void kvm_s390_crypto_reset(void)
 {
 }
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 2c6e35b5aafe..7df7be4a1bdc 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -283,44 +283,37 @@ void kvm_s390_crypto_reset(void)
     }
 }
 
-static int kvm_s390_configure_mempath_backing(KVMState *s)
+void kvm_s390_set_max_pagesize(uint64_t pagesize, Error **errp)
 {
-    size_t path_psize = qemu_getrampagesize();
-
-    if (path_psize == 4 * KiB) {
-        return 0;
+    if (pagesize == 4 * KiB) {
+        return;
     }
 
     if (!hpage_1m_allowed()) {
-        error_report("This QEMU machine does not support huge page "
-                     "mappings");
-        return -EINVAL;
+        error_setg(errp, "This QEMU machine does not support huge page "
+                   "mappings");
+        return;
     }
 
-    if (path_psize != 1 * MiB) {
-        error_report("Memory backing with 2G pages was specified, "
-                     "but KVM does not support this memory backing");
-        return -EINVAL;
+    if (pagesize != 1 * MiB) {
+        error_setg(errp, "Memory backing with 2G pages was specified, "
+                   "but KVM does not support this memory backing");
+        return;
     }
 
-    if (kvm_vm_enable_cap(s, KVM_CAP_S390_HPAGE_1M, 0)) {
-        error_report("Memory backing with 1M pages was specified, "
-                     "but KVM does not support this memory backing");
-        return -EINVAL;
+    if (kvm_vm_enable_cap(kvm_state, KVM_CAP_S390_HPAGE_1M, 0)) {
+        error_setg(errp, "Memory backing with 1M pages was specified, "
+                   "but KVM does not support this memory backing");
+        return;
     }
 
     cap_hpage_1m = 1;
-    return 0;
 }
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
 
-    if (kvm_s390_configure_mempath_backing(s)) {
-        return -EINVAL;
-    }
-
     mc->default_cpu_type = S390_CPU_TYPE_NAME("host");
     cap_sync_regs = kvm_check_extension(s, KVM_CAP_SYNC_REGS);
     cap_async_pf = kvm_check_extension(s, KVM_CAP_ASYNC_PF);
diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
index 6e52287da3f0..caf985955ba5 100644
--- a/target/s390x/kvm_s390x.h
+++ b/target/s390x/kvm_s390x.h
@@ -36,6 +36,7 @@ int kvm_s390_cmma_active(void);
 void kvm_s390_cmma_reset(void);
 void kvm_s390_reset_vcpu(S390CPU *cpu);
 int kvm_s390_set_mem_limit(uint64_t new_limit, uint64_t *hw_limit);
+void kvm_s390_set_max_pagesize(uint64_t pagesize, Error **errp);
 void kvm_s390_crypto_reset(void);
 void kvm_s390_restart_interrupt(S390CPU *cpu);
 void kvm_s390_stop_interrupt(S390CPU *cpu);
-- 
2.17.2
