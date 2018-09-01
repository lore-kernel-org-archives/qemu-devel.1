Received: from eggs.gnu.org ([2001:4830:134:3::10]:35641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fw5JZ-00068M-5u
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 08:47:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fw5JY-0007y9-6i
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 08:47:45 -0400
From: Luc Michel <luc.michel@greensocs.com>
Date: Sat,  1 Sep 2018 14:46:33 +0200
Message-Id: <20180901124639.19735-10-luc.michel@greensocs.com>
In-Reply-To: <20180901124639.19735-1-luc.michel@greensocs.com>
References: <20180901124639.19735-1-luc.michel@greensocs.com>
Subject: [Qemu-devel] [PATCH 09/15] gdbstub: add multiprocess support to 'D'
 packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@greensocs.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, alistair@alistair23.me, mark.burton@greensocs.com

'D' packets are used by GDB to detach from a process. In multiprocess
mode, the PID to detach from is sent in the request.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
---
 gdbstub.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 48 insertions(+), 7 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 4ccd1153ce..af8864e251 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1025,24 +1025,39 @@ static int gdb_breakpoint_remove(target_ulong addr, target_ulong len, int type)
     default:
         return -ENOSYS;
     }
 }
 
+static inline void gdb_cpu_breakpoint_remove_all(CPUState *cpu)
+{
+    cpu_breakpoint_remove_all(cpu, BP_GDB);
+#ifndef CONFIG_USER_ONLY
+    cpu_watchpoint_remove_all(cpu, BP_GDB);
+#endif
+}
+
+static void gdb_process_breakpoint_remove_all(const GDBState *s, GDBProcess *p)
+{
+    CPUState *cpu = get_first_cpu_in_process(s, p);
+
+    while (cpu) {
+        gdb_cpu_breakpoint_remove_all(cpu);
+        cpu = gdb_next_cpu_in_process(s, cpu);
+    }
+}
+
 static void gdb_breakpoint_remove_all(void)
 {
     CPUState *cpu;
 
     if (kvm_enabled()) {
         kvm_remove_all_breakpoints(gdbserver_state->c_cpu);
         return;
     }
 
     CPU_FOREACH(cpu) {
-        cpu_breakpoint_remove_all(cpu, BP_GDB);
-#ifndef CONFIG_USER_ONLY
-        cpu_watchpoint_remove_all(cpu, BP_GDB);
-#endif
+        gdb_cpu_breakpoint_remove_all(cpu);
     }
 }
 
 static void gdb_set_cpu_pc(GDBState *s, target_ulong pc)
 {
@@ -1318,13 +1333,39 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         /* Kill the target */
         error_report("QEMU: Terminated via GDBstub");
         exit(0);
     case 'D':
         /* Detach packet */
-        gdb_breakpoint_remove_all();
-        gdb_syscall_mode = GDB_SYS_DISABLED;
-        gdb_continue(s);
+        pid = 1;
+
+        if (s->multiprocess) {
+            unsigned long lpid;
+            if (*p != ';') {
+                put_packet(s, "E22");
+                break;
+            }
+            qemu_strtoul(p + 1, &p, 16, &lpid);
+            pid = lpid;
+        }
+
+        process = gdb_get_process(s, pid);
+        gdb_process_breakpoint_remove_all(s, process);
+        process->attached = false;
+
+        if (pid == gdb_get_cpu_pid(s, s->c_cpu)) {
+            s->c_cpu = gdb_first_cpu(s);
+        }
+
+        if (pid == gdb_get_cpu_pid(s, s->g_cpu)) {
+            s->g_cpu = gdb_first_cpu(s);
+        }
+
+        if (s->c_cpu == NULL) {
+            /* No more process attached */
+            gdb_syscall_mode = GDB_SYS_DISABLED;
+            gdb_continue(s);
+        }
         put_packet(s, "OK");
         break;
     case 's':
         if (*p != '\0') {
             addr = strtoull(p, (char **)&p, 16);
-- 
2.18.0
