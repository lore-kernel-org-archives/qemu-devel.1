Received: from eggs.gnu.org ([2001:4830:134:3::10]:43995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dGRPP-0004ZP-GE
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:49:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dGRPJ-0002Uz-GC
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:49:07 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:38393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dGRPJ-0002UK-96
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:49:01 -0400
Received: by mail-wm0-x229.google.com with SMTP id n195so35525007wmg.1
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 07:49:01 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  1 Jun 2017 15:49:13 +0100
Message-Id: <20170601144915.20778-3-alex.bennee@linaro.org>
In-Reply-To: <20170601144915.20778-1-alex.bennee@linaro.org>
References: <20170601144915.20778-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 2/4] gdbstub: rename cpu_index ->
 cpu_gdb_index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, doug16k@gmail.com, imbrenda@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This is to make it clear the index is purely a gdbstub function and
should not be confused with the value of cpu->cpu_index.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub.c              | 12 ++++++------
 include/exec/gdbstub.h |  7 ++++++-
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index a249846954..026d1fe6bb 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -837,7 +837,7 @@ static CPUState *find_cpu(uint32_t thread_id)
     CPUState *cpu;
 
     CPU_FOREACH(cpu) {
-        if (cpu_index(cpu) == thread_id) {
+        if (cpu_gdb_index(cpu) == thread_id) {
             return cpu;
         }
     }
@@ -925,7 +925,7 @@ static int gdb_handle_vcont(GDBState *s, const char *p)
             idx = tmp;
             /* 0 means any thread, so we pick the first valid CPU */
             if (!idx) {
-                idx = cpu_index(first_cpu);
+                idx = cpu_gdb_index(first_cpu);
             }
 
             /*
@@ -975,7 +975,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
     case '?':
         /* TODO: Make this return the correct value for user-mode.  */
         snprintf(buf, sizeof(buf), "T%02xthread:%02x;", GDB_SIGNAL_TRAP,
-                 cpu_index(s->c_cpu));
+                 cpu_gdb_index(s->c_cpu));
         put_packet(s, buf);
         /* Remove all the breakpoints when this query is issued,
          * because gdb is doing and initial connect and the state
@@ -1243,7 +1243,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         } else if (strcmp(p,"sThreadInfo") == 0) {
         report_cpuinfo:
             if (s->query_cpu) {
-                snprintf(buf, sizeof(buf), "m%x", cpu_index(s->query_cpu));
+                snprintf(buf, sizeof(buf), "m%x", cpu_gdb_index(s->query_cpu));
                 put_packet(s, buf);
                 s->query_cpu = CPU_NEXT(s->query_cpu);
             } else
@@ -1400,7 +1400,7 @@ static void gdb_vm_state_change(void *opaque, int running, RunState state)
             }
             snprintf(buf, sizeof(buf),
                      "T%02xthread:%02x;%swatch:" TARGET_FMT_lx ";",
-                     GDB_SIGNAL_TRAP, cpu_index(cpu), type,
+                     GDB_SIGNAL_TRAP, cpu_gdb_index(cpu), type,
                      (target_ulong)cpu->watchpoint_hit->vaddr);
             cpu->watchpoint_hit = NULL;
             goto send_packet;
@@ -1434,7 +1434,7 @@ static void gdb_vm_state_change(void *opaque, int running, RunState state)
         break;
     }
     gdb_set_stop_cpu(cpu);
-    snprintf(buf, sizeof(buf), "T%02xthread:%02x;", ret, cpu_index(cpu));
+    snprintf(buf, sizeof(buf), "T%02xthread:%02x;", ret, cpu_gdb_index(cpu));
 
 send_packet:
     put_packet(s, buf);
diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index f9708bbcd6..c4fe567600 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -58,7 +58,12 @@ void gdb_register_coprocessor(CPUState *cpu,
                               gdb_reg_cb get_reg, gdb_reg_cb set_reg,
                               int num_regs, const char *xml, int g_pos);
 
-static inline int cpu_index(CPUState *cpu)
+/* Return the GDB index for a given vCPU state.
+ *
+ * For user mode this is simply the thread id. In system mode GDB
+ * numbers CPUs from 1 as 0 is reserved as an "any cpu" index.
+ */
+static inline int cpu_gdb_index(CPUState *cpu)
 {
 #if defined(CONFIG_USER_ONLY)
     return cpu->host_tid;
-- 
2.13.0
