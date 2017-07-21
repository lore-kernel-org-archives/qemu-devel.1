Received: from eggs.gnu.org ([2001:4830:134:3::10]:33922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yi59@zte.com.cn>) id 1dYSFl-0005F9-7e
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 03:21:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wang.yi59@zte.com.cn>) id 1dYSFg-0001cB-Cw
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 03:21:37 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:55582)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yi59@zte.com.cn>) id 1dYSFf-0001b8-My
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 03:21:32 -0400
From: Yi Wang <wang.yi59@zte.com.cn>
Date: Fri, 21 Jul 2017 03:38:55 -0400
Message-Id: <1500622736-20865-2-git-send-email-wang.yi59@zte.com.cn>
In-Reply-To: <1500622736-20865-1-git-send-email-wang.yi59@zte.com.cn>
References: <1500622736-20865-1-git-send-email-wang.yi59@zte.com.cn>
Subject: [Qemu-devel] [PATCH 1/2] [PATCH] hmp: dump ids including socket-id,
 core-id and so on for 'info registers'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, armbru@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, qemu-devel@nongnu.org
Cc: wang.yi59@zte.com.cn, Liu.Jianjun3@zte.com.cn, liu.yunh@zte.com.cn

This patch add output of CPUs' socket-id, core-id, thread-id and
apic-id for 'info registers', which can be used for querying other
hmp commands.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Signed-off-by: Yun Liu <liu.yunh@zte.com.cn>
---
 include/qom/cpu.h    | 12 ++++++++++++
 monitor.c            |  1 +
 qom/cpu.c            | 10 ++++++++++
 target/i386/cpu.c    |  1 +
 target/i386/cpu.h    |  1 +
 target/i386/helper.c | 13 +++++++++++++
 6 files changed, 38 insertions(+)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 25eefea..4717bd7 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -92,6 +92,7 @@ struct TranslationBlock;
  * CPUs can use the default implementation of this method. This method should
  * not be used by any callers other than the pre-1.0 virtio devices.
  * @memory_rw_debug: Callback for GDB memory access.
+ * @dump_ids: Callback for dumping ids.
  * @dump_state: Callback for dumping state.
  * @dump_statistics: Callback for dumping statistics.
  * @get_arch_id: Callback for getting architecture-dependent CPU ID.
@@ -156,6 +157,7 @@ typedef struct CPUClass {
     bool (*virtio_is_big_endian)(CPUState *cpu);
     int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
                            uint8_t *buf, int len, bool is_write);
+    void (*dump_ids)(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf);
     void (*dump_state)(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf,
                        int flags);
     GuestPanicInformation* (*get_crash_info)(CPUState *cpu);
@@ -518,6 +520,16 @@ enum CPUDumpFlags {
 };
 
 /**
+ * cpu_dump_ids:
+ * @cpu: The CPU whose state is to be dumped.
+ * @f: File to dump to.
+ * @cpu_fprintf: Function to dump with.
+ *
+ * Dumps CPU socket-id, core-id, thread-id and apic-id.
+ */
+void cpu_dump_ids(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf);
+
+/**
  * cpu_dump_state:
  * @cpu: The CPU whose state is to be dumped.
  * @f: File to dump to.
diff --git a/monitor.c b/monitor.c
index 6d040e6..30f898c 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1085,6 +1085,7 @@ static void hmp_info_registers(Monitor *mon, const QDict *qdict)
     if (all_cpus) {
         CPU_FOREACH(cs) {
             monitor_printf(mon, "\nCPU#%d\n", cs->cpu_index);
+            cpu_dump_ids(cs, (FILE *)mon, monitor_fprintf);
             cpu_dump_state(cs, (FILE *)mon, monitor_fprintf, CPU_DUMP_FPU);
         }
     } else {
diff --git a/qom/cpu.c b/qom/cpu.c
index 4f38db0..a9df661 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -242,6 +242,16 @@ GuestPanicInformation *cpu_get_crash_info(CPUState *cpu)
     return res;
 }
 
+void cpu_dump_ids(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf)
+{
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+
+    if (cc->dump_ids) {
+        cpu_synchronize_state(cpu);
+        cc->dump_ids(cpu, f, cpu_fprintf);
+    }
+}
+
 void cpu_dump_state(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf,
                     int flags)
 {
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0bbda76..0aa488f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4120,6 +4120,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
     cc->do_interrupt = x86_cpu_do_interrupt;
     cc->cpu_exec_interrupt = x86_cpu_exec_interrupt;
 #endif
+    cc->dump_ids = x86_cpu_dump_ids;
     cc->dump_state = x86_cpu_dump_state;
     cc->get_crash_info = x86_cpu_get_crash_info;
     cc->set_pc = x86_cpu_set_pc;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 0518673..31ad681 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1316,6 +1316,7 @@ int x86_cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
 void x86_cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
                                 Error **errp);
 
+void x86_cpu_dump_ids(CPUState *cs, FILE *f, fprintf_function cpu_fprintf);
 void x86_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
                         int flags);
 
diff --git a/target/i386/helper.c b/target/i386/helper.c
index f63eb3d..fd4f1af 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -408,6 +408,19 @@ void x86_cpu_dump_local_apic_state(CPUState *cs, FILE *f,
 #define DUMP_CODE_BYTES_TOTAL    50
 #define DUMP_CODE_BYTES_BACKWARD 20
 
+void x86_cpu_dump_ids(CPUState *cs, FILE *f, fprintf_function cpu_fprintf)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    APICCommonState *s = APIC_COMMON(cpu->apic_state);
+    if (!s) {
+        cpu_fprintf(f, "local apic state not available\n");
+        return;
+    }
+
+    cpu_fprintf(f, "(socket-id:%d core-id:%d thread-id:%d apic-id:%d)\n",
+            cpu->socket_id, cpu->core_id, cpu->thread_id, s->id);
+}
+
 void x86_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
                         int flags)
 {
-- 
1.8.3.1
