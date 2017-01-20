Received: from eggs.gnu.org ([2001:4830:134:3::10]:42819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1cUc7E-0002M6-Vk
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:32:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1cUc7C-00056A-Re
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:32:41 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:41801)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Julian_Brown@mentor.com>)
	id 1cUc7C-00055m-Lv
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:32:38 -0500
Received: from nat-ies.mentorg.com ([192.94.31.2]
	helo=SVR-IES-MBX-04.mgc.mentorg.com)
	by relay1.mentorg.com with esmtp
	id 1cUc7B-0005bf-Ds from Julian_Brown@mentor.com
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:32:37 -0800
From: Julian Brown <julian@codesourcery.com>
Date: Fri, 20 Jan 2017 08:32:09 -0800
Message-ID: <caaf64ffc72f6ae183015337b7afdbd4b8989cb6.1484929304.git.julian@codesourcery.com>
In-Reply-To: <cover.1484929304.git.julian@codesourcery.com>
References: <cover.1484929304.git.julian@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 7/7] ARM BE32 watchpoint fix.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In BE32 mode, sub-word size watchpoints can fail to trigger because the
address of the access is adjusted in the opcode helpers before being
compared with the watchpoint registers.  This patch reverses the address
adjustment before performing the comparison with the help of a new CPUClass
hook.

This version of the patch augments and tidies up comments a little.

Signed-off-by: Julian Brown <julian@codesourcery.com>
---
 exec.c                 |  1 +
 include/qom/cpu.h      |  3 +++
 qom/cpu.c              |  6 ++++++
 target/arm/cpu.c       |  3 +++
 target/arm/internals.h |  5 +++++
 target/arm/op_helper.c | 22 ++++++++++++++++++++++
 6 files changed, 40 insertions(+)

diff --git a/exec.c b/exec.c
index 401a912..b6be381 100644
--- a/exec.c
+++ b/exec.c
@@ -2110,6 +2110,7 @@ static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
         return;
     }
     vaddr = (cpu->mem_io_vaddr & TARGET_PAGE_MASK) + offset;
+    vaddr = cc->adjust_watchpoint_address(cpu, vaddr, len);
     QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
         if (cpu_watchpoint_address_matches(wp, vaddr, len)
             && (wp->flags & flags)) {
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 3f79a8e..1d2df57 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -132,6 +132,8 @@ struct TranslationBlock;
  * @cpu_exec_exit: Callback for cpu_exec cleanup.
  * @cpu_exec_interrupt: Callback for processing interrupts in cpu_exec.
  * @disas_set_info: Setup architecture specific components of disassembly info
+ * @adjust_watchpoint_address: Perform a target-specific adjustment to an
+ * address before attempting to match it against watchpoints.
  *
  * Represents a CPU family or model.
  */
@@ -195,6 +197,7 @@ typedef struct CPUClass {
     bool (*cpu_exec_interrupt)(CPUState *cpu, int interrupt_request);
 
     void (*disas_set_info)(CPUState *cpu, disassemble_info *info);
+    vaddr (*adjust_watchpoint_address)(CPUState *cpu, vaddr addr, int len);
 } CPUClass;
 
 #ifdef HOST_WORDS_BIGENDIAN
diff --git a/qom/cpu.c b/qom/cpu.c
index cee4e6f..b35deb5 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -391,6 +391,11 @@ static int64_t cpu_common_get_arch_id(CPUState *cpu)
     return cpu->cpu_index;
 }
 
+static vaddr cpu_adjust_watchpoint_address(CPUState *cpu, vaddr addr, int len)
+{
+    return addr;
+}
+
 static void cpu_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -415,6 +420,7 @@ static void cpu_class_init(ObjectClass *klass, void *data)
     k->cpu_exec_enter = cpu_common_noop;
     k->cpu_exec_exit = cpu_common_noop;
     k->cpu_exec_interrupt = cpu_common_exec_interrupt;
+    k->adjust_watchpoint_address = cpu_adjust_watchpoint_address;
     dc->realize = cpu_common_realizefn;
     dc->unrealize = cpu_common_unrealizefn;
     /*
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 4d91d07..7a56487 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1656,6 +1656,9 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_stop_before_watchpoint = true;
     cc->debug_excp_handler = arm_debug_excp_handler;
     cc->debug_check_watchpoint = arm_debug_check_watchpoint;
+#if !defined(CONFIG_USER_ONLY)
+    cc->adjust_watchpoint_address = arm_adjust_watchpoint_address;
+#endif
 
     cc->disas_set_info = arm_disas_set_info;
 }
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 3cae5ff..0485583 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -437,6 +437,11 @@ void hw_breakpoint_update_all(ARMCPU *cpu);
 /* Callback function for checking if a watchpoint should trigger. */
 bool arm_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp);
 
+/* Adjust addresses (in BE32 mode) before testing against watchpoint
+ * addresses.
+ */
+vaddr arm_adjust_watchpoint_address(CPUState *cs, vaddr addr, int len);
+
 /* Callback function for when a watchpoint or breakpoint triggers. */
 void arm_debug_excp_handler(CPUState *cs);
 
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index ba796d8..fb366fd 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -1225,6 +1225,28 @@ bool arm_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
     return check_watchpoints(cpu);
 }
 
+vaddr arm_adjust_watchpoint_address(CPUState *cs, vaddr addr, int len)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    /* In BE32 system mode, target memory is stored byteswapped (on a
+     * little-endian host system), and by the time we reach here (via an
+     * opcode helper) the addresses of subword accesses have been adjusted
+     * to account for that, which means that watchpoints will not match.
+     * Undo the adjustment here.
+     */
+    if (arm_sctlr_b(env)) {
+        if (len == 1) {
+            addr ^= 3;
+        } else if (len == 2) {
+            addr ^= 2;
+        }
+    }
+
+    return addr;
+}
+
 void arm_debug_excp_handler(CPUState *cs)
 {
     /* Called by core code when a watchpoint or breakpoint fires;
-- 
2.8.1
