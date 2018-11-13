Received: from eggs.gnu.org ([2001:4830:134:3::10]:35778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gMcAc-000762-BX
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 12:08:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gMbwm-000402-Dv
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 11:53:53 -0500
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Tue, 13 Nov 2018 17:52:45 +0100
Message-Id: <20181113165247.4806-12-sameo@linux.intel.com>
In-Reply-To: <20181113165247.4806-1-sameo@linux.intel.com>
References: <20181113165247.4806-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 11/13] target: arm: Define TCG dependent
 functions when TCG is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, richard.henderson@linaro.org, qemu-arm@nongnu.org

do_interrupt, do_unaligned_access, do_transaction_failed and debug_excp
are only relevant in the TCG context, so we should not define them
when TCG is disabled.

Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Robert Bradford <robert.bradford@intel.com>
---
 target/arm/cpu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 60411f6bfe..fb2e5d430e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1444,7 +1444,7 @@ static void arm_v7m_class_init(ObjectClass *oc, void *data)
 {
     CPUClass *cc = CPU_CLASS(oc);
 
-#ifndef CONFIG_USER_ONLY
+#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
     cc->do_interrupt = arm_v7m_cpu_do_interrupt;
 #endif
 
@@ -2061,9 +2061,14 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
 #ifdef CONFIG_USER_ONLY
     cc->handle_mmu_fault = arm_cpu_handle_mmu_fault;
 #else
+
+#ifdef CONFIG_TCG
     cc->do_interrupt = arm_cpu_do_interrupt;
     cc->do_unaligned_access = arm_cpu_do_unaligned_access;
     cc->do_transaction_failed = arm_cpu_do_transaction_failed;
+    cc->debug_excp_handler = arm_debug_excp_handler;
+#endif
+
     cc->get_phys_page_attrs_debug = arm_cpu_get_phys_page_attrs_debug;
     cc->asidx_from_attrs = arm_asidx_from_attrs;
     cc->vmsd = &vmstate_arm_cpu;
@@ -2076,7 +2081,6 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_arch_name = arm_gdb_arch_name;
     cc->gdb_get_dynamic_xml = arm_gdb_get_dynamic_xml;
     cc->gdb_stop_before_watchpoint = true;
-    cc->debug_excp_handler = arm_debug_excp_handler;
     cc->debug_check_watchpoint = arm_debug_check_watchpoint;
 #if !defined(CONFIG_USER_ONLY)
     cc->adjust_watchpoint_address = arm_adjust_watchpoint_address;
-- 
2.19.1
