Received: from eggs.gnu.org ([2001:4830:134:3::10]:52218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eI8VN-0002zh-31
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:34:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eI8VM-0004rP-0d
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:34:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eI8VL-0004qs-OH
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:34:31 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri, 24 Nov 2017 15:34:17 +0800
Message-Id: <20171124073417.4342-4-peterx@redhat.com>
In-Reply-To: <20171124073417.4342-1-peterx@redhat.com>
References: <20171124073417.4342-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/3] cpu: put AddressSpace into
 CPUAddressSpace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, peterx@redhat.com

Now we can put AddressSpace into CPUAddressSpace struct, then we don't
need dynamic allocation of AddressSpaces.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 exec.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/exec.c b/exec.c
index 41f89f8164..511217f38c 100644
--- a/exec.c
+++ b/exec.c
@@ -221,7 +221,7 @@ static MemoryRegion io_mem_watch;
  */
 struct CPUAddressSpace {
     CPUState *cpu;
-    AddressSpace *as;
+    AddressSpace as;
     struct AddressSpaceDispatch *memory_dispatch;
     MemoryListener tcg_as_listener;
 };
@@ -712,10 +712,19 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
                             const char *prefix, MemoryRegion *mr)
 {
     CPUAddressSpace *newas;
-    AddressSpace *as = g_new0(AddressSpace, 1);
+    AddressSpace *as;
     char *as_name;
 
     assert(mr);
+
+    if (!cpu->cpu_ases) {
+        /* This should be setup before calling the function. */
+        assert(cpu->num_ases > 0);
+        cpu->cpu_ases = g_new0(CPUAddressSpace, cpu->num_ases);
+    }
+    newas = &cpu->cpu_ases[asidx];
+    as = &newas->as;
+
     as_name = g_strdup_printf("%s-%d", prefix, cpu->cpu_index);
     address_space_init(as, mr, as_name);
     g_free(as_name);
@@ -731,13 +740,7 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
     /* KVM cannot currently support multiple address spaces. */
     assert(asidx == 0 || !kvm_enabled());
 
-    if (!cpu->cpu_ases) {
-        cpu->cpu_ases = g_new0(CPUAddressSpace, cpu->num_ases);
-    }
-
-    newas = &cpu->cpu_ases[asidx];
     newas->cpu = cpu;
-    newas->as = as;
     if (tcg_enabled()) {
         newas->tcg_as_listener.commit = tcg_commit;
         memory_listener_register(&newas->tcg_as_listener, as);
@@ -747,7 +750,7 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
 AddressSpace *cpu_get_address_space(CPUState *cpu, int asidx)
 {
     /* Return the AddressSpace corresponding to the specified index */
-    return cpu->cpu_ases[asidx].as;
+    return &cpu->cpu_ases[asidx].as;
 }
 #endif
 
@@ -830,7 +833,7 @@ static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
     int asidx = cpu_asidx_from_attrs(cpu, attrs);
     if (phys != -1) {
         /* Locks grabbed by tb_invalidate_phys_addr */
-        tb_invalidate_phys_addr(cpu->cpu_ases[asidx].as,
+        tb_invalidate_phys_addr(cpu_get_address_space(cpu, asidx),
                                 phys | (pc & ~TARGET_PAGE_MASK));
     }
 }
@@ -2518,7 +2521,7 @@ static MemTxResult watch_mem_read(void *opaque, hwaddr addr, uint64_t *pdata,
     MemTxResult res;
     uint64_t data;
     int asidx = cpu_asidx_from_attrs(current_cpu, attrs);
-    AddressSpace *as = current_cpu->cpu_ases[asidx].as;
+    AddressSpace *as = cpu_get_address_space(current_cpu, asidx);
 
     check_watchpoint(addr & ~TARGET_PAGE_MASK, size, attrs, BP_MEM_READ);
     switch (size) {
@@ -2546,7 +2549,7 @@ static MemTxResult watch_mem_write(void *opaque, hwaddr addr,
 {
     MemTxResult res;
     int asidx = cpu_asidx_from_attrs(current_cpu, attrs);
-    AddressSpace *as = current_cpu->cpu_ases[asidx].as;
+    AddressSpace *as = cpu_get_address_space(current_cpu, asidx);
 
     check_watchpoint(addr & ~TARGET_PAGE_MASK, size, attrs, BP_MEM_WRITE);
     switch (size) {
@@ -2793,7 +2796,7 @@ static void tcg_commit(MemoryListener *listener)
      * We reload the dispatch pointer now because cpu_reloading_memory_map()
      * may have split the RCU critical section.
      */
-    d = address_space_to_dispatch(cpuas->as);
+    d = address_space_to_dispatch(&cpuas->as);
     atomic_rcu_set(&cpuas->memory_dispatch, d);
     tlb_flush(cpuas->cpu);
 }
@@ -3539,10 +3542,10 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
             l = len;
         phys_addr += (addr & ~TARGET_PAGE_MASK);
         if (is_write) {
-            cpu_physical_memory_write_rom(cpu->cpu_ases[asidx].as,
+            cpu_physical_memory_write_rom(cpu_get_address_space(cpu, asidx),
                                           phys_addr, buf, l);
         } else {
-            address_space_rw(cpu->cpu_ases[asidx].as, phys_addr,
+            address_space_rw(cpu_get_address_space(cpu, asidx), phys_addr,
                              MEMTXATTRS_UNSPECIFIED,
                              buf, l, 0);
         }
-- 
2.14.3
