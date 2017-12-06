Received: from eggs.gnu.org ([2001:4830:134:3::10]:48933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCB-0000Kp-H2
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfC8-0000J3-Bl
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60084
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfC8-0000I0-49
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:24 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JEAJ1037337
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:23 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2epne8b89u-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:23 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 12:17:22 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:13 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-21-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 20/55] memory: Get rid of
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
Cc: qemu-stable@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

Since FlatViews are shared now and ASes not, this gets rid of
address_space_init_shareable().

This should cause no behavioural change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20170921085110.25598-17-aik@ozlabs.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit b516572f31c0ea0937cd9d11d9bd72dd83809886)
 Conflicts:
	target/arm/cpu.c
* drop context deps on 1d2091bc and 1e577cc7
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 cpus.c                  |  5 +++--
 hw/arm/armv7m.c         |  9 ++++-----
 include/exec/memory.h   | 19 -------------------
 include/hw/arm/armv7m.h |  2 +-
 memory.c                | 21 ---------------------
 target/arm/cpu.c        | 15 ++++++++-------
 target/i386/cpu.c       |  5 +++--
 7 files changed, 19 insertions(+), 57 deletions(-)

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
index c8a11f2b53..475a88fc56 100644
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
@@ -117,8 +117,7 @@ static void bitband_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    s->source_as = address_space_init_shareable(s->source_memory,
-                                                "bitband-source");
+    address_space_init(&s->source_as, s->source_memory, "bitband-source");
 }
 
 /* Board init.  */
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 6715551fc6..631daf0cce 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -319,8 +319,6 @@ struct AddressSpace {
     struct rcu_head rcu;
     char *name;
     MemoryRegion *root;
-    int ref_count;
-    bool malloced;
 
     /* Accessed via RCU.  */
     struct FlatView *current_map;
@@ -1595,23 +1593,6 @@ MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
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
index a9b3f2ab35..dba77dfa39 100644
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
diff --git a/memory.c b/memory.c
index 6914d87d0d..2e0def18ee 100644
--- a/memory.c
+++ b/memory.c
@@ -2721,9 +2721,7 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
 {
     memory_region_ref(root);
     memory_region_transaction_begin();
-    as->ref_count = 1;
     as->root = root;
-    as->malloced = false;
     as->current_map = NULL;
     as->ioeventfd_nb = 0;
     as->ioeventfds = NULL;
@@ -2736,37 +2734,18 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
 
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
index 05c038bf17..24ef71ad8b 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -650,6 +650,9 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     CPUARMState *env = &cpu->env;
     int pagebits;
     Error *local_err = NULL;
+#ifndef CONFIG_USER_ONLY
+    AddressSpace *as;
+#endif
 
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
@@ -835,19 +838,17 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
     if (cpu->has_el3) {
-        AddressSpace *as;
+        as = g_new0(AddressSpace, 1);
 
         if (!cpu->secure_memory) {
             cpu->secure_memory = cs->memory;
         }
-        as = address_space_init_shareable(cpu->secure_memory,
-                                          "cpu-secure-memory");
+        address_space_init(as, cpu->secure_memory, "cpu-secure-memory");
         cpu_address_space_init(cs, as, ARMASIdx_S);
     }
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
index ddc45abd70..df73958b82 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3702,10 +3702,11 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 
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
