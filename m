Received: from eggs.gnu.org ([2001:4830:134:3::10]:56650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dufmj-00042U-V4
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:15:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dufmi-0005PD-2N
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:15:29 -0400
Received: from ozlabs.ru ([107.173.13.209]:59858)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dufmh-0005P4-OI
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:15:28 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 20 Sep 2017 21:46:35 +1000
Message-Id: <20170920114637.42004-17-aik@ozlabs.ru>
In-Reply-To: <20170920114637.42004-1-aik@ozlabs.ru>
References: <20170920114637.42004-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v4 16/18] memory: Get rid of
 address_space_init_shareable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>

Since FlatViews are shared now and ASes not, this gets rid of
address_space_init_shareable().

This should cause no behavioural change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v3:
* now removes @malloced and @ref_count, used to be in the previos patch
---
 include/exec/memory.h   | 19 -------------------
 include/hw/arm/armv7m.h |  2 +-
 cpus.c                  |  5 +++--
 hw/arm/armv7m.c         |  9 ++++-----
 memory.c                | 22 +---------------------
 target/arm/cpu.c        | 16 ++++++++--------
 target/i386/cpu.c       |  5 +++--
 7 files changed, 20 insertions(+), 58 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 2f4f56cf40..402824c6f2 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -309,8 +309,6 @@ struct AddressSpace {
     struct rcu_head rcu;
     char *name;
     MemoryRegion *root;
-    int ref_count;
-    bool malloced;
 
     /* Accessed via RCU.  */
     struct FlatView *current_map;
@@ -1586,23 +1584,6 @@ MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
 void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name);
 
 /**
- * address_space_init_shareable: return an address space for a memory region,
- *                               creating it if it does not already exist
- *
- * @root: a #MemoryRegion that routes addresses for the address space
- * @name: an address space name.  The name is only used for debugging
- *        output.
- *
- * This function will return a pointer to an existing AddressSpace
- * which was initialized with the specified MemoryRegion, or it will
- * create and initialize one if it does not already exist. The ASes
- * are reference-counted, so the memory will be freed automatically
- * when the AddressSpace is destroyed via address_space_destroy.
- */
-AddressSpace *address_space_init_shareable(MemoryRegion *root,
-                                           const char *name);
-
-/**
  * address_space_destroy: destroy an address space
  *
  * Releases all resources associated with an address space.  After an address space
diff --git a/include/hw/arm/armv7m.h b/include/hw/arm/armv7m.h
index 10eb058027..008000fe11 100644
--- a/include/hw/arm/armv7m.h
+++ b/include/hw/arm/armv7m.h
@@ -21,7 +21,7 @@ typedef struct {
     SysBusDevice parent_obj;
     /*< public >*/
 
-    AddressSpace *source_as;
+    AddressSpace source_as;
     MemoryRegion iomem;
     uint32_t base;
     MemoryRegion *source_memory;
diff --git a/cpus.c b/cpus.c
index 9bed61eefc..c9a624003a 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1764,8 +1764,9 @@ void qemu_init_vcpu(CPUState *cpu)
         /* If the target cpu hasn't set up any address spaces itself,
          * give it the default one.
          */
