Received: from eggs.gnu.org ([2001:4830:134:3::10]:41846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSHZa-0004U8-Tr
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSHZZ-0003CY-Lt
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dSHZZ-0003CE-Cp
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4CB9B80462
	for <qemu-devel@nongnu.org>; Tue,  4 Jul 2017 06:44:32 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Tue,  4 Jul 2017 14:43:46 +0800
Message-Id: <20170704064347.7022-20-famz@redhat.com>
In-Reply-To: <20170704064347.7022-1-famz@redhat.com>
References: <20170704064347.7022-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 19/20] cpu: Convert to DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 cpus.c            |  5 +++--
 exec.c            | 30 ++++++++++++++++--------------
 include/qom/cpu.h |  4 +++-
 qom/cpu.c         |  1 +
 target/arm/cpu.c  |  6 +++---
 target/i386/cpu.c |  5 +++--
 6 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/cpus.c b/cpus.c
index 14bb8d5..708ee78 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1764,8 +1764,9 @@ void qemu_init_vcpu(CPUState *cpu)
         /* If the target cpu hasn't set up any address spaces itself,
          * give it the default one.
          */
-        AddressSpace *as = address_space_init_shareable(cpu->memory,
-                                                        "cpu-memory");
+        AddressSpace *as =
+            address_space_init_shareable(MEMORY_REGION(cpu->memory),
+                                         "cpu-memory");
         cpu->num_ases = 1;
         cpu_address_space_init(cpu, as, 0);
     }
diff --git a/exec.c b/exec.c
index 42ad1ea..26a4f0f 100644
--- a/exec.c
+++ b/exec.c
@@ -27,6 +27,7 @@
 #include "exec/target_page.h"
 #include "tcg.h"
 #include "hw/qdev-core.h"
+#include "hw/qdev-properties.h"
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/boards.h"
 #include "hw/xen/xen.h"
@@ -730,6 +731,19 @@ void cpu_exec_unrealizefn(CPUState *cpu)
     }
 }
 
+Property cpu_common_props[] = {
+#ifndef CONFIG_USER_ONLY
+    /* Create a memory property for softmmu CPU object,
+     * so users can wire up its memory. (This can't go in qom/cpu.c
+     * because that file is compiled only once for both user-mode
+     * and system builds.) The default if no link is set up is to use
+     * the system address space.
+     */
+    DEFINE_PROP_LINK("memory", CPUState, memory, TYPE_MEMORY_REGION),
+#endif
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 void cpu_exec_initfn(CPUState *cpu)
 {
     cpu->as = NULL;
@@ -737,20 +751,8 @@ void cpu_exec_initfn(CPUState *cpu)
 
 #ifndef CONFIG_USER_ONLY
     cpu->thread_id = qemu_get_thread_id();
-
-    /* This is a softmmu CPU object, so create a property for it
-     * so users can wire up its memory. (This can't go in qom/cpu.c
-     * because that file is compiled only once for both user-mode
-     * and system builds.) The default if no link is set up is to use
-     * the system address space.
-     */
-    object_property_add_link(OBJECT(cpu), "memory", TYPE_MEMORY_REGION,
-                             (Object **)&cpu->memory,
-                             qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
-                             &error_abort);
-    cpu->memory = system_memory;
-    object_ref(OBJECT(cpu->memory));
+    cpu->memory = OBJECT(system_memory);
+    object_ref(cpu->memory);
 #endif
 }
 
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 2fe7cff..9857781 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -342,7 +342,8 @@ struct CPUState {
     CPUAddressSpace *cpu_ases;
     int num_ases;
     AddressSpace *as;
-    MemoryRegion *memory;
+    /* Memory region pointer to be filled by link property */
+    Object *memory;
 
     void *env_ptr; /* CPUArchState */
 
@@ -1010,6 +1011,7 @@ AddressSpace *cpu_get_address_space(CPUState *cpu, int asidx);
 
 void QEMU_NORETURN cpu_abort(CPUState *cpu, const char *fmt, ...)
     GCC_FMT_ATTR(2, 3);
+extern Property cpu_common_props[];
 void cpu_exec_initfn(CPUState *cpu);
 void cpu_exec_realizefn(CPUState *cpu, Error **errp);
 void cpu_exec_unrealizefn(CPUState *cpu);
diff --git a/qom/cpu.c b/qom/cpu.c
index 585419b..071551c 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -446,6 +446,7 @@ static void cpu_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_CPU, dc->categories);
     dc->realize = cpu_common_realizefn;
     dc->unrealize = cpu_common_unrealizefn;
+    dc->props = cpu_common_props;
     /*
      * Reason: CPUs still need special care by board code: wiring up
      * IRQs, adding reset handlers, halting non-first CPUs, ...
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 28a9141..9b5968b 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -817,14 +817,14 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         AddressSpace *as;
 
         if (!cpu->secure_memory) {
-            cpu->secure_memory = cs->memory;
+            cpu->secure_memory = MEMORY_REGION(cs->memory);
         }
-        as = address_space_init_shareable(cpu->secure_memory,
+        as = address_space_init_shareable(MEMORY_REGION(cpu->secure_memory),
                                           "cpu-secure-memory");
         cpu_address_space_init(cs, as, ARMASIdx_S);
     }
     cpu_address_space_init(cs,
-                           address_space_init_shareable(cs->memory,
+                           address_space_init_shareable(MEMORY_REGION(cs->memory),
                                                         "cpu-memory"),
                            ARMASIdx_NS);
 #endif
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fce277b..4f1c9fa 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3615,8 +3615,9 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 
 #ifndef CONFIG_USER_ONLY
     if (tcg_enabled()) {
-        AddressSpace *as_normal = address_space_init_shareable(cs->memory,
-                                                               "cpu-memory");
+        AddressSpace *as_normal =
+            address_space_init_shareable(MEMORY_REGION(cs->memory),
+                                         "cpu-memory");
         AddressSpace *as_smm = g_new(AddressSpace, 1);
 
         cpu->cpu_as_mem = g_new(MemoryRegion, 1);
-- 
2.9.4
