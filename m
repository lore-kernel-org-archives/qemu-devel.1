Received: from eggs.gnu.org ([2001:4830:134:3::10]:32818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cbAe5-0007bb-EM
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:37:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cbAe3-0002li-Vq
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:37:41 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cbAe3-0002gg-OP
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:37:39 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cbAdu-0005UN-2X
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 18:37:30 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  7 Feb 2017 18:37:20 +0000
Message-Id: <1486492645-27803-9-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1486492645-27803-1-git-send-email-peter.maydell@linaro.org>
References: <1486492645-27803-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 08/13] arm: Correctly handle watchpoints for
 BE32 CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Julian Brown <julian@codesourcery.com>

In BE32 mode, sub-word size watchpoints can fail to trigger because the
address of the access is adjusted in the opcode helpers before being
compared with the watchpoint registers.  This patch reverses the address
adjustment before performing the comparison with the help of a new CPUClass
hook.

This version of the patch augments and tidies up comments a little.

Signed-off-by: Julian Brown <julian@codesourcery.com>
Message-id: caaf64ffc72f6ae183015337b7afdbd4b8989cb6.1484929304.git.julian@codesourcery.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/qom/cpu.h      |  3 +++
 target/arm/internals.h |  5 +++++
 exec.c                 |  1 +
 qom/cpu.c              |  6 ++++++
 target/arm/cpu.c       |  3 +++
 target/arm/op_helper.c | 22 ++++++++++++++++++++++
 6 files changed, 40 insertions(+)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index ca4d0fb..45bcf21 100644
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
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 2e65bc1..f742a41 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -444,6 +444,11 @@ void hw_breakpoint_update_all(ARMCPU *cpu);
 /* Callback function for checking if a watchpoint should trigger. */
 bool arm_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp);
 
+/* Adjust addresses (in BE32 mode) before testing against watchpoint
+ * addresses.
+ */
+vaddr arm_adjust_watchpoint_address(CPUState *cs, vaddr addr, int len);
+
 /* Callback function for when a watchpoint or breakpoint triggers. */
 void arm_debug_excp_handler(CPUState *cs);
 
diff --git a/exec.c b/exec.c
index 8b9ed73..6fa337b 100644
--- a/exec.c
+++ b/exec.c
@@ -2115,6 +2115,7 @@ static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
         return;
     }
     vaddr = (cpu->mem_io_vaddr & TARGET_PAGE_MASK) + offset;
+    vaddr = cc->adjust_watchpoint_address(cpu, vaddr, len);
     QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
         if (cpu_watchpoint_address_matches(wp, vaddr, len)
             && (wp->flags & flags)) {
diff --git a/qom/cpu.c b/qom/cpu.c
index d57faf3..0e19b1a 100644
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
     set_bit(DEVICE_CATEGORY_CPU, dc->categories);
     dc->realize = cpu_common_realizefn;
     dc->unrealize = cpu_common_unrealizefn;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 81448ca..4ee250c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1675,6 +1675,9 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_stop_before_watchpoint = true;
     cc->debug_excp_handler = arm_debug_excp_handler;
     cc->debug_check_watchpoint = arm_debug_check_watchpoint;
+#if !defined(CONFIG_USER_ONLY)
+    cc->adjust_watchpoint_address = arm_adjust_watchpoint_address;
+#endif
 
     cc->disas_set_info = arm_disas_set_info;
 }
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
2.7.4
