Received: from eggs.gnu.org ([209.51.188.92]:46373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXoa-00050f-P5
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXoY-00025Y-FR
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:48 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:37102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggXoY-0001rP-5r
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:46 -0500
Received: by mail-wr1-x430.google.com with SMTP id s12so1079270wrt.4
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 08:31:37 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	j14sm46039759wrv.96.2019.01.07.08.31.34 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 07 Jan 2019 08:31:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  7 Jan 2019 16:30:52 +0000
Message-Id: <20190107163117.16269-13-peter.maydell@linaro.org>
In-Reply-To: <20190107163117.16269-1-peter.maydell@linaro.org>
References: <20190107163117.16269-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/37] gdbstub: add multiprocess support to 'D'
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

From: Luc Michel <luc.michel@greensocs.com>

'D' packets are used by GDB to detach from a process. In multiprocess
mode, the PID to detach from is sent in the request.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20181207090135.7651-11-luc.michel@greensocs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 gdbstub.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 7 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index edee38b6136..2c7032f53ab 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1047,6 +1047,24 @@ static int gdb_breakpoint_remove(target_ulong addr, target_ulong len, int type)
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
@@ -1057,10 +1075,7 @@ static void gdb_breakpoint_remove_all(void)
     }
 
     CPU_FOREACH(cpu) {
-        cpu_breakpoint_remove_all(cpu, BP_GDB);
-#ifndef CONFIG_USER_ONLY
-        cpu_watchpoint_remove_all(cpu, BP_GDB);
-#endif
+        gdb_cpu_breakpoint_remove_all(cpu);
     }
 }
 
@@ -1339,9 +1354,40 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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
+
+            if (qemu_strtoul(p + 1, &p, 16, &lpid)) {
+                put_packet(s, "E22");
+                break;
+            }
+
+            pid = lpid;
+        }
+
+        process = gdb_get_process(s, pid);
+        gdb_process_breakpoint_remove_all(s, process);
+        process->attached = false;
+
+        if (pid == gdb_get_cpu_pid(s, s->c_cpu)) {
+            s->c_cpu = gdb_first_attached_cpu(s);
+        }
+
+        if (pid == gdb_get_cpu_pid(s, s->g_cpu)) {
+            s->g_cpu = gdb_first_attached_cpu(s);
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
-- 
2.19.2
