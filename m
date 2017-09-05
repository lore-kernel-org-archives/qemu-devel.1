Received: from eggs.gnu.org ([2001:4830:134:3::10]:59240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dpGAY-0000MV-Re
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:53:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dpGAT-0004HU-U9
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:53:42 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Sep 2017 16:53:32 +0100
Message-Id: <1504626814-23124-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504626814-23124-1-git-send-email-peter.maydell@linaro.org>
References: <1504626814-23124-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v2 1/3] boards.h: Define new flag
 ignore_memory_transaction_failures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>

Define a new MachineClass field ignore_memory_transaction_failures.
If this is flag is true then the CPU will ignore memory transaction
failures which should cause the CPU to take an exception due to an
access to an unassigned physical address; the transaction will
instead return zero (for a read) or be ignored (for a write).  This
should be set only by legacy board models which rely on the old
RAZ/WI behaviour for handling devices that QEMU does not yet model.
New board models should instead use "unimplemented-device" for all
memory ranges where the guest will attempt to probe for a device that
QEMU doesn't implement and a stub device is required.

We need this for ARM boards, where we're about to implement support for
generating external aborts on memory transaction failures. Too many
of our legacy board models rely on the RAZ/WI behaviour and we
would break currently working guests when their "probe for device"
code provoked an external abort rather than a RAZ.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/boards.h | 11 +++++++++++
 include/qom/cpu.h   |  7 ++++++-
 qom/cpu.c           | 16 ++++++++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 3363dd1..7f044d1 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -131,6 +131,16 @@ typedef struct {
  *    size than the target architecture's minimum. (Attempting to create
  *    such a CPU will fail.) Note that changing this is a migration
  *    compatibility break for the machine.
+ * @ignore_memory_transaction_failures:
+ *    If this is flag is true then the CPU will ignore memory transaction
+ *    failures which should cause the CPU to take an exception due to an
+ *    access to an unassigned physical address; the transaction will instead
+ *    return zero (for a read) or be ignored (for a write). This should be
+ *    set only by legacy board models which rely on the old RAZ/WI behaviour
+ *    for handling devices that QEMU does not yet model. New board models
+ *    should instead use "unimplemented-device" for all memory ranges where
+ *    the guest will attempt to probe for a device that QEMU doesn't
+ *    implement and a stub device is required.
  */
 struct MachineClass {
     /*< private >*/
@@ -171,6 +181,7 @@ struct MachineClass {
     bool rom_file_has_mr;
     int minimum_page_bits;
     bool has_hotpluggable_cpus;
+    bool ignore_memory_transaction_failures;
     int numa_mem_align_shift;
     void (*numa_auto_assign_ram)(MachineClass *mc, NodeInfo *nodes,
                                  int nb_nodes, ram_addr_t size);
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 08bd868..995a7be 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -312,6 +312,9 @@ struct qemu_work_item;
  * @trace_dstate_delayed: Delayed changes to trace_dstate (includes all changes
  *                        to @trace_dstate).
  * @trace_dstate: Dynamic tracing state of events for this vCPU (bitmask).
+ * @ignore_memory_transaction_failures: Cached copy of the MachineState
+ *    flag of the same name: allows the board to suppress calling of the
+ *    CPU do_transaction_failed hook function.
  *
  * State of one CPU core or thread.
  */
@@ -398,6 +401,8 @@ struct CPUState {
      */
     bool throttle_thread_scheduled;
 
+    bool ignore_memory_transaction_failures;
+
     /* Note that this is accessed at the start of every TB via a negative
        offset from AREG0.  Leave this field at the end so as to make the
        (absolute value) offset as small as possible.  This reduces code
@@ -864,7 +869,7 @@ static inline void cpu_transaction_failed(CPUState *cpu, hwaddr physaddr,
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
 
-    if (cc->do_transaction_failed) {
+    if (!cpu->ignore_memory_transaction_failures && cc->do_transaction_failed) {
         cc->do_transaction_failed(cpu, physaddr, addr, size, access_type,
                                   mmu_idx, attrs, response, retaddr);
     }
diff --git a/qom/cpu.c b/qom/cpu.c
index deb8880..dc5392d 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -29,6 +29,7 @@
 #include "exec/cpu-common.h"
 #include "qemu/error-report.h"
 #include "sysemu/sysemu.h"
+#include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "trace-root.h"
 
@@ -363,6 +364,21 @@ static void cpu_common_parse_features(const char *typename, char *features,
 static void cpu_common_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cpu = CPU(dev);
+    Object *machine = qdev_get_machine();
+
+    /* qdev_get_machine() can return something that's not TYPE_MACHINE
+     * if this is one of the user-only emulators; in that case there's
+     * no need to check the ignore_memory_transaction_failures board flag.
+     */
+    if (object_dynamic_cast(machine, TYPE_MACHINE)) {
+        ObjectClass *oc = object_get_class(machine);
+        MachineClass *mc = MACHINE_CLASS(oc);
+
+        if (mc) {
+            cpu->ignore_memory_transaction_failures =
+                mc->ignore_memory_transaction_failures;
+        }
+    }
 
     if (dev->hotplugged) {
         cpu_synchronize_post_init(cpu);
-- 
2.7.4
