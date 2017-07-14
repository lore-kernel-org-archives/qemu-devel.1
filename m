Received: from eggs.gnu.org ([2001:4830:134:3::10]:42577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVxYj-0000Qb-OM
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVxYi-00056C-Nt
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:53 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35089)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVxYi-00055R-33
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:52 -0400
Received: by mail-wm0-x244.google.com with SMTP id u23so9970259wma.2
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 03:10:52 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 14 Jul 2017 12:10:27 +0200
Message-Id: <1500027028-4127-16-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1500027028-4127-1-git-send-email-pbonzini@redhat.com>
References: <1500027028-4127-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 54/55] cpu: Convert to DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>

From: Fam Zheng <famz@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170714021509.23681-20-famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c            | 27 +++++++++++++++------------
 include/qom/cpu.h |  1 +
 qom/cpu.c         |  1 +
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/exec.c b/exec.c
index b3c080f..01ac21e 100644
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
@@ -737,6 +738,20 @@ void cpu_exec_unrealizefn(CPUState *cpu)
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
+    DEFINE_PROP_LINK("memory", CPUState, memory, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
+#endif
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 void cpu_exec_initfn(CPUState *cpu)
 {
     cpu->as = NULL;
@@ -744,18 +759,6 @@ void cpu_exec_initfn(CPUState *cpu)
 
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
     cpu->memory = system_memory;
     object_ref(OBJECT(cpu->memory));
 #endif
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index d3c783b..04c31e6 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -1013,6 +1013,7 @@ AddressSpace *cpu_get_address_space(CPUState *cpu, int asidx);
 
 void QEMU_NORETURN cpu_abort(CPUState *cpu, const char *fmt, ...)
     GCC_FMT_ATTR(2, 3);
+extern Property cpu_common_props[];
 void cpu_exec_initfn(CPUState *cpu);
 void cpu_exec_realizefn(CPUState *cpu, Error **errp);
 void cpu_exec_unrealizefn(CPUState *cpu);
diff --git a/qom/cpu.c b/qom/cpu.c
index 8757f03..a39ff6c 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -458,6 +458,7 @@ static void cpu_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_CPU, dc->categories);
     dc->realize = cpu_common_realizefn;
     dc->unrealize = cpu_common_unrealizefn;
+    dc->props = cpu_common_props;
     /*
      * Reason: CPUs still need special care by board code: wiring up
      * IRQs, adding reset handlers, halting non-first CPUs, ...
-- 
1.8.3.1