-        AddressSpace *as = address_space_init_shareable(cpu->memory,
-                                                        "cpu-memory");
+        AddressSpace *as = g_new0(AddressSpace, 1);
+
+        address_space_init(as, cpu->memory, "cpu-memory");
         cpu->num_ases = 1;
         cpu_address_space_init(cpu, as, 0);
     }
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index b64a409b40..4900339646 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -41,7 +41,7 @@ static MemTxResult bitband_read(void *opaque, hwaddr offset,
 
     /* Find address in underlying memory and round down to multiple of size */
     addr = bitband_addr(s, offset) & (-size);
-    res = address_space_read(s->source_as, addr, attrs, buf, size);
+    res = address_space_read(&s->source_as, addr, attrs, buf, size);
     if (res) {
         return res;
     }
@@ -66,7 +66,7 @@ static MemTxResult bitband_write(void *opaque, hwaddr offset, uint64_t value,
 
     /* Find address in underlying memory and round down to multiple of size */
     addr = bitband_addr(s, offset) & (-size);
-    res = address_space_read(s->source_as, addr, attrs, buf, size);
+    res = address_space_read(&s->source_as, addr, attrs, buf, size);
     if (res) {
         return res;
     }
@@ -79,7 +79,7 @@ static MemTxResult bitband_write(void *opaque, hwaddr offset, uint64_t value,
     } else {
         buf[bitpos >> 3] &= ~bit;
     }
-    return address_space_write(s->source_as, addr, attrs, buf, size);
+    return address_space_write(&s->source_as, addr, attrs, buf, size);
 }
 
 static const MemoryRegionOps bitband_ops = {
@@ -111,8 +111,7 @@ static void bitband_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    s->source_as = address_space_init_shareable(s->source_memory,
-                                                "bitband-source");
+    address_space_init(&s->source_as, s->source_memory, "bitband-source");
 }
 
 /* Board init.  */
diff --git a/memory.c b/memory.c
index 92b1304a20..25000d1035 100644
--- a/memory.c
+++ b/memory.c
@@ -2732,9 +2732,7 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
 {
     memory_region_ref(root);
     memory_region_transaction_begin();
-    as->ref_count = 1;
     as->root = root;
-    as->malloced = false;
     as->current_map = NULL;
     as->ioeventfd_nb = 0;
     as->ioeventfds = NULL;
@@ -2747,37 +2745,19 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
 
 static void do_address_space_destroy(AddressSpace *as)
 {
-    bool do_free = as->malloced;
-
     assert(QTAILQ_EMPTY(&as->listeners));
 
     flatview_unref(as->current_map);
     g_free(as->name);
     g_free(as->ioeventfds);
     memory_region_unref(as->root);
-    if (do_free) {
-        g_free(as);
-    }
-}
-
-AddressSpace *address_space_init_shareable(MemoryRegion *root, const char *name)
-{
-    AddressSpace *as;
-
-    as = g_malloc0(sizeof *as);
-    address_space_init(as, root, name);
-    as->malloced = true;
-    return as;
+    g_free(as);
 }
 
 void address_space_destroy(AddressSpace *as)
 {
     MemoryRegion *root = as->root;
 
-    as->ref_count--;
-    if (as->ref_count) {
-        return;
-    }
     /* Flush out anything from MemoryListeners listening in on this */
     memory_region_transaction_begin();
     as->root = NULL;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 412e94c7ad..bba24f4590 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -684,6 +684,9 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     CPUARMState *env = &cpu->env;
     int pagebits;
     Error *local_err = NULL;
+#ifndef CONFIG_USER_ONLY
+    AddressSpace *as;
+#endif
 
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
@@ -874,24 +877,21 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 
 #ifndef CONFIG_USER_ONLY
     if (cpu->has_el3 || arm_feature(env, ARM_FEATURE_M_SECURITY)) {
-        AddressSpace *as;
+        as = g_new0(AddressSpace, 1);
 
         cs->num_ases = 2;
 
         if (!cpu->secure_memory) {
             cpu->secure_memory = cs->memory;
         }
-        as = address_space_init_shareable(cpu->secure_memory,
-                                          "cpu-secure-memory");
+        address_space_init(as, cpu->secure_memory, "cpu-secure-memory");
         cpu_address_space_init(cs, as, ARMASIdx_S);
     } else {
         cs->num_ases = 1;
     }
-
-    cpu_address_space_init(cs,
-                           address_space_init_shareable(cs->memory,
-                                                        "cpu-memory"),
-                           ARMASIdx_NS);
+    as = g_new0(AddressSpace, 1);
+    address_space_init(as, cs->memory, "cpu-memory");
+    cpu_address_space_init(cs, as, ARMASIdx_NS);
 #endif
 
     qemu_init_vcpu(cs);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4b0fa0613b..b0b123a571 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3741,10 +3741,11 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 
 #ifndef CONFIG_USER_ONLY
     if (tcg_enabled()) {
-        AddressSpace *as_normal = address_space_init_shareable(cs->memory,
-                                                               "cpu-memory");
+        AddressSpace *as_normal = g_new0(AddressSpace, 1);
         AddressSpace *as_smm = g_new(AddressSpace, 1);
 
+        address_space_init(as_normal, cs->memory, "cpu-memory");
+
         cpu->cpu_as_mem = g_new(MemoryRegion, 1);
         cpu->cpu_as_root = g_new(MemoryRegion, 1);
 
-- 
2.11.0
