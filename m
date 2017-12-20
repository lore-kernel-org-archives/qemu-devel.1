Received: from eggs.gnu.org ([2001:4830:134:3::10]:56461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyQ-0004jT-ET
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyM-0007GV-SF
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:06 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:33598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRhyM-0007G6-Hl
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:02 -0500
Received: by mail-wr0-x242.google.com with SMTP id v21so12206703wrc.0
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 09:16:02 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 18:14:37 +0100
Message-Id: <1513790098-9815-26-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 25/46] cpu: refactor cpu_address_space_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

Normally we create an address space for that CPU and pass that address
space into the function.  Let's just do it inside to unify address space
creations.  It'll simplify my next patch to rename those address spaces.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20171123092333.16085-3-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c                  |  5 +----
 exec.c                  |  7 ++++++-
 include/exec/exec-all.h |  6 ++++--
 target/arm/cpu.c        | 13 +++----------
 target/i386/cpu.c       | 10 ++--------
 5 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/cpus.c b/cpus.c
index 3740c4d..83700c1 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1787,11 +1787,8 @@ void qemu_init_vcpu(CPUState *cpu)
         /* If the target cpu hasn't set up any address spaces itself,
          * give it the default one.
          */
-        AddressSpace *as = g_new0(AddressSpace, 1);
-
-        address_space_init(as, cpu->memory, "cpu-memory");
         cpu->num_ases = 1;
-        cpu_address_space_init(cpu, as, 0);
+        cpu_address_space_init(cpu, 0, "cpu-memory", cpu->memory);
     }
 
     if (kvm_enabled()) {
diff --git a/exec.c b/exec.c
index 3e7c57e..3ab515e 100644
--- a/exec.c
+++ b/exec.c
@@ -705,9 +705,14 @@ CPUState *qemu_get_cpu(int index)
 }
 
 #if !defined(CONFIG_USER_ONLY)
-void cpu_address_space_init(CPUState *cpu, AddressSpace *as, int asidx)
+void cpu_address_space_init(CPUState *cpu, int asidx,
+                            const char *prefix, MemoryRegion *mr)
 {
     CPUAddressSpace *newas;
+    AddressSpace *as = g_new0(AddressSpace, 1);
+
+    assert(mr);
+    address_space_init(as, mr, prefix);
 
     /* Target code should have set num_ases before calling us */
     assert(asidx < cpu->num_ases);
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 0f51c92..b37f7d8 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -74,8 +74,9 @@ void cpu_reloading_memory_map(void);
 /**
  * cpu_address_space_init:
  * @cpu: CPU to add this address space to
- * @as: address space to add
  * @asidx: integer index of this address space
+ * @prefix: prefix to be used as name of address space
+ * @mr: the root memory region of address space
  *
  * Add the specified address space to the CPU's cpu_ases list.
  * The address space added with @asidx 0 is the one used for the
@@ -89,7 +90,8 @@ void cpu_reloading_memory_map(void);
  *
  * Note that with KVM only one address space is supported.
  */
-void cpu_address_space_init(CPUState *cpu, AddressSpace *as, int asidx);
+void cpu_address_space_init(CPUState *cpu, int asidx,
+                            const char *prefix, MemoryRegion *mr);
 #endif
 
 #if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7f7a3d1..cc1856c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -705,9 +705,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     CPUARMState *env = &cpu->env;
     int pagebits;
     Error *local_err = NULL;
-#ifndef CONFIG_USER_ONLY
-    AddressSpace *as;
-#endif
 
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
@@ -912,21 +909,17 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 
 #ifndef CONFIG_USER_ONLY
     if (cpu->has_el3 || arm_feature(env, ARM_FEATURE_M_SECURITY)) {
-        as = g_new0(AddressSpace, 1);
-
         cs->num_ases = 2;
 
         if (!cpu->secure_memory) {
             cpu->secure_memory = cs->memory;
         }
-        address_space_init(as, cpu->secure_memory, "cpu-secure-memory");
-        cpu_address_space_init(cs, as, ARMASIdx_S);
+        cpu_address_space_init(cs, ARMASIdx_S, "cpu-secure-memory",
+                               cpu->secure_memory);
     } else {
         cs->num_ases = 1;
     }
-    as = g_new0(AddressSpace, 1);
-    address_space_init(as, cs->memory, "cpu-memory");
-    cpu_address_space_init(cs, as, ARMASIdx_NS);
+    cpu_address_space_init(cs, ARMASIdx_NS, "cpu-memory", cs->memory);
 #endif
 
     qemu_init_vcpu(cs);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 325b52e..b069eaf 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3736,11 +3736,6 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 
 #ifndef CONFIG_USER_ONLY
     if (tcg_enabled()) {
-        AddressSpace *as_normal = g_new0(AddressSpace, 1);
-        AddressSpace *as_smm = g_new(AddressSpace, 1);
-
-        address_space_init(as_normal, cs->memory, "cpu-memory");
-
         cpu->cpu_as_mem = g_new(MemoryRegion, 1);
         cpu->cpu_as_root = g_new(MemoryRegion, 1);
 
@@ -3755,11 +3750,10 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
                                  get_system_memory(), 0, ~0ull);
         memory_region_add_subregion_overlap(cpu->cpu_as_root, 0, cpu->cpu_as_mem, 0);
         memory_region_set_enabled(cpu->cpu_as_mem, true);
-        address_space_init(as_smm, cpu->cpu_as_root, "CPU");
 
         cs->num_ases = 2;
-        cpu_address_space_init(cs, as_normal, 0);
-        cpu_address_space_init(cs, as_smm, 1);
+        cpu_address_space_init(cs, 0, "cpu-memory", cs->memory);
+        cpu_address_space_init(cs, 1, "cpu-smm", cpu->cpu_as_root);
 
         /* ... SMRAM with higher priority, linked from /machine/smram.  */
         cpu->machine_done.notify = x86_cpu_machine_done;
-- 
1.8.3.1
