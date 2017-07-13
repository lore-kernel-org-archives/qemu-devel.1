Received: from eggs.gnu.org ([2001:4830:134:3::10]:51240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf3R-00010d-AG
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf3Q-0002UV-5e
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:21 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34903)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVf3P-0002U3-SQ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:20 -0400
Received: by mail-wm0-x242.google.com with SMTP id u23so5457775wma.2
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:25:19 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Jul 2017 16:24:18 +0200
Message-Id: <1499955874-10954-26-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
References: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 25/41] gdbstub: rename cpu_index -> cpu_gdb_index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Alex Bennée <alex.bennee@linaro.org>

This is to make it clear the index is purely a gdbstub function and
should not be confused with the value of cpu->cpu_index. At the same
time we move the function from the header to gdbstub itself which will
help with later changes.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Message-Id: <20170712105216.747-3-alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 gdbstub.c              | 26 ++++++++++++++++++++------
 include/exec/gdbstub.h |  9 ---------
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 3965980..b1efe0b 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -56,6 +56,20 @@ static inline int target_memory_rw_debug(CPUState *cpu, target_ulong addr,
     return cpu_memory_rw_debug(cpu, addr, buf, len, is_write);
 }
 
+/* Return the GDB index for a given vCPU state.
+ *
+ * For user mode this is simply the thread id. In system mode GDB
+ * numbers CPUs from 1 as 0 is reserved as an "any cpu" index.
+ */
+static inline int cpu_gdb_index(CPUState *cpu)
+{
+#if defined(CONFIG_USER_ONLY)
+    return cpu->host_tid;
+#else
+    return cpu->cpu_index + 1;
+#endif
+}
+
 enum {
     GDB_SIGNAL_0 = 0,
     GDB_SIGNAL_INT = 2,
@@ -838,7 +852,7 @@ static CPUState *find_cpu(uint32_t thread_id)
     CPUState *cpu;
 
     CPU_FOREACH(cpu) {
-        if (cpu_index(cpu) == thread_id) {
+        if (cpu_gdb_index(cpu) == thread_id) {
             return cpu;
         }
     }
@@ -926,7 +940,7 @@ static int gdb_handle_vcont(GDBState *s, const char *p)
             idx = tmp;
             /* 0 means any thread, so we pick the first valid CPU */
             if (!idx) {
-                idx = cpu_index(first_cpu);
+                idx = cpu_gdb_index(first_cpu);
             }
 
             /*
@@ -976,7 +990,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     case '?':
         /* TODO: Make this return the correct value for user-mode.  */
         snprintf(buf, sizeof(buf), "T%02xthread:%02x;", GDB_SIGNAL_TRAP,
-                 cpu_index(s->c_cpu));
+                 cpu_gdb_index(s->c_cpu));
         put_packet(s, buf);
         /* Remove all the breakpoints when this query is issued,
          * because gdb is doing and initial connect and the state
@@ -1244,7 +1258,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         } else if (strcmp(p,"sThreadInfo") == 0) {
         report_cpuinfo:
             if (s->query_cpu) {
-                snprintf(buf, sizeof(buf), "m%x", cpu_index(s->query_cpu));
+                snprintf(buf, sizeof(buf), "m%x", cpu_gdb_index(s->query_cpu));
                 put_packet(s, buf);
                 s->query_cpu = CPU_NEXT(s->query_cpu);
             } else
@@ -1401,7 +1415,7 @@ static void gdb_vm_state_change(void *opaque, int running, RunState state)
             }
             snprintf(buf, sizeof(buf),
                      "T%02xthread:%02x;%swatch:" TARGET_FMT_lx ";",
-                     GDB_SIGNAL_TRAP, cpu_index(cpu), type,
+                     GDB_SIGNAL_TRAP, cpu_gdb_index(cpu), type,
                      (target_ulong)cpu->watchpoint_hit->vaddr);
             cpu->watchpoint_hit = NULL;
             goto send_packet;
@@ -1435,7 +1449,7 @@ static void gdb_vm_state_change(void *opaque, int running, RunState state)
         break;
     }
     gdb_set_stop_cpu(cpu);
-    snprintf(buf, sizeof(buf), "T%02xthread:%02x;", ret, cpu_index(cpu));
+    snprintf(buf, sizeof(buf), "T%02xthread:%02x;", ret, cpu_gdb_index(cpu));
 
 send_packet:
     put_packet(s, buf);
diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index f9708bb..9aa7756 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -58,15 +58,6 @@ void gdb_register_coprocessor(CPUState *cpu,
                               gdb_reg_cb get_reg, gdb_reg_cb set_reg,
                               int num_regs, const char *xml, int g_pos);
 
-static inline int cpu_index(CPUState *cpu)
-{
-#if defined(CONFIG_USER_ONLY)
-    return cpu->host_tid;
-#else
-    return cpu->cpu_index + 1;
-#endif
-}
-
 /* The GDB remote protocol transfers values in target byte order.  This means
  * we can use the raw memory access routines to access the value buffer.
  * Conveniently, these also handle the case where the buffer is mis-aligned.
-- 
1.8.3.1
